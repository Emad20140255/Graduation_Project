import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:provider/provider.dart';
import 'package:recommendation_flutter_app/Models/restaurant.dart';
import 'package:recommendation_flutter_app/Screens/add_cinema.dart';
import 'package:recommendation_flutter_app/Screens/add_restaurant.dart';
import 'package:recommendation_flutter_app/Screens/cinema_details.dart';
import 'package:recommendation_flutter_app/Screens/edit_cinema.dart';

import 'edit_restaurant.dart';

class CinemasDetails extends StatefulWidget {

  String SelectCategory;

  String PageKey;
  CinemasDetails({this.PageKey});
  static const routeName ='/CinemasDetails';

  
  @override
  _CinemasDetailsState createState() => _CinemasDetailsState();
}

class _CinemasDetailsState extends State<CinemasDetails> {
  Query referenceData;
  DatabaseReference reference = FirebaseDatabase.instance.reference().child('All_Cinemas').child('Movies_in_each_cinema');
  
  List<Restaurant>DataList=[];
bool _isLooding = true;  

  @override
  void initState() {
    super.initState();
     referenceData =  FirebaseDatabase.instance.reference().child('All_Cinemas').child('Movies_in_each_cinema').orderByChild('name_English').equalTo(widget.PageKey);
  }


    Widget _buildCategoryItem({Map movie}){
      int i =0;
     // while(widget.PageKey==movie['name_English']){
      if(widget.PageKey==movie['name_English']){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(5),
      height: 650,
      width:  double.infinity,
      color: Colors.white,
      child: Expanded(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
             child: InkWell(
              onTap: () {},
              child: Card(
             child: Column(
                  
                  children: [
                Container(
                  height: 300,
                  width:double.infinity, 
                  child: Image.network(movie['movie_image']),),
                SizedBox(height: 18,),
                Container(
                  height: 40,
                  width:  double.infinity,
                  child:  Text("Name:${movie['movie_name'].toString()}",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,

                  ),
                  ),
                ), 
                 SizedBox(height: 18,),
                Container(
                  height: 100,
                  width:  double.infinity,
                  child:  Text("Movie ShowTimes:${movie['movie_showTimes'].toString()}",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,

                  ),
                  ),
                ), 
                 SizedBox(height: 18,),
                Container(
                  height: 100,
                  width:  double.infinity,
                  child:  Text("Movie Prices:${movie['movie_price']}",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,

                  ),
                  ),
                ),                
              
                  ]
                  ),
              ),
                        ),
            ),
      
          ],
          ),
      ),
    );
    }
  }


   ShowDeleteDailog({Map moviee}){
    showDialog(
      context: context,
       builder: (context){
         return AlertDialog(
           title: Text('Delete ${moviee['movie_name']}'),
           content: Text('Are You Sure You Want To Delete?'),
           actions: [
              FlatButton(onPressed: () {  
                Navigator.pop(context);           
           },
           child: Text('Cancel'),
           ),
             FlatButton(onPressed: () {  
               reference.child(moviee['Key']).remove().whenComplete(() => Navigator.pop(context));           
           },
           child: Text('Delete'),
           ),
           ],
         );
       },
       );

  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        
      ),
      body:Container(
          height: double.infinity,
          child: FirebaseAnimatedList(query:referenceData ,itemBuilder: (BuildContext context,DataSnapshot snapshot,Animation<double>animation,int index ){
              Map Movie_In_Each_Cinema = snapshot.value;
              Movie_In_Each_Cinema['Key'] = snapshot.key;
              return _buildCategoryItem(movie: Movie_In_Each_Cinema);
            },),
        ),
      
       floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF262AAA),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_){
              return AddCinema();

      
    
  }

  

      ),
    );
  
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
            ),

       )
    );
  }
}
