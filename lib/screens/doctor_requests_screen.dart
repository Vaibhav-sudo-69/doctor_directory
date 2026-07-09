import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DoctorRequestsScreen extends StatefulWidget {

  const DoctorRequestsScreen({super.key});


  @override
  State<DoctorRequestsScreen> createState()
  => _DoctorRequestsScreenState();

}




class _DoctorRequestsScreenState
    extends State<DoctorRequestsScreen> {




  void acceptDoctor(
      String id,
      Map<String, dynamic> doctor,
      ) async {


    // Add approved doctor
    await FirebaseFirestore.instance
        .collection("doctors")
        .add({

      "name": doctor["name"],

      "email": doctor["email"],

      "password": doctor["password"],

      "specialization":
      doctor["specialization"],

      "clinicName":
      doctor["clinicName"],

      "phoneNumber":
      doctor["phoneNumber"],

      "rating": 0,

      "createdAt":
      DateTime.now(),

    });





    // Remove request
    await FirebaseFirestore.instance
        .collection("doctor_requests")
        .doc(id)
        .delete();





    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(

        content:
        Text("Doctor Approved ✅"),

      ),

    );


  }









  void rejectDoctor(String id) async {


    await FirebaseFirestore.instance
        .collection("doctor_requests")
        .doc(id)
        .delete();




    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(

        content:
        Text("Doctor Rejected ❌"),

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
          "Doctor Requests",
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
            .collection("doctor_requests")
            .snapshots(),




        builder:
            (context, snapshot) {


          if(snapshot.connectionState
              ==
              ConnectionState.waiting) {


            return const Center(

              child:
              CircularProgressIndicator(),

            );


          }






          if(!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {


            return const Center(

              child:
              Text(
                "No Doctor Requests",
              ),

            );


          }







          final requests =
              snapshot.data!.docs;





          return ListView.builder(


            itemCount:
            requests.length,



            itemBuilder:
                (context,index){



              final doc =
              requests[index];


              final doctor =
              doc.data()
              as Map<String,dynamic>;





              return Card(

                margin:
                const EdgeInsets.all(10),



                child:
                ListTile(


                  leading:
                  const Icon(

                    Icons.medical_services,

                    color:
                    Colors.blue,

                  ),






                  title:
                  Text(

                    doctor["name"],

                  ),






                  subtitle:
                  Column(

                    crossAxisAlignment:
                    CrossAxisAlignment.start,


                    children: [


                      Text(
                        doctor["specialization"],
                      ),


                      Text(
                        doctor["clinicName"],
                      ),


                      Text(
                        doctor["email"],
                      ),


                    ],

                  ),







                  trailing:
                  Row(

                    mainAxisSize:
                    MainAxisSize.min,


                    children: [





                      IconButton(


                        icon:
                        const Icon(

                          Icons.check,

                          color:
                          Colors.green,

                        ),



                        onPressed: (){


                          acceptDoctor(

                            doc.id,

                            doctor,

                          );


                        },

                      ),








                      IconButton(


                        icon:
                        const Icon(

                          Icons.close,

                          color:
                          Colors.red,

                        ),




                        onPressed: (){


                          rejectDoctor(

                            doc.id,

                          );


                        },

                      ),



                    ],

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