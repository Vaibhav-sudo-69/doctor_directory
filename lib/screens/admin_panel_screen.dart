import 'package:flutter/material.dart';

import 'add_doctor_screen.dart';
import 'manage_doctors_screen.dart';
import 'doctor_requests_screen.dart';


class AdminPanelScreen extends StatelessWidget {

  const AdminPanelScreen({super.key});


  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor:
      const Color(0xffF5F7FA),


      appBar: AppBar(

        title:
        const Text(
          "Admin Panel",
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




            const Icon(

              Icons.admin_panel_settings,

              size: 100,

              color: Colors.blue,

            ),





            const SizedBox(
              height: 30,
            ),







            // ADD DOCTOR

            SizedBox(

              width:
              double.infinity,

              height:
              55,


              child:
              ElevatedButton.icon(

                icon:
                const Icon(
                  Icons.add,
                ),


                label:
                const Text(
                  "ADD DOCTOR",
                ),


                onPressed: () {


                  Navigator.push(

                    context,


                    MaterialPageRoute(

                      builder: (_) =>
                      const AddDoctorScreen(),

                    ),

                  );


                },

              ),

            ),








            const SizedBox(
              height: 15,
            ),









            // MANAGE DOCTORS

            SizedBox(

              width:
              double.infinity,

              height:
              55,


              child:
              ElevatedButton.icon(

                icon:
                const Icon(
                  Icons.medical_services,
                ),


                label:
                const Text(
                  "MANAGE DOCTORS",
                ),



                onPressed: () {


                  Navigator.push(

                    context,


                    MaterialPageRoute(

                      builder: (_) =>
                      const ManageDoctorsScreen(),

                    ),

                  );


                },

              ),

            ),









            const SizedBox(
              height: 15,
            ),







            // DOCTOR REQUESTS

            SizedBox(

              width:
              double.infinity,

              height:
              55,


              child:
              ElevatedButton.icon(

                icon:
                const Icon(
                  Icons.verified_user,
                ),


                label:
                const Text(
                  "DOCTOR REQUESTS 👨‍⚕️",
                ),



                onPressed: () {


                  Navigator.push(

                    context,


                    MaterialPageRoute(

                      builder: (_) =>
                      const DoctorRequestsScreen(),

                    ),

                  );


                },

              ),

            ),









            const SizedBox(
              height: 15,
            ),







            // EXIT ADMIN

            SizedBox(

              width:
              double.infinity,

              height:
              55,


              child:
              ElevatedButton.icon(

                icon:
                const Icon(
                  Icons.logout,
                ),



                label:
                const Text(
                  "EXIT ADMIN",
                ),



                onPressed: () {


                  Navigator.pop(context);


                },

              ),

            ),




          ],

        ),

      ),

    );


  }

}