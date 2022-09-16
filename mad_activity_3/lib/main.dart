// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plant/landing.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './auth.dart';
import './home.dart';
import 'landing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: landing(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  final userName = TextEditingController();
  final password = TextEditingController();
  final born = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Firebase Demo"),
        ),
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
                Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              controller: userName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Email',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              controller: password,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Password',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: signUp,
            child: const Text('SignUp'),
            style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 11, vertical: 11),
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            onPressed: signIn,
            child: const Text('Login'),
            style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 11, vertical: 11),
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
        ]));
  }

  signUp() {
    print("Up");
  }

  signIn() {
    print("In");
  }

  // addUser() async {
  //   WidgetsFlutterBinding.ensureInitialized();

  //   await Firebase.initializeApp();
  //   // Call the user's CollectionReference to add a new user
  //   var db = FirebaseFirestore.instance;
  //   CollectionReference users = FirebaseFirestore.instance.collection('users');
  //   // Create a new user with a first and last name
  //   return users
  //       .add(
  //           {"first": firstName.text, "last": lastName.text, "born": born.text})
  //       .then((DocumentReference doc) =>
  //           print('DocumentSnapshot added with ID: ${doc.id}'))
  //       .catchError((error) => print("Failed to add user: $error"));
  // }
}
