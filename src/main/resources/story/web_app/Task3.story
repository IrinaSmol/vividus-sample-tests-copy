Scenario: 1. Verify that allows creating a User
Given I initialize story variable `userEmail` with value `#{generate(Internet.emailAddress)}`
Given I initialize story variable `userPassword` with value `#{generate(Internet.password '6', '10', 'true')}`
Given I initialize story variable `userName` with value `#{generate(Name.username)}`
Given I initialize story variable `userID` with value `#{generate(Number.digits '7')}`
Given request body: {
  "id": ${userID},
  "username": "${userName}",
  "firstName": "John",
  "lastName": "Doe",
  "email": "${userEmail}",
  "password": "${userPassword}",
  "phone": "313-917-2580",
  "userStatus": 1
}
When I add request headers:
|name           |value |
|accept|application/json |
|Content-Type|application/json|
When I execute HTTP POST request for resource with URL `https://petstore.swagger.io/v2/user`
Then response code is equal to `200`
Then JSON element value from `${response}` by JSON path `$.message` is equal to `${userID}`
When I execute HTTP GET request for resource with URL `https://petstore.swagger.io/v2/user/${userName}`
Then response code is equal to `200`
Then JSON element value from `${response}` by JSON path `$.id` is equal to `${userID}`

Scenario: 2. Verify that allows login as a User
When I add request headers:
|name           |value |
|accept|application/json |
When I execute HTTP GET request for resource with URL `https://petstore.swagger.io/v2/user/login?username=${userName}&password=${userPassword}`
Then response code is equal to `200`
Then JSON element value from `${response}` by JSON path `$.message` contains `logged in user session:`

Scenario: 3. Verify that allows creating the list of Users
Given request body: [
{
  "id": "#{generate(Number.digits '7')}",
  "username": "#{generate(Name.username)}",
  "firstName": "Jack",
  "lastName": "Doe",
  "email": "#{generate(Internet.emailAddress)}",
  "password": "#{generate(Internet.password '6', '10', 'true')}",
  "phone": "520-305-6545",
  "userStatus": 1
},
{
  "id": "#{generate(Number.digits '7')}",
  "username": "#{generate(Name.username)}",
  "firstName": "Jane",
  "lastName": "Doe",
  "email": "#{generate(Internet.emailAddress)}",
  "password": "#{generate(Internet.password '6', '10', 'true')}",
  "phone": "615-587-9512",
  "userStatus": 1
},
{
  "id": "#{generate(Number.digits '7')}",
  "username": "#{generate(Name.username)}",
  "firstName": "Jeremy",
  "lastName": "Doe",
  "email": "#{generate(Internet.emailAddress)}",
  "password": "#{generate(Internet.password '6', '10', 'true')}",
  "phone": "217-853-2316",
  "userStatus": 1
}
]
When I add request headers:
|name           |value |
|accept|application/json |
|Content-Type|application/json|
When I execute HTTP POST request for resource with URL `https://petstore.swagger.io/v2/user/createWithList`
Then response code is equal to `200`
Then JSON element value from `${response}` by JSON path `$.message` is equal to `ok`

Scenario: 4. Verify that allows Log out User
When I add request headers:
|name           |value |
|accept|application/json |
When I execute HTTP GET request for resource with URL `https://petstore.swagger.io/v2/user/logout`
Then response code is equal to `200`
Then JSON element value from `${response}` by JSON path `$.message` is equal to `ok`

Scenario: 5. Verify that allows adding a new Pet
Given I initialize story variable `petID` with value `#{generate(Number.digits '8')}`
Given I initialize story variable `petName` with value `Simba`
Given request body: {
  "id": ${petID},
  "category": {
    "id": ${petID},
    "name": "Dog"
  },
  "name": "${petName}",
  "photoUrls": [
    "https://www.barkandwhiskers.com/content/images/size/w2000/2023/08/samoyed-dogs.webp"
  ],
  "tags": [
    {
      "id": ${petID},
      "name": "Samoyed"
    }
  ],
  "status": "available"
}
When I add request headers:
|name           |value |
|accept|application/json |
|Content-Type|application/json|
When I execute HTTP POST request for resource with URL `https://petstore.swagger.io/v2/pet`
Then response code is equal to `200`
Then JSON element value from `${response}` by JSON path `$.id` is equal to `${petID}`
When I execute HTTP GET request for resource with URL `https://petstore.swagger.io/v2/pet/${petID}`
Then response code is equal to `200`
Then JSON element value from `${response}` by JSON path `$.name` is equal to `${petName}`

Scenario: 7. Verify that allows updating Pet’s name, image and status
Given request body: {
  "id": ${petID},
  "category": {
    "id": ${petID},
    "name": "Dog"
  },
  "name": "Pumba",
  "photoUrls": [
    "https://cdn.britannica.com/85/235885-050-C8CC6D8B/Samoyed-dog-standing-snow.jpg"
  ],
  "tags": [
    {
      "id": ${petID},
      "name": "Samoyed"
    }
  ],
  "status": "unavailable"
}
When I add request headers:
|name           |value |
|accept|application/json |
|Content-Type|application/json|
When I execute HTTP PUT request for resource with URL `https://petstore.swagger.io/v2/pet`
Then response code is equal to `200`
Then JSON element value from `${response}` by JSON path `$.name` is equal to `Pumba`
Then JSON element value from `${response}` by JSON path `$.status` is equal to `unavailable`

Scenario: 8. Verify that allows deleting Pet
When I add request headers:
|name           |value |
|accept|application/json |
When I execute HTTP DELETE request for resource with URL `https://petstore.swagger.io/v2/pet/${petID}`
Then response code is equal to `200`
When I execute HTTP GET request for resource with URL `https://petstore.swagger.io/v2/pet/${petID}`
Then response code is equal to `404`
Then JSON element value from `${response}` by JSON path `$.message` is equal to `Pet not found`
