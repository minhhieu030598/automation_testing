*** Settings ***
Documentation     A test suite for valid login.
...
...               Keywords are imported from the resource file
Default Tags      positive
Library           SeleniumLibrary
Suite Setup       Open Browser To LoginPage
Suite Teardown    Close All Browsers

*** Variables ***
${BROWSER}        Chrome
${URL}            http://google.com
${EXPECTED_TITLE}   Google

*** Keywords ***
Open Browser To LoginPage
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Title Should Be  ${EXPECTED_TITLE}


*** Test Cases ***
Visit Example Page
    [Documentation]    Test that the browser opens up the Example Domain.
    [Tags]             Smoke
    Title Should Be    ${EXPECTED_TITLE}



# robot --outputdir web_testing web_testing/chrome_testing.robot

