import 'dart:convert';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;







class Movie_in_Cinema {
  String movie_image;
  String movie_name;
  String name_English;
  List movie_price;
  List movie_showTimes;


  final fireStore = FirebaseDatabase.instance;
  List <Movie_in_Cinema>cinemasList =[];
  Movie_in_Cinema(this.movie_image,this.movie_name ,this.name_English,this.movie_price,this.movie_showTimes);
}