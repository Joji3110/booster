import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_booster/common/panel_data.dart';
import 'package:flutter_booster/cubit/measurement_cubit.dart';
import 'package:flutter_booster/repositories/create_material.dart';

import 'package:flutter_booster/screens/widgets/app_bar.dart';
import 'package:flutter_booster/screens/widgets/create_articul_panel.dart';
import 'package:flutter_booster/screens/widgets/create_material_panel.dart';
import 'package:flutter_booster/screens/widgets/custom_button.dart';
import 'package:flutter_booster/utils/constants/color.dart';

class CreateArticleScreen extends StatefulWidget {
  const CreateArticleScreen({super.key});

  @override
  State<CreateArticleScreen> createState() => _CreateArticleScreenState();
}

class _CreateArticleScreenState extends State<CreateArticleScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey panel1Key = GlobalKey();
  final GlobalKey panel2Key = GlobalKey();

  List<CreateMaterialPanel> materialPanels = [];
  List<CreateMaterialPanel> accessoriesPanels = [];
  List<PanelDataMaterial> panelDataMaterialList = [];
  List<PanelDataAccessories> panelDataAccessoriesList = [];
  bool isButtonEnabled = false;
  bool isButtonEnabledAccessories = false;
  bool isSaving = false;

  final CreateMaterial createMaterial = CreateMaterial();

  final FocusNode _focusNodeNumber = FocusNode();
  final FocusNode _focusNodeDescription = FocusNode();
  final FocusNode _focusNodeMaterial = FocusNode();
  final FocusNode _focusNodeQuantityProduct = FocusNode();
  final FocusNode _focusNodeMaterialMeasurements = FocusNode();
  final FocusNode _focusNodeFurniture = FocusNode();
  final FocusNode _focusNodeQuantityUnit = FocusNode();
  final FocusNode _focusNodeFurnitureMeasurements = FocusNode();

  final TextEditingController numberArticuleController =
      TextEditingController();
  final TextEditingController descriptionArticuleController =
      TextEditingController();
  final TextEditingController nameMaterialController = TextEditingController();
  final TextEditingController measurementsMaterialController =
      TextEditingController();
  final TextEditingController nameAccessoriesController =
      TextEditingController();
  final TextEditingController measurementsAccessoriesController =
      TextEditingController();
  final TextEditingController quantityAccessoriesController =
      TextEditingController();
  final TextEditingController quantityMaterialController =
      TextEditingController();

  TextEditingController createNewController() {
    return TextEditingController();
  }

  @override
  void initState() {
    super.initState();
    nameMaterialController.addListener(updateButtonColor);
    measurementsMaterialController.addListener(updateButtonColor);
    quantityMaterialController.addListener(updateButtonColor);
    nameAccessoriesController.addListener(updateButtonColorAccessories);
    measurementsAccessoriesController.addListener(updateButtonColorAccessories);
    quantityAccessoriesController.addListener(updateButtonColorAccessories);
  }

  @override
  void dispose() {
    numberArticuleController.dispose();
    descriptionArticuleController.dispose();
    quantityAccessoriesController.dispose();
    measurementsAccessoriesController.dispose();
    measurementsMaterialController.dispose();
    quantityAccessoriesController.dispose();
    quantityMaterialController.dispose();
    nameAccessoriesController.dispose();

    _focusNodeNumber.dispose();
    _focusNodeDescription.dispose();
    _focusNodeMaterial.dispose();
    _focusNodeQuantityProduct.dispose();
    _focusNodeMaterialMeasurements.dispose();
    _focusNodeFurniture.dispose();
    _focusNodeQuantityUnit.dispose();
    _focusNodeFurnitureMeasurements.dispose();
    super.dispose();
  }

  void updateButtonColor() {
    setState(() {
      isButtonEnabled = nameMaterialController.text.isNotEmpty &&
          measurementsMaterialController.text.isNotEmpty &&
          quantityMaterialController.text.isNotEmpty;

      for (var panelData in materialPanels) {
        isButtonEnabled = isButtonEnabled &&
            panelData.measurementsController!.text.isNotEmpty &&
            panelData.nameMaterialController!.text.isNotEmpty &&
            panelData.quantityController!.text.isNotEmpty;
      }
    });
  }

  void updateButtonColorAccessories() {
    setState(() {
      isButtonEnabledAccessories = nameAccessoriesController.text.isNotEmpty &&
          measurementsAccessoriesController.text.isNotEmpty &&
          quantityAccessoriesController.text.isNotEmpty;

      for (var panelData in accessoriesPanels) {
        isButtonEnabledAccessories = isButtonEnabledAccessories &&
            panelData.measurementsController!.text.isNotEmpty &&
            panelData.nameMaterialController!.text.isNotEmpty &&
            panelData.quantityController!.text.isNotEmpty;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool a = isButtonEnabled && isButtonEnabledAccessories;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const AppBarCustom(),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CraeteArticulPanel(
                          validator: validate,
                          descriptionArticuleController:
                              descriptionArticuleController,
                          numberArticuleController: numberArticuleController,
                          focusNodeNumber: _focusNodeNumber,
                          focusNodeDescription: _focusNodeDescription,
                        ),
                        const SizedBox(height: 10.0),
                        CreateMaterialPanel(
                          key: panel1Key,
                          quantityController: quantityMaterialController,
                          measurementsController:
                              measurementsMaterialController,
                          nameMaterialController: nameMaterialController,
                          labelTextMaterial: 'Материал, цвет *',
                          labelTextQuantityProduct: 'Кол-во на ед. прод. *',
                          labelTextMeasurements: 'Ед. измерения *',
                          text: 'МАТЕРИАЛ',
                          nameButton: '+ материал',
                          focusNodeMaterial: _focusNodeMaterial,
                          focusNodeQuantityProduct: _focusNodeQuantityProduct,
                          focusNodeMeasurements: _focusNodeMaterialMeasurements,
                        ),
                        // Ваши текущие CreateMaterialPanel
                        ...materialPanels.asMap().entries.map((entry) {
                          final index = entry.key;
                          return CreateMaterialPanel(
                            key: UniqueKey(),
                            measurementsController: panelDataMaterialList[index]
                                .measurementsController,
                            nameMaterialController: panelDataMaterialList[index]
                                .nameMaterialController,
                            quantityController:
                                panelDataMaterialList[index].quantityController,
                            onDelete: () {
                              setState(() {
                                materialPanels.removeAt(index);
                                panelDataMaterialList.removeAt(index);
                              });
                            },
                            labelTextMaterial: 'Материал, цвет *',
                            labelTextQuantityProduct: 'Кол-во на ед. прод. *',
                            labelTextMeasurements: 'Ед. измерения *',
                            text: '',
                            nameButton: '+ материал',
                            focusNodeMaterial: FocusNode(),
                            focusNodeQuantityProduct: FocusNode(),
                            focusNodeMeasurements: FocusNode(),
                          );
                        }),
                        CustomButton(
                          width: 195.0,
                          nameButton: '+ материал',
                          colorButton: isButtonEnabled
                              ? TColors.blueColor
                              : TColors.greyColor,
                          onTap: () {
                            isButtonEnabled
                                ? setState(() {
                                    final UniqueKey newPanelKey = UniqueKey();
                                    TextEditingController
                                        measurementsController =
                                        createNewController();
                                    TextEditingController
                                        nameMaterialController =
                                        createNewController();
                                    TextEditingController quantityController =
                                        createNewController();

                                    PanelDataMaterial newPanelData =
                                        PanelDataMaterial(
                                      measurementsController:
                                          measurementsController,
                                      nameMaterialController:
                                          nameMaterialController,
                                      quantityController: quantityController,
                                    );
                                    panelDataMaterialList.add(newPanelData);
                                    materialPanels.add(CreateMaterialPanel(
                                      key: newPanelKey,
                                      measurementsController:
                                          measurementsController,
                                      nameMaterialController:
                                          nameMaterialController,
                                      quantityController: quantityController,
                                      labelTextMaterial: 'Материал, цвет *',
                                      labelTextQuantityProduct:
                                          'Кол-во на ед. прод. *',
                                      labelTextMeasurements: 'Ед. измерения *',
                                      text: 'МАТЕРИАЛ',
                                      nameButton: '+ материал',
                                      focusNodeMaterial: FocusNode(),
                                      focusNodeQuantityProduct: FocusNode(),
                                      focusNodeMeasurements: FocusNode(),
                                    ));
                                  })
                                : null;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        CreateMaterialPanel(
                          labelTextMaterial: 'Фурнитура *',
                          labelTextQuantityProduct: 'Кол-во на единицу *',
                          labelTextMeasurements: 'Ед. измерения *',
                          text: 'ФУРНИТУРА',
                          nameButton: '+ фурнитура',
                          focusNodeMaterial: _focusNodeFurniture,
                          focusNodeQuantityProduct: _focusNodeQuantityUnit,
                          quantityController: quantityAccessoriesController,
                          focusNodeMeasurements:
                              _focusNodeFurnitureMeasurements,
                          nameMaterialController: nameAccessoriesController,
                          measurementsController:
                              measurementsAccessoriesController,
                        ),
                        ...accessoriesPanels.asMap().entries.map(
                          (entry) {
                            final index = entry.key;
                            return CreateMaterialPanel(
                              labelTextMaterial: 'Фурнитура *',
                              labelTextQuantityProduct: 'Кол-во на единицу *',
                              labelTextMeasurements: 'Ед. измерения *',
                              text: '',
                              nameButton: '+ фурнитура',
                              onDelete: () {
                                setState(() {
                                  accessoriesPanels.removeAt(index);
                                  panelDataAccessoriesList.removeAt(index);
                                });
                              },
                              focusNodeMaterial: FocusNode(),
                              focusNodeQuantityProduct: FocusNode(),
                              focusNodeMeasurements: FocusNode(),
                              quantityController:
                                  panelDataAccessoriesList[index]
                                      .quantityController,
                              nameMaterialController:
                                  panelDataAccessoriesList[index]
                                      .nameAccessoriesController,
                              measurementsController:
                                  panelDataAccessoriesList[index]
                                      .measurementsController,
                            );
                          },
                        ),
                        CustomButton(
                          width: 195.0,
                          nameButton: '+ фурнитура',
                          colorButton: isButtonEnabledAccessories
                              ? TColors.blueColor
                              : TColors.greyColor,
                          onTap: () {
                            isButtonEnabledAccessories
                                ? setState(() {
                                    final UniqueKey newPanelKey = UniqueKey();
                                    TextEditingController
                                        measurementsController =
                                        createNewController();
                                    TextEditingController
                                        nameAccessoriesController =
                                        createNewController();
                                    TextEditingController quantityController =
                                        createNewController();
                                    PanelDataAccessories newPanelData =
                                        PanelDataAccessories(
                                      measurementsController:
                                          measurementsController,
                                      nameAccessoriesController:
                                          nameAccessoriesController,
                                      quantityController: quantityController,
                                    );

                                    panelDataAccessoriesList.add(newPanelData);
                                    accessoriesPanels.add(CreateMaterialPanel(
                                      key: newPanelKey,
                                      measurementsController:
                                          measurementsController,
                                      nameMaterialController:
                                          nameAccessoriesController,
                                      quantityController: quantityController,
                                      labelTextMaterial: 'Фурнитура *',
                                      labelTextQuantityProduct:
                                          'Кол-во на единицу *',
                                      labelTextMeasurements: 'Ед. измерения *',
                                      text: 'ФУРНИТУРА',
                                      nameButton: '+ фурнитура',
                                      focusNodeMaterial: FocusNode(),
                                      focusNodeQuantityProduct: FocusNode(),
                                      focusNodeMeasurements: FocusNode(),
                                    ));
                                  })
                                : null;
                          },
                        ),
                        const SizedBox(height: 10),
                        !isSaving
                            ? CustomButton(
                                nameButton: 'Сохранить',
                                colorButton:
                                    a ? TColors.blueColor : TColors.greyColor,
                                onTap: () => a ? save(context) : null,
                              )
                            : const CupertinoActivityIndicator(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пожалуйста, введите текст';
    }
    return null;
  }

  void save(context) async {
    if (_formKey.currentState!.validate()) {
      try {
        final int articleId = await createMaterial.craeteArticule(
          nameArticule: numberArticuleController.text,
          descriptionArticule: descriptionArticuleController.text,
        );

        final int materialMeasurementId = getMeasurementId(
          measurementsMaterialController.text,
        );
        final int materialId = await createMaterial.createMaterial(
          nameMaterial: nameMaterialController.text,
          itemType: 'material',
          measurement: materialMeasurementId,
        );

        final int accessoriesMeasurementId = getMeasurementId(
          measurementsAccessoriesController.text,
        );
        final int accessoriesId = await createMaterial.createAccessories(
          nameMaterial: nameAccessoriesController.text,
          itemType: 'accessories',
          measurement: accessoriesMeasurementId,
        );

        final int quantityMaterial = int.parse(quantityMaterialController.text);
        final int quantityAccessories =
            int.parse(quantityAccessoriesController.text);

        for (var panelData in materialPanels) {
          final int panelMeasurementId = getMeasurementId(
            panelData.measurementsController?.text ?? '1',
          );

          final int panelMaterialId = await createMaterial.createMaterial(
            nameMaterial: panelData.nameMaterialController?.text ?? 'jh',
            itemType: 'material',
            measurement: panelMeasurementId,
          );

          final int panelQuantityMaterial =
              int.parse(panelData.quantityController?.text ?? '0');
          createMaterial.createArticleItem(
            panelQuantityMaterial,
            articleId,
            panelMaterialId,
          );
        }
        for (var panelData in accessoriesPanels) {
          final int panelMeasurementId = getMeasurementId(
            panelData.measurementsController?.text ?? '1',
          );

          final int panelMaterialId = await createMaterial.createAccessories(
            nameMaterial: panelData.nameMaterialController?.text ?? 'jh',
            itemType: 'accessories',
            measurement: panelMeasurementId,
          );

          final int panelQuantityAccessories =
              int.parse(panelData.quantityController?.text ?? '0');
          createMaterial.createArticleItem(
            panelQuantityAccessories,
            articleId,
            panelMaterialId,
          );
        }

        createMaterial.createArticleItem(
          quantityMaterial,
          articleId,
          materialId,
        );
        createMaterial.createArticleItem(
          quantityAccessories,
          articleId,
          accessoriesId,
        );
        const snackBar = SnackBar(
          content: Text('Артикул упсешно создан!'),
        );

        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } catch (error) {
        print('Ошибка во время операции сохранения: $error');
        const snackBar = SnackBar(
          content: Text('Ошибка при создании артикула'),
        );

        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } finally {}
    }
  }

  int getMeasurementId(String measurementName) {
    final MeasurementCubit measurementCubit = context.read<MeasurementCubit>();
    final List<Map<String, dynamic>> measurementsList = measurementCubit.state;

    for (final measurement in measurementsList) {
      if (measurement['name'] == measurementName) {
        return int.parse(measurement['id'].toString());
      }
    }

    // Если не найдено, возвращаем значение по умолчанию
    return 1;
  }
}
