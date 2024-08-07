package token.decrypt

# Function to verify and decode the JWT token
verify_and_decode_jwt(token) = payload {
    # Decode the token to get the payload
    [_, payload, _] := io.jwt.decode(token)
}

# Get the decoded payload from the input token
decoded_payload = payload {
    token := input.token
    payload := verify_and_decode_jwt(token)
}

# Extract user_id from the decoded payload
user_id = id {
    payload := decoded_payload
    id := payload.user_id
    print("Decoded id: ", id)
}
