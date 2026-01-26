import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tm_store_app/utils/constants/sizes.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.validator,
    this.isPassword = false,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? Function(String?) validator;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
          suffixIcon: isPassword ? const Icon(Iconsax.eye_slash) : null,
        ),
      ),
    );
  }
}
