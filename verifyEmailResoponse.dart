import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../Service/supaBaseEnv.dart';
import 'CustomResponse.dart';



verificationEmail(Request req) async {
  try {

    //read from body 
    final body = json.decode(await req.readAsString());

   // check by otp and email 
    await supaBaseEnv().supabase.auth.verifyOTP(
          token: body['otp'],
          type: OtpType.signup,
          email: body['email'],
        );

    return CustomResponse().successResponse(msg: "email is confirm");
  } catch (error) {
    return CustomResponse().errorResponse(msg: "email not confirm");
  }
}
