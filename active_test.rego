package user.active_test

import data.user.active
import data.token.decrypt

# Mock HTTP response
mock_response_enabled := {
    "body": {"disabled": false},
    "status_code": 200
}

mock_response_disabled := {
    "body": {"disabled": true},
    "status_code": 200
}

# Mock HTTP function
mock_http_send := {
    "get": "https://user-mgmt.dev.ue1.dc.goriv.co/id/v2/users/02-49889d04-779d-4a09-94f9-f320e1971bc7-f8424b82"
       
    
}

# Test case for active user
test_active_user {
    input := {
        "token": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjZiOTE4Y2Q4MDY5YjEzNmQxNWExMWRlNzIxZTA3YjBjMzhkYTA2YTAiLCJ0eXAiOiJKV1QifQ.eyJpYXQiOjE3MjMwMDkyMjYsImV4cCI6MTcyMzAxNjQyNiwibmJmIjoxNzIzMDA5MjIxLCJpc3MiOiJyaXZpYW4uY29tIiwiYXVkIjpbImh0dHBzOi8vcHJpdmFjeS1yaWdodHMtcmVxdWVzdHMuZGV2Lmdvcml2LmNvIiwiaHR0cHM6Ly9pZC5kZXYudWUxLmRjLmdvcml2LmNvLyIsImh0dHBzOi8vZHQtc2VydmljZS10MmQtZGF0YS1odWIuZGV2LnVlMS5kYy5nb3Jpdi5jbyIsImh0dHBzOi8vZXQtc2VydmljZS1pZG1zLXRvb2xzLmRldi4qLmRjLmdvcml2LmNvIiwiaHR0cHM6Ly9hdXRoLmRldi51ZTEuZGMuZ29yaXYuY28vIiwiaHR0cHM6Ly8qLmRldiIsImh0dHBzOi8vY29yZS1wYXltZW50cy1zZXJ2aWNlLmRldi51ZTEuZGMuZ29yaXYuY28iXSwiY2xpZW50X2lkIjoicml2aWFuLmlkbXN0b29scy4yaXZ2YnZqOTVva2RpcmwiLCJzY29wZSI6IioiLCJ1c2VyX2lkIjoiMDItNDk4ODlkMDQtNzc5ZC00YTA5LTk0ZjktZjMyMGUxOTcxYmM3LWY4NDI0YjgyIiwiZW1wbG95ZXJfaWQiOiIwMi1SSVZJQU4ifQ.FDILJ0ggzjCL566oWlC10Hppn1yPdwDiDpqOu-9tTwTJ_O7xNw7Slftuq9tWExnooAWL7boZeTkXfMabgRhp7hsMyk3-EWnm1ulRzk3tUMA4egcWMCqUZ165zhMZOxKOTrwxKiFbB6imA-GaiS1Z3AXevgwwvbOej72oJ30CXbX5QGovUWONcqHS-RWOHJhLHF0vwYLeGe1aDLwrGwYI3qxAll-MjEGPD7bkMw0Axg0H7BmsAlF6u-7IzYSnZV267LLXVHB9fvCBHQrJiEp59IiEpQvQpvq9VVLUyh42vQKc_DslHU1FyFya8tHntlFVRxIBeUGl77wbcOe-58N5Ig",
    }

    user_id := decrypt.user_id with input as input

    # Mock the HTTP request
    is_active := active.get_user_by_user_id[user_id] with input as input

    # Assert that the user is active
    is_active == true
}