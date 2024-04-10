import 'package:flutter/material.dart';
import 'package:scent_shop/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:scent_shop/models/order_model/order_model.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Orders",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestoreHelper.instance.getUserOrder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            ); // Center
          }
          if (snapshot.data!.isEmpty ||
              snapshot.data == null ||
              !snapshot.hasData) {
            return const Center(
              child: Text("No orders Found"),
            ); // Center
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 70.0),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              padding: const EdgeInsets.all(12.0),
              itemBuilder: (context, index) {
                OrderModel orderModel = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    tilePadding: EdgeInsets.zero,
                    collapsedShape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue, width: 2.3)),
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue, width: 2.3)),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                          child: Image.network(
                            orderModel.products[0].image,
                          ), // Image.network
                        ), // Container
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  orderModel.products[0].name,
                                  style: const TextStyle(),
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ), // SizedBox
                                orderModel.products.length > 1
                                    ? Column(
                                        children: [
                                          Text(
                                            "Quantity: ${orderModel.products[0].qty.toString()}",
                                            style: const TextStyle(
                                              fontSize: 12.0,
                                            ), // TextStyle
                                          ), // Text
                                          const SizedBox(
                                            height: 12.0,
                                          ), // SizedBox
                                        ],
                                      )
                                    : SizedBox.fromSize(),
                                Text(
                                  "Total Price: \$${orderModel.payment.toString()}",
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                  ), // TextStyle
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                Text(
                                  "Order Status: ${orderModel.status}",
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                  ), // TextStyle
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    children: orderModel.products.length > 1
                        ? [
                            const Text("Details"),
                            const Divider(color: Colors.blue),
                            ...orderModel.products.map((singleProduct) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 12.0, top: 6.0),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Container(
                                          height: 80,
                                          width: 80,
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.5),
                                          child: Image.network(
                                            singleProduct.image,
                                          ), // Image.network
                                        ), // Container
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  singleProduct.name,
                                                  style: const TextStyle(),
                                                ),
                                                const SizedBox(
                                                  height: 12.0,
                                                ), // SizedBox
                                                orderModel.products.length > 1
                                                    ? SizedBox.fromSize()
                                                    : Column(
                                                        children: [
                                                          Text(
                                                            "Quantity: ${singleProduct.qty.toString()}",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12.0,
                                                            ), // TextStyle
                                                          ), // Text
                                                          const SizedBox(
                                                            height: 12.0,
                                                          ), // SizedBox
                                                        ],
                                                      ),
                                                Text(
                                                  "Price: \$${singleProduct.price.toString()}",
                                                  style: const TextStyle(
                                                    fontSize: 12.0,
                                                  ), // TextStyle
                                                ),
                                                const Divider(
                                                    color: Colors.blue),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ]
                        : [],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
