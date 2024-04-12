import 'package:flutter_web_greenhouse_supervision_system/widgets/single_variable_graph.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_greenhouse_supervision_system/widgets/variable_card.dart';

List<List<Widget>> getGridData(String temperature, String humidity, String humidityS1, String humidityS2,
                               String co2, String co2S1, String co2S2, int greenhouseNum,
                               List<FlSpot> temperatureData, List<FlSpot> humidityData, List<FlSpot> dataCo2) {
  return [
    /// Greenhouse 1
    // Row 1
    [
      Expanded(
        child: VariableCardWeb(
          title: "Temperatura medida:",
          value: temperature,
          chartType: 1,
          color: 'generico',
          greenhouseNum: greenhouseNum,
        ),
      ),
      Expanded(
        child: VariableCardWeb(
          title: "Humedad suelo 1:",
          value: humidityS1,
          chartType: 2,
          color: 'generico',
          greenhouseNum: greenhouseNum,
        ),
      ),
    ],

    // Lista fila 2
    [
      Expanded(
        child: VariableCardWeb(
          title: "CO₂:",
          value: co2,
          chartType: 3,
          color: 'oscuro',
          greenhouseNum: greenhouseNum,
        ),
      ),
      Expanded(
        child: VariableCardWeb(
          title: "Humedad suelo 2:",
          value: humidityS2,
          chartType: 2,
          color: 'oscuro',
          greenhouseNum: greenhouseNum,
        ),
      ),
    ],

    // Lista fila 3
    [
      Expanded(
        child: FlowCardWeb(
          title: "Caudal",
          greenhouseNum: greenhouseNum,
        ),
      ),
      Expanded(
        child: VariableCardWeb(
          title: "Humedad relativa:",
          value: humidity,
          chartType: 2,
          color: 'generico',
          greenhouseNum: greenhouseNum,
        ),
      ),
    ],

    /// Listas para invernadero 2
    // Lista fila 1
    [
      Expanded(
        child: VariableCardWeb(
          title: "Temperatura:",
          value: temperature,
          chartType: 1,
          color: 'generico',
          greenhouseNum: greenhouseNum,
        ),
      ),
      Expanded(
        child: VariableCardWeb(
          title: "Humedad suelo 1:",
          value: humidityS1,
          chartType: 2,
          color: 'generico',
          greenhouseNum: greenhouseNum,
        ),
      ),
    ],

    // Lista fila 2
    [
      Expanded(
        child: VariableCardWeb(
          title: "CO₂:",
          value: co2,
          chartType: 3,
          color: 'oscuro',
          greenhouseNum: greenhouseNum,
        ),
      ),
      Expanded(
        child: VariableCardWeb(
          title: "Humedad suelo 2:",
          value: humidityS2,
          chartType: 2,
          color: 'oscuro',
          greenhouseNum: greenhouseNum,
        ),
      ),
    ],

    // Lista fila 3
    [
      Expanded(
        child: FlowCardWeb(
          title: "Caudal",
          greenhouseNum: greenhouseNum,
        ),
      ),
      Expanded(
        child: VariableCardWeb(
          title: "Humedad relativa:",
          value: humidity,
          chartType: 2,
          color: 'generico',
          greenhouseNum: greenhouseNum,
        ),
      ),
    ],

    /// Listas para invernadero 3
    // Lista fila 1
    [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 15, top: 15),
          child: LineGraph1(
            title: "Temperatura",
            data: temperatureData,
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 15, top: 15),
          child: LineGraph1(
            title: "Humedad",
            data: humidityData,
          ),
        ),
      ),
    ],
  ];
}