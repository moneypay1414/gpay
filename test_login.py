import requests
import json

BASE_URL = "http://localhost:5000/api"

# Test 1: Register a test user
print("=" * 50)
print("TEST 1: User Registration")
print("=" * 50)

register_payload = {
    "name": "Test User",
    "email": "test@example.com",
    "phone": "08012345678",
    "password": "TestPassword123",
    "role": "user"
}

try:
    response = requests.post(f"{BASE_URL}/auth/register", json=register_payload)
    print(f"Status Code: {response.status_code}")
    print(f"Response: {json.dumps(response.json(), indent=2)}")
    register_result = response.json()
except Exception as e:
    print(f"Error: {e}")
    register_result = None

# Test 2: Verify phone (skip actual SMS, use test code)
print("\n" + "=" * 50)
print("TEST 2: Phone Verification")
print("=" * 50)

if register_result and 'userId' in register_result:
    # Get the verification code from the user record
    # For testing, we'll need to check the database or mock the code
    verify_payload = {
        "phone": "08012345678",
        "code": "000000"  # This will fail, but shows the flow
    }
    
    try:
        response = requests.post(f"{BASE_URL}/auth/verify-phone", json=verify_payload)
        print(f"Status Code: {response.status_code}")
        print(f"Response: {json.dumps(response.json(), indent=2)}")
    except Exception as e:
        print(f"Error: {e}")

# Test 3: Login
print("\n" + "=" * 50)
print("TEST 3: User Login")
print("=" * 50)

login_payload = {
    "email": "test@example.com",
    "password": "TestPassword123"
}

try:
    response = requests.post(f"{BASE_URL}/auth/login", json=login_payload)
    print(f"Status Code: {response.status_code}")
    print(f"Response: {json.dumps(response.json(), indent=2)}")
    
    if response.status_code == 200:
        login_data = response.json()
        token = login_data.get('token')
        print(f"\n✅ Login successful!")
        print(f"Token: {token[:50]}..." if token else "No token")
        
        # Test 4: Get profile with token
        print("\n" + "=" * 50)
        print("TEST 4: Get Profile with Token")
        print("=" * 50)
        
        headers = {"Authorization": f"Bearer {token}"}
        response = requests.get(f"{BASE_URL}/auth/profile", headers=headers)
        print(f"Status Code: {response.status_code}")
        print(f"Response: {json.dumps(response.json(), indent=2)}")
    else:
        print(f"❌ Login failed with status {response.status_code}")
        
except Exception as e:
    print(f"Error: {e}")

print("\n" + "=" * 50)
print("LOGIN TEST COMPLETE")
print("=" * 50)
