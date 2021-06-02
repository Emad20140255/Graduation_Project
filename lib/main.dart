import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recommendation_flutter_app/Screens/add_category.dart';
import 'package:recommendation_flutter_app/Models/auth.dart';
import 'package:recommendation_flutter_app/Screens/add_restaurant.dart';
import 'package:recommendation_flutter_app/Screens/categories.dart';
import 'package:recommendation_flutter_app/Screens/login.dart';
import 'package:recommendation_flutter_app/Screens/register.dart';
import 'package:recommendation_flutter_app/Screens/restaurants_page.dart';
import 'package:recommendation_flutter_app/Widgets/sideBar_layout.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Authentication(),),
        
      ],
          child: MaterialApp(
        debugShowCheckedModeBanner: false, 
        theme: ThemeData(
       
          primarySwatch: Colors.lightBlue,
          accentColor: Colors.lightBlueAccent,
        ),
        home: LoginPage(),
        routes: {
          AddCategory.routeName: (ctx) => AddCategory(),
          Categories.routeName: (ctx) => Categories(),
          RegisterPage.routeName:(ctx) => RegisterPage(),
          LoginPage.routeName:(ctx) => LoginPage(),
          AddRestaurant.routeName:(ctx) => AddRestaurant(),
          RestaurantsPage.routeName:(ctx) =>RestaurantsPage(),
        },
        
        
      ),
    );
  }
}

