import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_web_greenhouse_supervision_system/views/home_screen.dart';
import 'package:flutter_web_greenhouse_supervision_system/views/table_screen.dart';
import 'package:flutter_web_greenhouse_supervision_system/widgets/CardInfoAnalisis.dart';
import 'package:flutter_web_greenhouse_supervision_system/widgets/CardVariables.dart';
import 'package:flutter_web_greenhouse_supervision_system/widgets/CardRiego.dart';
import 'package:flutter_web_greenhouse_supervision_system/utils/data_images_descriptions.dart';
import 'package:flutter_web_greenhouse_supervision_system/utils/data_grid.dart';
import '../widgets/Graf1Linea.dart';

class MonitoringPage extends StatefulWidget {
  final int greenhouseNum;
  final String username;

  const MonitoringPage({super.key, required this.greenhouseNum, required this.username});

  @override
  State<MonitoringPage> createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage> {
  List<Map<String, dynamic>> _data = [];

  String? temperature = "0";
  String? humidity = "0";
  String? humidityS1 = "0";
  String? humidityS2 = "0";
  String? co2 = "0";
  String? co2S1 = "0";
  String? co2S2 = "0";

  late String fullDataUri;
  late String weekDateUri;
  late String lastDataUri;
  late String last20DataUri;

  bool _processing = false;
  bool _uploadData = false;
  bool isSwitched = false;

  int _currentIndex = 0;
  late PageController _pageController;

  Timer? _timer;

  List<FlSpot> temperatureData = [];
  List<FlSpot> humidityData = [];
  List<FlSpot> co2Data = [];

  final List<String> descriptions = despcriptionList;
  final List<String> imagesGreenhouse1 = imagesListGreenhouse1;
  final List<String> imagesGreenhouse2 = imagesListGreenhouse2;
  final List<String> imagesGreenhouse3 = imagesListGreenhouse3;

  @override
  void initState() {
    super.initState();
    _urisAssignment(widget.greenhouseNum);
    widget.greenhouseNum == 3 ? _requestLast20Greenhouse3() : _requestLast20();
    _pageController = PageController(initialPage: _currentIndex);

    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      widget.greenhouseNum == 3 ? _requestLast20Greenhouse3() : _requestLast20();
    });

