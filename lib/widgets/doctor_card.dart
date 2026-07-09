import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/doctor.dart';
import '../screens/doctor_details_screen.dart';


class DoctorCard extends StatelessWidget {

  final Doctor doctor;


  const DoctorCard({
    super.key,
    required this.doctor,
  });



  void toggleFavorite() async {

    final user =
        FirebaseAuth.instance.currentUser;


    if(user == null){
      return;
    }


    final favRef =
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.email)
        .collection("favorites")
        .doc(doctor.email);


    final fav =
    await favRef.get();


    if(fav.exists){

      await favRef.delete();

    }else{

      await favRef.set(
        doctor.toJson(),
      );

    }

  }




  void callDoctor() async {


    final Uri phoneUri =
    Uri(
      scheme: "tel",
      path: doctor.phoneNumber,
    );


    if(await canLaunchUrl(phoneUri)){


      await launchUrl(
        phoneUri,
      );


    }

  }






  @override
  Widget build(BuildContext context) {


    final user =
        FirebaseAuth.instance.currentUser;


    return InkWell(

      borderRadius:
      BorderRadius.circular(20),


      onTap: (){

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                DoctorDetailsScreen(
                  doctor: doctor,
                ),
          ),
        );

      },



      child: Card(

        margin:
        const EdgeInsets.only(bottom:18),

        elevation:5,


        shape:
        RoundedRectangleBorder(

          borderRadius:
          BorderRadius.circular(20),

        ),



        child: Padding(

          padding:
          const EdgeInsets.all(16),



          child: Row(

            crossAxisAlignment:
            CrossAxisAlignment.start,


            children: [




              CircleAvatar(

                radius:38,

                backgroundImage:
                AssetImage(
                  doctor.image,
                ),

              ),



              const SizedBox(width:15),




              Expanded(

                child: Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,


                  children: [




                    Row(

                      children: [


                        Expanded(

                          child: Text(

                            doctor.name,

                            style:
                            const TextStyle(

                              fontSize:20,

                              fontWeight:
                              FontWeight.bold,

                            ),

                          ),

                        ),




                        StreamBuilder(

                          stream:
                          FirebaseFirestore
                              .instance
                              .collection("users")
                              .doc(user?.email)
                              .collection("favorites")
                              .doc(doctor.email)
                              .snapshots(),



                          builder:(context,snapshot){


                            bool fav =
                                snapshot.hasData &&
                                    snapshot.data!.exists;


                            return IconButton(

                              icon: Icon(

                                fav
                                    ? Icons.favorite
                                    : Icons.favorite_border,

                                color:
                                Colors.red,

                              ),


                              onPressed:
                              toggleFavorite,

                            );

                          },

                        ),


                      ],

                    ),






                    StreamBuilder<QuerySnapshot>(


                      stream:
                      FirebaseFirestore
                          .instance
                          .collection("reviews")
                          .where(
                        "doctorEmail",
                        isEqualTo: doctor.email,
                      )
                          .snapshots(),



                      builder:(context,snapshot){


                        if(!snapshot.hasData){

                          return const Text(
                              "⭐ 0.0"
                          );

                        }



                        final reviews =
                            snapshot.data!.docs;


                        double avg = 0;


                        for(var r in reviews){

                          final data =
                          r.data()
                          as Map<String,dynamic>;


                          avg +=
                          data["rating"];

                        }



                        if(reviews.isNotEmpty){

                          avg =
                              avg / reviews.length;

                        }



                        return Text(

                          "⭐ ${avg.toStringAsFixed(1)} (${reviews.length})",

                          style:
                          const TextStyle(
                            fontWeight:
                            FontWeight.bold,
                          ),

                        );

                      },

                    ),






                    const SizedBox(height:8),



                    Text(

                      doctor.specialization,

                      style:
                      const TextStyle(
                        color:Colors.blue,
                      ),

                    ),




                    const SizedBox(height:8),




                    Text(
                      doctor.clinicName,
                    ),




                    const SizedBox(height:8),





                    Text(

                      "${doctor.experience} Years Experience",

                    ),


                  ],

                ),

              ),








              CircleAvatar(

                backgroundColor:
                Colors.green.shade100,


                child:
                IconButton(

                  icon:
                  const Icon(

                    Icons.call,

                    color:
                    Colors.green,

                  ),


                  onPressed:
                  callDoctor,

                ),

              ),



            ],

          ),

        ),

      ),

    );

  }

}