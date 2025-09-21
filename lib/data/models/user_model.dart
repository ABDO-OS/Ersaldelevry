import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final DateTime? createdAt;
  final DateTime? lastLoginAt;
  final bool isEmailVerified;

  const UserModel({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.createdAt,
    this.lastLoginAt,
    this.isEmailVerified = false,
  });

  factory UserModel.fromFirebaseUser(dynamic user) {
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoUrl: user.photoURL,
      createdAt: user.metadata.creationTime,
      lastLoginAt: user.metadata.lastSignInTime,
      isEmailVerified: user.emailVerified,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.parse(json['lastLoginAt'] as String)
          : null,
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'createdAt': createdAt?.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'isEmailVerified': isEmailVerified,
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    bool? isEmailVerified,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        displayName,
        photoUrl,
        createdAt,
        lastLoginAt,
        isEmailVerified,
      ];

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
      createdAt: createdAt,
      lastLoginAt: lastLoginAt,
      isEmailVerified: isEmailVerified,
    );
  }
}
