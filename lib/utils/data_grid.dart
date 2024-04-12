import 'package:flutter_web_greenhouse_supervision_system/widgets/Graf1Linea.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_greenhouse_supervision_system/widgets/CardVariables.dart';

List<List<Widget>> getGridData(String temperature, String humidity, String humidityS1, String humidityS2,
                               String co2, String co2S1, String co2S2, int greenhouseNum,
                               List<FlSpot> temperatureData, List<FlSpot> humidityData, List<FlSpot> dataCo2) {
  return [
    /// Greenhouse 1
    // Row 1
    [
      Expanded(
        child: CardVariableWeb(
          titulo: "Temperatura medida:",
          valor: temperature,
          tipoGrafica: 1,
          color: 'generico',
          numInvernadero: greenhouseNum,
        ),
      ),
      Expanded(
        child: CardVariableWeb(
          titulo: "Humedad suelo 1:",
          valor: humidityS1,
          tipoGrafica: 2,
          color: 'generico',
          numInvernadero: greenhouseNum,
        ),
      ),
    ],

    // Lista fila 2
    [
      Expanded(
        child: CardVariableWeb(
          titulo: "CO₂:",
          valor: co2,
          tipoGrafica: 3,
          color: 'oscuro',
          numInvernadero: greenhouseNum,
        ),
      ),
      Expanded(
        child: CardVariableWeb(
          titulo: "Humedad suelo 2:",
          valor: humidityS2,
          tipoGrafica: 2,
          color: 'oscuro',
          numInvernadero: greenhouseNum,
        ),
      ),
    ],

    // Lista fila 3
    [
      Expanded(
        child: CardCaudalWeb(
          titulo: "Caudal",
          numInvernadero: greenhouseNum,
        ),
      ),
      Expanded(
        child: CardVariableWeb(
          titulo: "Humedad relativa:",
          valor: humidity,
          tipoGrafica: 2,
          color: 'generico',
          numInvernadero: greenhouseNum,
        ),
      ),
    ],

    /// Listas para invernadero 2
    // Lista fila 1
    [
      Expanded(
        child: CardVariableWeb(
          titulo: "Temperatura:",
          valor: temperature,
          tipoGrafica: 1,
          color: 'generico',
          numInvernadero: greenhouseNum,
        ),
      ),
      Expanded(
        child: CardVariableWeb(
          titulo: "Humedad suelo 1:",
          valor: humidityS1,
          tipoGrafica: 2,
          color: 'generico',
          numInvernadero: greenhouseNum,
        ),
      ),
    ],

    // Lista fila 2
    [
      Expanded(
        child: CardVariableWeb(
          titulo: "CO₂:",
          valor: co2,
          tipoGrafica: 3,
          color: 'oscuro',
          numInvernadero: greenhouseNum,
        ),
      ),
      Expanded(
        child: CardVariableWeb(
          titulo: "Humedad suelo 2:",
          valor: humidityS2,
          tipoGrafica: 2,
          color: 'oscuro',
          numInvernadero: greenhouseNum,
        ),
      ),
    ],

    // Lista fila 3
    [
      Expanded(
        child: CardCaudalWeb(
          titulo: "Caudal",
          numInvernadero: greenhouseNum,
        ),
      ),
      Expanded(
        child: CardVariableWeb(
          titulo: "Humedad relativa:",
          valor: humidity,
          tipoGrafica: 2,
          color: 'generico',
          numInvernadero: greenhouseNum,
        ),
      ),
    ],

    /// Listas para invernadero 3
    // Lista fila 1
    [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 15, top: 15),
          child: graf1Linea(
            titulo: "Temperatura",
            data: temperatureData,
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 15, top: 15),
          child: graf1Linea(
            titulo: "Humedad",
            data: humidityData,
          ),
        ),
      ),
    ],
  ];
}