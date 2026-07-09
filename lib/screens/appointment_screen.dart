import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/doctor.dart';


class AppointmentScreen extends StatefulWidget {

  final Doctor doctor;


  const AppointmentScreen({
    super.key,
    required this.doctor,
  });


  @override
  State<AppointmentScreen> createState()
  => _AppointmentScreenState();

}




class _AppointmentScreenState
    extends State<AppointmentScreen> {


  final nameController =
  TextEditingController();

  final phoneController =
  TextEditingController();

  final dateController =
  TextEditingController();

  final timeController =
  TextEditingController();


  bool loading = false;





  void bookAppointment() async {


    if(
    nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        dateController.text.isEmpty ||
        timeController.text.isEmpty
    ){


      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
          Text("Please fill all details ❌"),

        ),

      );


      return;

    }





    if(phoneController.text.length != 10){


      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
          Text("Enter valid phone number ❌"),

        ),

      );


      return;

    }





    setState(() {

      loading = true;

    });





    await FirebaseFirestore.instance
        .collection("appointments")
        .add({



      "doctorName":
      widget.doctor.name,


      "doctorEmail":
      widget.doctor.email,


      "specialization":
      widget.doctor.specialization,


      "patientName":
      nameController.text.trim(),


      "phoneNumber":
      phoneController.text.trim(),


      "date":
      dateController.text,


      "time":
      timeController.text,



      // CURRENT LOGIN USER EMAIL
      "userEmail":
      FirebaseAuth.instance
          .currentUser!
          .email,



      "status":
      "Pending",



      "createdAt":
      DateTime.now(),


    });






    setState(() {

      loading = false;

    });






    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(

        content:
        Text(
          "Appointment Booked Successfully ✅",
        ),

      ),

    );



    Navigator.pop(context);



  }









  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor:
      const Color(0xffF5F7FA),



      appBar:
      AppBar(

        title:
        const Text(
          "Book Appointment",
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

          crossAxisAlignment:
          CrossAxisAlignment.start,


          children: [



            Text(

              widget.doctor.name,


              style:
              const TextStyle(

                fontSize:26,

                fontWeight:
                FontWeight.bold,

              ),

            ),





            const SizedBox(
              height:5,
            ),





            Text(

              widget.doctor.specialization,


              style:
              const TextStyle(

                color:
                Colors.blue,

                fontSize:17,

              ),

            ),






            const SizedBox(
              height:30,
            ),






            TextField(

              controller:
              nameController,


              decoration:
              const InputDecoration(

                labelText:
                "Patient Name",

                prefixIcon:
                Icon(Icons.person),

                border:
                OutlineInputBorder(),

              ),

            ),






            const SizedBox(
              height:20,
            ),






            TextField(

              controller:
              phoneController,


              keyboardType:
              TextInputType.phone,


              decoration:
              const InputDecoration(

                labelText:
                "Phone Number",

                prefixIcon:
                Icon(Icons.phone),

                border:
                OutlineInputBorder(),

              ),

            ),






            const SizedBox(
              height:20,
            ),






            TextField(

              controller:
              dateController,


              readOnly:true,


              onTap: () async {


                DateTime? date =
                await showDatePicker(

                  context: context,

                  firstDate:
                  DateTime.now(),

                  lastDate:
                  DateTime(2030),

                  initialDate:
                  DateTime.now(),

                );



                if(date != null){


                  dateController.text =
                  "${date.day}/${date.month}/${date.year}";

                }


              },



              decoration:
              const InputDecoration(

                labelText:
                "Appointment Date",

                prefixIcon:
                Icon(Icons.calendar_month),

                border:
                OutlineInputBorder(),

              ),

            ),






            const SizedBox(
              height:20,
            ),






            TextField(

              controller:
              timeController,


              readOnly:true,


              onTap: () async {


                TimeOfDay? time =
                await showTimePicker(

                  context:context,

                  initialTime:
                  TimeOfDay.now(),

                );



                if(time != null){

                  timeController.text =
                      time.format(context);

                }


              },



              decoration:
              const InputDecoration(

                labelText:
                "Appointment Time",

                prefixIcon:
                Icon(Icons.access_time),

                border:
                OutlineInputBorder(),

              ),

            ),








            const Spacer(),








            SizedBox(

              width:
              double.infinity,

              height:55,


              child:
              ElevatedButton(


                onPressed:
                loading
                    ? null
                    : bookAppointment,



                child:
                loading

                    ?

                const CircularProgressIndicator()


                    :

                const Text(

                  "CONFIRM APPOINTMENT",

                  style:
                  TextStyle(

                    fontSize:17,

                  ),

                ),

              ),

            ),


          ],

        ),

      ),


    );

  }


}