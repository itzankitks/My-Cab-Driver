import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_clone/main_screen.dart';
import '../global/global.dart';

class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({super.key});

  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  var carTypeController = TextEditingController();
  var carModelController = TextEditingController();
  var carNumberController = TextEditingController();
  var carColorController = TextEditingController();

  List<String> carType = ["uber-car", "uber-x", "uber-bike"];
  String? selectedCarType;

  saveCarInfo() {
    Map driverCarInfoMap = {
      "type": selectedCarType,
      "carModel": carModelController.text.trim(),
      "carColor": carColorController.text.trim(),
      "carNumber": carNumberController.text.trim(),
    };

    DatabaseReference driverRef =
        FirebaseDatabase.instance.ref().child("drivers");
    driverRef
        .child(currentFirebaseUser!.uid)
        .child("car_details")
        .set(driverCarInfoMap);

    Fluttertoast.showToast(msg: "Car info added");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 21, bottom: 21, left: 25, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 150,
              ),

              const Text(
                "Fill Car Details",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              //for Car Type
              DropdownButton(
                  dropdownColor: Colors.black54,
                  isExpanded: true,
                  hint: const Text(
                    "Please Choose Vehical Model",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  items: carType.map((car) {
                    return DropdownMenuItem(
                      value: car,
                      child: Text(
                        car,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  value: selectedCarType,
                  onChanged: (newValue) {
                    setState(() {
                      selectedCarType = newValue.toString();
                    });
                  }),

              const SizedBox(
                height: 10,
              ),

              //for Car Model
              TextField(
                controller: carModelController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  labelText: "vehicalModel",
                  labelStyle: const TextStyle(color: Colors.grey),
                  hintText: "Enter Your Vehical's Model",
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
                    borderRadius: BorderRadius.circular(20),
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

              //for Car Number
              TextField(
                controller: carNumberController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  labelText: "vehicalNumber",
                  labelStyle: const TextStyle(color: Colors.grey),
                  hintText: "Enter Your Vehical's Number",
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
                    borderRadius: BorderRadius.circular(20),
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

              //for Car Color
              TextField(
                controller: carColorController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  labelText: "vehicalColor",
                  labelStyle: const TextStyle(color: Colors.grey),
                  hintText: "Enter Your Vehical's Color",
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
                    borderRadius: BorderRadius.circular(20),
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

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  if (carColorController.text.isNotEmpty &&
                      carNumberController.text.isNotEmpty &&
                      carModelController.text.isNotEmpty &&
                      (selectedCarType != null)) {
                    saveCarInfo();
                  } else {
                    Fluttertoast.showToast(msg: "Enter Each Field");
                  }
                },
                child: const Text(
                  "Create Account",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
