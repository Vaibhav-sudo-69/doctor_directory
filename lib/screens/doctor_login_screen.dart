import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'doctor_panel_screen.dart';
import 'doctor_register_screen.dart';



class DoctorLoginScreen extends StatefulWidget {

  const DoctorLoginScreen({super.key});


  @override
  State<DoctorLoginScreen> createState()
  => _DoctorLoginScreenState();

}




class _DoctorLoginScreenState
    extends State<DoctorLoginScreen> {


  final emailController =
  TextEditingController();


  final passwordController =
  TextEditingController();



  bool loading = false;







  void loginDoctor() async {


    if(
    emailController.text.isEmpty ||
        passwordController.text.isEmpty
    ){


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






    final result =
    await FirebaseFirestore.instance
        .collection("doctors")
        .where(

      "email",

      isEqualTo:
      emailController.text.trim(),

    )
        .where(

      "password",

      isEqualTo:
      passwordController.text.trim(),

    )
        .get();







    setState(() {

      loading = false;

    });








    if(result.docs.isNotEmpty){



      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (_) =>

              DoctorPanelScreen(

                doctorId:
                result.docs.first.id,


                doctorData:
                result.docs.first.data(),

              ),

        ),

      );







      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
          Text(
              "Doctor Login Successful ✅"
          ),

        ),

      );



    }






    else{


      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
          Text(
              "Invalid Doctor Login ❌"
          ),

        ),

      );


    }



  }









  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar:
      AppBar(

        title:
        const Text(
            "Doctor Login"
        ),


        backgroundColor:
        Colors.blue,


        foregroundColor:
        Colors.white,

      ),








      body:
      Padding(

        padding:
        const EdgeInsets.all(20),



        child:
        Column(


          mainAxisAlignment:
          MainAxisAlignment.center,



          children: [





            const Icon(

              Icons.medical_services,

              size:80,

              color:
              Colors.blue,

            ),






            const SizedBox(
              height:30,
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
              height:15,
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
              height:25,
            ),









            SizedBox(

              width:
              double.infinity,


              child:
              ElevatedButton(


                onPressed:
                loading
                    ? null
                    : loginDoctor,



                child:
                loading

                    ?

                const CircularProgressIndicator()


                    :


                const Text(
                    "DOCTOR LOGIN"
                ),


              ),

            ),









            const SizedBox(
              height:15,
            ),







            TextButton(


              onPressed: (){


                Navigator.push(

                  context,


                  MaterialPageRoute(

                    builder: (_) =>
                    const DoctorRegisterScreen(),

                  ),

                );


              },



              child:
              const Text(

                "New Doctor? Register 👨‍⚕️",

              ),

            ),




          ],

        ),

      ),


    );


  }


}