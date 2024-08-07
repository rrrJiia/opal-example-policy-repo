package user.active

import data.token.decrypt

default allow = false


user_id := decrypt.user_id

# HTTP request to get a user by user_id
get_user_by_user_id[user_id] {
    # Use the user_id from the decrypted token
    user_id := decrypt.user_id

    # Debug: Print the user_id used in HTTP request
    print(user_id)
    
    # Construct the URL
    url := sprintf("https://user-mgmt.dev.ue1.dc.goriv.co/id/v2/users/%s", [user_id])
    
    print("auth token:", opa.runtime().env["AUTH_TOKEN"])
    
    # Perform HTTP request and capture response
    resp := http.send({
        "method": "get",
        "url": url,
        "headers": {
            "Authorization": "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjZiOTE4Y2Q4MDY5YjEzNmQxNWExMWRlNzIxZTA3YjBjMzhkYTA2YTAiLCJ0eXAiOiJKV1QifQ.eyJpYXQiOjE3MjMwNDU1MzYsImV4cCI6MTcyMzA2NzEzNiwibmJmIjoxNzIzMDQ1NTMxLCJpc3MiOiJyaXZpYW4uY29tIiwiYXVkIjpbImh0dHBzOi8vYXV0aC5kZXYudWUxLmRjLmdvcml2LmNvLyIsImh0dHBzOi8vKi5kZXYiLCJodHRwczovL2lkLmRldi51ZTEuZGMuZ29yaXYuY28vIiwiaHR0cHM6Ly8qIl0sImNsaWVudF9pZCI6IlJJVklBTl9JREVOVElUWV9TRVJWSUNFIiwic2NvcGUiOiIqIiwidXNlcl9pZCI6IjAyLWNhYzgxNTEyLTNkOGYtNDNjNi04NjE4LTY1ZThmNDFkYjMzNi03NTBkMzIxMSJ9.HNNogmf01cNjbefR7xILcIwljTRNXkifL0SMMNvCvtLeetzDPg26CD3y-yP-pFzFslE_K1DNheJCKFd2udqzd-8Tkkgiro9FiEzZUCvWIrC0xmlY0EGjjKApRubfxNeVNtA45fJFR09mJYsszS_fBf5PtMUDM493KxptM6uTsmB45fiwJKK-vohvPu_ga0KlqoJ2z3Effsu2WmAAh25B4L7m8Ux5ao_4mhZwwupx7o2rDrQE5Tozxb4WCgCcggoNFNOqJUyb9ODSSX0hPAybdyHWfUWxlBQHcZ_Y9jhBSlmP2Sl2NMG7eKPdNNNA-5Gz-3g1NCY7zI39O5HEKes0-Q",
            "dc-cid": "haha",
            "x-riv-client-token": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjZiOTE4Y2Q4MDY5YjEzNmQxNWExMWRlNzIxZTA3YjBjMzhkYTA2YTAiLCJ0eXAiOiJKV1QifQ.eyJpYXQiOjE3MjMwNDU1MzYsImV4cCI6MTcyMzA2NzEzNiwibmJmIjoxNzIzMDQ1NTMxLCJpc3MiOiJyaXZpYW4uY29tIiwiYXVkIjpbImh0dHBzOi8vYXV0aC5kZXYudWUxLmRjLmdvcml2LmNvLyIsImh0dHBzOi8vKi5kZXYiLCJodHRwczovL2lkLmRldi51ZTEuZGMuZ29yaXYuY28vIiwiaHR0cHM6Ly8qIl0sImNsaWVudF9pZCI6IlJJVklBTl9JREVOVElUWV9TRVJWSUNFIiwic2NvcGUiOiIqIiwidXNlcl9pZCI6IjAyLWNhYzgxNTEyLTNkOGYtNDNjNi04NjE4LTY1ZThmNDFkYjMzNi03NTBkMzIxMSJ9.HNNogmf01cNjbefR7xILcIwljTRNXkifL0SMMNvCvtLeetzDPg26CD3y-yP-pFzFslE_K1DNheJCKFd2udqzd-8Tkkgiro9FiEzZUCvWIrC0xmlY0EGjjKApRubfxNeVNtA45fJFR09mJYsszS_fBf5PtMUDM493KxptM6uTsmB45fiwJKK-vohvPu_ga0KlqoJ2z3Effsu2WmAAh25B4L7m8Ux5ao_4mhZwwupx7o2rDrQE5Tozxb4WCgCcggoNFNOqJUyb9ODSSX0hPAybdyHWfUWxlBQHcZ_Y9jhBSlmP2Sl2NMG7eKPdNNNA-5Gz-3g1NCY7zI39O5HEKes0-Q"
        }
    })
    
    # Debug: Print the HTTP response
    print("HTTP response for user: %v", [resp.body.data.disabled])
    resp.status_code == 200
    fetched_data := object.get(resp.body, "data", null)
    fetched_data != null
    # Ensure status code check before binding response
    # resp.status_code == 200
    not fetched_data.disabled
}

# Policy to allow actions based on conditions
allow {    
    # Retrieve the user_id from the decrypted token
    user_id := decrypt.user_id
    
    get_user_by_user_id[user_id]
}
