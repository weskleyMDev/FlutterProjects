part of 'user_repository.dart';

abstract interface class IUserRepository {
  Stream<List<UserModel>?> get users;
}
