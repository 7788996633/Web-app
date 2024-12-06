import '../helper/api.dart';

class LoginServices {
  Future<String> login(String email, String password) async {
    var headers = {'Accept': 'application/json'};
    var body = ({'email': email, 'password': password});
    var data = await Api().postt('api/login', headers, body);
    if (!data['message'].toString().contains('failed')) {
      print(
        data,
      );
      return data['token'];
    } else {
      print(
        data,
      );
      return 'fail';
    }
  }
}
