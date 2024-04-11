*** Settings ***
Library           String
Library           RequestsLibrary
Library           DatabaseLibrary


*** Variables ***
#${DB_CONNECT_STRING}    psycopg2:dbname='happy_learn' user='postgres' password='iloveyou' host='localhost' port='5432'
#${DB_CONNECT_STRING}    dbapi2:postgresql://postgres:iloveyou@localhost:5432/happy_learn
${DB_CONNECT_STRING}    postgresql+psycopg2://postgres:iloveyou@localhost:5432/happy_learn

*** Test Cases ***
Verify Specific Data in Database
    # Connect to the database
    Connect To Database Using Custom Params    ${DB_CONNECT_STRING}
    ${query_result}=    Query    SELECT name, dob, status FROM persons WHERE name='Hoang Van C'
    log to console   ${query_result[0][0]}
    log to console   ${query_result[0][1]}
    log to console   ${query_result[0][2]}
    Disconnect From Database

