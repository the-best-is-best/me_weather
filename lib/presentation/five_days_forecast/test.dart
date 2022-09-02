// import 'package:flutter/material.dart';

// class Test extends StatelessWidget {
//   const Test({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(18),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Color(0xff8cbaec),
//           borderRadius: const BorderRadius.all(
//             Radius.circular(50),
//           ),
//           border: Border.all(
//             width: 0,
//             color: Color(0xff8cbaec),
//             style: BorderStyle.solid,
//           ),
//         ),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 30,
//             ),
//             SizedBox(
//               height: 90,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 shrinkWrap: true,
//                 itemCount: 7, //numberofcontainers[index],
//                 itemBuilder: (BuildContext context, int index2) {
//                   return Padding(
//                     padding: const EdgeInsets.only(left: 20),
//                     child: SingleChildScrollView(
//                       child: Container(
//                         child: SizedBox(
//                           width: 58,
//                           child: Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Text(
//                                     '${index2 + 3}',
//                                     style: const TextStyle(
//                                         fontSize: 22, color: Colors.white),
//                                   ),

//                                   const Text(
//                                     ' pm',
//                                     style: TextStyle(
//                                         fontSize: 22, color: Colors.white),
//                                   ),

//                                   //Image.asset("assets/img/person.jpeg")
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               (index2 < 4)
//                                   ? Image.asset("assets/img/sun.png")
//                                   : Image.asset("assets/img/moon2.png")
//                             ],
//                           ),
//                         ),
//                         //SizedBox(width: 55,)
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Container(
//               height: 170,
//               child: SfCartesianChart(
//                 primaryXAxis: CategoryAxis(
//                   isVisible: false,
//                   majorGridLines: MajorGridLines(
//                     width: 0,
//                   ),
//                 ),

//                 primaryYAxis: CategoryAxis(
//                   isVisible: false,
//                   //visibleMinimum:20,
//                   labelPlacement: LabelPlacement.betweenTicks,

//                   majorGridLines: MajorGridLines(width: 0),
//                 ),

//                 //borderWidth: 18,
//                 margin: EdgeInsets.only(top: 20, left: 20, bottom: 15),
//                 borderColor: Color(0xff8cbaec),
//                 plotAreaBorderColor: Color(0xff8cbaec),

//                 // Sets 15 logical pixels as margin for all the 4 sides.

//                 //title: ChartTitle(text: 'Half Yearly Sales Analysis'),
//                 enableSideBySideSeriesPlacement: false,

//                 legend: Legend(
//                   isVisible: false,
//                 ),
//                 tooltipBehavior: TooltipBehavior(enable: false),
//                 series: <CartesianSeries>[
//                   LineSeries<SalesData, String>(
//                     isVisibleInLegend: false,
//                     dataSource: data,

//                     xValueMapper: (SalesData sales, _) => sales.month,
//                     yValueMapper: (SalesData sales, _) => sales.sales,

//                     name: '',
//                     color: Colors.white,

//                     dataLabelSettings: const DataLabelSettings(
//                       isVisible: true,

//                       alignment: ChartAlignment.center,
//                       opacity: 20,
//                       labelPosition: ChartDataLabelPosition.outside,
//                       labelAlignment: ChartDataLabelAlignment.top,

//                       textStyle: TextStyle(
//                           fontSize: 22,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold),

//                       // builder: (dynamic data, dynamic point, dynamic series, int pointIndex, int seriesIndex) {
//                       //   return Container(
//                       //       height: 30,
//                       //       width: 30,
//                       //       child: Image.asset('assets/img/person.jpeg')
//                       //   );
//                       // }
//                     ),

//                     //dataLabelMapper:(SalesData sales, _)
//                     //=> sales.month ,

//                     markerSettings: MarkerSettings(isVisible: true, width: 6),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 45,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 shrinkWrap: true,
//                 itemCount: 7, //numberofcontainers[index],
//                 itemBuilder: (BuildContext context, int index2) {
//                   return Padding(
//                     padding: const EdgeInsets.only(left: 20),
//                     child: SingleChildScrollView(
//                       child: Container(
//                         child: SizedBox(
//                           width: 57,
//                           child: Row(
//                             children: [
//                               Container(
//                                 child: Image.asset("assets/img/water.png"),
//                                 width: 22,
//                               ),

//                               const Text(
//                                 ' 0%',
//                                 style: TextStyle(
//                                     fontSize: 22, color: Colors.white),
//                               ),

//                               //Image.asset("assets/img/person.jpeg")
//                             ],
//                           ),
//                         ),
//                         //SizedBox(width: 55,)
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
