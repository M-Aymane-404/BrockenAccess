<?php
/**
 * RBAC Demo API Endpoints
 * 
 * This file provides 7 demo endpoints for testing Role-Based Access Control
 * Each endpoint demonstrates different authorization scenarios:
 * - Public access (no auth required)
 * - Basic user access (any authenticated user)
 * - Role-based access (specific roles required)
 * 
 * HTTP Responses:
 * - 200 OK: Successful access with proper authentication and role
 * - 401 Unauthorized: No authentication token provided
 * - 403 Forbidden: Authentication present but insufficient role
 */

require_once 'db.php';
require_once 'utils.php';

header('Content-Type: application/json');

// Demo endpoints for testing RBAC system
// These endpoints simulate different permission requirements

try {
    $pdo = getDB();
    
    // Get the endpoint name from URL parameter
    $endpoint = $_GET['endpoint'] ?? '';
    $method = $_SERVER['REQUEST_METHOD'];
    
    // Check for no_token flag for testing 401 responses
    $noToken = isset($_GET['no_token']) && $_GET['no_token'] === 'true';
    
    // Debug logging
    error_log("Endpoint: " . $endpoint);
    error_log("No token flag: " . ($noToken ? 'true' : 'false'));
    error_log("GET params: " . json_encode($_GET));
    
    // Authenticate user (optional for some endpoints to test 401)
    $session = null;
    $currentUserId = null;
    $currentUserRole = null;
    
    // For endpoints that require authentication
    if ($endpoint !== 'public' && !$noToken) {
        try {
            $session = authenticateUser($pdo);
            $currentUserId = $session['user_id'];
            $currentUserRole = $session['role_name'];
        } catch (Exception $e) {
            // Return 401 for endpoints that require auth
            sendJson(['error' => 'Authentication required', 'endpoint' => $endpoint], 401);
        }
    } elseif ($endpoint !== 'public' && $noToken) {
        // no_token=true: skip authentication to trigger 401
        error_log("Returning 401 for no_token request");
        sendJson(['error' => 'Authentication required - NO TOKEN', 'endpoint' => $endpoint, 'debug' => 'no_token flag used'], 401);
    }
    
    switch ($endpoint) {
        case 'public':
            handlePublicEndpoint();
            break;
        case 'user_basic':
            handleUserBasicEndpoint($pdo, $currentUserId, $currentUserRole);
            break;
        case 'admin_only':
            handleAdminOnlyEndpoint($pdo, $currentUserId, $currentUserRole);
            break;
        case 'clinician_only':
            handleClinicianOnlyEndpoint($pdo, $currentUserId, $currentUserRole);
            break;
        case 'receptionist_only':
            handleReceptionistOnlyEndpoint($pdo, $currentUserId, $currentUserRole);
            break;
        case 'nurse_only':
            handleNurseOnlyEndpoint($pdo, $currentUserId, $currentUserRole);
            break;
        case 'multi_role':
            handleMultiRoleEndpoint($pdo, $currentUserId, $currentUserRole);
            break;
        default:
            sendJson(['error' => 'Endpoint not found'], 404);
    }
    
} catch (Exception $e) {
    sendJson(['error' => 'Internal server error'], 500);
}

function handlePublicEndpoint() {
    sendJson([
        'success' => true,
        'message' => 'Public endpoint accessed successfully',
        'endpoint' => 'public',
        'data' => [
            'system_status' => 'operational',
            'access_level' => 'public',
            'timestamp' => date('Y-m-d H:i:s')
        ],
        'style' => 'success',
        'color' => '#28a745'
    ]);
}

function handleUserBasicEndpoint($pdo, $currentUserId, $currentUserRole) {
    // Requires basic user permissions (any authenticated user)
    if (!authorize($pdo, $currentUserId, 'appointments:read')) {
        sendJson([
            'success' => false,
            'error' => 'Forbidden: Basic user access required',
            'endpoint' => 'user_basic',
            'required_permission' => 'appointments:read',
            'current_role' => $currentUserRole,
            'style' => 'error',
            'color' => '#dc3545'
        ], 403);
    }
    
    sendJson([
        'success' => true,
        'message' => 'Basic user endpoint accessed successfully',
        'endpoint' => 'user_basic',
        'user_id' => $currentUserId,
        'role' => $currentUserRole,
        'permissions' => ['appointments:read'],
        'style' => 'success',
        'color' => '#28a745'
    ]);
}

function handleAdminOnlyEndpoint($pdo, $currentUserId, $currentUserRole) {
    // Requires admin role
    if ($currentUserRole !== 'admin') {
        sendJson([
            'success' => false,
            'error' => 'Forbidden: Admin access required',
            'endpoint' => 'admin_only',
            'required_role' => 'admin',
            'current_role' => $currentUserRole,
            'style' => 'error',
            'color' => '#dc3545'
        ], 403);
    }
    
    sendJson([
        'success' => true,
        'message' => 'Admin endpoint accessed successfully',
        'endpoint' => 'admin_only',
        'user_id' => $currentUserId,
        'role' => $currentUserRole,
        'permissions' => ['admin'],
        'style' => 'success',
        'color' => '#28a745'
    ]);
}

