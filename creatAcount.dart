import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../Model/modelUser.dart';
import '../Service/supaBaseEnv.dart';
import 'CustomResponse.dart';

creatAcount(Request req ) async{

try{
//read the body and store it in body 
final body = json.decode(await req.readAsString());

final supabaseVaribale = supaBaseEnv().supabase.auth;

//creat users
UserResponse userInfo = await supabaseVaribale.admin.createUser
(AdminUserAttributes (email: body['email'], password: body['password']));

//creat users objects from  users models
modelUser userObject = modelUser(
      username: body["username"],
      email: body["email"],
      name: body["name"],
      idAuth: userInfo.user!.id,
      bio: body["bio"],
    );

// authentication for user by email
await supabaseVaribale.signInWithOtp(email: body['email']);
await supaBaseEnv().supabase.from("users").insert(userObject.toMap());



return CustomResponse().successResponse(
      msg: "create account done",
      data: {"email": body['email']},
    );


}
catch(e){

print(e);

    return CustomResponse().errorResponse(
      msg: "sorry you should have body",
    );





}


}