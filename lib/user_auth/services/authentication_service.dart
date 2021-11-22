import 'package:wms/core/entity/user.dart';
import 'package:wms/user_auth/interfaces/i_user_repository.dart';

class AuthenticationService {
  final IUserRepository _userRepository;
  late List<User> _validUsers;

  AuthenticationService({required userRepository})
      : _userRepository = userRepository;

  Future<void> fetchValidUsers() async {
    _validUsers = await _userRepository.fetchValidUsers();
    return;
  }

  Future<bool> isUserValid(User loginUser) async {
    await fetchValidUsers();
    return _validUsers.contains(loginUser);
  }

  Future<User> loginUser(User loginUser) async {
    if (_validUsers.isEmpty) {
      await fetchValidUsers();
    }

    return _validUsers.firstWhere((element) => element == loginUser);
  }
}
