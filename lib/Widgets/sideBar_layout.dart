import 'package:flutter/material.dart';
import 'package:recommendation_flutter_app/Screens/add_category.dart';
import 'package:recommendation_flutter_app/Screens/categories.dart';
import 'package:recommendation_flutter_app/Widgets/sideBar.dart';


class SideBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
          child: Stack(
        children: <Widget>[
          Positioned(child: Categories(),),
          Positioned(child:  SideBar(),)
          
         

        ],
        
      ),
    )
    );
  }
}