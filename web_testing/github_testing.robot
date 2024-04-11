*** Settings ***
Documentation     GitHub test
Library           SeleniumLibrary

*** Variables ***
${BROWSER}        Chrome
${URL}            https://github.com/login
${USERNAME}       minhhieu030598
${PASSWORD}       Dominhhieu03051998


*** Test Cases ***
GitHub Test Successful Login
    Open Browser    ${URL}   ${BROWSER}  options=add_argument("--start-maximized")
    ${login_button}=    set variable   //input[@class='btn btn-primary btn-block js-sign-in-button']
    ${username_field}=  set variable   //input[@id='login_field']
    ${password_field}=  set variable   //input[@id='password']
    Wait Until Element Is Visible  ${username_field}
    Input Text      ${username_field}   ${USERNAME}
    Input Text      ${password_field}   ${PASSWORD}
    Click Element    ${login_button}
#    Submit form     ${login_button}
    Sleep  1s
    Title Should Be    GitHub
    [Teardown]    Close All Browsers

GitHub Test Fail Password Login
    Open Browser    ${URL}   ${BROWSER}  options=add_argument("--start-maximized")
    ${login_button}=    set variable   //input[@class='btn btn-primary btn-block js-sign-in-button']
    ${username_field}=  set variable   //input[@id='login_field']
    ${password_field}=  set variable   //input[@id='password']
    Wait Until Element Is Visible  ${username_field}
    Input Text      ${username_field}   ${USERNAME}
    Input Text      ${password_field}   1234546547
    Click Element    ${login_button}
    Sleep  1s
    Title Should Be    Sign in to GitHub · GitHub
#   solution 1
#    Wait Until Element Is Visible   //div[@class='js-flash-alert']
#   solution 2
    ${fail_message}=    Get text    //div[@class='js-flash-alert']
    log to console     ${fail_message}
    Should Not Be Empty      ${fail_message}
    [Teardown]    Close All Browsers


# robot --outputdir web_testing web_testing/github_testing.robot
