import 'package:flutter/material.dart';

import '../models/user.dart';
import '../data/user_data.dart';
import 'home_screen.dart';


class SignupScreen extends StatefulWidget {

  const SignupScreen({super.key});


  @override
  State<SignupScreen> createState() => _SignupScreenState();

}



class _SignupScreenState extends State<SignupScreen> {


  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();




  void signup() async {


    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {


      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text("Please fill all details"),

        ),

      );


      return;

    }





    currentUser = User(

      name: nameController.text,

      email: emailController.text,

      password: passwordController.text,

    );



    await saveUser();




    Navigator.pushReplacement(

      context,

      MaterialPageRoute(

        builder: (_) => const HomeScreen(),

      ),

    );


  }






  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title: const Text("Signup"),

        backgroundColor: Colors.blue,

        foregroundColor: Colors.white,

      ),




      body: Padding(


        padding: const EdgeInsets.all(20),



        child: Column(


          mainAxisAlignment: MainAxisAlignment.center,


          children: [



            const Text(

              "Create Account",

              style: TextStyle(

                fontSize: 28,

                fontWeight: FontWeight.bold,

              ),

            ),




            const SizedBox(height:30),





            TextField(

              controller: nameController,

              decoration: const InputDecoration(

                labelText: "Name",

                border: OutlineInputBorder(),

              ),

            ),





            const SizedBox(height:15),





            TextField(

              controller: emailController,

              decoration: const InputDecoration(

                labelText: "Email",

                border: OutlineInputBorder(),

              ),

            ),





            const SizedBox(height:15),






            TextField(

              controller: passwordController,

              obscureText: true,

              decoration: const InputDecoration(

                labelText: "Password",

                border: OutlineInputBorder(),

              ),

            ),






            const SizedBox(height:25),






            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                onPressed: signup,

                child: const Text("SIGN UP"),

              ),

            ),



          ],


        ),


      ),


    );

  }

}