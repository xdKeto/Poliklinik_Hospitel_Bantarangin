import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:poli_admin/base/utils/config.dart';

class WebSocketManager {
  static final WebSocketManager _instance = WebSocketManager._internal();
  factory WebSocketManager() => _instance;

  WebSocketManager._internal();

  WebSocketChannel? _channel;
  bool _isConnected = false;
  Timer? _reconnectTimer;
  final StreamController<Map<String, dynamic>> _messageStreamController =
      StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get messageStream =>
      _messageStreamController.stream;

  bool get isConnected => _isConnected;

  Future<void> connect() async {
    if (_isConnected) return;

    try {
      final wsUrl = Config.apiEndpoints['wsUrl']!(); 
      _channel = WebSocketChannel.connect(Uri.parse(wsUrl));

      _channel!.stream.listen(
        (dynamic message) {
          _handleMessage(message);
        },
        onError: (error) {
          print('WebSocket error: $error');
          _handleDisconnection();
        },
        onDone: () {
          print('WebSocket connection closed');
          _handleDisconnection();
        },
      );

      _isConnected = true;
      print('WebSocket connected');
    } catch (e) {
      print('WebSocket connection error: $e');
      _handleDisconnection();
    }
  }

  void _handleMessage(dynamic message) {
    try {
      final Map<String, dynamic> parsedMessage =
          message is String ? json.decode(message) : message;
      _messageStreamController.add(parsedMessage);
    } catch (e) {
      print('Error parsing WebSocket message: $e');
    }
  }

  void _handleDisconnection() {
    _isConnected = false;
    _channel?.sink.close();
    _channel = null;

    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(Duration(seconds: 5), connect);
  }

  void disconnect() {
    _reconnectTimer?.cancel();
    _isConnected = false;
    _channel?.sink.close();
    _channel = null;
  }

  void dispose() {
    disconnect();
    _messageStreamController.close();
  }
}
