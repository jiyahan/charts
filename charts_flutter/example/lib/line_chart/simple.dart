// Copyright 2018 the Charts project authors. Please see the AUTHORS file
// for details.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// Example of a simple line chart.
// EXCLUDE_FROM_GALLERY_DOCS_START
import 'dart:math';
// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleLineChart extends StatelessWidget {
  final List<charts.Series<dynamic, num>> seriesList;
  final bool animate;

  SimpleLineChart(this.seriesList, {this.animate = false});

  /// Creates a [LineChart] with sample data and no transition.
  factory SimpleLineChart.withSampleData() {
    return new SimpleLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
  factory SimpleLineChart.withRandomData() {
    return new SimpleLineChart(_createRandomData());
  }

  /// Create random data.
  static List<charts.Series<LinearSales, num>> _createRandomData() {
    final random = new Random();

    final data = [
      new LinearSales(0, random.nextInt(100)),
      new LinearSales(1, random.nextInt(100)),
      new LinearSales(2, random.nextInt(100)),
      new LinearSales(3, random.nextInt(100)),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(
      seriesList,
      animate: animate,
      defaultRenderer: charts.LineRendererConfig(
        // 折线图绘制的配置
        includeArea: true,
        includePoints: true,
        includeLine: true,
        stacked: false,
        strokeWidthPx: 1.0,
      ),
      domainAxis: charts.NumericAxisSpec(
        // 主轴的配置
        // tickFormatterSpec:
        //     charts.DomainFormatterSpec(dateRange), // tick 值的格式化，这里把 num 转换成 String
        renderSpec: charts.SmallTickRendererSpec(
          // 主轴绘制的配置
          tickLengthPx: 3, // 刻度标识突出的长度
          labelOffsetFromAxisPx: 5, // 刻度文字距离轴线的位移
          // labelStyle: charts.TextStyleSpec(
          //   // 刻度文字的样式
          //   //color: ChartUtil.getChartColor(HColors.lightGrey),
          //   //fontSize: HFontSizes.smaller.toInt(),
          // ),
          // axisLineStyle: charts.LineStyleSpec(
          //   // 轴线的样式
          //   color: Color.fromARGB(a, r, g, b),
          // ),
        ),
        tickProviderSpec: charts.BasicNumericTickProviderSpec(
          // 轴线刻度配置
          zeroBound: false,
          dataIsInWholeNumbers: false,
          desiredTickCount: seriesList.length, // 期望显示几个刻度
        ),
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 5),
      new LinearSales(1, 25),
      new LinearSales(2, 100),
      new LinearSales(3, 75),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
