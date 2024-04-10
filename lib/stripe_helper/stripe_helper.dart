// // ignore_for_file: use_build_context_synchronously

// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:scent_shop/constants/constants.dart';
// import 'package:scent_shop/constants/routes.dart';
// import 'package:scent_shop/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
// import 'package:scent_shop/provider/app_provider.dart';
// import 'package:scent_shop/screens/custom_bottem/custom_bottem_nav.dart';

// class StripeHelper {
//   static StripeHelper instance = StripeHelper();
//   Map<String, dynamic>? paymentIntent;

//   Future<void> makePayment(String amount, BuildContext context) async {
//     try {
//       paymentIntent = await createPaymentIntent(amount, 'USD');
//       var gpay = const PaymentSheetGooglePay(
//         merchantCountryCode: "GB",
//         currencyCode: "USD",
//         testEnv: true,
//       );

//       //STEP 2: Initialize Payment Sheet
//       await Stripe.instance
//           .initPaymentSheet(
//             paymentSheetParameters: SetupPaymentSheetParameters(
//               paymentIntentClientSecret:
//                   paymentIntent!['client_secret'], //Gotten from payment intent
//               style: ThemeMode.light,
//               merchantDisplayName: 'Achinthya',
//               googlePay: gpay,
//             ),
//           )
//           .then((value) {});

//       //STEP 3: Display Payment sheet
//       displayPaymentSheet(context);
//     } catch (err) {
//       showMessages(err.toString());
//     }
//   }

//   Future<void> displayPaymentSheet(BuildContext context) async {
//     AppProvider appprovider = Provider.of<AppProvider>(context, listen: false);
//     try {
//       await Stripe.instance.presentPaymentSheet().then((value) async {
//         bool value =
//             await FirebaseFirestoreHelper.instance.uploadOrderedProductFirebase(
//           appprovider.getBuyProductList,
//           context,
//           "paid",
//         );

//         appprovider.clearBuyProduct();
//         if (value) {
//           Future.delayed(const Duration(seconds: 2), () {
//             Routes.instance
//                 .push(widget: const CustomBottem(), context: context);
//           });
//         }
//       });
//     } catch (e) {
//       showMessages(e.toString());
//     }
//   }

//   Future<Map<String, dynamic>> createPaymentIntent(
//       String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': amount,
//         'currency': currency,
//       };
//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization':
//               'Bearer sk_test_51MWx80AVMykLfe3C3gP4wK0hTsRdF6r1PYhhg1P',
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: body,
//       );
//       return json.decode(response.body);
//     } catch (err) {
//       throw Exception(err.toString());
//     }
//   }
// }

// class Stripe {
// }
