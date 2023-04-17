
import 'package:flutter/material.dart';


const textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w300),
  fillColor: Color.fromARGB(255, 249, 244, 244), filled: true,
  border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
  enabledBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
  focusedBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
  errorBorder: 
      OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
  //floatingLabelBehavior: FloatingLabelBehavior.always,
);


