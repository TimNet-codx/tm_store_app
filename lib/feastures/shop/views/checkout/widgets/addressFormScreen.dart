import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tm_store_app/common/widgets/appbar/appbar.dart';
import 'package:tm_store_app/utils/constants/colors.dart';

class AddressFormScreen extends StatelessWidget {
  final bool isUpdate;
  const AddressFormScreen({super.key, this.isUpdate = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   title: Text(
      //     isUpdate ? 'Update Address' : 'Add new Address',
      //     style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      //   ),
      //   centerTitle: true,
      // ),
      appBar: TAppBar(
        showBackArrow: true,
       // title: Text("Checkout", style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.black),),
          title: Text(
          isUpdate ? 'Update Address' : 'Add new Address',
          style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTextField(Icons.person_outline, 'Name', isUpdate ? 'Timothy Johnson' : ''),
                    const SizedBox(height: 16),
                    _buildTextField(Icons.phone_android_outlined, 'Phone Number', isUpdate ? '08168172808' : ''),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildTextField(Icons.home_outlined, 'Street', isUpdate ? '15 Mark' : '')),
                        const SizedBox(width: 16),
                        Expanded(child: _buildTextField(Icons.qr_code_scanner, 'Postal Code', isUpdate ? '56457' : '')),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildTextField(Icons.location_city_outlined, 'City', isUpdate ? 'Ilorin' : '')),
                        const SizedBox(width: 16),
                        Expanded(child: _buildTextField(Icons.timeline_outlined, 'State', isUpdate ? 'Kwara' : '')),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(Icons.public, 'Country', isUpdate ? 'Nigeria' : ''),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                onPressed: () {},
                child: const Text('Save', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(IconData icon, String label, String initialValue) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}