
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:recommendation_flutter_app/Screens/add_category.dart';
import 'package:recommendation_flutter_app/Screens/restaurants_page.dart';
import 'package:recommendation_flutter_app/Screens/edit_category.dart';
import 'package:recommendation_flutter_app/Widgets/sideBar.dart';

import 'cinema_page.dart';

class Categories extends StatefulWidget {

  String categoname;

  static const routeName = '/Categories';
  Categories({this.categoname});

  void selectCategory(BuildContext ctx){
Navigator.of(ctx).pushNamed(RestaurantsPage.routeName,
arguments: {
  'Name' : categoname,
},
);
}

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
Query _ref;
DatabaseReference reference = FirebaseDatabase.instance.reference().child('Categories');
 






@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ref = FirebaseDatabase.instance.reference().child('Categories');
  }

  

  Widget _buildCategoryItem({Map category}){
    String categoname;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(5),
      height: 100,
      color: Colors.white,
      child: Expanded(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5,),
            Expanded(
             child: InkWell(
               
              onTap: () {if (category['Category_name'] == 'Restaurants') {

                Navigator.push(context, MaterialPageRoute(builder: (_)=> RestaurantsPage()));
                }
                if (category['Category_name'] == 'Cinemas') {
                  
                } else {
                }{
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> CinemasPage()));

                }

              }

              
              ,
                
              child: Row(
                
                children: [
              Icon(Icons.category_sharp,color: Color(0xFF262AAA),size: 20,),
              SizedBox(width: 6,),
              Text(category['Category_name'],
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.w600,

                ),
                ),
                ]
                ),
                        ),
            ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
              GestureDetector(
                
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> EditCategory(categoryKey: category['Key'],)));
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
                  ShowDeleteDailog(category:category);
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

  ShowDeleteDailog({Map category}){
    showDialog(
      context: context,
       builder: (context){
         return AlertDialog(
           title: Text('Delete ${category['Category_name']}'),
           content: Text('Are You Sure You Want To Delete?'),
           actions: [
              FlatButton(onPressed: () {  
                Navigator.pop(context);           
           },
           child: Text('Cancel'),
           ),
             FlatButton(onPressed: () {  
               reference.child(category['Key']).remove().whenComplete(() => Navigator.pop(context));           
           },
           child: Text('Delete'),
           ),
           ],
         );
       },
       );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
       // title: Text(
        //  "Categories",
        //  style: TextStyle( color: Color(0xFF262AAA),fontSize: 35,fontWeight: FontWeight.bold),
      //  ),
        
        centerTitle: true,
      ),
      
        body: Container(
          height: double.infinity,
          
          child: FirebaseAnimatedList(query:_ref ,itemBuilder: (BuildContext context,DataSnapshot snapshot,Animation<double>animation,int index ){
            Map category = snapshot.value;
            category['Key'] = snapshot.key;
            return _buildCategoryItem(category: category);
          },),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF262AAA),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_){
              return AddCategory();

            }));

          },
          child: Icon(
            Icons.add,
            color: Colors.white,
            ),
          ),
      
    );
  }
}