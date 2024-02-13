import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';


class CatalogImage extends StatelessWidget {
  final String image;

  const CatalogImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    // after p8.color(MyTheme.creamColor)
    return Image.network(image).box.rounded.p8.make().p16().wPCT(context: context, widthPCT: context.isMobile? 40:20);
  }
}
