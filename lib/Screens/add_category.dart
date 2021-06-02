import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:recommendation_flutter_app/Widgets/sideBar.dart';

class AddCategory extends StatefulWidget {
  static const routeName = '/Add Category';


  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {

   TextEditingController _Category_nameController = new TextEditingController();
   String Category_name;
   DatabaseReference _ref;

   
   @override
   void initState() {
     super.initState();
     _Category_nameController = TextEditingController();
     _ref = FirebaseDatabase.instance.reference().child('Categories');

   }

   Widget _buildCategoryType(String title){
     return InkWell(
       child: Container(
         height: 40,
         width: 90,
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(15),
         ),
         child: Center(
           child: Text(title , style: TextStyle(
             fontSize: 18,
             color: Colors.white,
           ),),
         ),
       ),
       onTap: (){
         setState(() {
           
         });
       },
     );

   }

  @override
  

  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          " Add Category",
          style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
     
      body:Container(
        
        margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50,),
          TextFormField(
            controller: _Category_nameController,
            decoration: InputDecoration(
              hintText: 'Enter Category Name ',
              prefixIcon: Icon(
                Icons.category,size: 30,
              ),
              fillColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsets.all(15),
            ),
          ),
          SizedBox(height: 15),
          
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: RaisedButton(onPressed: (){
              SaveCategory();
            },
            child: Text('Add Category', style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),),
            color: Color(0xFF262AAA),
            )
          ),
        
        ]

            ),
          ),
    
    );

    
  }
  void SaveCategory(){
      String category_name = _Category_nameController.text;

      Map<String,String> category = {
        'Category_name' : category_name,
      };

      _ref.push().set(category).then((value) {
        Navigator.pop(context);

      });

    }
}