import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login_screen.dart';
import 'doctor_edit_profile_screen.dart';



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

            onPressed: () {

              Navigator.pushAndRemoveUntil(

                context,

                MaterialPageRoute(

                  builder: (_) =>
                  const LoginScreen(),

                ),

                    (route) => false,

              );

            },

          ),

        ],


      ),







body: Column(
children: [

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
margin: const EdgeInsets.all(12),
padding: const EdgeInsets.all(15),
decoration: BoxDecoration(
color: Colors.blue,
borderRadius: BorderRadius.circular(15),
),
child: Text(
"🔔 Pending Requests: $count",
style: const TextStyle(
color: Colors.white,
fontSize: 18,
fontWeight: FontWeight.bold,
),
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
        margin: const EdgeInsets.all(10),
        child: ListTile(
          title: Text(data["patientName"] ?? ""),

          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text("Phone: ${data["phoneNumber"]}"),

              Text("Date: ${data["date"]}"),

              Text("Time: ${data["time"]}"),

              Text("Status: ${data["status"]}"),

            ],
          ),

          trailing: data["status"] == "Pending"
              ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [

              IconButton(
                icon: const Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                onPressed: () {
                  updateStatus(id, "Accepted");
                },
              ),

              IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                onPressed: () {
                  updateStatus(id, "Rejected");
                },
              ),

            ],
          )
              : Text(data["status"]),
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