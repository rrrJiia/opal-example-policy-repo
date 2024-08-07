package token.decrypt_test

import data.token.decrypt

# Define a test for the verify_and_decode_jwt function
test_verify_and_decode_jwt {
    token := "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyLCJ1c2VyX2lkIjoiMDItYzVlZGFhN2ItOTRiNy00OGE5LWEwMTEtY2U5ZWI2ZjMzNmM5LTRmYTJmZWVhIn0.Rz7ztEfkBIbaIUy6dNQnXlvtVoQW5B0wKBXP3EveG3w"

    expected_payload := {
        "sub": "1234567890",
        "name": "John Doe",
        "iat": 1516239022,
        "user_id": "02-c5edaa7b-94b7-48a9-a011-ce9eb6f336c9-4fa2feea"
    }

    actual_payload := decrypt.verify_and_decode_jwt(token)

    # Assert that the payload matches the expected values
    actual_payload == expected_payload
}

# Define a test for extracting the decoded payload
test_decoded_payload {
    input := {"token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyLCJ1c2VyX2lkIjoiMDItYzVlZGFhN2ItOTRiNy00OGE5LWEwMTEtY2U5ZWI2ZjMzNmM5LTRmYTJmZWVhIn0.Rz7ztEfkBIbaIUy6dNQnXlvtVoQW5B0wKBXP3EveG3w"}

    expected_payload := {
        "sub": "1234567890",
        "name": "John Doe",
        "iat": 1516239022,
        "user_id": "02-c5edaa7b-94b7-48a9-a011-ce9eb6f336c9-4fa2feea"
    }

    actual_payload := decrypt.decoded_payload with input as input

    # Assert that the decoded payload matches the expected values
    actual_payload == expected_payload
}

# Define a test for extracting user_id
test_user_id_extraction {
    input := {"token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyLCJ1c2VyX2lkIjoiMDItYzVlZGFhN2ItOTRiNy00OGE5LWEwMTEtY2U5ZWI2ZjMzNmM5LTRmYTJmZWVhIn0.Rz7ztEfkBIbaIUy6dNQnXlvtVoQW5B0wKBXP3EveG3w"}

    expected_user_id := "02-c5edaa7b-94b7-48a9-a011-ce9eb6f336c9-4fa2feea"

    actual_user_id := decrypt.user_id with input as input

    # Assert that the extracted user_id matches the expected value
    actual_user_id == expected_user_id
}
