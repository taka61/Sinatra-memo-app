# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'json'

# XSS
helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

def read_memo(id)
  File.open("json/#{id}.json") do |file|
    JSON.parse(file.read)
  end
end

def read_all
  files = Dir.glob('json/*')
  @hashs = files.map { |file| JSON.parse(File.read(file)) }
end

def write_memo(hashs)
  File.open("json/#{hashs['id']}.json", 'w') do |file|
    JSON.dump(hashs, file)
  end
end

get '/memos' do
  read_all
  erb :top
end

get '/memos/new' do
  erb :new_memo
end

post '/memos' do
  hashs = { 'id' => SecureRandom.uuid, "title": params[:title], "message": params[:message] }
  write_memo(hashs)
  redirect to('/memos')
end

get '/memos/:id' do
  @memo = read_memo(params['id'])
  erb :show
end

get '/memos/:id/edit' do
  @memo = read_memo(params['id'])
  erb :edit
end

get '/memos/:id/delete' do
  @memo = read_memo(params['id'])
  erb :delete
end

patch '/memos/:id' do
  edit_hashs = { 'id' => params[:id], "title": params[:title], "message": params[:message] }
  write_memo(edit_hashs)
  redirect to('/memos')
end

delete '/memos/:id' do
  File.delete("json/#{params['id']}.json")
  redirect to('/memos')
end
