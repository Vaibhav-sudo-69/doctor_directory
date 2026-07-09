import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'add_doctor_screen.dart';
import 'manage_doctors_screen.dart';
import 'doctor_requests_screen.dart';



class AdminPanelScreen extends StatelessWidget {

  const AdminPanelScreen({super.key});



  Widget dashboardCard(
      String title,
      IconData icon,
      int count,
      ) {


    return Expanded(

      child: Card(

        elevation: 5,


        child: Padding(

          padding:
          const EdgeInsets.all(15),


          child: Column(

            children: [


              Icon(

                icon,

                size: 35,

                color: Colors.blue,

              ),



              const SizedBox(
                height: 10,
              ),



              Text(

                count.toString(),

                style:
                const TextStyle(

                  fontSize: 25,

                  fontWeight:
                  FontWeight.bold,

                ),

              ),




              Text(

                title,

                textAlign:
                TextAlign.center,

              ),


            ],

          ),

        ),

      ),

    );


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
          "Admin Dashboard",
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
            .collection("doctors")
            .snapshots(),



        builder:
            (context, doctorSnapshot){



          return StreamBuilder<QuerySnapshot>(


            stream:

            FirebaseFirestore.instance

                .collection("appointments")

                .snapshots(),





            builder:
                (context, appointmentSnapshot){





              if(!doctorSnapshot.hasData ||
                  !appointmentSnapshot.hasData){



                return const Center(

                  child:
                  CircularProgressIndicator(),

                );

              }






              int doctorCount =
                  doctorSnapshot.data!.docs.length;



              int appointmentCount =
                  appointmentSnapshot.data!.docs.length;








              return SingleChildScrollView(


                padding:
                const EdgeInsets.all(20),



                child: Column(


                  children: [







                    const Icon(

                      Icons.admin_panel_settings,

                      size: 90,

                      color:
                      Colors.blue,

                    ),







                    const SizedBox(
                      height: 20,
                    ),







                    Row(

                      children: [


                        dashboardCard(

                          "Doctors",

                          Icons.medical_services,

                          doctorCount,

                        ),




                        dashboardCard(

                          "Appointments",

                          Icons.calendar_month,

                          appointmentCount,

                        ),


                      ],

                    ),








                    const SizedBox(
                      height:30,
                    ),









                    SizedBox(

                      width:
                      double.infinity,

                      height:
                      55,



                      child:
                      ElevatedButton.icon(


                        icon:
                        const Icon(Icons.add),



                        label:
                        const Text(

                          "ADD DOCTOR",

                        ),




                        onPressed: (){


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
                      height:15,
                    ),








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



                        onPressed: (){


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
                      height:15,
                    ),










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




                        onPressed: (){


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
                      height:15,
                    ),








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




                        onPressed: (){


                          Navigator.pop(context);


                        },


                      ),

                    ),



                  ],

                ),

              );


            },

          );


        },


      ),


    );


  }


}