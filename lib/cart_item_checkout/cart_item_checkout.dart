import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scent_shop/constants/routes.dart';
import 'package:scent_shop/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:scent_shop/provider/app_provider.dart';
import 'package:scent_shop/screens/custom_bottem/custom_bottem_nav.dart';
import 'package:scent_shop/stripe_helper/stripe_helper.dart';
import 'package:scent_shop/widgets/primary_button/primary_button.dart';

class CartItemCheckout extends StatefulWidget {
  const CartItemCheckout({super.key});

  @override
  State<CartItemCheckout> createState() => _CartItemCheckoutState();
}

class _CartItemCheckoutState extends State<CartItemCheckout> {
  int groupValue = 1;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "CartItem Checkout",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
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
                  color: Theme.of(context).primaryColor,
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
                        groupValue = value!;
                      });
                    },
                  ), // Radio
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12.0,
                  ), // SizedBox
                  const Text(
                    "Cash on Delivery",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ), // Text
                ],
              ), // Row
            ), // Container
            const SizedBox(
              height: 24.0,
            ), // SizedBox
            Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
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
                        groupValue = value!;
                      });
                    },
                  ), // Radio
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12.0,
                  ), // SizedBox
                  const Text(
                    "Pay Online",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ), // Text
                ],
              ), // Row
            ), // Container
            const SizedBox(
              height: 24.0,
            ), // SizedBox
            PrimaryButton(
              title: "Continue",
              onPressed: () async {
                if (groupValue == 1) {
                  bool value = await FirebaseFirestoreHelper.instance
                      .uploadOrderedProductFirebase(
                    appProvider.getBuyProductList,
                    context,
                    "Cash on delivery",
                  );

                  appProvider.clearBuyProduct();
                  if (value) {
                    Future.delayed(const Duration(seconds: 2), () {
                      Routes.instance
                          .push(widget: const CustomBottem(), context: context);
                    });
                  }
                } else {
                  // print("Hello");
                  // int value = double.parse(
                  //         appProvider.totalPriceBuyProduct().toString())
                  //     .round()
                  //     .toInt();
                  // String totalPrice = (value * 100).toString();
                  // await StripeHelper.instance
                  //     .makePayment(totalPrice.toString(), context);
                }
              },
            ), // PrimaryButton
          ],
        ), // Column
      ), // Padding
    ); // Scaffold
  }
}
