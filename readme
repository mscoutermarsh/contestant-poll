Contestant Poll API
===========================
mscoutermarsh

Purpose: API for tracking votes. Votes require math captcha.

In the public folder is an HTML/JavaScript implementation of the API.

Documentation
-------------

Each Vote contains the following:

+   id (Integer)


POST
----

### Create a new Vote
`Post: http://localhost:4567/vote/:contestant`

Creates a new vote. Returns json containing the ID and the simple math problem.

Response: `{"question":"What is 4+3?","id":"96"}`

### Confirm Vote
`Post: http://localhost:4567/confirm/:id/:answer`

Post ID recieved when creating a vote. And the answer to the question.
If correct: the vote will be valid and counted.
`{"message":"Thanks for voting!"}`

If incorrect: error message will be returned.
`{"message":"Oops, wrong answer."}`

Response: `{"question":"What is 4+3?","id":"96"}`

GET
----