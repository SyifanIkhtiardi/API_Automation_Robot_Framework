*** Settings ***
Resource          ../../resources/keywords.robot
Resource          ../../resources/variables.robot
Resource          ../../resources/endpoint_list.resource

*** Test Cases ***
Get User By id
     [Documentation]          Get user by id with valid user_id and valid app_id
     [Tags]                   Positive Smoke Regression
     ${response_body}     ${status_code}     Get User    ${BASE_URL}    ${USER_DETAIL_ENDPOINT}    ${USER_ID}    ${APP_ID}
     log  ${response_body}
     Verify Response Status Code    200    ${status_code}