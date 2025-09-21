import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/utils/result.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const AuthState.initial());

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _authRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    result.when(
      success: (user) {
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          errorMessage: null,
        ));
      },
      error: (failure) {
        emit(state.copyWith(
          status: AuthStatus.unauthenticated,
          user: null,
          errorMessage: failure.message,
        ));
      },
    );
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _authRepository.signUpWithEmailAndPassword(
      email: email,
      password: password,
      displayName: displayName,
    );

    result.when(
      success: (user) {
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          errorMessage: null,
        ));
      },
      error: (failure) {
        emit(state.copyWith(
          status: AuthStatus.unauthenticated,
          user: null,
          errorMessage: failure.message,
        ));
      },
    );
  }

  Future<void> signOut() async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _authRepository.signOut();

    result.when(
      success: (_) {
        emit(state.copyWith(
          status: AuthStatus.unauthenticated,
          user: null,
          errorMessage: null,
        ));
      },
      error: (failure) {
        emit(state.copyWith(
          status: AuthStatus.error,
          errorMessage: failure.message,
        ));
      },
    );
  }

  Future<void> getCurrentUser() async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _authRepository.getCurrentUser();

    result.when(
      success: (user) {
        if (user != null) {
          emit(state.copyWith(
            status: AuthStatus.authenticated,
            user: user,
            errorMessage: null,
          ));
        } else {
          emit(state.copyWith(
            status: AuthStatus.unauthenticated,
            user: null,
            errorMessage: null,
          ));
        }
      },
      error: (failure) {
        emit(state.copyWith(
          status: AuthStatus.error,
          errorMessage: failure.message,
        ));
      },
    );
  }

  Future<void> resetPassword(String email) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _authRepository.resetPassword(email);

    result.when(
      success: (_) {
        emit(state.copyWith(
          status: AuthStatus.passwordResetSent,
          errorMessage: null,
        ));
      },
      error: (failure) {
        emit(state.copyWith(
          status: AuthStatus.error,
          errorMessage: failure.message,
        ));
      },
    );
  }

  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }

  void listenToAuthChanges() {
    _authRepository.authStateChanges.listen((user) {
      if (user != null) {
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          errorMessage: null,
        ));
      } else {
        emit(state.copyWith(
          status: AuthStatus.unauthenticated,
          user: null,
          errorMessage: null,
        ));
      }
    });
  }
}
