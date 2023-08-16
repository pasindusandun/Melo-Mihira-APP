import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Song {
  final String name;
  final String singer;
  final String image;
  final String url;
  final int duration;
  Song(
      {required this.name,
      required this.singer,
      required this.image,
      required this.duration,
      required this.url
    });
    factory Song.fromJson(dynamic json) {
    return Song(
        name: json['name'] as String,
        singer: json['singer'] as String,
        image: json['image'] as String,
        url: json['url'] as String,
        duration:json['duration']as int
        );
  }
}
