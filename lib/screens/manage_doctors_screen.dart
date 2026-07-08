import 'package:flutter/material.dart';

import '../data/doctor_data.dart';


class ManageDoctorsScreen extends StatefulWidget {

  const ManageDoctorsScreen({super.key});


  @override
  State<ManageDoctorsScreen> createState() =>
      _ManageDoctorsScreenState();

}



class _ManageDoctorsScreenState
    extends State<ManageDoctorsScreen> {


  void deleteDoctor(int index) async {

    setState(() {

      doctors.removeAt(index);

    });


    await saveDoctors();


    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(

        content: Text(
          "Doctor Deleted Successfully",
        ),

      ),

    );

  }






  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title: const Text(
          "Manage Doctors",
        ),

        backgroundColor: Colors.blue,

        foregroundColor: Colors.white,

      ),




      body: ListView.builder(

        itemCount: doctors.length,


        itemBuilder: (context, index) {


          final doctor = doctors[index];



          return Card(

            margin: const EdgeInsets.all(10),


            child: ListTile(


              leading: const Icon(

                Icons.medical_services,

                color: Colors.blue,

              ),



              title: Text(

                doctor.name,

              ),



              subtitle: Text(

                doctor.specialization,

              ),




              trailing: IconButton(

                icon: const Icon(

                  Icons.delete,

                  color: Colors.red,

                ),


                onPressed: () {

                  deleteDoctor(index);

                },

              ),


            ),

          );


        },

      ),


    );


  }

}