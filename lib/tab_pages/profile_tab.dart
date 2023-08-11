import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uber_clone/global/global.dart';
import 'package:uber_clone/splash_screen.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({super.key});

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  bool loading = false;

  Future<void> uploadImage(String inputSource) async {
    final picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
        source:
            inputSource == 'camera' ? ImageSource.camera : ImageSource.gallery);

    if (pickedImage == null) {
      // ignore: avoid_returning_null_for_void
      return null;
    }

    String fileName = pickedImage.name;
    File imageFile = File(pickedImage.path);

    try {
      setState(() {
        loading = true;
      });
      await firebaseStorage.ref(fileName).putFile(imageFile);
      setState(() {
        loading = false;
      });
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text("Successfully Uploaded"),
      // ));
      Fluttertoast.showToast(msg: "Successfully Uploaded");
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello, Upload your Car's image."),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            uploadImage('camera');
                          },
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                          ),
                          label: const Text("Camera"),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            uploadImage('gallery');
                          },
                          icon: const Icon(
                            Icons.folder_open_sharp,
                          ),
                          label: const Text("Gallery"),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
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
