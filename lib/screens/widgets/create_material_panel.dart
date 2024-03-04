import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_booster/screens/widgets/custom_text_filed.dart';
import 'package:flutter_booster/screens/widgets/dropdwn_menu.dart';
import 'package:flutter_booster/utils/constants/color.dart';

class CreateMaterialPanel extends StatefulWidget {
  final FocusNode focusNodeMaterial,
      focusNodeQuantityProduct,
      focusNodeMeasurements;
  final String text,
      labelTextMaterial,
      labelTextQuantityProduct,
      labelTextMeasurements,
      nameButton;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final TextEditingController? measurementsController,
      nameMaterialController,
      quantityController;

  final VoidCallback? onDelete;

  const CreateMaterialPanel({
    super.key,
    required this.focusNodeMaterial,
    required this.focusNodeQuantityProduct,
    required this.focusNodeMeasurements,
    required this.text,
    required this.nameButton,
    required this.labelTextMaterial,
    required this.labelTextQuantityProduct,
    required this.labelTextMeasurements,
    this.suffixIcon,
    this.measurementsController,
    this.nameMaterialController,
    this.onDelete,
    this.quantityController,
    this.onChanged,
  });

  @override
  State<CreateMaterialPanel> createState() => _CreateMaterialPanelState();
}

class _CreateMaterialPanelState extends State<CreateMaterialPanel> {
  bool? isButtonEnabled;
  void initState() {
    super.initState();
    widget.nameMaterialController?.addListener(updateButtonColor);
  }

  void updateButtonColor() {
    setState(() {
      // Проверяем, являются ли nameMaterialController непустым
      bool allFieldsFilled =
          widget.nameMaterialController?.text.isNotEmpty ?? false;
      isButtonEnabled = allFieldsFilled;
    });
  }

  @override
  void dispose() {
    widget.nameMaterialController?.removeListener(updateButtonColor);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.text,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: CustomTextFiled(
                onChanged: widget.onChanged,
                controller: widget.nameMaterialController,
                focusNode: widget.focusNodeMaterial,
                labelText: widget.labelTextMaterial,
                horizontal: 15.0,
              ),
            ),
            const SizedBox(width: 10.0),
            GestureDetector(
              onTap: () {
                widget.onDelete?.call();
                widget.nameMaterialController!.clear();
                widget.measurementsController!.clear();
                widget.quantityController?.clear();
              },
              child: Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: isButtonEnabled ?? false
                      ? Colors.white
                      : TColors.greyColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                  border: Border.all(
                      color: isButtonEnabled ?? false
                          ? Colors.blue
                          : TColors.greyColor),
                ),
                child: Icon(
                  Icons.close,
                  color: isButtonEnabled ?? false
                      ? TColors.blueColor
                      : Colors.white,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: CustomTextFiled(
                onChanged: widget.onChanged,
                controller: widget.quantityController,
                focusNode: widget.focusNodeQuantityProduct,
                labelText: widget.labelTextQuantityProduct,
                horizontal: 5.0,
              ),
            ),
            const SizedBox(width: 5.0),
            CustomDropdownMenu(
              measurementsController: widget.measurementsController,
            ),
          ],
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
