import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class homee extends StatelessWidget
{late final String email;
homee({Key ? key,required this.email});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.green[300],
     body: Center(child: Text("welcome $email",style: GoogleFonts.aclonica(),)),
   );
  }

}