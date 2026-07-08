import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'screens/login_screen.dart';

import 'data/user_data.dart';
import 'data/doctor_data.dart';
import 'data/appointment_data.dart';
import 'data/doctor_request_data.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();


  // 🔥 Firebase Start
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  // old local data loading (keep for now)
  await loadUser();

  await loadDoctors();

  await loadAppointments();

  await loadDoctorRequests();


  runApp(
    const MyApp(),
  );

}




class MyApp extends StatelessWidget {

  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {


    return MaterialApp(

      debugShowCheckedModeBanner: false,


      title: "City Doctor Directory",


      theme: ThemeData(

        primarySwatch: Colors.blue,

        useMaterial3: true,

      ),



      home: const LoginScreen(),


    );


  }

}