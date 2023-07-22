import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:ecommerce/core/widgets/text_form.dart';
import 'package:flutter/foundation.dart';
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
  //final ScaffoldMessengerState _scaffold =

  String? category;
  String? subCat;
  int catPosition = 0;

  File? mainImage;
  List<File> selectedImages = [];

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemporary = File(image.path);

      setState(() => mainImage = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future getImages() async {
    final pickedFile = await ImagePicker().pickMultiImage();
    List<XFile> xfilePick = pickedFile;

    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        selectedImages.add(File(xfilePick[i].path));
      }
      setState(() {});
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('لم يتم اختيار الصور'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
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
                        Navigator.of(context).pop(false);
                      },
                      child: const Text(
                        'إكمال',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Text('تأكيد الرجوع'),
                    ),
                  ],
                );
              },
            ) ??
            false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'اضف اعلان',
            textAlign: TextAlign.center,
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
            if (widget.currentStep < 2) {
              setState(() {
                widget.currentStep += 1;
              });
            }
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
                  SizedBox(
                    height: mainImage == null
                        ? heightScreen * 0.1
                        : heightScreen * 0.26,
                    width: widthScreen,
                    child: mainImage == null
                        ? const Center(
                            child: Text('لم تحمل الصورة الرئسية بعد'),
                          )
                        : Image.file(
                            mainImage!,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(Icons.photo_size_select_actual_rounded),
                        Text(
                          'حمل الصورة الرئيسية',
                          style: TextStyle(
                            fontSize: heightScreen * 0.025,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: heightScreen * 0.05),

                  // picturs
                  SizedBox(
                    height: selectedImages.isEmpty
                        ? heightScreen * 0.1
                        : selectedImages.length <= 2
                            ? heightScreen * 0.23
                            : heightScreen * 0.43,
                    width: widthScreen,
                    child: selectedImages.isEmpty
                        ? const Center(
                            child: Text('لم تحمل الصور بعد'),
                          )
                        : GridView.builder(
                            itemCount: selectedImages.length,
                            padding: const EdgeInsets.all(08),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 08,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Center(
                                  child: Image.file(selectedImages[index]));
                            },
                          ),
                  ),
                  SizedBox(height: heightScreen * 0.03),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(heightScreen * 0.072),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (selectedImages.length < 4) {
                        getImages();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('لا يمكن تحميل اكثر من 4 صور')));
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(Icons.photo_size_select_actual_rounded),
                        Text(
                          'حمل الصور',
                          style: TextStyle(
                            fontSize: heightScreen * 0.025,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: heightScreen * 0.04),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
