*** Settings ***
Library    RequestsLibrary
Library    DataDriver    ../fixtures/csv/bookings.csv    dialect=excel   
Resource    ../resources/common.resource
Variables    ../resources/variables.py
Test Setup    Create Token    ${url}
Test Template    Create Booking DDT  

*** Test Cases ***
# aqui está disponibilizando os dados do bookings.csv
TC001    ${firstname}    ${lastname}    ${totalprice}    ${depositpaid}    ${checkin}    ${checkout}    ${additionalneeds}

TC002    ${firstname}    ${lastname}    ${totalprice}    ${depositpaid}    ${checkin}    ${checkout}    ${additionalneeds}

*** Keywords ***
# aqui está lendo os dados disponíveis/ Test cases e Keywords estão se conectando.
Create Booking DDT
    [Arguments]        ${firstname}    ${lastname}    ${totalprice}    ${depositpaid}    ${checkin}    ${checkout}    ${additionalneeds}
    ${headers}    Create Dictionary    Content-Type=${content_type}    