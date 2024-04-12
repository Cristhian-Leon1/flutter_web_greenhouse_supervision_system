import 'package:flutter/material.dart';

import 'package:flutter_web_greenhouse_supervision_system/widgets/greenhouse_card.dart';
import 'monitoring_screen.dart';


class HomePage extends StatefulWidget {
  final String username;

  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int greenhouseNum = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff7f7f7),
        body: Column(
          children: [
            Container(
              height: width > 600 ? height * 0.10 : height * 0.08,
              width: double.infinity,
              color: Colors.transparent,
              child: width > 600
              ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      widget.username,
                      style: TextStyle(
                        fontSize: height * 0.037,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Icon(Icons.account_circle, color: const Color(0xff073775),size: height * 0.062),
                  )
                ],
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10, top: 17),
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
                    padding: const EdgeInsets.only(right: 20, top: 10),
                    child: Icon(
                      Icons.account_circle,
                      color: const Color(0xff073775),
                      size: width < 500 ? height * 0.048 : height * 0.062
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: width > 600 ? height * 0.75 : height * 0.79,
              width: double.infinity,
              color: Colors.transparent,
              child: width > 600 ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        greenhouseNum = 1;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) =>
                            MonitoringPage(greenhouseNum: greenhouseNum, username: widget.username)
                        )
                      );
                    },
                    child: GreenhouseCard(
                      title: 'Invernadero 1',
                      image: Image.asset('assets/invernadero.png', width: width * 0.12),
                      description: 'En este apartado se monitorea el invernadero numero 1 que contiene un cultivo de remolacha.',
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        greenhouseNum = 2;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) =>
                            MonitoringPage(greenhouseNum: greenhouseNum, username: widget.username)
                        )
                      );
                    },
                    child: GreenhouseCard(
                      image: Image.asset('assets/invernadero1.png', width: width * 0.12),
                      title: 'Invernadero 2',
                      description: 'En este apartado se monitorea el invernadero numero 2 que contiene un cultivo de remolacha.'
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        greenhouseNum = 3;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) =>
                          MonitoringPage(greenhouseNum: greenhouseNum, username: widget.username)
                        )
                      );
                    },
                    child: GreenhouseCard(
                      image: Image.asset('assets/invernadero2.png', width: width * 0.12),
                      title: 'Invernadero 3',
                      description: 'En este apartado se monitorea el invernadero numero 3 que contiene cultivos de rosas rojas.'
                    ),
                  ),
                ],
              )
              : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        greenhouseNum = 1;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) =>
                          MonitoringPage(greenhouseNum: greenhouseNum, username: widget.username)
                        )
                      );
                    },
                    child: GreenhouseCardCell(
                      image: Image.asset('assets/invernadero.png', width: width * 0.2),
                      title: 'Invernadero 1',
                      description: 'En este invernadero se monitorean cultivos de remolacha.'
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        greenhouseNum = 2;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) =>
                          MonitoringPage(greenhouseNum: greenhouseNum, username: widget.username)
                        )
                      );
                    },
                    child: GreenhouseCardCell(
                      image: Image.asset('assets/invernadero1.png', width: width * 0.2),
                      title: 'Invernadero 2',
                      description: 'En este invernadero se monitorean cultivos de remolacha.'
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        greenhouseNum = 3;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) =>
                          MonitoringPage(greenhouseNum: greenhouseNum, username: widget.username)
                        )
                      );
                    },
                    child: GreenhouseCardCell(
                      image: Image.asset('assets/invernadero2.png', width: width * 0.2),
                      title: 'Invernadero 3',
                      description: 'En este apartado se monitorea el invernadero numero 3 que contiene cultivos de arveja.'
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: width > 600 ? height * 0.15 : height * 0.13,
              width: double.infinity,
              color: Colors.green[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/escudounipamplona_redux.png', height: width > 600 ? height * 0.12 : width * 0.13),
                  const SizedBox(width: 10),
                  RichText(
                    text:  TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'UNIVERSIDAD\nDE',
                          style: TextStyle(
                            letterSpacing: 1.2,
                            fontSize: width > 600 ? height * 0.029 : width * 0.031
                          ),
                        ),
                        TextSpan(
                          text: ' PAMPLONA',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: width > 600 ? height * 0.029 : width * 0.031
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  Image.asset('assets/slogan_negro_redux.png', width: width > 600 ? 200 : width * 0.33),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
