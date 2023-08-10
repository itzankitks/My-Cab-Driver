import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_clone/authentication/car_info_screen.dart';
import 'package:uber_clone/authentication/sign_in_Screen.dart';
import 'package:uber_clone/widgets/progress_dialog.dart';
import '../global/global.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // making Controllers for the required inout fields while logging in

  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  saveDriverInfoNow() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: ((context) {
        return ProgressDialog(message: "Processing, Please wait...");
      }),
    );

    final User? firebaseUser = (await fAuth
            .createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
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
      Map driverMap = {
        "id": firebaseUser.uid,
        "name": usernameController.text.trim(),
        "email": emailController.text.trim(),
        "phone": phoneController.text.trim(),
        "password": passwordController.text.trim()
      };

      DatabaseReference driverRef =
          FirebaseDatabase.instance.ref().child("drivers");
      driverRef.child(firebaseUser.uid).set(driverMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been created");

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const CarInfoScreen()));
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account Not Created");
    }
  }

  validateForm() {
    if (usernameController.text.length < 4) {
      Fluttertoast.showToast(msg: "Name must be atleast 4 characters");
    } else if (!emailController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Enter valid Email");
    } else if (phoneController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Phone number is required");
    } else if (phoneController.text.length != 10) {
      Fluttertoast.showToast(msg: "Enter valid phone number");
    } else if (passwordController.text.length < 8) {
      Fluttertoast.showToast(msg: "Password must be at least 8 characters");
    } else {
      saveDriverInfoNow();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
          child: Padding(
        padding:
            const EdgeInsets.only(top: 21, bottom: 21, left: 25, right: 25),
        child: Column(children: [
          const SizedBox(
            height: 10,
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Image.asset("assets/images/signUpLogo.png"),
          ),

          const SizedBox(
            height: 10,
          ),

          const Text(
            "Register as a Driver",
            style: TextStyle(
                fontSize: 25, color: Colors.grey, fontWeight: FontWeight.bold),
          ),

          const SizedBox(
            height: 25,
          ),

          // TestField for UserName
          TextField(
            controller: usernameController,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person),
              prefixIconColor: Colors.grey,
              labelText: "UserName",
              labelStyle: const TextStyle(color: Colors.grey),
              hintText: "Enter Your UserName",
              hintStyle: const TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: const BorderSide(
                  color: Colors.white,
                  width: 3,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(
                  color: Colors.cyanAccent,
                  width: 3,
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          // TestField for Email
          TextField(
            controller: emailController,
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
                  color: Colors.cyanAccent,
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

          // TestField for Phone Number
          TextField(
            controller: phoneController,
            style: const TextStyle(
              color: Colors.white,
            ),
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.phone),
              prefixIconColor: Colors.grey,
              labelText: "Phone Number",
              labelStyle: const TextStyle(color: Colors.grey),
              hintText: "Enter Your Phn. No.",
              hintStyle: const TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: const BorderSide(
                  color: Colors.white,
                  width: 3,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(
                  color: Colors.cyanAccent,
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
            controller: passwordController,
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
                  color: Colors.cyanAccent,
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

          ElevatedButton(
            onPressed: () {
              validateForm();
              //Taking User to CarInfoScreen
              /**/
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            child: const Text(
              "Next",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have account?",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              TextButton(
                onPressed: () {
                  //taking user back to SignInScreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Log-In here",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ]),
      )),
    );
  }
}
