import 'package:flutter/material.dart';

class WateringCard extends StatefulWidget {
  final Widget image;
  final String title;

  final bool valueSwitch;
  final ValueChanged<bool> onChanged;

  const WateringCard({super.key,
    required this.image,
    required this.title,
    required this.valueSwitch,
    required this.onChanged});

  @override
  State<WateringCard> createState() => _WateringCardState();
}

class _WateringCardState extends State<WateringCard> {

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
                    widget.title,
                    style: const TextStyle(fontSize: 20,),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: widget.image),
                    const Expanded(
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

class WateringCardCell extends StatefulWidget {
  final Widget image;
  final String title;

  final bool valueSwitch;
  final ValueChanged<bool> onChanged;

  const WateringCardCell({super.key,
    required this.image,
    required this.title,
    required this.valueSwitch,
    required this.onChanged});

  @override
  State<WateringCardCell> createState() => _WateringCardCellState();
}

class _WateringCardCellState extends State<WateringCardCell> {

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
                      widget.title,
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
                    Expanded(child: widget.image),
                    const Expanded(
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