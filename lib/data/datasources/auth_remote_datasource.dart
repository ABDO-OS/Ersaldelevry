import 'package:firebase_auth/firebase_auth.dart';
import '../../core/errors/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  });

  Future<void> signOut();

  Future<UserModel?> getCurrentUser();

  Stream<UserModel?> get authStateChanges;

  Future<void> resetPassword(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  const AuthRemoteDataSourceImpl({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  @override
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw const AuthException(message: 'فشل في تسجيل الدخول');
      }

      return UserModel.fromFirebaseUser(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw e.toAuthException();
    } catch (e) {
      throw AuthException(message: 'حدث خطأ غير متوقع: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw const AuthException(message: 'فشل في إنشاء الحساب');
      }

      if (displayName != null) {
        await credential.user!.updateDisplayName(displayName);
      }

      return UserModel.fromFirebaseUser(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw e.toAuthException();
    } catch (e) {
      throw AuthException(message: 'حدث خطأ غير متوقع: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw AuthException(message: 'فشل في تسجيل الخروج: ${e.toString()}');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) return null;
      return UserModel.fromFirebaseUser(user);
    } catch (e) {
      throw AuthException(
          message: 'فشل في الحصول على المستخدم الحالي: ${e.toString()}');
    }
  }

  @override
  Stream<UserModel?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((user) {
      if (user == null) return null;
      return UserModel.fromFirebaseUser(user);
    });
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw e.toAuthException();
    } catch (e) {
      throw AuthException(
          message:
              'فشل في إرسال رابط إعادة تعيين كلمة المرور: ${e.toString()}');
    }
  }
}
