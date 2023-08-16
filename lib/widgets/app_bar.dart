import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:optimum_music/main.dart';
import 'package:optimum_music/screens/image_resoponse_screen.dart';
import 'package:optimum_music/screens/login.dart';
import 'package:optimum_music/services/my_provider.dart';
import 'package:optimum_music/widgets/app_logo.dart';
import 'package:provider/provider.dart';

TextEditingController searchController = TextEditingController();

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final myProvider = Provider.of<MyProvider>(context, listen: false);
    return Container(
      color: HexColor('0a1227'),
      child: Padding(
        padding: EdgeInsets.only(top: _size.height * 0.06),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _size.width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // InkWell(
              //     onTap: () {
              //       Navigator.pop(context);
              //     },
              //     child: Icon(Icons.arrow_back_ios)),
              AppLogo(
                height: _size.height * 0.09,
              ),
              // SizedBox(),
              Expanded(
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.white),
                    suffixIcon: Icon(Icons.search,color: Colors.white,),
                 
                  ),
                  onChanged: (value) {
                    myProvider.serachValue =value;
                  },
                ),
              ),
              // GestureDetector(
              //   onTap: () {
              //     // Handle search icon tapped
              //     // Perform search operation or any other desired action
              //     print('Search icon tapped');
              //   },
              //   child: Icon(Icons.search),
              // ),
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  audioPlayer.stop();
                  signOutGoogle();
                  myProvider.islogin = false;
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) => false,
                  );
                  //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()),);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final GoogleSignIn googleSignIn = GoogleSignIn();

void signOutGoogle() async {
  await googleSignIn.signOut();
  print("User signed out");
}
