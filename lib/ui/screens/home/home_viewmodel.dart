import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:websocket_demo_app/data/remote/services/binance_service.dart';
import 'package:websocket_demo_app/data/model/trade_model';

// Home ViewModel
class HomeViewModel extends ChangeNotifier {
  static const url = 'wss://stream.binance.com:9443/ws/btcusdt@trade';
  
  late final BinanceService _binanceService;
  Trade? _tradeData;

  Trade? get trade => _tradeData;

  HomeViewModel() {
    _binanceService = BinanceService(url);
    priceStreamListener();
  }

  void priceStreamListener() async {
    await _binanceService.channel.ready;
    _binanceService.channel.stream.listen((message) {
      Map<String, dynamic> data = jsonDecode(message);
      _tradeData = Trade.fromJson(data);
      notifyListeners();
    });
  }

  void closeBinanceService() {
    _binanceService.close();
  }
}