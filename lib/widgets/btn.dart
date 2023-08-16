import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.onTap,
      required this.title,
      required this.icon,
      required this.index,
      this.height,
      this.width})
      : super(key: key);

  final void Function() onTap;
  final String title;
  final IconData icon;
  final int index;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: index == 1 ? Colors.transparent : Colors.white,
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            height: height ?? _size.height * 0.15,
            width: width ?? _size.width * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: index == 1
                  ? Border.all(width: 1, color: Colors.lightBlueAccent)
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 30,
                  color: index == 1 ? Colors.white : Colors.blue,
                ),
                SizedBox(
                  height: _size.height * 0.005,
                ),
                Text(
                  title,
                  style: _textTheme.button?.copyWith(
                    color: index == 1 ? Colors.white : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
