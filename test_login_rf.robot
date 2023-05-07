*** Settings ***
Library     SeleniumLibrary
Documentation       Suite description #automated tests for scout website
Library  SeleniumLibrary
Documentation    Suite description #automated tests for scout website

*** Variables ***
${LOGIN URL}      https://scouts.futbolkolektyw.pl/en/
${BROWSER}        Chrome
${SIGNINBUTTON}     xpath=//*[(text()='Sign in')]
${EMAILINPUT}       xpath=//*[@id='login']
${PASSWORDINPUT}    xpath=//*[@id='password']
${PAGELOGO}     xpath=//*[@id="__next"]/div[1]/main/div[3]/div[1]/div/div[1]
${LOG OUT BUTTON}       xpath=//ul[2]/div[2]
${CHANGE LANGUAGE BUTTON}       xpath=//*[@id='__next']/div[1]/div/div/div/ul[2]/div[1]
${ADD PLAYER BUTTON}        xpath=//*[@id='__next']/div[1]/main/div[3]/div[2]/div/div/a/button
${SUBMIT BUTTON ADD PLAYER}     xpath=//*[@type='submit']
${PLAYER EMAIL INPUT}       xpath=//*[@name='email']
${NAMEINPUT}        xpath=//*[@name='name']
${SURNAMEINPUT}     xpath=//*[@name='surname']
${PHONEINPUT}       xpath=//*[@name='phone']
${WEIGHTINPUT}      xpath=//*[@type='number'][1]
${HEIGHTINPUT}      xpath=//*[@name='height']
${AGEINPUT}     xpath=//*[@name='age']
${MAIN POSITION INPUT}      xpath=//*[@name='mainPosition']
${ADD LINK TO YOUTUBE BUTTON}       xpath=//*[@aria-label='Add link to Youtube']
${YOUTUBE LINK INPUT}             xpath=//*[@name='webYT[0]']
${MAIN CLUB INPUT}      xpath=//*[@name='club']
${ACHIEVEMENTS INPUT}       xpath=//*[@name='achievements']
${SECOND POSITION}      xpath=//*[@name='secondPosition']
${PLAYER LANGUAGE BUTTON}       xpath=//*[@aria-label='Add language']
${PLAYER LANGUAGE INPUT}        xpath=//*[@name='languages[0]']
${CHOOSE LEG BUTTON}        xpath=//*[@id = 'mui-component-select-leg']
${CHOOSE RIGHT LEG}     xpath=//*[@data-value='right']
${CHOOSE DISTRICT BUTTON}       xpath=//*[@id='mui-component-select-district']
${CHOOSE DISTRICT}      xpath=//*[@data-value='lubelskie']
${MAIN PAGE BUTTON}     xpath=//*[(text()='Main page')]         #xpath=//*[@id="__next"]/div[1]/div/div/div/ul[1]/div[1]
${CLEAR FORM BUTTON}        xpath=//*[contains(@class, 'MuiButton-containedSecondary')]
${LAST ADDED PLAYER}        xpath=//*[@id="__next"]/div[1]/main/div[3]/div[3]/div/div/a[1]/button
${SUCESS CONTAINER}     xpath=//*[@id="__next"]/div[2]/div

*** Test Cases ***
Login to the system
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Assert dashboard
    [Teardown]    Close Browser

Log out of the system
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Click on the log out button
    Assert login page
    [Teardown]    Close Browser

Change Language
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Click on the change language button
    Click on the change language button
    [Teardown]    Close Browser

Add a new player
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Click on the add player button
    Assert New Player Title
    [Teardown]    Close Browser

Fill in form
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Click on the add player button
    Fill in form
    Assert Check last added player
    [Teardown]    Close Browser

Clear form
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Click on the add player button
    Fill in part of the form
    Click on the Clear button
    [Teardown]    Close Browser

*** Keywords ***
Open login page
    Open Browser        ${LOGIN URL}        ${BROWSER}
    Title Should Be        Scouts panel - sign in
Type in email
    Input Text      ${EMAILINPUT}       user07@getnada.com
Type in password
    Input Text      ${PASSWORDINPUT}        Test-1234
Click on the submit button
    Click Element       ${SIGNINBUTTON}
