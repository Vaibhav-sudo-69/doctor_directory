import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/doctor.dart';



List<Doctor> doctors = [

  Doctor(

    name: "Dr. Amit Sharma",

    specialization: "Physician",

    clinicName: "Sharma Clinic",

    phoneNumber: "9876543210",

    address: "Civil Lines, Muzaffarnagar",

    timings: "10:00 AM - 7:00 PM",

    experience: 15,

    qualification: "MBBS, MD",

    image: "assets/doctor.png",

    rating: 4.9,

    reviews: [],

  ),



  Doctor(

    name: "Dr. Neha Gupta",

    specialization: "Dentist",

    clinicName: "Smile Dental Care",

    phoneNumber: "9876543211",

    address: "Muzaffarnagar",

    timings: "9:00 AM - 6:00 PM",

    experience: 10,

    qualification: "BDS",

    image: "assets/neha.webp",

    rating: 4.9,

    reviews: [],

  ),

];




// SAVE DOCTORS
Future<void> saveDoctors() async {


  final prefs =
  await SharedPreferences.getInstance();


  List<String> data = doctors.map(
        (doctor) {

      return jsonEncode(
        doctor.toJson(),
      );

    },
  ).toList();



  await prefs.setStringList(

    "doctors",

    data,

  );

}




// LOAD DOCTORS
Future<void> loadDoctors() async {


  final prefs =
  await SharedPreferences.getInstance();


  final data =
  prefs.getStringList("doctors");



  if (data != null) {


    doctors = data.map(

          (doctorString) {


        return Doctor.fromJson(

          jsonDecode(
            doctorString,
          ),

        );


      },

    ).toList();


  }


}