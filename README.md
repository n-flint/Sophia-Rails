# Sophia
This is the summary

## Learning Goals
  - First learning goal
  - Second learning goal

## Technologies Used
  - [Ruby](https://ruby-doc.org/)
  - [Ruby On Rails](https://guides.rubyonrails.org/)
  - [Travis CI](https://travis-ci.org)

## Setup
1. Clone this repository
2. Further instructions to come

  ### Testing
  1. Instructions for setting up rspec here

---

## Endpoints
  - [User Profile](#user-profile)
  - [All Lists](#all-lists)
  - [Single List](#single-list)
  - [Create A List](#create-a-list)
  - [Create A Task](#create-a-task)

## User Profile
Send a GET request to receive all information related to a single user

  #### GET /api/v1/users/:id
   *this should change once we have a login/sessions
  ```
  Content-Type: application/json
  Accept: application/json
  ```

  ##### Successful Response
  ```
  { 
    "client": {
      "id": 1,
      "name": "client 1",
      "street_address": "1331 17th St.",
      "city": "Denver",
      "state": "CO",
      "zip_code": "80202",
      "email": "snoopy@example.com"'
      "phone_number": "9119119911",
      "username": "username-1",
      "needs": "example need 1",
      "allergies": "example allergy 1",
      "medications": "example medication 1"
      }
  }
  ```
  ##### Unsuccessful Response
  A valid user ID must be provided otherwise a 404 status code (page not found) will be returned.

## All Lists
Send a GET request to receive a list of all the lists related to a single user

  #### GET api/v1/users/:id/lists
  ```
  Content-Type: application/json
  Accept: application/json
  ```

  ##### Successful Response
  ```
  { 
    "client": {
      "id": 1'
      "lists": {
        "some sort of lists would go here... hopefully"
        }
    }
  }
  ```

  ##### Requirements
  - A valid ID must be provided otherwise a 404 status code (page not found) will be returned.

## Single List

Send a GET request to receive a single list

  #### GET /api/v1/users/:id/lists/:list_id
  ```
  Content-Type: application/json
  Accept: application/json
  ```

  ##### Successful Response
  ```
  {
    "id": "1",
    "name": "list one",
    "tasks": {
      "task_1": {
        "name": "task name uno",
        "description": "this is the description of the first task",
        "completed": "false",
        "due_date": "12-25-2025"
      },
      "task_2": {
        "name": "task name dos",
        "description": "this is the description of the second task",
        "completed": "true",
        "due_date": "01-01-2026"
      }
    }

  }
  ```

  ##### Requirements
  -  If the user ID or the list ID are invalid, a 404 status code (page not found) will be returned.

## Create A List

Send a POST request with valid list parameters to create a new list.

  #### POST /api/v1/users/:id/lists
  ```
  Content-Type: application/json
  Accept: application/json
  ```

  ##### Successful Request
  ```
  { "name": "new list" }
  ```

  ##### Successful Response
  ```
  {
    "id": "1",
    "name": "new list uno"
  }
  ```

  ##### Requirements
  - If a valid name a is not provided, a 404 status code (page not found) will be returned.

## Create A Task

Send a POST request with valid task parameters to create a new task.

  #### POST /api/v1/users/:id/lists/:id/tasks
  ```
  Content-Type: application/json
  Accept: application/json
  ```

  ##### Successful Request
  ```
  { 
    "name": "new task",
    "description": "description of task the new task",
    "completed": "false",
    "due_date": "12-12-2077"
   }
  ```

  ##### Successful Response
  ```
  { 
    "id": "1",
    "name": "new task",
    "description": "description of task the new task",
    "completed": "false",
    "due_date": "12-12-2077"
   }
  ```

  ##### Requirements
  - If missing an ID or name,  a 404 status code (page not found) will be returned. Description is optional.
  
----------

## Contributing
   - Please open a pull request to contribute! Vince loves feedback!!!
