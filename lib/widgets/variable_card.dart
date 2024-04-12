import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../views/flow_table_screen.dart';

class VariableCardCell extends StatelessWidget {
  final String title;
  final String value;

  const VariableCardCell({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width  = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: height * 0.20,
          width: width * 0.9,
          decoration: BoxDecoration(
            color: Colors.brown[100],
            borderRadius: BorderRadius.circular(15)
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.brown[200],
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
                  ),
                  child: Center(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16
                      ),
                    ),
                  ),
                )
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}


class VariableCardWeb extends StatelessWidget {
  final String title;
  final String value;
  final int chartType;
  final String color;
  final int greenhouseNum;

  const VariableCardWeb({super.key,
    required this.title,
    required this.value,
    required this.chartType,
    required this.color,
    required this.greenhouseNum});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width  = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: greenhouseNum == 3 ? height * 0.42 : height * 0.265,
          width: width * 0.35,
          decoration: BoxDecoration(
            color: color == "oscuro" ? Colors.brown[200] : Colors.brown[100] ,
            borderRadius: BorderRadius.circular(15)
          ),
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          chartType == 1 ? "$value °C" :
                          chartType == 2 ? "$value %" :
                          chartType == 3 ? "$value ppm" :
                          value,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class FlowCardWeb extends StatefulWidget {

  final String title;
  final int greenhouseNum;

  const FlowCardWeb({super.key, required this.title, required this.greenhouseNum});

  @override
  FlowCardWebState createState() => FlowCardWebState();
}

class FlowCardWebState extends State<FlowCardWeb> {

  List<Map<String, dynamic>> _data = [];

  bool _processing = false;
  bool _uploadData = false;

  // Petición get para la tabla en siguiente pantalla
  Future<void> _dataCompleteCaudal(int greenhouseNum) async {
    try {
      setState(() {
        _processing = true;
      });

      String uriDataCompleta = 'https://invernaapirest.onrender.com/api/caudal';
      final response = await http.get(Uri.parse(uriDataCompleta));

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body)['data'];
        _data = jsonResponse.cast<Map<String, dynamic>>();

        setState(() {
          _uploadData = true;
          _processing = false;
        });

        if (_uploadData) {
          // Navegar a la Pantalla 2 solo si _uploadData es true
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  FlowTablePage(data: _data, greenhouseNum: greenhouseNum),
            ),
          );
        }
      } else {
        setState(() {
          _uploadData = false;
          _processing = false;
        });
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width  = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: height * 0.265,
          width: width * 0.35,
          decoration: BoxDecoration(
              color: Colors.brown[100],
              borderRadius: BorderRadius.circular(15)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${widget.title} (m³/s):',
                style: const TextStyle(fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: _processing ?
                const CircularProgressIndicator(color: Color(0xff073775)) :
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 6,
                    padding: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    backgroundColor: const Color(0xff073775),
                  ),
                  onPressed: (){
                    _dataCompleteCaudal(widget.greenhouseNum);
                  },
                  child: const Text(
                    'Registro de caudal',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}