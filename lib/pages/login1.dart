import 'package:flutter/material.dart';
//============================================
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
//============================================
import 'home.dart';
import 'signup1.dart';

//============================================
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  SharedPreferences preferences;
  bool loading = false;
  bool isLogedIn = false;

  @override
  void initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
    isSignedIn();
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

  void isSignedIn() async {
    setState(() {
      loading = true;
    });

    preferences = await SharedPreferences.getInstance();
    isLogedIn = await googleSignIn.isSignedIn();
    if (isLogedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }

    setState(() {
      loading = false;
    });
  }

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();

    setState(() {
      loading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    FirebaseUser firebaseUser =
        (await firebaseAuth.signInWithCredential(credential)).user;

    if (firebaseUser != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection('users')
          .where('id', isEqualTo: firebaseUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
//        insert the user to our collection
        Firestore.instance
            .collection('users')
            .document(firebaseUser.uid)
            .setData({
          "id": firebaseUser.uid,
          "username": firebaseUser.displayName,
          "ptofilePicture": firebaseUser.photoUrl,
        });
        await preferences.setString("id", firebaseUser.uid);
        await preferences.setString("username", firebaseUser.displayName);
        await preferences.setString("photoUrl", firebaseUser.photoUrl);
      } else {
        await preferences.setString("id", documents[0]['id']);
        await preferences.setString("username", documents[0]['username']);
        await preferences.setString("photoUrl", documents[0]['photoUrl']);
      }

      Fluttertoast.showToast(msg: "Login was successful");
      setState(() {
        loading = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Fluttertoast.showToast(msg: "Login failed :(");
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
              color: Colors.black.withOpacity(0.8),
              width: double.infinity,
              height: double.infinity,
            ),
            /*Padding(
              padding: const EdgeInsets.all(.0),
              child: Container(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "images/logo.jpg",
                  width: 280.0,
                  height: 240.0,
                ),
              ),
            ),*/
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 100.0, bottom: 10.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: Container(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 100.0,
                        backgroundImage: AssetImage(
                          "images/logo.jpg",
                        ),
                      ),
                    ),

                    /*Image.asset(
                      "images/logo.jpg",
                      width: 200.0,
                      height: 200.0,
                    ),*/
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
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Center(
                      child: Form(
                        key: _formKey,
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
                                    controller: emailInputController,
                                    decoration: InputDecoration(
                                      labelText: 'Email*',
                                      icon: Icon(Icons.alternate_email),
                                      hintText: "john.doe@gmail.com",
                                      border: InputBorder.none,
                                    ),
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
                                    controller: pwdInputController,
                                    decoration: InputDecoration(
                                        labelText: 'Password*',
                                        icon: Icon(Icons.lock),
                                        border: InputBorder.none,
                                        hintText: "********"),
                                    obscureText: true,
                                    validator: pwdValidator,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.blue.shade700,
                                  elevation: 0.0,
                                  child: MaterialButton(
                                    onPressed: () {},
                                    minWidth: MediaQuery.of(context).size.width,
                                    child: Text(
                                      "login",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Forget Password",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            /*RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0),
                                  children: [
                                    TextSpan(
                                        text:
                                            "Don\'t have an account? click here to "),
                                    TextSpan(
                                      text: "sign up!",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ]),
                            ),*/
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {},
                                child: Text(
                                  "Sign up!",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                            Text(
                              "Don't have an account yet?",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                            FlatButton(
                              child: Text(
                                "Register here!",
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()),
                                );
                              },
                            ),
                            /*Divider(
                              color: Colors.teal.shade100,
                            ),*/
                            /*                      Text(
                              "Other Login\'s Options",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            // google sign in
                             Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.orange,
                              elevation: 0.0,
                              child: MaterialButton(
                                onPressed: () {
                                  handleSignIn();
                                },
                                minWidth: MediaQuery.of(context).size.width,
                                child: Text(
                                  " google",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),*/
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: loading ?? true,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white.withOpacity(0.9),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                ),
              ),
            )
          ],
        ),
//        google sign in and sgn up
        /*bottomNavigationBar: Container(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 12.0, right: 12.0, top: 8.0, bottom: 8.0),
            child: FlatButton(
              color: Colors.red.shade900,
              onPressed: () {
                handleSignIn();
              },
              child: Text(
                'Signin/Sign up with google',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),*/
      ),
    );
  }
}
