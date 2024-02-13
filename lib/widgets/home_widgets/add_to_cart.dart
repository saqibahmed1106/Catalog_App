import 'package:catalog_app/core/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:catalog_app/models/catalog.dart';
import 'package:catalog_app/models/cart.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:catalog_app/widgets/themes.dart';

class AddToCart extends StatelessWidget{
  final Item catalog;
  AddToCart({
    super.key, required this.catalog,
  });

  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [AddMutation, RemoveMutation]);
    final CartModel _cart = (VxState.store as MyStore).cart;

    bool isInCart = _cart.items.contains(catalog) ?? false;
    return ElevatedButton(
      onPressed: () {
        if(!isInCart) {
          AddMutation(catalog);
        }
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              MyTheme.darkBluishColor),
          shape: MaterialStateProperty.all(StadiumBorder())),
      child: isInCart ? Icon(Icons.done,color: Colors.white,) : Icon(CupertinoIcons.cart_badge_plus, color: Colors.white,));
  }
}