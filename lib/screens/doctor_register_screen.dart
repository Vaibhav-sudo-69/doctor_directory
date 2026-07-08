import 'package:flutter/material.dart';

import '../models/doctor_request.dart';
import '../data/doctor_request_data.dart';


class DoctorRegisterScreen extends StatefulWidget {

  const DoctorRegisterScreen({super.key});


  @override
  State<DoctorRegisterScreen> createState() =>
      _DoctorRegisterScreenState();

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

  final qualificationController =
  TextEditingController();

  final experienceController =
  TextEditingController();

  final addressController =
  TextEditingController();

  final timingsController =
  TextEditingController();





  void registerDoctor() async {


    if (
    nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        specializationController.text.isEmpty ||
        clinicController.text.isEmpty ||
        phoneController.text.isEmpty ||
        qualificationController.text.isEmpty ||
        experienceController.text.isEmpty ||
        addressController.text.isEmpty ||
        timingsController.text.isEmpty
    ) {


      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            "Fill all details",
          ),

        ),

      );

      return;

    }







    DoctorRequest request =
    DoctorRequest(


      name:
      nameController.text,


      email:
      emailController.text,


      password:
      passwordController.text,


      specialization:
      specializationController.text,


      clinicName:
      clinicController.text,


      phoneNumber:
      phoneController.text,


      qualification:
      qualificationController.text,


      experience:
      int.parse(
        experienceController.text,
      ),


      address:
      addressController.text,


      timings:
      timingsController.text,


    );







    doctorRequests.add(request);



    await saveDoctorRequests();





    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(

        content: Text(

          "Request sent to Admin ✅",

        ),

      ),

    );






    Navigator.pop(context);


  }









  Widget input(

      String text,

      TextEditingController controller,

      ) {


    return Padding(

      padding:
      const EdgeInsets.only(bottom: 15),



      child: TextField(


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


      appBar: AppBar(

        title:
        const Text(
          "Doctor Registration",
        ),


        backgroundColor:
        Colors.blue,


        foregroundColor:
        Colors.white,

      ),








      body: SingleChildScrollView(


        padding:
        const EdgeInsets.all(20),




        child: Column(


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




            input(
              "Qualification",
              qualificationController,
            ),



            input(
              "Experience (Years)",
              experienceController,
            ),




            input(
              "Address",
              addressController,
            ),




            input(
              "Timings",
              timingsController,
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