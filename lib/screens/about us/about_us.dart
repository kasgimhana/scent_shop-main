import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colo,
        title: const Text(
          "About Us",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Text(
            "A perfume is a liquid mixture used to emit a pleasant odour. It is formed from fragrant essential oils derived from plants and spices or synthetic aromatic compounds.Cosmetic fragrances applied to a person’s body to emit a pleasant smell include perfume, cologne, and aftershave"),
      ),
    );
  }
}
