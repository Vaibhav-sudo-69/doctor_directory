import 'package:flutter/material.dart';
import '../models/doctor.dart';
import '../models/appointment.dart';
import '../data/appointment_data.dart';

class AppointmentScreen extends StatefulWidget {
  final Doctor doctor;

  const AppointmentScreen({
    super.key,
    required this.doctor,
  });

  @override
  State<AppointmentScreen> createState() =>
      _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        title: const Text("Book Appointment"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              widget.doctor.name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              widget.doctor.specialization,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 17,
              ),
            ),


            const SizedBox(height: 30),


            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Patient Name",
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),


            const SizedBox(height: 20),


            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Phone Number",
                prefixIcon: const Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),


            const SizedBox(height: 20),


            TextField(
              controller: dateController,
              readOnly: true,

              onTap: () async {

                DateTime? pickedDate =
                await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                  initialDate: DateTime.now(),
                );

                if (pickedDate != null) {
                  dateController.text =
                  "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                }

              },

              decoration: InputDecoration(
                labelText: "Appointment Date",
                prefixIcon: const Icon(Icons.calendar_month),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),


            const SizedBox(height: 20),


            TextField(
              controller: timeController,
              readOnly: true,

              onTap: () async {

                TimeOfDay? pickedTime =
                await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (pickedTime != null) {
                  timeController.text =
                      pickedTime.format(context);
                }

              },

              decoration: InputDecoration(
                labelText: "Appointment Time",
                prefixIcon: const Icon(Icons.access_time),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),


            const Spacer(),


            SizedBox(
              height: 55,
              width: double.infinity,

              child: ElevatedButton(

                onPressed: () {

                  if (
                  nameController.text.isEmpty ||
                      phoneController.text.isEmpty ||
                      dateController.text.isEmpty ||
                      timeController.text.isEmpty
                  ) {

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Please fill all details ❌",
                        ),
                      ),
                    );

                    return;
                  }

                  if (phoneController.text.length != 10) {

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Enter valid 10 digit phone number ❌",
                        ),
                      ),
                    );

                    return;
                  }


                  appointments.add(
                    Appointment(
                      doctorName: widget.doctor.name,
                      specialization: widget.doctor.specialization,
                      patientName: nameController.text,
                      phoneNumber: phoneController.text,
                      date: dateController.text,
                      time: timeController.text,
                    ),
                  );


                  saveAppointments();


                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Appointment Saved Successfully ✅",
                      ),
                    ),
                  );


                  Navigator.pop(context);

                },

                child: const Text(
                  "CONFIRM APPOINTMENT",
                  style: TextStyle(
                    fontSize: 17,
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