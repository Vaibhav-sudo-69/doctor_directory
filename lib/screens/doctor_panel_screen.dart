import 'package:flutter/material.dart';

import '../data/appointment_data.dart';
import '../data/doctor_login_data.dart';


class DoctorPanelScreen extends StatefulWidget {

  const DoctorPanelScreen({super.key});


  @override
  State<DoctorPanelScreen> createState() =>
      _DoctorPanelScreenState();

}



class _DoctorPanelScreenState
    extends State<DoctorPanelScreen> {



  void updateStatus(
      int index,
      String status,
      ) async {


    setState(() {

      appointments[index].status = status;

    });


    await saveAppointments();


    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(

        content: Text(
          "Appointment $status",
        ),

      ),

    );

  }





  @override
  Widget build(BuildContext context) {


    final doctorAppointments =
    appointments.where((appointment) {

      return appointment.doctorName ==
          currentDoctor!.name;

    }).toList();



    return Scaffold(


      appBar: AppBar(

        title: Text(
          "${currentDoctor!.name} Panel",
        ),

        backgroundColor: Colors.blue,

        foregroundColor: Colors.white,

      ),





      body: doctorAppointments.isEmpty

          ? const Center(

        child: Text(
          "No Appointment Requests",
        ),

      )


          : ListView.builder(


        itemCount:
        doctorAppointments.length,


        itemBuilder: (context, index) {


          final appointment =
          doctorAppointments[index];


          final realIndex =
          appointments.indexOf(appointment);




          return Card(

            margin:
            const EdgeInsets.all(10),


            child: ListTile(


              title: Text(

                appointment.patientName,

              ),




              subtitle: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,


                children: [


                  Text(
                    "Doctor: ${appointment.doctorName}",
                  ),


                  Text(
                    "Date: ${appointment.date}",
                  ),


                  Text(
                    "Time: ${appointment.time}",
                  ),


                  Text(
                    "Status: ${appointment.status}",
                  ),


                ],

              ),





              trailing:
              appointment.status == "Pending"

                  ? Row(

                mainAxisSize:
                MainAxisSize.min,


                children: [


                  IconButton(

                    icon: const Icon(

                      Icons.check,

                      color: Colors.green,

                    ),


                    onPressed: () {

                      updateStatus(

                        realIndex,

                        "Accepted",

                      );

                    },

                  ),





                  IconButton(

                    icon: const Icon(

                      Icons.close,

                      color: Colors.red,

                    ),


                    onPressed: () {

                      updateStatus(

                        realIndex,

                        "Rejected",

                      );

                    },

                  ),


                ],

              )


                  : Text(

                appointment.status,

              ),


            ),

          );


        },


      ),


    );


  }

}