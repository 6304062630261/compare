import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart'; // สำหรับ format currency

class PieChartWidget extends StatelessWidget {
  final Map<String, double> dataMap;

  PieChartWidget({required this.dataMap});

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> pieChartSections = _createPieChartSections();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            _buildTitle(),
            Container(
              height: 300,
              child: PieChart(
                PieChartData(
                  sections: pieChartSections,
                  centerSpaceRadius: 40,
                  sectionsSpace: 2,
                ),
              ),
            ),
            SizedBox(height: 5),
            _buildIndicator(pieChartSections),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  final Map<String, Color> typeToColor = {
    'Food': Colors.blueAccent,
    'Travel expenses': Colors.lightGreenAccent,
    'Water bill': Colors.lightBlueAccent,
    'Electricity bill': Colors.yellow,
    'House cost': Colors.deepOrangeAccent,
    'Car fare': Colors.deepPurpleAccent,
    'Gasoline cost': Colors.orangeAccent,
    'Medical expenses': Colors.indigo,
    'Beauty expenses': Colors.black,
    'Cost of equipment': Colors.blue.shade100,
    'Other': Colors.teal.shade400,
    'Internet cost': Colors.pink,
  };

  List<PieChartSectionData> _createPieChartSections() {
    return dataMap.entries.map((entry) {
      return PieChartSectionData(
        color: typeToColor[entry.key] ?? Colors.grey,
        value: entry.value,
        title: entry.key,
        radius: 50,
        showTitle: false,
      );
    }).toList();
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chart',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Show expense types',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildIndicator(List<PieChartSectionData> pieChartSections) {
    return Column(
      children: pieChartSections.map((section) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: section.color,
              ),
            ),
            SizedBox(width: 8),
            Expanded( // ใช้ Expanded เพื่อให้ข้อความปรับขนาด
              child: Text(
                '${section.title} ${NumberFormat('#,##0.00').format(section.value)}',
                style: TextStyle(fontSize: 20),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
