class Appointment {

  final String doctorName;
  final String specialization;
  final String patientName;
  final String phoneNumber;
  final String date;
  final String time;

  // NEW
  String status;


  Appointment({
    required this.doctorName,
    required this.specialization,
    required this.patientName,
    required this.phoneNumber,
    required this.date,
    required this.time,

    this.status = "Pending",
  });


  Map<String, dynamic> toJson() {

    return {

      "doctorName": doctorName,

      "specialization": specialization,

      "patientName": patientName,

      "phoneNumber": phoneNumber,

      "date": date,

      "time": time,

      "status": status,

    };

  }



  factory Appointment.fromJson(
      Map<String, dynamic> json) {

    return Appointment(

      doctorName: json["doctorName"],

      specialization: json["specialization"],

      patientName: json["patientName"],

      phoneNumber: json["phoneNumber"],

      date: json["date"],

      time: json["time"],


      // old appointments protection
      status: json["status"] ?? "Pending",

    );

  }

}