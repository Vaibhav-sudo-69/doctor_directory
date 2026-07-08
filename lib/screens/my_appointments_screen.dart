import 'package:flutter/material.dart';
import '../data/appointment_data.dart';


class MyAppointmentsScreen extends StatefulWidget {

  const MyAppointmentsScreen({super.key});


  @override
  State<MyAppointmentsScreen> createState()
  => _MyAppointmentsScreenState();

}



class _MyAppointmentsScreenState
    extends State<MyAppointmentsScreen> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF5F7FA),


      appBar: AppBar(

        title: const Text(
          "My Appointments",
        ),

        backgroundColor: Colors.blue,

        foregroundColor: Colors.white,

      ),



      body: appointments.isEmpty

          ? const Center(

        child: Text(

          "No Appointments Yet",

          style: TextStyle(
            fontSize: 20,
          ),

        ),

      )


          : ListView.builder(


        itemCount: appointments.length,


        itemBuilder: (context, index) {


          final appointment =
          appointments[index];


          return Card(

            margin: const EdgeInsets.all(12),


            child: ListTile(


              leading: const Icon(
                Icons.calendar_month,
                color: Colors.blue,
              ),


              title: Text(
                appointment.doctorName,
              ),


              subtitle: Text(

                "Patient: ${appointment.patientName}\n"
                    "Date: ${appointment.date}\n"
                    "Time: ${appointment.time}",

              ),



              trailing: IconButton(

                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),


                onPressed: () {


                  setState(() {

                    appointments.removeAt(index);

                  });


// 💾 update saved data
                  saveAppointments();


                  ScaffoldMessenger.of(context)
                      .showSnackBar(

                    const SnackBar(

                      content: Text(
                        "Appointment Cancelled",
                      ),

                    ),

                  );


                },


              ),


            ),


          );


        },


      ),


    );


  }


}