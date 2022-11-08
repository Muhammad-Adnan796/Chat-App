import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({Key? key, 
     this.title,
    required this.backgroundColor,
    required this.onPress,
    this.elevation,
    this.shape,
    this.color,
    this.size,
  }) : super(key: key);
  final Widget? title;
  final Color backgroundColor;
  final Function onPress;
  double? elevation;
  var shape;
  Color? color;
  double? size;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        
        fixedSize: MaterialStateProperty.all(
          Size.fromRadius(size!),
        ),
        shadowColor: MaterialStateProperty.all(color),
        elevation: MaterialStateProperty.all(elevation),
        shape: MaterialStateProperty.all(shape),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
      ),
      onPressed: () {
        onPress();
      },
      child: title,
    );
  }
}
