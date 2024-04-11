*** Settings ***
Library           String
Library           RequestsLibrary
Library           DatabaseLibrary

*** Variables ***
${accountServiceUrl}    http://localhost:3030
${authorization}    Basic kjasdflkjgskljgkfjgflkagjlkwadjgklhdfglkfdjglkfj

*** Test Cases ***
Create Account API
    ${CREATE_ACCOUNT_BODY}=   set variable   {"name": "Hoang Van C", "dob": "2000-03-15", "status": "ACTIVATE"}
    &{headers}=    Create Dictionary    Content-Type=application/json   Authorization=${authorization}
    Create Session  createAccountApi    ${accountServiceUrl}   headers=${headers}
    ${response}=  POST On Session  createAccountApi  /persons   data=${CREATE_ACCOUNT_BODY}  headers=${headers}  expected_status=200
    log to console   ${response}
#    # Extract the response data for comparison
#    ${response_data}=    Set Variable    ${response.json()}
#    CONNECT POSTGRESQL
#    ${queryAccount}    QUERY    select name, dob, status from persons where name='Hoang Van C'    returnAsDict=true
#    should contain    ${response_data}[meta][code]    ${queryAccount}[0][name]    expected_status=200
#    # Assuming the query returns one row with the expected data
#    ${db_name}=    Set Variable    ${expected_data[0][0]}
#    ${db_dob}=    Set Variable    ${expected_data[0][1]}
#    ${db_status}=    Set Variable    ${expected_data[0][2]}
#    # Compare API response with database data
#    Should Be Equal    ${response_data['name']}    ${db_name}
#    Should Be Equal    ${response_data['dob']}    ${db_dob}
#    Should Be Equal    ${response_data['status']}    ${db_status}
#    # Disconnect from the database
#    [teardown]    Disconnect From Database



#
#
#    CONNECT POSTGRESQL
#    ${queryAccount}    QUERY    select * from account where name like '%hoan%'    returnAsDict=true
#    should contain    ${response.json()}[data][0][name]    ${queryAccount}[0][name]    expected_status=200
#    [teardown]    disconnect from database

Get Account API
    &{headers}=    Create Dictionary    Content-Type=application/json   Authorization=${authorization}
    Create Session  getAccountApi    ${accountServiceUrl}    headers=${headers}
    ${response}=    GET On Session    getAccountApi   /persons  params=page=0&size=3&name=ANh  expected_status=200
    log to console   ${response}

Update Account API
    &{headers}=    Create Dictionary    Content-Type=application/json   Authorization=${authorization}
    ${id}=   set variable    34
    ${name}=   set variable    Nguyen Van A1
    &{body}=     create dictionary     name=${name}
    Create Session  updateAccountApi    ${accountServiceUrl}    headers=${headers}
    ${response}=  PUT On Session  updateAccountApi  /persons/${id}     json=${body}    expected_status=200
    ${response_data}=    Set Variable    ${response.json()}
    log to console     ${response_data}
    Should Be Equal As Strings   ${response_data['data']['id']}    ${id}
    Should Be Equal    ${response_data['data']['name']}    ${name}

#${actual_id}=    Convert To Integer    ${response_data['data']['id']}
#${expected_id}=    Convert To Integer    ${id}
#Should Be Equal As Numbers    ${actual_id}    ${expected_id}

#    https://robotframework.org/robotframework/latest/libraries/BuiltIn.html#Should%20Be%20Empty
#    Should Not Be Equal
#    Should Be Empty
#    Should Not Be Empty
#    should (Not) contain
#    Should (Not) Contain Any
#    Should (Not) Start With
#    Should (Not) End With
#    Should (Not) Match (Fails if the given string does not match the given pattern.)
#    Should (Not) Match Regexp (Fails if the given string does not match the given pattern.)
#    Should (Not) Be True 10 > 2
#    Should (Not) Be Equal As Integers
#    Should (Not) Be Equal As Numbers
#    Should Be True 10 > 2
#
#    Sleep (Time strings are in a format such as 1 day 2 hours 3 minutes 4 seconds 5milliseconds or 1d 2h 3m 4s 5ms)

Delete Account API
    &{headers}=    Create Dictionary    Content-Type=application/json   Authorization=${authorization}
    ${id}=   set variable    35
    Create Session  deleteAccountApi    ${accountServiceUrl}    headers=${headers}
    ${response}=  DELETE On Session  deleteAccountApi  /persons/${id}    expected_status=400
    ${response_data}=    Set Variable    ${response.json()}
    log to console     ${response_data}
    Should Be Equal    ${response_data['meta']['code']}    MANAGE-4045
    Should Not Be Empty     ${response_data['meta']['message']}

*** Keywords ***
#CONNECT POSTGRESQL
#    Connect To Database Using Custom Params  jaydebeapi  'org.postgresql.Driver', 'jdbc:postgresql://localhost:5432/happy_learn', ['postgres', 'iloveyou'], ['././lib/postgresql-42.3.6.jar']
#    Set Auto Commit False
#    ${DatabaseLibrary}    Get library instance    DatabaseLibrary
#    Evaluate    $DatabaseLibrary._dbconnection.jconn.setAutoCommit(False)



# robot --outputdir api_testing api_testing/person_test.robot

