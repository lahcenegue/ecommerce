import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/core/widgets/email_validator.dart';
import 'package:flutter/material.dart';
import '../core/widgets/constum_button.dart';
import '../core/widgets/text_form.dart';

class EditProfilScreen extends StatefulWidget {
  const EditProfilScreen({super.key});

  @override
  State<EditProfilScreen> createState() => _EditProfilScreenState();
}

class _EditProfilScreenState extends State<EditProfilScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: heightScreen * 0.13,
                        width: heightScreen * 0.13,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'مرام السالمي',
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
