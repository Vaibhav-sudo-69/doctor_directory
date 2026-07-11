import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home_screen.dart';
import 'signup_screen.dart';
import 'admin_login_screen.dart';
import 'doctor_login_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

final emailController =
TextEditingController();

final passwordController =
TextEditingController();

bool _obscurePassword = true;

bool loading = false;

void login() async {

if (emailController.text.isEmpty ||
passwordController.text.isEmpty) {

ScaffoldMessenger.of(context)
.showSnackBar(

const SnackBar(

content:
Text("Enter all details"),

),

);

return;
}

setState(() {
loading = true;
});

try {

await FirebaseAuth.instance
.signInWithEmailAndPassword(

email:
emailController.text.trim(),

password:
passwordController.text.trim(),

);

setState(() {
loading = false;
});

ScaffoldMessenger.of(context)
.showSnackBar(

const SnackBar(

content:
Text("Login Successful ✅"),

),

);

Navigator.pushReplacement(

context,

MaterialPageRoute(

builder: (_) =>
const HomeScreen(),

),

);

} catch (e) {

setState(() {
loading = false;
});

ScaffoldMessenger.of(context)
.showSnackBar(

const SnackBar(

content:
Text("Wrong Email or Password ❌"),

),

);

}

}

// 🔐 Forgot Password

void forgotPassword() async {

if (emailController.text.trim().isEmpty) {

ScaffoldMessenger.of(context)
.showSnackBar(

const SnackBar(

content:
Text("Enter your email first"),

),

);

return;
}

try {

await FirebaseAuth.instance
.sendPasswordResetEmail(

email:
emailController.text.trim(),

);

ScaffoldMessenger.of(context)
.showSnackBar(

const SnackBar(

content:
Text(
"Password reset email sent ✅",
),

),

);

}

catch (e) {

ScaffoldMessenger.of(context)
.showSnackBar(

const SnackBar(

content:
Text(
"Unable to send reset email",
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

          child: Center(

            child: SingleChildScrollView(

              padding: const EdgeInsets.all(20),

              child: Container(

                padding: const EdgeInsets.all(25),

                decoration: BoxDecoration(

                  color: Colors.white.withOpacity(.15),

                  borderRadius:
                  BorderRadius.circular(30),

                  border: Border.all(

                    color:
                    Colors.white.withOpacity(.3),

                  ),

                ),

                child: Column(

                  mainAxisSize:
                  MainAxisSize.min,

                  children: [

                    const CircleAvatar(

                      radius:45,

                      backgroundColor:
                      Colors.white,

                      child: Icon(

                        Icons.local_hospital,

                        size:50,

                        color:
                        Colors.blue,

                      ),

                    ),

                    const SizedBox(height:20),

                    const Text(

                      "Doctor Directory",

                      style: TextStyle(

                        fontSize:30,

                        color: Colors.white,

                        fontWeight:
                        FontWeight.bold,

                      ),

                    ),

                    const SizedBox(height:8),

                    const Text(

                      "Your Health, Our Priority",

                      style: TextStyle(

                        color:
                        Colors.white70,

                        fontSize:16,

                      ),

                    ),

                    const SizedBox(height:35),

                    TextField(

                      controller:
                      emailController,

                      decoration: InputDecoration(

                        filled:true,

                        fillColor:
                        Colors.white,

                        hintText:
                        "Email Address",

                        prefixIcon:
                        const Icon(
                          Icons.email,
                        ),

                        border:
                        OutlineInputBorder(

                          borderRadius:
                          BorderRadius.circular(18),

                          borderSide:
                          BorderSide.none,

                        ),

                      ),

                    ),

                    const SizedBox(height:20),

                    TextField(

                      controller:
                      passwordController,

                      obscureText:
                      _obscurePassword,

                      decoration: InputDecoration(

                        filled:true,

                        fillColor:
                        Colors.white,

                        hintText:
                        "Password",

                        prefixIcon:
                        const Icon(
                          Icons.lock,
                        ),

                        suffixIcon:
                        IconButton(

                          icon: Icon(

                            _obscurePassword

                                ?

                            Icons.visibility_off

                                :

                            Icons.visibility,

                          ),

                          onPressed: (){

                            setState((){

                              _obscurePassword =
                              !_obscurePassword;

                            });

                          },

                        ),

                        border:
                        OutlineInputBorder(

                          borderRadius:
                          BorderRadius.circular(18),

                          borderSide:
                          BorderSide.none,

                        ),

                      ),

                    ),

                    Align(

                      alignment:
                      Alignment.centerRight,

                      child:
                      TextButton(

                        onPressed:
                        forgotPassword,

                        child:
                        const Text(

                          "Forgot Password?",

                          style: TextStyle(

                            color:
                            Colors.white,

                          ),

                        ),

                      ),

                    ),

                    const SizedBox(height:15),

                    SizedBox(

                      width:
                      double.infinity,

                      height:55,

                      child:
                      ElevatedButton(

                        onPressed:

                        loading

                            ?

                        null

                            :

                        login,

                        style:
                        ElevatedButton.styleFrom(

                          backgroundColor:
                          Colors.blue.shade800,

                          shape:
                          RoundedRectangleBorder(

                            borderRadius:
                            BorderRadius.circular(18),

                          ),

                        ),

                        child:

                        loading

                            ?

                        const CircularProgressIndicator(

                          color:
                          Colors.white,

                        )

                            :

                        const Text(

                          "LOGIN",

                          style: TextStyle(

                            fontSize:18,

                            color:
                            Colors.white,

                            fontWeight:
                            FontWeight.bold,

                          ),

                        ),

                      ),

                    ),

                    const SizedBox(height:20),

                    TextButton(

                      onPressed: (){

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

                        style: TextStyle(

                          color:
                          Colors.white,

                          fontSize:16,

                        ),

                      ),

                    ),

                    const Divider(
                      color: Colors.white,
                    ),

                    TextButton.icon(

                      icon:
                      const Icon(

                        Icons.medical_services,

                        color:
                        Colors.white,

                      ),

                      label:
                      const Text(

                        "Doctor Login",

                        style: TextStyle(

                          color:
                          Colors.white,

                        ),

                      ),

                      onPressed: (){

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>
                            const DoctorLoginScreen(),

                          ),

                        );

                      },

                    ),

                    TextButton.icon(

                      icon:
                      const Icon(

                        Icons.admin_panel_settings,

                        color:
                        Colors.white,

                      ),

                      label:
                      const Text(

                        "Admin Login",

                        style: TextStyle(

                          color:
                          Colors.white,

                        ),

                      ),

                      onPressed: (){

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>
                            const AdminLoginScreen(),

                          ),

                        );

                      },

                    ),

                  ],

                ),

              ),

            ),

          ),

        ),

      ),

    );

  }

}