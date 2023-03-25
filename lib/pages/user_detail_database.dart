import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_textfield.dart';

class UserDetailDatabase extends StatelessWidget {
  final String Aadhar_Number;
  final String Address;
  final String Email;
  final String First_Name;
  final String Last_Name;
  final String Phone_Number;
  final String Pincode;
  final String State;
  final String Password;

   UserDetailDatabase(
      {Key? key,
      required this.Aadhar_Number,
      required this.Address,
      required this.Email,
      required this.First_Name,
      required this.Last_Name,
      required this.Phone_Number,
      required this.State,
      required this.Pincode,
      required this.Password});
final ph1=TextEditingController();
  final ph2=TextEditingController();
  final ph3=TextEditingController();

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Row(children: <Widget>[
              MyTextField(
                controller: ph1,
                hintText: 'phone number 1',
                obscureText: false,
                icon: Icon(Icons.call),
              ),
              const SizedBox(height: 30),

              MyTextField(
                controller: ph2,
                hintText: 'phone number 2',
                obscureText: false,
                icon: Icon(Icons.call),
              ),

              const SizedBox(height: 30),

              MyTextField(
                controller: ph3,
                hintText: 'phone number 3',
                obscureText: false,
                icon: Icon(Icons.call),
              ),

              ElevatedButton(onPressed: ()async {
                final docUser = FirebaseFirestore.instance.collection('users').doc(Email);
                final json = {
                  'Aadhar_Number': Aadhar_Number,
                  'Address': Address,
                  'Email': Email,
                  'First_Name': First_Name,
                  'Last_Name': Last_Name,
                  'State': State,
                  'PinCode': Pincode,
                  'ph1': ph1,
                  'ph2': ph2,
                  'ph3': ph3,
                };
                await docUser.set(json);
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: Email, password: Password);
              }, child: Text('add numbers'))

               ,SizedBox(height: 30),


            ],),
          ),
        ),
      ),
    );
  }
}
