import 'package:flutter/material.dart';
import 'package:optimum_music/main.dart';
import 'package:optimum_music/screens/image_resoponse_screen.dart';
import 'package:optimum_music/screens/splash_screen.dart';
import 'package:optimum_music/services/my_provider.dart';
import 'package:optimum_music/utils/models.dart';
import 'package:provider/provider.dart';

class DemographicScreen extends StatefulWidget {
   DemographicScreen({Key? key,
    // required this.demographic,
    required this.songId,required this.updateid,required this.songList})
      : super(key: key);

  // final Demographic demographic;
  final songId;
  Function updateid;
  List songList;

  @override
  State<DemographicScreen> createState() => _DemographicScreenState();
}

class _DemographicScreenState extends State<DemographicScreen> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _textTheme = Theme.of(context).textTheme;
     final myProvider = Provider.of<MyProvider>(context,listen: false);
    return Scaffold(
      // appBar: PreferredSize(
      //     preferredSize: Size(_size.width, _size.height * 0.1),
      //     child: const Center(child: AppBarWidget())),
      body: Container(
        // padding: EdgeInsets.symmetric(horizontal: _size.width * 0.0),
        alignment: Alignment.center,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: _size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Age',
                          style: _textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: _size.width * 0.035),
                        ),
                        Text(
                          // widget.demographic.age,
                          myProvider.user['age'],
                          style: _textTheme.caption!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: _size.width * 0.05),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.white,
                      height: 30,
                      width: 1,
                    ),
                    Column(
                      children: [
                        Text(
                          'Gender',
                          style: _textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: _size.width * 0.035),
                        ),
                        Text(
                          // widget.demographic.gender,
                           myProvider.user['gender'],
                          style: _textTheme.caption!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: _size.width * 0.05),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.white,
                      height: 30,
                      width: 1,
                    ),
                    Column(
                      children: [
                        Text(
                          'Ethnicity',
                          style: _textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: _size.width * 0.035),
                        ),
                        Text(
                          // widget.demographic.ethnicity,
                           myProvider.user['ethnicity'],
                          style: _textTheme.caption!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: _size.width * 0.05),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: _size.height * 0.03,
                ),
                ElevatedButton(onPressed: (){
                  audioPlayer.stop();
                  // Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => SplashScreen()),
  (route) => false,
);

                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SplashScreen()),);
    //               return Navigator.of(context)
    //     .pushReplacement(MaterialPageRoute(builder: (context) {
    //   return const HomeScreen();
    // }));

                }, child: Text('Re-Identify'),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF0E1C63)),),
                ),
                SizedBox(
                  height: _size.height * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: _size.width * 0.05),
                  child: Column(
                    children: [
                      const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Recommended Songs',
                          )),
                      SizedBox(
                        height: _size.height * 0.025,
                      ),
                      Column(
                        children: [
                          for (int i = 0;
                              i < songList.length;
                              i++)
                              if(songList[i]['name'].toLowerCase().contains(myProvider.serachValue.toLowerCase())  || myProvider.serachValue =="" || songList[i]['singer'].toLowerCase().contains(myProvider.serachValue.toLowerCase()) )
                            GestureDetector(
                              onTap: () {
                                  this.widget.updateid(i,true);
                                setState(() {
                                  songId = i;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(bottom: 15),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/album-placeholder.png',
                                      width: _size.height * 0.085,
                                      height: _size.height * 0.085,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    // Flexible(child: Text(widget.songList[i]['name']))
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      Text(widget.songList[i]['name'],
                                      style: _textTheme.caption!.copyWith(
                              fontWeight: FontWeight.w300,
                              // fontSize: _size.width * 0.045
                              ),
                              textAlign: TextAlign.start),
                                      Text(widget.songList[i]['singer'],
                                      style: _textTheme.caption!.copyWith(
                              fontWeight: FontWeight.w100,
                              fontSize: _size.width * 0.03),
                              // textAlign: TextAlign.start
                              ),
                              
                                      ],
                                    ),
                                    Spacer(),
                                    songId==i && playing==true? Icon(
                      Icons.pause,
                      color: Colors.white,
                      size: 30,
                    ):Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 30,
                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      )
                    ],
                  ),
                ),
                // SizedBox(
                //   height: _size.height * 0.04,
                // ),
                // Align(alignment: Alignment.bottomCenter,
                // child: PlayerHome(),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class PlayerHome extends StatefulWidget {
//   // const PlayerHome({Key? key}) : super(key: key);

//   PlayerHome();

//   @override
//   State<PlayerHome> createState() => _PlayerHomeState();
// }

// class _PlayerHomeState extends State<PlayerHome> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 130,
//       padding: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.black,
//         borderRadius: BorderRadius.only(topRight: Radius.circular(30))
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               CircleAvatar(
//                 backgroundImage: AssetImage('assets/images/album-placeholder.png'),
//                 radius: 30,
//               ),
//               SizedBox(width: 10,),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Bata Nala",style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold
//                   ),),
//                   Text("yohani",style: TextStyle(
//                     color: Colors.white54,
//                   ),),
//                 ],
//               )
//             ],
//           ),
          
//       ]),
//     );
//   }
// }

