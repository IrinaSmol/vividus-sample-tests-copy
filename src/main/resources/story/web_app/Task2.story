Scenario: 1. Verify that allows register a User
Given I am on page with URL `https://demowebshop.tricentis.com/`
Given I initialize story variable `userEmail` with value `#{generate(Internet.emailAddress)}`
Given I initialize story variable `userPassword` with value `#{generate(Internet.password '6', '10', 'true')}`
When I click on element located by `By.xpath(//a[@href='/register'])`
When I enter `Jane` in field located by `By.xpath(//input[@id='FirstName'])`
When I enter `Doe` in field located by `By.xpath(//input[@id='LastName'])`
When I enter `${userEmail}` in field located by `By.xpath(//input[@id='Email'])`
When I enter `${userPassword}` in field located by `By.xpath(//input[@id='Password'])`
When I enter `${userPassword}` in field located by `By.xpath(//input[@id='ConfirmPassword'])`
When I click on element located by `By.xpath(//input[@id='register-button'])`
Then text `Your registration completed` exists

Scenario: 2. Verify that allows login a User
When I click on element located by `By.xpath(//a[@href='/logout'])`
When I click on element located by `By.xpath(//a[@href='/login'])`
When I enter `${userEmail}` in field located by `By.xpath(//input[@id='Email'])`
When I enter `${userPassword}` in field located by `By.xpath(//input[@id='Password'])`
When I click on element located by `By.xpath(//input[@class='button-1 login-button'])`
When I save text of element located by `By.xpath((//a[@class='account'])[1])` to story variable `loggedUser`
Then `${loggedUser}` is equal to `${userEmail}`

Scenario: 3. Verify that ‘Computers’ group has 3 sub-groups with correct names
When I hover mouse over element located `By.xpath((//a[@href='/computers'])[1])`
Then text `<text>` exists
Examples:
|text|
|Desktops|
|Notebooks|
|Accessories|

Scenario: 4. Verify that allows sorting items (different options)
Given I am on page with URL `https://demowebshop.tricentis.com/books`
When I select `<option>` in dropdown located `By.xpath(//select[@id='products-orderby'])`
Then elements located by `By.xpath<xpath>` are sorted by text in <sorting> order
Examples:
|option|xpath|sorting|
|Name: A to Z|(//h2[@class='product-title']/a)|ascending|
|Name: Z to A|(//h2[@class='product-title']/a)|descending|
|Price: Low to High|(//span[@class='price actual-price'])|ascending|
|Price: High to Low|(//span[@class='price actual-price'])|descending|

Scenario: 5. Verify that allows changing number of items on page
When I select `4` in dropdown located `By.xpath(//select[@id='products-pagesize'])`
Then number of elements found by `By.xpath(//div[@class='product-item'])` is <= `4`

Scenario: 6. Verify that allows adding an item to the Wishlist
Given I am on page with URL `https://demowebshop.tricentis.com/black-white-diamond-heart`
When I click on element located by `By.xpath(//input[@value='Add to wishlist'])`
Then text `The product has been added to your wishlist` exists
When I click on element located by `By.xpath((//a[@href='/wishlist'])[1])`
Then text `Black & White Diamond Heart` exists

Scenario: 7. Verify that allows adding an item to the cart
Given I am on page with URL `https://demowebshop.tricentis.com/black-white-diamond-heart`
When I click on element located by `By.xpath((//input[@value='Add to cart'])[1])`
Then text `The product has been added to your shopping cart` exists
When I click on element located by `By.xpath((//a[@class='ico-cart'])[1])`
Then text `Black & White Diamond Heart` exists

Scenario: 8. Verify that allows removing an item from the cart
When I check checkbox located by `By.xpath((//input[@name='removefromcart'])[1])`
When I click on element located by `By.xpath(//input[@name='updatecart'])`
Then text `Black & White Diamond Heart` does not exist

Scenario: 9. Verify that allows checkout an item 
Given I am on page with URL `https://demowebshop.tricentis.com/black-white-diamond-heart`
When I click on element located by `By.xpath((//input[@value='Add to cart'])[1])`
When I click on element located by `By.xpath((//a[@class='ico-cart'])[1])`
When I check checkbox located by `By.xpath(//input[@id='termsofservice'])`
When I click on element located by `By.xpath(//button[@id='checkout'])`
When I select `United States` in dropdown located `By.xpath(//select[@id='BillingNewAddress_CountryId'])`
When I select `Pennsylvania` in dropdown located `By.xpath(//select[@id='BillingNewAddress_StateProvinceId'])`
When I enter `Philadelphia` in field located by `By.xpath(//input[@id='BillingNewAddress_City'])`
When I enter `150 Hiddenview Drive` in field located by `By.xpath(//input[@id='BillingNewAddress_Address1'])`
When I enter `19126` in field located by `By.xpath(//input[@id='BillingNewAddress_ZipPostalCode'])`
When I enter `215-910-0482` in field located by `By.xpath(//input[@id='BillingNewAddress_PhoneNumber'])`
When I click on element located by `By.xpath((//input[@title='Continue'])[1])`
When I wait until element located by `By.xpath((//input[@title='Continue'])[2])` appears
When I click on element located by `By.xpath((//input[@title='Continue'])[2])`
When I click on element located by `By.xpath((//input[@value='Continue'])[3])`
When I click on element located by `By.xpath((//input[@value='Continue'])[4])`
When I click on element located by `By.xpath((//input[@value='Continue'])[5])`
When I click on element located by `By.xpath(//input[@value='Confirm'])`
When I wait until element located by `By.xpath(//input[@class='button-2 order-completed-continue-button'])` appears
Then text `Your order has been successfully processed!` exists
Then text `Order number` exists
