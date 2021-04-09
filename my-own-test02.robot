*** Settings ***
Library    String
Library    REST          https://automationintesting.online
ssl_verify=falseSet expectations
    Expect response   { "status": { "enum": [200, 201, 204, 400] } }
    Expect response   { "seconds": { "maximum": 2} }

*** Test Cases ***

Post to Login
    POST            /auth/login    {"username":"admin","password":"password"}
#   Below line will output the full response
#   Output         response
    ${tokennum}=    Output          $..token
    Set Suite Variable    @{passtoken}    ${tokennum}



Book a Room
   Output   @{passtoken}
   ${bookdetail}=   Set Variable    {"bookingdates": {"checkin": "2018-11-01T09:48:25.469Z","checkout": "2018-11-01T09:48:25.469Z"},"depositpaid": true,"firstname": "string","lastname": "string","roomid": 1,"totalprice": 10}
   POST    booking/   body=${bookdetail}    headers=${passtoken}
   Output   response
   #Output   $.status
   #headers=@{passtoken}

Get Room
    GET             room/
    Output          response  body
    Object          response
    Number          $..roomid
    ${roomnum}=     Output          $..roomid
