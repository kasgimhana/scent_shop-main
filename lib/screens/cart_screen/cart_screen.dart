import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scent_shop/cart_item_checkout/cart_item_checkout.dart';
import 'package:scent_shop/constants/constants.dart';
import 'package:scent_shop/constants/routes.dart';
import 'package:scent_shop/provider/app_provider.dart';
import 'package:scent_shop/screens/cart_screen/widgets/single_cart_item.dart';
import 'package:scent_shop/widgets/primary_button/primary_button.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "LKR${appProvider.totalPrice().toString()}",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              PrimaryButton(
                  title: "Check out",
                  onPressed: () {
                    appProvider.clearBuyProduct();
                    appProvider.addBuyProductCart();
                    appProvider.clearCart();
                    if (appProvider.getBuyProductList.isEmpty) {
                      showMessages("Cart is empty");
                    }
                    Routes.instance.push(
                        widget: const CartItemCheckout(), context: context);
                  })
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Cart Screen",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: appProvider.getCartProductList.isEmpty
          ? const Center(
              child: Text("Cart Empty"),
            )
          : ListView.builder(
              itemCount: appProvider.getCartProductList.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (ctx, index) {
                return SingleCartItem(
                  singleProduct: appProvider.getCartProductList[index],
                );
              }),
    );
  }
}
