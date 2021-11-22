import 'package:wms/core/entity/user.dart';
import 'package:wms/user_auth/interfaces/i_user_repository.dart';

class AuthenticationService {
  final IUserRepository _userRepository;
  List<User> _validUsers = List.empty();

  AuthenticationService({required userRepository})
      : _userRepository = userRepository;

  Future<void> fetchValidUsers() async {
    _validUsers = await _userRepository.fetchValidUsers();
    return;
  }

  Future<bool> isUserValid(User loginUser) async {
    await checkUserListEmpty();

    return _validUsers.contains(loginUser);
  }

  Future<User> loginUser(User loginUser) async {
    await checkUserListEmpty();

    return _validUsers.firstWhere((element) => element == loginUser);
  }

  Future<void> checkUserListEmpty() async {
    if (_validUsers.isEmpty) {
      await fetchValidUsers();
    }
  }
}
