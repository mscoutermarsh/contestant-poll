require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'json'

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
  property :validvote,       Boolean
  property :answer,      Integer 
end

helpers do
  def validateVote(answer, question)
    ((question[0].to_i + question[1].to_i) == answer)
  end
end


DataMapper.finalize



get '/vote/:contestant/?' do
  # ask the user some simple math
  int1 = 1 + rand(8)
  int2 = 1 + rand(3)
  answer = int1 + int2

  @newVote = Vote.create(:contestant => params[:contestant], :created_at => Time.now, :answer=>answer, :validvote=>false, :ip=>@env['REMOTE_ADDR'])
  
  output = Hash.new
  output['question'] = "What is #{int1}+#{int2}?"
  output['id'] = "#{@newVote.id}"

  content_type "text"
  output.to_json
end

get '/confirm/:id/:answer/?' do
  vote = Vote.filter(id => params[:id])

  if vote.answer == params[:answer] then
    vote.update(:validvote => true)
    "Thanks for voting!"
  else
    "Oops, wrong answer."
  end
end