import 'package:flutter/material.dart';
import '../utils/upload_doctors.dart';

class UploadDoctorsScreen extends StatelessWidget {
  const UploadDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Doctors"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await uploadDoctors();

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("✅ Doctors Uploaded Successfully"),
              ),
            );
          },
          child: const Text("UPLOAD DOCTORS"),
        ),
      ),
    );
  }
}