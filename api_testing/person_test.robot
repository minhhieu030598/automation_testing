*** Settings ***
Library           String
Library           RequestsLibrary
Library           DatabaseLibrary
Library           custom_db_keywords.CustomDBKeywords

*** Variables ***
${accountServiceUrl}    http://localhost:3030

*** Test Cases ***
Create Account API
    ${CREATE_ACCOUNT_BODY}=   set variable   {"name": "Hoang Van C", "dob": "2000-03-15", "status": "ACTIVATE"}
    &{headers}=    Create Dictionary    Content-Type=application/json
    Create Session  createAccountApi    ${accountServiceUrl}   headers=${headers}
    ${response}=  POST On Session  createAccountApi  /persons   data=${CREATE_ACCOUNT_BODY}  headers=${headers}  expected_status=200
    log to console   ${response}
    # Extract the response data for comparison
    ${response_data}=    Set Variable    ${response.json()}
    CONNECT POSTGRESQL
    ${queryAccount}    QUERY    select name, dob, status from persons where name='Hoang Van C'    returnAsDict=true
    should contain    ${response_data}[meta][code]    ${queryAccount}[0][name]    expected_status=200
#    # Assuming the query returns one row with the expected data
#    ${db_name}=    Set Variable    ${expected_data[0][0]}
#    ${db_dob}=    Set Variable    ${expected_data[0][1]}
#    ${db_status}=    Set Variable    ${expected_data[0][2]}
#    # Compare API response with database data
#    Should Be Equal    ${response_data['name']}    ${db_name}
#    Should Be Equal    ${response_data['dob']}    ${db_dob}
#    Should Be Equal    ${response_data['status']}    ${db_status}
#    # Disconnect from the database
    [teardown]    Disconnect From Database



#
#
#    CONNECT POSTGRESQL
#    ${queryAccount}    QUERY    select * from account where name like '%hoan%'    returnAsDict=true
#    should contain    ${response.json()}[data][0][name]    ${queryAccount}[0][name]    expected_status=200
#    [teardown]    disconnect from database


*** Keywords ***
CONNECT POSTGRESQL
    Connect To Database Using Custom Params  jaydebeapi  'org.postgresql.Driver', 'jdbc:postgresql://localhost:5432/happy_learn', ['postgres', 'iloveyou'], ['././lib/postgresql-42.3.6.jar']
    Set Auto Commit False
#    ${DatabaseLibrary}    Get library instance    DatabaseLibrary
#    Evaluate    $DatabaseLibrary._dbconnection.jconn.setAutoCommit(False)