function handleClinicianOnlyEndpoint($pdo, $currentUserId, $currentUserRole) {
    // Requires clinician role or admin
    if (!in_array($currentUserRole, ['clinician', 'admin'])) {
        sendJson([
            'success' => false,
            'error' => 'Forbidden: Clinician access required',
            'endpoint' => 'clinician_only',
            'required_role' => 'clinician or admin',
            'current_role' => $currentUserRole,
            'style' => 'error',
            'color' => '#dc3545'
        ], 403);
    }
    
    // Get clinician-specific data
    $clinicianData = [];
    if ($currentUserRole === 'clinician') {
        $stmt = $pdo->prepare("
            SELECT COUNT(*) as my_appointments 
            FROM appointments 
            WHERE clinician_id = ?
        ");
        $stmt->execute([$currentUserId]);
        $clinicianData['my_appointments'] = $stmt->fetch()['my_appointments'];
    }
    
    sendJson([
        'success' => true,
        'message' => 'Clinician endpoint accessed successfully',
        'endpoint' => 'clinician_only',
        'user_id' => $currentUserId,
        'role' => $currentUserRole,
        'clinician_data' => $clinicianData,
        'style' => 'success',
        'color' => '#17a2b8'
    ]);
}

function handleReceptionistOnlyEndpoint($pdo, $currentUserId, $currentUserRole) {
    // Requires receptionist role or admin
    if (!in_array($currentUserRole, ['receptionist', 'admin'])) {
        sendJson([
            'success' => false,
            'error' => 'Forbidden: Receptionist access required',
            'endpoint' => 'receptionist_only',
            'required_role' => 'receptionist or admin',
            'current_role' => $currentUserRole,
            'style' => 'error',
            'color' => '#dc3545'
        ], 403);
    }
    
    sendJson([
        'success' => true,
        'message' => 'Receptionist endpoint accessed successfully',
        'endpoint' => 'receptionist_only',
        'user_id' => $currentUserId,
        'role' => $currentUserRole,
        'receptionist_data' => [
            'today_appointments' => getTodayAppointments($pdo),
            'pending_confirmations' => getPendingConfirmations($pdo)
        ],
        'style' => 'success',
        'color' => '#ffc107'
    ]);
}

function handleNurseOnlyEndpoint($pdo, $currentUserId, $currentUserRole) {
    // Requires nurse role or admin
    if (!in_array($currentUserRole, ['nurse', 'admin'])) {
        sendJson([
            'success' => false,
            'error' => 'Forbidden: Nurse access required',
            'endpoint' => 'nurse_only',
            'required_role' => 'nurse or admin',
            'current_role' => $currentUserRole,
            'style' => 'error',
            'color' => '#dc3545'
        ], 403);
    }
    
    sendJson([
        'success' => true,
        'message' => 'Nurse endpoint accessed successfully',
        'endpoint' => 'nurse_only',
        'user_id' => $currentUserId,
        'role' => $currentUserRole,
        'nurse_data' => [
            'patient_count' => getPatientCount($pdo),
            'medication_alerts' => getMedicationAlerts($pdo)
        ],
        'style' => 'success',
        'color' => '#17a2b8'
    ]);
}

function handleMultiRoleEndpoint($pdo, $currentUserId, $currentUserRole) {
    // Allows multiple roles: admin, clinician, nurse
    $allowedRoles = ['admin', 'clinician', 'nurse'];
    
    if (!in_array($currentUserRole, $allowedRoles)) {
        sendJson([
            'success' => false,
            'error' => 'Forbidden: Clinical staff access required',
            'endpoint' => 'multi_role',
            'required_role' => 'admin, clinician, or nurse',
            'current_role' => $currentUserRole,
            'style' => 'error',
            'color' => '#dc3545'
        ], 403);
    }
    
    $roleSpecificData = [];
    switch ($currentUserRole) {
        case 'clinician':
            $stmt = $pdo->prepare("SELECT COUNT(*) as count FROM appointments WHERE clinician_id = ?");
            $stmt->execute([$currentUserId]);
            $roleSpecificData['my_appointments'] = $stmt->fetch()['count'];
            break;
        case 'nurse':
            $stmt = $pdo->prepare("SELECT COUNT(*) as count FROM patients");
            $stmt->execute();
            $roleSpecificData['total_patients'] = $stmt->fetch()['count'];
            break;
        case 'admin':
            $roleSpecificData['system_access'] = 'full';
            break;
    }
    
    sendJson([
        'success' => true,
        'message' => 'Multi-role endpoint accessed successfully',
        'endpoint' => 'multi_role',
        'user_id' => $currentUserId,
        'role' => $currentUserRole,
        'allowed_roles' => $allowedRoles,
        'role_specific_data' => $roleSpecificData,
        'style' => 'success',
        'color' => '#17a2b8'
    ]);
}

// Helper functions for demo data
function getTotalUsers($pdo) {
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM users");
    return $stmt->fetch()['count'];
}

function getTotalAppointments($pdo) {
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM appointments");
    return $stmt->fetch()['count'];
}

function getTodayAppointments($pdo) {
    $stmt = $pdo->prepare("SELECT COUNT(*) as count FROM appointments WHERE DATE(date_time) = CURDATE()");
    $stmt->execute();
    return $stmt->fetch()['count'];
}

function getPendingConfirmations($pdo) {
    $stmt = $pdo->prepare("SELECT COUNT(*) as count FROM appointments WHERE status = 'Scheduled'");
    $stmt->execute();
    return $stmt->fetch()['count'];
}

function getPatientCount($pdo) {
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM patients");
    return $stmt->fetch()['count'];
}

function getMedicationAlerts($pdo) {
    // Demo function - returns mock data
    return 3;
}
?>
