import 'package:flutter/material.dart';
import 'package:tm_store_app/common/widgets/custom_shape/container/circular_container.dart';
import 'package:tm_store_app/common/widgets/custom_shape/curved_edges/curved_edges_widget.dart';
import 'package:tm_store_app/utils/constants/colors.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({super.key, required this.child });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      child: Container(
        color: TColors.primary,
        child: Stack(
          children: [ 
            // ignore: deprecated_member_use
            Positioned(top: -150, right: -250, child: TCirularContainer(backgroundColor: TColors.textWhite.withOpacity(0.1))),
            // ignore: deprecated_member_use
            Positioned(top: 100, right: -300, child: TCirularContainer( backgroundColor: TColors.textWhite.withOpacity(0.1))),
            child, 
          ],
        ),
      )
    
    );
  }
}
