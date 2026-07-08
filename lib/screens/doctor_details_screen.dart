import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/doctor.dart';
import '../models/review.dart';
import '../data/review_data.dart';
import 'appointment_screen.dart';


class DoctorDetailsScreen extends StatefulWidget {

  final Doctor doctor;

  const DoctorDetailsScreen({
    super.key,
    required this.doctor,
  });

  @override
  State<DoctorDetailsScreen> createState() =>
      _DoctorDetailsScreenState();
}


class _DoctorDetailsScreenState
    extends State<DoctorDetailsScreen> {


  int selectedRating = 5;


  void addReviewDialog() {

    final nameController =
    TextEditingController();

    final reviewController =
    TextEditingController();


    showDialog(

      context: context,

      builder: (context) {

        return StatefulBuilder(

          builder: (context, setDialogState) {

            return AlertDialog(

              title: const Text(
                "Add Review ⭐",
              ),


              content: Column(

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

                    ),

                  ),



                  TextField(

                    controller:
                    reviewController,

                    decoration:
                    const InputDecoration(

                      labelText:
                      "Review",

                    ),

                  ),



                  const SizedBox(
                    height: 15,
                  ),



                  Row(

                    mainAxisAlignment:
                    MainAxisAlignment.center,


                    children:

                    List.generate(

                      5,

                          (index) {

                        return IconButton(

                          onPressed: () {

                            setDialogState(() {

                              selectedRating =
                                  index + 1;

                            });

                          },


                          icon: Icon(

                            index <
                                selectedRating

                                ? Icons.star

                                : Icons.star_border,


                            color:
                            Colors.orange,

                          ),

                        );

                      },

                    ),

                  )

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



                    reviews.add(

                      Review(

                        doctorName:
                        widget.doctor.name,


                        userName:
                        nameController.text,


                        reviewText:
                        reviewController.text,


                        rating:
                        selectedRating.toDouble(),

                      ),

                    );



                    await saveReviews();


                    setState(() {});


                    Navigator.pop(context);

                  },


                  child:
                  const Text(
                    "Submit",
                  ),

                )

              ],

            );

          },

        );

      },

    );

  }




  Widget infoCard(

      IconData icon,
      String title,
      String value,

      ){

    return Card(

      child: ListTile(

        leading:
        Icon(icon),


        title:
        Text(title),


        subtitle:
        Text(value),

      ),

    );

  }





  @override
  Widget build(BuildContext context) {


    final doctorReviews = reviews

        .where(

          (r) =>
      r.doctorName ==
          widget.doctor.name,

    )

        .toList();



    return Scaffold(

      backgroundColor:
      const Color(0xffF5F7FA),



      appBar: AppBar(

        title:
        Text(
          widget.doctor.name,
        ),


        backgroundColor:
        Colors.blue,


        foregroundColor:
        Colors.white,

      ),




      body: SingleChildScrollView(


        padding:
        const EdgeInsets.all(20),


        child: Column(

          children: [



            CircleAvatar(

              radius: 65,


              backgroundImage:

              AssetImage(
                widget.doctor.image,
              ),

            ),




            const SizedBox(
              height:20,
            ),



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

                fontSize:18,

              ),

            ),





            const SizedBox(
              height:20,
            ),





            infoCard(

              Icons.school,

              "Qualification",

              widget.doctor
                  .qualification,

            ),



            infoCard(

              Icons.work,

              "Experience",

              "${widget.doctor.experience} Years",

            ),




            infoCard(

              Icons.local_hospital,

              "Clinic",

              widget.doctor.clinicName,

            ),




            Card(

              child: ListTile(

                leading: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),

                title: const Text(
                  "Address",
                ),

                subtitle: Text(
                  widget.doctor.address,
                ),


                trailing: IconButton(

                  icon: const Icon(
                    Icons.map,
                    color: Colors.blue,
                  ),


                  onPressed: () async {

                    final Uri mapUrl = Uri.parse(
                      "https://www.google.com/maps/search/?api=1&query=${widget.doctor.address}",
                    );


                    await launchUrl(
                      mapUrl,
                      mode: LaunchMode.externalApplication,
                    );

                  },

                ),

              ),

            ),



            infoCard(

              Icons.access_time,

              "Timing",

              widget.doctor.timings,

            ),




            infoCard(

              Icons.phone,

              "Phone",

              widget.doctor.phoneNumber,

            ),




            const SizedBox(
              height:20,
            ),




            ElevatedButton.icon(

              onPressed:
              addReviewDialog,


              icon:
              const Icon(
                  Icons.rate_review
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


              child: Text(

                "Patient Reviews ⭐",


                style:
                TextStyle(

                  fontSize:22,

                  fontWeight:
                  FontWeight.bold,

                ),

              ),

            ),





            ListView.builder(

              shrinkWrap: true,

              physics: const NeverScrollableScrollPhysics(),

              itemCount: doctorReviews.length,

              itemBuilder: (context, index) {

                return Card(

                  child: ListTile(

                    leading: const Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),


                    title: Text(
                      "${"⭐" * doctorReviews[index].rating.toInt()}  "
                          "${doctorReviews[index].reviewText}",
                    ),


                    subtitle: Text(
                      "By ${doctorReviews[index].userName}",
                    ),


                    trailing: IconButton(

                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),


                      onPressed: () async {

                        reviews.remove(
                          doctorReviews[index],
                        );


                        await saveReviews();


                        setState(() {});

                      },

                    ),

                  ),

                );

              },

            ),






            const SizedBox(
              height:20,
            ),




            SizedBox(

              width:
              double.infinity,


              child:
              ElevatedButton.icon(


                onPressed: () async {


                  final Uri phoneUri =
                  Uri(

                    scheme:
                    "tel",

                    path:
                    widget.doctor.phoneNumber,

                  );


                  await launchUrl(
                      phoneUri
                  );

                },


                icon:
                const Icon(
                    Icons.call
                ),


                label:
                const Text(
                    "CALL NOW"
                ),

              ),

            ),





            const SizedBox(
              height:15,
            ),





            SizedBox(

              width:
              double.infinity,


              child:
              ElevatedButton.icon(


                onPressed: () {


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


                icon:
                const Icon(
                    Icons.calendar_month
                ),


                label:
                const Text(
                    "BOOK APPOINTMENT"
                ),

              ),

            ),

          ],

        ),

      ),

    );

  }

}