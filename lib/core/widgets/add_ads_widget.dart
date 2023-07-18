import 'package:dropdown_search/dropdown_search.dart';

import 'package:flutter/material.dart';

class AddAdsWidget extends StatefulWidget {
  int currentStep;
  final List catNames;
  final List listCategories;

  AddAdsWidget({
    super.key,
    required this.currentStep,
    required this.catNames,
    required this.listCategories,
  });

  @override
  State<AddAdsWidget> createState() => _AddAdsWidgetState();
}

class _AddAdsWidgetState extends State<AddAdsWidget> {
  String? category;
  String? subCat;
  int catPosition = 0;

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return AlertDialog(
      title: const Text(
        'اضف اعلان',
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: widthScreen,
        height: heightScreen * 0.7,
        child: Stepper(
          currentStep: widget.currentStep,
          type: StepperType.horizontal,
          onStepTapped: (int index) {
            setState(() {
              widget.currentStep = index;
            });
          },
          onStepContinue: () {
            setState(() {
              widget.currentStep += 1;
            });
          },
          onStepCancel: () {
            if (widget.currentStep > 0) {
              setState(() {
                widget.currentStep -= 1;
              });
            } else {
              Navigator.pop(context);
            }
          },
          steps: [
            Step(
              isActive: widget.currentStep >= 0,
              title: const Text(''),
              content: Column(
                children: [
                  DropdownSearch(
                    items: widget.catNames,
                    onChanged: (value) {
                      setState(() {
                        category = value;
                        catPosition = widget.catNames.indexOf(category);
                      });
                    },
                    popupProps: const PopupProps.menu(
                      showSearchBox: true,
                      scrollbarProps: ScrollbarProps(),
                    ),
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: "الأقسام",
                      ),
                    ),
                  ),
                  SizedBox(height: heightScreen * 0.05),
                  DropdownSearch(
                    items: widget.listCategories[catPosition].subCatName,
                    enabled: category == null ? false : true,
                    onChanged: (value) {
                      setState(() {
                        subCat = value;
                      });
                    },
                    popupProps: const PopupProps.menu(
                      showSearchBox: true,
                      scrollbarProps: ScrollbarProps(),
                    ),
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: "الأقسام الفرعية",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Step(
              isActive: widget.currentStep >= 1,
              title: const Text(''),
              content: Column(
                children: [
                  Text('etape 2 '),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
