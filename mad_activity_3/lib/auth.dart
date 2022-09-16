import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class fireAuth extends StatefulWidget {
  const fireAuth({super.key});

  @override
  State<fireAuth> createState() => _fireAuthState();
}

class _fireAuthState extends State<fireAuth> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Demo"),
      ),
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
                Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              controller: _email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Email',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              controller: _password,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Password',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: SignUp,
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
                    const EdgeInsets.symmetric(horizontal: 5, vertical:5),
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
      scopes: ['email', 'profile'],
      hostedDomain: '',
    ).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  SignUp() async {
    await Firebase.initializeApp();

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      print(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  signIn() async* {
    print("In");
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text, password: _password.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
