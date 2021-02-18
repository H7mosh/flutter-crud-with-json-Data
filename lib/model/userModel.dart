class UserModel
{
 String id;
 String name;
 String email;
 String password;

 UserModel({this.id,this.name,this.email,this.password});

 factory UserModel.fromJson(Map<String,dynamic> jsonData)
 {
   return UserModel(
      id: jsonData['id'] as String,
      name: jsonData['name'] as String,
     email: jsonData['email'] as String,
     password: jsonData['password'] as String,
   );
 }

 Map<String,dynamic>fromFlutter_toJson(){
   return{
     //'id':id,
     'name':name,
     'email':email,
     'password':password,

   };
 }


 Map<String,dynamic>fromFlutter_toJson_updateUser(){
   return{
     'id':id,
     'name':name,
     'email':email,
     'password':password,

   };
 }

}