import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:ecommerce/core/widgets/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../core/utils/app_colors.dart';

class AddAdsScreen extends StatefulWidget {
  int currentStep;
  final List catNames;
  final List listCategories;

  AddAdsScreen({
    super.key,
    required this.currentStep,
    required this.catNames,
    required this.listCategories,
  });

  @override
  State<AddAdsScreen> createState() => _AddAdsScreenState();
}

class _AddAdsScreenState extends State<AddAdsScreen> {
  String? category;
  String? subCat;
  int catPosition = 0;

  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemporary = File(image.path);

      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'اضف اعلان',
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                    'Sooq.in',
                    textAlign: TextAlign.center,
                  ),
                  content: Text(
                    'هل تريد تأكيد الرجوع؟',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: heightScreen * 0.02),
                  ),
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(08),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'إكمال',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Text('تأكيد الرجوع'),
                    ),
                  ],
                );
              },
            );
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Stepper(
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
                // category
                SizedBox(
                  height: heightScreen * 0.072,
                  child: DropdownSearch(
                    items: widget.catNames,
                    selectedItem: category,
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
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(08),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: heightScreen * 0.022),

                // sub category
                SizedBox(
                  height: heightScreen * 0.072,
                  child: DropdownSearch(
                    items: widget.listCategories[catPosition].subCatName,
                    selectedItem: subCat,
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
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(08),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // title
                //SizedBox(height: heightScreen * 0.02),

                customTextFormField(hintText: 'العنوان'),

                //price

                customTextFormField(
                  hintText: 'الثمن',
                  keyboardType: TextInputType.number,
                ),

                //descreption

                customTextFormField(
                  hintText: 'الوصف',
                  keyboardType: TextInputType.text,
                  maxLine: 5,
                ),
              ],
            ),
          ),
          Step(
            isActive: widget.currentStep >= 1,
            title: const Text(''),
            content: Column(
              children: [
                Container(
                  height: image == null ? 0 : heightScreen * 0.4,
                  width: widthScreen,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(08),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  child: image == null
                      ? const SizedBox()
                      : Image.file(
                          image!,
                          width: widthScreen,
                          height: heightScreen * 0.4,
                        ),
                ),
                SizedBox(height: heightScreen * 0.03),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(heightScreen * 0.072),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    pickImage();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.photo_size_select_actual_rounded),
                      Text('حمل الصورة'),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
