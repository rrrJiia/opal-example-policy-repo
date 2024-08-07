package primary.owner.test

import data.token.decrypt
import data.primary.owner

# Mock the HTTP response
mock_http_response := {
    "roles": [
        {"role": "primary-owner", "user_id": "02-63bd6bd9-4a7d-435b-abcd-b2fb510bcfd3-f595762b", "vehicle_id": "01-245905524"},
        {"role": "user", "user_id": "02-49889d04-779d-4a09-94f9-f320e1971bc7-f8424b82", "vehicle_id": "vehicle2"}
    ]
}


# Test case: Verify that the correct token and vehicle_id combination is identified as the primary owner
test_primary_owner {
    input := {
        "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyLCJ1c2VyX2lkIjoiMDItNjNiZDZiZDktNGE3ZC00MzViLWFiY2QtYjJmYjUxMGJjZmQzLWY1OTU3NjJiIn0.WC4fge4bIBHbirTRkZgDp3rbCcZgc2lVAtO4yLpq3Gg",
        "vehicle_id": "01-245905524"
    }
    user_id := decrypt.user_id with input as input
    is_primary := owner.get_primary_owner_info_by_user_id[user_id] with input as input

    is_primary == true 
}

# Test case: Verify that an incorrect token or vehicle_id combination is not identified as the primary owner
test_not_primary_owner {
    input := {
        "token": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjZiOTE4Y2Q4MDY5YjEzNmQxNWExMWRlNzIxZTA3YjBjMzhkYTA2YTAiLCJ0eXAiOiJKV1QifQ.eyJpYXQiOjE3MjMwMDkyMjYsImV4cCI6MTcyMzAxNjQyNiwibmJmIjoxNzIzMDA5MjIxLCJpc3MiOiJyaXZpYW4uY29tIiwiYXVkIjpbImh0dHBzOi8vcHJpdmFjeS1yaWdodHMtcmVxdWVzdHMuZGV2Lmdvcml2LmNvIiwiaHR0cHM6Ly9pZC5kZXYudWUxLmRjLmdvcml2LmNvLyIsImh0dHBzOi8vZHQtc2VydmljZS10MmQtZGF0YS1odWIuZGV2LnVlMS5kYy5nb3Jpdi5jbyIsImh0dHBzOi8vZXQtc2VydmljZS1pZG1zLXRvb2xzLmRldi4qLmRjLmdvcml2LmNvIiwiaHR0cHM6Ly9hdXRoLmRldi51ZTEuZGMuZ29yaXYuY28vIiwiaHR0cHM6Ly8qLmRldiIsImh0dHBzOi8vY29yZS1wYXltZW50cy1zZXJ2aWNlLmRldi51ZTEuZGMuZ29yaXYuY28iXSwiY2xpZW50X2lkIjoicml2aWFuLmlkbXN0b29scy4yaXZ2YnZqOTVva2RpcmwiLCJzY29wZSI6IioiLCJ1c2VyX2lkIjoiMDItNDk4ODlkMDQtNzc5ZC00YTA5LTk0ZjktZjMyMGUxOTcxYmM3LWY4NDI0YjgyIiwiZW1",
        "vehicle_id": "noVehicle"
    }
    user_id := decrypt.user_id with input as input
    is_primary := owner.get_primary_owner_info_by_user_id[user_id] with input as input
    print(is_primary)
    is_primary == false 
}