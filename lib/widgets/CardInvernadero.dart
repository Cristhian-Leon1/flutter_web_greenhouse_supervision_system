import 'package:flutter/material.dart';

class CardInvernaderos extends StatelessWidget {

  late final Widget imagen;
  late final String titulo;
  late final String descripcion;

  CardInvernaderos({super.key, required this.imagen,required this.titulo,required this.descripcion});

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green[300],
          borderRadius: BorderRadius.circular(25),
        ),
        height: height * 0.65,
        width: width * 0.25,
        child:  Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  titulo,
                  style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    color: const Color(0xfff7f7f7),
                    fontSize: width * 0.025,
                    //fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  imagen,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      descripcion,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardInvernaderosCell extends StatelessWidget {

  late final Widget imagen;
  late final String titulo;
  late final String descripcion;

  CardInvernaderosCell({super.key, required this.imagen,required this.titulo,required this.descripcion});

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green[300],
          borderRadius: BorderRadius.circular(25),
        ),
        height: height * 0.23,
        width: width * 0.9,
        child:  Column(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  titulo,
                  style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    color: const Color(0xfff7f7f7),
                    fontSize: height * 0.03,
                    //fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: width > 600 ? const EdgeInsets.all(0) : EdgeInsets.only(top: height * 0.034),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(child: imagen),
                    Flexible(
                      flex: 2,
                      child: SingleChildScrollView(
                        child: Text(
                          descripcion,
                          textAlign: TextAlign.center,
                          maxLines: width > 600 ? 3 : 6,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}