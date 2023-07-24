import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReusabletextField extends StatelessWidget {
  ReusabletextField(
      {super.key,
      this.hintText,
      this.suffixIcon,
      this.validator,
      required this.controller,
      this.maxLength,
      required this.labelText,
      this.keyboardType,
      this.formatter,
      this.onTap});
  String? hintText;
  String labelText;
  int? maxLength;

  IconData? suffixIcon;
  TextInputType? keyboardType;
  String? Function(String?)? validator;
  TextEditingController controller = TextEditingController();
  List<TextInputFormatter>? formatter;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 15,
        left: 15,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height / 11,
        width: MediaQuery.of(context).size.width / 1.01,
        // color: Colors.white,
        child: TextFormField(
          onTap: onTap,
          inputFormatters: formatter,
          keyboardType: keyboardType,
          maxLength: maxLength,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.black87, fontSize: 18),
              labelText: labelText,
              alignLabelWithHint: false,
              counterText: '',
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.only(left: 10),
              hoverColor: Colors.white,
              focusColor: Colors.white,
              prefixIconColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              // disabledBorder: OutlineInputBorder(
              //     borderSide: BorderSide(color: Colors.redAccent)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              hintText: hintText,
              suffixIcon: Icon(suffixIcon),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        ),
      ),
    );
  }
}
