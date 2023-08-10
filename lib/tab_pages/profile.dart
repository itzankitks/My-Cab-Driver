import 'package:flutter/material.dart';
import 'package:uber_clone/global/global.dart';
import 'package:uber_clone/splash_screen.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({super.key});

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          fAuth.signOut();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MySpalshScreen(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        child: const Text("Sign Out"),
      ),
    );
  }
}
