import 'package:wms/core/entity/user.dart';
import 'package:wms/user_auth/interfaces/i_user_repository.dart';

class AuthenticationService {
  final IUserRepository _userRepository;
  List<User> _validUser = [];

  AuthenticationService({required userRepository})
      : _userRepository = userRepository;

  Future<List<User>> fetchValidUsers() async {
    _validUser = await _userRepository.fetchValidUsers();
    return _validUser;
  }

  bool isUserValid(User loginUser) {
    if (_validUser.isEmpty) {
      fetchValidUsers();
    }

    return _validUser.contains(loginUser);
  }
}
