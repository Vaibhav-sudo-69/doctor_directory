import 'package:flutter/material.dart';

import 'admin_panel_screen.dart';


class AdminLoginScreen extends StatefulWidget {

  const AdminLoginScreen({super.key});


  @override
  State<AdminLoginScreen> createState() =>
      _AdminLoginScreenState();

}




class _AdminLoginScreenState extends State<AdminLoginScreen> {


  final emailController =
  TextEditingController();


  final passwordController =
  TextEditingController();




  void adminLogin() {


    if (
    emailController.text == "admin@gmail.com" &&
        passwordController.text == "admin123"
    ) {


      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (_) =>
          const AdminPanelScreen(),

        ),

      );


    } else {


      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
          Text(
            "Wrong Admin Details ❌",
          ),

        ),

      );


    }


  }






  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title:
        const Text(
          "Admin Login",
        ),

        backgroundColor:
        Colors.blue,

        foregroundColor:
        Colors.white,

      ),





      body: Padding(

        padding:
        const EdgeInsets.all(20),


        child: Column(


          mainAxisAlignment:
          MainAxisAlignment.center,


          children: [



            const Icon(

              Icons.admin_panel_settings,

              size: 90,

              color: Colors.blue,

            ),



            const SizedBox(
              height: 30,
            ),




            TextField(

              controller:
              emailController,


              decoration:
              const InputDecoration(

                labelText:
                "Admin Email",

                border:
                OutlineInputBorder(),

              ),

            ),





            const SizedBox(
              height: 15,
            ),





            TextField(

              controller:
              passwordController,


              obscureText:
              true,


              decoration:
              const InputDecoration(

                labelText:
                "Password",

                border:
                OutlineInputBorder(),

              ),

            ),






            const SizedBox(
              height: 25,
            ),






            SizedBox(

              width:
              double.infinity,


              child:
              ElevatedButton(

                onPressed:
                adminLogin,


                child:
                const Text(
                  "ADMIN LOGIN",
                ),

              ),

            ),


          ],

        ),

      ),

    );

  }

}