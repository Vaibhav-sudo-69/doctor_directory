import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home_screen.dart';


class SignupScreen extends StatefulWidget {

  const SignupScreen({super.key});


  @override
  State<SignupScreen> createState()
  => _SignupScreenState();

}




class _SignupScreenState
    extends State<SignupScreen> {


  final nameController =
  TextEditingController();

  final emailController =
  TextEditingController();

  final passwordController =
  TextEditingController();





  void signup() async {


    if (
    nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty
    ) {


      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
          Text(
            "Please fill all details",
          ),

        ),

      );


      return;

    }




    try {


      final credential =
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(

        email:
        emailController.text.trim(),

        password:
        passwordController.text.trim(),

      );





      await credential.user!
          .updateDisplayName(

        nameController.text.trim(),

      );
      await FirebaseFirestore.instance
          .collection("users")
          .doc(credential.user!.uid)
          .set(
        {

          "uid":
          credential.user!.uid,

          "name":
          nameController.text.trim(),

          "email":
          emailController.text.trim(),

          "createdAt":
          DateTime.now(),

        },
      );



      await credential.user!
          .reload();







      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
          Text(
            "Signup Successful ✅",
          ),

        ),

      );





      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (_) =>
          const HomeScreen(),

        ),

      );



    }

    on FirebaseAuthException catch (e) {


      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          content:
          Text(

            e.message ??
                "Signup Failed",

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
          "Signup",
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




            const Text(

              "Create Account",

              style:
              TextStyle(

                fontSize: 28,

                fontWeight:
                FontWeight.bold,

              ),

            ),





            const SizedBox(
              height: 30,
            ),







            TextField(

              controller:
              nameController,


              decoration:
              const InputDecoration(

                labelText:
                "Name",

                border:
                OutlineInputBorder(),

              ),

            ),






            const SizedBox(
              height: 15,
            ),







            TextField(

              controller:
              emailController,


              decoration:
              const InputDecoration(

                labelText:
                "Email",

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
                signup,


                child:
                const Text(

                  "SIGN UP",

                ),

              ),

            ),



          ],

        ),

      ),

    );

  }

}