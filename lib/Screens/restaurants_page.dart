import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'package:recommendation_flutter_app/Models/restaurant.dart';

class RestaurantsPage  extends StatefulWidget {
  static const routeName ='/Restaurants';

  
  @override
  _RestaurantsPageState createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {
bool _isLooding = true;  

  @override
  void initState() {
    Provider.of<Restaurant>(context,listen: false).Fetch().then((_) => _isLooding = false);
    super.initState();
   
    
  }

  Widget detailCard(Name,Description,Address,PhoneNumber,IconImagePath,CoverImagePath ,WorkingHours,ctx){
    return InkWell(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
          ),
          elevation: 4,
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                  
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.network(CoverImagePath , height: 200, width: double.infinity, fit: BoxFit.cover),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 10,
                      child: Container(
                        width: 300,
                        color: Colors.black45,
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 20,
                          ),
                        child: Text(
                        Name, style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    ),
                      ),
                  ),

                ],
                
              ),
              /*
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  
                  
                  children: [
                    Row(
                      children: [
                        Icon(Icons.schedule),
                        SizedBox(width: 6,),
                        Text("$duration min" , style: TextStyle(color: Colors.black),),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.work),
                        SizedBox(width: 6),
                        Text("$complexityTest" , style: TextStyle(color: Colors.black),),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.attach_money),
                        SizedBox(width: 6),
                        Text("$affordabilityTest" , style: TextStyle(color: Colors.black),),
                      ],
                    ),
                  ],
                ),
              ),
              */
            ],
          ),
      ),
      
    );

  }
  @override
  Widget build(BuildContext context){
    List<Restaurant> restaurantsList = Provider.of<Restaurant>(context, listen: true).restaurantsList;
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        
      ),
      body:_isLooding
      ? Center(child: CircularProgressIndicator())
      :(restaurantsList.isEmpty
      ? Center(
        child:Text('No Restaurants Added',style: TextStyle(fontSize: 22),),
      )
       :RefreshIndicator(
         onRefresh: () async=>await Provider.of<Restaurant>(context,listen: false).Fetch(),
          child: Text('hkj'),
         
       ) 
      )
      
    );
  }
}