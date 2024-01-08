import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mocketest_hive/database%20hive/databases.dart';
import 'package:mocketest_hive/mocks_file/screens/regstrn%20page.dart';
import 'package:mocketest_hive/model%20hive/models.dart';

import 'homee.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(usersignAdapter());
  Hive.openBox<usersign>("users");
  runApp(GetMaterialApp(home: loghive(),
  debugShowCheckedModeBanner: false,
    useInheritedMediaQuery: true,
  ));}
class loghive extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()=>hivelogstate();
}
class hivelogstate extends State<loghive>
{
  TextEditingController Uname= TextEditingController();
  TextEditingController Upass=TextEditingController();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title: Text("LOGIN PAGE",style: GoogleFonts.aclonica(color: Colors.black),),centerTitle: true,
     backgroundColor: Colors.green[300],),
     body:Container(
       child: SingleChildScrollView(
         child: Column(
           children: [
             Padding(
               padding: const EdgeInsets.only(top: 150,left: 20,right: 20),
               child: TextFormField(
                 textInputAction: TextInputAction.next,
                 controller: Uname,
                 decoration: InputDecoration(
                   hintText: "user name",hintStyle: GoogleFonts.aclonica(),
                   border:OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                 ),
               ),
             ),
             SizedBox(height: 40),
             Padding(
               padding: const EdgeInsets.only(left: 20,right: 20),
               child: TextFormField(
                 textInputAction: TextInputAction.next,
                 controller: Upass,
                 decoration: InputDecoration(
                   hintText: "password",hintStyle: GoogleFonts.aclonica(),
                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(100))
                 ),
               ),
             ),
             SizedBox(height: 40,),
             ElevatedButton(onPressed: () async {
               final userdetails= await Dbfunction.instance.gettinguser();
               userfind(userdetails);

             },
                 child: Text("Login ",style: GoogleFonts.aclonica(color: Colors.black),),
             style: ElevatedButton.styleFrom(backgroundColor: Colors.green[200]),),
             SizedBox(height: 40,),
             TextButton(onPressed: (){
               Get.to(reghive());
             },
                 child:Text("Not a user please register",style: GoogleFonts.aclonica(color: Colors.black),)),
           ],
         ),
       ),
     )
   );
  }

  Future<void> userfind(List<usersign> userdetails) async {
    final email    = Uname.text.trim();
    final password = Upass.text.trim();
    bool userfound = false;
    final validate = await validateLogin(email,password);
    if(validate == true){
      await Future.forEach(userdetails, (user) {
        if(user.email == email && user.password == password){
          userfound = true;
        }else{
          userfound = false;
        }
      });
      if(userfound == true){
        Get.offAll(()=> homee(email :email));
        Get.snackbar("Success", "Login Successfully",
            backgroundColor: Colors.green);
      }else{
        Get.snackbar("Error", "Please check your email/Password!!!",
            backgroundColor: Colors.red);
      }
    }
  }
  Future<bool> validateLogin(String email, String password) async {
    if(email != '' && password != ''){
      return true;
    }else{
      Get.snackbar("Error", "Fields can't be empty,try again!!!",backgroundColor: Colors.red);
      return false;
    }

  }}