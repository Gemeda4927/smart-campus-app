// domain/entities/user_entity.dart
class UserEntity {
  final String id;
  final String name;
  final String email;
  final String role;
  final String campus;
  final String department;
  final String subscription;
  final DateTime? subscriptionExpires;
  final String? chapaTransactionId;
  final String paymentStatus;
  final double walletBalance;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.campus,
    required this.department,
    required this.subscription,
    this.subscriptionExpires,
    this.chapaTransactionId,
    required this.paymentStatus,
    required this.walletBalance,
    required this.createdAt,
    required this.updatedAt,
  });
}
