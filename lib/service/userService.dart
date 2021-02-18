import 'dart:convert';
import 'package:crud_app/model/userModel.dart';
import 'package:http/http.dart'as http;
class UserService {
  static const add_url = 'http://192.168.100.168/api/addToTestDb.php';
  static const view_url = 'http://192.168.100.168/api/getUsersFromTestDb.php';
  static const update_url = 'http://192.168.100.168/api/updateUsers.php';
  static const del_url = 'http://192.168.100.168/api/delUser.php';

  Future<String> addUserToDatabase(UserModel userModel) async
  {
    final response = await http.post(
        add_url, body: userModel.fromFlutter_toJson());

    if (response.statusCode == 200) {
      print('add response is : ' + response.body);
      return response.body;
    } else {
      return 'error';
    }
  }

  List<UserModel> userFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<UserModel>.from(data.map((item) => UserModel.fromJson(item)));
  }


  Future <List<UserModel>> getUsers()async
  {
    final response = await http.get(view_url);
    if (response.statusCode == 200)
      {
        List<UserModel> list=userFromJson(response.body);
        return list;
      }
  }

  fetchData()async
  {
    var res = await http.get('http://192.168.100.168/api/getUsersFromTestDb.php');
    if (res.statusCode==200)
    {
      var object=json.decode(res.body);
      return object;
    }
  }

  Future<String> updateUser(UserModel userModel) async
  {
    final response = await http.post(
        update_url, body: userModel.fromFlutter_toJson_updateUser());
    if (response.statusCode == 200) {
      print('update response is : ' + response.body);
      return response.body;
    } else {
      return 'error';
    }
  }

  Future<String> deleteUserFromDatabase(UserModel userModel) async
  {
    final response = await http.post(
        del_url, body: userModel.fromFlutter_toJson_updateUser());
    if (response.statusCode == 200) {
      print('delete response is : ' + response.body);
      return response.body;
    } else {
      return 'error';
    }
  }

}
