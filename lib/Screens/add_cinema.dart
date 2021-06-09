import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class AddCinema extends StatefulWidget {

   static const routeName ='/AddCinema';

  @override
  _AddCinemaState createState() => _AddCinemaState();
}

class _AddCinemaState extends State<AddCinema> {
  TextEditingController _name_English_Controller = new TextEditingController();
  TextEditingController _name_Arabic_Controller = new TextEditingController();
  TextEditingController _area_Controller = new TextEditingController();
  TextEditingController _phone_Controller = new TextEditingController();
  TextEditingController _address_Controller = new TextEditingController();
  TextEditingController _governorate_Controller = new TextEditingController();
  TextEditingController _image_link_Controller = new TextEditingController();
  TextEditingController _location_Controller = new TextEditingController();

   String Cinema_name;
   DatabaseReference _ref;

    @override
   void initState() {
     super.initState();
     _name_English_Controller = TextEditingController();
     _ref = FirebaseDatabase.instance.reference().child('All_Cinemas').child('Cinemas');

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
          " Add Cinema",
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
                controller: _name_English_Controller,
                decoration: InputDecoration(
                  hintText: 'Enter Cinema English Name ',
                
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
              SizedBox(height: 25),
               TextFormField(
                controller: _name_Arabic_Controller,
                decoration: InputDecoration(
                  hintText: 'Enter Cinema Arabic Name ',
                
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
              SizedBox(height: 25),
              TextFormField(
                controller: _area_Controller,
                decoration: InputDecoration(
                  hintText: 'Enter Cinema Area ',
                 
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
              SizedBox(height: 25),
              TextFormField(
                controller: _phone_Controller,
                decoration: InputDecoration(
                  hintText: 'Enter Cinema Phone ',
                  
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(25),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _address_Controller,
                decoration: InputDecoration(
                  hintText: 'Enter Cinema Address ',
                 
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(25),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _governorate_Controller,
                decoration: InputDecoration(
                  hintText: 'Enter Cinema Governorate',
                  
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(25),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _image_link_Controller,
                decoration: InputDecoration(
                  hintText: 'Enter Cinema Image Path',
                  
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
              SizedBox(height: 25),
              TextFormField(
                controller: _location_Controller,
                decoration: InputDecoration(
                  hintText: 'Enter Cinema Location ',
                  
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
                child: Text('Add Cinema', style: TextStyle(
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

      String nameEnglish = _name_English_Controller.text;
      String nameArabic = _name_Arabic_Controller.text;
      String area = _area_Controller.text;
      String phone= _phone_Controller.text;
      String address = _address_Controller.text;
      String governorate = _governorate_Controller.text;
      String imageLink = _image_link_Controller.text;
      String location = _location_Controller.text;


      Map<String,String> cinemaa = {
        'name_English': nameEnglish,
        'name_Arabic': nameArabic,
        'area': area,
        'phone':phone,
        'address': address,
        'governorate': governorate,
        'image_link': imageLink,
        'location': location,
      };

      _ref.push().set(cinemaa).then((value) {
        Navigator.pop(context);

      });

    }
}