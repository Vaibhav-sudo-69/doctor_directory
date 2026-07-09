import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/doctor.dart';
import '../widgets/doctor_card.dart';


class FavoriteScreen extends StatelessWidget {

  const FavoriteScreen({
    super.key,
  });


  @override
  Widget build(BuildContext context) {


    final user =
        FirebaseAuth.instance.currentUser;


    if (user == null) {

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
          "Favorite Doctors ❤️",
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

            .collection("users")

            .doc(user.email)

            .collection("favorites")

            .snapshots(),






        builder:
            (context, snapshot) {




          if (snapshot.connectionState
              ==
              ConnectionState.waiting) {


            return const Center(

              child:
              CircularProgressIndicator(),

            );


          }








          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {


            return const Center(

              child:
              Text(

                "No favorite doctors yet ❤️",

                style:
                TextStyle(
                  fontSize: 18,
                ),

              ),

            );


          }










          final doctors =
              snapshot.data!.docs;










          return ListView.builder(


            padding:
            const EdgeInsets.all(16),


            itemCount:
            doctors.length,



            itemBuilder:
                (context, index) {




              final data =
              doctors[index].data()
              as Map<String,dynamic>;






              Doctor doctor =
              Doctor.fromJson(data);







              return DoctorCard(

                doctor: doctor,

              );



            },


          );



        },


      ),


    );


  }


}