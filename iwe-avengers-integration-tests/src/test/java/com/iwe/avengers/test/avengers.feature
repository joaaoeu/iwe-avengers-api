Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://0ubbtgs3f9.execute-api.us-east-1.amazonaws.com/dev'

Scenario: Get Avenger by Id
Given path 'avengers', 'sdsa-sasa-asas-sasa'
When method get
Then status 200
And match response == {id: '#string', name: 'Iron Man', secretIdentity: 'Tony Stark'}

Scenario: Registry a new Avenger
Given path 'avengers'
And request {name: 'Captain America', secretIdentity: 'Steve Rogers'}
When method post
Then status 201
And match response == {id: '#string', name: 'Captain America', secretIdentity: 'Steve Rogers'}

Scenario: Delete Avenger by Id
Given path 'avengers', 'sdsa-sasa-asas-sasa'
When method delete
Then status 204

Scenario: Update Avenger by Id
Given path 'avengers', 'sdsa-sasa-asas-sasa'
And request {name: 'Spider Man', secretIdentity: 'Peter Parker'}
When method put
Then status 200
And match response == {id: '#string', name: 'Spider Man', secretIdentity: 'Peter Parker'}