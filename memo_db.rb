# frozen_string_literal: true

require 'pg'

require 'sinatra'
require 'sinatra/reloader'
require 'securerandom'

# XSS
helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

def connection
  PG.connect(dbname: 'sinatra_app')
end

def specific_file
  files = connection.exec('SELECT * FROM memos WHERE id = $1', [params[:id]])
  files.each do |file|
    @file = file
  end
end

get '/memos' do
  @data = connection.exec('SELECT * FROM memos;')
  erb :top
end

get '/memos/new' do
  erb :new_memo
end

post '/memos' do
  hashs = { 'id' => SecureRandom.uuid, 'title' => params[:title], 'message' => params[:message] }
  @data = connection.exec('INSERT INTO memos(id, title, message) VALUES ($1, $2, $3)',
                          [hashs['id'], hashs['title'], hashs['message']])
  redirect to('/memos')
end

get '/memos/:id' do
  specific_file
  erb :show
end

get '/memos/:id/edit' do
  specific_file
  erb :edit
end

get '/memos/:id/delete' do
  specific_file
  erb :delete
end

patch '/memos/:id' do
  @id = params[:id]
  @title = params[:title]
  @message = params[:message]
  @data = connection.exec('UPDATE memos SET title= $1, message= $2 WHERE id= $3', [@title, @message, @id])
  redirect to('/memos')
end

delete '/memos/:id' do
  @data = connection.exec('DELETE FROM memos WHERE id = $1', [params[:id].to_s])
  redirect to('/memos')
end
