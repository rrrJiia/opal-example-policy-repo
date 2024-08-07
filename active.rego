package user.active

import data.token.decrypt

default allow = false


user_id := decrypt.user_id

# HTTP request to get a user by user_id
get_user_by_user_id[user_id] {
    # Use the user_id from the decrypted token
    user_id := decrypt.user_id

    # Construct the URL
    url := sprintf("https://user-mgmt.dev.ue1.dc.goriv.co/id/v2/users/%s", [user_id])
    
    auth_token := opa.runtime().env["AUTH_TOKEN"]
    # print("auth token:", opa.runtime().env["AUTH_TOKEN"])
    
    # Perform HTTP request and capture response
    resp := http.send({
        "method": "get",
        "url": url,
        "headers": {
            "Authorization": sprintf("Bearer %s", [auth_token]),
            "dc-cid": "haha",
            "x-riv-client-token": auth_token
        }
    })
    
    # Debug: Print the HTTP response
    print("HTTP response for user: %v", [resp])
    
    # Ensure status code check before binding response
    resp.status_code == 200
    fetched_data := object.get(resp.body, "data", null)
    fetched_data != null

    not fetched_data.disabled
    
}

# Policy to allow actions based on conditions
allow {    
    # Retrieve the user_id from the decrypted token
    user_id := decrypt.user_id
    
    get_user_by_user_id[user_id]
}
