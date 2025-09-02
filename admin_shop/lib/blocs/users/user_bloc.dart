import 'dart:async';

import 'package:admin_shop/models/user_model.dart';
import 'package:admin_shop/repositories/clients/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

final class UserBloc extends Bloc<UserEvent, UserState> {
  final IUserRepository _userRepository;
  UserBloc(this._userRepository) : super(UserState.initial()) {
    on<UsersOverviewSubscriptionRequested>(
      _onUsersOverviewSubscriptionRequested,
    );
  }

  Future<void> _onUsersOverviewSubscriptionRequested(
    UsersOverviewSubscriptionRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserState.loading(users: state.users));
    await emit.forEach<List<UserModel>?>(
      _userRepository.users,
      onData: (data) =>
          data != null ? UserState.success(data) : UserState.initial(),
      onError: (error, _) => UserState.failure(
        error is FirebaseException
            ? (error.message ?? 'Firebase unknown error!')
            : error.toString(),
      ),
    );
  }
}
