import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/appMangers/colorsManger.dart';
import 'package:evently/core/appMangers/imageManger.dart';
import 'package:evently/core/appMangers/stringsManger.dart';
import 'package:evently/core/dialogUtils.dart';
import 'package:evently/core/firebase_ecodes.dart';
import 'package:evently/core/regx/regx.dart';
import 'package:evently/core/reusableWidgets/customElevatedButtom.dart';
import 'package:evently/core/reusableWidgets/customTextFormField.dart';
import 'package:evently/ui/login/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:evently/core/constants/objects/userObj.dart' as MyUser;
import '../../../core/constants/firebase/firebaseHandeler.dart';
import '../../home/screen/home_screen.dart';
import '../../start_screen/widget/animatedToggleLocal.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static String routeName = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
        title: Text(StringManger.register).tr(),
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
              CustomTextFormField(
                prefixIcon: ImageManger.nameIcon,
                hint: StringManger.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return StringManger.emptyError.tr();
                  }
                },
                controller: nameController,
              ),
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
              Gap(16),
              CustomTextFormField(
                prefixIcon: ImageManger.passwordIcon,
                hint: StringManger.rePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return StringManger.emptyError.tr();
                  } else if (value != passwordController.text) {
                    return "Password not match";
                  }
                },
                controller: rePasswordController,
              ),
              Gap(16),
              CustomElevatedButton(
                  elevetadChild: StringManger.createAccount.tr(),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      createAccount();
                    }
                  }),
              Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(StringManger.alreadyHaveAccount).tr(),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(LoginScreen.routeName);
                      },
                      child: Text(StringManger.login,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: ColorManger.lightSecondary,
                                      decoration: TextDecoration.underline))
                          .tr())
                ],
              ),
              const AnimatedToggleLocal()
            ]),
          ),
        ),
      ),
    );
  }

  createAccount() async {
    try {
      DialogUtils.showDialogLoading(context);

      ///we put this before await cause compile this statement then blocking in await until finish then remove it by pop
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(

          ///credential is obj that's have user that's created on server (access user details)
          email: mailController.text,
          password: passwordController.text);
     await FirebaseHandler.addUser(MyUser.User(name: nameController.text, email:credential.user!.email, phone: credential.user?.phoneNumber, id: credential.user?.uid, favorite: []));

      DialogUtils.showToastMassage("account created");
      Navigator.pop(context);
      Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);

      ///we remove it by pop cause alert dialog consider as screen
    } on FirebaseAuthException catch (e) {
      ///on are used for specific exception and every exp in have code
      Navigator.pop(context);

      if (e.code == FirebaseECodes.emailAlreadyInUse) {
        DialogUtils.showDialogMassage(
            context: context,
            massage: 'The account already exists for that email.',
            positiveBtnTitle: "ok",
            onPstvBtnPressed: () {
              Navigator.pop(context);
            });
        print('The account already exists for that email.');
      } else if (e.code == FirebaseECodes.weekPasswordCode) {
        print('The password provided is too weak.');
      }
    } catch (e) {
      DialogUtils.showToastMassage("account created");
      Navigator.pop(context);
      print(e);
    }
  }
}
