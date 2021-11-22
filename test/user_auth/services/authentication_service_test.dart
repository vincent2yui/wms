import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:wms/core/entity/user.dart';
import 'package:wms/core/error/exceptions.dart';
import 'package:wms/user_auth/interfaces/i_user_repository.dart';
import 'package:wms/user_auth/repository/demo_user_repository.dart';
import 'package:wms/user_auth/services/authentication_service.dart';

class FakeUserRepository extends Fake implements IUserRepository {
  @override
  Future<List<User>> fetchValidUsers() {
    throw ServerException();
  }
}

void main() {
  group('Authentication Service - ', () {
    FakeUserRepository fakeUserRepository = FakeUserRepository();
    DemoUserRepository demoUserRepository = DemoUserRepository();

    late AuthenticationService authenticationService;

    group('Check if user is not valid - ', () {
      setUp(() {
        authenticationService =
            AuthenticationService(userRepository: demoUserRepository);
      });
      test('Should throw exception When the service is not available', () {
        authenticationService =
            AuthenticationService(userRepository: fakeUserRepository);

        expect(
          () async => await authenticationService
              .isUserValid(const User(username: '', password: '')),
          throwsA(isA<ServerException>()),
        );
      });

      test('Should return false When login user A4 is not authenticated',
          () async {
        const invalidUser = User(username: 'A4', password: '4');

        var result = await authenticationService.isUserValid(invalidUser);

        expect(result, false);
      });

      test('Should return false When login user A4 is not authenticated',
          () async {
        const invalidUser = User(username: 'A5', password: '5');

        var result = await authenticationService.isUserValid(invalidUser);

        expect(result, false);
      });

      test('Should return false When login user a1 is not authenticated',
          () async {
        const invalidUser = User(username: 'a1', password: '1');

        var result = await authenticationService.isUserValid(invalidUser);

        expect(result, false);
      });

      test('Should return true When login user A1 is authenticated', () async {
        const invalidUser = User(username: 'A1', password: '1');

        var result = await authenticationService.isUserValid(invalidUser);

        expect(result, true);
      });
    });
  });
}
