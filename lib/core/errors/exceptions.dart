import 'package:firebase_auth/firebase_auth.dart';

class ServerException implements Exception {
  final String message;
  final String? code;

  const ServerException({
    required this.message,
    this.code,
  });
}

class NetworkException implements Exception {
  final String message;

  const NetworkException({required this.message});
}

class AuthException implements Exception {
  final String message;
  final String? code;

  const AuthException({
    required this.message,
    this.code,
  });
}

class ValidationException implements Exception {
  final String message;

  const ValidationException({required this.message});
}

class CacheException implements Exception {
  final String message;

  const CacheException({required this.message});
}

class LocationException implements Exception {
  final String message;

  const LocationException({required this.message});
}

// Firebase Auth Exception Extensions
extension FirebaseAuthExceptionExtension on FirebaseAuthException {
  AuthException toAuthException() {
    String message;
    switch (code) {
      case 'user-not-found':
        message = 'المستخدم غير موجود';
        break;
      case 'wrong-password':
        message = 'كلمة المرور خاطئة';
        break;
      case 'email-already-in-use':
        message = 'البريد الإلكتروني مستخدم بالفعل';
        break;
      case 'weak-password':
        message = 'كلمة المرور ضعيفة';
        break;
      case 'invalid-email':
        message = 'البريد الإلكتروني غير صحيح';
        break;
      case 'user-disabled':
        message = 'تم تعطيل هذا الحساب';
        break;
      case 'too-many-requests':
        message = 'تم تجاوز عدد المحاولات المسموح';
        break;
      case 'operation-not-allowed':
        message = 'العملية غير مسموحة';
        break;
      default:
        message = 'حدث خطأ في المصادقة';
    }

    return AuthException(
      message: message,
      code: code,
    );
  }
}
