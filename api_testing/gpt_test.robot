*** Settings ***
Library           RequestsLibrary

*** Variables ***
${URL}            http://localhost:3030/persons
${HEADERS}        Content-Type=application/json
${BODY}           {"name": "Hoang Van C", "dob": "2000-03-15", "status": "ACTIVATE"}

*** Test Cases ***
Post Person Data And Verify Status Code
    Create Session    my_api_session    ${URL}
    ${response}=    Post On Session  my_api_session    /    data=${BODY}    headers=${HEADERS}
    Status Should Be    200    ${response}
