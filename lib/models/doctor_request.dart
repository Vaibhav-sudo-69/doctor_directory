class DoctorRequest {

  final String name;
  final String email;
  final String password;
  final String specialization;
  final String clinicName;
  final String phoneNumber;

  final String qualification;
  final int experience;
  final String address;
  final String timings;

  String status;


  DoctorRequest({

    required this.name,
    required this.email,
    required this.password,
    required this.specialization,
    required this.clinicName,
    required this.phoneNumber,

    required this.qualification,
    required this.experience,
    required this.address,
    required this.timings,

    this.status = "Pending",

  });




  // SAVE DATA
  Map<String, dynamic> toJson() {

    return {

      "name": name,

      "email": email,

      "password": password,

      "specialization": specialization,

      "clinicName": clinicName,

      "phoneNumber": phoneNumber,

      "qualification": qualification,

      "experience": experience,

      "address": address,

      "timings": timings,

      "status": status,

    };

  }






  // LOAD DATA
  factory DoctorRequest.fromJson(
      Map<String, dynamic> json,
      ) {

    return DoctorRequest(

      name:
      json["name"] ?? "",


      email:
      json["email"] ?? "",


      password:
      json["password"] ?? "",


      specialization:
      json["specialization"] ?? "",


      clinicName:
      json["clinicName"] ?? "",


      phoneNumber:
      json["phoneNumber"] ?? "",



      qualification:
      json["qualification"] ?? "",



      experience:
      json["experience"] ?? 0,



      address:
      json["address"] ?? "",



      timings:
      json["timings"] ?? "",



      status:
      json["status"] ?? "Pending",

    );

  }

}