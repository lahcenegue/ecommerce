import 'package:ecommerce/core/utils/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../core/widgets/constum_button.dart';
import '../data/api_login_mobile.dart';

import 'login_code_screen.dart';

class LoginMobileScreen extends StatefulWidget {
  const LoginMobileScreen({super.key});

  @override
  State<LoginMobileScreen> createState() => _LoginMobileScreenState();
}

class _LoginMobileScreenState extends State<LoginMobileScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  String phoneNumber = '';

  bool loading = false;
  bool isApiCallProcess = false;

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Text(
                        'ادخل رقم هاتفك لتسجيل الدخول',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: heightScreen * 0.03,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: heightScreen * 0.1),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: heightScreen * 0.39,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: widthScreen,
              child: Form(
                key: globalKey,
                child: Column(
                  children: [
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: IntlPhoneField(
                        languageCode: "ar",
                        countries: const <Country>[
                          Country(
                            name: "Kuwait",
                            nameTranslations: {
                              "sk": "Kuvajt",
                              "se": "Kuwait",
                              "pl": "Kuwejt",
                              "no": "Kuwait",
                              "ja": "クウェート",
                              "it": "Kuwait",
                              "zh": "科威特",
                              "nl": "Koeweit",
                              "de": "Kuwait",
                              "fr": "Koweït",
                              "es": "Kuwait",
                              "en": "Kuwait",
                              "pt_BR": "Kuwait",
                              "sr-Cyrl": "Кувајт",
                              "sr-Latn": "Kuvajt",
                              "zh_TW": "科威特",
                              "tr": "Kuveyt",
                              "ro": "Kuweit",
                              "ar": "الكويت",
                              "fa": "کویت",
                              "yue": "科威特"
                            },
                            flag: "🇰🇼",
                            code: "KW",
                            dialCode: "965",
                            minLength: 8,
                            maxLength: 8,
                          ),
                        ],
                        textAlign: TextAlign.left,
                        invalidNumberMessage: 'قمت بإدخال رقم خاطئ',
                        onChanged: (value) {
                          phoneNumber = value.completeNumber;
                        },
                        decoration: const InputDecoration(
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

                    // login button
                    customButton(
                      title: 'ارسل رمز التحقق',
                      topPadding: 40,
                      buttonWidth: widthScreen,
                      onPressed: () {
                        String newphone = phoneNumber.replaceAll('+965', '');
                        if (validateAndSave()) {
                          setState(() {
                            isApiCallProcess = true;
                          });
                          apiLoginMobile(newphone).then((value) {
                            setState(() {
                              isApiCallProcess = false;
                            });
                            if (value.msg == 'ok') {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginCodeScreen(
                                    phoneNumber: newphone,
                                  ),
                                ),
                              );
                            }
                          });
                        }
                      },
                    ),
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
