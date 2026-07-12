import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorEditProfileScreen extends StatefulWidget {
  final String doctorId;
  final Map<String, dynamic> doctorData;

  const DoctorEditProfileScreen({
    super.key,
    required this.doctorId,
    required this.doctorData,
  });

  @override
  State<DoctorEditProfileScreen> createState() =>
      _DoctorEditProfileScreenState();
}

class _DoctorEditProfileScreenState
    extends State<DoctorEditProfileScreen> {

late TextEditingController nameController;
late TextEditingController specializationController;
late TextEditingController clinicController;
late TextEditingController phoneController;
late TextEditingController addressController;
late TextEditingController timingsController;
late TextEditingController qualificationController;
late TextEditingController experienceController;
late TextEditingController locationController;

bool loading = false;

@override
void initState() {
super.initState();

nameController = TextEditingController(
text: widget.doctorData["name"] ?? "",
);

specializationController = TextEditingController(
text: widget.doctorData["specialization"] ?? "",
);

clinicController = TextEditingController(
text: widget.doctorData["clinicName"] ??
widget.doctorData["clinic"] ??
"",
);

phoneController = TextEditingController(
text: widget.doctorData["phoneNumber"] ??
widget.doctorData["phone"] ??
"",
);

addressController = TextEditingController(
text: widget.doctorData["address"] ?? "",
);

timingsController = TextEditingController(
text: widget.doctorData["timings"] ?? "",
);

qualificationController = TextEditingController(
text: widget.doctorData["qualification"] ?? "",
);

experienceController = TextEditingController(
text:
"${widget.doctorData["experience"] ?? ""}",
);

locationController = TextEditingController(
text: widget.doctorData["location"] ?? "",
);
}

Future<void> updateProfile() async {

if (nameController.text.isEmpty ||
specializationController.text.isEmpty ||
clinicController.text.isEmpty ||
phoneController.text.isEmpty ||
addressController.text.isEmpty) {

ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text("Please fill all required fields"),
),
);

return;
}

setState(() {
loading = true;
});

await FirebaseFirestore.instance
.collection("doctors")
.doc(widget.doctorId)
.update({

"name": nameController.text.trim(),

"specialization":
specializationController.text.trim(),

"clinicName":
clinicController.text.trim(),

"phoneNumber":
phoneController.text.trim(),

"address":
addressController.text.trim(),

"timings":
timingsController.text.trim(),

"qualification":
qualificationController.text.trim(),

"experience":
int.tryParse(experienceController.text) ?? 0,

"location":
locationController.text.trim(),

});

setState(() {
loading = false;
});

ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text("Profile Updated Successfully ✅"),
),
);

Navigator.pop(context);
}

Widget inputBox(
String title,
TextEditingController controller, {
TextInputType keyboard = TextInputType.text,
}) {
return Padding(
padding: const EdgeInsets.only(bottom: 15),
child: TextField(
controller: controller,
keyboardType: keyboard,
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
      title: const Text("Edit Profile"),
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
            keyboard: TextInputType.phone,
          ),

          inputBox(
            "Address",
            addressController,
          ),

          inputBox(
            "Timings",
            timingsController,
          ),

          inputBox(
            "Qualification",
            qualificationController,
          ),

          inputBox(
            "Experience (Years)",
            experienceController,
            keyboard: TextInputType.number,
          ),

          inputBox(
            "Google Maps Location URL",
            locationController,
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton.icon(
              onPressed: loading
                  ? null
                  : updateProfile,
              icon: loading
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : const Icon(Icons.save),
              label: Text(
                loading
                    ? "Updating..."
                    : "SAVE CHANGES",
              ),
            ),
          ),

        ],
      ),
    ),
  );
}

@override
void dispose() {
  nameController.dispose();
  specializationController.dispose();
  clinicController.dispose();
  phoneController.dispose();
  addressController.dispose();
  timingsController.dispose();
  qualificationController.dispose();
  experienceController.dispose();
  locationController.dispose();
  super.dispose();
}
}