import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '03_chart_color.dart';
import '03_realtime_changes.dart';

final Stream<QuerySnapshot> usersStream =
    FirebaseFirestore.instance.collection('users').snapshots();

class ChartPage extends StatefulWidget {
  const ChartPage();

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            colors: [
              const Color(0xffe4a972).withOpacity(0.6),
              Color.fromARGB(255, 41, 144, 162).withOpacity(0.6),
            ],
            stops: const [
              0.0,
              1.0,
            ],
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Graph'),
            leading: IconButton(
              icon: Icon(Icons.backspace),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                colors: [
                  const Color(0xffe4a972).withOpacity(1.0),
                  Color.fromARGB(255, 41, 144, 162).withOpacity(1.0),
                ],
                stops: const [
                  0.0,
                  1.0,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("データ数総計：", style: TextStyle(fontSize: 20)),
                    Text(
                      (youbi_amount_List[0] +
                              youbi_amount_List[1] +
                              youbi_amount_List[2] +
                              youbi_amount_List[3] +
                              youbi_amount_List[4] +
                              youbi_amount_List[5] +
                              youbi_amount_List[6])
                          .toString(),
                      style: TextStyle(fontSize: 30, fontFamily: 'bananas'),
                    ),
                  ],
                ),
                Expanded(
                  flex: 5,
                  child: BarChart(
                    BarChartData(
                      barTouchData: barTouchData,
                      titlesData: titlesData,
                      borderData: borderData,
                      barGroups: barGroups,
                      backgroundColor: Colors.white.withOpacity(1),
                      gridData: const FlGridData(show: true),
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                fontSize: 20,
                fontFamily: 'bananas',
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: AppColors.contentColorBlue.darken(20),
      fontWeight: FontWeight.bold,
      fontFamily: 'bananas',
      fontSize: 20,
    );
    String text;

    switch (value.toInt()) {
      case 0:
        text = 'Sun';
        break;
      case 1:
        text = 'Mon';
        break;
      case 2:
        text = 'Tue';
        break;
      case 3:
        text = 'Wed';
        break;
      case 4:
        text = 'Thu';
        break;
      case 5:
        text = 'Fri';
        break;
      case 6:
        text = 'Sat';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 20,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 100,
            getTitlesWidget: getTitles,
          ),
        ),

// leftTitles: SideTitles(
//     // 縦軸値の表示制御
//     checkToShowTitle: bool Function(double minValue, double maxValue, SideTitles sideTitles, double appliedInterval, double value);
//   ),

        leftTitles: const AxisTitles(
            sideTitles: SideTitles(reservedSize: 30, showTitles: true),
            axisNameSize: 30),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          AppColors.contentColorBlue.darken(20),
          Color.fromARGB(255, 18, 28, 216),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  double graphWidth = 25;
  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              width: graphWidth,
              toY: youbi_amount_List[0].toDouble(),
              gradient: _barsGradient,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              width: graphWidth,
              toY: youbi_amount_List[1].toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              width: graphWidth,
              toY: youbi_amount_List[2].toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              width: graphWidth,
              toY: youbi_amount_List[3].toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              width: graphWidth,
              toY: youbi_amount_List[4].toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              width: graphWidth,
              toY: youbi_amount_List[5].toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              width: graphWidth,
              toY: youbi_amount_List[6].toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}

class BarChartSample3 extends StatefulWidget {
  const BarChartSample3({super.key});

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const AspectRatio(
        aspectRatio: 4.6,
        child: ChartPage(),
      ),
    );
  }
}
