# Codeplay - a web app for listing courses [ONGOING]

[Campus Code](https://campuscode.com.br/) is a bootcamp school that trains jr web developers on behalf of partner companies. Their program called **Treinadev** happens 4-5 times a year, lasts 2.5 months, and selects the top 20 students after a series of code challenges.

Codeplay is the first project for the Treinadev 6 cohort (May 2021): it's a Ruby on Rails web app.

Learning outcomes:
- first and foremost: TDD - test-driven design
- starting a Rails project from scratch
- CRUD implementation
- translation and internationalization: I18n
- authentication
- API

---

## API

### Get list of courses
Return JSON data with all courses open for enrollment
- URL: /api/v1/courses
- method: GET
- Success response:
  - Code: 200 OK
  - Content: 
  ```
  [{
    "name": "Programming Logic on Ruby",
    "description": "Start here if you don't know where to start!",
    "code": "ROR101",
    "price": "250.0",
    "enrollment_deadline": "2022-05-11",
    "instructor":{
      "name": "Alicia Brant",
      "bio": "Accomplished programmer",
  }},{
    "name": "Ruby on Rails",
    "description": "Make your first web app",
    "code": "ROR201",
    "price": "251.0",
    "enrollment_deadline": "2021-06-17",
    "instructor":{
      "name": "Alicia Brant",
      "bio": "Accomplished programmer"
   }}]
    ```
### Get a single course
Return JSON data for the requested course
- URL: /api/v1/courses/:code
- method: GET
- Success response:
  - Code: 200 OK
  - Content: 
  ```
  [{
    "name": "Programming Logic on Ruby",
    "description": "Start here if you don't know where to start!",
    "code": "ROR101",
    "price": "250.0",
    "enrollment_deadline": "2022-05-11",
    "instructor":{
        "name":"Alicia Brant",
        "bio": "Accomplished programmer",
  }}]
  ```
 - Error response:
     - Code: 404 Not Found