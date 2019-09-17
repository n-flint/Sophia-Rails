<h1 align="center">SOPHIA</h1>

<h3 align="center">Speech Operated Personal Household Interactive Assistant</h3>


## Table of Contents
* [Description](#Description)
* [Technologies Used](#Technologies-Used)
* [Learning Goals](#Learning-Goals)
* [How To Use](#How-To-Use)
* [Endpoints](#Endpoints)
* [Database Schema](#Database-Schema)
* [Challenges](#Challenges)
* [Successes](#Successes)
* [Extensions](#Extensions)
* [Developers](#Developers)
* [Frontend Repo](#Frontend-Repo)
* [Production](#Production)

## Description

SOPHIA is a speech operated personal household interactive assistant. This app is built for two audiences: Clients and Caretakers. Clients are anyone with a disability (physical, cognitive, long-term, temporary) who needs care. Caretakers include anyone who is willing to help take care of clients. Taking care could include running errands, cleaning, yardwork, paying bills, grocery shopping, etc. SOPHIA was built to connect clients to caretakers to help meet their daily needs.

Please reference the user stories to understand the full functionality of SOPHIA.

SOPHIA is an A11Y app with a large focus on accessibility.

## Technologies Used
  - [Ruby](https://ruby-doc.org/)
  - [Ruby On Rails](https://guides.rubyonrails.org/)
  - [PostgreSQL](https://www.postgresql.org/)
  - [RSpec-Rails](https://github.com/rspec/rspec-rails)
  - [Travis CI](https://travis-ci.org)  [![Build Status](https://travis-ci.org/n-flint/Sophia-Rails.svg?branch=master)](https://travis-ci.org/n-flint/Sophia-Rails)
  - [Docker](https://www.docker.com)
  - [FFmpeg](https://ffmpeg.org/)

## Learning Goals

This is a unique opportunity that presents some valuable goals:

* Ultimately, demonstrate knowledge you’ve gained throughout Turing
* Use an agile process to turn well defined requirements into deployed and production ready software
* Gain experience dividing applications into components and domains of responsibilities to facilitate multi-developer teams.
* Service oriented architecture concepts and patterns are highly encouraged.
* Explore and implement new concepts, patterns, or libraries that have not been explicitly taught while at Turing
* Practice an advanced, professional git workflow (see whole-team expectations)
* Gain more experience using continuous integration tools to build and automate the deployment of features in various environments
* Build applications that execute in development, test, CI, and production environments
* Focus on communication between front-end and back-end teams in order to complete and deploy features that have been outlined by the project spec

## Setup
1. Clone this repository
```
cd Sophia-Rails
bundle install
rails db:create
rails db:migrate
rails db:seed
rails server
```
2. Navigate to http://localhost:3000

## Docker Setup
1. Clone this repository
2. Make sure docker is running

```
cd Sophia-Rails
git checkout dockerize
docker-compose build
docker-compose run web rails db:{create,migrate,seed}
docker-compose up
```

3. Navigate to http://localhost:3000

```
docker-compose build
docker-compose up
```

### Testing
Testing Requests:

```
bundle exec rspec spec/requests
```

Testing Google Text to Speech:

*Google Speech api will look for an Environment Variable called GOOGLE_APPLICATION_CREDENTIALS that points to the path of key.json assigned by google. More info can be found [here](https://cloud.google.com/speech-to-text/docs/quickstart-client-libraries) in the 'Before you begin' section.*

```
bundle exec rspec spec/services
```

Testing Models:

```
bundle exec rspec spec/models
```

## Endpoints

### Client Endpoints
- [Single Client](#single-client)
  - [Client Profile](#client-profile)
  - [Client Creation](#client-creation)
  - [Client Update](#client-update)
  - [Client Deletion](#client-deletion)
- [Client Lists](#client-lists)
  - [List Creation](#list-creation)
  - [List Index](#list-index)
  - [List Update](#list-update)
  - [List Deletion](#list-deletion)
- [Client Tasks](#client-tasks)
  - [List Tasks Creation](#list-task-creation)
  - [List Tasks Index](#list-tasks-index)
  - [List Tasks Update](#list-tasks-update)
  - [List Tasks Deletion](#list-tasks-deletion)

### Caretaker Endpoints
- [Single Caretaker](#single-caretaker)
  - [Caretaker Profile](#caretaker-profile)
  - [Caretaker Creation](#caretaker-creation)
  - [Caretaker Update](#caretaker-update)
  - [Caretaker Deletion](#caretaker-deletion)
- [Caretaker Lists](#caretaker-lists)
  - [Caretaker List Show](#caretaker-list-show)
  - [Caretaker List Index](#caretaker-list-index)
- [Caretaker Tasks](#caretaker-tasks)
  - [Caretaker Task Update](#caretaker-task-update)
### Login
- [Login](#login)
### Speech to text
- [Speech to Text](#speech-to-text)

---

# Client Endpoints

## Single Client

### Client Profile:
Send a GET request to receive all information related to a single client

  #### GET /api/v1/clients/:id
   *if a client does not have diet_restrictions, needs, allergies, or medications, these attributes do not show. The client below has no 'allergies' associated*
  ```
  Content-Type: application/json
  Accept: application/json
  ```

  ##### Successful Response
  ```json
  {
    "id": "1",
    "username": "katierulz",
    "name": "Katie",
    "street_address": "123 Test St",
    "city": "Denver",
    "state": "CO",
    "zip": "12345",
    "email": "katierulz@gmail.com",
    "phone_number": "1235551234",
    "needs": ["groceries", "bills"],
    "medications": ["drug_1", "drug_2"],
    "diet_restrictions": ["vegetarian", "peanut-free"],
    "role": "client",
    "created_at": "DateTime",
    "updated_at": "DateTime"
  }
  ```
  ##### Unsuccessful Response
  A valid client ID must be provided otherwise a 404 status code (page not found) will be returned.


### Client Creation:
Send a POST request to create a client

  #### POST /api/v1/clients/

  ##### headers:
  ```
  Content-Type: application/json
  Accept: application/json
  ```

#### body:
 *MUST have password AND password confirmation and they must match*
```json
{
    "username": "string-required",
    "name": "string-required",
    "password": "password",
    "password_confirmation": "password",
    "street_address": "string-required",
    "city": "string-required",
    "state": "string-required",
    "zip": "string-required",
    "email": "string-required",
    "phone_number": "string-required",
    "needs": ["array"],
    "allergies": ["array"],
    "medications": ["array"],
    "diet_restrictions": ["array"],
    "role": "client"
}
```

  ##### Successful Response
  ```json
  {
    "id": "1",
    "username": "katierulz",
    "name": "Katie",
    "street_address": "123 Test St",
    "city": "Denver",
    "state": "CO",
    "zip": "12345",
    "email": "katierulz@gmail.com",
    "phone_number": "1235551234",
    "needs": ["groceries", "bills"],
    "allergies": ["pollen", "peanuts"],
    "medications": ["drug_1", "drug_2"],
    "diet_restrictions": ["vegetarian", "peanut-free"],
    "role": "client",
    "created_at": "DateTime",
    "updated_at": "DateTime"
  }
  ```
  #### Unsuccessful Responses:
  ##### Email Taken:
  ```json
  {
    "email": ["has already been taken"]
  }
  ```

  ##### Empty state:
  ```json
  {
    "state": ["can't be blank"]
  }
  ```

  ##### Unmatching Password:
  ```json
  {
    "password_confirmation": ["does not match password"]
  }
  ```

### Client Update
Send a PATCH request to update a clients profile

  #### PATCH /api/v1/clients/:id

  #### Headers:
  ```
  Content-Type: application/json
  Accept: application/json
  ```

  #### Body:
  ```json
{
  "email": "vincecarollo@gmail.com"
}

  ```

  ##### Successful Response
  ```json
  {
    "id": "1",
    "username": "katierulz",
    "name": "Katie",
    "street_address": "123 Test St",
    "city": "Denver",
    "state": "CO",
    "zip": "12345",
    "email": "vincecarollo@gmail.com",
    "phone_number": "1235551234",
    "needs": ["groceries", "bills"],
    "allergies": ["pollen", "peanuts"],
    "medications": ["drug_1", "drug_2"],
    "created_at": "DateTime",
    "updated_at": "DateTime"
  }
  ```
  ##### Unsuccessful Response
  A valid client ID must be provided otherwise a 404 status code (page not found) will be returned.

### Client Deletion
Send a DELETE request to delete a client

  #### DELETE /api/v1/clients/:id

  ##### Successful Response:

  will return a 204 status code with no body

  ##### Unsuccessful Response
  A valid client ID must be provided otherwise a 404 status code (page not found) will be returned.

## Client Tasks


### List Task Creation
Send a POST request to create a list task

  #### post /api/v1/clients/:client_id/lists/:list_id/tasks

  ##### Headers:
  ```
  Content-Type: application/json
  Accept: application/json
  ```
  #### Body:
  *Due date is optional*
  ```json
{
    "name": "task one",
    "description": "description of the first task",
    "due_date": "2018-12-08"
}
  ```

  ##### Successful Response
  ```json

  {
    "id": 1,
    "name": "task_uno",
    "description": "description of the first task",
    "completed": "false",
    "due_date": "2018-12-08"
  }

  ```
  ##### Unsuccessful Response
  A valid client and list ID must be provided otherwise a 404 status code (page not found) will be returned.

### List Tasks Index
Send a GET request to get all tasks associated with a clients list

  #### get /api/v1/clients/:client_id/lists/:list_id/tasks

  ##### Headers:
  ```
  Content-Type: application/json
  Accept: application/json
  ```

  ##### Successful Response
  ```json
[
  {"id":83,
    "name":"Coriander Seed",
    "description":"3 gallon",
    "completed":false,
    "list_id":349,
    "created_at":"2019-09-06T04:43:25.260Z",
    "updated_at":"2019-09-06T04:43:25.260Z",
    "due_date":"2019-09-17T00:00:00.000Z"},
   {"id":84,
    "name":"Mung Beans",
    "description":"3 gallon",
    "completed":false,
    "list_id":349,
    "created_at":"2019-09-06T04:43:25.262Z",
    "updated_at":"2019-09-06T04:43:25.262Z",
    "due_date":"2019-09-07T00:00:00.000Z"},
   {"id":85,
    "name":"Sweet Potato",
    "description":"1 gallon",
    "completed":false,
    "list_id":349,
    "created_at":"2019-09-06T04:43:25.263Z",
    "updated_at":"2019-09-06T04:43:25.263Z",
    "due_date":"2019-09-24T00:00:00.000Z"}
]
  ```
  ##### Unsuccessful Response
  A valid client and list ID must be provided otherwise a 404 status code (page not found) will be returned.

### List Tasks Update
Send a PATCH request to update a task

  #### patch /api/v1/clients/:client_id/lists/:list_id/tasks/:task_id

  ##### Headers:
  ```
  Content-Type: application/json
  Accept: application/json
  ```

  ##### Body:
  ```
  {
    name: "updated name"
  }
  ```

  ##### Successful Response
  ```json
  {
    "id": 1,
    "name": "updated name",
    "description": "description of the first task",
    "completed": "false",
    "due_date": "date_time"
  }
  ```
  ##### Unsuccessful Response
  A valid client, list, and task ID must be provided otherwise a 404 status code (page not found) will be returned.

### List Tasks Deletion
Send a DELTE request to delete a task

  #### delete /api/v1/clients/:client_id/lists/:list_id/tasks/:task_id

  ##### Successful Response

  Will return a 204 status code with no body.

  ##### Unsuccessful Response
  A valid client, list, and task ID must be provided otherwise a 404 status code (page not found) will be returned.

---

# Caretaker Endpoints

## Single Caretaker:

### Caretaker Profile
  Send a GET request to receive all information related to a single caretaker

  #### GET /api/v1/caretakers/:id

  ##### Successful Response
  ```json
  {
    "id": "1",
    "username": "katierulz",
    "name": "Katie",
    "email": "katierulz@gmail.com",
    "phone_number": "1235551234",
    "abilities": "ability_1",
    "role": "caretaker",
    "created_at": "DateTime",
    "updated_at": "DateTime"
  }
  ```
  ##### Unsuccessful Response
  A valid caretaker ID must be provided otherwise a 404 status code (page not found) will be returned.

### Caretaker Creation:
Send a POST request to create a caretaker

  #### POST /api/v1/caretakers/:id

  ##### headers:
  ```
  Content-Type: application/json
  Accept: application/json
  ```

#### body:
 *MUST have password AND password confirmation and they must match*
  ```json
  {
      "username": "string-required",
      "name": "string-required",
      "password": "password",
      "password_confirmation": "password",
      "email": "string-required",
      "phone_number": "string-required",
      "abilities": "ability_1",
      "role": "caretaker"
  }
  ```

  ##### Successful Response
  ```json
  {
    "id": "1",
    "username": "katierulz",
    "name": "Katie",
    "email": "katierulz@gmail.com",
    "phone_number": "1235551234",
    "abilities": "ability_1",
    "role": "caretaker",
    "created_at": "DateTime",
    "updated_at": "DateTime"
  }
  ```
  #### Unsuccessful Responses:
  ##### Username Taken:
  ```json
  {
    "message": ["Username has been taken"]
  }
  ```

  ##### Email Taken:
  ```json
  {
    "message": ["Email has been taken"]
  }
  ```

  ##### Unmatching Password:
  ```json
  {
    "password_confirmation": ["does not match password"]
  }
  ```

### Caretaker Update
Send a PATCH request to update a caretaker

  #### PATCH /api/v1/caretakers/:id

  ##### headers:
  ```
  Content-Type: application/json
  Accept: application/json
  ```

#### body:
```json
{
    "username": "updated_username",
    "name": "update_name",
    "email": "updated_email@email.com",
    "phone_number": "updated_number",
    "abilities": "updated_ability_1"
}
```

  ##### Successful Response
  ```json
  {
    "id": "1",
    "username": "updated_username",
    "name": "update_name",
    "email": "updated_email@email.com",
    "phone_number": "updated_number",
    "abilities": "updated_ability_1",
    "created_at": "DateTime",
    "updated_at": "DateTime"
  }
  ```
  #### Unsuccessful Responses:
  ##### Username Taken:
  ```json
  {
    "message": ["Username has been taken"]
  }
  ```

  ##### Email Taken:
  ```json
  {
    "message": ["Email has been taken"]
  }
  ```

### Caretaker Deletion
  Send a DELETE request to delete a caretaker

  #### DELETE /api/v1/caretakers/:id

  ##### Successful Response:

  will return a 204 status code with no body

  ##### Unsuccessful Response
  A valid caretaker ID must be provided otherwise a 404 status code (page not found) will be returned.

## Caretaker Lists

## Caretaker List Show
Send a GET request to get a single list associated with a caretaker

  #### get /api/v1/caretakers/:id/lists/:list_id/

  ##### Successful Response
  ```json
  {
      "id": 1,
      "name": "groceries",
      "client_id": 2,
      "caretaker_id": 4,
      "created_at": "2019-09-04T22:14:25.439Z",
      "updated_at": "2019-09-04T22:14:25.439Z"
  }
  ```

  ##### Unsuccessful Response
  A valid caretaker and list ID must be provided otherwise a 404 status code (page not found) will be returned.

## Caretaker List Index
Send a GET request to get all the lists associated with a caretaker

  #### get /api/v1/caretakers/:id/lists/


  ##### Successful Response
  ```json
  [
    {
      "id": 1,
      "name": "groceries",
      "client_id": 2,
      "caretaker_id": 4,
      "created_at": "2019-09-04T22:14:25.439Z",
      "updated_at": "2019-09-04T22:14:25.439Z"
    },
    {
      "id": 2,
      "name": "bills",
      "client_id": 2,
      "caretaker_id": 4,
      "created_at": "2019-09-04T22:14:25.439Z",
      "updated_at": "2019-09-04T22:14:25.439Z"
    }
  ]
  ```

  ##### Unsuccessful Response
  A valid caretaker ID must be provided otherwise a 404 status code (page not found) will be returned.

## Caretaker Tasks:

  ### Caretaker Tasks Update
Send a PATCH request to update a task

  #### patch /api/v1/caretakers/:id/lists/:list_id/tasks/:task_id

  ##### Headers:
  ```
  Content-Type: application/json
  Accept: application/json
  ```

  ##### Body:
  ```
  {
    name: "updated name",
    completed: "true"
  }
  ```

  ##### Successful Response
  ```json
  {
    "id": 1,
    "name": "updated name",
    "description": "description of the first task",
    "completed": "true",
    "due_date": "date_time"
  }
  ```
  ##### Unsuccessful Response
  A valid client, list, and task ID must be provided otherwise a 404 status code (page not found) will be returned.

## Login
Send a POST request to get user id from username and password

#### post /api/v1/login

##### Headers:
```
Content-Type: application/json
Accept: application/json
```

##### Body:
```
{
  username: "testClient",
  password: "pass"
}
```

##### Successful Response
returns the user object who matches given username and password

```json
{
  "id": "1",
  "username": "testClient",
  "name": "Katie",
  "street_address": "123 Test St",
  "city": "Denver",
  "state": "CO",
  "zip": "12345",
  "email": "katierulz@gmail.com",
  "phone_number": "1235551234",
  "needs": ["groceries", "bills"],
  "medications": ["drug_1", "drug_2"],
  "diet_restrictions": ["vegetarian", "peanut-free"],
  "created_at": "DateTime",
  "updated_at": "DateTime"
}
```
##### Unsuccessful Response
##### Bad Username/Password:
Returns 400 and body:
```json
  {
    "message": "Invalid Username/Password"
  }
```

## Speech to Text
Send a POST request to turn a .caf audio file into text

*Google Speech api will look for an Environment Variable called GOOGLE_APPLICATION_CREDENTIALS that points to the path of key.json assigned by google. More info can be found [here](https://cloud.google.com/speech-to-text/docs/quickstart-client-libraries) in the 'Before you begin' section.*

#### post /api/v1/speech

##### Headers:
```
Content-Type: application/octet-stream
```

##### Body:
Body Should contain an audio blob originating from a .caf file

##### Successful Response
Returns text converted from audio file sent.
```json
{
  "message": "groceries"
}
```
##### Unsuccessful Response
```json
{
  "message": "No Matching Text Found"
}
```

## Database Schema
<img width="812" alt="sophia_db_schema" src="https://user-images.githubusercontent.com/34421236/64760769-bcbca100-d4f7-11e9-989f-d03cb4b120b1.png">

## Challenges
Technicle Debt: This project has two types of users, a client and a caretaker. When planning our database architecture, we were more focused on implementing the client funcionality first. When we moved on to implementing the caretaker funcionality, we had to rearrange much of the existing routes and controllers to accomidate.

## Successes
Testing: During the course of developing this project, we were consitently able to maintain 97% to 100% test coverage.

## Extensions
We would eventually like to combine both the client and caretaker tables into one.

## Developers

👤 **Noah Flint, Vince Carollo, Katie Lewis, Andreea Hanson**

* Github: [@n-flint](https://github.com/n-flint)
* Github: [@VinceCarollo](https://github.com/VinceCarollo)
* Github: [@Kalex19](https://github.com/Kalex19)
* Github: [@andreeahanson](https://github.com/andreeahanson)

## Frontend Repo

* Github: [Sophia Repo](https://github.comkalex19/Sophia-Native)

## Production

* Heroku: [Sophia Rails Application](https://evening-dusk-50121.herokuapp.com/)
