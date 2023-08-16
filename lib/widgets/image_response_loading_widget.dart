import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageResponseLoadingWidget extends StatelessWidget {
  const ImageResponseLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _size.width * 0.07),
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.red,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: _size.height * 0.02,
              ),
              Container(
                width: _size.width * 0.3,
                height: _size.height * 0.035,
                color: Colors.white,
              ),
              SizedBox(height: _size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            Container(
                              width: _size.width * 0.3,
                              height: _size.height * 0.025,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: _size.width * 0.14,
                              height: _size.height * 0.025,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            Container(
                              width: _size.width * 0.3,
                              height: _size.height * 0.025,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: _size.width * 0.14,
                              height: _size.height * 0.025,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.white,
              ),
              Column(
                children: [
                  SizedBox(
                    height: _size.height * 0.04,
                  ),
                  Container(
                    width: _size.width * 0.55,
                    height: _size.height * 0.025,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: _size.width * 0.2,
                    height: _size.height * 0.03,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: _size.height * 0.05,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: _size.width * 0.5,
                      height: _size.height * 0.03,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: _size.height * 0.025,
                  ),
                  for (int i = 0; i < 5; i++)
                    Container(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          Container(
                            width: _size.height * 0.085,
                            height: _size.height * 0.085,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: _size.width * 0.6,
                                height: _size.height * 0.025,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: _size.width * 0.3,
                                height: _size.height * 0.035,
                                color: Colors.white,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
