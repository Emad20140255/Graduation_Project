import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class EditCinema extends StatefulWidget {
  String CinemaKey;
  EditCinema({this.CinemaKey});
  @override
  _EditCinemaState createState() => _EditCinemaState();
}

class _EditCinemaState extends State<EditCinema> {
  TextEditingController _name_English_Controller = new TextEditingController();
  TextEditingController _name_Arabic_Controller = new TextEditingController();
  TextEditingController _area_Controller = new TextEditingController();
  TextEditingController _phone_Controller = new TextEditingController();
  TextEditingController _address_Controller = new TextEditingController();
  TextEditingController _governorate_Controller = new TextEditingController();
  TextEditingController _image_link_Controller = new TextEditingController();
  TextEditingController _location_Controller = new TextEditingController();

  String Cinema_Name;
  DatabaseReference _ref;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _name_English_Controller = TextEditingController();
     _name_Arabic_Controller = TextEditingController();
     _area_Controller =  TextEditingController();
     _phone_Controller =  TextEditingController();
     _address_Controller =  TextEditingController();
     _governorate_Controller =  TextEditingController();
     _image_link_Controller =  TextEditingController();
     _location_Controller =  TextEditingController();

     _ref = FirebaseDatabase.instance.reference().child('All_Cinemas').child('Cinemas');
     getCinemaDetails();    
  }
  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Cinema"),backgroundColor: Colors.transparent,
        elevation: 0,),
      body:SingleChildScrollView(
              child: Container(
          margin: EdgeInsets.all(15),
          height: 800,
          width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _name_English_Controller,
              decoration: InputDecoration(
                hintText: 'Enter Cinema English Name ',
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
              controller: _name_Arabic_Controller,
              decoration: InputDecoration(
                hintText: 'Enter Cinema Arabic Name ',
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
              controller: _area_Controller,
              decoration: InputDecoration(
                hintText: 'Enter Cinema Area',
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
              controller: _phone_Controller,
              decoration: InputDecoration(
                hintText: 'Enter Cinema Phone Number ',
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
              controller: _address_Controller,
              decoration: InputDecoration(
                hintText: 'Enter Cinema Address ',
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
              controller: _governorate_Controller,
              decoration: InputDecoration(
                hintText: 'Enter Cinema Governorate',
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
              controller: _image_link_Controller,
              decoration: InputDecoration(
                hintText: 'Enter Cinema Image Path ',
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
              controller: _location_Controller,
              decoration: InputDecoration(
                hintText: 'Enter Cinema Location ',
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
              child: Text('Update Cinema', style: TextStyle(
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
    
    );

    
  }

  getCinemaDetails() async{
    DataSnapshot snapshot= await _ref.child(widget.CinemaKey).once(); 
    Map cinema = snapshot.value;

     _name_English_Controller.text = cinema['name_English'];
     _name_Arabic_Controller.text = cinema['name_Arabic'];
     _area_Controller.text =  cinema['area'];
     _phone_Controller.text=  cinema['phone'];
     _address_Controller.text =  cinema['address'];
     _governorate_Controller.text = cinema['governorate'];
     _image_link_Controller.text =  cinema['image_link'];
     _location_Controller.text =  cinema['location'];
    
     }

   void SaveRestaurant(){
      String name_English = _name_English_Controller.text;
      String name_Arabic = _name_Arabic_Controller.text;
      String area = _area_Controller.text;
      String phone = _phone_Controller.text;
      String address = _address_Controller.text;
      String governorate = _governorate_Controller.text;
      String image_link = _image_link_Controller.text;
      String location = _location_Controller.text;

      Map<String,String> restaurant = {
        'name_English' : name_English,
        'name_Arabic': name_Arabic,
        'area': area,
        'phone': phone,
        'address': address,
        'governorate': governorate,
        'image_link': image_link,
        'location' : location,
      };

      _ref.child(widget.CinemaKey).update(restaurant).then((value) {
        Navigator.pop(context);

      });

    }
}