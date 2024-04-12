import 'package:flutter/material.dart';

class CardRiego extends StatefulWidget {

  final Widget imagen;
  final String titulo;

  final bool valueSwitch;
  final ValueChanged<bool> onChanged;

  const CardRiego({super.key, required this.imagen,required this.titulo, required this.valueSwitch, required this.onChanged});

  @override
  State<CardRiego> createState() => _CardRiegoState();
}

class _CardRiegoState extends State<CardRiego> {

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.brown[100],
            borderRadius: BorderRadius.circular(15),
          ),
          height: height * 0.42,
          width: width * 0.4,
          child:  Column(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    widget.titulo,
                    style: const TextStyle(fontSize: 20,),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: widget.imagen),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                        ],
                      )
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class CardRiegoCell extends StatefulWidget {

  late final Widget imagen;
  late final String titulo;

  final bool valueSwitch;
  final ValueChanged<bool> onChanged;

  CardRiegoCell({super.key, required this.imagen,required this.titulo, required this.valueSwitch, required this.onChanged});

  @override
  State<CardRiegoCell> createState() => _CardRiegoCellState();
}

class _CardRiegoCellState extends State<CardRiegoCell> {

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.brown[100],
            borderRadius: BorderRadius.circular(15),
          ),
          height: height * 0.27,
          width: width * 0.9,
          child:  Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.brown[200],
                      borderRadius: const BorderRadius.only (
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)
                      )
                  ),
                  child: Center(
                    child: Text(
                      widget.titulo,
                      style: const TextStyle(fontSize: 20,),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: widget.imagen),
                    Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                          ],
                        )
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}