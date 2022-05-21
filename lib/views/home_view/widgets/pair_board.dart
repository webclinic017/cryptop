import 'package:carousel_slider/carousel_slider.dart';
import 'package:cryptop/components/loading_animation/loading_animation.dart';
import 'package:cryptop/components/text_component/text_component.dart';
import 'package:cryptop/components/line_chart/home_line_chart.dart';
import 'package:cryptop/models/chart_model.dart';
import 'package:cryptop/models/ticker_model.dart';
import 'package:cryptop/views/home_view/widgets/home_line_chart_details.dart';
import 'package:cryptop/views/home_view/widgets/home_line_chart_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PairBoard extends StatelessWidget {
  const PairBoard({
    this.activeBoard,
    Key? key,
    this.data,
    this.setIndex,
    this.tickers,
  }) : super(key: key);

  final int? activeBoard;
  final Function? setIndex;
  final List<Chart>? data;
  final List<Ticker>? tickers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50.0,
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextComponent(
                align: TextAlign.start,
                fontSize: 14.0,
                line: 1,
                textColor: Colors.black,
                title: 'Market Update',
                weight: FontWeight.w600,
              ),
              InkWell(
                onTap: () => {},
                child: const TextComponent(
                  align: TextAlign.start,
                  fontSize: 14.0,
                  line: 1,
                  textColor: Colors.black,
                  title: 'See all',
                  weight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 200.0,
          color: const Color.fromRGBO(55, 61, 76, 1),
          child: tickers == null || data == null
              ? LoadingAnimation()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: CarouselSlider.builder(
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 1,
                          onPageChanged: (index, value) => setIndex!(index),
                        ),
                        itemCount: data!.length,
                        itemBuilder: (context, y, index) {
                          return Stack(
                            children: [
                              HomeLineChart(
                                height: 100.0,
                                data: data![activeBoard!]
                                    .candles!
                                    .map((e) => FlSpot(
                                        e.date.millisecondsSinceEpoch
                                            .toDouble(),
                                        e.close))
                                    .toList(),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 24.0),
                                  child: TextComponent(
                                    align: TextAlign.center,
                                    fontSize: 16.0,
                                    line: 1,
                                    textColor:
                                        const Color.fromARGB(255, 35, 136, 41),
                                    title: tickers!
                                        .where((element) =>
                                            element.symbol ==
                                            data![activeBoard!].symbol)
                                        .first
                                        .lastPrice
                                        .toString(),
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              HomeLineChartDetails(
                                ticker: tickers!
                                    .where((element) =>
                                        element.symbol ==
                                        data![activeBoard!].symbol)
                                    .first,
                                chart: data![activeBoard!],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    HomeLineChartSlider(
                      activeBoard: activeBoard!,
                      length: data!.length,
                    )
                  ],
                ),
        ),
      ],
    );
  }
}
