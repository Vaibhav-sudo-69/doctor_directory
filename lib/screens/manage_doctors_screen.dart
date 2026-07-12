import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'doctor_edit_profile_screen.dart';
import 'doctor_info_screen.dart';

class ManageDoctorsScreen extends StatefulWidget {
  const ManageDoctorsScreen({super.key});

  @override
  State<ManageDoctorsScreen> createState() =>
      _ManageDoctorsScreenState();
}

class _ManageDoctorsScreenState extends State<ManageDoctorsScreen> {
  TextEditingController searchController = TextEditingController();

  String search = "";

  Future<void> deleteDoctor(String doctorId) async {
    await FirebaseFirestore.instance
        .collection("doctors")
        .doc(doctorId)
        .delete();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Doctor Deleted Successfully"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Doctors"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("doctors")
            .snapshots(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No Doctors Found"),
            );
          }

          final docs = snapshot.data!.docs;
          final filteredDocs = docs.where((doc) {
            final data = doc.data() as Map<String, dynamic>;

            final name =
            (data["name"] ?? "").toString().toLowerCase();

            final specialization =
            (data["specialization"] ?? "")
                .toString()
                .toLowerCase();

            return name.contains(search.toLowerCase()) ||
                specialization.contains(search.toLowerCase());
          }).toList();

          return Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Search Doctor...",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) {
                    if (search != value) {
                      setState(() {
                        search = value;
                      });
                    }
                  },
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: filteredDocs.length,
                  itemBuilder: (context, index) {

                    final doc = filteredDocs[index];
                    final data = doc.data() as Map<String, dynamic>;

                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DoctorInfoScreen(
                                doctorData: data,
                              ),
                            ),
                          );
                        },
                        leading: const Icon(
                          Icons.medical_services,
                          color: Colors.blue,
                        ),

                        title: Text(data["name"] ?? ""),

                        subtitle: Text(
                          data["specialization"] ?? "",
                        ),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        DoctorEditProfileScreen(
                                          doctorId: doc.id,
                                          doctorData: data,
                                        ),
                                  ),
                                );
                              },
                            ),

                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () async {

                                bool? confirm =
                                await showDialog<bool>(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text(
                                          "Delete Doctor"),
                                      content: const Text(
                                          "Are you sure you want to delete this doctor?"),
                                      actions: [

                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(
                                                context, false);
                                          },
                                          child:
                                          const Text("Cancel"),
                                        ),

                                        ElevatedButton(
                                          style: ElevatedButton
                                              .styleFrom(
                                            backgroundColor:
                                            Colors.red,
                                          ),
                                          onPressed: () {
                                            Navigator.pop(
                                                context, true);
                                          },
                                          child:
                                          const Text("Delete"),
                                        ),

                                      ],
                                    );
                                  },
                                );

                                if (confirm == true) {
                                  await deleteDoctor(doc.id);
                                }
                              },
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}