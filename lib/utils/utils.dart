import 'package:flutter/material.dart';

Widget flutterLogo() {
  return FlutterLogo(
    duration: Duration(seconds: 5),
  );
}

Widget textFormField({
  TextEditingController? controller,
  FocusNode? focusNode,
  String? hintText,
  double? size,
}) {
  return SizedBox(
    height: 45.0,
    child: TextFormField(
      controller: controller,
      focusNode: focusNode,
      cursorColor: Colors.blue,
      cursorWidth: 1,
      // undoController: ,
      toolbarOptions: ToolbarOptions(
        copy: true,
        cut: true,
        paste: true,
        selectAll: true,
      ),
      style: TextStyle(color: Colors.blue, fontSize: size),

      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: hintText,
          hintStyle:
              TextStyle(color: Colors.blue, fontWeight: FontWeight.normal),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue, width: 1)),
          focusColor: Colors.blue,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 1),
              borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1, color: Colors.red))),
    ),
  );
}

Widget button(
    {String? title, double? size, FontWeight? fontWeight, Color? color}) {
  return TextButton(
      isSemanticButton: true,
      onPressed: () {},
      child: Text(
        title ?? "Next",
        style: TextStyle(
            fontSize: size ?? 18.0,
            color: color ?? Colors.blue,
            fontWeight: fontWeight ?? FontWeight.normal),
      ));
}

Widget text({required String title, double? size, color, style}) {
  return Text(
    title,
    style: style ??
        TextStyle(
          color: color ?? Colors.black,
          fontSize: size ?? 16.0,
        ),
  );
}
