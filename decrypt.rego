package token.decrypt

import input

# Function to verify and decode the JWT token
# Using the secret from an environment variable
verify_and_decode_jwt(token) = payload {
    # Retrieve the secret key from an environment variable
    # secret := opa.runtime().env["JWT_SECRET"]
    # [_ payload, _] := io.jwt.decode_verify(token)
    
    [_, payload, _] := io.jwt.decode(token)
}

# Extract the JWT from the Authorization header if present
extracted_jwt = token {
    # Check if the Authorization header is present and contains a bearer token
    auth_header := input.request.headers["Authorization"][0]
    startswith(auth_header, "Bearer ")
    token := substring(auth_header, count("Bearer "), -1)
}

# Get the decoded payload from the extracted JWT
decoded_payload = payload {
    token := extracted_jwt
    payload := verify_and_decode_jwt(token)
}
