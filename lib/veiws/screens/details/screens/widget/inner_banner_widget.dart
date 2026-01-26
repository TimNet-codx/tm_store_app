 import 'package:flutter/material.dart';
 
class InnerBannerWidget extends StatelessWidget {
  final String banner;
  const InnerBannerWidget({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 170,
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: banner.startsWith('http') 
            ? Image.network(
                banner,
                fit: BoxFit.cover,
                // Placeholder while loading
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                // Handle broken links
                errorBuilder: (context, error, stackTrace) => 
                    const Icon(Icons.broken_image, size: 50),
              )
            : Image.asset(banner, fit: BoxFit.cover),
        ),
      ),
    );
  }
}