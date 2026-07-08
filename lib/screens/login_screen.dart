import 'package:flutter/material.dart';

import '../models/user.dart';
import '../data/user_data.dart';

import 'home_screen.dart';
import 'signup_screen.dart';
import 'admin_login_screen.dart';
import 'doctor_login_screen.dart';


class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});


  @override
  State<LoginScreen> createState() => _LoginScreenState();

}



class _LoginScreenState extends State<LoginScreen> {


  final emailController = TextEditingController();

  final passwordController = TextEditingController();



  void login() async {


    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty) {


      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Enter all details",
          ),

        ),

      );


      return;

    }



    currentUser = User(

      name: "Vaibhav",

      email: emailController.text,

      password: passwordController.text,

    );



    await saveUser();



    Navigator.pushReplacement(

      context,

      MaterialPageRoute(

        builder: (_) =>
        const HomeScreen(),

      ),

    );

  }






  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title: const Text(
          "Login",
        ),

        backgroundColor: Colors.blue,

        foregroundColor: Colors.white,

      ),




      body: Padding(

        padding: const EdgeInsets.all(20),


        child: Column(


          mainAxisAlignment:
          MainAxisAlignment.center,


          children: [



            const Text(

              "Doctor Directory Login",

              style: TextStyle(

                fontSize: 26,

                fontWeight: FontWeight.bold,

              ),

            ),




            const SizedBox(height: 30),




            TextField(

              controller: emailController,


              decoration: const InputDecoration(

                labelText: "Email",

                border: OutlineInputBorder(),

              ),

            ),





            const SizedBox(height: 15),





            TextField(

              controller: passwordController,

              obscureText: true,


              decoration: const InputDecoration(

                labelText: "Password",

                border: OutlineInputBorder(),

              ),

            ),






            const SizedBox(height: 25),






            SizedBox(

              width: double.infinity,


              child: ElevatedButton(

                onPressed: login,


                child: const Text(
                  "LOGIN",
                ),

              ),

            ),







            TextButton(

              onPressed: () {


                Navigator.push(

                  context,


                  MaterialPageRoute(

                    builder: (_) =>
                    const SignupScreen(),

                  ),

                );


              },


              child: const Text(

                "Create New Account",

              ),

            ),







            // 👨‍⚕️ DOCTOR LOGIN

            TextButton.icon(


              icon: const Icon(

                Icons.medical_services,

              ),



              label: const Text(

                "Doctor Login 👨‍⚕️",

              ),



              onPressed: () {


                Navigator.push(

                  context,


                  MaterialPageRoute(

                    builder: (_) =>
                    const DoctorLoginScreen(),

                  ),

                );


              },

            ),








            // 👨‍💻 ADMIN LOGIN

            TextButton(


              onPressed: () {


                Navigator.push(

                  context,


                  MaterialPageRoute(

                    builder: (_) =>
                    const AdminLoginScreen(),

                  ),

                );


              },



              child: const Text(

                "Admin Login 👨‍💻",

              ),

            ),



          ],

        ),

      ),

    );


  }

}