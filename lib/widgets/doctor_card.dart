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
        .doc(doctor.name);


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

        elevation:4,
        color: Colors.white,


        shape:
        RoundedRectangleBorder(

          borderRadius:
          BorderRadius.circular(20),

        ),



        child: Padding(

          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),



          child: Row(

            crossAxisAlignment:
            CrossAxisAlignment.start,


            children: [




              Stack(
                children: [

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.medical_services,
                        size: 38,
                        color: Colors.blue,
                      ),
                    ),
                  ),

                  Positioned(
                    right: -2,
                    bottom: -2,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.verified,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),

                ],
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
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ),







                      ],

                    ),






                    StreamBuilder<QuerySnapshot>(


                      stream:
                      FirebaseFirestore
                          .instance
                          .collection("reviews")
                          .where(
                        "doctorName",
                        isEqualTo: doctor.name,
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



                        return Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "${avg.toStringAsFixed(1)} (${reviews.length} Reviews)",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xff4B5563),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        );

                      },

                    ),






                    const SizedBox(height:8),



                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        doctor.specialization,
                        style: TextStyle(
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),

                    const SizedBox(height: 6),

                    Row(
                      children: [
                        const Icon(
                          Icons.local_hospital,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            doctor.clinicName,
                            style: const TextStyle(
                              color: Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Row(
                      children: [
                        const Icon(
                          Icons.work_outline,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "${doctor.experience} Years Experience",
                          style: const TextStyle(
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.redAccent,
                          size: 16,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            doctor.address,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [

                        Expanded(
                          child: StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("users")
                                .doc(user?.email)
                                .collection("favorites")
                                .doc(doctor.name)
                                .snapshots(),

                            builder: (context, snapshot) {

                              bool fav =
                                  snapshot.hasData &&
                                      snapshot.data!.exists;

                              return SizedBox(
                                height: 48,
                                child: OutlinedButton.icon(

                                  onPressed: toggleFavorite,

                                  icon: Icon(
                                    fav
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                  ),

                                  label: Text(
                                    fav
                                        ? "Favorited"
                                        : "Favorite",
                                  ),

                                  style: OutlinedButton.styleFrom(
                                    foregroundColor:
                                    fav ? Colors.red : Colors.blue,
                                  ),

                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: SizedBox(
                            height: 48,
                          child: OutlinedButton.icon(
                            onPressed: callDoctor,
                            icon: const Icon(Icons.call),
                            label: Text("Call Doctor"),
                          ),
                        ),
                        ),

                      ],
                    ),

                    const SizedBox(height: 14),

/*
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DoctorDetailsScreen(
                                doctor: doctor,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.calendar_month),
                        label: const Text(
                          "Book Appointment",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff1976D2),

                          elevation: 3,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    */


                  ],

                ),

              ),












            ],

          ),

        ),

      ),

    );

  }

}