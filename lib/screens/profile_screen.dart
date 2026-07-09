import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_screen.dart';


class ProfileScreen extends StatelessWidget {

  const ProfileScreen({super.key});


  @override
  Widget build(BuildContext context) {


    final user =
        FirebaseAuth.instance.currentUser;


    return Scaffold(


      backgroundColor:
      const Color(0xffFFF1FF),


      appBar: AppBar(

        title: const Text(
          "Profile",
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


          children: [



            const SizedBox(
              height: 20,
            ),



            const CircleAvatar(

              radius: 60,

              backgroundColor:
              Color(0xffE5CCFF),


              child: Icon(

                Icons.person,

                size: 70,

                color:
                Colors.deepPurple,

              ),

            ),




            const SizedBox(
              height: 40,
            ),






            Card(

              color:
              const Color(0xffFAEEFF),


              child: ListTile(

                leading:
                const Icon(
                  Icons.person,
                ),


                title:
                const Text(
                  "Name",
                ),


                subtitle:
                Text(

                  user?.displayName ??
                      "User",

                ),

              ),

            ),







            const SizedBox(
              height: 10,
            ),







            Card(

              color:
              const Color(0xffFAEEFF),


              child: ListTile(

                leading:
                const Icon(
                  Icons.email,
                ),


                title:
                const Text(
                  "Email",
                ),


                subtitle:
                Text(

                  user?.email ??
                      "No Email",

                ),

              ),

            ),








            const SizedBox(
              height: 40,
            ),






            SizedBox(

              width:
              double.infinity,


              child:
              ElevatedButton.icon(


                icon:
                const Icon(
                  Icons.logout,
                ),


                label:
                const Text(
                  "LOGOUT",
                ),



                onPressed: () async {


                  await FirebaseAuth
                      .instance
                      .signOut();



                  Navigator.pushAndRemoveUntil(

                    context,


                    MaterialPageRoute(

                      builder: (_) =>
                      const LoginScreen(),

                    ),


                        (route) => false,

                  );


                },

              ),

            ),


          ],

        ),

      ),

    );

  }

}