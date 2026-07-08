import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/doctor.dart';
import '../widgets/search_bar_widgets.dart';
import '../widgets/doctor_card.dart';
import '../widgets/category_chip.dart';

import 'profile_screen.dart';
import 'favorite_screen.dart';
import 'my_appointments_screen.dart';


class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();

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




  void searchDoctor(String value) {

    setState(() {

      searchText = value.toLowerCase();

    });

  }





  @override
  Widget build(BuildContext context) {


    return Scaffold(


      backgroundColor: const Color(0xffF5F7FA),



      appBar: AppBar(


        elevation: 0,


        backgroundColor: Colors.blue,


        foregroundColor: Colors.white,


        title: const Text(

          "City Doctor Directory",

        ),



        actions: [


          IconButton(

            icon: const Icon(Icons.person),

            onPressed: () {

              Navigator.push(

                context,

                MaterialPageRoute(

                  builder: (_) => const ProfileScreen(),

                ),

              );

            },

          ),





          IconButton(

            icon: const Icon(Icons.favorite),


            onPressed: () {


              Navigator.push(

                context,

                MaterialPageRoute(

                  builder: (_) => FavoriteScreen(

                    favoriteDoctors: const [],

                  ),

                ),

              );


            },

          ),





          IconButton(

            icon: const Icon(Icons.calendar_month),


            onPressed: () {


              Navigator.push(

                context,

                MaterialPageRoute(

                  builder: (_) =>
                  const MyAppointmentsScreen(),

                ),

              );


            },

          ),



        ],

      ),






      body: Padding(


        padding: const EdgeInsets.all(16),



        child: Column(


          crossAxisAlignment: CrossAxisAlignment.start,


          children: [




            const Text(

              "👋 Hello ",


              style: TextStyle(

                fontSize: 28,

                fontWeight: FontWeight.bold,

              ),

            ),




            const SizedBox(height: 20),




            SearchBarWidget(

              onChanged: searchDoctor,

            ),




            const SizedBox(height: 15),





            SizedBox(


              height: 50,


              child: ListView.builder(


                scrollDirection: Axis.horizontal,


                itemCount: categories.length,


                itemBuilder: (context, index) {


                  final category = categories[index];



                  return CategoryChip(


                    text: category,


                    isSelected:

                    selectedCategory == category,


                    onTap: () {


                      setState(() {


                        selectedCategory = category;


                      });


                    },


                  );


                },

              ),

            ),






            const SizedBox(height: 20),






            Expanded(


              child: StreamBuilder(


                stream: FirebaseFirestore.instance

                    .collection("doctors")

                    .snapshots(),




                builder: (context, snapshot) {



                  if (!snapshot.hasData) {


                    return const Center(

                      child: CircularProgressIndicator(),

                    );


                  }




                  final firebaseDoctors = snapshot.data!.docs;




                  List<Doctor> doctors = firebaseDoctors.map((doc) {


                    final data = doc.data();



                    return Doctor(


                      name: data["name"] ?? "",


                      specialization:

                      data["specialization"] ?? "",



                      clinicName:

                      data["clinic"] ?? "",



                      phoneNumber:

                      data["phone"] ?? "",



                      address:

                      data["address"] ?? "",



                      timings:

                      data["timings"] ?? "",



                      experience:

                      data["experience"] ?? 0,



                      qualification:

                      data["qualification"] ?? "",



                      image:

                      data["image"] ?? "",



                      rating:

                      (data["rating"] ?? 0).toDouble(),



                      reviews: [],


                    );


                  }).toList();







                  doctors = doctors.where((doctor) {



                    bool matchSearch =

                    doctor.name

                        .toLowerCase()

                        .contains(searchText);





                    bool matchCategory =

                        selectedCategory == "All" ||

                            doctor.specialization

                                .toLowerCase()

                                ==

                                selectedCategory.toLowerCase();




                    return matchSearch && matchCategory;


                  }).toList();







                  return ListView.builder(


                    itemCount: doctors.length,


                    itemBuilder: (context, index) {


                      return DoctorCard(

                        doctor: doctors[index],

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