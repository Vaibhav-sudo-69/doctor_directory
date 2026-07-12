import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class MyAppointmentsScreen extends StatefulWidget {
  const MyAppointmentsScreen({super.key});

  @override
  State<MyAppointmentsScreen> createState() =>
      _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState
    extends State<MyAppointmentsScreen> {

  String searchText = "";








  Color getStatusColor(String status){


    if(status == "Accepted"){

      return Colors.green;

    }


    if(status == "Rejected"){

      return Colors.red;

    }


    return Colors.orange;


  }






  IconData getStatusIcon(String status){


    if(status == "Accepted"){

      return Icons.check_circle;

    }


    if(status == "Rejected"){

      return Icons.cancel;

    }


    return Icons.access_time;


  }









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







      appBar:
      AppBar(


        title:
        const Text(

          "My Appointments",

        ),



        backgroundColor:
        Colors.blue,



        foregroundColor:
        Colors.white,


      ),










      body: Column(
          children: [

      Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        decoration: const InputDecoration(
          hintText: "Search Doctor...",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          setState(() {
            searchText = value.toLowerCase();
          });
        },
      ),
    ),

    Expanded(
    child: StreamBuilder<QuerySnapshot>(



        stream:


        FirebaseFirestore.instance

            .collection("appointments")


            .where(

          "userEmail",

          isEqualTo:
          user.email,

        )


            .snapshots(),









        builder:(context,snapshot){






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

                "No Appointments Yet",

                style:
                TextStyle(

                  fontSize:20,

                ),

              ),

            );


          }










    final appointments = snapshot.data!.docs.where((doc) {

    final data = doc.data() as Map<String, dynamic>;

    final doctor =
    (data["doctorName"] ?? "").toString().toLowerCase();

    return doctor.contains(searchText);

    }).toList();



          appointments.sort((a,b){


            final dataA =
            a.data() as Map<String,dynamic>;


            final dataB =
            b.data() as Map<String,dynamic>;



            int priority(String status){


              if(status == "Pending"){

                return 0;

              }


              if(status == "Accepted"){

                return 1;

              }


              return 2;


            }




            return priority(
              dataA["status"] ?? "Pending",
            ).compareTo(

              priority(
                dataB["status"] ?? "Pending",
              ),

            );


          });









          return ListView.builder(




            itemCount:
            appointments.length,






            itemBuilder:(context,index){







              final data =


              appointments[index].data()


              as Map<String,dynamic>;






              String status =

                  data["status"]
                      ??
                      "Pending";









              return Card(



                color:
                const Color(0xffFAEEFF),



                margin:
                const EdgeInsets.all(12),



                elevation:4,






                child:
                ListTile(






                  leading:
                  Icon(


                    getStatusIcon(status),



                    color:
                    getStatusColor(status),



                    size:35,


                  ),










                  title:
                  Text(


                    data["doctorName"]
                        ??
                        "",




                    style:
                    const TextStyle(


                      fontWeight:
                      FontWeight.bold,


                    ),



                  ),







                  subtitle:
                  Column(


                    crossAxisAlignment:
                    CrossAxisAlignment.start,



                    children: [




                      Text(

                        "Patient: ${data["patientName"]}",

                      ),




                      Text(

                        "Date: ${data["date"]}",

                      ),




                      Text(

                        "Time: ${data["time"]}",

                      ),







                      const SizedBox(
                        height:5,
                      ),







                      Text(


                        status,



                        style:
                        TextStyle(


                          color:
                          getStatusColor(status),



                          fontWeight:
                          FontWeight.bold,


                        ),


                      ),




                    ],



                  ),










                  trailing: status == "Pending"
                      ? IconButton(
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),
                    onPressed: () async {

                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Cancel Appointment"),
                          content: const Text(
                            "Are you sure you want to cancel this appointment?",
                          ),
                          actions: [

                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text("No"),
                            ),

                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text("Yes"),
                            ),

                          ],
                        ),
                      );

                      if (confirm == true) {

                        await FirebaseFirestore.instance
                            .collection("appointments")
                            .doc(appointments[index].id)
                            .delete();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Appointment Cancelled ✅"),
                          ),
                        );
                      }
                    },
                  )
                      : null,




                ),



              );



            },



          );




        },

    ),
    ),

          ],
      ),

    );



  }


}