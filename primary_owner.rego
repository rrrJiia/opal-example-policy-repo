package primary.owner
import data.token.decrypt
import data.user.active

default allow = false


user_id := decrypt.user_id

# HTTP request to get a user by user_id
get_primary_owner_info_by_user_id[user_id] {
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
    print("HTTP response for user: %v", [resp])
    resp.status_code == 200
    fetched_data := object.get(resp.body, "roles", null)
    not fetched_data == null
    
    some i
    entry := resp.body.roles[i]
    entry.role == "primary-owner"
    entry.user_id == user_id
    entry.vehicle_id == input.vehicle_id
}

allow {
    # get_user_by_user_id[user_id]
    get_primary_owner_info_by_user_id[user_id]
}