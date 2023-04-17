import 'package:flutter/material.dart';

import '../theming.dart';

class SwitchTextListTile extends StatelessWidget {
  const SwitchTextListTile({
    Key? key,
    required this.title,
    required this.switchValue,
    required this.onSwitchChanged,
    required this.textValue,
    required this.onTextChanged,
    this.errorText,
  }) : super(key: key);

  final String title;
  final bool switchValue;
  final Function onSwitchChanged;
  final String textValue;
  final Function onTextChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0 - 4.0, right: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 60.0,
            child: Switch(
              value: switchValue,
              onChanged: (bool value) => onSwitchChanged(value),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onSwitchChanged(!switchValue),
              child: Container(
                color: Colors.transparent,
                height: 48.0,
                child: Row(
                  children: [
                    const SizedBox(width: 6.0),
                    Text(title),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 56.0,
            child: TextFormField(
              enabled: switchValue,
              keyboardType: TextInputType.number,
              initialValue: textValue,
              onChanged: (value) => onTextChanged(value),
              textAlign: TextAlign.center,
              style: TextStyle(color: switchValue ? Colors.white : Colors.white24),
              decoration: InputDecoration(
                filled: true,
                fillColor: MaterialStateColor.resolveWith((states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.transparent;
                  }
                  return DARK35;
                }),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                errorText: errorText,
                errorStyle: const TextStyle(height: 0, fontSize: 0),
                contentPadding: const EdgeInsets.only(top: 0.0, bottom: 0.0, left: 4.0, right: 2.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
