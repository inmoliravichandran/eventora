<?php
session_start();
require_once 'config.php';

if (!isset($_SESSION['user_id'])) {
    echo json_encode(['success' => false, 'message' => 'Please login first']);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    
    $user_id = $_SESSION['user_id'];
    $service_id = $data['service_id'] ?? 0;
    $event_date = $data['event_date'] ?? date('Y-m-d');
    $guests = $data['guests'] ?? 0;
    $total_price = $data['total_price'] ?? 0;
    
    $stmt = $pdo->prepare("INSERT INTO bookings (user_id, service_id, event_date, guests, total_price, status) VALUES (?, ?, ?, ?, ?, 'confirmed')");
    $stmt->execute([$user_id, $service_id, $event_date, $guests, $total_price]);
    
    // Clear cart after booking
    $stmt = $pdo->prepare("DELETE FROM cart WHERE user_id = ?");
    $stmt->execute([$user_id]);
    
    echo json_encode(['success' => true, 'message' => 'Booking confirmed', 'booking_id' => $pdo->lastInsertId()]);
}
?>