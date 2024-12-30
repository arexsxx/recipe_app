import 'package:flutter/material.dart';

class CustomTextInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String hint;
  final String? Function(String?) validator;

  const CustomTextInput({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    required this.validator,
  });

  @override
  _CustomTextInputState createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4.0),
        TextFormField(
          obscureText: widget.label.toLowerCase() == "password" ||
                  widget.label.toLowerCase() == "confirm password"
              ? _obscureText
              : false,
          controller: widget.controller,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 1.5),
                borderRadius: BorderRadius.circular(8.0)),
            hintText: widget.hint,
            prefixIcon: Icon(widget.icon),
            suffixIcon: widget.label.toLowerCase() == "password" ||
                    widget.label.toLowerCase() == "confirm password"
                ? IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: widget.validator,
        ),
        // const SizedBox(height: 12.0),
      ],
    );
  }
}
