import 'package:webapp/data/helper/api.dart';

class RegisterServices {
  Future<String> register() async {
    var headers = {'Accept': 'application/json'};
    var body = (
      {
  'name': 'mohammed',
  'email': 'mnr@gmail.com',
  'password': '11223344'
      },
    );
    var data = await Api().postt('api/register', headers, body);
    if (data['message'] == 'success') {
      print(
        data,
      );
      return data['access_token'];
    } else {
      print(
        data['message'],
      );
      return 'fail';
    }

  }
}
