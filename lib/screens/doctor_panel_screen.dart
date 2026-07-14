import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login_screen.dart';
import 'doctor_edit_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';



class DoctorPanelScreen extends StatefulWidget {


  final String doctorId;

  final Map<String,dynamic> doctorData;



  const DoctorPanelScreen({

    super.key,

    required this.doctorId,

    required this.doctorData,

  });



  @override
  State<DoctorPanelScreen> createState()
  => _DoctorPanelScreenState();

}







class _DoctorPanelScreenState
    extends State<DoctorPanelScreen> {
  String selectedFilter = "All";





  void updateStatus(
      String id,
      String status,
      ) async {



    await FirebaseFirestore.instance
        .collection("appointments")
        .doc(id)
        .update({


      "status": status,


    });





    ScaffoldMessenger.of(context)
        .showSnackBar(


      SnackBar(

        content:
        Text(
          "Appointment $status",
        ),

      ),


    );


  }









  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor: const Color(0xffF5F7FA),

      appBar:
      AppBar(


        title:
        Text(

          "${widget.doctorData["name"]} Panel",

        ),



        backgroundColor:
        Colors.blue,


        foregroundColor:
        Colors.white,



        actions: [

          IconButton(

            icon: const Icon(
              Icons.edit,
            ),

            tooltip: "Edit Profile",

            onPressed: () {

              Navigator.push(

                context,

                MaterialPageRoute(

                  builder: (_) => DoctorEditProfileScreen(

                    doctorId: widget.doctorId,

                    doctorData: widget.doctorData,

                  ),

                ),

              );

            },

          ),

          IconButton(

            icon: const Icon(
              Icons.logout,
            ),

            onPressed: () async {

              bool? logout = await showDialog<bool>(

                context: context,

                builder: (context) {

                  return AlertDialog(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),

                    title: const Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                        SizedBox(width: 10),
                        Text("Logout"),
                      ],
                    ),

                    content: const Text(
                      "Are you sure you want to logout?",
                    ),

                    actions: [

                      TextButton(

                        onPressed: () {

                          Navigator.pop(context, false);

                        },

                        child: const Text("Cancel"),

                      ),

                      ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),

                        onPressed: () {

                          Navigator.pop(context, true);

                        },

                        child: const Text("Logout"),

                      ),

                    ],

                  );

                },

              );

              if (logout == true) {

                await FirebaseAuth.instance.signOut();

                Navigator.pushAndRemoveUntil(

                  context,

                  MaterialPageRoute(

                    builder: (_) => const LoginScreen(),

                  ),

                      (route) => false,

                );

              }

            },

          ),

        ],


      ),







body: Column(
children: [
  Container(
    margin: const EdgeInsets.fromLTRB(15, 15, 15, 5),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color(0xff1565C0),
          Color(0xff42A5F5),
        ],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.15),
          blurRadius: 15,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Row(
      children: [

        const CircleAvatar(
          radius: 34,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.person,
            size: 40,
            color: Colors.blue,
          ),
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                widget.doctorData["name"] ?? "",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                widget.doctorData["specialization"] ?? "",
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                widget.doctorData["clinicName"] ?? "",
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                widget.doctorData["phoneNumber"] ?? "",
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),

            ],
          ),
        ),
      ],
    ),
  ),

StreamBuilder<QuerySnapshot>(
stream: FirebaseFirestore.instance
.collection("appointments")
.where(
"doctorEmail",
isEqualTo: widget.doctorData["email"],
)
.where(
"status",
isEqualTo: "Pending",
)
.snapshots(),
builder: (context, snapshot) {

int count = 0;

if (snapshot.hasData) {
count = snapshot.data!.docs.length;
}

return Container(
  width: double.infinity,
  margin: const EdgeInsets.symmetric(
    horizontal: 15,
    vertical: 10,
  ),
  padding: const EdgeInsets.all(18),
  decoration: BoxDecoration(
    gradient: const LinearGradient(
      colors: [
        Color(0xff1565C0),
        Color(0xff42A5F5),
      ],
    ),
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(.15),
        blurRadius: 12,
        offset: const Offset(0, 6),
      ),
    ],
  ),
  child: Row(
    children: [

      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.2),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.notifications_active,
          color: Colors.white,
          size: 30,
        ),
      ),

      const SizedBox(width: 15),

      const Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Pending Appointments",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 4),

            Text(
              "Waiting for your response",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
              ),
            ),

          ],
        ),
      ),

      Container(
        height: 55,
        width: 55,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          "$count",
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),

    ],
  ),
);
},
),

