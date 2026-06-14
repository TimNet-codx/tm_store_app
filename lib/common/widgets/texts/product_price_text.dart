import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tm_store_app/provider/cart_provider.dart';

class TProductPriceText extends ConsumerWidget {
  const TProductPriceText({
    super.key, this.item, this.currencySign = '\$', required this.price, this.maxLines = 1,  this.isLarge = false, this.lineThrough = false,
  });

 final String currencySign, price;
 final int maxLines;
 final bool isLarge;
 final bool lineThrough;
 final dynamic item; 

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final cartData = ref.watch(cartProvider);

    return Text(
          //'\$35.5',
          currencySign + price,
          maxLines: maxLines  ,
          overflow: TextOverflow.ellipsis,
          // style: Theme.of(context).textTheme.headlineMedium,
          style: isLarge
           ? Theme.of(context).textTheme.headlineMedium!.apply(decoration: lineThrough ? TextDecoration.lineThrough : null)
           : Theme.of(context).textTheme.titleLarge!.apply(decoration: lineThrough ? TextDecoration.lineThrough : null)

        );

  }
}
