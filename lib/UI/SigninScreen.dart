import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitjung/UI/SignupScreen.dart';
import 'package:flutter/material.dart';
import './HomeScreen.dart';

class SigninScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SigninScreenState();
  }
}

class SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
        // padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // Icon()crossAxisAlignment: CrossAxisAlignment.center,
              Image.asset(
                "resource/cat_eating.jpg",
                height: 200,
              ),
              TextFormField(
                controller: email,
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Email is required";
                  }
                },
              ),
              TextFormField(
                obscureText: true,
                controller: password,
                decoration: InputDecoration(labelText: "Password"),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Password is required";
                  }
                },
              ),
              ButtonTheme(
                minWidth: 300,
                child: RaisedButton(
                    color: Colors.grey.shade300,
                    child: Text("LOGIN"),
                    onPressed: () {
                      auth.signInWithEmailAndPassword(email: email.text, password: password.text).then((user){
                        if(user.isEmailVerified){
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                        }
                        else{
                          showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: Text("ERROR"),
                                content: Text("Please verify your email first"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Close"),
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            }
                          );
                        }
                      });
                    }),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: ButtonTheme(
                  padding: EdgeInsets.all(0),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Text(
                        "Register New Account",
                      ),
                    ),
                    textColor: Colors.teal.shade500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
