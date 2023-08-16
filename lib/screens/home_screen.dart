import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:optimum_music/screens/demogtaphic_data_identi.dart';
import 'package:optimum_music/screens/image_resoponse_screen.dart';
import 'package:optimum_music/widgets/app_logo.dart';
import 'package:optimum_music/widgets/btn.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  XFile? _imageFile;
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickimage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Future<void> _pickVideo(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickVideo(source: source);
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Widget _bottomSheetBtn(onTap, _size, icon, title, _textTheme) {
    return Material(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: _size.height * 0.08,
          width: _size.width * 0.4,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 30,
                color: Colors.white,
              ),
              SizedBox(
                height: _size.height * 0.005,
              ),
              Text(
                title,
                style: _textTheme.button?.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(
      {required Size size,
      required void Function()? onPressedGallery,
      required void Function()? onPressedCamera,
      required TextTheme textTheme}) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: size.height * 0.2,
          color: Colors.white,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.1,
                          vertical: size.height * 0.02),
                      child: Text(
                        'Choose Image Source',
                        style: textTheme.headline3?.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: Row(
                      children: [
                        Expanded(
                          child: _bottomSheetBtn(onPressedGallery, size,
                              Icons.image, 'Gallery', textTheme),
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Expanded(
                          child: _bottomSheetBtn(onPressedCamera, size,
                              Icons.camera, 'Camera', textTheme),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppLogo(
              height: 100,
            ),
            SizedBox(
              height: _size.height * 0.05,
            ),
            CustomButton(
              onTap: () {
                _showBottomSheet(
                    onPressedCamera: () async {
                      if (await Permission.camera.request().isGranted) {
                        await _pickimage(ImageSource.camera);
                        Navigator.pop(context);
                        if (_imageFile != null) {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return  demoDataIden(imageFile: _imageFile);
                            // ImageResponseScreen(
                            //   imageFile: _imageFile,
                            // );
                           
                          }));
                        }
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    onPressedGallery: () async {
                      if (await Permission.storage.request().isGranted) {
                        await _pickimage(ImageSource.gallery);
                        Navigator.pop(context);
                        if (_imageFile != null) {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return demoDataIden(imageFile: _imageFile);
                            // ImageResponseScreen(
                            //   imageFile: _imageFile,
                            // );
                          }));
                        }
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    size: _size,
                    textTheme: _textTheme);
              },
              title: 'Add Image',
              icon: Icons.image,
              index: 1,
            ),
            SizedBox(
              height: _size.height * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}
