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




  Widget infoCard({

    required IconData icon,
    required String title,
    required String value,
    Widget? trailing,

  }){


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






  void openMap() async {


    final url = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=${widget.doctor.address}"
    );


    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );

  }









  void addReviewDialog(){


    final nameController =
    TextEditingController();


    final reviewController =
    TextEditingController();


    int rating = 5;




    showDialog(

      context: context,


      builder: (context){


        return StatefulBuilder(


          builder:(context,setDialogState){


            return AlertDialog(


              title:
              const Text("Add Review ⭐"),



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
                      labelText:"Your Name",
                    ),

                  ),




                  TextField(

                    controller:
                    reviewController,

                    decoration:
                    const InputDecoration(
                      labelText:"Write Review",
                    ),

                  ),





                  Row(

                    mainAxisAlignment:
                    MainAxisAlignment.center,


                    children:

                    List.generate(5,(index){


                      return IconButton(

                        icon:
                        Icon(

                          index < rating
                              ? Icons.star
                              : Icons.star_border,

                          color:
                          Colors.orange,

                        ),


                        onPressed: (){


                          setDialogState((){

                            rating=index+1;

                          });

                        },

                      );

                    }),

                  ),


                ],

              ),






              actions: [


                ElevatedButton(

                  child:
                  const Text("Submit"),


                  onPressed: () async {


                    await FirebaseFirestore.instance
                        .collection("reviews")
                        .add({


                      "doctorEmail":
                      widget.doctor.email,


                      "userName":
                      nameController.text,


                      "reviewText":
                      reviewController.text,


                      "rating":
                      rating,


                    });



                    Navigator.pop(context);


                    ScaffoldMessenger.of(context)
                        .showSnackBar(

                      const SnackBar(

                        content:
                        Text("Review Added ⭐"),

                      ),

                    );

                  },

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



            CircleAvatar(

              radius:60,


              backgroundImage:
              AssetImage(
                widget.doctor.image,
              ),

            ),




            const SizedBox(height:15),





            Text(

              widget.doctor.name,


              style:
              const TextStyle(

                fontSize:28,

                fontWeight:
                FontWeight.bold,

              ),

            ),





            Text(

              widget.doctor.specialization,


              style:
              const TextStyle(

                color:
                Colors.blue,

              ),

            ),




            const SizedBox(height:25),






            infoCard(
              icon:Icons.school,
              title:"Qualification",
              value:widget.doctor.qualification,
            ),


            infoCard(
              icon:Icons.work,
              title:"Experience",
              value:"${widget.doctor.experience} Years",
            ),


            infoCard(
              icon:Icons.local_hospital,
              title:"Clinic",
              value:widget.doctor.clinicName,
            ),



            infoCard(

              icon:Icons.location_on,

              title:"Address",

              value:widget.doctor.address,


              trailing:
              IconButton(

                icon:
                const Icon(
                  Icons.map,
                  color:Colors.blue,
                ),

                onPressed:
                openMap,

              ),

            ),



            infoCard(
              icon:Icons.access_time,
              title:"Timing",
              value:widget.doctor.timings,
            ),



            infoCard(
              icon:Icons.phone,
              title:"Phone",
              value:widget.doctor.phoneNumber,
            ),







            ElevatedButton.icon(

              onPressed:
              addReviewDialog,


              icon:
              const Icon(Icons.star),


              label:
              const Text("ADD REVIEW"),

            ),






            const SizedBox(height:20),





            const Align(

              alignment:
              Alignment.centerLeft,


              child:
              Text(

                "Patient Reviews ⭐",

                style:
                TextStyle(
                  fontSize:22,
                  fontWeight:FontWeight.bold,
                ),

              ),

            ),








            StreamBuilder<QuerySnapshot>(


              stream:

              FirebaseFirestore.instance
                  .collection("reviews")
                  .where(
                "doctorEmail",
                isEqualTo: widget.doctor.email,
              )
                  .snapshots(),



              builder:(context,snapshot){



                if(!snapshot.hasData){

                  return const CircularProgressIndicator();

                }



                final reviews =
                    snapshot.data!.docs;



                return ListView.builder(

                  shrinkWrap:true,

                  physics:
                  const NeverScrollableScrollPhysics(),

                  itemCount:
                  reviews.length,


                  itemBuilder:(context,index){


                    final data =
                    reviews[index].data()
                    as Map<String,dynamic>;



                    int rating =
                    data["rating"];



                    return Card(

                      color:
                      const Color(0xffFAEEFF),


                      child:
                      ListTile(


                        leading:
                        const Icon(Icons.person),



                        title:
                        Text(
                          data["userName"],
                        ),




                        subtitle:
                        Column(

                          crossAxisAlignment:
                          CrossAxisAlignment.start,


                          children:[



                            Row(

                              children:

                              List.generate(5,(i){

                                return Icon(

                                  i < rating
                                      ? Icons.star
                                      : Icons.star_border,


                                  color:
                                  Colors.orange,


                                  size:18,

                                );

                              }),

                            ),



                            Text(
                              data["reviewText"],
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

              width:double.infinity,

              child:
              ElevatedButton.icon(

                icon:
                const Icon(Icons.call),

                label:
                const Text("CALL NOW"),


                onPressed:() async{


                  await launchUrl(

                    Uri.parse(
                        "tel:${widget.doctor.phoneNumber}"
                    ),

                  );

                },

              ),

            ),






            SizedBox(

              width:double.infinity,

              child:
              ElevatedButton.icon(

                icon:
                const Icon(Icons.calendar_month),

                label:
                const Text("BOOK APPOINTMENT"),


                onPressed:(){


                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder:(_)=>
                          AppointmentScreen(
                            doctor:widget.doctor,
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