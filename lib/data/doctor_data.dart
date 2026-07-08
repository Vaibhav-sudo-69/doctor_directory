import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/doctor.dart';


List<Doctor> doctors = [];




// LOAD DOCTORS FROM FIREBASE

Future<void> loadDoctors() async {


  final snapshot = await FirebaseFirestore
      .instance
      .collection("doctors")
      .get();



  doctors = snapshot.docs.map(

        (doc) {


      return Doctor.fromJson(

        doc.data(),

      );


    },

  ).toList();


}






// SAVE DOCTOR TO FIREBASE

Future<void> saveDoctors() async {


  final firestore =
      FirebaseFirestore.instance;



  for (var doctor in doctors) {


    await firestore
        .collection("doctors")
        .add(

      doctor.toJson(),

    );


  }


}