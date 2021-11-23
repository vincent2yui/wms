import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wms/core/entity/user.dart';
import 'package:wms/core/error/exceptions.dart';
import 'package:wms/user_auth/interfaces/i_user_repository.dart';

class DevelopmentUserRepository implements IUserRepository {
  @override
  Future<List<User>> fetchValidUsers() async {
    Map<String, String> requestHeaders = {
      'Authorization': 'Basic Vm9jb2xsZWN0OkFiY2RAMTIzNDU=',
      'Cookie': 'sap-usercontext=sap-client=110',
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'X-Requested-With': 'X'
    };

    final response = await http.get(
        Uri.parse(
            'http://s4devapp01.ffpgroup.net:8000/sap/opu/odata/sap/ZEWM_USERS_SRV/usersrecordSet'),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      List<User> userList = [];

      for (var user in json.decode(response.body).values.first.values.first) {
        userList.add(
          User(
              warehouseName: user['Lgnum'],
              username: user['Uname'],
              password: user['Password'],
              isReceivingActive: user['InbAct'],
              isPutAwayActive: user['PtaAct'],
              isPickingActive: user['OutAct'],
              isLoadingActive: user['LdgAct'],
              isReplenishmentActive: user['PrmAct'],
              isCycleCountActive: user['CycAct']),
        );
      }
      return userList;
    }

    return throw ServerException();
  }
}
