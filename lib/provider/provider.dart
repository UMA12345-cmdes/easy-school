import 'package:flutter/foundation.dart';

class ProviderData with ChangeNotifier{
  final List<Messages> _messages = [
    Messages(isMe: true, message: 'Message sent by me'),
    Messages(isMe: false, message: 'Message sent by others'),
    Messages(isMe: true, message: 'Message sent by me'),
    Messages(isMe: false, message: 'Message sent by others'),
  ];
  List<Messages> get messages {
    return [..._messages];
    notifyListeners();
  }
}


class Messages {
  final String message;
  final bool isMe;

  Messages({
    required this.isMe,
    required this.message,
  });
}
