import 'package:arista/pages/register_page.dart';
import 'package:arista/pages/register_page.dart';
import 'package:flutter/material.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';
import '../components/gradienttext.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_or_register_page.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserIn() async {
    //show loading circle
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text);
    } on FirebaseAuthException catch(e)
    {    //pop the loading circle
      if(e.code=='user-not-found')
        {
          wrongEmailMessage();
        }
      else if (e.code=='wrong-password')
        {
          wrongPasswordMessage();
        }
    }


  }

  //wrong email message popup
  void wrongEmailMessage()
  {
    showDialog(context: context, builder: (context){
      return const AlertDialog(title: Text('Incorrect Email'),shadowColor: Colors.deepPurple,surfaceTintColor: Colors.deepPurple ,);
    });
  }
  void wrongPasswordMessage()
  {
    showDialog(context: context, builder: (context){
      return const AlertDialog(title: Text('Incorrect Password'),shadowColor: Colors.deepPurple,surfaceTintColor: Colors.deepPurple,);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
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
                  'Please sign in to continue',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                    fontSize: 20,
                  ),
                ),
              ),

              const SizedBox(height: 50),

              // username textfield
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
                icon: Icon(Icons.mail),
              ),

              const SizedBox(height: 30),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
                icon: Icon(Icons.lock),
              ),

              const SizedBox(height: 10),

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // sign in button
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 20),
                child: MyButton(bname:"Login",onTap: (){signUserIn();}),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    style: TextButton.styleFrom(primary: Colors.deepPurple),
                    onPressed:
                      widget.onTap,
                    child: Text("Sign up"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
