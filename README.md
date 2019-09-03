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
  - [Client Creation](#client-creation)
  - [Client Deletion](#client-deletion)
  - [Client Update](#client-update)

## Client Creation
Send a POST request to create a client

  #### POST /api/v1/clients/

  ##### headers:
  ```
  Content-Type: application/json
  Accept: application/json
  ```

#### body:
```json
{
    "username": "string-required",
    "name": "string-required",
    "street_address": "string-required",
    "city": "string-required",
    "state": "string-required",
    "zip": "string-required",
    "email": "string-required",
    "phone_number": "string-required",
    "needs": "string",
    "allergies": "string",
    "medications": "string"
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
    "needs": "groceries, bills",
    "allergies": "pollen, peanuts",
    "medications": "drug_1, drug_2",
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
    "client": {
      "email": "vincecarollo@gmail.com"
    }
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
    "needs": "groceries, bills",
    "allergies": "pollen, peanuts",
    "medications": "drug_1, drug_2",
    "created_at": "DateTime",
    "updated_at": "DateTime"
  }
  ```
  ##### Unsuccessful Response
  A valid user ID must be provided otherwise a 404 status code (page not found) will be returned.

## Client Deletion
Send a DELETE request to delete a client

  #### DELETE /api/v1/clients/:id

  ##### Successful Response:

  will return a 204 status code with no body

  ##### Unsuccessful Response
  A valid user ID must be provided otherwise a 404 status code (page not found) will be returned.

## Client Profile
Send a GET request to receive all information related to a single user

  #### GET /api/v1/clients/:id
   *this should change once we have a login/sessions*
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
    "needs": "groceries, bills",
    "allergies": "pollen, peanuts",
    "medications": "drug_1, drug_2",
    "created_at": "DateTime",
    "updated_at": "DateTime"
  }
  ```
  ##### Unsuccessful Response
  A valid user ID must be provided otherwise a 404 status code (page not found) will be returned.
