// import 'package:flutter/material.dart';
// import 'package:flutter_booster/common/panel_data.dart';
// import 'package:flutter_booster/screens/widgets/create_material_panel.dart';

// CreateMaterialPanel buildMaterialPanel(
//       List<CreateMaterialPanel> panelsList,
//       List<PanelDataMaterial> panelDataList,
//       TextEditingController nameController,
//       TextEditingController measurementsController,
//       TextEditingController quantityController,
//       FocusNode focusNodeMaterial,
//       FocusNode focusNodeQuantityProduct,
//       FocusNode focusNodeMeasurements,
//       String labelTextMaterial,
//       String labelTextQuantityProduct,
//       String labelTextMeasurements,
//       String text,
//       String nameButton) {
//     return CreateMaterialPanel(
//       key: UniqueKey(),
//       measurementsController: measurementsController,
//       nameMaterialController: nameController,
//       quantityController: quantityController,
//       onDelete: () {
//         setState(() {
//           panelsList.remove(nameController);
//           panelDataList.remove(nameController);
//         });
//       },
//       labelTextMaterial: labelTextMaterial,
//       labelTextQuantityProduct: labelTextQuantityProduct,
//       labelTextMeasurements: labelTextMeasurements,
//       text: text,
//       nameButton: nameButton,
//       focusNodeMaterial: focusNodeMaterial,
//       focusNodeQuantityProduct: focusNodeQuantityProduct,
//       focusNodeMeasurements: focusNodeMeasurements,
//     );
//   }