import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../configuration.dart';

class OutlineTextView extends StatelessWidget {
  final String hintText;
  final Color borderColor;
  final bool readOnly;
  final Function(String param) customFunction;
  final TextInputType type;
  final TextEditingController controller;
  final List<TextInputFormatter> customFormat;
  const OutlineTextView(
      {Key key,
      @required this.hintText,
      this.controller,
      this.readOnly = false,
      this.type = TextInputType.text,
      this.borderColor = colorPrimaryDark,
      this.customFormat,
      this.customFunction = _dummyOnTap})
      : assert(customFunction != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      keyboardType: type,
      inputFormatters: customFormat,
      decoration: new InputDecoration(
          prefixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.all(8.0),
          // labelText: hintText,
          hintText: hintText,
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: borderColor)),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      onFieldSubmitted: (val) {
        customFunction(val);
      },
      onChanged: (String val) {
        customFunction(val);
      },
    );
  }

  static dynamic _dummyOnTap(String param) {}
}