    Timer.periodic(const Duration(seconds: 30), (Timer timer) {
      if (_currentIndex < imagesGreenhouse1.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      if(_pageController.hasClients) {
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _urisAssignment(int greenhouseNum) {
    setState(() {
      switch (greenhouseNum) {
        case 1:
          fullDataUri = 'https://invernaapirest.onrender.com/api/invernadero1';
          weekDateUri = 'https://invernaapirest.onrender.com/api/invernadero1/semana';
          lastDataUri = 'https://invernaapirest.onrender.com/api/invernadero1/ultimo';
          break;
        case 2:
          fullDataUri = 'https://invernaapirest.onrender.com/api/invernadero2';
          weekDateUri = 'https://invernaapirest.onrender.com/api/invernadero2/semana';
          lastDataUri = 'https://invernaapirest.onrender.com/api/invernadero2/ultimo';
          break;
        case 3:
          fullDataUri = 'https://invernaapirest.onrender.com/api/invernadero3';
          weekDateUri = 'https://invernaapirest.onrender.com/api/invernadero3/semana';
          lastDataUri = 'https://invernaapirest.onrender.com/api/invernadero3/ultimo';
          last20DataUri = 'https://invernaapirest.onrender.com/api/invernadero3/ultimos20';
          break;
        default:
          fullDataUri = 'https://invernaapirest.onrender.com/api/invernadero1';
          weekDateUri = 'https://invernaapirest.onrender.com/api/invernadero1/semana';
          lastDataUri = 'https://invernaapirest.onrender.com/api/invernadero1/ultimo';
      }
    });
  }

  Future<void> _requestCompleteDataTable(int greenhouseNum) async {
    try {
      setState(() {
        _processing = true;
      });
      final response = await http.get(Uri.parse(fullDataUri));

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body)['data'];
        _data = jsonResponse.cast<Map<String, dynamic>>();
        setState(() {
          _uploadData = true;
          _processing = false;
        });

        if (_uploadData) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  TablePage(data: _data, greenhouseNum: greenhouseNum),
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

  Future<void> _requestLast20Greenhouse3() async {
    final response = await http.get(Uri.parse(last20DataUri));
    final jsonData = json.decode(response.body);

    if (jsonData != null && jsonData['data'] != null) {
      final data = jsonData['data'];

      temperatureData.clear();
      humidityData.clear();
      co2Data.clear();
      for (var i = 0; i < data.length; i++) {
        var item = data[i];
        if (item != null && item['temperaturai3'] != null) {
          temperatureData.add(FlSpot(i.toDouble(), double.parse(item['temperaturai3'].toString())));
          humidityData.add(FlSpot(i.toDouble(), double.parse(item['humedadi3'].toString())));
          co2Data.add(FlSpot(i.toDouble(), double.parse(item['co2i3'].toString())));
        }
      }
      setState(() {
        temperatureData = temperatureData;
        humidityData = humidityData;
        co2Data = co2Data;
      });
    } else {
      print("No se recibieron datos");
    }
  }

  Future<void> _requestLast20() async {
    final response = await http.get(Uri.parse(lastDataUri));
    final jsonData = json.decode(response.body);

    if (jsonData != null && jsonData['data'] != null) {
      final data = jsonData['data'];
      switch (widget.greenhouseNum) {
        case 1:
          temperature = data['temperaturai1'].toString();
          co2 = data['co2i1'].toString();
          humidity = data['humedadi1'].toString();
          humidityS1 = data['humedad_suelo1'].toString();
          humidityS2 = data['humedad_suelo2'].toString();
          break;
        case 2:
          temperature = data['temperaturai2'].toString();
          co2 = data['co2i2'].toString();
          humidity = data['humedadi2'].toString();
          humidityS1 = data['humedad_suelo1i2'].toString();
          humidityS2 = data['humedad_suelo2i2'].toString();
          break;
        case 3:
          break;
        default:
      }
      if (mounted) {
        setState(() {
          temperature = temperature;
          co2 = co2;
          humidity = humidity;
          humidityS1 = humidityS1;
          humidityS2 = humidityS2;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          temperature = "N/A";
          co2 = "N/A";
          humidity = "N/A";
          humidityS1 = "N/A";
          humidityS2 = "N/A";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    List<List<Widget>> gridList = getGridData(temperature!, humidity!, humidityS1!, humidityS2!,
                                      co2!, co2S1!, co2S2!, widget.greenhouseNum, temperatureData,
                                      humidityData, co2Data);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff7f7f7),
        appBar: AppBar(
          toolbarHeight: width > 600 ? 40 : height * 0.08,
          backgroundColor: const Color(0xfff7f7f7),
          leading: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(username: widget.username),
                  ),
                );
              },
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 10),
              child: width > 600 ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 9),
                    child: Text(
                      widget.username,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 5,top: 5),
                    child: Icon(Icons.account_circle, color: Color(0xff073775),size: 30),
                  ),
                ],
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10, top: 9),
                    child: Text(
                      widget.username,
                      style: TextStyle(
                        fontSize: height * 0.025,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: width * 0.02, top: 4),
                    child: Icon(
                      Icons.account_circle,
                      color: const Color(0xff073775),
                      size: width < 500 ? height * 0.048 : height * 0.062
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        body: width > 600 ? Row(
          children: [
            Expanded(
              child: Center(
                child: Material(
                  elevation: 6,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: height * 0.895,
                    width: width * 0.23,
                    decoration: BoxDecoration(
                      color: Colors.green[300],
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Invernadero ${widget.greenhouseNum}',
                                    style: const TextStyle(
                                      color: Color(0xfff7f7f7),
                                      fontSize: 22
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                                    child: Text(widget.greenhouseNum == 1 ? descriptions[0] :
                                                widget.greenhouseNum == 2 ? descriptions[1] :
                                                widget.greenhouseNum == 3 ? descriptions[2] : '',
                                    textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25, right: 25),
                                    child: _processing ?
                                    const CircularProgressIndicator(color: Color(0xff073775)) :
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 6,
                                        padding: const EdgeInsets.all(15),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15)
                                        ),
                                        backgroundColor: const Color(0xff073775),
                                      ),
                                      onPressed: () {
                                        int? value;
                                        setState(() {
                                          value = widget.greenhouseNum;
                                        });
                                        _requestCompleteDataTable(value!);
                                      },
                                      child: const Text(
                                        'Registro completo',
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
                          )
                        ),
                        Expanded(
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: imagesGreenhouse1.length,
                            onPageChanged: (index) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              return ImagenCardInfo(
                                Image.asset(
                                  widget.greenhouseNum == 1 ? imagesGreenhouse1[index] :
                                  widget.greenhouseNum == 2 ? imagesGreenhouse2[index] :
                                  widget.greenhouseNum == 3 ? imagesGreenhouse3[index] :
                                  'assets/invernadero_real.jpg',
                                  fit: BoxFit.cover
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(color: Color(0xfff7f7f7)),
                child: widget.greenhouseNum == 1 ? Column(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget> [
                          ...gridList[0],
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          ...gridList[1],
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          ...gridList[2],
                        ],
                      ),
                    ),
                  ],
                ) :
                widget.greenhouseNum == 2 ? Column(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget> [
                          ...gridList[3],
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          ...gridList[4],
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          ...gridList[5],
                        ],
                      ),
                    ),
                  ],
                ) :
                widget.greenhouseNum == 3 ? Column(
                  children: <Widget>[
                     Expanded(
                       child: Row(
                         children: <Widget> [
                           ...gridList[6],
                         ],
                       ),
                     ),
                     Expanded(
                       child: Row(
                         children: <Widget>[
                           Expanded(
                             child: Padding(
                               padding: const EdgeInsets.only(right: 15, top: 15, bottom: 15),
                               child: graf1Linea(
                                 titulo: "CO2",
                                 data: co2Data,
                               ),
                             ),
                           ),
                           Expanded(
                             child: CardRiego(
                               titulo: 'Sistema de riego',
                               imagen: Padding(
                                 padding: const EdgeInsets.only(left: 30, bottom: 20),
                                 child: Image.asset('assets/riego.png',height: height * 0.2),
                               ),
                               valueSwitch: isSwitched,
                               onChanged: (bool value) {
                                 setState(() {
                                   isSwitched = value;
                                   if (isSwitched) {

                                   } else {

                                   }
                                 });
                               },
                             ),
                           ),
                         ],
                       ),
                     ),
                   ],
                 )
                 : const SizedBox(height: 0),
              ),
            )
          ],
        ) : Padding(
          padding: const EdgeInsets.only(top: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Material(
                    elevation: 6,
                    borderRadius: BorderRadius.circular(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: height * 0.87,
                          width: width * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.green[300],
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 15),
                                          child: Text(
                                            'Invernadero ${widget.greenhouseNum}',
                                            style: TextStyle(
                                              //fontWeight: FontWeight.bold,
                                              color: const Color(0xfff7f7f7),
                                              fontSize: height * 0.03,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                                          child: Text(widget.greenhouseNum == 1 ? descriptions[0] :
                                                      widget.greenhouseNum == 2 ? descriptions[1] :
                                                      widget.greenhouseNum == 3 ? descriptions[2] : '',
                                          textAlign: TextAlign.center,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 25, right: 25),
                                          child: _processing ? const CircularProgressIndicator(color: Color(0xff073775))
                                          : ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                              elevation: 6,
                                              padding: const EdgeInsets.all(15),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                              backgroundColor: const Color(0xff073775),
                                            ),
                                            onPressed: () {
                                              int? value;
                                              setState(() {
                                                value = widget.greenhouseNum;
                                              });
                                              _requestCompleteDataTable(value!);
                                            },
                                            child: const Text(
                                              'Registro completo',
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
                              ),
                              Expanded(
                                child: PageView.builder(
                                  controller: _pageController,
                                  itemCount: imagesGreenhouse1.length,
                                  onPageChanged: (index) {
                                    setState(() {
                                      _currentIndex = index;
                                    });
                                  },
                                  itemBuilder: (context, index) {
                                    return ImagenCardInfo(
                                      Image.asset(
                                        widget.greenhouseNum == 1 ? imagesGreenhouse1[index] :
                                        widget.greenhouseNum == 2 ? imagesGreenhouse2[index] :
                                        widget.greenhouseNum == 3 ? imagesGreenhouse3[index] :
                                        'assets/invernadero_real.jpg',
                                        fit: BoxFit.cover
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                widget.greenhouseNum == 1 ? Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    children: [
                      CardVariableCell(titulo: "La temperatura medida es:", valor: "$temperature °C"),
                      CardVariableCell(titulo: "El CO₂ medido es:", valor: "$co2S1 ppm"),
                      CardVariableCell(titulo: "El caudal medido es:", valor: "$co2S2 ppm"),
                      CardVariableCell(titulo: "El nivel de humedad suelo 1 es:", valor: "$humidityS1 %"),
                      CardVariableCell(titulo: "El nivel de humedad suelo 2 es:", valor: "$humidityS2 %"),
                      CardVariableCell(titulo: "Humedad relativa:", valor: "$humidity %"),
                      const Padding(padding: EdgeInsets.only(bottom: 10))
                    ]
                  ),
                )
                : widget.greenhouseNum == 2 ? Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    children: [
                      CardVariableCell(titulo: "La temperatura medida es:", valor: "$temperature °C"),
                      CardVariableCell(titulo: "El CO₂ medido es:", valor: "$co2 ppm"),
                      CardVariableCell(titulo: "El nivel de humidity suelo 1 es:", valor: "$humidityS1 %"),
                      CardVariableCell(titulo: "El nivel de humidity suelo 2 es:", valor: "$humidityS2 %"),
                      CardVariableCell(titulo: "Humedad relativa:", valor: "$humidity %"),
                      const Padding(padding: EdgeInsets.only(bottom: 10))
                    ]
                  ),
                ) :
                widget.greenhouseNum == 2 ? Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    children: [
                      CardVariableCell(titulo: "La temperature medida es:", valor: "$temperature °C"),
                      CardVariableCell(titulo: "La nivel de humidity medido es:", valor: "$humidity %"),
                      CardVariableCell(titulo: "El nivel de CO₂ medido es:", valor: "$co2 ppm"),
                      const Padding(padding: EdgeInsets.only(bottom: 10))
                    ]
                  ),
                ) :
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    children: [
                      CardVariableCell(titulo: "La temperature medida es:", valor: "$temperature °C"),
                      CardVariableCell(titulo: "La nivel de humidity medido es:", valor: "$humidity %"),
                      CardVariableCell(titulo: "El  nivel de CO₂ medido es:", valor: "$co2 ppm"),
                      CardRiegoCell(
                        titulo: 'Sistema de riego',
                        imagen: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Image.asset('assets/riego.png',height: height * 0.15),
                        ),
                        valueSwitch: isSwitched,
                        onChanged: (bool value) {
                          setState(() {
                            isSwitched = value;
                            if (isSwitched) {
                              //channel.sink.add('Encender motor');
                            } else {
                              //channel.sink.add('Apagar motor');
                            }
                          });
                        },
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 10))
                    ]
                  ),
                )
              ],
            ),
          ),
        )
      )
    );
  }
}
