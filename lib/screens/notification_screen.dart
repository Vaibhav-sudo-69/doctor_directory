import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class NotificationScreen extends StatefulWidget {

  const NotificationScreen({super.key});


  @override
  State<NotificationScreen> createState()
  => _NotificationScreenState();

}





class _NotificationScreenState
    extends State<NotificationScreen> {




  @override
  void initState() {

    super.initState();


    markNotificationsRead();

  }






  void markNotificationsRead() async {


    final user =
        FirebaseAuth.instance.currentUser;



    if(user == null){
      return;
    }






    final result =
    await FirebaseFirestore.instance

        .collection("appointments")

        .where(

      "userEmail",

      isEqualTo:
      user.email,

    )

        .get();







    for(var doc in result.docs){



      final data =
      doc.data();




      if(data["status"] == "Accepted"

          ||

          data["status"] == "Rejected"){



        doc.reference.update({

          "isRead": true,

        });



      }



    }



  }









  @override
  Widget build(BuildContext context) {



    final user =
        FirebaseAuth.instance.currentUser;






    return Scaffold(


      backgroundColor:
      const Color(0xffF5F7FA),






      appBar:
      AppBar(


        title:
        const Text(

          "Notifications 🔔",

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
          user!.email,

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









          if(!snapshot.hasData){


            return const Center(

              child:
              Text(
                "No Notifications",
              ),

            );


          }









          final notifications =

          snapshot.data!.docs.where((doc){



            final data =
            doc.data()
            as Map<String,dynamic>;



            return

              data["status"] == "Accepted"

                  ||

                  data["status"] == "Rejected";



          }).toList();









          if(notifications.isEmpty){


            return const Center(

              child:
              Text(

                "No Notifications 🔔",

                style:
                TextStyle(

                  fontSize:20,

                ),

              ),

            );


          }










          return ListView.builder(



            itemCount:
            notifications.length,




            itemBuilder:(context,index){






              final data =

              notifications[index].data()

              as Map<String,dynamic>;





              bool accepted =

                  data["status"] == "Accepted";









              return Card(


                color:
                const Color(0xffFAEEFF),


                margin:
                const EdgeInsets.all(12),





                child:
                ListTile(





                  leading:
                  Icon(

                    accepted
                        ?
                    Icons.check_circle
                        :
                    Icons.cancel,


                    color:

                    accepted
                        ?
                    Colors.green
                        :
                    Colors.red,


                    size:35,

                  ),









                  title:
                  Text(


                    accepted
                        ?

                    "Appointment Accepted ✅"

                        :

                    "Appointment Rejected ❌",




                    style:
                    const TextStyle(

                      fontWeight:
                      FontWeight.bold,

                    ),

                  ),







                  subtitle:
                  Text(


                    "${data["doctorName"]}\n"
                        "${data["date"]}   ${data["time"]}",


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