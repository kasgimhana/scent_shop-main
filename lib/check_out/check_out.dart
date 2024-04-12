import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scent_shop/constants/routes.dart';
import 'package:scent_shop/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:scent_shop/models/product_model/product_model.dart';
import 'package:scent_shop/provider/app_provider.dart';
import 'package:scent_shop/screens/custom_bottem/custom_bottem_nav.dart';
import 'package:scent_shop/screens/oder_screen/oder_screen.dart';
import 'package:scent_shop/widgets/primary_button/primary_button.dart';

class Checkout extends StatefulWidget {
  final ProductModel singleProduct;

  const Checkout({super.key, required this.singleProduct});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  int groupValue = 1;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Checkout",
          style: TextStyle(
            color: Colors.black,
          ), // TextStyle
        ), // Text
      ), // AppBar
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 36.0,
            ), // SizedBox
            Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Colors.blue,
                  width: 3.0,
                ),
              ),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value as int; // Cast value to int
                      });
                    },
                  ),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12.0,
                  ),
                  const Text(
                    "cash on delivery",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24.0,
            ), // SizedBox
            Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Colors.blue,
                  width: 3.0,
                ),
              ),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value as int; // Cast value to int
                      });
                    },
                  ),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12.0,
                  ),
                  const Text(
                    "pay Online",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            PrimaryButton(
              title: "Continue",
              onPressed: () async {
                appProvider.clearBuyProduct();
                appProvider.addBuyProduct(widget.singleProduct);

                bool value = await FirebaseFirestoreHelper.instance
                    .uploadOrderedProductFirebase(appProvider.getBuyProductList,
                        context, groupValue == 1 ? "Cash on delivery" : "Paid");
                if (value) {
                  Future.delayed(const Duration(seconds: 2), () {
                    Routes.instance.push(
                      widget: const OrderScreen(),
                      context: context,
                    );
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for primary button (assuming it's defined somewhere)
// Widget PrimaryButton({required String title, required VoidCallback onPressed}) {
  // Your button implementation
// }
