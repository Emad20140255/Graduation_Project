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

class CinemasPage  extends StatefulWidget {

  String SelectCategory;

  String PageKey;
  CinemasPage();
  static const routeName ='/Cinemas';

  
  @override
  _CinemasPageState createState() => _CinemasPageState();
}

class _CinemasPageState extends State<CinemasPage> {
  Query referenceData;
  DatabaseReference reference = FirebaseDatabase.instance.reference().child('All_Cinemas').child('Cinemas');
  
  List<Restaurant>DataList=[];
bool _isLooding = true;  

  @override
  void initState() {
    super.initState();
    referenceData = FirebaseDatabase.instance.reference().child('All_Cinemas').child('Cinemas').orderByChild('name_English');
  }


    Widget _buildCategoryItem({Map cinemas}){
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
            SizedBox(height: 5,),
            Expanded(
             child: InkWell(
              onTap: () {},
              child: Card(
             child: Column(
                  
                  children: [
                SizedBox(width: 6,),
                Container(
                  height: 350,
                  width:double.infinity, 
                  child: Image.network(cinemas['image_link']),),
                SizedBox(height: 18,),
                Container(
                  height: 40,
                  width:  double.infinity,
                  child:  Text("Name:${cinemas['name_English']}",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,

                  ),
                  ),
                ),
               
                
                SizedBox(width: 6,),
                 Container(
                 height: 70,
                 width:  double.infinity,
                  child:  Text("Address:${cinemas['address']}${cinemas['area']}${cinemas['governorate']}",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,

                  ),
                  ),
                ),
                SizedBox(width: 6,),
                 Container(
                 height: 40,
                 width:  double.infinity,
                  child:  Text("Phone:${cinemas['phone']}",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,

                  ),
                  ),
                ),
                SizedBox(width: 6,),
                 Container(
                 height: 40,
                 width:  double.infinity,
                  child:  Text("Rate:${cinemas['rate']}",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,

                  ),
                  ),
                ),
                SizedBox(width: 6,),
                 GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> CinemasDetails(PageKey: cinemas['name_English'],)));
                },
                child: Expanded(
                  child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.edit , color: Color(0xFF262AAA),),
                      SizedBox(width: 6,),
                      Text('Movies',
                      style: TextStyle(
                        fontSize: 22,
                        color: Color(0xFF262AAA),
                        fontWeight: FontWeight.w600,
                      ),
                      ),
                    ],
                  ),
                ),
              ),

                  ]
                  ),
              ),
                        ),
            ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
              GestureDetector(
                
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> EditCinema(CinemaKey: cinemas['Key'],)));
                },
                child: Expanded(
                   child: Row(
                    children: [
                      Icon(Icons.edit , color: Color(0xFF262AAA),),

                      SizedBox(width: 6,),
                      Text('Edit',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF262AAA),
                        fontWeight: FontWeight.w600,
                      ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox( width: 20,),

              GestureDetector(
                
                onTap: (){
                  ShowDeleteDailog(cinema:cinemas);
                },
                child: Expanded(
                                child: Row(
                    children: [
                      Icon(Icons.edit , color: Colors.red[700],),

                      SizedBox(width: 6,),
                      Text('Delete',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red[700],
                        fontWeight: FontWeight.w600,
                      ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width:20 ,),
              ]
            ),
           

          ],
          ),
      ),
    );
  }


   ShowDeleteDailog({Map cinema}){
    showDialog(
      context: context,
       builder: (context){
         return AlertDialog(
           title: Text('Delete ${cinema['movie_name']}'),
           content: Text('Are You Sure You Want To Delete?'),
           actions: [
              FlatButton(onPressed: () {  
                Navigator.pop(context);           
           },
           child: Text('Cancel'),
           ),
             FlatButton(onPressed: () {  
               reference.child(cinema['Key']).remove().whenComplete(() => Navigator.pop(context));           
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
              return _buildCategoryItem(cinemas: Movie_In_Each_Cinema);
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
