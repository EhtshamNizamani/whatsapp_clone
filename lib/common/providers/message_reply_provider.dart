import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/enum/message_enum.dart';

class MessageReply {
  final String message;
  final MessageEnum messageType;
  final bool isMe;

  MessageReply(this.message, this.messageType, this.isMe);
}

final messageRepplyProvider = StateProvider<MessageReply?>((ref) => null);
