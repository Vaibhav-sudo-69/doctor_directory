import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login_screen.dart';



class DoctorPanelScreen extends StatefulWidget {

  final String doctorId;
  final Map<String,dynamic> doctorData;


  const DoctorPanelScreen({
    super.key,
    required this.doctorId,
    required this.doctorData,
  });



  @override
  State<DoctorPanelScreen> createState()
  => _DoctorPanelScreenState();

}






class _DoctorPanelScreenState
    extends State<DoctorPanelScreen> {





  void updateStatus(
      String id,
      String status,
      ) async {



    await FirebaseFirestore.instance
        .collection("appointments")
        .doc(id)
        .update({


      "status": status,


    });





    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        content:
        Text(

          "Appointment $status",

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
        Text(

          "${widget.doctorData["name"]} Panel",

        ),




        backgroundColor:
        Colors.blue,



        foregroundColor:
        Colors.white,





        actions: [


          IconButton(

            icon:
            const Icon(

              Icons.logout,

            ),




            onPressed: (){


              Navigator.pushAndRemoveUntil(

                context,


                MaterialPageRoute(

                  builder: (_) =>
                  const LoginScreen(),

                ),



                    (route) => false,


              );


            },


          ),


        ],




      ),










      body:
      StreamBuilder<QuerySnapshot>(




        stream:


        FirebaseFirestore.instance

            .collection("appointments")

            .where(

          "doctorEmail",

          isEqualTo:
          widget.doctorData["email"],

        )

            .snapshots(),







        builder:
            (context,snapshot){






          if(snapshot.connectionState
              ==
              ConnectionState.waiting){



            return const Center(

              child:
              CircularProgressIndicator(),

            );


          }








          if(!snapshot.hasData ||
              snapshot.data!.docs.isEmpty){



            return const Center(

              child:
              Text(

                "No Appointment Requests",

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





              final id =

                  appointments[index].id;









              return Card(


                margin:
                const EdgeInsets.all(10),







                child:
                ListTile(






                  title:
                  Text(

                    data["patientName"]
                        ??
                        "",

                  ),









                  subtitle:
                  Column(


                    crossAxisAlignment:
                    CrossAxisAlignment.start,




                    children: [






                      Text(

                        "Phone: ${data["phoneNumber"]}",

                      ),






                      Text(

                        "Date: ${data["date"]}",

                      ),






                      Text(

                        "Time: ${data["time"]}",

                      ),






                      Text(

                        "Status: ${data["status"]}",

                      ),





                    ],


                  ),










                  trailing:


                  data["status"]
                      ==
                      "Pending"



                      ?

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


                          updateStatus(

                            id,

                            "Accepted",

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


                          updateStatus(

                            id,

                            "Rejected",

                          );


                        },


                      ),




                    ],


                  )



                      :


                  Text(

                    data["status"],

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