import 'package:cryptop/viewmodels/chart_viewmodel/chart_action.dart';
import 'package:cryptop/viewmodels/ticker_viewmodel/ticker_action.dart';
import 'package:cryptop/views/coin_view/widgets/coin_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoinView extends StatefulWidget {
  const CoinView({Key? key, this.data}) : super(key: key);

  final Object? data;
  @override
  State<CoinView> createState() => _CoinViewState();
}

class _CoinViewState extends State<CoinView> {
  // ignore: avoid_print
  setTradeType(value) => setState(() => print(value));

  @override
  void initState() {
    context.read(chartViewmodel).coin = widget.data.toString();
    context.read(chartViewmodel).interval = '4h';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: const Color.fromRGBO(55, 61, 76, 1),
          child: Consumer(
            builder: (context, watch, child) {
              watch(klineProvider).whenData(
                  (value) => watch(chartViewmodel).updateCandle(value));
              watch(messageProvider).whenData(
                  (value) => watch(tickerViewmodel).updateTickers(value));

              final chart = watch(getKlines).data?.value;
              final fcharts = watch(chartViewmodel).favoriteCharts;
              final tickers = watch(tickerViewmodel).tickers;

              return CoinBody(
                chart: chart,
                fcharts: fcharts,
                tickers: tickers,
                title: widget.data.toString(),
                setTradeType: setTradeType,
              );
            },
          ),
        ),
      ),
    );
  }
}
