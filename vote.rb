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

  # create new vote
  @newVote = Vote.create(:contestant => params[:contestant], :created_at => Time.now, :answer=>answer, :validvote=>false, :ip=>@env['REMOTE_ADDR'])
  
  # return security question and ID.
  output = Hash.new
  output['question'] = "What is #{int1}+#{int2}?"
  output['id'] = "#{@newVote.id}"

  content_type "json"
  output.to_json
end

get '/confirm/:id/:answer/?' do
  output = Hash.new

  #answer to security question. If correct... vote is valid!
  vote_to_check = Vote.get(params[:id])
  if vote_to_check then
    if vote_to_check.answer.to_i == params[:answer].to_i then
      vote_to_check.update(:validvote => true)
      hash['message'] = "Thanks for voting!"
    else
      hash['message'] = "Oops, wrong answer."
    end
  else
    hash['message'] = "no, no, no..."
  end

  content_type "json"
  hash.to_json
end