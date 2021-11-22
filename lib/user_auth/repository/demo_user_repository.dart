import 'package:wms/core/entity/user.dart';
import 'package:wms/user_auth/interfaces/i_user_repository.dart';

class DemoUserRepository implements IUserRepository {
  final List<User> _demoUsers = [
    const User(username: 'A1', password: '1'),
    const User(username: 'A2', password: '2'),
    const User(username: 'A3', password: '3'),
  ];

  @override
  Future<List<User>> fetchValidUsers() async {
    await Future.delayed(const Duration(seconds: 1));
    return _demoUsers;
  }
}
