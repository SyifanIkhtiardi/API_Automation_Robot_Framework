*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${baseUrl}        https://reqres.in/api/users
${pageId}         2

*** Test Cases ***

Quick Get Request Test
    ${response}=    GET    ${baseUrl}    params=page=${pageId}    expected_status=200
    Log    ${response.json()}
    Should Be Equal As Strings    6    ${response.json()}[per_page]
    Should Be Equal As Strings    12    ${response.json()}[total]
    Should Be Equal As Strings    7    ${response.json()}[data][0][id]