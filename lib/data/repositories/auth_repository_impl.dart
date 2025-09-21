import '../../core/errors/failures.dart';
import '../../core/errors/exceptions.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  const AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Result<UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _remoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Success(user.toEntity());
    } on AuthException catch (e) {
      return Error(AuthFailure(message: e.message, code: e.code));
    } on ServerException catch (e) {
      return Error(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Error(NetworkFailure(message: e.message));
    } catch (e) {
      return Error(ServerFailure(message: 'حدث خطأ غير متوقع: ${e.toString()}'));
    }
  }

  @override
  Future<Result<UserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final user = await _remoteDataSource.signUpWithEmailAndPassword(
        email: email,
        password: password,
        displayName: displayName,
      );
      return Success(user.toEntity());
    } on AuthException catch (e) {
      return Error(AuthFailure(message: e.message, code: e.code));
    } on ServerException catch (e) {
      return Error(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Error(NetworkFailure(message: e.message));
    } catch (e) {
      return Error(ServerFailure(message: 'حدث خطأ غير متوقع: ${e.toString()}'));
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      await _remoteDataSource.signOut();
      return const Success(null);
    } on AuthException catch (e) {
      return Error(AuthFailure(message: e.message, code: e.code));
    } on ServerException catch (e) {
      return Error(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Error(ServerFailure(message: 'حدث خطأ غير متوقع: ${e.toString()}'));
    }
  }

  @override
  Future<Result<UserEntity?>> getCurrentUser() async {
    try {
      final user = await _remoteDataSource.getCurrentUser();
      return Success(user?.toEntity());
    } on AuthException catch (e) {
      return Error(AuthFailure(message: e.message, code: e.code));
    } on ServerException catch (e) {
      return Error(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Error(ServerFailure(message: 'حدث خطأ غير متوقع: ${e.toString()}'));
    }
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    return _remoteDataSource.authStateChanges.map((user) => user?.toEntity());
  }

  @override
  Future<Result<void>> resetPassword(String email) async {
    try {
      await _remoteDataSource.resetPassword(email);
      return const Success(null);
    } on AuthException catch (e) {
      return Error(AuthFailure(message: e.message, code: e.code));
    } on ServerException catch (e) {
      return Error(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Error(NetworkFailure(message: e.message));
    } catch (e) {
      return Error(ServerFailure(message: 'حدث خطأ غير متوقع: ${e.toString()}'));
    }
  }
}
