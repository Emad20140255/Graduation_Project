import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:provider/provider.dart';
import 'package:recommendation_flutter_app/Models/restaurant.dart';
import 'package:recommendation_flutter_app/Screens/add_restaurant.dart';
import 'package:recommendation_flutter_app/Screens/restaurant_menu.dart';
import 'package:recommendation_flutter_app/Screens/restaurants_page.dart';

import 'edit_restaurant.dart';

class RestaurantsMenu  extends StatefulWidget {

  String SelectCategory;

  String PageKey;
  RestaurantsMenu({this.PageKey});
  static const routeName ='/RestaurantsMenu';

  
  @override
  _RestaurantsMenuState createState() => _RestaurantsMenuState();
}

class _RestaurantsMenuState extends State<RestaurantsMenu> {
  Query referenceData;
  DatabaseReference reference = FirebaseDatabase.instance.reference().child('Restaurants');
  List <dynamic> DataList=[];
  String m;
  List  <dynamic> Mennu=[];
  bool _isLooding = true;  

  @override
  void initState() {
    super.initState();
    referenceData = FirebaseDatabase.instance.reference().child('Restaurants').orderByChild('Name').equalTo(widget.PageKey);
  
  }


    Widget _buildCategoryItem({Map restauraannt}){
      if(widget.PageKey==restauraannt['Name']){
        DataList = restauraannt['Menu'].toString().split(',').toList();
        Mennu = restauraannt['Price'].toString().split(',').toList();
       
      return SingleChildScrollView(
              child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(5),
        height: 8000,
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
               
                child: InkWell(
                  onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (_)=> RestaurantsPage()));
                    
                  },
                 child: Card(
                 child:Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children:[
                   Column(
                    children: [
                    SizedBox(width: 6,),
                   for(int i=0;i<DataList.length;i++)
                     Container(
                      height: 80,
                      width: 150,
                      child: Text(DataList[i],
                      style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      ),
                      ),
                    ),
                      ]
                      ),
                    Column(  
                    children: [
                    SizedBox(width: 6,),
                   for(int i=0;i<DataList.length;i++)
                     Container(
                      height: 80,
                      width: 150,
                      child: Text(Mennu[i],
                      style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      ),
                      ),
                    ),                   
                      ]
                      ),
                   ]
               )
                  ),
                ),
                          ),
              ),
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> EditRestaurant(RestaurantKey: restauraannt['Name'],)));
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
    ),
      );
      }
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
              res['Key'] = (snapshot.key).toString();
                 return _buildCategoryItem(restauraannt: res );
            },),
        ),
   
    );
  }
}
