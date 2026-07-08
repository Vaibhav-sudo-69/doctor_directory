import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/doctor_request.dart';



List<DoctorRequest> doctorRequests = [];





Future<void> saveDoctorRequests() async {

  final prefs =
  await SharedPreferences.getInstance();


  List<String> data =
  doctorRequests
      .map(
        (doctor) =>
        jsonEncode(
          doctor.toJson(),
        ),
  )
      .toList();


  await prefs.setStringList(
    "doctorRequests",
    data,
  );

}






Future<void> loadDoctorRequests() async {

  final prefs =
  await SharedPreferences.getInstance();


  List<String>? data =
  prefs.getStringList(
    "doctorRequests",
  );



  if (data != null) {

    doctorRequests =
        data
            .map(
              (doctor) =>
              DoctorRequest.fromJson(
                jsonDecode(doctor),
              ),
        )
            .toList();

  }

}