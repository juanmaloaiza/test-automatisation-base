@PruebaAutomatizacion
Feature: Party Authentication API Automation

  Background:
# Base URL and SSL configuration
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    * configure ssl = true

  @GetPersonById
  Scenario: Get a Person By Id
    Given url  'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/391'
    * configure ssl = true
    When method get
    Then status 200

  @GetAllListPerson
  Scenario: Get a List All of person
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    When method get
    Then status 200



  @GetPersonByIdNotFound
  Scenario: Get a Person By Id Not Found
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/1'
    * configure ssl = true
    When method get
    Then status 404
    And match response contains  { "error": "Character not found"}


  @CreateAndGetId
  Scenario: create user and get contactID
    * def randomName = 'Iron Man 22223233332'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    Given def requestPayload = read('/data/person/AddPerson.json')
    And request requestPayload
    When method post
    Then status 201
    And def contactId = response.id
    And print 'contacto:' + contactId


  @CreateAndError
  Scenario: create user error
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    Given def requestPayload = read('/data/person/AddErrorPerson.json')
    And request requestPayload
    When method post
    Then status 400
    And match response contains  { "name": "Name is required"}

@PutError
Scenario: put user error
  * def randomName = 'Iron Man 222332322'
  Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/1'
  And request { "name": "#(randomName)", "alterego": "Tony Stark", "description": "Genius billionaire", "powers": ["Armor", "Flight"] }
  When method put
  Then status 404
  And match response contains  {"error":"Character not found"}

  @DeleteId
  Scenario: delete person error
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/1'
    When method delete
    Then status 404
    And match response contains   {"error":"Character not found"}