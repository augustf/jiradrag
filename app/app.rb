# app.rb
require 'sinatra'
require 'jira-ruby'
require 'dotenv/load'

class HelloWorldApp < Sinatra::Base
  get '/' do

    options = {
      :username => ENV['JIRA_USER'],
      :password => ENV['JIRA_PASSWORD'],
      :site     => ENV['JIRA_SERVER'],
      :auth_type => :basic,
      :context_path => '',
      :read_timeout => 120
    }

    client = JIRA::Client.new(options)

    erb :maintenance, locals: {client: client}
  end

  post '/commit-priorities', :provides => :json do
    payload = URI.unescape(request.body.read)
    x = JSON.parse payload.to_s
    File.open("moose", 'w') { |file| file.write(x[1]) }
    "hello world"
  end
end
