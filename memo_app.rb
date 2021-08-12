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

def receive_memo
  File.open("json/#{params['id']}.json") do |file|
    JSON.parse(file.read)
  end
end

get '/memos' do
  files = Dir.glob('json/*')
  @hashs = files.map { |file| JSON.parse(File.read(file)) }
  erb :top
end

get '/memos/new' do
  erb :new_memo
end

post '/memos' do
  hashs = { 'id' => SecureRandom.uuid, "title": params[:title], "message": params[:message] }
  File.open("json/#{hashs['id']}.json", 'w') do |file|
    JSON.dump(hashs, file)
    redirect to('/memos')
  end
end

get '/memos/:id' do
  @specific = receive_memo
  erb :show
end

get '/memos/:id/edit' do
  @specific = receive_memo
  erb :edit
end

get '/memos/:id/delete' do
  @specific = receive_memo
  erb :delete
end

patch '/memos/:id' do
  hashs = { 'id' => params[:id], "title": params[:title], "message": params[:message] }
  File.open("json/#{params['id']}.json", 'w') do |file|
    JSON.dump(hashs, file)
  end
  redirect to('/memos')
end

delete '/memos/:id' do
  File.delete("json/#{params['id']}.json")
  redirect to('/memos')
end
