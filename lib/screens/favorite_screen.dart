import 'package:flutter/material.dart';
import '../models/doctor.dart';
import '../widgets/doctor_card.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Doctor> favoriteDoctors;

  const FavoriteScreen({
    super.key,
    required this.favoriteDoctors,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Doctors"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: favoriteDoctors.isEmpty
          ? const Center(
        child: Text(
          "No favorite doctors yet ❤️",
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: favoriteDoctors.length,
        itemBuilder: (context, index) {
          return DoctorCard(
            doctor: favoriteDoctors[index],
          );
        },
      ),
    );
  }
}