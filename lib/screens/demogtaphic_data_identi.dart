import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:optimum_music/screens/image_resoponse_screen.dart';
import 'package:optimum_music/screens/splash_screen.dart';
import 'package:optimum_music/services/dio_service.dart';
import 'package:optimum_music/services/my_provider.dart';
import 'package:optimum_music/utils/models.dart';
import 'package:optimum_music/widgets/app_logo.dart';
import 'package:optimum_music/widgets/image_response_loading_widget.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum LoadingState { Loading, NotLoading }

class demoDataIden extends StatefulWidget {
  const demoDataIden({Key? key, required this.imageFile}) : super(key: key);

  final XFile? imageFile;

  @override
  State<demoDataIden> createState() => _demoDataIdenState();
}

class _demoDataIdenState extends State<demoDataIden>
    with SingleTickerProviderStateMixin {
  LoadingState _lodingState = LoadingState.Loading;
  late Demographic _demographic;
  @override
  void initState() {
  
    _init();
    super.initState();
  }

  void _init() async {
    await Future.delayed(const Duration(seconds: 3));

     final myProvider = Provider.of<MyProvider>(context, listen: false);
        final resDemo = await DioService()
        .sendRequest(widget.imageFile!.path, 'demographicsImage');
    print('ger hello world');
    print(resDemo);
    try {
     
    _demographic = Demographic.fromJson(resDemo);
      // _demographic = await APICall().demographic();
    } catch (e) {
      print('Error Occured while demographic req: $e');
    }
    
    setState(() {
      _lodingState = LoadingState.NotLoading;
    });
    // Map<String,Song> songMap={};
    print('add ML details to firestore');
  }

  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<MyProvider>(context, listen: false);
    final _size = MediaQuery.of(context).size;
    final _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: _lodingState == LoadingState.Loading
          ? const ImageResponseLoadingWidget()
          : Padding(
           padding: EdgeInsets.symmetric(horizontal: _size.width * 0.1),
            child: Column(
                children: [
                  SizedBox(
                    height: _size.height * 0.03,
                  ),
                  AppLogo(),
                  SizedBox(
                    height: _size.height * 0.03,
                  ),
                  Text(
                    'Demographic data \n identification',
                    textAlign: TextAlign.center,
                    style: _textTheme.caption!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: _size.width * 0.05),
                  ),
                  SizedBox(
                    height: _size.height * 0.03,
                  ),
                  Text(
                    'identified Age',
                    style: _textTheme.caption!.copyWith(
                        fontWeight: FontWeight.w200,
                        fontSize: _size.width * 0.03),
                  ),
                  Text(
                    _demographic.age,
                    style: _textTheme.caption!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: _size.width * 0.05),
                  ),
                  SizedBox(
                    height: _size.height * 0.03,
                  ),
                  Text(
                    'identified Gender',
                     style: _textTheme.caption!.copyWith(
                        fontWeight: FontWeight.w200,
                        fontSize: _size.width * 0.03),
                  ),
                  Text(_demographic.gender,
                    style: _textTheme.caption!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: _size.width * 0.05),),
                  SizedBox(
                    height: _size.height * 0.03,
                  ),
                  Text(
                    'identified Location',
                     style: _textTheme.caption!.copyWith(
                        fontWeight: FontWeight.w200,
                        fontSize: _size.width * 0.03),
                  ),
                  Text(_demographic.ethnicity,
                   style: _textTheme.caption!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: _size.width * 0.05),),
                  SizedBox(
                    height: _size.height * 0.03,
                  ),
                  Text(
                      'if you not statisfied with the automatic predction please change by cliking the edit button',
                      textAlign: TextAlign.center,
                      style: _textTheme.caption!.copyWith(
                        fontWeight: FontWeight.w200,
                        fontSize: _size.width * 0.03,
                        color: Colors.grey),),
                         SizedBox(
                    height: _size.height * 0.03,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SplashScreen()),
                        (route) => false,
                      );
                    },
                    icon: Icon(Icons.edit),
                    label: Text('Re-Identify'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFF0E1C63)),
                    ),
                  ),
                   SizedBox(
                    height: _size.height * 0.03,
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      myProvider.user['ethnicity'] = _demographic.ethnicity;
                      myProvider.user['gender'] = _demographic.gender;
                      myProvider.user['age'] = _demographic.age;
          
                      await FirebaseFirestore.instance
                          .collection('users')
                          // .doc(myProvider.user['email'])
                          .doc(myProvider.user['id'])
                          .set(myProvider.user);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImageResponseScreen(
                                  imageFile: null,
                                )),
                        (route) => false,
                      );
                    },
                    icon: Icon(Icons.save),
                    label: Text('Save and Finish'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFF0E1C63)),
                    ),
                  ),
                ],
              ),
          ),
    );
  }
}

