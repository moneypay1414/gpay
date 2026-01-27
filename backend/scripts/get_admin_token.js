import fetch from 'node-fetch';

const url = 'http://ssswwkk4gso4ooog0scw4g8o.127.0.0.1.sslip.io/api/auth/login';
const body = {
  email: 'admin@moneypay.com',
  password: 'Admin@12345'
};

fetch(url, {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify(body)
})
  .then(res => res.json())
  .then(data => {
    if (data.token) {
      console.log('Bearer token:', data.token);
    } else {
      console.error('Failed to get token:', data);
    }
  })
  .catch(err => console.error('Error:', err));
