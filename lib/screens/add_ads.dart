import 'dart:io';
import 'dart:typed_data';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:ecommerce/core/utils/cache_helper.dart';
import 'package:ecommerce/core/widgets/text_form.dart';
import 'package:ecommerce/data/add_ads_api.dart';
import 'package:ecommerce/models/add_ads.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import '../core/utils/app_colors.dart';
import 'home_screen.dart';

class AddAdsScreen extends StatefulWidget {
  final List catNames;
  final List listCategories;

  const AddAdsScreen({
    super.key,
    required this.catNames,
    required this.listCategories,
  });

  @override
  State<AddAdsScreen> createState() => _AddAdsScreenState();
}

class _AddAdsScreenState extends State<AddAdsScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late AddAdsRequest addAdsRequest;

  String? category;
  String? subCatName;
  int? subCatId;
  int catPosition = 0;
  int subCatPosition = 0;
  int mainImage = 0;
  String mainImageBase64 = '';

  int _currentStep = 0;

  bool isApiCallProcess = false;

  @override
  void initState() {
    addAdsRequest = AddAdsRequest();
    addAdsRequest.token = CacheHelper.getData(key: PrefKeys.token);
    super.initState();
  }

  List<File> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        WillPopScope(
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
              type: StepperType.horizontal,

              // on Tapped
              onStepTapped: (int index) {
                setState(() {
                  _currentStep = index;
                });
              },

              // current Step
              currentStep: _currentStep,

              // cantinue
              onStepContinue: () async {
                if (_currentStep < 1) {
                  if ((addAdsRequest.name != null) &&
                      (addAdsRequest.amount != null) &&
                      (addAdsRequest.comment != null) &&
                      (addAdsRequest.catid != null)) {
                    setState(() {
                      _currentStep += 1;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('يحب ملء جميع المعلومات'),
                      ),
                    );
                  }
                } else {
                  if (mainImageBase64.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('يجب اختيار الصور'),
                      ),
                    );
                  } else {
                    if (validateAndSave()) {
                      setState(() {
                        isApiCallProcess = true;
                      });
                      await addAdsApi(addAdsRequest: addAdsRequest)
                          .then((value) {
                        setState(() {
                          isApiCallProcess = false;
                        });
                        if (value.msg == 'ok') {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        }
                      });
                    }
                  }
                }
              },
              onStepCancel: () {
                if (_currentStep > 0) {
                  setState(() {
                    _currentStep -= 1;
                  });
                } else {
                  Navigator.pop(context);
                }
              },
              steps: [
                Step(
                  isActive: _currentStep >= 0,
                  title: const Text(''),
                  content: Form(
                    key: globalKey,
                    child: Column(
                      children: [
                        // category
                        SizedBox(
                          height: heightScreen * 0.072,
                          child: DropdownSearch(
                            items: widget.catNames,
                            //////////////////////////////////////////////////////////////=========>
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
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
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
                            items:
                                widget.listCategories[catPosition].subCatName,
                            selectedItem: subCatName,
                            enabled: category == null ? false : true,
                            onChanged: (value) {
                              setState(() {
                                subCatName = value.toString();
                                subCatPosition = widget
                                    .listCategories[catPosition].subCatName
                                    .indexOf(subCatName);
                                subCatId = widget.listCategories[catPosition]
                                    .subCatId[subCatPosition];
                                addAdsRequest.catid = subCatId.toString();
                              });
                            },
                            popupProps: const PopupProps.menu(
                              showSearchBox: true,
                              scrollbarProps: ScrollbarProps(),
                            ),
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
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

                        customTextFormField(
                          hintText: 'العنوان',
                          onChanged: (value) {
                            addAdsRequest.name = value;
                          },
                        ),

                        //price

                        customTextFormField(
                          hintText: 'السعر',
                          onChanged: (value) {
                            addAdsRequest.amount = value;
                          },
                          keyboardType: TextInputType.number,
                        ),

                        //descreption

                        customTextFormField(
                          hintText: 'الوصف',
                          onChanged: (value) {
                            addAdsRequest.comment = value;
                          },
                          keyboardType: TextInputType.text,
                          maxLine: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                Step(
                  isActive: _currentStep >= 1,
                  title: const Text(''),
                  content: Column(
                    children: [
                      // picturs
                      SizedBox(
                        height: selectedImages.isEmpty
                            ? heightScreen * 0.2
                            : heightScreen * 0.43,
                        width: widthScreen,
                        child: selectedImages.isEmpty
                            ? Center(
                                child: Text(
                                  'لم تحمل الصور بعد',
                                  style: TextStyle(
                                    fontSize: heightScreen * 0.025,
                                  ),
                                ),
                              )
                            : ListView.separated(
                                padding: const EdgeInsets.all(12),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: selectedImages.length,
                                separatorBuilder: (context, index) => SizedBox(
                                  width: heightScreen * 0.05,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return SizedBox(
                                    height: heightScreen * 0.4,
                                    width: widthScreen * 0.6,
                                    child: Stack(
                                      children: [
                                        Image.file(
                                          selectedImages[index],
                                          height: heightScreen * 0.4,
                                          width: widthScreen * 0.6,
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          child: IconButton(
                                            onPressed: () {
                                              selectedImages.removeAt(index);

                                              setState(() {
                                                selectedImages;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.remove_circle,
                                              color: Colors.red,
                                              size: heightScreen * 0.04,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 0,
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                mainImage = index;
                                                Uint8List imagebytes =
                                                    selectedImages[mainImage]
                                                        .readAsBytesSync();

                                                mainImageBase64 =
                                                    base64Encode(imagebytes);
                                              });

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'تم اختيار الصورة ${index + 1} كصورة رئيسية'),
                                                ),
                                              );
                                            },
                                            icon: Icon(
                                              Icons.check_circle,
                                              color: mainImage == index
                                                  ? Colors.green
                                                  : Colors.blue,
                                              size: heightScreen * 0.04,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                      ),
                      SizedBox(height: heightScreen * 0.02),
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
                                    content:
                                        Text('لا يمكن تحميل اكثر من 4 صور')));
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
        ),
        Visibility(
          visible: isApiCallProcess ? true : false,
          child: Stack(
            children: [
              ModalBarrier(
                color: Colors.white.withOpacity(0.6),
                dismissible: true,
              ),
              const Center(
                child: CircularProgressIndicator(),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future getImages() async {
    final pickedFile = await ImagePicker().pickMultiImage();
    List<XFile> xfilePick = pickedFile;

    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        selectedImages.add(File(xfilePick[i].path));
      }
      setState(() {
        Uint8List imagebytes = selectedImages[mainImage].readAsBytesSync();

        mainImageBase64 = base64Encode(imagebytes);
        addAdsRequest.image = mainImageBase64;
      });
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

  bool validateAndSave() {
    final FormState? form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
