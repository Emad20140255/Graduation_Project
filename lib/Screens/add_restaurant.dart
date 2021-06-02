import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class AddRestaurant extends StatefulWidget {

   static const routeName ='/AddRestaurant';

  @override
  _AddRestaurantState createState() => _AddRestaurantState();
}

class _AddRestaurantState extends State<AddRestaurant> {
   TextEditingController _Restaurant_nameController = new TextEditingController();
   TextEditingController _Description_Controller = new TextEditingController();
   TextEditingController _PhoneNumber_Controller = new TextEditingController();
   TextEditingController _Address_Controller = new TextEditingController();
   TextEditingController _IconImagePath_Controller = new TextEditingController();
   TextEditingController _CoverImagePath_Controller = new TextEditingController();
   TextEditingController _WorkingHours_Controller = new TextEditingController();
   String Restaurant_name;
   DatabaseReference _ref;

    @override
   void initState() {
     super.initState();
     _Restaurant_nameController = TextEditingController();
     _ref = FirebaseDatabase.instance.reference().child('Restaurants');

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
          " Add Restaurant",
          style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
     
      body:SingleChildScrollView(
              child: Container(
          
          margin: EdgeInsets.all(15),
        child: Expanded(
          
          child: Column(
            
                  
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50,),
              TextFormField(
                controller: _Restaurant_nameController,
                decoration: InputDecoration(
                  hintText: 'Enter Restaurant Name ',
                
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
              SizedBox(height: 25),
              TextFormField(
                controller: _Description_Controller,
                decoration: InputDecoration(
                  hintText: 'Enter Restaurant Description ',
                 
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
              SizedBox(height: 25),
              TextFormField(
                controller: _Address_Controller,
                decoration: InputDecoration(
                  hintText: 'Enter Restaurant Address ',
                  
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(25),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _PhoneNumber_Controller,
                decoration: InputDecoration(
                  hintText: 'Enter Restaurant Phone Number ',
                 
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(25),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _CoverImagePath_Controller,
                decoration: InputDecoration(
                  hintText: 'Enter Restaurant Cover Image ',
                  
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(25),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _IconImagePath_Controller,
                decoration: InputDecoration(
                  hintText: 'Enter Restaurant Icon Image',
                  
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
              SizedBox(height: 25),
              TextFormField(
                controller: _WorkingHours_Controller,
                decoration: InputDecoration(
                  hintText: 'Enter Restaurant Working Hours ',
                  
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
              SizedBox(height: 25),
              
              
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: RaisedButton(onPressed: (){
                  SaveCategory();
                },
                child: Text('Add Restaurant', style: TextStyle(
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
            ),
      ),
    
    );

    
  }
  void SaveCategory(){
      String Restaurant_name = _Restaurant_nameController.text;
      String Description = _Description_Controller.text;
      String Address = _Address_Controller.text;
      String PhoneNumber= _PhoneNumber_Controller.text;
      String CoverImagePath = _CoverImagePath_Controller.text;
      String IconImagePath = _IconImagePath_Controller.text;
      String WorkingHours = _WorkingHours_Controller.text;

      Map<String,String> category = {
        'Name' : Restaurant_name,
        'Description': Description,
        'Address':Address,
        'PhoneNumber': PhoneNumber,
        'CoverImagePath': CoverImagePath,
        'IconImagePath': IconImagePath,
        'WorkingHours': WorkingHours,
      };

      _ref.push().set(category).then((value) {
        Navigator.pop(context);

      });

    }
}