*** Settings ***
Library     SeleniumLibrary
Documentation       Suite description #automated tests for scout website


*** Variables ***
${LOGIN URL}      https://scouts-test.futbolkolektyw.pl/en
${BROWSER}        Chrome
${SIGNINBUTTON}     xpath=//*[(text()='Sign in')]
${EMAILINPUT}       xpath=//*[@id='login']
${PASSWORDINPUT}    xpath=//*[@id='password']
${PAGELOGO}     xpath=//*[@id="__next"]/div[1]/main/div[3]/div[1]/div/div[1]

*** Test Cases ***
Login to the system
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Assert dashboard
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

class TestLoginPage(unittest.TestCase):

    @classmethod
    def setUp(self):
        os.chmod(DRIVER_PATH, 755)
        self.driver = webdriver.Chrome(executable_path=DRIVER_PATH)
        self.driver.get("https://scouts-test.futbolkolektyw.pl/en")
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

    # def test_title_of_dashboard_page(self):
        dashboard_page = Dashboard(self.driver)
        dashboard_page.title_of_page()

    @classmethod
    def tearDown(self):
        self.driver.quit()
