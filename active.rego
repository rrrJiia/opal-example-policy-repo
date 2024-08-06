# file: user/active.rego

package user.active

import data.token.decrypt

default allow = false

# HTTP request to get a user by rivian_id
get_user_by_user_id[user_id] = response {
    token := decrypt.decrypted_token
    url := sprintf("https://user-mgmt.dev.ue1.dc.goriv.co/id/v2/users/%s", [user_id])
    resp := http.send({
        "method": "get",
        "url": url,
        "headers": {
            "Authorization": sprintf("Bearer %s", [opa.runtime().env[AUTH_TOKEN]])
        }
    })
    response := resp.body
}

# HTTP request to get a list of user-vehicle provisions
get_user_vehicle_provisions[user_id] = response {
    token := decrypt.decrypted_token
    url := sprintf("https://vms.dev.ue1.dc.goriv.co/vms/v2/provision/list/users/%s", [user_id])
    resp := http.send({
        "method": "get",
        "url": url,
        "headers": {
            "Authorization": sprintf("Bearer %s", [opa.runtime().env[AUTH_TOKEN]])
        }
    })
    response := resp.body
}

# Policy to allow actions based on conditions
allow {
    not input.disabled
    some user_id
    response := get_user_by_rivian_id[user_id]
    # Additional logic to determine if the user should be allowed
    response.status == 200
}
