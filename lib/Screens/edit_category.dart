import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class EditCategory extends StatefulWidget {
  String categoryKey;
  EditCategory({this.categoryKey});

  @override
  _EditCategoryState createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {

   TextEditingController _Category_nameController = new TextEditingController();
   String Category_name;
   DatabaseReference _ref;

   @override
   void initState() {
     super.initState();
     _Category_nameController = TextEditingController();
     _ref = FirebaseDatabase.instance.reference().child('Categories');
     getCategoryDetail();

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
      appBar: AppBar(title: Text("Update Category"),backgroundColor: Colors.transparent,
        elevation: 0,),
      body:Container(
        margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            child: Text('Update Category', style: TextStyle(
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

  getCategoryDetail() async{
    DataSnapshot snapshot= await _ref.child(widget.categoryKey).once(); 
    Map category = snapshot.value;
    _Category_nameController.text = category['Category_name'];
    
     }


  void SaveCategory(){
      String category_name = _Category_nameController.text;

      Map<String,String> category = {
        'Category_name' : category_name,
      };

      _ref.child(widget.categoryKey).update(category).then((value) {
        Navigator.pop(context);

      });

    }
}