Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://0ubbtgs3f9.execute-api.us-east-1.amazonaws.com/dev'

Scenario: Should return Unauthorized access
Given path 'avengers', 'anyid'
When method get
Then status 401

Scenario: Get Avenger by Invalid Id
Given path 'avengers', 'invalid'
When method get
Then status 404

Scenario: Registry a New Avenger
#Create a New Avenger
Given path 'avengers'
And request {name: 'Captain America', secretIdentity: 'Steve Rogers'}
When method post
Then status 201
And match response == {id: '#string', name: 'Captain America', secretIdentity: 'Steve Rogers'}

* def savedAvenger = response

#Get savedAvenger by Id
Given path 'avengers', savedAvenger.id
When method get
Then status 200
And match $ == savedAvenger

Scenario: Registry a New Avenger with Invalid Payload
#Create a New Avenger
Given path 'avengers'
And request {secretIdentity: 'Steve Rogers'}
When method post
Then status 400
And match response == {message: 'Invalid request body'}

Scenario: Delete Avenger by Id
#Create a New Avenger
Given path 'avengers'
And request {name: 'Hulk', secretIdentity: 'Bruce Banner'}
When method post
Then status 201

* def avengerToDelete = response

#Delete avengerToDelete by Id
Given path 'avengers', avengerToDelete.id
When method delete
Then status 204

#Get avengerToDelete by Id
Given path 'avengers', avengerToDelete.id
When method get
Then status 404

Scenario: Delete Avenger by Invalid Id
#Delete With Invalid by Id
Given path 'avengers', 'invalid'
When method delete
Then status 404

Scenario: Update Avenger Data by Id
#Create a new Avenger
Given path 'avengers'
And request {name: 'Captain', secretIdentity: 'Steve'}
When method post
Then status 201

* def avengerToUpdate = response

#Update avengerToUpdate by Id
Given path 'avengers', avengerToUpdate.id
And request {name: 'Captain America', secretIdentity: 'Steve Rogers'}
When method put
Then status 200
And match $.id == avengerToUpdate.id
And match $.name == 'Captain America'
And match $.secretIdentity == 'Steve Rogers'

Scenario: Update Avenger Data by Id with invalid Payload
Given path 'avengers', 'sdsa-sasa-asas-sasa'
And request {secretIdentity: 'Peter Parker'}
When method put
Then status 400
And match response == {message: 'Invalid request body'}

Scenario: Update Avenger Data by Invalid Id
Given path 'avengers', 'invalid'
And request {name: 'Spider Man', secretIdentity: 'Peter Parker'}
When method put
Then status 404