import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scent_shop/constants/constants.dart';
import 'package:scent_shop/firebase_helper/firebase_auth_helper/firebase_firestore/firebase_auth_helper.dart';
import 'package:scent_shop/widgets/primary_button/primary_button.dart';

class ChangePasssword extends StatefulWidget {
  const ChangePasssword({super.key});

  @override
  State<ChangePasssword> createState() => _ChangePassswordState();
}

class _ChangePassswordState extends State<ChangePasssword> {
  bool isShowPassword = true;
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Change password",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: ListView(
          children: [
            TextFormField(
              controller: password,
              obscureText: isShowPassword,
              decoration: InputDecoration(
                hintText: " New Password",
                prefixIcon: const Icon(
                  Icons.lock_outlined,
                ),
                suffixIcon: CupertinoButton(
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: const Icon(Icons.visibility)),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: confirmpassword,
              obscureText: isShowPassword,
              decoration: InputDecoration(
                hintText: " Confirm Password",
                prefixIcon: const Icon(
                  Icons.lock_outlined,
                ),
                suffixIcon: CupertinoButton(
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: const Icon(Icons.visibility)),
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            PrimaryButton(
              title: "Update",
              onPressed: () async {
                if (password.text.isEmpty) {
                  showMessages("New password is empty");
                } else if (confirmpassword.text.isEmpty) {
                  showMessages("Confirm password is empty");
                } else {
                  if (confirmpassword.text == password.text) {
                    FirebaseAuthHelper.instance
                        .changepasssword(password.text, context);
                  } else {
                    showMessages("Confirm password is not match");
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
