Contestant Poll API
===========================
mscoutermarsh

**Purpose:** 
API for tracking votes. To limit cheating, instead of using a captcha, use simple math!

API is all contained within *votes.rb.*

An example of how it could be implemented is in the public folder.

For a vote to be valid is must be created and then confirmed (by answering a simple math problem).

**Setup:** Before running you must do the following:
+ Define ENV variable VOTECONN. This is the connection string to your database.
+ *Optional:* Define ENV variable ALLOW_REF with the domain you want to limit requests from.
++ Example: ALLOWED_REF=voteAPI.heroku.com will only allow record votes if the referer is from the specified domain.



API Documentation
============================

POST
----

### Create a new Vote
`Post: http://localhost:4567/vote/:contestant`

Creates a new vote. Returns json containing the ID and the simple math problem.

Response: `{"question":"What is 4+3?","id":"96"}`

After recieving this response, you must confirm the vote by answering the question (What is 4+3?).

### Confirm Vote
`Post: http://localhost:4567/confirm/:id/:answer`

**Post:** ID and answer to question.

If correct: the vote will be valid and counted.//
`{"message":"Thanks for voting!"}`

If incorrect: error message will be returned.//
`{"message":"Oops, wrong answer."}`


GET
----

### Get count of votes

`Get: http://localhost:4567/votes/:contestant`

Returns number of validated votes for a contestant.

Response: `{"votes":"21"}`

Things to do
============================
+ Clean up JavaScript for example implementation.
+ Record header information for the user. This could be used to filter out cheating beyond just IP.