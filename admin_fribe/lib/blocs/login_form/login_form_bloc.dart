import 'package:admin_fribe/blocs/login_form/validator/email_validator.dart';
import 'package:admin_fribe/blocs/login_form/validator/password_validator.dart';
import 'package:admin_fribe/blocs/login_form/validator/username_validator.dart';
import 'package:admin_fribe/services/auth/auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

final class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final IAuthService _authService;
  LoginFormBloc({required IAuthService authService})
    : _authService = authService,
      super(LoginFormState.initial()) {
    on<LoginFormEmailChanged>(_onEmailChanged);
    on<LoginFormPasswordChanged>(_onPasswordChanged);
    on<LoginFormSubmitted>(_onSubmitted);
  }

  void _onEmailChanged(
    LoginFormEmailChanged event,
    Emitter<LoginFormState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: () => email,
        isValid: () => Formz.validate([email, state.password]),
      ),
    );
  }

  void _onPasswordChanged(
    LoginFormPasswordChanged event,
    Emitter<LoginFormState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: () => password,
        isValid: () => Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> _onSubmitted(
    LoginFormSubmitted event,
    Emitter<LoginFormState> emit,
  ) async {
    if (!state.isValid) return;
    emit(
      state.copyWith(
        status: () => FormzSubmissionStatus.inProgress,
        isLoading: () => true,
      ),
    );
    try {
      await _authService.signIn(
        email: state.email.value,
        password: state.password.value,
      );
      emit(
        state.copyWith(
          status: () => FormzSubmissionStatus.success,
          isLoading: () => false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: () => FormzSubmissionStatus.failure,
          isLoading: () => false,
        ),
      );
    }
  }
}
