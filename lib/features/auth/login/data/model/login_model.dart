import 'package:mobile/features/auth/login/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    required super.campus,
    required super.department,
    required super.subscription,
    super.subscriptionExpires,
    super.chapaTransactionId,
    required super.paymentStatus,
    required super.walletBalance,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["_id"],
      name: json["name"],
      email: json["email"],
      role: json["role"],
      campus: json["campus"],
      department: json["department"],
      subscription: json["subscription"],
      subscriptionExpires: json["subscriptionExpires"] != null
          ? DateTime.tryParse(json["subscriptionExpires"])
          : null,
      chapaTransactionId: json["chapaTransactionId"],
      paymentStatus: json["paymentStatus"],
      walletBalance: (json["walletBalance"] ?? 0).toDouble(),
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "email": email,
      "role": role,
      "campus": campus,
      "department": department,
      "subscription": subscription,
      "subscriptionExpires": subscriptionExpires?.toIso8601String(),
      "chapaTransactionId": chapaTransactionId,
      "paymentStatus": paymentStatus,
      "walletBalance": walletBalance,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }
}
