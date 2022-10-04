// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;


String? currentuseremail;

class loginscreen extends StatefulWidget {
  @override
  _loginscreenState createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   _secureText = false;
  // }
  bool _secureText = true;
  final logemailcontroller = TextEditingController();
  final logpasswordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    // ignore: unused_local_variable
    bool emailaddValidate = false;

    void clearText() {
      logemailcontroller.clear();
      logpasswordcontroller.clear();
    }

  

  
Future <void> LoginOfuser(String  email, password) async{
    var jsonResponse ;
    Map data = {
      
      'email': logemailcontroller.text,
      'password': logpasswordcontroller.text,
      
    };
    print(data);

     String body = json.encode(data);
    var url = 'https://api-001.emberspec.com/api/login';
    var response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
    ).timeout(Duration(seconds: 10));

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 201) {
       jsonResponse = json.decode(response.body.toString());   
         
      Navigator.pushNamed(context, '/homescreen');
      // ignore: avoid_print
      print('success');
    } else {
      print('error');
    }



}
   
    

    // String? validateEmail(String? formEmail) {
    //   if (formEmail == null || formEmail.isEmpty)
    //     return 'E-mail address is required.';

    //   return null;
    // }

    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text('padayon'),
            backgroundColor: Color.fromRGBO(8, 120, 93, 3),
            automaticallyImplyLeading: false,
          ),
          body: Form(
            key: _formKey,
            child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg1.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: logemailcontroller,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'e-mail address is required.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter your email',
                          prefixIcon: Icon(Icons.person),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          //when error has occured
                          // errorStyle: TextStyle(
                          //   color: Colors.white,
                          // ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightGreen)),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextFormField(
                        obscureText: _secureText,
                        style: TextStyle(color: Colors.white),
                        controller: logpasswordcontroller,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'password is required.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _secureText
                                  ? Icons.visibility
                                  // ignore: dead_code
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _secureText = !_secureText;
                              });
                            },
                          ),
                          labelText: 'Enter your password',
                          prefixIcon: Icon(Icons.lock),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightGreen)),
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                          LoginOfuser(logemailcontroller.text , logpasswordcontroller.text);

                        //login function button
                      },
                      color: Colors.black.withOpacity(0.05),
                      textColor: Colors.white,
                      child: Text(
                        "login",
                        // style: GoogleFonts.droidSans(
                        //     fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                        clearText();
                        //   if(acontroller.text == ''){

                        // }else{
                        //     searchedterm = acontroller.text ;
                        //   Navigator.pushNamed(context, '/SearchScreen');
                        //   Navigator.of(context).push(MaterialPageRoute(
                        //         builder: (context) => SearchResultScreen(searchedterm: searchedterm),
                        //     ));
                        //   print("searched book: $searchedterm");
                        // }
                      },
                      color: Colors.black.withOpacity(0.05),
                      textColor: Colors.white,
                      hoverColor: Colors.white,
                      child: Text(
                        "register",
                        // style: GoogleFonts.droidSans(
                        //     fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
             
                  ],
                )),
          ),
        ),
        onWillPop: () async {
          return false;
        });
  }
}
