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
  Widget _statItem(
      IconData icon,
      String value,
      String title,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [

          Icon(
            icon,
            color: Colors.white,
          ),

          const SizedBox(width: 8),

          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [

              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }


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
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1000;
    final isDesktop = width >= 1000;


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
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          count > 99 ? "99+" : count.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
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



            Container(
              width: double.infinity,
              padding: EdgeInsets.all(
                isMobile ? 18 : 30,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xff1565C0),
                    Color(0xff42A5F5),
                    Color(0xff90CAF9),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.25),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
                borderRadius: BorderRadius.circular(
                  isMobile ? 20 : 28,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                   Text(
                    "Good Afternoon 👋",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: isMobile ? 17 : 22,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    user?.displayName?.isNotEmpty == true
                        ? user!.displayName!
                        : (user?.email?.split('@').first ?? "User"),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 28 : 38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.verified,
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        "Verified Account",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                   Text(
                    "Book appointments with trusted doctors in seconds.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 15 : 18,
                    ),
                  ),

                  const SizedBox(height: 20),

                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("doctors")
                        .snapshots(),
                    builder: (context, doctorSnapshot) {

                      int doctorCount = doctorSnapshot.data?.docs.length ?? 0;

                      return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("appointments")
                            .where(
                          "userEmail",
                          isEqualTo: user!.email,
                        )
                            .where(
                          "status",
                          isEqualTo: "Pending",
                        )
                            .snapshots(),
                        builder: (context, appointmentSnapshot) {

                          int pendingCount =
                              appointmentSnapshot.data?.docs.length ?? 0;

                          return Wrap(
                            spacing: 15,
                            runSpacing: 15,
                            children: [

                              SizedBox(
                                width: isMobile ? width * 0.40 : 220,
                                child: _statItem(
                                  Icons.local_hospital,
                                  "$doctorCount",
                                  "Doctors",
                                ),
                              ),

                              SizedBox(
                                width: isMobile ? width * 0.40 : 220,
                                child: _statItem(
                                  Icons.pending_actions,
                                  "$pendingCount",
                                  "Pending",
                                ),
                              ),

                            ],
                          );
                        },
                      );
                    },
                  ),

                ],
              ),
            ),

            const SizedBox(height: 20),



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
                    itemCount: doctors.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: DoctorCard(
                          doctor: doctors[index],
                        ),
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