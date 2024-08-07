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
        "token": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjZiOTE4Y2Q4MDY5YjEzNmQxNWExMWRlNzIxZTA3YjBjMzhkYTA2YTAiLCJ0eXAiOiJKV1QifQ.eyJpYXQiOjE3MjI5ODY0MzksImV4cCI6MTcyMjk5MzYzOSwibmJmIjoxNzIyOTg2NDM0LCJpc3MiOiJyaXZpYW4uY29tIiwiYXVkIjpbImh0dHBzOi8vKi5kZXYiLCJodHRwczovL3ByaXZhY3ktcmlnaHRzLXJlcXVlc3RzLmRldi5nb3Jpdi5jbyIsImh0dHBzOi8vZHQtc2VydmljZS10MmQtZGF0YS1odWIuZGV2LnVlMS5kYy5nb3Jpdi5jbyIsImh0dHBzOi8vaWQuZGV2LnVlMS5kYy5nb3Jpdi5jby8iLCJodHRwczovL2V0LXNlcnZpY2UtaWRtcy10b29scy5kZXYuKi5kYy5nb3Jpdi5jbyIsImh0dHBzOi8vY29yZS1wYXltZW50cy1zZXJ2aWNlLmRldi51ZTEuZGMuZ29yaXYuY28iLCJodHRwczovL2F1dGguZGV2LnVlMS5kYy5nb3Jpdi5jby8iXSwiY2xpZW50X2lkIjoicml2aWFuLmlkbXN0b29scy4yaXZ2YnZqOTVva2RpcmwiLCJzY29wZSI6IioiLCJ1c2VyX2lkIjoiMDItNDk4ODlkMDQtNzc5ZC00YTA5LTk0ZjktZjMyMGUxOTcxYmM3LWY4NDI0YjgyIiwiZW1wbG95ZXJfaWQiOiIwMi1SSVZJQU4ifQ.AMFobzjEiJ775cyf29WCMDb8iyiQxxGU1DEdHCH7AElzNqULp-tf0CBDPRVlTtOMWLxsDFddyRkPNr1OpI9LCyUe0GMx5B2r7sDgbSgDb6bmwqqQ6JNoXDSKDsnRijzFuP6-VCiwzsYJj88meGXRuc9jJ0ZbX0OwKF5RysSYFAWQPlVtPBX_mIOwkTmdsiMkg4yXpoTrXrQJCCto6E-zSnwIh1F9sSDrtVVAhUPq4rpSmdVochA7P4bGU94qdN4VrRTP9-JatVFdmViUl1ULTNElm6IapXA0kVP2PHlwM5O0CzAjI50-cnqteJCEQ3nWBMKkP1XwSJFVRsASQtJ6jQ",
    }

    user_id := decrypt.user_id with input as input

    # Mock the HTTP request
    is_active := active.get_user_by_user_id[user_id] with input as input

    # Assert that the user is active
    is_active == true
}