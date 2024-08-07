package primary.owner
import data.token.decrypt
import data.user.active

default allow = false


user_id := decrypt.user_id

# Rule to determine if the user is a primary owner
user_is_primary_owner = obj {
    # Extract roles from the response body
    roles := get_roles_from_response()
    
    # Find an object in roles that matches the specified criteria
    obj := roles[_]
    obj["role"] == "primary-owner"
    obj["user_id"] == decrypt.user_id
    obj["vehicle_id"] == input.vehicle_id
}

# Helper rule to fetch roles from the HTTP response
get_roles_from_response() = roles {
    # Use the user_id from the decrypted token
    user_id := decrypt.user_id

    url := sprintf("https://vms.dev.ue1.dc.goriv.co/vms/v2/provision/list/users/%s", [user_id])
    auth_token := opa.runtime().env["AUTH_TOKEN"]

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

    # Debug: Print the full HTTP response
    print("HTTP response: %v", [resp])

    # Ensure the HTTP response is successful and extract roles
    resp.status_code == 200
    roles := object.get(resp.body, "roles", [])
}

# Policy to allow actions based on conditions
allow {
    user_is_primary_owner
}