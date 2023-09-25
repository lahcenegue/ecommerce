import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/main.dart';
import 'package:ecommerce/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../core/utils/cache_helper.dart';
import '../core/widgets/constum_button.dart';
import '../data/api_login_code.dart';

class LoginCodeScreen extends StatefulWidget {
  final String phoneNumber;

  const LoginCodeScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<LoginCodeScreen> createState() => _LoginCodeScreenState();
}

class _LoginCodeScreenState extends State<LoginCodeScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  String? yourCode;

  bool isApiCallProcess = false;

  @override
  void initState() {
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
              height: heightScreen * 0.8,
              width: widthScreen,
              child: Form(
                key: globalKey,
                child: ListView(
                  children: [
                    SizedBox(
                      height: heightScreen * 0.27,
                    ),
                    Text(
                      'رمز التحقق',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: heightScreen * 0.03,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'ادخل الارقام التي ارسلت الى رقم هاتفك',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: heightScreen * 0.022,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: heightScreen * 0.07,
                    ),
                    Container(
                      width: widthScreen,
                      height: heightScreen * 0.1,
                      padding: const EdgeInsets.all(08),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(08),
                      ),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'رمز التحقق ارسل الى الرقم',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: heightScreen * 0.02,
                                ),
                              ),
                              Text(
                                widget.phoneNumber,
                                style: TextStyle(
                                  fontSize: heightScreen * 0.03,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.mode,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: heightScreen * 0.05),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        length: 4,
                        onChanged: (value) {
                          setState(() {
                            yourCode = value;
                          });
                        },
                      ),
                    ),

                    // login button
                    customButton(
                      title: 'تأكيد',
                      buttonWidth: widthScreen,
                      topPadding: 40,
                      onPressed: () {
                        setState(() {
                          isApiCallProcess = true;
                        });

                        apiLoginCode(widget.phoneNumber, yourCode)
                            .then((value) {
                          setState(() {
                            isApiCallProcess = false;
                          });

                          if (value.code == null) {
                            if (value.user == "new") {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(
                                    phoneNumber: widget.phoneNumber,
                                    code: yourCode!,
                                  ),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            } else if (value.user == "old") {
                              CacheHelper.saveData(
                                  key: PrefKeys.token, value: value.token);
                              CacheHelper.saveData(
                                  key: PrefKeys.name, value: value.name);

                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/', (_) => false);
                            }
                          } else if (value.code == 'error') {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                    'sooq.in',
                                    textAlign: TextAlign.center,
                                  ),
                                  content: const Text(
                                    'يجب ادخال الكود الصحيح',
                                    textAlign: TextAlign.center,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('رجوع'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        });
                      },
                    ),
                    SizedBox(
                      height: heightScreen * 0.12,
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
