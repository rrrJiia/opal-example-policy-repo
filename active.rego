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
            "Authorization": "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjZiOTE4Y2Q4MDY5YjEzNmQxNWExMWRlNzIxZTA3YjBjMzhkYTA2YTAiLCJ0eXAiOiJKV1QifQ.eyJpYXQiOjE3MjI5NzU4NDQsImV4cCI6MTcyMjk5NzQ0NCwibmJmIjoxNzIyOTc1ODM5LCJpc3MiOiJyaXZpYW4uY29tIiwiYXVkIjpbImh0dHBzOi8vKiIsImh0dHBzOi8vaWQuZGV2LnVlMS5kYy5nb3Jpdi5jby8iLCJodHRwczovLyouZGV2IiwiaHR0cHM6Ly9hdXRoLmRldi51ZTEuZGMuZ29yaXYuY28vIl0sImNsaWVudF9pZCI6IlJJVklBTl9JREVOVElUWV9TRVJWSUNFIiwic2NvcGUiOiIqIiwidXNlcl9pZCI6IjAyLWNhYzgxNTEyLTNkOGYtNDNjNi04NjE4LTY1ZThmNDFkYjMzNi03NTBkMzIxMSJ9.YaHx1UiZ9MxpnxijzDl1GzqlQBnVACZq9Ax_8kRKCLVpk4kJe1ufAnIMHjfsVmPAqhKFjLKtVGkdvt7Jo_7m_gohlINEGIZImh1SQ7c1wEO_nBJ9WiTfR8I1UYgSi29L9Se8UN52Bo4FoI39PLc5gUIetiIo6ujO6OC_f1gEUJxdaCDGhhU-MogCUxUZ5XBW2F9CUDSMp18TE8SP_RiVkpW0tf1kV1k0Qu9Ow7sMlRHdWskTH6feJUil6vYuUqzjSTi_vTcTZ5mOE9xdHHoR_A369ypLMSA5tFbuEzzjAbzfz18J9W3oSZe7eqsDoo0GgIBCtYqqIwgw2sgnTx2TSQ",
            "dc-cid": "haha",
            "x-riv-client-token": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjZiOTE4Y2Q4MDY5YjEzNmQxNWExMWRlNzIxZTA3YjBjMzhkYTA2YTAiLCJ0eXAiOiJKV1QifQ.eyJpYXQiOjE3MjI5NzU4NDQsImV4cCI6MTcyMjk5NzQ0NCwibmJmIjoxNzIyOTc1ODM5LCJpc3MiOiJyaXZpYW4uY29tIiwiYXVkIjpbImh0dHBzOi8vKiIsImh0dHBzOi8vaWQuZGV2LnVlMS5kYy5nb3Jpdi5jby8iLCJodHRwczovLyouZGV2IiwiaHR0cHM6Ly9hdXRoLmRldi51ZTEuZGMuZ29yaXYuY28vIl0sImNsaWVudF9pZCI6IlJJVklBTl9JREVOVElUWV9TRVJWSUNFIiwic2NvcGUiOiIqIiwidXNlcl9pZCI6IjAyLWNhYzgxNTEyLTNkOGYtNDNjNi04NjE4LTY1ZThmNDFkYjMzNi03NTBkMzIxMSJ9.YaHx1UiZ9MxpnxijzDl1GzqlQBnVACZq9Ax_8kRKCLVpk4kJe1ufAnIMHjfsVmPAqhKFjLKtVGkdvt7Jo_7m_gohlINEGIZImh1SQ7c1wEO_nBJ9WiTfR8I1UYgSi29L9Se8UN52Bo4FoI39PLc5gUIetiIo6ujO6OC_f1gEUJxdaCDGhhU-MogCUxUZ5XBW2F9CUDSMp18TE8SP_RiVkpW0tf1kV1k0Qu9Ow7sMlRHdWskTH6feJUil6vYuUqzjSTi_vTcTZ5mOE9xdHHoR_A369ypLMSA5tFbuEzzjAbzfz18J9W3oSZe7eqsDoo0GgIBCtYqqIwgw2sgnTx2TSQ"
        }
    })
    
    # Debug: Print the HTTP response
    print("HTTP response for user: %v", [resp.body.data.disabled])
    
    # Ensure status code check before binding response
    resp.status_code == 200
    not resp.body.disabled
}

# Policy to allow actions based on conditions
allow {    
    # Retrieve the user_id from the decrypted token
    user_id := decrypt.user_id
    
    get_user_by_user_id[user_id]
}
