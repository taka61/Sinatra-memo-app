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

def read_memo
  memos = connection.exec('SELECT * FROM memos WHERE id = $1', [params['id']])
  memos.find { |memo| memo['id'] == params['id'] }
end

get '/memos' do
  @memos = connection.exec('SELECT * FROM memos;')
  erb :top
end

get '/memos/new' do
  erb :new_memo
end

post '/memos' do
  @memos = connection.exec('INSERT INTO memos(id, title, message) VALUES ($1, $2, $3)',
                           [SecureRandom.uuid, params['title'], params['message']])
  redirect to('/memos')
end

get '/memos/:id' do
  @memo = read_memo
  if @memo
    erb :show
  else
    erb :error
  end
end

get '/memos/:id/edit' do
  @memo = read_memo
  if @memo
    erb :edit
  else
    erb :error
  end
end

get '/memos/:id/delete' do
  @memo = read_memo
  if @memo
    erb :delete
  else
    erb :error
  end
end

patch '/memos/:id' do
  @memos = connection.exec('UPDATE memos SET title= $1, message= $2 WHERE id= $3',
                           [params['title'], params['message'], params['id']])
  redirect to('/memos')
end

delete '/memos/:id' do
  @memos = connection.exec('DELETE FROM memos WHERE id = $1', [params['id'].to_s])
  redirect to('/memos')
end

not_found do
  "You requested a route that wasn't available."
end
