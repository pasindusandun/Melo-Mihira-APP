import 'dart:convert';

import 'package:optimum_music/constants/dummy.dart';

class Demographic {
  String gender;
  String age;
  String ethnicity;
  // List<String>? recommendations;

  Demographic(
      {required this.gender,
      required this.age,
      required this.ethnicity,
      // required this.recommendations
      }
      );

  factory Demographic.fromJson(Map<String, dynamic> json) {
    return Demographic(
        gender: json['Gender'],
        age: json['Age'],
        ethnicity: json['Ethnicity'],
        // recommendations: json['Recommendations'].cast<String>()
        );
  }
}

class APICall {
  Future<Demographic> demographic() async {
    final respons = demographicR;
    await Future.delayed(Duration(seconds: 1));
    return Demographic.fromJson(json.decode(respons));
  }

}
