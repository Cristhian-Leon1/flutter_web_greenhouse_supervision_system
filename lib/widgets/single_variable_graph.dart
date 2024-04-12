import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class _LineChart extends StatelessWidget {
  final String chartType;
  final bool isShowingMainData;
  final List<FlSpot> data;

  const _LineChart({required this.isShowingMainData, required this.chartType, required this.data});

  @override
  Widget build(BuildContext context) {

    FlTitlesData titlesData1 = FlTitlesData(
      topTitles: SideTitles(
        showTitles: false,
      ),
      bottomTitles: SideTitles(
        showTitles: true,
        getTextStyles: (context, value) => TextStyle(
          fontSize: chartType == 'Temperatura' ? 12 :
          chartType == 'Humedad' ? 12 :
          chartType == 'CO2' ? 12 : 0,
        ),
        getTitles: (value) {
          switch (value.toInt()) {
            case 0:
              return '0';
            case 1:
              return '1';
            case 2:
              return '2';
            case 3:
              return '3';
            case 4:
              return '4';
            case 5:
              return '5';
            case 6:
              return '6';
            case 7:
              return '7';
            case 8:
              return '8';
            case 9:
              return '9';
            case 10:
              return '10';
            case 11:
              return '11';
            case 12:
              return '12';
            case 13:
              return '13';
            case 14:
              return '14';
            case 15:
              return '15';
            case 16:
              return '16';
            case 17:
              return '17';
            case 18:
              return '18';
            case 19:
              return '19';
            default:
              return '';
          }
        },
      ),
      leftTitles: SideTitles(
          showTitles: false,
          margin: 30
      ),
      rightTitles: SideTitles(
        margin: 10,
        showTitles: true,
        getTextStyles: (context, value) => TextStyle(
          fontSize: chartType == 'Temperatura' ? 12 :
          chartType == 'Humedad' ? 11 :
          chartType == 'CO2' ? 9.3 : 0,
        ),
        getTitles: (value){
          return chartType == 'Temperatura' ? '${value.toInt()}°' :
          chartType == 'CO2' ? '${value.toInt()} ppm' :
          chartType == 'Humedad' ? '${value.toInt()}%' :
          '${value.toInt()}';
        },
      ),
    );

    LineChartData sampleData1 = LineChartData(
      lineTouchData: lineTouchData1,
      gridData: gridData,
      titlesData: titlesData1,
      borderData: borderData,
      lineBarsData: lineBarsData1,
      minX: 0,
      maxX: 20,
      maxY: chartType == 'Temperatura' ? 50 :
      chartType == 'Humedad' ? 102 :
      chartType == 'CO2' ? 2000 : 0,
      minY: 0,
    );

    FlTitlesData titlesData2 = FlTitlesData(
      topTitles: SideTitles(
        showTitles: false,
      ),
      bottomTitles: SideTitles(
        showTitles: true,
        getTextStyles: (context, value) => TextStyle(
          fontSize: chartType == 'Temperatura' ? 12 :
          chartType == 'Humedad' ? 12 :
          chartType == 'CO2' ? 12 : 0,
        ),
        getTitles: (value) {
          switch (value.toInt()) {
            case 0:
              return '0';
            case 1:
              return '1';
            case 2:
              return '2';
            case 3:
              return '3';
            case 4:
              return '4';
            case 5:
              return '5';
            case 6:
              return '6';
            case 7:
              return '7';
            case 8:
              return '8';
            case 9:
              return '9';
            case 10:
              return '10';
            case 11:
              return '11';
            case 12:
              return '12';
            case 13:
              return '13';
            case 14:
              return '14';
            case 15:
              return '15';
            case 16:
              return '16';
            case 17:
              return '17';
            case 18:
              return '18';
            case 19:
              return '19';
            default:
              return '';
          }
        },
      ),
      leftTitles: SideTitles(
          showTitles: false,
          margin: 30
      ),
      rightTitles: SideTitles(
        margin: 10,
        showTitles: true,
        getTextStyles: (context, value) => TextStyle(
          fontSize: chartType == 'Temperatura' ? 12 :
          chartType == 'Humedad' ? 12 :
          chartType == 'CO2' ? 9.3 : 0,
        ),
        getTitles: (value) {
          return chartType == 'Temperatura' ? '${value.toInt()}°' :
          chartType == 'CO2' ? '${value.toInt()} ppm' :
          chartType == 'Humedad' ? '${value.toInt()}%' :
          '${value.toInt()}';
        },
      ),
    );

    LineChartData sampleData2 = LineChartData(
      lineTouchData: lineTouchData2,
      gridData: gridData,
      titlesData: titlesData2,
      borderData: borderData,
      lineBarsData: lineBarsData2,
      minX: 0,
      maxX: 20,
      maxY: chartType == 'Temperatura' ? 52 :
      chartType == 'Humedad' ? 100 :
      chartType == 'CO2' ? 2000 : 0,
      minY: 0,
    );

    return Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: LineChart(
        isShowingMainData ? sampleData1 : sampleData2,
      ),
    );
  }

  LineTouchData get lineTouchData1 => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
    ),
  );


  List<LineChartBarData> get lineBarsData1 => [
    lineChartBarData1_1,
  ];

  LineTouchData get lineTouchData2 => LineTouchData(
    enabled: false,
  );


  List<LineChartBarData> get lineBarsData2 => [
    lineChartBarData2_1,
  ];


  Widget sideTitleWidget(double value, SideTitles meta, String text) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
    isCurved: true,
    colors: chartType == 'Temperatura' ? [const Color(0xFFad3333)] :
    chartType == 'Humedad' ? [Colors.amber] :
    chartType == 'CO2' ? [Colors.green] : [Colors.grey],
    barWidth: 5,
    isStrokeCapRound: true,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    spots: data,
  );

  LineChartBarData get lineChartBarData2_1 => LineChartBarData(
    isCurved: true,
    curveSmoothness: 0,
    colors: chartType == 'Temperatura' ? [const Color(0xFFad3333).withOpacity(0.5)] :
    chartType == 'Humedad' ? [Colors.amber.withOpacity(0.5)] :
    chartType == 'CO2' ? [Colors.green.withOpacity(0.5)] : [Colors.grey.withOpacity(0.5)],
    barWidth: 4,
    isStrokeCapRound: true,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(
      show: true,
      colors: chartType == 'Temperatura' ? [const Color(0xFFad3333).withOpacity(0.2)] :
      chartType == 'Humedad' ? [Colors.amber.withOpacity(0.2)] :
      chartType == 'CO2' ? [Colors.green.withOpacity(0.2)] : [Colors.grey.withOpacity(0.2)],
    ),
    spots: data,
  );
}

FlGridData get gridData => FlGridData(show: false);

FlBorderData get borderData => FlBorderData(
  show: true,
  border: Border(
    bottom:
    BorderSide(color: const Color(0xFF50E4FF).withOpacity(0.2), width: 4),
    left: const BorderSide(color: Colors.transparent),
    right: const BorderSide(color: Colors.transparent),
    top: const BorderSide(color: Colors.transparent),
  ),
);


class LineGraph1 extends StatefulWidget {
  final String title;
  final List<FlSpot> data;

  const LineGraph1({super.key, required this.title, required this.data});

  @override
  State<StatefulWidget> createState() => LineGraph1State();
}

class LineGraph1State extends State<LineGraph1> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [
            Colors.brown[100]!,
            Colors.brown[100]!,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: AspectRatio(
        aspectRatio: 1.23,
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 6),
                    child: _LineChart(isShowingMainData: isShowingMainData, chartType: widget.title, data: widget.data),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
              ),
              onPressed: () {
                setState(() {
                  isShowingMainData = !isShowingMainData;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}