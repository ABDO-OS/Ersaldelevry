import '../../core/utils/result.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Result<UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Result<UserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  });

  Future<Result<void>> signOut();

  Future<Result<UserEntity?>> getCurrentUser();

  Stream<UserEntity?> get authStateChanges;

  Future<Result<void>> resetPassword(String email);
}
