import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/core/widgets/email_validator.dart';
import 'package:flutter/material.dart';
import '../core/widgets/constum_button.dart';
import '../core/widgets/text_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  bool hidePassword1 = true;
  bool hidePassword2 = true;
  bool isApiCallProcess = false;

  String? passVerif;

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
                        'انشاء حساب',
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
            top: heightScreen * 0.33,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: widthScreen,
              child: Form(
                key: globalKey,
                child: Column(
                  children: [
                    customTextFormField(
                      onChanged: (value) {},
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
                        // print(email);
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
                      onPressed: () {},
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('لديك حساب؟'),
                        TextButton(
                          onPressed: () {},
                          child: const Text('تسجيل الدخول'),
                        ),
                      ],
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
