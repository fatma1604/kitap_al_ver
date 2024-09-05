
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/configuration/core/nebox.dart';



class MyTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Widget prefixIcon;
  final String hintText;
  final bool obscureText;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool? autocorrect;

  const MyTextField({
    super.key,
    this.controller,
    required this.prefixIcon,
    required this.hintText,
    this.obscureText = false,
    this.onSaved,
    this.validator,
    this.keyboardType,
    this.autocorrect,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return NeuBox(
      width: mediaQuery.width * 0.8,
      height: mediaQuery.height * 0.01,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          autocorrect: widget.autocorrect ?? false,
          keyboardType: widget.keyboardType,
          onSaved: widget.onSaved,
          validator: widget.validator,
          controller: widget.controller,
          obscureText: _obscureText,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 243, 229, 229),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 63, 63, 63)),
            ),
            filled: true,
            fillColor: Colors.transparent,
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              shadows: [
                BoxShadow(
                  color: Color.fromARGB(255, 252, 248, 248),
                  blurRadius: 3,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: _toggleObscureText,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
