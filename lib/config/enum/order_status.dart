import 'package:flutter/material.dart';

enum OrderStatus {
  pending,
  preparing,
  delivering,
  delivered,
  cancelled,
  unknown,
}

String buildOrderStatusText(String status) {
  OrderStatus orderStatus = getOrderStatusFromString(status);
  // Use a switch statement to map the string status to the corresponding enum value
  switch (orderStatus) {
    case OrderStatus.pending:
      return "Pending";
    case OrderStatus.preparing:
      return "Preparing";
    case OrderStatus.delivering:
      return "Delivering";
    case OrderStatus.delivered:
      return 'Delivered';
    case OrderStatus.cancelled:
      return 'Cancelled';
    default:
      return 'Unknown Status';
  }
}

OrderStatus getOrderStatusFromString(String status) {
  switch (status) {
    case 'pending':
      return OrderStatus.pending;
    case 'preparing':
      return OrderStatus.preparing;
    case 'delivering':
      return OrderStatus.delivering;
    case 'delivered':
      return OrderStatus.delivered;
    case 'cancelled':
      return OrderStatus.cancelled;
    default:
      return OrderStatus
          .unknown; // Assuming you have an 'unknown' status in your enum
  }
}

Color getOrderStatusColor(String status) {
  OrderStatus orderStatus = getOrderStatusFromString(status);
  switch (orderStatus) {
    case OrderStatus.pending:
      return Colors.grey;
    // return const Color.fromARGB(80, 158, 158, 158);
    case OrderStatus.preparing:
    case OrderStatus.delivering:
      return Colors.orange;
    case OrderStatus.delivered:
      return Colors.green;
    case OrderStatus.cancelled:
      return Colors.red;
    default:
      return Colors.grey;
  }
}
