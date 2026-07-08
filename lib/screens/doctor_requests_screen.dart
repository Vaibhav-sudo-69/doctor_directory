import 'package:flutter/material.dart';

import '../data/doctor_request_data.dart';
import '../data/doctor_login_data.dart';


class DoctorRequestsScreen extends StatefulWidget {

  const DoctorRequestsScreen({super.key});


  @override
  State<DoctorRequestsScreen> createState() =>
      _DoctorRequestsScreenState();

}




class _DoctorRequestsScreenState
    extends State<DoctorRequestsScreen> {




  void acceptDoctor(int index) async {


    final request =
    doctorRequests[index];



    doctorAccounts.add(

      DoctorAccount(

        name: request.name,

        email: request.email,

        password: request.password,

      ),

    );




    doctorRequests.removeAt(index);



    await saveDoctorRequests();




    setState(() {});



    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(

        content: Text(
          "Doctor Approved ✅",
        ),

      ),

    );

  }






  void rejectDoctor(int index) async {


    doctorRequests.removeAt(index);



    await saveDoctorRequests();



    setState(() {});



    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(

        content: Text(
          "Doctor Rejected ❌",
        ),

      ),

    );

  }









  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title: const Text(
          "Doctor Requests",
        ),

        backgroundColor:
        Colors.blue,

        foregroundColor:
        Colors.white,

      ),








      body: doctorRequests.isEmpty


          ? const Center(

        child: Text(

          "No Doctor Requests",

        ),

      )




          : ListView.builder(


        itemCount:
        doctorRequests.length,



        itemBuilder:
            (context, index) {


          final doctor =
          doctorRequests[index];




          return Card(

            margin:
            const EdgeInsets.all(10),



            child: ListTile(



              leading:
              const Icon(

                Icons.medical_services,

                color: Colors.blue,

              ),





              title: Text(

                doctor.name,

              ),




              subtitle: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,



                children: [


                  Text(

                    doctor.specialization,

                  ),


                  Text(

                    doctor.clinicName,

                  ),


                  Text(

                    doctor.email,

                  ),


                ],

              ),






              trailing: Row(

                mainAxisSize:
                MainAxisSize.min,



                children: [




                  IconButton(

                    icon: const Icon(

                      Icons.check,

                      color: Colors.green,

                    ),


                    onPressed: () {

                      acceptDoctor(index);

                    },

                  ),







                  IconButton(

                    icon: const Icon(

                      Icons.close,

                      color: Colors.red,

                    ),


                    onPressed: () {

                      rejectDoctor(index);

                    },

                  ),



                ],

              ),



            ),

          );


        },

      ),


    );


  }

}