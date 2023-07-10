import 'dart:async';

import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/widgets/constum_button.dart';
import '../firebase/function.dart';
import 'home_screen.dart';
import 'main_screen.dart';

class LoginCodeScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  const LoginCodeScreen({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
  });

  @override
  State<LoginCodeScreen> createState() => _LoginCodeScreenState();
}

class _LoginCodeScreenState extends State<LoginCodeScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  String yourCode = '6677';
  String smsCode = '';

  bool loading = false;
  bool resend = false;
  int count = 20;

  bool isApiCallProcess = false;

  final _auth = FirebaseAuth.instance;

  savePhone(String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phone', phone);
  }

  saveName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
  }

  saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  //OTP
  late Timer timer;

  void decompte() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (count < 1) {
        timer.cancel();
        count = 20;
        resend = true;
        setState(() {});
        return;
      }
      count--;
      setState(() {});
    });
  }

  void onResendSmsCode() {
    resend = false;
    setState(() {});
    authWithPhoneNumber(
      widget.phoneNumber,
      onCodeSend: (verificationId, v) {
        loading = false;

        decompte();
        setState(() {});
      },
      onAutoVerify: (v) async {
        await _auth.signInWithCredential(v);
      },
      onFailed: (e) {
        loading = false;
        setState(() {});
        debugPrint("Le code est erroné");
      },
      autoRetrieval: (v) {},
    );
  }

  void onVerifySmsCode() async {
    setState(() {
      loading = true;
    });
    await validateOtp(smsCode, widget.verificationId).whenComplete(() {
      setState(() {
        loading = true;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });

    // apiLoginCode(widget.phoneNumber, yourCode).then((value) async {
    //   setState(() {
    //     isApiCallProcess = false;
    //   });
    //   savePhone(widget.phoneNumber);
    //   if (value.user == "new") {
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => RegisterScreen(
    //                 phoneNumber: widget.phoneNumber,
    //                 code: yourCode,
    //               )),
    //     );
    //   } else if (value.user == "old") {
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => MainScreen(
    //                 token: value.token!,
    //               )),
    //     );
    //     saveToken(value.token!);
    //     saveName(value.name!);
    //   }
    // });

    debugPrint("Vérification éfectué avec succès");
  }

  @override
  void initState() {
    super.initState();
    decompte();
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
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
                        length: 6,
                        onChanged: (value) {
                          smsCode = value;
                          setState(() {});
                        },
                      ),
                    ),

                    // login button
                    customButton(
                      title: 'تأكيد',
                      buttonWidth: widthScreen,
                      topPadding: 40,
                      onPressed: () {
                        if (validateAndSave()) {
                          setState(() {
                            isApiCallProcess = true;
                          });
                          smsCode.length < 6 || loading
                              ? null
                              : onVerifySmsCode();
                        }
                      },
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: !resend ? null : onResendSmsCode,
                        child: Text(
                          !resend
                              ? "00:${count.toString().padLeft(2, "0")}"
                              : "إعادة ارسال الكود",
                          style: TextStyle(
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
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
