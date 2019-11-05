import 'package:booking_app/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController firstNameInputController;
  TextEditingController lastNameInputController;
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  TextEditingController confirmPwdInputController;

  @override
  initState() {
    firstNameInputController = new TextEditingController();
    lastNameInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    confirmPwdInputController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Stack(
            children: <Widget>[
              Image.asset(
                'images/back.jpeg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Container(
                color: Colors.black.withOpacity(0.5),
                width: double.infinity,
                height: double.infinity,
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child: Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "images/logo.jpg",
                        width: 200.0,
                        height: 200.0,
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      height: 10.0,
                      width: 105.0,
                      child: Divider(
                        color: Colors.teal.shade100,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _registerFormKey,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white.withOpacity(0.4),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'First Name*',
                                        border: InputBorder.none,
                                        hintText: "John"),
                                    controller: firstNameInputController,
                                    validator: (value) {
                                      if (value.length < 3) {
                                        return "Please enter a valid first name.";
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white.withOpacity(0.4),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: TextFormField(
                                      decoration: InputDecoration(
                                          labelText: 'Last Name*',
                                          border: InputBorder.none,
                                          hintText: "Doe"),
                                      controller: lastNameInputController,
                                      validator: (value) {
                                        if (value.length < 3) {
                                          return "Please enter a valid last name.";
                                        }
                                      }),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white.withOpacity(0.4),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Email*',
                                        border: InputBorder.none,
                                        hintText: "john.doe@gmail.com"),
                                    controller: emailInputController,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: emailValidator,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white.withOpacity(0.4),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Password*',
                                        border: InputBorder.none,
                                        hintText: "********"),
                                    controller: pwdInputController,
                                    obscureText: true,
                                    validator: pwdValidator,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white.withOpacity(0.4),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Confirm Password*',
                                        border: InputBorder.none,
                                        hintText: "********"),
                                    controller: confirmPwdInputController,
                                    obscureText: true,
                                    validator: pwdValidator,
                                  ),
                                ),
                              ),
                            ),
                            RaisedButton(
                              child: Text("Register"),
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              onPressed: () async {
                                if (_registerFormKey.currentState.validate()) {
                                  if (pwdInputController.text ==
                                      confirmPwdInputController.text) {
                                    FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: emailInputController.text,
                                            password: pwdInputController.text)
                                        .then((currentUser) => Firestore
                                                .instance
                                                .collection("users")
                                                .document(currentUser.user.uid)
                                                .setData({
                                              "uid": currentUser.user.uid,
                                              "fname":
                                                  firstNameInputController.text,
                                              "surname":
                                                  lastNameInputController.text,
                                              "email":
                                                  emailInputController.text,
                                            }))
                                        .catchError((err) => print(err));

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()));
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Error"),
                                            content: Text(
                                                "The passwords do not match"),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text("Close"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          );
                                        });
                                  }
                                }
                              },
                            ),
                            Text(
                              "Already have an account?",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                            FlatButton(
                              child: Text("Login here!",
                                  style: TextStyle(color: Colors.red)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