Assert dashboard
    Wait Until Element Is Visible       ${PAGELOGO}
    Title Should Be     Scouts panel
    Capture Page Screenshot     alert.png
Click on the log out button
    Wait Until Element Is Visible       ${PAGELOGO}
    Click Element       ${LOG OUT BUTTON}
Assert login page
    Title Should Be     Scouts panel - sign in
    Capture Page Screenshot     logout.png
Click on the change language button
    Wait Until Element Is Visible       ${PAGELOGO}
    Click Element       ${CHANGE LANGUAGE BUTTON}
    Capture Page Screenshot     jezyk_polski.png
    Click Element       ${CHANGE LANGUAGE BUTTON}
    Capture Page Screenshot     jezyk_angielski.png
Click on the add player button
    Wait Until Element Is Visible       ${PAGELOGO}
    Click Element       ${ADD PLAYER BUTTON}
Assert New Player Title
    Wait Until Element Is Visible       ${SUBMIT BUTTON ADD PLAYER}
    Title Should Be     Add player
    Capture Page Screenshot     add_player.png
Fill in form
    Wait Until Element Is Visible       ${SUBMIT BUTTON ADD PLAYER}
    Input text      ${PLAYER EMAIL INPUT}       marian@amorki.pl
    Input text      ${NAMEINPUT}        Marian
    Input text      ${SURNAMEINPUT}     Drozd
    Input text      ${PHONEINPUT}       123456
    Input text      ${WEIGHTINPUT}      80kg
    Input text      ${HEIGHTINPUT}      180
    Input text      ${AGEINPUT}     01.01.2001
    Input text      ${MAIN POSITION INPUT}      Napastnik
    Input text      ${MAIN CLUB INPUT}      Liverpool
    Input text      ${ACHIEVEMENTS INPUT}       brak
    Input text      ${SECOND POSITION}      Bramkarz
    Click element       ${CHOOSE LEG BUTTON}
    Click element       ${CHOOSE RIGHT LEG}
    Click element       ${CHOOSE DISTRICT BUTTON}
    Click element       ${CHOOSE DISTRICT}
    Click element       ${PLAYER LANGUAGE BUTTON}
    Input text      ${PLAYER LANGUAGE INPUT}        English
    Click element       ${ADD LINK TO YOUTUBE BUTTON}
    Wait Until Element Is Visible    ${YOUTUBE LINK INPUT}
    Input text      ${YOUTUBE LINK INPUT}       none
    Click element       ${SUBMIT BUTTON ADD PLAYER}
    Wait Until Element Is Visible       ${SUCESS CONTAINER}
    Click element       ${MAIN PAGE BUTTON}
Assert Check last added player
    Wait Until Element Is Visible       ${PAGELOGO}
    Element Text Should Be      ${LAST ADDED PLAYER}        MARIAN DROZD
    # Should Be Equal     ${LAST ADDED PLAYER}        Marian Drozd
Fill in part of the form
    Wait Until Element Is Visible       ${SUBMIT BUTTON ADD PLAYER}
    Input text      ${PLAYER EMAIL INPUT}       marian@amorki.pl
    Input text      ${NAMEINPUT}        Marian
    Input text      ${SURNAMEINPUT}     Drozd
Click on the Clear button
    Click element       ${CLEAR FORM BUTTON}
    Capture Page Screenshot     clear.png

class TestLoginPage(unittest.TestCase):
    @classmethod
    def setUp(self):
        os.chmod(DRIVER_PATH, 755)
        self.driver = webdriver.Chrome(executable_path=DRIVER_PATH)
        self.driver.get("https://scouts.futbolkolektyw.pl/en/")
        self.driver.fullscreen_window()
        self.driver.implicitly_wait(IMPLICITLY_WAIT)
        super(TestLoginPage, self).setUp(self)

    def test_login_to_the_system(self):
        user_login = LoginPage(self.driver)
        user_login.type_in_email('user02@getnada.com')
        user_login.type_in_password('Test-1234')
        user_login.title_of_page()
        user_login.title_of_box()
        user_login.click_on_the_sign_in_button()
        time.sleep(2)

        dashboard_page = Dashboard(self.driver)
        dashboard_page.title_of_page()

    @classmethod
    def tearDown(self):
        self.driver.quit()
