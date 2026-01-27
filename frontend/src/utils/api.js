import axios from 'axios';

const API_BASE = import.meta.env.VITE_API_URL || 'http://ssswwkk4gso4ooog0scw4g8o.127.0.0.1.sslip.io';

//axios.defaults.baseURL = '/api'
const api = axios.create({
  baseURL: API_BASE,
  headers: {
    'Content-Type': 'application/json'
  }
});

// Add token to requests
api.interceptors.request.use((config) => {
  const token = localStorage.getItem('token');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

export const authAPI = {
  register: (data) => api.post('/api/auth/register', data),
  verifyPhone: (data) => api.post('/api/auth/verify-phone', data),
  login: (data) => api.post('/api/auth/login', data),
  getProfile: () => api.get('/api/auth/profile'),
  updateProfile: (data) => api.put('/api/auth/profile', data)
};

export const transactionAPI = {
  sendMoney: (data) => api.post('/api/transactions/send-money', data),
  withdraw: (data) => api.post('/api/transactions/withdraw', data),
  getTransactions: () => api.get('/api/transactions/transactions'),
  getStats: () => api.get('/api/transactions/stats'),
  getUserInfo: (phoneNumber) => api.get(`/api/transactions/user-info/${phoneNumber}`)
};

export const adminAPI = {
  topupUser: (data) => api.post('/api/admin/topup-user', data),
  withdrawFromUser: (data) => api.post('/api/admin/withdraw-from-user', data),
  pushMoney: (data) => api.post('/api/admin/push-money', data),
  requestAgentWithdrawal: (data) => api.post('/api/admin/request-agent-withdrawal', data),
  getCommission: () => api.get('/api/admin/commission'),
  setCommission: (data) => api.post('/api/admin/commission', data),
  getTieredCommission: () => api.get('/api/admin/tiered-commission'),
  setTieredCommission: (data) => api.post('/api/admin/tiered-commission', data),
  getStateSettings: () => api.get('/api/admin/state-settings'),
  createStateSetting: (data) => api.post('/api/admin/state-settings', data),
  updateStateSetting: (id, data) => api.put(`/api/admin/state-settings/${id}`, data),
  deleteStateSetting: (id) => api.delete(`/api/admin/state-settings/${id}`),
  adminSendState: (data) => api.post('/api/admin/send-state', data),
  // currencies
  getCurrencies: () => api.get('/api/admin/currencies'),
  createCurrency: (data) => api.post('/api/admin/currencies', data),
  updateCurrency: (id, data) => api.put(`/api/admin/currencies/${id}`, data),
  deleteCurrency: (id) => api.delete(`/api/admin/currencies/${id}`),
  // (pairwise exchange-rate endpoints removed)
  // pairwise exchange-rates
  getExchangeRates: (params) => api.get('/api/admin/exchange-rates', { params }),
  createExchangeRate: (data) => api.post('/api/admin/exchange-rates', data),
  updateExchangeRate: (id, data) => api.put(`/api/admin/exchange-rates/${id}`, data),
  deleteExchangeRate: (id) => api.delete(`/api/admin/exchange-rates/${id}`),
  getPendingStateSends: () => api.get('/api/admin/send-state/pending'),
  getPendingStateSendsCount: () => api.get('/api/admin/send-state/pending/count'),
  receiveStateSend: (id) => api.post(`/api/admin/send-state/${id}/receive`),
  cancelStateSend: (id) => api.post(`/api/admin/send-state/${id}/cancel`),
  getMyAdminCashedOut: () => api.get('/api/admin/stats/my-cashed-out'),
  getMyAdminCommission: () => api.get('/api/admin/stats/my-commission'),
  getAllUsers: () => api.get('/api/admin/users'),
  getAllTransactions: () => api.get('/api/admin/transactions'),
  suspendUser: (data) => api.post('/api/admin/suspend-user', data),
  unsuspendUser: (data) => api.post('/api/admin/unsuspend-user', data),
  getStats: () => api.get('/api/admin/stats'),
  grantLocationPermissionToAll: () => api.post('/api/admin/grant-location'),
  createTransaction: (data) => api.post('/api/admin/money-exchange', data)
};

export const notificationAPI = {
  getNotifications: () => api.get('/api/notifications'),
  markAsRead: (data) => api.post('/api/notifications/mark-as-read', data),
  markAllAsRead: () => api.post('/api/notifications/mark-all-as-read'),
  sendToAll: (data) => api.post('/api/notifications/send-to-all', data),
  sendToUser: (data) => api.post('/api/notifications/send-to-user', data),
  delete: (id) => api.delete(`/api/notifications/${id}`)
};

export const withdrawalAPI = {
  requestWithdrawal: (data) => api.post('/api/withdrawals/request', data),
  approveRequest: (data) => api.post('/api/withdrawals/approve', data),
  rejectRequest: (data) => api.post('/api/withdrawals/reject', data),
  getPendingRequests: () => api.get('/api/withdrawals/pending'),
  approveAdminWithdrawalRequest: (data) => api.post('/api/admin/approve-withdrawal-request', data),
  rejectAdminWithdrawalRequest: (data) => api.post('/api/admin/reject-withdrawal-request', data),
  getAgentWithdrawalRequests: () => api.get('/api/admin/agent-withdrawal-requests')
};

export default api;
