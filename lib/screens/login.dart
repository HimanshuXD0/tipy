import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tipy/screens/homepage.dart';

import '../auth/result.dart';


class LoginPageNew extends StatefulWidget {
  const LoginPageNew({super.key});

  @override
  _LoginPageNewState createState() => _LoginPageNewState();
}

class _LoginPageNewState extends State<LoginPageNew> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final authService _apiService = authService();



  bool isLoading = false;
  bool _obscureText = true;



 void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final user = await _apiService.loginResponse(
        _nameController.text,
        _passwordController.text,
      );
      if (user.statusCode == 200) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => homepage()));
      }
    }
  }  


  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            height: 200,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 51,
                  width: double.infinity,
                  color: Colors.red.shade700,
                  child: Center(
                    child: Text(
                      "Digital Praveshotsav",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Text(
                    message,
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ),
                SizedBox(
                  height: 44,
                ),
                Container(
                  height: 37,
                  width: 135,
                  decoration: BoxDecoration(
                      color: Colors.red.shade700,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'ठीक है',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _validateAndLogin() async {
    // Perform username and password validation
    if (_nameController.text.isEmpty || _passwordController.text.isEmpty) {
      _showErrorDialog('कृपया उपयोगकर्ता नाम और पासवर्ड दर्ज करें');
    } else {
      _login();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/hh.jpg'),
          fit: BoxFit.fitHeight,
        )),
        //margin: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 105),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Image(
                  image: const AssetImage("assets/images/logo.png"),
                  height: 150,
                  width: 150,
                ),
              ),
              SizedBox(height: 30.0),
              element("उपयोगकर्ता नाम", Icons.person, _nameController, false),
              SizedBox(height: 16.0),
              element("पासवर्ड", Icons.lock, _passwordController, _obscureText),
              SizedBox(height: 5.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 50,
                  ),
                  Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                        value: !_obscureText,
                        checkColor: Colors.white54,
                        onChanged: (val) {
                          setState(() {
                            _obscureText = !val!;
                          });
                        },
                        fillColor:
                            MaterialStateProperty.all(Colors.red.shade700)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      "पासवर्ड दिखायें?",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              Container(
                height: 40,
                margin: EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                  onPressed: _validateAndLogin,
                  child: Center(
                    child: Text(
                      'लॉग इन',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Version 1.0",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget element(String s, IconData iconData, TextEditingController control,
      bool obscureText) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child: Center(
                child: Icon(
              iconData,
              color: const Color.fromARGB(255, 60, 61, 60),
            )),
          ),
          Expanded(
              child: TextFormField(
                onTap: () async {
                  },
            obscureText: obscureText,
            keyboardType: TextInputType.number,
            controller: control,
            style: const TextStyle(color: Colors.black54),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: s,
              contentPadding: EdgeInsets.only(left: 13),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1)),
              hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              border: const OutlineInputBorder(),
            ),
          )),
        ],
      ),
    );
  }
}
