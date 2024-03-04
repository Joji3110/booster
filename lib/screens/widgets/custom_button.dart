import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String nameButton;
  final Color colorButton;
  final void Function() onTap;
  final double? width;

  const CustomButton({
    super.key,
    required this.nameButton,
    required this.colorButton,
    required this.onTap,
    this.width,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: widget.colorButton,
        ),
        child: Text(
          widget.nameButton,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
