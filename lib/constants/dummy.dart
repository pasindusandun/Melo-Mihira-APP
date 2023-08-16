import 'dart:convert';

import 'package:optimum_music/utils/models.dart';

final demographic = {
  "Gender": "male",
  "Age": "133",
  "Ethnicity": "white",
  "Recommendations": [
  "https://foo.com/bar.mp3",
    "https://foo.com/bar.mp3",
    "led zeppelin",
    "king diamond",
    "live",
    "solitary experiments",
    "in flames",
    "ian moss",
    "gipsy kings",
    "fatboy slim"
  ]
};
final demographicR = json.encode(demographic);
