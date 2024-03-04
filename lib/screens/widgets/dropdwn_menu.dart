import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_booster/cubit/measurement_cubit.dart';

import 'package:flutter_booster/utils/constants/color.dart';

class CustomDropdownMenu extends StatefulWidget {
  final TextEditingController? measurementsController;

  const CustomDropdownMenu({
    super.key,
    this.measurementsController,
  });
  @override
  _DropdwnMenuState createState() => _DropdwnMenuState();
}

class _DropdwnMenuState extends State<CustomDropdownMenu> {
  String selectedValue = '';
  bool enabled = true;
  late bool isControllerEmpty;

  @override
  void initState() {
    super.initState();
    isControllerEmpty = widget.measurementsController?.text.isEmpty ?? true;
    setState(() {
      widget.measurementsController?.addListener(() {
        isControllerEmpty = widget.measurementsController?.text.isEmpty ?? true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeasurementCubit, List<Map<String, dynamic>>>(
      builder: (context, measurementNames) {
        const radius = BorderRadius.all(
          Radius.circular(20.0),
        );
        return DropdownMenu<Map<String, dynamic>>(
          inputDecorationTheme: InputDecorationTheme(
            fillColor:
                isControllerEmpty ? TColors.lightGreyColor : TColors.lightColor,
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 1, vertical: -10),
            labelStyle: const TextStyle(color: TColors.darkGreyColor),
            focusedBorder: const OutlineInputBorder(
              borderRadius: radius,
              borderSide: BorderSide(
                color: TColors.greyColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: radius,
              borderSide: isControllerEmpty
                  ? BorderSide.none
                  : const BorderSide(
                      color: TColors.greyColor,
                      width: 1.0,
                    ),
            ),
          ),
          width: 185.0,
          trailingIcon: const Icon(Icons.arrow_drop_down),
          controller: widget.measurementsController,
          requestFocusOnTap: true,
          label: const Text(
            'Ед.измерения *',
            style: TextStyle(fontSize: 15),
          ),
          onSelected: (Map<String, dynamic>? selectedMeasurement) {
            if (selectedMeasurement != null) {
              setState(() {
                selectedValue = selectedMeasurement['id'].toString();
              });
            }
          },
          dropdownMenuEntries:
              measurementNames.map<DropdownMenuEntry<Map<String, dynamic>>>(
            (measurement) {
              return DropdownMenuEntry<Map<String, dynamic>>(
                value: measurement,
                label: measurement['name'] as String,
                trailingIcon: measurement['name'] == 'метр'
                    ? const Icon(
                        Icons.arrow_drop_up,
                        color: Colors.white,
                      )
                    : null,
                style: MenuItemButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                ),
              );
            },
          ).toList(),
        );
      },
    );
  }
}
