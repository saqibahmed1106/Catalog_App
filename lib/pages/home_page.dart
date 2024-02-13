import 'package:catalog_app/core/store.dart';
import 'package:catalog_app/models/cart.dart';
import 'package:catalog_app/models/catalog.dart';
import 'package:catalog_app/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:velocity_x/velocity_x.dart';
import 'package:catalog_app/widgets/home_widgets/catalog_header.dart';
import 'package:catalog_app/widgets/home_widgets/catalog_list.dart';
import 'package:catalog_app/widgets/themes.dart';
import 'package:http/http.dart' as http;




class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // ____________________________________________________________________
  // It is not find yet bcz author delete this api :                    |
  // final url = "https://api.jsonbin.io/b/604dbddb683e7e079c4eefd3";   |
  // ____________________________________________________________________

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    final catalogJson =
        await rootBundle.loadString("assets/files/catalog.json");

    // __________________________________________________
    // If api is not deleted then its work properly :   |
    // final response = await http.get(Uri.parse(url)); |
    // final catalogJson = response.body;               |
    // __________________________________________________

    final decodedData = jsonDecode(catalogJson);
    var productData = decodedData["products"];
    CatalogModel.items =
        List.from(productData).map<Item>((item) => Item.fromMap(item)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _cart = (VxState.store as MyStore).cart;
    return Scaffold(
        backgroundColor: MyTheme.creamColor,
        floatingActionButton: VxBuilder(
          mutations: {AddMutation, RemoveMutation},
          builder: (context, dynamic _, VxStatus? status) => FloatingActionButton(
            onPressed: ()
          =>Navigator.pushNamed(context, MyRoutes.cartRoute),
            backgroundColor: MyTheme.darkBluishColor,
          foregroundColor: Colors.white,
          child: Icon(CupertinoIcons.cart),
          ).badge(color: MyTheme.creamColor, size: 22, count: _cart.items.length, textStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          )),
        ),
        body: SafeArea(
          child: Container(
            padding: Vx.m32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CatalogHeader(),
                if (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
                  CatalogList().py16().expand()
                else
                  CircularProgressIndicator().centered().expand(),
              ],
            ),
          ),
        ));
  }
}

