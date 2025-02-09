import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/appMangers/imageManger.dart';
import 'package:evently/core/appMangers/stringsManger.dart';
import 'package:evently/core/dialogUtils.dart';
import 'package:evently/core/firebase_ecodes.dart';
import 'package:evently/core/regx/regx.dart';
import 'package:evently/core/reusableWidgets/customElevatedButtom.dart';
import 'package:evently/core/reusableWidgets/customTextFormField.dart';
import 'package:evently/ui/register/screen/register_screen.dart';
import 'package:evently/ui/resetPassword/screen/resetPassword_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:evently/core/constants/objects/userObj.dart' as MyUser;
import '../../../core/appMangers/colorsManger.dart';
import '../../../core/constants/firebase/firebaseHandeler.dart';
import '../../home/screen/home_screen.dart';
import '../../start_screen/widget/animatedToggleLocal.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static String routeName = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GlobalKey<FormState> formKey;
  late TextEditingController nameController;
  late TextEditingController mailController;
  late TextEditingController passwordController;
  late TextEditingController rePasswordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    mailController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    mailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(StringManger.login).tr(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: formKey,
          child: SingleChildScrollView(
            child: Column(children: [
              Image.asset(ImageManger.bodyLogo),
              const Gap(24),
              Gap(16),
              CustomTextFormField(
                prefixIcon: ImageManger.mailIcon,
                hint: StringManger.mail,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return StringManger.emptyError.tr();
                  }
                  if (!RegExp(emailRegex).hasMatch(value)) {
                    return "Email not Valid";
                  }
                },
                controller: mailController,
              ),
              Gap(16),
              CustomTextFormField(
                prefixIcon: ImageManger.passwordIcon,
                hint: StringManger.password,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return StringManger.emptyError.tr();
                  } else if (!RegExp(passwordRegex).hasMatch(value)) {
                    return "Use at least 12 characters with a mix of letters, \n Numbers, and symbols. \n Avoid common words or personal info. Stay secure! 🔒";
                  }
                },
                controller: passwordController,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          ResetPasswordScreen.routeName,
                          arguments: mailController.text);
                    },
                    child: Text(
                      StringManger.forgetPassword,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorManger.lightSecondary,
                            decoration: TextDecoration.underline,
                          ),
                    ).tr()),
              ),
              Gap(16),
              CustomElevatedButton(
                  elevetadChild: StringManger.login.tr(),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      signIn();

                    }
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Dont have account").tr(),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(RegisterScreen.routeName);
                      },
                      child: Text("Create account",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: ColorManger.lightSecondary,
                                      decoration: TextDecoration.underline))
                          .tr())
                ],
              ),
              Gap(16),
              FilledButton(
                  style: FilledButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: ColorManger.lightSecondary),
                          borderRadius: BorderRadius.circular(16))),
                  onPressed: () async {
                    DialogUtils.showDialogLoading(context);
                    await signInWithGoogle();
                    Navigator.pop(context);

                    Navigator.of(context).pushNamedAndRemoveUntil(
                        HomeScreen.routeName, (route) => false);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/googleLogo.svg"),
                      Gap(8),
                      Text(
                        "Sign in whith Google",
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    ],
                  )),
              Gap(16),
              const AnimatedToggleLocal()
            ]),
          ),
        ),
      ),
    );
  }

  signIn() async {
    try {
      DialogUtils.showDialogLoading(context);
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: mailController.text, password: passwordController.text);

      Navigator.pop(context);
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
      print(credential.user?.email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

   Future<dynamic> signInWithGoogle() async {
try {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
  await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

   await FirebaseAuth.instance.signInWithCredential(credential);
  await FirebaseHandler.addUser(MyUser.User(name: googleUser?.displayName,
      email: googleUser?.email,
      phone: "No phone Number",
      id: FirebaseAuth.instance.currentUser?.uid,
      favorite: []));
  // Once signed in, return the UserCredential
  print("***********************${googleUser?.id}");
}on Exception catch(e) {

  print('--------------------------$e');
}

        }



}
