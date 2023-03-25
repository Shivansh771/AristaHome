import 'package:arista/components/data_add.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/gradienttext.dart';
import 'package:firebase_auth/firebase_auth.dart';
class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});
  final FirebaseAuth auth=FirebaseAuth.instance;
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  // text editing controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNoController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final addressController = TextEditingController();
  final stateController = TextEditingController();
  final pinCodeController = TextEditingController();
  final aadharController = TextEditingController();
  final otpController = TextEditingController();
  final ph1Controller=TextEditingController();
  final ph2Controller=TextEditingController();
  final ph3Controller=TextEditingController();

  void signUserUp() async {
    try {

      //check if password is confirmed
      if (passwordController.text == confirmpasswordController.text) {
        if (firstNameController.text == "" ||
            lastNameController.text == "" ||
            phoneNoController.text == "" ||
            emailController.text == "" ||
            passwordController.text == "" ||
            confirmpasswordController.text == "" ||
            addressController.text == "" ||
            stateController.text == "" ||
            pinCodeController.text == "" ||
            aadharController.text == ""||
            ph1Controller.text == ""||
            ph2Controller.text == ""||
            ph3Controller.text == "") {
          missinginfo();
        } else if (aadharController.text.length != 16) {
          aadharlenerror();
        } else if (phoneNoController.text.length != 10) {
          phonenumberlenerror();
        }
        else if(passwordController.text.length<6)
        {
          passwordlenshort();
        }
        else {
          Map<String,dynamic> data={'Aadhar_Number': aadharController.text,
            'Address': addressController.text,
            'Phone Number':phoneNoController.text,
            'Email': emailController.text,
            'First_Name': firstNameController.text,
            'Last_Name': lastNameController.text,
            'State': stateController.text,
            'PinCode': pinCodeController.text,
            'ph1': ph1Controller.text,
            'ph2': ph2Controller.text,
            'ph3': ph3Controller.text,};
          FirebaseFirestore.instance.collection('users').doc(emailController.text).set(data);

          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
        }
      } else {
        wrongPasswordDontMatch();
      }
    } on FirebaseAuthException catch (e) {
        if(e.code == 'email-already-in-use') {
          emailalreadyexits();
        }
      //pop the loading circle
      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      }
    }
  }

  void emailalreadyexits() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Email Already Exists'),
            shadowColor: Colors.deepPurple,
          );
        });
  }
  void phonenumberlenerror() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Enter a valid Phone Number'),
            shadowColor: Colors.deepPurple,
          );
        });
  }

  void aadharlenerror() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Aadhar Card length is not equal to 16'),
            shadowColor: Colors.deepPurple,
          );
        });
  }

  void passwordlenshort() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Password length is too short(Min:6)'),
            shadowColor: Colors.deepPurple,
          );
        });
  }

  //missing information popup
  void missinginfo() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Please Fill all the Fields'),
            shadowColor: Colors.deepPurple,
          );
        });
  }

  //wrong email message popup
  void wrongPasswordDontMatch() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Password doesn\'t match'),
            shadowColor: Colors.deepPurple,
            surfaceTintColor: Colors.deepPurple,
          );
        });
  }

  void phonenotverified() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Please verify your phone number'),
            shadowColor: Colors.deepPurple,
            surfaceTintColor: Colors.deepPurple,
          );
        });
  }

  void wrongEmailMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Incorrect Email'),
            shadowColor: Colors.deepPurple,
            surfaceTintColor: Colors.deepPurple,
          );
        });
  }

  void wrongPasswordMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Incorrect Password'),
            shadowColor: Colors.deepPurple,
            surfaceTintColor: Colors.deepPurple,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Welcome to',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        fontFamily: 'Arial'),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  alignment: Alignment.topLeft,
                  child: GradientText(
                    'Arista',
                    style: const TextStyle(
                        fontSize: 80, fontWeight: FontWeight.bold),
                    gradient: LinearGradient(colors: [
                      Colors.purpleAccent,
                      Colors.deepPurple,
                    ]),
                  ),
                ),
                const SizedBox(height: 8),
                // welcome back, you've been missed!
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    'Let\'s create an account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                      fontSize: 20,
                    ),
                  ),
                ),

                const SizedBox(height: 50),
                Text(
                  'All fields are Mandatory',
                  style: TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 20),

                // username textfield
                MyTextField(
                  controller: firstNameController,
                  hintText: 'First Name',
                  obscureText: false,
                  icon: Icon(Icons.person),
                ),

                const SizedBox(height: 30),

                // password textfield
                MyTextField(
                  controller: lastNameController,
                  hintText: 'Last Name',
                  obscureText: false, //draw dots where we write password
                  icon: Icon(Icons.person),
                ),
                const SizedBox(height: 30),

                // password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: phoneNoController,
                    obscureText: false,
                    decoration: InputDecoration(
                        icon: Icon(Icons.call),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: "Phone Number",
                        hintStyle: TextStyle(color: Colors.grey[500])),
                  ),
                ),

                const SizedBox(height: 30),

                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                  icon: Icon(Icons.mail),
                ),
                const SizedBox(height: 30),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  icon: Icon(Icons.lock),
                ),
                const SizedBox(height: 30),
                MyTextField(
                  controller: confirmpasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                  icon: Icon(Icons.lock),
                ),
                const SizedBox(height: 30),
                MyTextField(
                  controller: addressController,
                  hintText: 'Address',
                  obscureText: false,
                  icon: Icon(Icons.location_pin),
                ),
                const SizedBox(height: 30),
                MyTextField(
                  controller: stateController,
                  hintText: 'State',
                  obscureText: false,
                  icon: Icon(Icons.location_pin),
                ),
                const SizedBox(height: 30),
                MyTextField(
                  controller: pinCodeController,
                  hintText: 'Pincode',
                  obscureText: false,
                  icon: Icon(Icons.location_pin),
                ),
                const SizedBox(height: 30),
                MyTextField(
                  controller: aadharController,
                  hintText: 'Aadhar Number',
                  obscureText: false,
                  icon: Icon(Icons.person_pin_outlined),
                ),
                const SizedBox(height: 30),
                Text("Emergency Numbers",style: TextStyle(color: Colors.red),),
                SizedBox(height: 10,),
                MyTextField(
                  controller: ph1Controller,
                  hintText: 'phone number 1',
                  obscureText: false,
                  icon: Icon(Icons.call),
                ),
                const SizedBox(height: 30),
                MyTextField(
                  controller: ph2Controller,
                  hintText: 'phone number 2',
                  obscureText: false,
                  icon: Icon(Icons.call),
                ),
                const SizedBox(height: 30),
                MyTextField(
                  controller: ph3Controller,
                  hintText: 'phone number 3',
                  obscureText: false,
                  icon: Icon(Icons.call),
                ),
                const SizedBox(height: 30),

                const SizedBox(height: 25),

                // sign in button
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 20),
                  child: MyButton(
                      bname: "Sign Up",
                      onTap: () {
                        signUserUp();
                      }),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                      style: TextButton.styleFrom(primary: Colors.deepPurple),
                      onPressed: widget.onTap,
                      child: Text("Login now"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}





