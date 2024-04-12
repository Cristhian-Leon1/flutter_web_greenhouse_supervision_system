import 'package:flutter/material.dart';

class InformationImageCard extends StatelessWidget {
  final Widget image;

  const InformationImageCard(this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 30),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color(0xfff7f7f7),
            width: 3,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: image,
        ),
      ),
    );
  }
}