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

def specific_file
  @id = params[:id]
  File.open("json/#{@id}.json") do |file|
    @specific = JSON.parse(file.read)
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
  @title = h(params[:title]).to_s
  @message = h(params[:message]).to_s
  hashs = { 'id' => SecureRandom.uuid, "title": @title, "message": @message }
  File.open("json/#{hashs['id']}.json", 'w') do |file|
    JSON.dump(hashs, file)
    redirect to('/memos')
  end
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
  @title = h(params[:title]).to_s
  @message = h(params[:message]).to_s
  hashs = { 'id' => @id, "title": @title, "message": @message }
  File.open("json/#{@id}.json", 'w') do |file|
    JSON.dump(hashs, file)
  end
  redirect to('/memos')
end

delete '/memos/:id' do
  @id = params[:id]
  @title = params[:title]
  @message = params[:message]
  File.delete("json/#{@id}.json")
  redirect to('/memos')
end