Padding(
padding: const EdgeInsets.symmetric(horizontal: 12),
child: SingleChildScrollView(
scrollDirection: Axis.horizontal,
child: Row(
children: [

ChoiceChip(
label: const Text("All"),
  selectedColor: const Color(0xff1565C0),

  backgroundColor: Colors.white,

  labelStyle: TextStyle(
    color: selectedFilter == "All"
        ? Colors.white
        : Colors.black87,
    fontWeight: FontWeight.w600,
  ),

  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
  ),

  showCheckmark: false,

  elevation: 2,

  shadowColor: Colors.black26,
selected: selectedFilter == "All",
onSelected: (_) {
setState(() {
selectedFilter = "All";
});
},
),

const SizedBox(width: 8),

ChoiceChip(
label: const Text("Pending"),
  selectedColor: const Color(0xff1565C0),

  backgroundColor: Colors.white,

  labelStyle: TextStyle(
    color: selectedFilter == "All"
        ? Colors.white
        : Colors.black87,
    fontWeight: FontWeight.w600,
  ),

  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
  ),

  showCheckmark: false,

  elevation: 2,

  shadowColor: Colors.black26,
selected: selectedFilter == "Pending",
onSelected: (_) {
setState(() {
selectedFilter = "Pending";
});
},
),

const SizedBox(width: 8),

ChoiceChip(
label: const Text("Accepted"),
  selectedColor: const Color(0xff1565C0),

  backgroundColor: Colors.white,

  labelStyle: TextStyle(
    color: selectedFilter == "All"
        ? Colors.white
        : Colors.black87,
    fontWeight: FontWeight.w600,
  ),

  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
  ),

  showCheckmark: false,

  elevation: 2,

  shadowColor: Colors.black26,
selected: selectedFilter == "Accepted",
onSelected: (_) {
setState(() {
selectedFilter = "Accepted";
});
},
),

const SizedBox(width: 8),

ChoiceChip(
label: const Text("Rejected"),
selected: selectedFilter == "Rejected",
onSelected: (_) {
setState(() {
selectedFilter = "Rejected";
});
},
),

],
),
),
),

Expanded(
child: StreamBuilder<QuerySnapshot>(
stream: FirebaseFirestore.instance
.collection("appointments")
.where(
"doctorEmail",
isEqualTo: widget.doctorData["email"],
)
.snapshots(),
builder: (context, snapshot) {
  if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
    return const Center(
      child: Text("No Appointment Requests"),
    );
  }

  final appointments = snapshot.data!.docs.where((doc) {
    if (selectedFilter == "All") return true;

    final data = doc.data() as Map<String, dynamic>;
    return data["status"] == selectedFilter;
  }).toList();

  return ListView.builder(
    itemCount: appointments.length,
    itemBuilder: (context, index) {

      final data =
      appointments[index].data() as Map<String, dynamic>;

      final id = appointments[index].id;

      return Card(
        elevation: 6,
        margin: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [

                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0xffE3F2FD),
                    child: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      data["patientName"] ?? "",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: data["status"] == "Pending"
                          ? Colors.orange.shade100
                          : data["status"] == "Accepted"
                          ? Colors.green.shade100
                          : Colors.red.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      data["status"],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: data["status"] == "Pending"
                            ? Colors.orange
                            : data["status"] == "Accepted"
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  const Icon(Icons.phone,
                      size: 18,
                      color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(data["phoneNumber"]),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  const Icon(Icons.calendar_month,
                      size: 18,
                      color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(data["date"]),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  const Icon(Icons.access_time,
                      size: 18,
                      color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(data["time"]),
                ],
              ),

              if (data["status"] == "Pending") ...[
                const SizedBox(height: 18),

                Row(
                  children: [

                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          updateStatus(id, "Accepted");
                        },
                        icon: const Icon(Icons.check),
                        label: const Text("Accept"),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          updateStatus(id, "Rejected");
                        },
                        icon: const Icon(Icons.close),
                        label: const Text("Reject"),
                      ),
                    ),

                  ],
                ),
              ],

            ],
          ),
        ),
      );
    },
  );
},
),
),
],
),
    );



  }


}