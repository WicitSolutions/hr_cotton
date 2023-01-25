import 'package:flutter/services.dart';
import 'package:hr_cotton/api/api.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../api/storageSharedPrefrences.dart';
import '../colors/app_colors.dart';
import '../styles/login_screen_styles.dart';
import '../svgs/svg_images.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Api instance = Api();
  String usernameTxt = "admin@hrcottonusa.com", passwordTxt = "umair@123"; // TODO: make "" strings
  bool isLoggingIn = false;
  final txtUsernameController = TextEditingController();
  final txtPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print("login Screen");
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF0061A6),
      statusBarIconBrightness: Brightness.light,
    ));
    txtUsernameController.value = const TextEditingValue(text: "admin@hrcottonusa.com");
    txtPasswordController.value = const TextEditingValue(text: "umair@123");
  }

  void showSnackBar(String message, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            message,
            style: const TextStyle(
              color: AppColors.baseGrey40Color,
            ),
          ),
          Icon(
            icon,
            color: AppColors.baseGrey40Color,
          )
        ],
      ),
    ));
  }

  void gotoHomeScreen(isAuthorized) {
    if (isAuthorized) {
      Navigator.popAndPushNamed(context, "/home"); // pushReplacementNamed
      /*RoutingPage.goToNextPage(
                        context: context,
                        navigateTo: const HomeScreen(),
                      );*/
    } else {
      setState(() {
        isLoggingIn = false;
      });
      showSnackBar("Invalid Username or password.", Icons.error);
      txtUsernameController.clear();
      txtPasswordController.clear();
    }
  }

  Widget buildTopPart({required BuildContext context}) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/bg2.png"),
          fit: BoxFit.fill,
        ),
        // color: Color(0xff0061a6),
      ),
      height: 350,
      child: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 3,
                  blurStyle: BlurStyle.normal,
                  spreadRadius: 2,
                  // offset: Offset(1, 1),
                ),
              ],
              color: const Color(0xffffffff),
            ),
            clipBehavior: Clip.hardEdge,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/logo_icon.png",
                width: 70,
                semanticLabel: "HR Cotton USA",
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "HR Cotton USA",
            style: LoginScreenStyles.mainHeadingTextStyles,
          ),
        ],
      ),
    );
  }

  Widget buildBottomPart() {
    return SizedBox(
      height: 230,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            "Or Sign In By",
            style: LoginScreenStyles.signInSocialStyles,
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  onPressed: () {},
                  shape: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 0.5,
                      color: AppColors.baseGrey40Color,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: WebsafeSvg.asset(
                    SvgImages.facebook,
                    color: AppColors.baseBlackColor,
                    width: 45,
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  shape: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 0.5,
                      color: AppColors.baseGrey40Color,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: WebsafeSvg.asset(
                    SvgImages.twitter,
                    color: AppColors.baseBlackColor,
                    width: 45,
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  shape: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 0.5,
                      color: AppColors.baseGrey40Color,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: WebsafeSvg.asset(
                    SvgImages.google,
                    color: AppColors.baseBlackColor,
                    width: 45,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: MaterialButton(
              color: AppColors.baseGrey10Color,
              height: 55,
              elevation: 0,
              shape: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Center(
                child: Text(
                  "Sign up",
                  style: LoginScreenStyles.signUpButtonTextStyles,
                ),
              ),
              onPressed: () {
                /*PageRouting.goToNextPage(
              context: context,
              navigateTo: SignupScreen(),
            );*/
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints.expand(),
            /*decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg.png"),
                fit: BoxFit.cover,
                alignment: Alignment.centerRight
              ),
            ),*/
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildTopPart(context: context),
                    const SizedBox(height: 50),
                    Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: TextField(
                                obscureText: false,
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(Icons.person),
                                  filled: true,
                                  hintText: "Username",
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF263238),
                                    ),
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ),
                                controller: txtUsernameController,
                                onChanged: (username) {
                                  usernameTxt = username.toString();
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: TextField(
                                obscureText: true,
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(Icons.key),
                                  filled: true,
                                  hintText: "Password",
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF263238),
                                    ),
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ),
                                controller: txtPasswordController,
                                onChanged: (password) {
                                  passwordTxt = password.toString();
                                },
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(value: false, onChanged: (value) {}),
                                  const Text("Remember Me"),
                                ],
                              ),
                              TextButton(
                                onPressed: () {},
                                style:
                                    LoginScreenStyles.forgotPasswordButtonStyle,
                                child: const Text(
                                  "Forgot Password",
                                  style: LoginScreenStyles.forgotPasswordStyles,
                                ),
                                // style: LoginScreenStyles.forgotPasswordStyles,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: MaterialButton(
                                  color: Colors.blue.shade700,
                                  onPressed: () async {
                                    setState(() {
                                      isLoggingIn = true;
                                    });
                                    SPStorage.setIsLoggedIn(true);
                                    SPStorage.printIsLoggedIn("Home Screen");
                                    await instance.getUser(usernameTxt, passwordTxt);
                                    gotoHomeScreen(instance.isAuthorized);
                                  },
                                  height: 45,
                                  elevation: 0,
                                  child: !isLoggingIn
                                      ? const Text(
                                          "Log in",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 5,
                                      ),
                                ),
                              ),
                              /*const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: CustomButton(
                                    text: "Sign Up",
                                    color: AppColors.baseDarkPinkColor,
                                    onPress: () {},
                                  ),
                                ),*/
                            ],
                          ),
                        ),
                      ],
                    )
                    // buildBottomPart(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
