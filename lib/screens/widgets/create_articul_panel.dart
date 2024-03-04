import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_booster/screens/widgets/custom_text_filed.dart';

class CraeteArticulPanel extends StatelessWidget {
  final FocusNode focusNodeNumber, focusNodeDescription;
  final TextEditingController numberArticuleController;
  final TextEditingController descriptionArticuleController;
  final String? Function(String?)? validator;
  const CraeteArticulPanel({
    super.key,
    required this.focusNodeNumber,
    required this.focusNodeDescription,
    required this.numberArticuleController,
    required this.descriptionArticuleController,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
          child: Text(
            'ИНФОРМАЦИЯ ОБ АРТИКУЛЕ',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
        ),
        Column(
          children: [
            CustomTextFiled(
              controller: numberArticuleController,
              validator: validator,
              focusNode: focusNodeNumber,
              labelText: 'Номер артикула *',
              horizontal: 13.0,
              vertical: 10.0,
            ),
            const SizedBox(height: 8.0),
            CustomTextFiled(
              controller: descriptionArticuleController,
              validator: validator,
              focusNode: focusNodeDescription,
              labelText: 'Описание артикула',
              horizontal: 13.0,
              maxLines: 7,
            ),
          ],
        ),
      ],
    );
  }
}
