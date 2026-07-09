import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class AddDoctorScreen extends StatefulWidget {

  const AddDoctorScreen({super.key});


  @override
  State<AddDoctorScreen> createState() =>
      _AddDoctorScreenState();

}




class _AddDoctorScreenState extends State<AddDoctorScreen> {



  final nameController = TextEditingController();

  final specializationController = TextEditingController();

  final clinicController = TextEditingController();

  final phoneController = TextEditingController();

  final addressController = TextEditingController();






  Future<void> addDoctor() async {



    await FirebaseFirestore.instance
        .collection("doctors")
        .add({


      "name":
      nameController.text,


      "specialization":
      specializationController.text,


      "clinic":
      clinicController.text,


      "phone":
      phoneController.text,


      "address":
      addressController.text,



      "timings":
      "10 AM - 7 PM",


      "qualification":
      "MBBS",


      "experience":
      5,


      "rating":
      5.0,


      "image":
      "assets/doctor.png",


      "reviews":
      [],


    });





    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(

        content:

        Text(
            "Doctor Added Successfully"
        ),

      ),

    );




    Navigator.pop(context);


  }









  Widget inputBox(

      String title,

      TextEditingController controller,

      ){


    return Padding(


      padding:

      const EdgeInsets.only(bottom: 15),




      child: TextField(


        controller:

        controller,



        decoration:

        InputDecoration(


          labelText:

          title,



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

          "Add Doctor",

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






            inputBox(

              "Doctor Name",

              nameController,

            ),






            inputBox(

              "Specialization",

              specializationController,

            ),







            inputBox(

              "Clinic Name",

              clinicController,

            ),








            inputBox(

              "Phone Number",

              phoneController,

            ),








            inputBox(

              "Address",

              addressController,

            ),








            const SizedBox(

              height: 20,

            ),








            SizedBox(



              width:

              double.infinity,





              child: ElevatedButton.icon(



                onPressed:

                addDoctor,




                icon:

                const Icon(

                  Icons.add,

                ),




                label:

                const Text(

                  "ADD DOCTOR",

                ),




              ),



            ),






          ],


        ),


      ),



    );


  }


}