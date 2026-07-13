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
      elevation: 5,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      color: Colors.white,


      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),

        leading: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade400,
                  Colors.blue.shade700,
                ],
              ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),


        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),


        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),


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

        extendBodyBehindAppBar: false,
      backgroundColor:
      const Color(0xffF5F7FA),


      appBar:
      AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          "Doctor Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),






      body:
      SingleChildScrollView(


        padding:
        const EdgeInsets.all(20),


        child:
        Column(


          children: [



            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.blue,
                  width: 4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.25),
                    blurRadius: 20,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 65,
                backgroundImage: AssetImage(widget.doctor.image),
              ),
            ),

            const SizedBox(height: 30),

            Text(
              widget.doctor.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),

            const SizedBox(height: 6),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                widget.doctor.specialization,
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),

            const SizedBox(height: 12),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("reviews")
                  .where(
                "doctorEmail",
                isEqualTo: widget.doctor.email,
              )
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                }

                final reviews = snapshot.data!.docs;

                double avg = 0;

                for (var review in reviews) {
                  final data = review.data() as Map<String, dynamic>;
                  avg += (data["rating"] ?? 0).toDouble();
                }

                if (reviews.isNotEmpty) {
                  avg /= reviews.length;
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${avg.toStringAsFixed(1)} (${reviews.length} Reviews)",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 25),





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
            const SizedBox(height: 12),








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
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.white,

                      child: Padding(
                        padding: const EdgeInsets.all(15),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            Row(
                              children: [

                                CircleAvatar(
                                  radius: 26,
                                  backgroundColor: Colors.blue.shade50,
                                  child: Text(
                                    data["userName"][0].toUpperCase(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: Text(
                                    data["userName"],
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                              ],
                            ),

                            const SizedBox(height: 10),

                            Row(
                              children: List.generate(5, (i) {
                                return Icon(
                                  i < rating ? Icons.star : Icons.star_border,
                                  color: Colors.orange,
                                  size: 20,
                                );
                              }),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              data["reviewText"],
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                height: 1.4,
                              ),
                            )

                          ],
                        ),
                      ),
                    );

                  },

                );

              },

            ),





            const SizedBox(height: 20),
            Column(
              children: [

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    icon: const Icon(Icons.call),
                    label: const Text(
                      "CALL NOW",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      await launchUrl(
                        Uri.parse("tel:${widget.doctor.phoneNumber}"),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    icon: const Icon(Icons.calendar_month),
                    label: const Text(
                      "BOOK APPOINTMENT",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AppointmentScreen(
                            doctor: widget.doctor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            )



          ],

        ),

      ),

    );

  }

}