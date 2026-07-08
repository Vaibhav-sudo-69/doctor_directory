import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';


User? currentUser;



Future<void> saveUser() async {
  final prefs = await SharedPreferences.getInstance();

  if (currentUser == null) {
    await prefs.remove("user");
    return;
  }

  await prefs.setString(
    "user",
    jsonEncode(currentUser!.toJson()),
  );
}



Future<void> loadUser() async {

  final prefs = await SharedPreferences.getInstance();


  String? data = prefs.getString("user");


  if (data != null) {

    currentUser = User.fromJson(

      jsonDecode(data),

    );

  }

}



Future<void> logoutUser() async {

  final prefs = await SharedPreferences.getInstance();


  await prefs.remove("user");


  currentUser = null;

}