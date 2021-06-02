import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recommendation_flutter_app/Screens/add_category.dart';
import 'package:recommendation_flutter_app/Screens/categories.dart';
import 'package:recommendation_flutter_app/Screens/register.dart';
import 'package:recommendation_flutter_app/Widgets/sideBar.dart';
import '../Models/auth.dart';

class  LoginPage extends StatefulWidget {
    static const routeName ='/Login';


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var bl = Colors.blue;

  var b = Colors.black;

  bool passvisivble =  true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>() ;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  String _email , _password;

  Map<String,String> _authData = {
   // 'username' : '',
    'email' : '',
    'password ' : '',
  };

  void  _showErrorDialog(String msg){
    showDialog(context: context, builder: (ctx) =>AlertDialog(
      title: Text('An Error Occured'),
      content: Text(msg),
      actions:<Widget> [
        FlatButton(onPressed: (){
          Navigator.of(ctx).pop();
        }, child: Text('Okay'))
      ],
    ));
  }

  Future<void> submit() async{
    if(!_formKey.currentState.validate()){
      return;
    }
    _formKey.currentState.save();

    try{
       await Provider.of<Authentication>(context,listen: false).login(
     //_authData['userame'],
      _authData['email'],
       _authData['password']
       );
              Navigator.of(context).pushReplacementNamed(Categories.routeName);


    }catch(error){
      var errorMessage = ' Authentication Failed. Please try again later.';
      _showErrorDialog(errorMessage);

    }

  
  }
  final _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        
      ),
      body:Container(
              height: double.infinity,  
              child:SingleChildScrollView(         
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
            children: <Widget>[
                  SizedBox(height:100),
                  Text(
                    " Welcome",
                    style: TextStyle(color: b,fontSize: 30,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 25),
                  /*
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 50, 20, 5),
                    child: 
                      TextFormField(
                        controller: _nameController,
                        validator: (value){
                          if (value.isEmpty){
                            return 'name cannot e empty';
                          }else
                          return null;
                        },
                        
                        onSaved: (value){
                          _authData['username'] = value;
                        },
                        
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black38,width: 1.5),
                            borderRadius: BorderRadius.circular(10)
                             ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "User Name",
                          labelStyle: TextStyle(fontSize: 20),
                          hintText: "Enter Your Name",
                          hintStyle: TextStyle(fontSize: 15),
                          prefixIcon: Icon(Icons.person),
                          contentPadding: EdgeInsets.all(15),
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                      ),
                  ),*/
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: 
                       TextFormField(
                         controller: _emailController,
                        validator: (value){
                          if (value.isEmpty || !value.contains('@')){
                            return 'Invalid Email';
                          }else
                          return null;
                        },
                        onSaved: (value){
                          _authData['email'] = value;
                        },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black38,width: 1.5),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),   
                            labelText: "Email",
                            labelStyle: TextStyle(fontSize: 20),
                            hintText: "Enter Your Email",
                            hintStyle: TextStyle(fontSize: 15),
                            prefixIcon: Icon(Icons.email),
                            contentPadding: EdgeInsets.all(15),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: 
                      TextFormField(
                        controller: _passwordController,
                        validator: (value){
                          if (value.isEmpty){
                            return 'Password cannot e empty';
                          }else if (value.length<8) {
                            return 'Invalid Password ';
                            
                          } else {
                            return null;
                          }
                        }
                          ,
                          onSaved: (value){
                          _authData['password'] = value;
                        },
                         
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black38,width: 1.5),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Passowrd",
                          labelStyle: TextStyle(fontSize: 20),
                          hintText: "Enter Your Passowrd",
                          hintStyle: TextStyle(fontSize: 15),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              passvisivble?Icons.visibility_off:Icons.visibility
                            ),
                            onPressed: (){
                              setState(() {
                                passvisivble = !passvisivble;
                              });
                            },
                          ),
                          contentPadding: EdgeInsets.all(15),
                        ),
                        obscureText: passvisivble,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                    ),
                  ),
                  SizedBox(height: 25),
                   FlatButton(
                    onPressed: (){
                      submit();
                    },
                    child:
                     Text
                     ("Log In",
                     style:
                    TextStyle(
                      color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),
                    ),
                    color: b,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      ),
                    padding: EdgeInsets.fromLTRB(115, 5, 115, 5),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Need an account?",
                      ),
                      GestureDetector(
                      
                        child:Text(
                        "Sign Up",
                        style: TextStyle(fontWeight: FontWeight.bold,color: b),
                      ),
                       onTap: (){
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                           return RegisterPage();
                        
                        }
                           ));
                      }
                      ),
                      SizedBox(height: 20),
                    ]
                  )
            ],
          ),
                ),
              ),
        ),
     ),
    );
  }
}

