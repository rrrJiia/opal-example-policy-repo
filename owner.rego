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
    # print("HTTP response: %v", [resp])
    # Check if the HTTP response is successful
    resp.status_code == 200
    # Extract roles from the response body
    roles := object.get(resp.body, "roles", [])
    print("Extracted roles: %v", [roles])
    # Ensure that roles are not null
    not roles == []
    some i
    entry := resp.body.roles[i]
    print("Extracted entry: %v", [entry])
    entry.role == "primary-owner"
    print("Extracted entry: %v", [entry.role])
    entry.user_id == user_id
    print("Extracted entry: %v", [entry.user_id])
    entry.vehicle_id == input.vehicle_id
    print("Extracted entry: %v", [entry.vehicle_id])
}
allow {
    # get_user_by_user_id[user_id]
    user_id := decrypt.user_id
    get_primary_owner_info_by_user_id[user_id]
}