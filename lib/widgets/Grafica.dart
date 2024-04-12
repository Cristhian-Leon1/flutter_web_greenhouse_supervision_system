import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Grafica extends StatefulWidget {
  final double temperatura;
  final Color lineColor;
  final int numGraf;

  Grafica({
    required this.temperatura,
    required this.lineColor,
    required this.numGraf,
  });

  @override
  _GraficaState createState() => _GraficaState();
}

class _GraficaState extends State<Grafica> {

  final List<FlSpot> temperaturePoints = [];
  final int limitCount = 100;
  double xValue = 0;
  double step = 0.05;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 40), (timer) {
      setState(() {
        while (temperaturePoints.length > limitCount) {
          temperaturePoints.removeAt(0);
        }
        temperaturePoints.add(FlSpot(xValue, widget.temperatura));
      });
      xValue += step;
    });
  }

  @override
  Widget build(BuildContext context) {
    return temperaturePoints.isNotEmpty ? SingleChildScrollView(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: AspectRatio(
            aspectRatio: 4.1,
            child: LineChart(
              LineChartData(
                minY: 0,
                maxY: widget.numGraf == 1 ? 50 :
                      widget.numGraf == 2 ? 100 :
                      widget.numGraf == 3 ? 900 :
                      null,
                minX: temperaturePoints.first.x,
                maxX: temperaturePoints.last.x,
                lineTouchData: LineTouchData(enabled: false),
                clipData: FlClipData.all(),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  temperatureLine(temperaturePoints),
                ],
                titlesData:FlTitlesData(
                  show: false,
                ),
              ),
            ),
          ),
        )
      ],
      ),
    ) : Container();
  }

  LineChartBarData temperatureLine(List<FlSpot> points) {
    return LineChartBarData(
      spots: points,
      dotData: FlDotData(
        show: false,
      ),
      barWidth: 3,
      isCurved: false,
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
