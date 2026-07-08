class DoctorRequest {

  final String name;
  final String email;
  final String password;
  final String specialization;
  final String clinicName;
  final String phoneNumber;

  String status;


  DoctorRequest({

    required this.name,
    required this.email,
    required this.password,
    required this.specialization,
    required this.clinicName,
    required this.phoneNumber,

    this.status = "Pending",

  });



  Map<String, dynamic> toJson() {

    return {

      "name": name,
      "email": email,
      "password": password,
      "specialization": specialization,
      "clinicName": clinicName,
      "phoneNumber": phoneNumber,
      "status": status,

    };

  }




  factory DoctorRequest.fromJson(
      Map<String, dynamic> json,
      ) {

    return DoctorRequest(

      name: json["name"],

      email: json["email"],

      password: json["password"],

      specialization: json["specialization"],

      clinicName: json["clinicName"],

      phoneNumber: json["phoneNumber"],

      status: json["status"],

    );

  }

}