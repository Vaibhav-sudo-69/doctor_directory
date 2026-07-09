import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DoctorRegisterScreen extends StatefulWidget {

  const DoctorRegisterScreen({super.key});


  @override
  State<DoctorRegisterScreen> createState()
  => _DoctorRegisterScreenState();

}




class _DoctorRegisterScreenState
    extends State<DoctorRegisterScreen> {


  final nameController =
  TextEditingController();

  final emailController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  final specializationController =
  TextEditingController();

  final clinicController =
  TextEditingController();

  final phoneController =
  TextEditingController();






  void registerDoctor() async {


    if (
    nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        specializationController.text.isEmpty ||
        clinicController.text.isEmpty ||
        phoneController.text.isEmpty
    ) {


      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
          Text(
            "Fill all details",
          ),

        ),

      );


      return;

    }





    try {


      await FirebaseFirestore.instance
          .collection("doctor_requests")
          .add(

        {


          "name":
          nameController.text.trim(),


          "email":
          emailController.text.trim(),


          "password":
          passwordController.text.trim(),


          "specialization":
          specializationController.text.trim(),


          "clinicName":
          clinicController.text.trim(),


          "phoneNumber":
          phoneController.text.trim(),


          "status":
          "Pending",


          "createdAt":
          DateTime.now(),


        },

      );








      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
          Text(

            "Request sent to Admin ✅",

          ),

        ),

      );



      Navigator.pop(context);



    }


    catch (e) {


      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          content:
          Text(

            e.toString(),

          ),

        ),

      );


    }


  }









  Widget input(

      String text,

      TextEditingController controller,

      ) {


    return Padding(

      padding:
      const EdgeInsets.only(
        bottom: 15,
      ),


      child:
      TextField(


        controller:
        controller,


        decoration:
        InputDecoration(


          labelText:
          text,


          border:
          const OutlineInputBorder(),


        ),

      ),

    );

  }









  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar:
      AppBar(


        title:
        const Text(

          "Doctor Registration",

        ),


        backgroundColor:
        Colors.blue,


        foregroundColor:
        Colors.white,


      ),








      body:
      SingleChildScrollView(


        padding:
        const EdgeInsets.all(20),


        child:
        Column(


          children: [





            input(

              "Doctor Name",

              nameController,

            ),





            input(

              "Email",

              emailController,

            ),






            input(

              "Password",

              passwordController,

            ),






            input(

              "Specialization",

              specializationController,

            ),







            input(

              "Clinic Name",

              clinicController,

            ),







            input(

              "Phone Number",

              phoneController,

            ),







            SizedBox(


              width:
              double.infinity,


              child:
              ElevatedButton(


                onPressed:
                registerDoctor,


                child:
                const Text(

                  "REGISTER",

                ),


              ),

            ),


          ],

        ),

      ),

    );

  }

}