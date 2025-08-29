import 'package:mobile/features/auth/signup/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String id,
    required String name,
    required String email,
    required String role,
    String? campus,
    String? department,
    required String subscription,
    DateTime? subscriptionExpires,
    String? chapaTransactionId,
    required String paymentStatus,
    required double walletBalance,
  }) : super(
         id: id,
         name: name,
         email: email,
         role: role,
         campus: campus,
         department: department,
         subscription: subscription,
         subscriptionExpires: subscriptionExpires,
         chapaTransactionId: chapaTransactionId,
         paymentStatus: paymentStatus,
         walletBalance: walletBalance,
       );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? 'user',
      campus: json['campus'],
      department: json['department'],
      subscription: json['subscription'] ?? 'free',
      subscriptionExpires: json['subscriptionExpires'] != null
          ? DateTime.parse(json['subscriptionExpires'])
          : null,
      chapaTransactionId: json['chapaTransactionId'],
      paymentStatus: json['paymentStatus'] ?? 'pending',
      walletBalance: (json['walletBalance'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'campus': campus,
      'department': department,
      'subscription': subscription,
      'subscriptionExpires': subscriptionExpires?.toIso8601String(),
      'chapaTransactionId': chapaTransactionId,
      'paymentStatus': paymentStatus,
      'walletBalance': walletBalance,
    };
  }
}
