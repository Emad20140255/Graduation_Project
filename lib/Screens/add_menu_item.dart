import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AddMenuItem extends StatefulWidget {
  String RestaurantKey;
  AddMenuItem({this.RestaurantKey});
  @override
  _AddMenuItemState createState() => _AddMenuItemState();
}
class _AddMenuItemState extends State<AddMenuItem> {
  TextEditingController _Menu_Controller = new TextEditingController();
  TextEditingController _Price_Controller = new TextEditingController();
  
  String Restaurant_Name;
  DatabaseReference _ref;
  List mennu;
  List pricce;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _Menu_Controller = TextEditingController();
     _Price_Controller = TextEditingController();
     _ref = FirebaseDatabase.instance.reference().child('Restaurants');
     getRestaurantDetails();    
  }
  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(" Restaurant Menu"),backgroundColor: Colors.transparent,
        elevation: 0,),
      body:Container(
        margin: EdgeInsets.all(15),
      child: Column(
        children:[ 
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _Menu_Controller,
              decoration: InputDecoration(
                hintText: 'Enter Restaurant Menu Item',
                prefixIcon: Icon(
                  Icons.category,size: 30,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
            ),
            SizedBox(width: 15),
              TextFormField(
              controller: _Price_Controller,
              decoration: InputDecoration(
                hintText: 'Enter Restaurant Item Price',
                prefixIcon: Icon(
                  Icons.category,size: 30,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
            ),
            SizedBox(height: 15),     
          ]),
         
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: RaisedButton(onPressed: (){
              SaveRestaurant();
            },
            child: Text('Update Restaurant Menu', style: TextStyle(
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
    mennu.add(restaurant['Menu']);
    pricce.add(restaurant['Price']);  
  
     }

   void SaveRestaurant(){
      String _Menu = _Menu_Controller.text;
      String _Price_= _Price_Controller.text;
     

      Map<String,String> restaurant = {
        'Menu' : _Menu,
        'Price': _Price_,
      };

      _ref.child(widget.RestaurantKey).update(restaurant).then((value) {
        Navigator.pop(context);

      });

    }
}