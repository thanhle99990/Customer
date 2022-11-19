import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:provider/provider.dart';
import 'package:provider_arc/core/models/userobj.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/shared/text_styles.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider_arc/ui/views/chat/chat_screen.dart';
import 'package:provider_arc/ui/widgets/dummy.dart';

class AllUsersScreen extends KFDrawerContent{
  _AllUsersScreenState createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  //final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  StreamSubscription<QuerySnapshot> _subscription;
  List<DocumentSnapshot> usersList;
  final CollectionReference _collectionReference =
      Firestore.instance.collection("users");
  UserObj userObj;

  @override
  void initState() {
    super.initState();
    _subscription = _collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        usersList = datasnapshot.documents;
        print("Users List ${usersList.length}");
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    userObj = Provider.of<UserObj>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text("All Users", style: TitleStyle,),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back,
              color: Dark,
            ),
            onPressed: widget.onMenuPressed,
          ),
        ),
        body: usersList != null
            ? Container(
                child: ListView.builder(
                  itemCount: usersList.length,
                  itemBuilder: ((context, index) {
                    return userObj.idcustomer.toString() == usersList[index].data['uid']
                        ? Dummy()
                        : ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(usersList[index].data['photoUrl']),
                      ),
                      title: Text(usersList[index].data['name'],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )),
                      subtitle: Text(usersList[index].data['phone'],
                          style: TextStyle(
                            color: Colors.grey,
                          )),
                      onTap: (() {
                        UserObj item = UserObj();
                        item.idcustomer =  int.parse(usersList[index].data['uid']);
                        item.name =  usersList[index].data['name'];
                        item.profile =  usersList[index].data['photoUrl'];
                        item.phone =  usersList[index].data['phone'];
                        item.token =  usersList[index].data['token'];
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => ChatScreen(userObj: item,)));
                      }),
                    );
                  }),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
