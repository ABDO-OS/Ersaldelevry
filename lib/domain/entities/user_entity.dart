import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final DateTime? createdAt;
  final DateTime? lastLoginAt;
  final bool isEmailVerified;

  const UserEntity({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.createdAt,
    this.lastLoginAt,
    this.isEmailVerified = false,
  });

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
}
