import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scent_shop/constants/routes.dart';
import 'package:scent_shop/firebase_helper/firebase_auth_helper/firebase_firestore/firebase_auth_helper.dart';
import 'package:scent_shop/provider/app_provider.dart';
import 'package:scent_shop/screens/about%20us/about_us.dart';
import 'package:scent_shop/screens/change_password/change_password.dart';
import 'package:scent_shop/screens/edit_profile/edit_profile.dart';
import 'package:scent_shop/screens/favourtite_screen/favourite_screen.dart';
import 'package:scent_shop/screens/oder_screen/oder_screen.dart';

import 'package:scent_shop/widgets/primary_button/primary_button.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    appProvider.getUserInfoFirebase();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Account",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                appProvider.getUserInformation.image == null
                    ? const Icon(
                        Icons.person_outline,
                        size: 75,
                      )
                    : CircleAvatar(
                        backgroundImage:
                            NetworkImage(appProvider.getUserInformation.image!),
                        radius: 55,
                      ),
                Text(
                  appProvider.getUserInformation.name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  appProvider.getUserInformation.email,
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 135,
                  child: PrimaryButton(
                    title: "Edit Profile",
                    onPressed: () {
                      Routes.instance
                          .push(widget: const EditProfile(), context: context);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    Routes.instance
                        .push(widget: const OrderScreen(), context: context);
                  },
                  leading: const Icon(Icons.shopping_bag_outlined),
                  title: const Text("Your Orders"),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance.push(
                        widget: const FavouriteScreen(), context: context);
                  },
                  leading: const Icon(Icons.favorite_outline),
                  title: const Text("Favourite"),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance
                        .push(widget: const AboutUs(), context: context);
                  },
                  leading: const Icon(Icons.info_outline),
                  title: const Text("About us"),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.support_agent_outlined),
                  title: const Text("Support"),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance.push(
                        widget: const ChangePasssword(), context: context);
                  },
                  leading: const Icon(Icons.change_circle_outlined),
                  title: const Text("Change Password"),
                ),
                ListTile(
                  onTap: () {
                    FirebaseAuthHelper.instance.signOut();
                    setState(() {});
                  },
                  leading: const Icon(Icons.logout),
                  title: const Text("Log Out"),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text("Version 1.0.0")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
