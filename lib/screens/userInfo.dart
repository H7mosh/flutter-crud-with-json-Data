import 'package:crud_app/model/userModel.dart';
import 'package:crud_app/service/userService.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class UserInfo extends StatefulWidget {
  final UserModel userModel;
  final int index;

  const UserInfo({ this.userModel, this.index});

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {

  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();
   bool editMode=false;


  addUserInfoToDb(UserModel userModel)async
  {
    await UserService().addUserToDatabase(userModel).then((success){
      Toast.show('add Successful', context);
      Navigator.pop(context);
    });
  }

 updateUser(UserModel userModel)async
  {
    await UserService().updateUser(userModel).then((success){
      Toast.show('update Successful', context);
      Navigator.pop(context);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    if(widget.index != null)
      {
        editMode=true;
        nameController.text=widget.userModel.name;
        emailController.text=widget.userModel.email;
        passController.text=widget.userModel.password;
      }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black45,
        onPressed: ()
        {
          if(editMode)
          {
            UserModel usermodel=UserModel(
                id: widget.userModel.id,
                name: nameController.text,
                email: emailController.text,
                password: passController.text,
            );
            updateUser(usermodel);
          }
          else
            {
              if(nameController.text.isEmpty && emailController.text.isEmpty && passController.text.isEmpty)
              {
                Toast.show('please Enter All The Information', context);
              }
              else
              {
                UserModel userModel = UserModel(
                  name: nameController.text,
                  email: emailController.text,
                  password: passController.text,

                );
                addUserInfoToDb(userModel);
                Toast.show('user add successfully', context);
              }
            }

        },
        child: editMode?Icon(Icons.edit):Icon(Icons.send),
      ),
      appBar: AppBar(
        title:Text('User Information '),
        backgroundColor: Colors.black45,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Enter ur Email'
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                  hintText: 'Enter ur Name'
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: passController,
              decoration: InputDecoration(
                  hintText: 'Enter password'
              ),
            ),
          ),
        ],
      ),
    );
  }
}
