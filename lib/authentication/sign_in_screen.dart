import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_clone/authentication/sign_up_screen.dart';
import 'package:uber_clone/splash_screen.dart';
import 'package:uber_clone/widgets/progress_dialog.dart';

import '../global/global.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // making Controllers for the required inout fields while logging in
  //var logInUsernameController = TextEditingController();
  var logInemailController = TextEditingController();
  var logInpasswordController = TextEditingController();

  LoginDriverNow() async {
    showDialog(
      context: context,
      builder: (context) {
        return ProgressDialog(
          message: "Logging In, Please Wait...",
        );
      },
    );

    final User? firebaseUser = (await fAuth
            .signInWithEmailAndPassword(
      email: logInemailController.text.trim(),
      password: logInpasswordController.text.trim(),
      // ignore: body_might_complete_normally_catch_error
    )
            .catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: "Error: $msg",
      );
    }))
        .user;

    if (firebaseUser != null) {
      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Logged In Succesfully!!");

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MySpalshScreen(),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occured While Logging in");
    }
  }

  validateForm() {
    if (!logInemailController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Enter valid Email");
    } else if (logInpasswordController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Password is required");
    } else {
      LoginDriverNow();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
          child: Padding(
        padding:
            const EdgeInsets.only(top: 21, bottom: 21, left: 40, right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Image.asset(
                "assets/images/driverLogo.png",
                height: 200,
                width: 350,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            const Text(
              "Sign In",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(
              height: 20,
            ),

            // TestField for Email
            TextField(
              controller: logInemailController,
              style: const TextStyle(
                color: Colors.white,
              ),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
                prefixIconColor: Colors.grey,
                labelText: "E-mail",
                labelStyle: const TextStyle(color: Colors.grey),
                hintText: "Enter Your email",
                hintStyle: const TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    color: Colors.cyan,
                    width: 3,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 3,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            // TestField for Password
            TextField(
              controller: logInpasswordController,
              style: const TextStyle(
                color: Colors.white,
              ),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              obscuringCharacter: "*",
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.password),
                prefixIconColor: Colors.grey,
                labelText: "Password",
                labelStyle: const TextStyle(color: Colors.grey),
                hintText: "Enter Your Password",
                hintStyle: const TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    color: Colors.cyan,
                    width: 3,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 3,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            ElevatedButton(
              onPressed: () {
                validateForm();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              child: const Text(
                "Log-In",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Don't have a account,",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()));
                  },
                  child: const Text(
                    "Create-One",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
