import 'dart:convert';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;



class Cinema {
  String name_Arabic;
  String name_English;
  String address;
  String area;
  String governorate;
  String image_link;
  String location;
  String phone;
  String rate;
  final fireStore = FirebaseDatabase.instance;
  List <Cinema>cinemasList =[];
  Cinema(this.name_Arabic,this.name_English ,this.address,this.area,this.governorate,this.image_link,this.location,this.phone,this.rate);
/*
  Future <void> Fetch()async{
    final url = Uri.parse("https://recommedation-flutter-app-default-rtdb.firebaseio.com/Restaurants.json");


    try{
       
       final http.Response res = await http.get(url);
       print(json.decode(res.body));
       final extractedData = json.decode(res.body) as Map<String, dynamic>;
       extractedData.forEach((key, value) {
         var isExist = cinemasList.firstWhere((element) => element.Name ==Name,orElse:()=>null);
         if(isExist==null){
           cinemasList.add(Cinema(value['Name'], value['Description'], value['Address'], value['PhoneNumber'], value['CoverImagePath'], value['IconImagePath'], value['WorkingHours']));

         }
       });

    } catch(error){
      throw error;
    }



  }
  */
}