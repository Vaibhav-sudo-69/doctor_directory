import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/doctor.dart';
import 'appointment_screen.dart';


class DoctorDetailsScreen extends StatefulWidget {

  final Doctor doctor;

  const DoctorDetailsScreen({
    super.key,
    required this.doctor,
  });


  @override
  State<DoctorDetailsScreen> createState()
  => _DoctorDetailsScreenState();

}





class _DoctorDetailsScreenState
    extends State<DoctorDetailsScreen> {





  void openMap() async {

    final Uri url = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=${widget.doctor.address}",
    );


    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );

  }







  void callDoctor() async {

    final Uri phone =
    Uri.parse(
      "tel:${widget.doctor.phoneNumber}",
    );


    await launchUrl(phone);

  }








  Widget infoCard({

    required IconData icon,
    required String title,
    required String value,
    Widget? trailing,

  }) {


    return Card(

      color:
      const Color(0xffFAEEFF),


      margin:
      const EdgeInsets.only(bottom:12),


      child:
      ListTile(

        leading:
        Icon(icon),


        title:
        Text(title),


        subtitle:
        Text(value),


        trailing:
        trailing,

      ),

    );

  }










  void addReviewDialog() {


    final nameController =
    TextEditingController();


    final reviewController =
    TextEditingController();


    int rating = 5;




    showDialog(

      context: context,


      builder: (context) {


        return StatefulBuilder(


          builder: (context, setDialogState) {


            return AlertDialog(


              title:
              const Text(
                "Add Review ⭐",
              ),




              content:
              Column(

                mainAxisSize:
                MainAxisSize.min,


                children: [



                  TextField(

                    controller:
                    nameController,


                    decoration:
                    const InputDecoration(

                      labelText:
                      "Your Name",

                      prefixIcon:
                      Icon(Icons.person),

                    ),

                  ),






                  TextField(

                    controller:
                    reviewController,


                    decoration:
                    const InputDecoration(

                      labelText:
                      "Write Review",

                      prefixIcon:
                      Icon(Icons.edit),

                    ),

                  ),






                  const SizedBox(
                    height: 15,
                  ),






                  Row(

                    mainAxisAlignment:
                    MainAxisAlignment.center,


                    children:

                    List.generate(5, (index) {


                      return IconButton(


                        icon:
                        Icon(

                          index < rating

                              ? Icons.star

                              : Icons.star_border,


                          color:
                          Colors.orange,

                        ),




                        onPressed: () {


                          setDialogState(() {


                            rating =
                                index + 1;


                          });


                        },

                      );


                    }),

                  ),


                ],

              ),







              actions: [



                ElevatedButton(


                  onPressed: () async {


                    if(
                    nameController.text.isEmpty ||
                        reviewController.text.isEmpty
                    ){


                      return;


                    }





                    await FirebaseFirestore
                        .instance
                        .collection("reviews")
                        .add({



                      "doctorEmail":
                      widget.doctor.email,



                      "userName":
                      nameController.text.trim(),



                      "reviewText":
                      reviewController.text.trim(),



                      "rating":
                      rating,



                      "createdAt":
                      DateTime.now(),



                    });






                    Navigator.pop(context);



                    ScaffoldMessenger.of(context)
                        .showSnackBar(


                      const SnackBar(

                        content:
                        Text(
                          "Review Added ⭐",
                        ),

                      ),

                    );


                  },



                  child:
                  const Text(
                    "Submit",
                  ),

                ),


              ],


            );


          },


        );


      },

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
        Text(widget.doctor.name),


        backgroundColor:
        Colors.blue,


        foregroundColor:
        Colors.white,

      ),







      body:
      SingleChildScrollView(


        padding:
        const EdgeInsets.all(20),



        child:
        Column(


          children: [






            infoCard(

              icon:
              Icons.school,

              title:
              "Qualification",

              value:
              widget.doctor.qualification,

            ),






            infoCard(

              icon:
              Icons.work,

              title:
              "Experience",

              value:
              "${widget.doctor.experience} Years",

            ),






            infoCard(

              icon:
              Icons.local_hospital,

              title:
              "Clinic",

              value:
              widget.doctor.clinicName,

            ),






            infoCard(

              icon:
              Icons.location_on,


              title:
              "Address",


              value:
              widget.doctor.address,



              trailing:
              IconButton(

                icon:
                const Icon(

                  Icons.map,

                  color:
                  Colors.blue,

                ),


                onPressed:
                openMap,

              ),

            ),






            infoCard(

              icon:
              Icons.access_time,


              title:
              "Timing",


              value:
              widget.doctor.timings,

            ),






            infoCard(

              icon:
              Icons.phone,


              title:
              "Phone",


              value:
              widget.doctor.phoneNumber,

            ),







            ElevatedButton.icon(


              onPressed:
              addReviewDialog,


              icon:
              const Icon(
                Icons.star,
              ),


              label:
              const Text(
                "ADD REVIEW",
              ),

            ),








            const SizedBox(
              height:20,
            ),








            const Align(

              alignment:
              Alignment.centerLeft,


              child:
              Text(

                "Patient Reviews ⭐",


                style:
                TextStyle(

                  fontSize:22,

                  fontWeight:
                  FontWeight.bold,

                ),

              ),

            ),







            StreamBuilder<QuerySnapshot>(


              stream:

              FirebaseFirestore.instance

                  .collection("reviews")

                  .where(

                "doctorEmail",

                isEqualTo:
                widget.doctor.email,

              )

                  .snapshots(),





              builder: (context, snapshot) {



                if(!snapshot.hasData){


                  return const Center(

                    child:
                    CircularProgressIndicator(),

                  );


                }





                final reviews =
                    snapshot.data!.docs;





                if(reviews.isEmpty){


                  return const Text(

                    "No Reviews Yet",

                  );


                }







                return ListView.builder(


                  shrinkWrap: true,


                  physics:
                  const NeverScrollableScrollPhysics(),


                  itemCount:
                  reviews.length,



                  itemBuilder: (context,index){



                    final data =
                    reviews[index].data()
                    as Map<String,dynamic>;




                    int rating =
                        data["rating"] ?? 0;




                    return Card(


                      color:
                      const Color(0xffFAEEFF),



                      margin:
                      const EdgeInsets.only(
                        bottom: 12,
                      ),




                      child:
                      ListTile(



                        leading:
                        const Icon(

                          Icons.person,

                          size: 35,

                        ),





                        title:
                        Text(

                          data["userName"] ?? "User",


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




                            Row(

                              children:

                              List.generate(5,(index){


                                return Icon(

                                  index < rating

                                      ? Icons.star

                                      : Icons.star_border,


                                  color:
                                  Colors.orange,


                                  size:18,

                                );


                              }),

                            ),






                            const SizedBox(
                              height:5,
                            ),






                            Text(

                              data["reviewText"] ?? "",

                            ),




                          ],

                        ),




                      ),


                    );



                  },


                );



              },


            ),








            SizedBox(

              width:
              double.infinity,


              child:
              ElevatedButton.icon(

                icon:
                const Icon(Icons.call),


                label:
                const Text(
                  "CALL NOW",
                ),


                onPressed:
                callDoctor,

              ),

            ),








            SizedBox(

              width:
              double.infinity,


              child:
              ElevatedButton.icon(


                icon:
                const Icon(
                  Icons.calendar_month,
                ),


                label:
                const Text(
                  "BOOK APPOINTMENT",
                ),



                onPressed: (){


                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) =>
                          AppointmentScreen(

                            doctor:
                            widget.doctor,

                          ),

                    ),

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