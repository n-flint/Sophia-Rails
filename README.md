<h1 align="center">SOPHIA</h1>

<h3 align="center">Speech Operated Personal Household Interactive Assistant</h3>


## Table of Contents
* [Description](#Description)
* [Technologies Used](#Technologies-Used)
* [Learning Goals](#Learning-Goals)
* [How To Use](#How-To-Use)
* [Endpoints](#Endpoints)
* [Challenges](#Challenges)
* [Successes](#Successes)
* [Extensions](#Extensions)
* [Developers](#Developers)
* [Frontend Repo](#Frontend-Repo)

## Description

SOPHIA is a speech operated personal household interactive assistant. This app is built for two audiences: Clients and Caretakers. Clients are anyone with a disability (physical, cognitive, long-term, temporary) who needs care. Caretakers include anyone who is willing to help take care of clients. Taking care could include running errands, cleaning, yardwork, paying bills, grocery shopping, etc. SOPHIA was built to connect clients to caretakers to help meet their daily needs.

Please reference the user stories to understand the full functionality of SOPHIA.

SOPHIA is an A11Y app with a large focus on accessibility.

## Technologies Used
  - [Ruby](https://ruby-doc.org/)
  - [Ruby On Rails](https://guides.rubyonrails.org/)
  - [Travis CI](https://travis-ci.org) [![Build Status](https://travis-ci.org/n-flint/Sophia-Rails.svg?branch=master)](https://travis-ci.org/n-flint/Sophia-Rails)

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
2. Further instructions to come

### Testing
1. Instructions for setting up rspec here

---

## Endpoints
- Clients
  - [Client Profile](#client-profile)
  - [Client Creation](#client-creation)
  - [Client Deletion](#client-deletion)
  - [Client Update](#client-update)
- Caretakers
  - [Caretaker Creation](#caretaker-creation)
  - [Caretaker Update](#caretaker-update)
  - [Caretaker Deletion](#caretaker-deletion)
  - [All Caretakers](#all-caretakers)
  - [Caretaker Profile](#caretaker-profile)
- Caretaker Lists
  - [Caretaker List Show](#caretaker-list-show)
  - [Caretaker List Index](#caretaker-list-index)
- Client Lists
  - [List Creation](#list-creation)
  - [List Index](#list-index)
  - [List Update](#list-update)
  - [List Deletion](#list-deletion)
- Client Tasks
  - [List Tasks Creation](#list-task-creation)
  - [List Tasks Index](#list-tasks-index)
  - [List Tasks Update](#list-tasks-update)
  - [List Tasks Deletion](#list-tasks-deletion)
- [Login](#login)

## Client Creation
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

## Client Update
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

## Client Deletion
Send a DELETE request to delete a client

  #### DELETE /api/v1/clients/:id

  ##### Successful Response:

  will return a 204 status code with no body

  ##### Unsuccessful Response
  A valid client ID must be provided otherwise a 404 status code (page not found) will be returned.

## Client Profile
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

## Caretaker Creation
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

## Caretaker Update
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

## Caretaker Deletion
  Send a DELETE request to delete a caretaker

  #### DELETE /api/v1/caretakers/:id

  ##### Successful Response:

  will return a 204 status code with no body

  ##### Unsuccessful Response
  A valid caretaker ID must be provided otherwise a 404 status code (page not found) will be returned.

## All Caretakers
  Send a GET request to receive a list of all caretakers

  #### GET /api/v1/caretakers

  ##### Successful Response:
   ```
  {
      "id": 1,
      "username": "caretaker_1",
      "name": "caretaker_uno",
      "email": "kate1@email.com",
      "phone_number": "1234567891",
      "abilities": "ability_1",
      "role": "caretaker",
      "created_at": "2019-09-04T22:14:25.439Z",
      "updated_at": "2019-09-04T22:14:25.439Z"
  },
  {
      "id": 2,
      "username": "caretaker_2",
      "name": "caretaker_dos",
      "email": "kate2@email.com",
      "phone_number": "1234567891",
      "abilities": "ability_1",
      "role": "caretaker",
      "created_at": "2019-09-04T22:14:25.439Z",
      "updated_at": "2019-09-04T22:14:25.439Z"
  }
  ```

## Caretaker Profile
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

## List Creation
Send a POST request to create a list for a client

  #### POST /api/v1/clients/:client_id/lists

  ##### Headers:
  ```
  Content-Type: application/json
  Accept: application/json
  ```

  ##### Body:
  ```json
  {
    "name": "Groceries"
  }
  ```

  ##### Successful Response
  ```json
  {
      "id": 1,
      "name": "groceries",
      "client_id": 2,
      "created_at": "2019-09-04T22:14:25.439Z",
      "updated_at": "2019-09-04T22:14:25.439Z"
  }
  ```
  ##### Unsuccessful Response
  A valid client ID must be provided otherwise a 404 status code (page not found) will be returned.

## List Index
Send a GET request to show all lists associated with a client

  #### GET /api/v1/clients/:client_id/lists

  ##### Headers:
  ```
  Content-Type: application/json
  Accept: application/json
  ```

  ##### Successful Response
  ```json
  [
    {
      "id": 1,
      "name": "groceries",
      "client_id": 2,
      "created_at": "2019-09-04T22:14:25.439Z",
      "updated_at": "2019-09-04T22:14:25.439Z"
    },
    {
      "id": 2,
      "name": "bills",
      "client_id": 2,
      "created_at": "2019-09-04T22:14:25.439Z",
      "updated_at": "2019-09-04T22:14:25.439Z"
    }
  ]
  ```
  ##### Unsuccessful Response
  A valid client ID must be provided otherwise a 404 status code (page not found) will be returned.

## List Update
Send a PATCH request to update a clients list

  #### patch /api/v1/clients/:client_id/lists/:list_id

  ##### Headers:
  ```
  Content-Type: application/json
  Accept: application/json
  ```

  ##### Body:
  ```json
  {
    "name": "updated name"
  }
  ```

  ##### Successful Response
  ```json

  {
    "id": 1,
    "name": "updated name",
    "client_id": 2,
    "created_at": "2019-09-04T22:14:25.439Z",
    "updated_at": "2019-09-04T22:14:25.439Z"
  }

  ```
  ##### Unsuccessful Response
  A valid client and list ID must be provided otherwise a 404 status code (page not found) will be returned.

## List Deletion
Send a DELETE request to delete a clients list

  #### delete /api/v1/clients/:client_id/lists/:list_id

  ##### Successful Response:

  Will return a 204 status code with no body.
  All tasks associated with the list will also be deleted

  ##### Unsuccessful Response
  A valid client ID and list ID must be provided otherwise a 404 status code (page not found) will be returned.

## List Task Creation
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

## List Tasks Index
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

## List Tasks Update
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

## List Tasks Deletion
Send a DELTE request to delete a task

  #### delete /api/v1/clients/:client_id/lists/:list_id/tasks/:task_id

  ##### Successful Response

  Will return a 204 status code with no body.

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

## Challenges

coming soon...

## Successes

coming soon...

## Extensions

coming soon...

## Developers

👤 **Noah Flint, Vince Carollo, Katie Lewis, Andreea Hanson**

* Github: [@n-flint](https://github.com/n-flint)
* Github: [@VinceCarollo](https://github.com/VinceCarollo)
* Github: [@Kalex19](https://github.com/Kalex19)
* Github: [@andreeahanson](https://github.com/andreeahanson)

## Frontend Repo

* Github: [Sophia Repo](https://github.comkalex19/Sophia-Native)
