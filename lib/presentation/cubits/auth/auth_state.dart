part of 'auth_cubit.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  passwordResetSent,
  error,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final UserEntity? user;
  final String? errorMessage;

  const AuthState({
    required this.status,
    this.user,
    this.errorMessage,
  });

  const AuthState.initial()
      : status = AuthStatus.initial,
        user = null,
        errorMessage = null;

  AuthState copyWith({
    AuthStatus? status,
    UserEntity? user,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }

  bool get isAuthenticated =>
      status == AuthStatus.authenticated && user != null;
  bool get isLoading => status == AuthStatus.loading;
  bool get hasError => status == AuthStatus.error && errorMessage != null;

  @override
  List<Object?> get props => [status, user, errorMessage];
}
