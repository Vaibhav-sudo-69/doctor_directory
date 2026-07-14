import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        title: const Text("About MediConnect"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xffE3F2FD),
                child: Icon(
                  Icons.local_hospital,
                  size: 55,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "MediConnect",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Version 1.0",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "MediConnect is a Flutter + Firebase based doctor directory and appointment booking application that helps patients connect with trusted doctors easily.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 35),

              const Divider(),

              const SizedBox(height: 20),

              ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Developed By"),
                subtitle: const Text(
                  "Vaibhav & Sushant",
                ),
              ),

              const ListTile(
                leading: Icon(Icons.code, color: Colors.green),
                title: Text("Technology"),
                subtitle: Text("Flutter • Firebase"),
              ),

              const ListTile(
                leading: Icon(Icons.copyright, color: Colors.orange),
                title: Text("Copyright"),
                subtitle: Text("© 2026 MediConnect"),
              ),

            ],
          ),
        ),
      ),
    );
  }
}