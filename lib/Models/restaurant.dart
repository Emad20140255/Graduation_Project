import 'dart:convert';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;



class Restaurant {
  String Name;
  String Description;
  String IconImagePath;
  String CoverImagePath;
  String PhoneNumber;
  String Address;
  String WorkingHours;
  List Menu=[];
  List Price=[];
  final fireStore = FirebaseDatabase.instance;
  List <Restaurant>restaurantsList =[];
  Restaurant(this.Name,this.Description ,this.Address,this.PhoneNumber,this.CoverImagePath,this.IconImagePath,this.WorkingHours,this.Menu,this.Price);

  Future <void> Fetch()async{
    final url = Uri.parse("https://recommedation-flutter-app-default-rtdb.firebaseio.com/Restaurants.json");
    try{
       
       final http.Response res = await http.get(url);
       print(json.decode(res.body));
       final extractedData = json.decode(res.body) as Map<String, dynamic>;
       extractedData.forEach((key, value) {
         var isExist = restaurantsList.firstWhere((element) => element.Name ==Name,orElse:()=>null);
         if(isExist==null){
           restaurantsList.add(Restaurant(value['Name'], value['Description'], value['Address'], value['PhoneNumber'], value['CoverImagePath'], value['IconImagePath'], value['WorkingHours'],value['Menu'],value['Price']));

         }
       });

    } catch(error){
      throw error;
    }



  }
}