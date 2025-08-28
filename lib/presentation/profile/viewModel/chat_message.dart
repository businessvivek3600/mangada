
import '../../../core/constants/enums.dart';

class ChatMessage {
  final String id;
  final String text;
  final Sender sender;
  final DateTime createdAt;

  ChatMessage({
    required this.id,
    required this.text,
    required this.sender,
    required this.createdAt,
  });
}