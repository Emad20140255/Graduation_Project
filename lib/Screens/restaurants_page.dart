import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:provider/provider.dart';
import 'package:recommendation_flutter_app/Models/restaurant.dart';
import 'package:recommendation_flutter_app/Screens/add_restaurant.dart';
import 'package:recommendation_flutter_app/Screens/restaurant_menu.dart';

import 'edit_restaurant.dart';

class RestaurantsPage  extends StatefulWidget {

  String SelectCategory;

  String PageKey;
  RestaurantsPage();
  static const routeName ='/Restaurants';

  
  @override
  _RestaurantsPageState createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {
  Query referenceData;
  DatabaseReference reference = FirebaseDatabase.instance.reference().child('Restaurants');
  List<Restaurant>DataList=[];
bool _isLooding = true;  

  @override
  void initState() {
    super.initState();
    referenceData = FirebaseDatabase.instance.reference().child('Restaurants').orderByChild('Name');
    
    

    
   
    
  }


    Widget _buildCategoryItem({Map restauraannt}){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(5),
      height: 550,
      width: double.infinity,
      color: Colors.white,
      child: Expanded(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5,),
            Expanded(
             child: Container(
             
              child: Card(
             child: Column(
                  
                  children: [
                SizedBox(width: 6,),
                Container(
                  height: 200,
                  width: double.infinity, 
                  child: Image.network(restauraannt['CoverImagePath']),),
                  SizedBox(width: 6,),
                 Container(
                   padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                  height: 30,
                  width:  double.infinity,
                  child: Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(restauraannt['IconImagePath'],
                    ))),
                  Text(restauraannt['Name'],
                  style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  ),
                  ),
                  ]
                ),
                 ),
                SizedBox(width: 6,),
                 Container(
                  height: 30,
                  width:  double.infinity,
                  child: Text(restauraannt['Description'],
                  style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  ),
                  ),
                ),
                SizedBox(width: 6,),
                Container(  
                  height: 52,
                  width:  double.infinity,
                  child: Text(restauraannt['Address'],
                  style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  ),
                  ),
                ),
                SizedBox(width: 10,),
                Container(  
                  height: 40,
                  width:  double.infinity,
                  child: Text(restauraannt['PhoneNumber'].toString(),
                  style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  ),
                  ),
                ),
                SizedBox(width: 6,),
                Container(  
                  height: 36,
                  width:  double.infinity,
                  child: Text(restauraannt['WorkingHours'].toString(),
                  style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  ),
                  ),
                ),
                SizedBox(width: 6,),
                 GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> RestaurantsMenu(PageKey: restauraannt['Name'],)));
                },
                child: Expanded(
                  child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.edit , color: Color(0xFF262AAA),),
                      SizedBox(width: 6,),
                      Text('Menu',
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
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> EditRestaurant(RestaurantKey: restauraannt['Key'],)));
                },
                child: Expanded(
                  child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.edit , color: Color(0xFF262AAA),),
                      SizedBox(width: 6,),
                      Text('Edit',
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
              SizedBox( width: 20,),

              GestureDetector(
                
                onTap: (){
                  ShowDeleteDailog(restoo:restauraannt);
                },
                child: Expanded(
                    child: Row(
                       mainAxisAlignment: MainAxisAlignment.end,

                    children: [
                      Icon(Icons.edit , color: Colors.red[700],),

                      SizedBox(width: 6,),
                      Text('Delete',
                      style: TextStyle(
                        fontSize: 22,
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


   ShowDeleteDailog({Map restoo}){
    showDialog(
      context: context,
       builder: (context){
         return AlertDialog(
           title: Text('Delete ${restoo['Name']}'),
           content: Text('Are You Sure You Want To Delete?'),
           actions: [
              FlatButton(onPressed: () {  
                Navigator.pop(context);           
           },
           child: Text('Cancel'),
           ),
             FlatButton(onPressed: () {  
               reference.child(restoo['Key']).remove().whenComplete(() => Navigator.pop(context));           
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
              Map res = snapshot.value;
              res['Key'] = snapshot.key;
              return _buildCategoryItem(restauraannt: res);
            },),
        ),
      
       floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF262AAA),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_){
              return AddRestaurant();

      
    
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
