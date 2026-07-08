class Doctor {

  final String name;
  final String specialization;
  final String clinicName;
  final String phoneNumber;
  final String address;
  final String timings;
  final int experience;
  final String qualification;
  final String image;
  final double rating;
  final List<Map<String, dynamic>> reviews;

  bool isFavorite;


  Doctor({

    required this.name,
    required this.specialization,
    required this.clinicName,
    required this.phoneNumber,
    required this.address,
    required this.timings,
    required this.experience,
    required this.qualification,
    required this.image,
    required this.rating,
    required this.reviews,

    this.isFavorite = false,

  });



  // SAVE DOCTOR TO FIREBASE
  Map<String, dynamic> toJson() {

    return {

      "name": name,

      "specialization": specialization,

      "clinic": clinicName,

      "phone": phoneNumber,

      "address": address,

      "timings": timings,

      "experience": experience,

      "qualification": qualification,

      "image": image,

      "rating": rating,

      "reviews": reviews,

      "isFavorite": isFavorite,

    };

  }





  // GET DOCTOR FROM FIREBASE
  factory Doctor.fromJson(Map<String, dynamic> json) {

    return Doctor(

      name: json["name"] ?? "",

      specialization: json["specialization"] ?? "",


      // Firebase compatibility
      clinicName: json["clinicName"]
          ?? json["clinic"]
          ?? "",


      phoneNumber: json["phoneNumber"]
          ?? json["phone"]
          ?? "",


      address: json["address"] ?? "",


      timings: json["timings"] ?? "",


      experience: json["experience"] ?? 0,


      qualification: json["qualification"] ?? "",


      image: json["image"] ?? "assets/doctor.png",


      rating: (json["rating"] ?? 0).toDouble(),


      reviews: List<Map<String, dynamic>>.from(
        json["reviews"] ?? [],
      ),


      isFavorite: json["isFavorite"] ?? false,

    );

  }
}