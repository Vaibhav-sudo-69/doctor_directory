import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/appointment.dart';


List<Appointment> appointments = [];


// SAVE APPOINTMENTS
Future<void> saveAppointments() async {

  final prefs = await SharedPreferences.getInstance();

  List<String> data = appointments.map((appointment) {
    return jsonEncode(
      appointment.toJson(),
    );
  }).toList();

  await prefs.setStringList(
    "appointments",
    data,
  );

}


// LOAD APPOINTMENTS
Future<void> loadAppointments() async {

  final prefs = await SharedPreferences.getInstance();

  List<String>? data =
  prefs.getStringList("appointments");


  if (data != null) {

    appointments = data.map((item) {

      return Appointment.fromJson(
        jsonDecode(item),
      );

    }).toList();

  }

}