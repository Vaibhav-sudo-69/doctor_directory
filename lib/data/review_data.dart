import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/review.dart';


List<Review> reviews = [];


// SAVE REVIEWS
Future<void> saveReviews() async {

  final prefs = await SharedPreferences.getInstance();

  List<String> reviewList =
  reviews.map((review) {

    return jsonEncode(
      review.toJson(),
    );

  }).toList();


  await prefs.setStringList(
    "reviews",
    reviewList,
  );

}


// LOAD REVIEWS
Future<void> loadReviews() async {

  final prefs = await SharedPreferences.getInstance();

  List<String>? savedReviews =
  prefs.getStringList(
    "reviews",
  );


  if (savedReviews != null) {

    reviews =
        savedReviews.map((review) {

          return Review.fromJson(
            jsonDecode(review),
          );

        }).toList();

  }

}