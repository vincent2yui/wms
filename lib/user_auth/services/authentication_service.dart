import 'package:wms/core/entity/user.dart';
import 'package:wms/user_auth/interfaces/i_user_repository.dart';

class AuthenticationService {
  final IUserRepository _userRepository;

  AuthenticationService({required userRepository})
      : _userRepository = userRepository;

  Future<List<User>> _fetchValidUsers() async =>
      await _userRepository.fetchValidUsers();

  Future<bool> isUserValid(User loginUser) async => await _fetchValidUsers()
      .then((value) => value)
      .then((value) => value.contains(loginUser));
}
