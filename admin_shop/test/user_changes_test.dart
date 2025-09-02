import 'package:admin_shop/blocs/auth/auth_bloc.dart';
import 'package:admin_shop/models/user_model.dart';
import 'package:admin_shop/services/auth/iauth_service.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements IAuthService {}

void main() {
  late AuthBloc authBloc;
  late MockAuthService mockAuthService;
  final mockUser = UserModel.empty().copyWith(
    id: () => '123',
    email: () => 'test@example.com',
    name: () => 'Test User',
  );

  setUp(() {
    mockAuthService = MockAuthService();
    authBloc = AuthBloc(mockAuthService);
  });

  tearDown(() {
    authBloc.close();
  });

  test('initial state is AuthState.initial()', () {
    expect(authBloc.state, AuthState.initial());
  });

  blocTest<AuthBloc, AuthState>(
    'emits success when userChanges emits a UserModel',
    build: () {
      when(
        () => mockAuthService.userChanges,
      ).thenAnswer((_) => Stream.value(mockUser));

      return authBloc;
    },
    act: (bloc) => bloc.add(UserChangesRequested()),
    expect: () => [AuthState.success(user: mockUser)],
  );

  blocTest<AuthBloc, AuthState>(
    'emits initial when userChanges emits null',
    build: () {
      when(
        () => mockAuthService.userChanges,
      ).thenAnswer((_) => Stream.value(null));
      return authBloc;
    },
    act: (bloc) => bloc.add(UserChangesRequested()),
    expect: () => [AuthState.initial()],
  );

  blocTest<AuthBloc, AuthState>(
    'emits failure when userChanges throws',
    build: () {
      when(
        () => mockAuthService.userChanges,
      ).thenAnswer((_) => Stream<UserModel?>.error('error'));
      return authBloc;
    },
    act: (bloc) => bloc.add(UserChangesRequested()),
    expect: () => [AuthState.failure(errorMessage: 'error')],
  );

  group('AuthBloc - SignInRequested', () {
    blocTest<AuthBloc, AuthState>(
      'emits [waiting, success] when signIn succeeds',
      build: () {
        when(
          () => mockAuthService.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => mockUser);
        return authBloc;
      },
      act: (bloc) => bloc.add(
        SignInRequested(email: 'test@example.com', password: '123456'),
      ),
      expect: () => [
        authBloc.state.copyWith(
          status: () => AuthStatus.waiting,
          errorMessage: () => null,
        ),
        authBloc.state.copyWith(status: () => AuthStatus.success),
      ],
      verify: (_) {
        verify(
          () => mockAuthService.signIn(
            email: 'test@example.com',
            password: '123456',
          ),
        ).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [waiting, failure] when signIn fails',
      build: () {
        when(
          () => mockAuthService.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(
          FirebaseAuthException(
            code: 'user-not-found',
            message: 'User not found',
          ),
        );
        return authBloc;
      },
      act: (bloc) => bloc.add(
        SignInRequested(email: 'wrong@example.com', password: '123456'),
      ),
      expect: () => [
        authBloc.state.copyWith(
          status: () => AuthStatus.waiting,
          errorMessage: () => null,
        ),
        authBloc.state.copyWith(
          status: () => AuthStatus.failure,
          errorMessage: () => 'User not found',
        ),
      ],
    );
  });
}
