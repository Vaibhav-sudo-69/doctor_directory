import 'package:flutter/material.dart';
import '../models/doctor.dart';
import '../screens/doctor_details_screen.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DoctorDetailsScreen(
              doctor: doctor,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 18),
        elevation: 5,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Doctor Image
              CircleAvatar(
                radius: 38,
                backgroundImage: AssetImage(
                  doctor.image,
                ),
              ),

              const SizedBox(width: 15),

              /// Doctor Information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [

                        Expanded(
                          child: Text(
                            doctor.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            doctor.isFavorite = !doctor.isFavorite;

                            (context as Element).markNeedsBuild();
                          },
                          icon: Icon(
                            doctor.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [

                        const Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 18,
                        ),

                        const SizedBox(width: 4),

                        const Text(
                          "4.9",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(width: 15),

                        const Icon(
                          Icons.medical_services,
                          color: Colors.blue,
                          size: 18,
                        ),

                        const SizedBox(width: 4),

                        Expanded(
                          child: Text(
                            doctor.specialization,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [

                        const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 18,
                        ),

                        const SizedBox(width: 5),

                        Expanded(
                          child: Text(
                            doctor.clinicName,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [

                        const Icon(
                          Icons.schedule,
                          color: Colors.green,
                          size: 18,
                        ),

                        const SizedBox(width: 5),

                        Expanded(
                          child: Text(
                            doctor.timings,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [

                        const Icon(
                          Icons.work,
                          color: Colors.deepPurple,
                          size: 18,
                        ),

                        const SizedBox(width: 5),

                        Text(
                          "${doctor.experience} Years Experience",
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              /// Call Button
              CircleAvatar(
                backgroundColor: Colors.green.shade100,
                radius: 24,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.call,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}