import { Routes, Route, Navigate } from 'react-router-dom';
import { useAuthStore } from './context/store';
import './styles/globals.css';

// Auth Pages
import Login from './pages/Login';
import Register from './pages/Register';

// User Pages
import UserLayout from './components/UserLayout';
import UserDashboard from './pages/UserDashboard';
import SendMoney from './pages/SendMoney';
import Withdraw from './pages/Withdraw';
import Transactions from './pages/Transactions';
import Notifications from './pages/Notifications';

// Admin Pages
import AdminLayout from './components/AdminLayout';
import AdminDashboard from './pages/AdminDashboard';
import AdminUsers from './pages/AdminUsers';
import AdminTransactions from './pages/AdminTransactions';
import AdminNotifications from './pages/AdminNotifications';

function ProtectedRoute({ children, requiredRole }) {
  const user = useAuthStore((state) => state.user);
  const isAuthenticated = useAuthStore((state) => state.isAuthenticated);

  if (!isAuthenticated) {
    return <Navigate to="/login" />;
  }

  if (requiredRole && !requiredRole.includes(user?.role)) {
    return <Navigate to="/login" />;
  }

  return children;
}

export default function App() {
  return (
    <Routes>
      {/* Public Routes */}
      <Route path="/login" element={<Login />} />
      <Route path="/register" element={<Register />} />

      {/* User Routes */}
      <Route
        path="/user/*"
        element={
          <ProtectedRoute requiredRole={['user', 'agent', 'admin']}>
            <UserLayout />
          </ProtectedRoute>
        }
      >
        <Route path="dashboard" element={<UserDashboard />} />
        <Route path="send-money" element={<SendMoney />} />
        <Route path="withdraw" element={<Withdraw />} />
        <Route path="transactions" element={<Transactions />} />
        <Route path="notifications" element={<Notifications />} />
      </Route>

      {/* Admin Routes */}
      <Route
        path="/admin/*"
        element={
          <ProtectedRoute requiredRole={['admin']}>
            <AdminLayout />
          </ProtectedRoute>
        }
      >
        <Route path="dashboard" element={<AdminDashboard />} />
        <Route path="users" element={<AdminUsers />} />
        <Route path="transactions" element={<AdminTransactions />} />
        <Route path="notifications" element={<AdminNotifications />} />
      </Route>

      {/* Default redirect */}
      <Route path="/" element={<Navigate to="/login" />} />
      <Route path="*" element={<Navigate to="/login" />} />
    </Routes>
  );
}
