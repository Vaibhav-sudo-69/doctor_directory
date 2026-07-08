import 'package:flutter/material.dart';

import '../data/user_data.dart';
import 'login_screen.dart';


class ProfileScreen extends StatefulWidget {

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();

}



class _ProfileScreenState extends State<ProfileScreen> {


 void logout() async {
  await logoutUser();

  if (!mounted) return;

  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ),
    (Route<dynamic> route) => false,
  );
}



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text("Profile"),

        backgroundColor: Colors.blue,

        foregroundColor: Colors.white,

      ),


      body: Padding(

        padding: const EdgeInsets.all(20),


        child: Column(

          children: [


            const CircleAvatar(

              radius: 60,

              child: Icon(
                Icons.person,
                size: 70,
              ),

            ),



            const SizedBox(height:30),



            Card(

              child: ListTile(

                leading: const Icon(Icons.person),

                title: const Text("Name"),

                subtitle: Text(
                  currentUser?.name ?? "",
                ),

              ),

            ),




            Card(

              child: ListTile(

                leading: const Icon(Icons.email),

                title: const Text("Email"),

                subtitle: Text(
                  currentUser?.email ?? "",
                ),

              ),

            ),



            const SizedBox(height:40),



            SizedBox(

              width: double.infinity,

              child: ElevatedButton.icon(
  onPressed: () {
    logout();
  },
  icon: const Icon(Icons.logout),
  label: const Text("LOGOUT"),
),

            ),


          ],

        ),

      ),

    );

  }

}