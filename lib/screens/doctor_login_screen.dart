import 'package:flutter/material.dart';

import '../data/doctor_login_data.dart';

import 'doctor_panel_screen.dart';
import 'doctor_register_screen.dart';


class DoctorLoginScreen extends StatefulWidget {

  const DoctorLoginScreen({super.key});


  @override
  State<DoctorLoginScreen> createState() =>
      _DoctorLoginScreenState();

}




class _DoctorLoginScreenState
    extends State<DoctorLoginScreen> {


  final emailController =
  TextEditingController();


  final passwordController =
  TextEditingController();





  void loginDoctor() {


    for (var doctor in doctorAccounts) {


      if (doctor.email ==
          emailController.text &&

          doctor.password ==
              passwordController.text) {


        currentDoctor = doctor;



        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder: (_) =>
            const DoctorPanelScreen(),

          ),

        );


        return;

      }

    }




    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(

        content: Text(

          "Invalid Doctor Login",

        ),

      ),

    );

  }








  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title: const Text(

          "Doctor Login",

        ),


        backgroundColor: Colors.blue,

        foregroundColor: Colors.white,

      ),








      body: Padding(

        padding:
        const EdgeInsets.all(20),



        child: Column(


          mainAxisAlignment:
          MainAxisAlignment.center,



          children: [





            const Icon(

              Icons.medical_services,

              size: 80,

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
                "Doctor Email",

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
                loginDoctor,


                child:
                const Text(

                  "DOCTOR LOGIN",

                ),

              ),

            ),








            const SizedBox(
              height: 15,
            ),








            // NEW DOCTOR REGISTER BUTTON

            TextButton(

              onPressed: () {


                Navigator.push(

                  context,


                  MaterialPageRoute(

                    builder: (_) =>
                    const DoctorRegisterScreen(),

                  ),

                );


              },



              child: const Text(

                "New Doctor? Register 👨‍⚕️",

              ),

            ),






          ],

        ),

      ),

    );


  }

}