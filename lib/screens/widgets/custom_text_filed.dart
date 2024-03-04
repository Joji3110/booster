import 'package:flutter/material.dart';
import 'package:flutter_booster/utils/constants/color.dart';

class CustomTextFiled extends StatefulWidget {
  final FocusNode focusNode;
  final String? labelText;
  final double? horizontal, vertical;
  final Widget? suffixIcon;
  final int? maxLines;
  final bool? expands;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  const CustomTextFiled({
    super.key,
    required this.focusNode,
    required this.labelText,
    this.horizontal,
    this.vertical,
    this.suffixIcon,
    this.validator,
    this.controller,
    this.onChanged,
    this.maxLines,
    this.expands,
  });

  @override
  State<CustomTextFiled> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  late bool hasFocus;
  late bool isControllerEmpty;

  @override
  void initState() {
    super.initState();
    hasFocus = widget.focusNode.hasFocus;
    isControllerEmpty = widget.controller?.text.isEmpty ?? true;
    widget.focusNode.addListener(() {
      setState(() {
        hasFocus = widget.focusNode.hasFocus;
      });
    });
    widget.controller?.addListener(() {
      setState(() {
        isControllerEmpty = widget.controller?.text.isEmpty ?? true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const radius = BorderRadius.all(
      Radius.circular(15.0),
    );
    return TextFormField(
      onChanged: widget.onChanged,
      controller: widget.controller,
      validator: widget.validator,
      focusNode: widget.focusNode,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.top,
      maxLines: widget.maxLines,
      expands: widget.expands ?? false,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: TColors.darkGreyColor,
        ),
        filled: true,
        fillColor:
            !isControllerEmpty || hasFocus ? TColors.lightColor : TColors.lightGreyColor,
        contentPadding: EdgeInsets.symmetric(
          horizontal: widget.horizontal ?? 0,
          vertical: widget.vertical ?? 0,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(
            color: TColors.greyColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: !isControllerEmpty
              ? const BorderSide(
                  color: TColors.greyColor,
                  width: 1.0,
                )
              : const BorderSide(
                  color: TColors.lightColor,
                  width: 1.0,
                ),
        ),
      ),
    );
  }
}
