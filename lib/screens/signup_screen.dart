import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home_screen.dart';
import 'login_screen.dart';


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










        body: Container(

            width: double.infinity,

            height: double.infinity,

            decoration: const BoxDecoration(

              gradient: LinearGradient(

                colors: [

                  Color(0xff1565C0),

                  Color(0xff42A5F5),

                  Color(0xff90CAF9),

                ],

                begin: Alignment.topLeft,

                end: Alignment.bottomRight,

              ),

            ),

            child: SafeArea(

              child: Padding(

                padding: const EdgeInsets.all(20),

                child: Container(

                  padding: const EdgeInsets.all(25),

                  decoration: BoxDecoration(

                    color: Colors.white.withOpacity(.18),

                    borderRadius: BorderRadius.circular(30),

                    border: Border.all(
                      color: Colors.white.withOpacity(.45),
                    ),

                    boxShadow: [

                      BoxShadow(

                        color: Colors.black.withOpacity(.15),

                        blurRadius: 25,

                        offset: const Offset(0, 10),

                      ),

                    ],

                  ),

                  child: Column(

          mainAxisAlignment:
          MainAxisAlignment.center,


          children: [




            const Icon(
              Icons.person_add_alt_1_rounded,
              color: Colors.white,
              size: 70,
            ),

            const SizedBox(height: 20),

            const Text(

              "Create Your Account",

              style: TextStyle(

                fontSize: 30,

                color: Colors.white,

                fontWeight: FontWeight.bold,

              ),

            ),

            const SizedBox(height: 8),

            const Text(

              "Join MediConnect today",

              style: TextStyle(

                color: Colors.white70,

                fontSize: 16,

              ),

            ),





            const SizedBox(
              height: 30,
            ),







            TextField(

              controller: nameController,

              style: const TextStyle(
                color: Colors.black,
              ),

              decoration: InputDecoration(

                hintText: "Full Name",

                prefixIcon: const Icon(
                  Icons.person,
                  color: Colors.blue,
                ),

                filled: true,

                fillColor: Colors.white,

                contentPadding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 20,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),

              ),

            ),






            const SizedBox(
              height: 15,
            ),







            TextField(

              controller: emailController,

              style: const TextStyle(
                color: Colors.black,
              ),

              decoration: InputDecoration(

                hintText: "Email Address",

                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.blue,
                ),

                filled: true,

                fillColor: Colors.white,

                contentPadding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 20,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),

              ),

            ),








            const SizedBox(
              height: 15,
            ),







            TextField(

              controller: passwordController,

              obscureText: true,

              style: const TextStyle(
                color: Colors.black,
              ),

              decoration: InputDecoration(

                hintText: "Password",

                prefixIcon: const Icon(
                  Icons.lock,
                  color: Colors.blue,
                ),

                suffixIcon: const Icon(
                  Icons.visibility_off,
                  color: Colors.grey,
                ),

                filled: true,

                fillColor: Colors.white,

                contentPadding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 20,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),

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

                onPressed: signup,

                style: ElevatedButton.styleFrom(

                  backgroundColor: const Color(0xff1565C0),

                  foregroundColor: Colors.white,

                  elevation: 8,

                  shadowColor: Colors.blueAccent,

                  minimumSize: const Size(
                    double.infinity,
                    58,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),

                ),

                child: const Text(

                  "CREATE ACCOUNT",

                  style: TextStyle(

                    fontSize: 18,

                    fontWeight: FontWeight.bold,

                    letterSpacing: 1,

                  ),

                ),

              ),

            ),
            const SizedBox(
              height: 20,
            ),

            Row(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                const Text(

                  "Already have an account? ",

                  style: TextStyle(
                    color: Colors.white,
                  ),

                ),

                TextButton(

                  onPressed: () {

                    Navigator.pushReplacement(

                      context,

                      MaterialPageRoute(

                        builder: (_) => const LoginScreen(),

                      ),

                    );

                  },

                  child: const Text(

                    "LOGIN",

                    style: TextStyle(

                      color: Colors.white,

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                ),

              ],

            ),



          ],



        ),
              ),
            ),
        ),
        ),
    );

  }

}