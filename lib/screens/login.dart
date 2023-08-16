import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:optimum_music/screens/image_resoponse_screen.dart';
import 'package:optimum_music/screens/splash_screen.dart';
import 'package:optimum_music/services/my_provider.dart';
import 'package:optimum_music/widgets/app_logo.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<MyProvider>(context,listen: false);
    final _size = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: _size.width * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppLogo(
              height: 100,
            ),
            SizedBox(
              height: _size.height * 0.05,
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  minimumSize: Size(double.infinity, 50),
                ),
                icon: FaIcon(
                  FontAwesomeIcons.google,
                  color: Colors.red,
                ),
                label: Text('Sign In With Google'),
                onPressed: () {
                  signInWithGoogle().then((user) async {
                    if (user != null) {
                  
                      final DocumentSnapshot<Map<String, dynamic>>
                          userSnapshot = await FirebaseFirestore.instance
                              .collection('users')
                              // .doc(user.email)
                              .doc(user.uid)
                              .get();

                      if (!userSnapshot.exists) {
                     

                        final userData = {
                          'id':user.uid,
                          'name': user.displayName,
                          'email': user.email,
                          'photoURL': user.photoURL,
                        };

                        await FirebaseFirestore.instance
                            .collection('users')
                            // .doc(user.email)
                             .doc(user.uid)
                            .set(userData);

                        myProvider.user ={
                          'id':user.uid,
                          'name': user.displayName,
                          'email': user.email,
                          'photoURL': user.photoURL,
                        };
                        myProvider.islogin=true;
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SplashScreen()),);
                      }
                      else{
                        myProvider.user =userSnapshot.data()!;
                         myProvider.islogin=true;
                         if(myProvider.user['age']!=null){
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ImageResponseScreen(imageFile: null,)),);
                         }else{
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SplashScreen()),);
                         }
                        
                      }
                    }
                  });
                }),
          ],
        ),
      ),
    ));
  }
}

final GoogleSignIn googleSignIn = GoogleSignIn();

Future<User?> signInWithGoogle() async {
  try {
    // Step 1: Perform the Google sign-in request
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    // Step 2: Obtain the authentication credentials
    final GoogleSignInAuthentication googleSignInAuth =
        await googleSignInAccount!.authentication;

    // Step 3: Create a Firebase credential
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuth.idToken,
      accessToken: googleSignInAuth.accessToken,
    );

    // Step 4: Sign in to Firebase with the credential
    final UserCredential authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // Step 5: Get the user details
    final User? user = authResult.user;

    // Return the signed-in user
    return user;
  } catch (e) {
    // Handle sign-in errors
    print(e);
    return null;
  }
}

