import 'dart:convert';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;



class Movie {
  String arabic_name;
  String english_name;
  String authors;
  String categorization_tags;
  String image;
  String actors;
  String country;
  String rate;
  String date_of_creation;
  String director;
  String duration;
  String summery;
  final fireStore = FirebaseDatabase.instance;
  List <Movie>cinemasList =[];
  Movie(this.arabic_name,this.english_name ,this.authors,this.categorization_tags,this.image,this.actors,this.country,this.rate,this.date_of_creation,this.director,this.duration,this.summery);
}