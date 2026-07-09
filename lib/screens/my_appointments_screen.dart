import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MyAppointmentsScreen extends StatelessWidget {

  const MyAppointmentsScreen({super.key});


  @override
  Widget build(BuildContext context) {


    final user =
        FirebaseAuth.instance.currentUser;



    if(user == null){

      return const Scaffold(

        body: Center(

          child: Text(
            "Please Login First",
          ),

        ),

      );

    }





    return Scaffold(


      backgroundColor:
      const Color(0xffF5F7FA),



      appBar: AppBar(

        title: const Text(
          "My Appointments",
        ),

        backgroundColor:
        Colors.blue,

        foregroundColor:
        Colors.white,

      ),








      body:
      StreamBuilder<QuerySnapshot>(


        stream:
        FirebaseFirestore.instance

            .collection("appointments")

            .where(

          "userEmail",

          isEqualTo:
          user.email,

        )

            .snapshots(),







        builder: (context, snapshot){



          if(snapshot.connectionState ==
              ConnectionState.waiting){


            return const Center(

              child:
              CircularProgressIndicator(),

            );

          }






          if(snapshot.hasError){

            return Center(

              child: Text(

                snapshot.error.toString(),

              ),

            );

          }








          if(!snapshot.hasData ||
              snapshot.data!.docs.isEmpty){


            return const Center(

              child: Text(

                "No Appointments Yet",

                style: TextStyle(
                  fontSize: 20,
                ),

              ),

            );

          }







          final appointments =
              snapshot.data!.docs;








          return ListView.builder(


            itemCount:
            appointments.length,



            itemBuilder:
                (context,index){



              final data =
              appointments[index].data()
              as Map<String,dynamic>;








              return Card(

                margin:
                const EdgeInsets.all(12),



                child:
                ListTile(



                  leading:
                  const Icon(

                    Icons.calendar_month,

                    color:
                    Colors.blue,

                  ),








                  title:
                  Text(

                    data["doctorName"]
                        ?? "",

                  ),







                  subtitle:
                  Text(

                    "Patient: ${data["patientName"] ?? ""}\n"
                        "Date: ${data["date"] ?? ""}\n"
                        "Time: ${data["time"] ?? ""}\n"
                        "Status: ${data["status"] ?? "Pending"}",

                  ),









                  trailing:
                  IconButton(


                    icon:
                    const Icon(

                      Icons.delete,

                      color:
                      Colors.red,

                    ),





                    onPressed: () async {


                      await FirebaseFirestore
                          .instance

                          .collection(
                          "appointments"
                      )

                          .doc(
                          appointments[index].id
                      )

                          .delete();





                      ScaffoldMessenger.of(context)
                          .showSnackBar(

                        const SnackBar(

                          content:
                          Text(
                            "Appointment Cancelled ✅",
                          ),

                        ),

                      );


                    },


                  ),


                ),


              );


            },


          );

        },


      ),


    );


  }

}