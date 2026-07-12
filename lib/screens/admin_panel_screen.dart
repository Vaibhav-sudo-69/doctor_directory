import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'add_doctor_screen.dart';
import 'manage_doctors_screen.dart';
import 'doctor_requests_screen.dart';

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  Widget dashboardCard(
    String title,
    IconData icon,
    int count,
    Color color,
  ) {
    return Expanded(
      child: Container(
        height: 150,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: color.withOpacity(.15),
              child: Icon(
                icon,
                color: color,
                size: 30,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "$count",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget actionButton(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          onPressed: onTap,
          icon: Icon(icon),
          label: Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }












@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xffF4F8FB),

body: StreamBuilder<QuerySnapshot>(
stream: FirebaseFirestore.instance
.collection("doctors")
.snapshots(),
builder: (context, doctorSnapshot) {

return StreamBuilder<QuerySnapshot>(
stream: FirebaseFirestore.instance
.collection("appointments")
.snapshots(),
builder: (context, appointmentSnapshot) {

return StreamBuilder<QuerySnapshot>(
stream: FirebaseFirestore.instance
.collection("users")
.snapshots(),
builder: (context, userSnapshot) {

return StreamBuilder<QuerySnapshot>(
stream: FirebaseFirestore.instance
    .collection("doctor_requests")
    .where("status", isEqualTo: "Pending")
    .snapshots(),
builder: (context, requestSnapshot) {

return StreamBuilder<QuerySnapshot>(
stream: FirebaseFirestore.instance
.collection("reviews")
.snapshots(),
builder: (context, reviewSnapshot) {

if (!doctorSnapshot.hasData ||
!appointmentSnapshot.hasData ||
!userSnapshot.hasData ||
!requestSnapshot.hasData ||
!reviewSnapshot.hasData) {

return const Center(
child: CircularProgressIndicator(),
);

}

int doctorCount =
doctorSnapshot.data!.docs.length;

int appointmentCount =
appointmentSnapshot.data!.docs.length;

int userCount =
userSnapshot.data!.docs.length;

int requestCount =
requestSnapshot.data!.docs.length;

int reviewCount =
reviewSnapshot.data!.docs.length;

            return SingleChildScrollView(
              child: Column(
                children: [

                  // ================= HEADER =================

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 60,
                      left: 20,
                      right: 20,
                      bottom: 30,
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff1565C0),
                          Color(0xff42A5F5),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                      ),
                    ),

                    child: Column(
                      children: [

                        Row(
                          children: [

                            const CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.admin_panel_settings,
                                color: Colors.blue,
                                size: 40,
                              ),
                            ),

                            const SizedBox(width: 15),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: const [

                                  Text(
                                    "Welcome Admin 👋",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(height: 5),

                                  Text(
                                    "City Doctor Directory",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const Icon(
                              Icons.notifications,
                              color: Colors.white,
                              size: 30,
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),

                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.2),
                            borderRadius:
                                BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                            children: [

                              Column(
                                children: const [
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Today's Dashboard",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),

                              Column(
                                children: [
                                  Text(
                                    "$doctorCount",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    "Doctors",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),

                              Column(
                                children: [
                                  Text(
                                    "$appointmentCount",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    "Appointments",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),
Padding(
padding: const EdgeInsets.symmetric(horizontal: 15),

child: Column(

children: [

Row(

children: [

dashboardCard(
"Doctors",
Icons.medical_services,
doctorCount,
Colors.blue,
),

dashboardCard(
"Appointments",
Icons.calendar_month,
appointmentCount,
Colors.orange,
),

],

),

Row(

children: [

dashboardCard(
"Users",
Icons.people,
userCount,
Colors.green,
),

dashboardCard(
"Reviews",
Icons.star,
reviewCount,
Colors.amber,
),

],

),

Row(

children: [

dashboardCard(
"Pending",
Icons.pending_actions,
requestCount,
Colors.deepPurple,
),

const Expanded(
child: SizedBox(),
),

],

),

],

),

),

                  const SizedBox(height: 20),

                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Quick Actions",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20),

                    child: Column(
                      children: [

                        actionButton(
                          context,
                          "Add Doctor",
                          Icons.add_circle,
                          Colors.green,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const AddDoctorScreen(),
                              ),
                            );
                          },
                        ),

                        actionButton(
                          context,
                          "Manage Doctors",
                          Icons.local_hospital,
                          Colors.blue,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const ManageDoctorsScreen(),
                              ),
                            );
                          },
                        ),

                        actionButton(
                          context,
                          "Doctor Requests",
                          Icons.verified_user,
                          Colors.deepPurple,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const DoctorRequestsScreen(),
                              ),
                            );
                          },
                        ),

                        actionButton(
                          context,
                          "Logout",
                          Icons.logout,
                          Colors.red,
                          () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            );
},
);
},
);
},
);
},
);
},
),
  );
}
}