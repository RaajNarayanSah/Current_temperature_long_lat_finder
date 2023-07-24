import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_task/components/reusableTextField.dart';
import 'package:weather_task/result_screen.dart';
import 'package:weather_task/services/services.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, this.restorationId});
  final String? restorationId;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with RestorationMixin {
  final formkey = GlobalKey<FormState>();
  List<String> genderList = <String>['Male', 'Female', 'Prefer not to say'];
  TextEditingController numberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  String district = "";
  String state = "";
  bool isLoading = false;
  String selectedGender = 'Male';

  DropdownButton<String> genderDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String gender in genderList) {
      var newItem = DropdownMenuItem(
        child: Text(gender),
        value: gender,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton(
      value: selectedGender,
      items: dropdownItems,
      onChanged: (value) async {
        selectedGender = value!;
        setState(() {});
      },
    );
  }

  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(2021, 7, 25));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(1990),
          lastDate: DateTime(2050),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        dobController.text =
            '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text(
        //       'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        // ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
          title: const Text(
            "Register",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          backgroundColor: Colors.black),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                ReusabletextField(
                  labelText: " Mobile Number",
                  formatter: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  controller: numberController,
                  validator: (value) {
                    if (value!.isEmpty || numberController.text.isEmpty) {
                      return "Enter mobile number";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ReusabletextField(
                  labelText: "Full Name",
                  maxLength: 50,
                  formatter: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                  ],
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty || nameController.text.isEmpty) {
                      return "Enter name";
                    } else {
                      return null;
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13.8, bottom: 25),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 14,
                    width: MediaQuery.of(context).size.width / 1.08,
                    // color: Colors.red,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.white),
                      // color: Colors.red
                    ),
                    child: Center(child: genderDropdown()),
                  ),
                ),
                ReusabletextField(
                  labelText: "DOB",
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    _restorableDatePickerRouteFuture.present();
                  },
                  controller: dobController,
                  suffixIcon: Icons.calendar_month,
                  validator: (value) {
                    if (value!.isEmpty || dobController.text.isEmpty) {
                      return "Select DOB";
                    } else {
                      return null;
                    }
                  },
                ),
                ReusabletextField(
                  labelText: "Address line 1*",
                  maxLength: 50,
                  controller: address1Controller,
                  validator: (value) {
                    if (value!.isEmpty || address1Controller.text.isEmpty) {
                      return "Enter address";
                    } else {
                      return null;
                    }
                  },
                ),
                ReusabletextField(
                  labelText: "Address line 2",
                  maxLength: 50,
                  controller: address2Controller,
                  validator: (value) {
                    if (value!.isEmpty || address2Controller.text.isEmpty) {
                      return "Enter address";
                    } else {
                      return null;
                    }
                  },
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 15, left: 15, bottom: 5, top: 5),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 11,
                        width: MediaQuery.of(context).size.width / 2,
                        child: TextFormField(
                          maxLength: 6,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: pincodeController,
                          validator: (value) {
                            if (value!.isEmpty ||
                                address2Controller.text.isEmpty) {
                              return "Enter pincode";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              counterText: '',
                              labelText: "Pin Code",
                              labelStyle: TextStyle(
                                  color: Colors.black87, fontSize: 18),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.only(top: 5, left: 10),
                              hoverColor: Colors.black38,
                              focusColor: Colors.black38,
                              prefixIconColor: Colors.black38,
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black38)),
                              // disabledBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(color: Colors.redAccent)),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black38)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 22),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 18,
                        width: MediaQuery.of(context).size.width / 2.8,
                        child: OutlinedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(3))),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black87)),
                            onPressed: () async {
                              // formkey.currentState!.validate();
                              if (pincodeController.text.isEmpty) {
                                final snackBar = const SnackBar(
                                    content:
                                        Text('Please enter a valid pincode'));

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                setState(() {
                                  isLoading = true;
                                });
                                var res = await ApiServices().getLocation(
                                    int.parse(pincodeController.text));
                                if (res == null) {
                                  setState(() {
                                    final snackBar = const SnackBar(
                                        content: Text(
                                            'Please enter a valid pincode'));

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    isLoading = false;
                                  });
                                } else {
                                  setState(() {
                                    district = res.district;
                                    state = res.state;
                                    isLoading = false;
                                  });
                                }
                              }

                              // formkey.currentState!.validate();
                            },
                            child: isLoading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    'Check',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  )),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Row(
                    children: [
                      const Text(
                        "District: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        district,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Row(
                    children: [
                      Text(
                        "State: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        state,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.08,
                    child: OutlinedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3))),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black87)),
                        onPressed: () {
                          formkey.currentState!.validate()
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ResultScreen()))
                              : null;
                        },
                        child: const Text(
                          'REGISTER',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
