Scenario: 1. Check the title is correct
Given I am on page with URL `https://www.epam.com/`
Then page title is equal to `EPAM | Software Engineering & Product Development Services`

Scenario: 2. Check the ability to switch Light/Dark mode
When I click on element located by `By.xpath(//button[@id='onetrust-accept-btn-handler'])`
When I click on element located by `By.xpath((//div[@class='theme-switcher'])[2])`
When I save `class` attribute value of element located `By.xpath(//body)` to SCENARIO variable `isLightMode`
Then `${isLightMode}` matches `.*light-mode`
When I click on element located by `By.xpath((//div[@class='theme-switcher'])[2])`
When I save `class` attribute value of element located `By.xpath(//body)` to SCENARIO variable `isDarkMode`
Then `${isDarkMode}` matches `.*dark-mode`

Scenario: 3. Check that allows to change language to UA
When I click on element located by `By.xpath((//span[@class='location-selector__button-language'])[last()])`
When I click on element located by `By.xpath((//a[@lang='uk'])[last()])`
When I wait until the page has the title 'EPAM Ukraine - найбільша ІТ-компанія в Україні | Вакансії'
When I save `lang` attribute value of element located `By.xpath(//html)` to SCENARIO variable `ukrLang`
Then `${ukrLang}` is equal to `uk-UA`

Scenario: 4. Check the policies list
Given I am on page with URL `https://www.epam.com/`
When I change context to element located by `By.xpath(//div[@class='policies'])`
Then text `<text>` exists
Examples:
|text|
|INVESTORS|
|COOKIE POLICY|
|OPEN SOURCE|
|APPLICANT PRIVACY NOTICE|
|PRIVACY POLICY|
|WEB ACCESSIBILITY|

Scenario: 5. Check that allows to switch location list by region
When I change context to element located by `By.xpath(//div[@ id='id-890298b8-f4a7-3f75-8a76-be36dc4490fd'])`
Then text `AMERICAS` exists
Then text `EMEA` exists
Then text `APAC` exists

Scenario: 5.1 Check that allows to switch location list by region
When I click on element located by `By.xpath(//a[@data-item='<number>'])`
Then text `<text>` exists
Examples:
|number|text|
|0|CANADA|
|1|ARMENIA|
|2|AUSTRALIA|

Scenario: 6. Check the search function
When I click on element located by `By.xpath(//button[@class='header-search__button header__icon'])`
When I enter `AI` in field located by `By.xpath(//input[@id='new_form_search'])`
When I click on element located by `By.xpath(//span[@class='bth-text-layer'])`
Then text `results for "AI"` exists
Then number of elements found by `By.xpath(//article[@class='search-results__item'])` is greater than `0`

Scenario: 7. Check form's fields validation
Given I am on page with URL `https://www.epam.com/about/who-we-are/contact`
Given I initialize story variable `iteration` with value `1`
When I find >= `0` elements by `By.xpath(//label[contains(text(),'*')])` and for each element do
|step|
|When I save `data-required-msg` attribute value of element located `By.xpath((//label[contains(text(),'*')])[${iteration}]/parent::div)` to story variable `isRequired`|
|Then `${isRequired}` is equal to `This is a required field`|
|Given I initialize scenario variable `iteration` with value `#{eval(${iteration}+1)}`|

Scenario: 8. Check that the Company logo on the header leads to the main page
Given I am on page with URL `https://www.epam.com/about`
When I click on element located by `By.xpath(//a[@class='header__logo-container desktop-logo'])`
Then the page with the URL 'https://www.epam.com/' is loaded

Scenario: 9.Check that allows to download report
Meta:
@proxy
Given I am on page with URL `https://www.epam.com/about`
When I click on element located by `By.xpath(//button[@id='onetrust-accept-btn-handler'])`
When I set browser cookies to the API context
When I click on element located by `By.xpath(//span[contains(text(),'DOWNLOAD')][1])`
When I wait until HTTP GET request with URL pattern `.*EPAM_Corporate_Overview_Q3_october.pdf` exists in proxy log
