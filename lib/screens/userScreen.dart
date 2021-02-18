import 'package:crud_app/model/userModel.dart';
import 'package:crud_app/screens/userInfo.dart';
import 'package:crud_app/service/userService.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  List<UserModel> userslList;
  bool isLoading = true;

  getAllUsers()async
  {
    userslList=await UserService().getUsers();
    setState(() {
      isLoading=false;
    });
    print('user : ${userslList.length}');
  }

  deleteUserFromDb(UserModel userModel)async
  {
    await UserService().deleteUserFromDatabase(userModel);
    setState(() {
      isLoading=false;
      getAllUsers();
    });
    Toast.show('deleted Successfully', context);
  }
  @override
  void initState() {
    // TODO: implement initState
    getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black45,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context)=>UserInfo())).then((value) => getAllUsers());
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('crud Flutter - php'),
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),
      body: isLoading?Center(child: CircularProgressIndicator(),):  ListView.builder(
        itemCount: userslList.length,
          itemBuilder: (context,index)
          {
            UserModel user=userslList[index];
            return ListTile(
              onTap: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>UserInfo(userModel: user,index: index,),)).then((value) => getAllUsers());
              },
              leading: CircleAvatar(backgroundColor: Colors.black54,child: Text(user.id),),
              title: Text(user.name),
              subtitle: Text(user.email),
              trailing: IconButton(icon: Icon(Icons.delete),
                  onPressed: (){
                    deleteUserFromDb(user);
                  }),
            );
          }
      ),
    );
  }
}
