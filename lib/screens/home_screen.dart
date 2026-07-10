import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/doctor.dart';

import '../widgets/search_bar_widgets.dart';
import '../widgets/doctor_card.dart';
import '../widgets/category_chip.dart';

import 'profile_screen.dart';
import 'favorite_screen.dart';
import 'my_appointments_screen.dart';
import 'notification_screen.dart';



class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState()
  => _HomeScreenState();

}





class _HomeScreenState extends State<HomeScreen> {


  String selectedCategory = "All";

  String searchText = "";



  final List<String> categories = [

    "All",
    "Physician",
    "Dentist",
    "Cardiologist",

  ];




  void searchDoctor(String value){

    setState((){

      searchText =
          value.toLowerCase();

    });

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
          "City Doctor Directory",
        ),


        backgroundColor:
        Colors.blue,


        foregroundColor:
        Colors.white,



        actions: [





          // 🔔 NOTIFICATION


          StreamBuilder<QuerySnapshot>(


            stream:

            FirebaseFirestore.instance

                .collection("appointments")

                .where(

              "userEmail",

              isEqualTo:
              user!.email,

            )

                .where(

              "isRead",

              isEqualTo:
              false,

            )

                .snapshots(),




            builder:(context,snapshot){



              int count = 0;



              if(snapshot.hasData){


                count =
                    snapshot.data!.docs.where((doc){


                      final data =
                      doc.data()
                      as Map<String,dynamic>;



                      return

                        data["status"] == "Accepted"

                            ||

                            data["status"] == "Rejected";


                    }).length;


              }








              return Stack(

                children: [




                  IconButton(


                    icon:
                    const Icon(
                      Icons.notifications,
                    ),



                    onPressed:(){



                      Navigator.push(

                        context,


                        MaterialPageRoute(

                          builder: (_) =>

                          const NotificationScreen(),

                        ),

                      );



                    },


                  ),







                  if(count > 0)


                    Positioned(


                      right:6,

                      top:6,



                      child:
                      Container(


                        padding:
                        const EdgeInsets.all(5),



                        decoration:
                        const BoxDecoration(

                          color:
                          Colors.red,

                          shape:
                          BoxShape.circle,

                        ),



                        child:
                        Text(


                          count.toString(),


                          style:
                          const TextStyle(

                            color:
                            Colors.white,

                            fontSize:10,

                          ),


                        ),


                      ),


                    ),


                ],


              );



            },


          ),







          IconButton(

            icon:
            const Icon(Icons.person),


            onPressed:(){


              Navigator.push(

                context,

                MaterialPageRoute(

                  builder: (_) =>
                  const ProfileScreen(),

                ),

              );


            },

          ),







          IconButton(

            icon:
            const Icon(Icons.favorite),


            onPressed:(){


              Navigator.push(

                context,


                MaterialPageRoute(

                  builder: (_) =>
                  const FavoriteScreen(),

                ),

              );


            },

          ),









          // 📅 APPOINTMENT


          StreamBuilder<QuerySnapshot>(


            stream:

            FirebaseFirestore.instance

                .collection("appointments")

                .where(

              "userEmail",

              isEqualTo:
              user.email,

            )

                .where(

              "status",

              isEqualTo:
              "Pending",

            )

                .snapshots(),




            builder:(context,snapshot){


              int count = 0;


              if(snapshot.hasData){

                count =
                    snapshot.data!.docs.length;

              }



              return Stack(

                children: [



                  IconButton(

                    icon:
                    const Icon(
                      Icons.calendar_month,
                    ),



                    onPressed:(){


                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>

                          const MyAppointmentsScreen(),

                        ),

                      );


                    },

                  ),






                  if(count > 0)


                    Positioned(

                      right:6,

                      top:6,


                      child:
                      CircleAvatar(

                        radius:8,


                        backgroundColor:
                        Colors.red,


                        child:
                        Text(

                          count.toString(),

                          style:
                          const TextStyle(

                            fontSize:10,

                            color:
                            Colors.white,

                          ),

                        ),

                      ),

                    ),



                ],

              );


            },

          ),



        ],

      ),









      body:
      Padding(

        padding:
        const EdgeInsets.all(16),


        child:
        Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,


          children: [



            const Text(

              "👋 Hello",

              style:
              TextStyle(

                fontSize:28,

                fontWeight:
                FontWeight.bold,

              ),

            ),



            const SizedBox(height:20),



            SearchBarWidget(

              onChanged:
              searchDoctor,

            ),




            const SizedBox(height:15),




            SizedBox(

              height:50,


              child:
              ListView.builder(

                scrollDirection:
                Axis.horizontal,


                itemCount:
                categories.length,


                itemBuilder:(context,index){


                  final category =
                  categories[index];



                  return CategoryChip(

                    text:
                    category,


                    isSelected:
                    selectedCategory == category,


                    onTap:(){


                      setState((){

                        selectedCategory =
                            category;

                      });


                    },

                  );


                },

              ),

            ),





            const SizedBox(height:20),





            Expanded(


              child:
              StreamBuilder<QuerySnapshot>(


                stream:

                FirebaseFirestore.instance
                    .collection("doctors")
                    .snapshots(),



                builder:(context,snapshot){



                  if(!snapshot.hasData){


                    return const Center(

                      child:
                      CircularProgressIndicator(),

                    );


                  }





                  List<Doctor> doctors =


                  snapshot.data!.docs.map((doc){



                    return Doctor.fromJson(

                      doc.data()
                      as Map<String,dynamic>,

                    );


                  }).toList();






                  doctors =

                      doctors.where((doctor){



                        return


                          doctor.name
                              .toLowerCase()
                              .contains(searchText)


                              &&


                              (

                                  selectedCategory=="All"

                                      ||

                                      doctor.specialization
                                          .toLowerCase()
                                          ==

                                          selectedCategory
                                              .toLowerCase()

                              );


                      }).toList();







                  return ListView.builder(

                    itemCount:
                    doctors.length,


                    itemBuilder:(context,index){


                      return DoctorCard(

                        doctor:
                        doctors[index],

                      );


                    },


                  );


                },

              ),

            ),



          ],

        ),

      ),

    );


  }

}