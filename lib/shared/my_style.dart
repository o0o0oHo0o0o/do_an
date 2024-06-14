import 'package:flutter/material.dart';
import 'package:weather/models/constants.dart';
Constants myConstants = Constants();

Widget buildTextFormField({
  TextEditingController? controller,
  required String labelText,
  required String hintText,
  required Icon icon,
  IconButton? suf_icon,
  bool obscureText = true,
  String? Function(String?)? validator = null,
}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    obscureText: obscureText,
    decoration: InputDecoration(
      prefixIcon: icon,
      suffixIcon: suf_icon,
      labelText: labelText,
      hintText: hintText,
      labelStyle: TextStyle(color: myConstants.textColor),
      hintStyle: TextStyle(color: myConstants.textColor),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: EdgeInsets.fromLTRB(8, 16, 8, 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: BorderSide(color: myConstants.secondaryColor ?? Colors.red),

      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: BorderSide(color: myConstants.textColor ?? Colors.grey),
      ),
    ),
  );
}

SnackBar buildSnackBar({
  required BuildContext context,
  required String content,
}){
  return SnackBar(
    content: Text(content, style: TextStyle(color: Colors.white)),
    backgroundColor: Colors.deepOrange,
    duration: Duration(seconds: 5),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    action: SnackBarAction(
      label: "Close",
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
      textColor: Colors.white,
    ),
  );
}

ElevatedButton buildElevation({
  required void Function()? onPressed,
  required String content
}){
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      elevation: 0,
      primary: Colors.transparent,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
        side: BorderSide(color: myConstants.textColor??Colors.grey),
      ),
    ),
    child: Text(
      content,
      style: TextStyle(
        color: myConstants.textColor,
        fontSize: 16,
      ),
    ),
  );
}

IconButton buildIconButton({
  required void Function()? onPressed,
  required Icon icon,
  required String content
}){
  return IconButton(
    onPressed: onPressed,
    icon: Row(
      children: [
        icon,
        SizedBox(width: 4),
        Text(content),
        SizedBox(width: 4),
      ],
    ),
  );
}