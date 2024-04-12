import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:data_table_2/data_table_2.dart';
import 'package:excel/excel.dart' as excel;
import 'package:data_table_2/data_table_2.dart' as DataTable2;

class TablaCaudal extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final int numInvernadero;
  const TablaCaudal({super.key, required this.data, required this.numInvernadero});

  @override
  State<TablaCaudal> createState() => _TablaCaudalState();
}

class _TablaCaudalState extends State<TablaCaudal> {

  late List<Map<String, dynamic>> dataSemana;
  late int _totalPages;

  int _currentPage = 1;
  final int _perPage = 20;

  String temperatura = "0";
  String humedad =  "0";
  String co2 = "0";
  String humedadS1 = "0";
  String humedadS2 = "0";

  bool _processing = false;

  void exportToExcel() {

    var excelFile = excel.Excel.createExcel();
    var sheet = excelFile['Sheet1'];

    sheet.appendRow(['Caudal', 'Fecha_hora']);
    for (var rowData in widget.data) {
      sheet.appendRow([
        rowData['caudal'],
        rowData['timestamp']
      ]);
    }

    var bytes = excelFile.encode();
    final blob = html.Blob([bytes], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'DataCaudal.xlsx';
    html.document.body!.children.add(anchor);
    anchor.click();
    html.document.body!.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final startIndex = (_currentPage - 1) * _perPage;
    final endIndex = startIndex + _perPage > widget.data.length ?
    widget.data.length : startIndex + _perPage;

    _totalPages = (widget.data.length / _perPage).ceil();

    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      appBar: AppBar(
        title: const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 13, right: 35),
              child: Text(
                'Tabla de datos Caudal',
              ),
            )
        ),
        backgroundColor: const Color(0xfff7f7f7),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: Future.value(widget.data),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final columns = [
                  const DataColumn2(label: Text('Caudal')),
                  const DataColumn2(label: Text('Fecha_hora')),
                ];

                final paginatedData = snapshot.data!.sublist(startIndex, endIndex);
                final rows = paginatedData.map((item) =>
                DataRow(cells: [
                  DataCell(Text(item['caudal'].toString())),
                  DataCell(Text(item['timestamp'].toString())),
                ]
                )).toList();
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SizedBox(
                          height: height * 0.7,
                          width: width * 0.9,
                          child: DataTable2.DataTable2(
                            columns: columns,
                            rows: rows,
                            columnSpacing: 30,
                            dataRowHeight: 50,
                            headingRowColor: MaterialStateProperty.all(Colors.green[300]),
                            dataRowColor: MaterialStateProperty.all(Colors.grey[200]),
                            headingTextStyle: const TextStyle(color: Color(0xfff7f7f7), fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: width > 600 ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: _processing == false ? ElevatedButton(
                                onPressed: () {
                                  exportToExcel();
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: const Color(0xfff7f7f7),
                                  backgroundColor: const Color(0xff073775),
                                ),
                                child: const Text("Exportar excel"),
                              ) : const Center(child: CircularProgressIndicator(color: Color(0xff073775))),
                            ),
                            ElevatedButton(
                              onPressed: _currentPage > 1
                                  ? () {
                                setState(() {
                                  _currentPage--;
                                });
                              }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                foregroundColor: const Color(0xfff7f7f7),
                                backgroundColor: const Color(0xff073775),
                              ),
                              child: const Text("Anterior"),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Text("Página $_currentPage"),
                            ),
                            ElevatedButton(
                              onPressed: endIndex < widget.data.length
                                  ? () {
                                setState(() {
                                  _currentPage++;
                                });
                              }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                foregroundColor: const Color(0xfff7f7f7),
                                backgroundColor: const Color(0xff073775),
                              ),
                              child: const Text("Siguiente"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _currentPage = _totalPages;  // Actualiza a la última página
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: const Color(0xfff7f7f7),
                                  backgroundColor: const Color(0xff073775),
                                ),
                                child: const Text("Última página"),
                              ),
                            ),
                          ],
                        ) : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: _currentPage > 1
                                      ? () {
                                    setState(() {
                                      _currentPage--;
                                    });
                                  }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: const Color(0xfff7f7f7),
                                    backgroundColor: const Color(0xff073775),
                                  ),
                                  child: const Text("Anterior"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text("Página $_currentPage"),
                                ),
                                ElevatedButton(
                                  onPressed: endIndex < widget.data.length
                                      ? () {
                                    setState(() {
                                      _currentPage++;
                                    });
                                  }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: const Color(0xfff7f7f7),
                                    backgroundColor: const Color(0xff073775),
                                  ),
                                  child: const Text("Siguiente"),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: _processing == false ? ElevatedButton(
                                onPressed: () {
                                  exportToExcel();
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: const Color(0xfff7f7f7),
                                  backgroundColor: const Color(0xff073775),
                                ),
                                child: const Text("Exportar excel"),
                              ) : const Center(child: CircularProgressIndicator(color: Color(0xff073775))),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}