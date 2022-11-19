import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_arc/core/models/userobj.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider_arc/ui/views/chat/all_users_screen.dart';
import 'package:provider_arc/ui/views/chat/models/user_details.dart';

class LoginGoogleView extends StatefulWidget {
  _LoginGoogleViewState createState() => _LoginGoogleViewState();
}

class _LoginGoogleViewState extends State<LoginGoogleView> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //final GoogleSignIn _googleSignIn = GoogleSignIn();
  DocumentReference _documentReference;
  UserDetails _userDetails = UserDetails();
  var mapData = Map<String, String>();
  String uid;

  /*Future<FirebaseUser> signIn() async {
    GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _signInAuthentication =
        await _signInAccount.authentication;

    AuthCredential authCredential = GoogleAuthProvider.getCredential(
        idToken: _signInAuthentication.idToken,
        accessToken: _signInAuthentication.accessToken);
    final FirebaseUser user = (await _firebaseAuth.signInWithCredential(authCredential)).user;
    print("signed in " + user.displayName);

    return user;
  }*/

  void addDataToDb(UserObj user) {
    _userDetails.name = user.name;
    _userDetails.emailId = user.email;
    _userDetails.photoUrl = user.profile;
    _userDetails.uid = user.idcustomer.toString();
    mapData = _userDetails.toMap(_userDetails);

    uid = user.idcustomer.toString();

    _documentReference = Firestore.instance.collection("users").document(uid);

    _documentReference.get().then((documentSnapshot) {
      if (documentSnapshot.exists) {
        Navigator.pushReplacement(context,
            new MaterialPageRoute(builder: (context) => AllUsersScreen()));
      } else {
        _documentReference.setData(mapData).whenComplete(() {
          print("Users Colelction added to Database");
          Navigator.pushReplacement(context,
              new MaterialPageRoute(builder: (context) => AllUsersScreen()));
        }).catchError((e) {
          print("Error adding collection to Database $e");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ChatApp'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to Chat App',
              style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
            ),
            RaisedButton(
              elevation: 8.0,
              padding: EdgeInsets.all(8.0),
              shape: StadiumBorder(),
              textColor: Colors.black,
              color: Colors.lime,
              child: Text('Sign In'),
              splashColor: Colors.red,
              onPressed: () {
               /* signIn().then((FirebaseUser user) {
                  addDataToDb(user);
                });*/
                //UserObj userObj = Provider.of<UserObj>(context, listen: false);
                UserObj userObj = UserObj();
                userObj.name="Duytb";
                addDataToDb(userObj);
              },
            )
          ],
        ),
      ),
    );
  }
}
