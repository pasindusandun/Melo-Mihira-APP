import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:just_audio/just_audio.dart';
import 'package:optimum_music/screens/demographic_screen.dart';
import 'package:optimum_music/services/dio_service.dart';
import 'package:optimum_music/services/my_provider.dart';
import 'package:optimum_music/utils/models.dart';
import 'package:optimum_music/utils/song.dart';
import 'package:optimum_music/widgets/app_bar.dart';
import 'package:optimum_music/widgets/image_response_loading_widget.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:just_audio/just_audio.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';

enum LoadingState { Loading, NotLoading }

List songList = [];
// List AllsongList = [];
// String id='';
// Map<String,Song> songMap={};

class ImageResponseScreen extends StatefulWidget {
  const ImageResponseScreen({
    Key? key,
    required this.imageFile,
  }) : super(key: key);
  final XFile? imageFile;

  @override
  State<ImageResponseScreen> createState() => _ImageResponseScreenState();
}

class _ImageResponseScreenState extends State<ImageResponseScreen>
    with SingleTickerProviderStateMixin {
  // late  AudioPlayer audioPlayer ;
  late PageController _tabController;
  LoadingState _lodingState = LoadingState.Loading;

  int _selectedIndex = 0;

  late Demographic _demographic;

  @override
  void initState() {
    _init();
  songList = [];
  // AllsongList = [];
    _tabController = PageController(
      initialPage: 0,
    );
    // audioPlayer= AudioPlayer();
    super.initState();
  }
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   audioPlayer.dispose();
  //   super.dispose();
  // }
  

  void _init() async {
    await Future.delayed(const Duration(seconds: 3));
    // final myProvider = Provider.of<MyProvider>(navigatorKey.currentContext!, listen: false);
    final myProvider = Provider.of<MyProvider>(context, listen: false);

    // if (widget.imageFile != null) {
    //   try {
    //     playing = false;
    //     songId = -1;
    //     currentSlider = 0;
    //     songList = [];
    //     // final resDemo = await DioService()
    //     //     .sendRequest(widget.imageFile!.path, 'demographicsImage');

    //     // _demographic = Demographic.fromJson(resDemo);
    //     print('myProvider1');
    //     _demographic = await APICall().demographic(); //add min pasindu
    //     myProvider.user['ethnicity'] = _demographic.ethnicity;
    //     myProvider.user['gender'] = _demographic.gender;
    //     myProvider.user['age'] = _demographic.age;
    //     print('myProvider');
    //     print(myProvider);

    //     await FirebaseFirestore.instance
    //         .collection('users')
    //         // .doc(myProvider.user['email'])
    //          .doc(myProvider.user['id'])
    //         .set(myProvider.user);
    //     // Map<String,Song> songMap={};
    //     print('add ML details to firestore');
    //     FirebaseFirestore.instance
    //         .collection('demographic/Male/30')
    //         .get()
    //         .then((QuerySnapshot querySnapshot) {
    //       querySnapshot.docs.forEach((doc) {
    //         // songMap[doc.id] = Song.fromJson(doc.data());
    //         songList.add(doc.data());
    //         setState(() {});
    //         // id = doc.id;
    //         // print('doc.id');
    //         // print(doc.id);
    //       });
    //     });
    //     // print('_demographic');
    //     // print(_demographic);

    //     //   final songRef = FirebaseFirestore.instance.collection('movies').withConverter<Song>(
    //     //   fromFirestore: (snapshot, _) => Song.fromJson(snapshot.data()!),
    //     //   toFirestore: (Song, _) => Song.toJson(),
    //     // );

    //     // final Stream users =FirebaseFirestore.instance.collection('demographic').doc('Male/20').snapshots();
    //     //     FirebaseFirestore.instance
    //     // .collection('demographic')
    //     // .doc('Male/20')
    //     // .get()
    //     // .then((DocumentSnapshot documentSnapshot) {
    //     //   if (documentSnapshot.exists) {
    //     //     // print('Document exists on the database');
    //     //     print(documentSnapshot);
    //     //   }
    //     // });
    //   } catch (e) {
    //     print('Error Occured while demographic req: $e');
    //   }

    //   // try {
    //   //   // final resEmo = await DioService()
    //   //   //     .sendRequest(widget.imageFile!.path, 'emotionImage');

    //   //   // _emotion = Emotion.fromJson(resEmo);
    //   //   _emotion = await APICall().emotion();//add min pasindu
    //   // } catch (e) {
    //   //   print('Error Occured while emotion req: $e');
    //   // }

    //   // await DioService().sendRequest(widget.imageFile!.path, 'emotionImage');
    //   setState(() {
    //     _lodingState = LoadingState.NotLoading;
    //   });
    // } else if (myProvider.user['age'] != null) {
      try {
      playing = false;
      songId = -1;
      currentSlider = 0;
      songList = [];

      // _demographic ={
      //   "age": myProvider.user['age'],
      //   "ethnicity": myProvider.user['ethnicity'],
      //   "gender": myProvider.user['gender']
      // } as Demographic;

      int age = int.parse(myProvider.user['age']); 
      
      int roundedUp=0;
      int roundedDown = (age ~/ 10) * 10;
      if(roundedDown==30|| roundedDown==40){
        roundedDown=30;
        roundedUp = 50;
      }
      else if(roundedDown>=50){
       roundedDown=50;
       roundedUp=100;
      }
      else{
        roundedUp = roundedDown +10;
      }
      
      print('roundedDown ${roundedDown}');
      print('roundedDown ${roundedUp}');

      FirebaseFirestore.instance
          .collection('demographic/${myProvider.user['gender']}/${roundedDown}-${roundedUp}')
          // .collection('demographic/male/30')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          // songMap[doc.id] = Song.fromJson(doc.data());
          songList.add(doc.data());
          // AllsongList.add(doc.data());
          setState(() {});
          print('end of not image');
          // id = doc.id;
          // print('doc.id');
          // print(doc.id);
        });
      });
      }
      catch (e) {
        print('Error Occured while demographic req: $e');
      }

      setState(() {
        _lodingState = LoadingState.NotLoading;
      });
    // }
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _textTheme = Theme.of(context).textTheme;
    //     audioPlayer.onDurationChanged.listen((Duration d) {
    //   print('Max duration: $d');
    //   setState(() => currentSlider = d as double);
    // });
    final myProvider = Provider.of<MyProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        //  await audioPlayer.dispose();
        audioPlayer.stop();
        setState(() {
          playing = false;
          songId = -1;
          currentSlider = 0;
          songList = [];
        });
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(_size.width, _size.height * 0.1),
            child: const Center(child: AppBarWidget())),
        body: _lodingState == LoadingState.Loading
            ? const ImageResponseLoadingWidget()
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: _size.width * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: _size.height * 0.01,
                    ),
                    Text(
                      'Playlist',
                      style: _textTheme.headline1
                          ?.copyWith(fontSize: _size.height * 0.04),
                    ),
                    SizedBox(height: _size.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(30),
                              onTap: () {
                                _selectedIndex = 0;
                                setState(() {});
                                _tabController.animateToPage(_selectedIndex,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'Demographic Data',
                                  style: _textTheme.bodyText2?.copyWith(
                                    color: Colors.white,
                                    // decoration: _selectedIndex == 1
                                    //     ? TextDecoration.underline
                                    //     : null
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    Expanded(
                      child: PageView(
                        controller: _tabController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          DemographicScreen(
                              // demographic: _demographic,
                              songId: songId,
                              songList: songList,
                              updateid: (int num, dynamic varr) {
                                songId = num;
                                isnew = varr;

                                audioPlayer.play(songList[num]['url']);
                                playing = true;
                                setState(() {});
                              }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: _size.height * 0.04,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: songId == -1
                          ? SizedBox(
                              height: _size.height * 0.04,
                            )
                          : PlayerHome(
                              // currentSong
                              // ,player
                              updatePlayingState: (bool isplay) {
                              playing = isplay;
                              setState(() {});
                            }, updatesongId: (int num) {
                              songId = num;
                              setState(() {});
                            }),
                    ),
                    SizedBox(
                      height: _size.height * 0.01,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

int songId = -1;
dynamic isnew = false;
// dynamic changeSlider=false;
double currentSlider = 0;
bool playing = false;
// Song currentSong = Song(
//     name: "title",
//     singer: "singer",
//     image: "assets/song1.jpg",
//     duration: 100,
//     url:'');
AudioPlayer audioPlayer = AudioPlayer();

// final player = AudioPlayer();
// final duration = player.setUrl('');

class PlayerHome extends StatefulWidget {
  PlayerHome(
      {Key? key, required this.updatePlayingState, required this.updatesongId})
      : super(key: key);

  Function updatePlayingState;
  Function updatesongId;

  // final Song song;
  // final player;

  // PlayerHome(
  //   // required this.updatePlayingState
  //   // this.song
  // // ,this.player
  // );

  @override
  State<PlayerHome> createState() => _PlayerHomeState();
}

class _PlayerHomeState extends State<PlayerHome> {
  @override
  Widget build(BuildContext context) {
     final myProvider = Provider.of<MyProvider>(context, listen: false);
    audioPlayer.onAudioPositionChanged.listen((Duration p) => {
          setState(() => currentSlider = p.inSeconds.toDouble())
          //  audioPlayer.playBytes(bytes)
        });
    return Container(
      height: 130,
      // padding: EdgeInsets.all(0),
      // decoration: BoxDecoration(
      //     color: HexColor('0A1227'),
      //     borderRadius: BorderRadius.circular(5),
      //     border: Border.all(color: Colors.black),
      //     boxShadow: [
      //       BoxShadow(
      //         color: Color.fromARGB(255, 47, 37, 190).withOpacity(0.5),
      //         spreadRadius: 3,
      //         blurRadius: 10,
      //         offset: Offset(0, 3)
      //       )
      //     ]
      //     ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/album-placeholder.png'),
                    radius: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        songList[songId]['name'],
                        // currentSlider.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        // currentSlider.toString(),
                        songList[songId]['singer'],
                        // songMap['QLQiBARH1dXiWM2YAqjb']!.name,
                        // "yohani "+songList.toString(),
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  if(myProvider.serachValue=="")
                  GestureDetector(
                    onTap: () {
                      if (songId - 1 >= 0) {
                        // await audioPlayer.dispose();
                        int newsongId = songId - 1;
                        currentSlider = 0;
                         audioPlayer.stop();
                        // audioPlayer.setUrl(songList[songId]['url']);
                        audioPlayer.play(songList[newsongId]['url']);
                        playing = true;
                        this.widget.updatesongId(newsongId);
                      }

                      setState(() {});
                    },
                    child: Icon(
                      Icons.skip_previous_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        // if(isnew){
                        //    audioPlayer.play(songList[songId]['url']);
                        //    setState(() {
                        //      isnew=false;
                        //    });
                        // }
                        // else
                        if (playing) {
                          audioPlayer.pause();
                          this.widget.updatePlayingState(false);
                        } else {
                          audioPlayer.resume();
                          this.widget.updatePlayingState(true);
                        }
                        // setState(() {
                        //     if(playing){
                        //       playing=false;
                        //     }else{
                        //       playing=true;
                        //     };
                        //   });
                      },
                      child: playing
                          ? Icon(
                              Icons.pause,
                              color: Colors.white,
                              size: 30,
                            )
                          : Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 30,
                            )),
                  SizedBox(
                    width: 10,
                  ),
                   if(myProvider.serachValue=="")
                  GestureDetector(
                    onTap: () {
                      if (songId + 1 < songList.length) {
                        // await audioPlayer.dispose();
                        int newsongId = songId + 1;
                        currentSlider = 0;
                        audioPlayer.stop();
                        audioPlayer.play(songList[newsongId]['url']);
                        playing = true;
                        this.widget.updatesongId(newsongId);
                      }

                      setState(() {});
                    },
                    child: Icon(
                      Icons.skip_next_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                Duration(seconds: currentSlider.toInt())
                    .toString()
                    .split('.')[0]
                    .substring(2),
                // '01.20',
                style: TextStyle(color: Colors.white),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 160,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 4),
                    trackShape: RectangularSliderTrackShape(),
                    trackHeight: 4,
                  ),
                  child: Slider(
                    value: currentSlider,
                    max: songList[songId]['duration'].toDouble(),
                    min: 0,
                    inactiveColor: Colors.grey[500],
                    activeColor: Colors.white,
                    onChanged: (val) {
                      setState(() {
                        currentSlider = val;
                        // changeSlider=true;
                        audioPlayer.seek(Duration(seconds: val.toInt()));
                      });
                    },
                  ),
                ),
              ),
              Text(
                Duration(seconds: songList[songId]['duration'].toInt())
                    .toString()
                    .split('.')[0]
                    .substring(2)
                // '14.0'
                ,
                style: TextStyle(color: Colors.white),
              )
            ],
          )
        ]),
      ),
    );
  }
}
