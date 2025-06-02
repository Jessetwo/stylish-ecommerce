import 'package:flutter/material.dart';

class MyTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String title;
  final Icon? pre;
  final Icon? sur;
  final bool obscureText; // To determine if this is a password field

  const MyTextfield({
    super.key,
    required this.controller,
    required this.hint,
    required this.title,
    this.pre,
    this.sur,
    this.obscureText = false, // Default to false (not obscured)
  });

  @override
  State<MyTextfield> createState() => _MyTextfieldState();
}

class _MyTextfieldState extends State<MyTextfield> {
  late bool _obscureText; // Local state for toggling visibility

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText; // Initialize with the widget's value
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText, // Use local state for obscuring text
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: widget.hint,
        label: Text(widget.title),
        prefixIcon: widget.pre,
        suffixIcon:
            widget
                    .obscureText // Only show toggle for password field
                ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText; // Toggle visibility
                    });
                  },
                )
                : widget.sur, // Use provided suffixIcon for non-password fields
      ),
    );
  }
}
