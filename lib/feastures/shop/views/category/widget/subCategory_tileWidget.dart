import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubcategoryTilewidget extends StatelessWidget {
  final String image;
  final String name;

  const SubcategoryTilewidget({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[200]
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(image, fit: BoxFit.cover),
          )
        ),
       const SizedBox(height: 8,),
        SizedBox(
          width: 110,
           child: Text(name, maxLines: 2, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, style: GoogleFonts.roboto(
            fontSize: 12,
            fontWeight: FontWeight.w600,
           ),),
        )
      ],
    );
  }
}