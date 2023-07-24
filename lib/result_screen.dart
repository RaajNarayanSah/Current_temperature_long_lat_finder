import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weather_task/components/reusableTextField.dart';
import 'package:weather_task/services/services.dart';
import 'package:weather_task/register_screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  TextEditingController resultController = TextEditingController();
  String tempC = "";
  String tempF = "";
  String long = "";
  String lat = "";
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Weather Today",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          ReusabletextField(
              labelText: "City Name", controller: resultController),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: OutlinedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3))),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueAccent)),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  var res =
                      await ApiServices().getWeather(resultController.text);
                  if (res == null) {
                    setState(() {
                      final snackBar = const SnackBar(
                          content: Text('Please enter a valid city name'));

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      isLoading = false;
                    });
                  } else {
                    setState(() {
                      tempC = res.current.tempC.toString() + "°C";
                      tempF = res.current.tempF.toString() + "°F";
                      long = res.location.lon.toString();
                      lat = res.location.lat.toString();
                      isLoading = false;
                    });
                  }
                  // formkey.currentState!.validate();
                },
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'Show Results',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      )),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "Temperatue in centigrade:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "$tempC",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    const Text(
                      "Temperatue in Fahrenhiet:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "$tempF",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    const Text(
                      "Latitide:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      lat,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    const Text(
                      "Longitude:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      long,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: OutlinedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black)),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()),
                            (route) => false);

                        // formkey.currentState!.validate();
                      },
                      child: const Text(
                        'Refresh',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
