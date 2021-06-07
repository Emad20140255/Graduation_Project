import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class EditRestaurant extends StatefulWidget {
  String RestaurantKey;
  EditRestaurant({this.RestaurantKey});
  @override
  _EditRestaurantState createState() => _EditRestaurantState();
}

class _EditRestaurantState extends State<EditRestaurant> {
  TextEditingController _Restaurant_nameController = new TextEditingController();
  TextEditingController _Description_Controller = new TextEditingController();
  TextEditingController _PhoneNumber_Controller = new TextEditingController();
  int phoneNumber_Controller;
  TextEditingController _Address_Controller = new TextEditingController();
  TextEditingController _Working_Hours_Controller = new TextEditingController();
  TextEditingController _CoverImagePath_Controller = new TextEditingController();
  TextEditingController _IconImagePath_Controller = new TextEditingController();

  String Restaurant_Name;
  DatabaseReference _ref;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _Restaurant_nameController = TextEditingController();
     _Description_Controller = TextEditingController();
     _PhoneNumber_Controller =  TextEditingController();
     _Address_Controller =  TextEditingController();
     _Working_Hours_Controller =  TextEditingController();
     _CoverImagePath_Controller =  TextEditingController();
     _IconImagePath_Controller =  TextEditingController();
     _ref = FirebaseDatabase.instance.reference().child('Restaurants');
     getRestaurantDetails();    
  }
  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Restaurant"),backgroundColor: Colors.transparent,
        elevation: 0,),
      body:Container(
        margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _Restaurant_nameController,
            decoration: InputDecoration(
              hintText: 'Enter Restaurant Name ',
              prefixIcon: Icon(
                Icons.category,size: 30,
              ),
              fillColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsets.all(15),
            ),
          ),
          SizedBox(height: 15),
            TextFormField(
            controller: _Description_Controller,
            decoration: InputDecoration(
              hintText: 'Enter Restaurant Description',
              prefixIcon: Icon(
                Icons.category,size: 30,
              ),
              fillColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsets.all(15),
            ),
          ),
          SizedBox(height: 15),
            TextFormField(
            controller: _Address_Controller,
            decoration: InputDecoration(
              hintText: 'Enter Restaurant Address ',
              prefixIcon: Icon(
                Icons.category,size: 30,
              ),
              fillColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsets.all(15),
            ),
          ),
          SizedBox(height: 15),

          TextFormField(
            controller: _PhoneNumber_Controller,
            decoration: InputDecoration(
              hintText: 'Enter Restaurant Phone Number ',
              prefixIcon: Icon(
                Icons.category,size: 30,
              ),
              fillColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsets.all(15),
            ),
          ),
          SizedBox(height: 15),

          TextFormField(
            controller: _CoverImagePath_Controller,
            decoration: InputDecoration(
              hintText: 'Enter Restaurant Cover Image Path ',
              prefixIcon: Icon(
                Icons.category,size: 30,
              ),
              fillColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsets.all(15),
            ),
          ),
          SizedBox(height: 15),
          TextFormField(
            controller: _IconImagePath_Controller,
            decoration: InputDecoration(
              hintText: 'Enter Restaurant Icon Image Path ',
              prefixIcon: Icon(
                Icons.category,size: 30,
              ),
              fillColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsets.all(15),
            ),
          ),
          SizedBox(height: 15),

           TextFormField(
            controller: _Working_Hours_Controller,
            decoration: InputDecoration(
              hintText: 'Enter Restaurant Working Hours ',
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
              SaveRestaurant();
            },
            child: Text('Update Restaurant', style: TextStyle(
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

  getRestaurantDetails() async{
    DataSnapshot snapshot= await _ref.child(widget.RestaurantKey).once(); 
    Map restaurant = snapshot.value;
    _Restaurant_nameController.text = restaurant['Name'];
    _Description_Controller.text = restaurant['Description'];
    _PhoneNumber_Controller.text= restaurant['PhoneNumber'].toString();
    _Address_Controller.text = restaurant['Address'];
    _CoverImagePath_Controller.text = restaurant['CoverImagePath'];
    _IconImagePath_Controller.text = restaurant['IconImagePath'];
    _Working_Hours_Controller.text = restaurant['WorkingHours'];
    
     }

   void SaveRestaurant(){
      String Restaurant_name = _Restaurant_nameController.text;
      String Description = _Description_Controller.text;
      String Address = _Address_Controller.text;
      var PhoneNumber = _PhoneNumber_Controller.text;
      String CoverImagePath = _CoverImagePath_Controller.text;
      String IconImagePath = _IconImagePath_Controller.text;
      String WorkingHours = _Working_Hours_Controller.text;

      Map<String,String> restaurant = {
        'Name' : Restaurant_name,
        'Description': Description,
        'Address': Address,
        'PhoneNumber': PhoneNumber,
        'CoverImagePath': CoverImagePath,
        'IconImagePath': IconImagePath,
        'WorkingHours': WorkingHours,
      };

      _ref.child(widget.RestaurantKey).update(restaurant).then((value) {
        Navigator.pop(context);

      });

    }
}