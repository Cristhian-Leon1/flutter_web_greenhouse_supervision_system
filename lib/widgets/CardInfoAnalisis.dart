import 'package:flutter/material.dart';

class CardInfoAnalisis extends StatelessWidget {

  late final String numeroInvernadero;
  late final String descripcionInvernadero;

  CardInfoAnalisis(this.numeroInvernadero, this.descripcionInvernadero, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              numeroInvernadero,
              style: const TextStyle(
                  color: Color(0xfff7f7f7),
                  fontSize: 22
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              child: Text(
                descripcionInvernadero,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 6,
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  backgroundColor: const Color(0xff073775),
                ),
                onPressed: (){

                },
                child: const Text(
                  'Registro completo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImagenCardInfo extends StatelessWidget {

  late final Widget imagen;

  ImagenCardInfo(this.imagen, {super.key});

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
          child: imagen,
        ),
      ),
    );
  }
}