// Container(
// alignment: Alignment.centerRight,
// padding: EdgeInsets.only(right: 20),
// child: TextButton(
// onPressed: () async {
// otpController.text=="";
// if (phone_no_authenticated == false) {
// await FirebaseAuth.instance.verifyPhoneNumber(
// phoneNumber: '+91${phoneNoController.text}',
// verificationCompleted:
// (PhoneAuthCredential credential) {},
// verificationFailed: (FirebaseAuthException e) {},
// codeSent:
// (String verificationId, int? resendToken) {
// showDialog(
// context: context,
// builder: (BuildContext context) {
// return AlertDialog(
// scrollable: true,
// title: const Text("OTP Verification"),
// content: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Form(
// child: Column(
// children: <Widget>[
// TextField(
// keyboardType: TextInputType.phone,
// controller: otpController,
// decoration: InputDecoration(
// icon: Icon(Icons.lock),
// enabledBorder:
// const OutlineInputBorder(
// borderSide: BorderSide(
// color: Colors.white),
// ),
// focusedBorder: OutlineInputBorder(
// borderSide: BorderSide(
// color:
// Colors.grey.shade400),
// ),
// fillColor: Colors.grey.shade200,
// filled: true,
// hintText: "Enter otp",
// hintStyle: TextStyle(
// color: Colors.grey[500])),
// ),
// ],
// ),
// ),
// ),
// actions: [
// ElevatedButton(
// child: const Text("Verify"),
// onPressed: () async{
// PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
//
// // Sign the user in (or link) with the credential
// // your code
// },
// ),
// ],
// );
// },
// );
// },
// codeAutoRetrievalTimeout:
// (String verificationId) {},
// );
//
// } else {
// showDialog(
// context: context,
// builder: (BuildContext context) {
// return AlertDialog(
// title: Text("Already Verified"),
// shadowColor: Colors.deepPurple,
// );
// });
// }
// },
// child: Text('verify phone number'),
// style: ButtonStyle(
// foregroundColor:
// MaterialStatePropertyAll(Colors.deepPurple)),
// )),