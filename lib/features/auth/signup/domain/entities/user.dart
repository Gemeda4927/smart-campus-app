class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? campus;
  final String? department;
  final String subscription;
  final DateTime? subscriptionExpires;
  final String? chapaTransactionId;
  final String paymentStatus;
  final double? walletBalance;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.campus,
    this.department,
    required this.subscription,
    this.subscriptionExpires,
    this.chapaTransactionId,
    required this.paymentStatus,
    required this.walletBalance,
  });
}
