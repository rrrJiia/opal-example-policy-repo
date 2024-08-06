# file: user/active.rego

package user.active

import data.token.decrypt

default allow = false

# Define the rule to ensure `auth_token` is initialized
auth_token := opa.runtime().env["AUTH_TOKEN"]
user_id := decrypt.user_id
# HTTP request to get a user by user_id
get_user_by_user_id[user_id] = response {
    
    # Define and check URL formatting
    url := sprintf("https://user-mgmt.dev.ue1.dc.goriv.co/id/v2/users/%s", [user_id])
    
    # Perform HTTP request and capture response
    resp := http.send({
        "method": "get",
        "url": url,
        "headers": {
            "Authorization": sprintf("Bearer %s", [auth_token])
        }
    })
    
    # Ensure status code check before binding response
    resp.status_code == 200
    response := resp.body
}

# HTTP request to get a list of user-vehicle provisions
get_user_vehicle_provisions[user_id] = response {

    # Define and check URL formatting
    url := sprintf("https://vms.dev.ue1.dc.goriv.co/vms/v2/provision/list/users/%s", [user_id])
    
    # Perform HTTP request and capture response
    resp := http.send({
        "method": "get",
        "url": url,
        "headers": {
            "Authorization": sprintf("Bearer %s", [auth_token])
        }
    })
    
    # Ensure status code check before binding response
    resp.status_code == 200
    response := resp.body
}

# Policy to allow actions based on conditions
allow {
    not input.disabled
    
    user_id := decrypt.user_id
    
    # Call the function and bind response
    response := get_user_by_user_id[user_id]
    response.status == 200
}
