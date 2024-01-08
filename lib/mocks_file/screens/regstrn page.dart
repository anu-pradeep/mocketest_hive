import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mocketest_hive/model%20hive/models.dart';

import '../../database hive/databases.dart';
//void main()
// {
//   runApp(MaterialApp(home: reghive(),));
// }
class reghive extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()=>hiveregstate();
}
class hiveregstate extends State<reghive>
{
  TextEditingController username= TextEditingController();
  TextEditingController password= TextEditingController();
  TextEditingController cpassword= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("REGISTRATION PAGE",style: GoogleFonts.aclonica(color: Colors.black),),
      centerTitle: true,backgroundColor: Colors.green[300],),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 150,right: 20,left: 20),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "Name",hintStyle: GoogleFonts.aclonica(),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                  ),
                ),
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: username,
                  decoration: InputDecoration(
                    hintText: "user name",hintStyle: GoogleFonts.aclonica(),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                  ),
                ),
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: password,
                  decoration: InputDecoration(
                    hintText: "Password",hintStyle: GoogleFonts.aclonica(),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                  ),
                ),
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: cpassword,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",hintStyle: GoogleFonts.aclonica(),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                  ),
                ),
              ),
              SizedBox(height: 40,),
              ElevatedButton(onPressed: (){
                validatesign();
              },
                  child: Text("Register",style: GoogleFonts.aclonica(color: Colors.black),),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green[200]),)
            ],
          ),
        ),
      ),
    );
  }

void validatesign() async {
  final email = username.text.trim(); // email from controller
  final pass = password.text.trim(); // password from controller
  final cpass = cpassword.text.trim(); // confirm password from controller

  final emailValidationResult = EmailValidator.validate(email);

  if (email != "" && pass != "" && cpass != "") {
    if (emailValidationResult == true) {
      final passValidationResult = checkPassword(pass, cpass);
      if (passValidationResult == true) {
        final user = usersign(email: email, password: pass);
        await Dbfunction.instance.usersignin(user);
        Get.back();
        Get.snackbar("Success", "Account created");
      }
    } else {
      Get.snackbar("Error", "Provide a valid Email");
    }
  } else {
    Get.snackbar("Error", "Fields Can not be empty");
  }
}

bool checkPassword(String pass, String cpass) {
  if (pass == cpass) {
    if (pass.length < 6) {
      Get.snackbar("Error", "Password length should be > 6");
      return false;
    }
    else {
      return true;
    }
  } else {
    Get.snackbar("Error", "Password mismatch");
    return false;
  }
}
}