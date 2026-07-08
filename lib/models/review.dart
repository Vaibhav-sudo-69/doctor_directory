class Review {

  final String doctorName;
  final String userName;
  final String reviewText;
  final double rating;


  Review({
    required this.doctorName,
    required this.userName,
    required this.reviewText,
    required this.rating,
  });


  Map<String, dynamic> toJson() {

    return {
      "doctorName": doctorName,
      "userName": userName,
      "reviewText": reviewText,
      "rating": rating,
    };

  }


  factory Review.fromJson(Map<String, dynamic> json) {

    return Review(
      doctorName: json["doctorName"],
      userName: json["userName"],
      reviewText: json["reviewText"],
      rating: json["rating"],
    );

  }

}