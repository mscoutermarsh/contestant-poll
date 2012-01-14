require 'rubygems'
require 'sinatra'
require 'data_mapper'

# If you want the logs displayed you have to do this before the call to setup
DataMapper::Logger.new($stdout, :debug)


# xeround database connection
DataMapper.setup(:default, ENV['VOTECONN'])

class Vote
  include DataMapper::Resource

  property :id,          Serial
  property :contestant,  Integer
  property :ip,          String
  property :headers,     String 
  property :created_at,  DateTime 
end

DataMapper.finalize

@hello = Vote.create(:contestant => 1, :created_at => Time.now)

post '/vote/:contestant/:code' do
  
end