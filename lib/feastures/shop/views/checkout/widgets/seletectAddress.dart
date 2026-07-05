import 'package:flutter/material.dart';
import 'package:tm_store_app/feastures/personalization/views/account/address/add_new_address.dart';
import 'package:tm_store_app/utils/constants/colors.dart';
import 'package:tm_store_app/utils/helpers/helper_functions.dart';

class SelectAddress extends StatelessWidget {
  const SelectAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Container(
      height: 300,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(color: dark ? TColors.dark : TColors.light, borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 24),
          const Text('Select Address', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildAddressCard(context),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2563EB), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddAndUpdateAddressScreen(isUpdate: false)));
              },
              child: const Text('Add new address', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildAddressCard(context) {
  final dark = THelperFunctions.isDarkMode(context);
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: dark ? TColors.dark : TColors.light, borderRadius: BorderRadius.circular(16)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Radio(value: true, groupValue: true, onChanged: (v) {}, activeColor: TColors.primary),
        const SizedBox(width: 8),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Timothy Johnson', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), const SizedBox(height: 8), Text('(0816) 817 2808', style: TextStyle(color: Colors.grey[600])), const SizedBox(height: 4), Text('15 Mark, Ilorin, Kwara 56457, Nigeria', style: TextStyle(color: Colors.grey[600]))])),

        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddAndUpdateAddressScreen(isUpdate: true)));
          },
          child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: TColors.primary, shape: BoxShape.circle), child: const Icon(Icons.edit, color: Colors.white, size: 16)),
        ),
      ],
    ),
  );
}
