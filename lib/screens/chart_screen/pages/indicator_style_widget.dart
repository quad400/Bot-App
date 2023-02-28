import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../chart/entity/k_line_entity.dart';
import '../body.dart';

Widget buildStyleDropDown(List<int> items, int currentItem, bool reset) {
  return StatefulBuilder(builder: (context, setState) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: Colors.white54,
        border: Border.all(color: Colors.black45),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            focusColor: Colors.transparent,
            // itemHeight: ,
            elevation: 0,
            isDense: true,
            value: currentItem,
            items: items
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e.toString(),
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ))
                .toList(),
            onChanged: (item) => setState(() {
                  currentItem = reset == true ? currentItem : item as int;
                })),
      ),
    );
  });
}

Widget buildDropDown(List<String> items, String? currentItem, bool reset) {
  return StatefulBuilder(builder: (context, setState) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: Colors.white54,
        border: Border.all(color: Colors.black45),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            focusColor: Colors.transparent,
            // itemHeight: ,
            elevation: 0,
            isDense: true,
            value: currentItem,
            items: items
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ))
                .toList(),
            onChanged: (item) => setState(() {
                  currentItem = reset == true ? currentItem : item as String?;
                })),
      ),
    );
  });
}
Widget buildInputFieldDouble(double value, TextEditingController controller) {
  return SizedBox(
    height: 30,
    width: 70,
    child: TextField(
      controller: controller,
      style: TextStyle(
          fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.7)),
      keyboardType: TextInputType.number,
      onSubmitted: (numb) {
        // int numb = int.parse(controller.text);
        value = double.parse(numb);
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
        hintText: '$value',
        hintStyle: TextStyle(
            fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.7)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.black54.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(color: Colors.black87.withOpacity(0.4)),
          gapPadding: 10,
        ),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(3),
        FilteringTextInputFormatter.digitsOnly
      ],
    ),
  );
}
Widget buildInputField(int value, TextEditingController controller) {
  return SizedBox(
    height: 30,
    width: 70,
    child: TextField(
      controller: controller,
      style: TextStyle(
          fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.7)),
      keyboardType: TextInputType.number,
      onSubmitted: (numb) {
        // int numb = int.parse(controller.text);
        value = int.parse(numb);
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
        hintText: '$value',
        hintStyle: TextStyle(
            fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.7)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.black54.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(color: Colors.black87.withOpacity(0.4)),
          gapPadding: 10,
        ),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(3),
        FilteringTextInputFormatter.digitsOnly
      ],
    ),
  );
}

Widget buildListInputField(List<int> value, TextEditingController controller) {
  return SizedBox(
    height: 30,
    width: 70,
    child: TextField(
      controller: controller,
      style: TextStyle(
          fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.7)),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
        hintText: '$value',
        hintStyle: TextStyle(
            fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.7)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.black54.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(color: Colors.black87.withOpacity(0.4)),
          gapPadding: 10,
        ),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(3),
        FilteringTextInputFormatter.digitsOnly
      ],
      // textAlign: TextAlign.center,
    ),
  );
}

TextButton textButtonIndicatorBuilder(List<KLineEntity>? datas,
    BuildContext context, Function() onPressed, String title) {
  return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        elevation: 0,
        fixedSize: const Size(80, 40),
        backgroundColor: Colors.grey.shade300,
        primary: Colors.black,
        onSurface: Colors.black,
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ));
}

Widget periodRow(String title, int inputs, TextEditingController controller) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black.withOpacity(0.5)),
      ),
      const SizedBox(
        width: 4,
      ),
      buildInputField(inputs, controller),
      
    ],
  );
}

Widget doubleRowPeriod(String title, double inputs, TextEditingController controller) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black.withOpacity(0.5)),
      ),
      const SizedBox(
        width: 4,
      ),
      buildInputFieldDouble(inputs, controller),
      
    ],
  );
}

Row sourceRow(
    String title, List<String> valueList, String selected, bool reset) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black.withOpacity(0.5)),
      ),
      buildDropDown(valueList, selected, reset),
    ],
  );
}


