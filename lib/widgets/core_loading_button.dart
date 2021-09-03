import 'package:flutter/material.dart';

class CoreLoadingButton extends StatelessWidget {
  final Function() onPressed;
  final Widget child;
  final bool loading;
  final Color color;
  final double width;
  final double height;
  const CoreLoadingButton(
      {Key? key,
      required this.onPressed,
      this.loading = false,
      this.child = const Text(''),
      this.color = Colors.blue,
      this.width = 60.0,
      this.height = 40.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: loading
            ? SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
            : child,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
              side: BorderSide(color: color, width: 2.5),
            ),
            primary: color),
      ),
    );
  }
}
