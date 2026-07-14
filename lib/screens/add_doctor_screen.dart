import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddDoctorScreen extends StatefulWidget {
  const AddDoctorScreen({super.key});

  @override
  State<AddDoctorScreen> createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
final nameController = TextEditingController();
final specializationController = TextEditingController();
final clinicController = TextEditingController();
final phoneController = TextEditingController();
final mapController = TextEditingController();
final addressController = TextEditingController();
final timingsController = TextEditingController();
final qualificationController = TextEditingController();
final experienceController = TextEditingController();
final locationController = TextEditingController();

Future<void> addDoctor() async {
if (nameController.text.isEmpty ||
specializationController.text.isEmpty ||
clinicController.text.isEmpty ||
phoneController.text.isEmpty ||
addressController.text.isEmpty) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text("Please fill all fields"),
),
);
return;
}

await FirebaseFirestore.instance.collection("doctors").add({
"name": nameController.text.trim(),
  "email": "",
  "password": "",
  "isRegistered": false,
"specialization": specializationController.text.trim(),
"clinicName": clinicController.text.trim(),
"phoneNumber": phoneController.text.trim(),
"address": addressController.text.trim(),
"timings": timingsController.text.trim().isEmpty
? "10 AM - 7 PM"
: timingsController.text.trim(),
"qualification": qualificationController.text.trim().isEmpty
? "MBBS"
: qualificationController.text.trim(),
"experience":
int.tryParse(experienceController.text.trim()) ?? 0,
"location": locationController.text.trim(),
  "image": "",
"rating": 0.0,
"reviews": [],
"isFavorite": false,
  "isVerified": true,
  "isAvailable": true,
  "createdBy": "admin",
"createdAt": Timestamp.now(),
});

ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text("Doctor Added Successfully ✅"),
),
);

Navigator.pop(context);
}

Widget inputBox(
String title,
TextEditingController controller, {
bool obscure = false,
TextInputType keyboardType = TextInputType.text,
}) {
return Padding(
padding: const EdgeInsets.only(bottom: 15),
child: TextField(
controller: controller,
obscureText: obscure,
keyboardType: keyboardType,
decoration: InputDecoration(
labelText: title,
border: const OutlineInputBorder(),
),
),
);
}
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Add Doctor"),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [

          inputBox(
            "Doctor Name",
            nameController,
          ),


          inputBox(
            "Specialization",
            specializationController,
          ),

          inputBox(
            "Clinic Name",
            clinicController,
          ),

          inputBox(
            "Phone Number",
            phoneController,
            keyboardType: TextInputType.phone,
          ),


          inputBox(
            "Address",
            addressController,
          ),

          inputBox(
            "Timings (Optional)",
            timingsController,
          ),

          inputBox(
            "Qualification (Optional)",
            qualificationController,
          ),

          inputBox(
            "Experience (Years)",
            experienceController,
            keyboardType: TextInputType.number,
          ),

          inputBox(
            "Google Maps Location URL (Optional)",
            locationController,
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton.icon(
              onPressed: addDoctor,
              icon: const Icon(Icons.add),
              label: const Text(
                "ADD DOCTOR",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}