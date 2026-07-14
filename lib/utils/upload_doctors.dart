import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/doctor_dataset.dart';

Future<void> uploadDoctors() async {
  final firestore = FirebaseFirestore.instance;

  for (final doctor in doctors) {
    final existingDoctor = await firestore
        .collection("doctors")
        .where("name", isEqualTo: doctor["name"])
        .get();

    // Doctor already exists
    if (existingDoctor.docs.isNotEmpty) {
      print("${doctor["name"]} already exists.");
      continue;
    }

    // Upload new doctor
    await firestore.collection("doctors").add({
      ...doctor,
      "createdAt": Timestamp.now(),
    });

    print("${doctor["name"]} uploaded successfully.");
  }

  print("All doctors processed successfully.");
}