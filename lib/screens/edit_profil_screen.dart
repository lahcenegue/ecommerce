import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/core/utils/cache_helper.dart';
import 'package:ecommerce/core/widgets/email_validator.dart';
import 'package:ecommerce/data/update_profil_api.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../core/widgets/constum_button.dart';
import '../core/widgets/text_form.dart';
import '../homeViewModel/home_view_model.dart';
import '../models/update_profil_model.dart';

class EditProfilScreen extends StatefulWidget {
  const EditProfilScreen({super.key});

  @override
  State<EditProfilScreen> createState() => _EditProfilScreenState();
}

class _EditProfilScreenState extends State<EditProfilScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  HomeViewModel hvm = HomeViewModel();
  late UpdateProfilRequestModel updateProfilRequestModel;

  bool isApiCallProcess = false;

  @override
  void initState() {
    updateProfilRequestModel = UpdateProfilRequestModel();
    hvm.fetchProfilInfo(
      token: CacheHelper.getData(key: PrefKeys.token),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;

    hvm.addListener(() {
      setState(() {});
    });

    if (hvm.profilInfo == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              SizedBox(
                height: heightScreen,
                width: widthScreen,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      height: heightScreen * 0.43,
                      width: widthScreen,
                      color: AppColors.primary,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.white,
                              size: heightScreen * 0.05,
                            ),
                          ),
                          SizedBox(height: heightScreen * 0.04),
                          Center(
                            child: Container(
                              height: heightScreen * 0.12,
                              width: heightScreen * 0.12,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          SizedBox(height: heightScreen * 0.015),
                          Center(
                            child: Text(
                              CacheHelper.getData(key: PrefKeys.name),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: heightScreen * 0.025,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: heightScreen * 0.33,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: widthScreen,
                  child: Form(
                    key: globalKey,
                    child: Column(
                      children: [
                        customTextFormField(
                          onChanged: (value) {
                            updateProfilRequestModel.info = value;
                          },
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'أدخل المعلومات';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          prefixIcon: Icons.info,
                          hintText: hvm.profilInfo!.info.isEmpty
                              ? 'المعلومات'
                              : hvm.profilInfo!.info,
                        ),

                        //email
                        customTextFormField(
                          onChanged: (value) {
                            updateProfilRequestModel.email = value;
                          },
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'أرجو التحقق من عنوان البريد الالكتروني';
                            }
                            if (value!.isNotEmpty &&
                                !value.toString().isValidEmail()) {
                              return 'أرجو التحقق من عنوان البريد الالكتروني';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: Icons.mail,
                          hintText: hvm.profilInfo!.email.isEmpty
                              ? 'الايميل'
                              : hvm.profilInfo!.email,
                        ),
                        customButton(
                          title: 'تأكيد',
                          topPadding: 40,
                          buttonWidth: widthScreen,
                          onPressed: () async {
                            if (validateAndSave()) {
                              setState(() {
                                isApiCallProcess = true;
                              });
                              await apiUpdateProfil(
                                updateProfilRequestModel:
                                    updateProfilRequestModel,
                                token: CacheHelper.getData(key: PrefKeys.token),
                              ).then((value) {
                                setState(() {
                                  isApiCallProcess = false;
                                });
                                if (value.edit == 'ok') {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
                                    ),
                                  );
                                }
                              });
                            }
                          },
                        ),
                        SizedBox(height: heightScreen * 0.1),
                      ],
                    ),
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
          ),
        ),
      );
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
