import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorInfoScreen extends StatelessWidget {
  final Map<String, dynamic> doctorData;

  const DoctorInfoScreen({
    super.key,
    required this.doctorData,
  });

  Widget infoTile(
      IconData icon,
      String title,
      String value,
      ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.blue,
        ),
        title: Text(title),
        subtitle: Text(
          value.isEmpty ? "Not Available" : value,
        ),
        onTap: title == "Google Maps" && value.isNotEmpty
            ? () async {
          final Uri url = Uri.parse(value);

          if (await canLaunchUrl(url)) {
            await launchUrl(
              url,
              mode: LaunchMode.externalApplication,
            );
          }
        }
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctor Details"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [

            const CircleAvatar(
              radius: 45,
              child: Icon(
                Icons.person,
                size: 45,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              doctorData["name"] ?? "",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              doctorData["specialization"] ?? "",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            infoTile(
              Icons.local_hospital,
              "Clinic",
              doctorData["clinicName"] ?? "",
            ),

            infoTile(
              Icons.phone,
              "Phone",
              doctorData["phoneNumber"] ?? "",
            ),

            infoTile(
              Icons.location_on,
              "Address",
              doctorData["address"] ?? "",
            ),

            infoTile(
              Icons.school,
              "Qualification",
              doctorData["qualification"] ?? "",
            ),

            infoTile(
              Icons.work,
              "Experience",
              "${doctorData["experience"] ?? ""} Years",
            ),

            infoTile(
              Icons.access_time,
              "Timings",
              doctorData["timings"] ?? "",
            ),

            infoTile(
              Icons.map,
              "Google Maps",
              doctorData["location"] ?? "",
            ),

          ],
        ),
      ),
    );
  }
}