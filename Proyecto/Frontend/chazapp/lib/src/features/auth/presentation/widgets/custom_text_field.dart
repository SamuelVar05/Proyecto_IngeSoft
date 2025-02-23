import 'package:flutter/material.dart';
import 'package:chazapp/src/config/themes/unchaza_theme.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomTextField extends StatefulWidget {
  final String name;
  final String text;
  final String hint;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool isPassword;
  final TextEditingController? controller;
  final void Function(String?)? onChanged;

  const CustomTextField({
    super.key,
    required this.text,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.isPassword = false,
    this.controller,
    required this.name,
    this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            style: UNChazaTheme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          FormBuilderTextField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: widget.isPassword ? obscureText : false,
            name: widget.name,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            validator: widget.validator,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              errorStyle: UNChazaTheme.textTheme.bodySmall,
              hintText: widget.hint,
              hintStyle: UNChazaTheme.textTheme.labelSmall,
              filled: true,
              fillColor: UNChazaTheme.white,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide:
                    const BorderSide(color: UNChazaTheme.lightGrey, width: 0.8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide:
                    const BorderSide(color: UNChazaTheme.deepGrey, width: 1.6),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide:
                    const BorderSide(color: UNChazaTheme.red, width: 1.6),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide:
                    const BorderSide(color: UNChazaTheme.red, width: 1.6),
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                        color: UNChazaTheme.darkGrey,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
