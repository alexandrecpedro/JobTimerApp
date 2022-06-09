import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProjectPieChart extends StatelessWidget {
  /** **/
  /** Constructor **/
  const ProjectPieChart({super.key});

  /** Methods **/
  @override
  Widget build(BuildContext context) {
    // Variable
    final theme = Theme.of(context);

    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        fit: StackFit.loose,
        children: [
          PieChart(
            PieChartData(
              // graphic values
              sections: [
                PieChartSectionData(
                  value: 50,
                  color: theme.primaryColor,
                  showTitle: true,
                  title: '50h',
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PieChartSectionData(
                  value: 150,
                  color: theme.primaryColorLight,
                  showTitle: true,
                  title: '150h',
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              '200h',
              style: TextStyle(
                fontSize: 25,
                color: theme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
