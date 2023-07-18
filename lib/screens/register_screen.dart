import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/core/widgets/email_validator.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../core/utils/cache_helper.dart';
import '../core/widgets/constum_button.dart';
import '../core/widgets/text_form.dart';
import '../data/api_register.dart';
import '../models/register_response_model.dart';

class RegisterScreen extends StatefulWidget {
  final String phoneNumber;
  final String code;
  const RegisterScreen({
    super.key,
    required this.phoneNumber,
    required this.code,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  late RegisterRequestModel registerRequestModel;

  bool hidePassword1 = true;
  bool hidePassword2 = true;
  bool isApiCallProcess = false;

  String? passVerif;

  @override
  void initState() {
    registerRequestModel = RegisterRequestModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
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
                ),
              ],
            ),
          ),
          Positioned(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: widthScreen,
              height: heightScreen,
              child: Form(
                key: globalKey,
                child: ListView(
                  children: [
                    SizedBox(height: heightScreen * 0.23),
                    Text(
                      'انشاء حساب',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: heightScreen * 0.03,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: heightScreen * 0.06),
                    customTextFormField(
                      onChanged: (value) {
                        registerRequestModel.name = value.toString();
                      },
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'أدخل الاسم';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      prefixIcon: Icons.person,
                      hintText: 'الاسم',
                    ),

                    //email
                    customTextFormField(
                      onChanged: (value) {
                        registerRequestModel.email = value.toString();
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
                      hintText: 'الايميل',
                    ),

                    //password
                    customTextFormField(
                      onChanged: (value) {
                        registerRequestModel.password = value.toString();
                        passVerif = value.toString();
                      },
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'أرجوا ادخال كلمة المرور';
                        } else if (value.toString().length < 6) {
                          return 'كلمة المرور تحتوي على اقل من 6 احرف';
                        }

                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: hidePassword1,
                      prefixIcon: Icons.lock,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword1 = !hidePassword1;
                            });
                          },
                          icon: Icon(
                            hidePassword1
                                ? Icons.visibility_off
                                : Icons.visibility,
                          )),
                      hintText: 'كلمة المرور',
                    ),

                    //password 2
                    customTextFormField(
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'أرجوا ادخال كلمة المرور';
                        }
                        if (value.toString().isNotEmpty &&
                            value.toString() != passVerif) {
                          return 'أرجوا ادخال نفس كلمة المرور';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: hidePassword2,
                      prefixIcon: Icons.lock,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword2 = !hidePassword2;
                            });
                          },
                          icon: Icon(
                            hidePassword2
                                ? Icons.visibility_off
                                : Icons.visibility,
                          )),
                      hintText: 'تأكيد كلمة المرور',
                    ),

                    // login button
                    customButton(
                      title: 'انشاء حساب',
                      topPadding: 40,
                      buttonWidth: widthScreen,
                      onPressed: () {
                        if (validateAndSave()) {
                          setState(() {
                            isApiCallProcess = true;
                          });
                          apiRegister(
                            phone: widget.phoneNumber,
                            yourCode: widget.code,
                            registerRequestModel: registerRequestModel,
                          ).then((value) async {
                            setState(() {
                              isApiCallProcess = false;
                            });

                            if (value.msg == "ok") {
                              CacheHelper.saveData(
                                  key: PrefKeys.token, value: value.token);
                              CacheHelper.saveData(
                                  key: PrefKeys.name, value: value.name);
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
      )),
    );
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
