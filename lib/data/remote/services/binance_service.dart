import 'package:web_socket_channel/web_socket_channel.dart';

// Binance Service
class BinanceService {
  late final WebSocketChannel _channel;

  BinanceService(String url) { 
    try {
       _channel = WebSocketChannel.connect(Uri.parse(url));
    } catch (error) {
        print('Error fetching data: $error');
    }
  }

  WebSocketChannel get channel => _channel;

  void close() {
    _channel.sink.close();
  }

}