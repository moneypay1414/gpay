import requests
import json

BASE_URL = "http://localhost:5000/api"

# Test Admin Login
print("=" * 50)
print("TEST: Admin Login")
print("=" * 50)

admin_payload = {
    "email": "admin@moneypay.com",
    "password": "admin123"
}

try:
    response = requests.post(f"{BASE_URL}/auth/login", json=admin_payload)
    print(f"Status Code: {response.status_code}")
    print(f"Response: {json.dumps(response.json(), indent=2)}")
    
    if response.status_code == 200:
        login_data = response.json()
        token = login_data.get('token')
        user = login_data.get('user', {})
        
        print(f"\n✅ Admin Login successful!")
        print(f"Role: {user.get('role')}")
        print(f"Name: {user.get('name')}")
        print(f"Email: {user.get('email')}")
        print(f"Token: {token[:50]}..." if token else "No token")
        
        # Test get admin info
        print("\n" + "=" * 50)
        print("TEST: Get Admin Profile")
        print("=" * 50)
        
        headers = {"Authorization": f"Bearer {token}"}
        response = requests.get(f"{BASE_URL}/auth/profile", headers=headers)
        print(f"Status Code: {response.status_code}")
        profile = response.json()
        print(f"Admin ID: {profile.get('adminId')}")
        print(f"Admin Location Consent: {profile.get('adminLocationConsent')}")
        
    else:
        print(f"❌ Login failed")
        print(f"Message: {response.json().get('message')}")
        
except Exception as e:
    print(f"Error: {e}")

print("\n" + "=" * 50)
print("ADMIN LOGIN TEST COMPLETE")
print("=" * 50)
