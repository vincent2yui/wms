import 'package:wms/core/entity/user.dart';

abstract class IUserRepository {
  Future<List<User>> fetchValidUsers();
}
