import 'package:whatsapp_clone/common/enum/message_enum.dart';

class Message {
  final String senderId;
  final String reciverId;
  final String text;
  final String messageId;
  final MessageEnum type;
  final bool isSeen;
  final DateTime timeSent;
  final String replyedMessage;
  final String replyedTo;
  final MessageEnum replyedMessageType;

  Message({
    required this.senderId,
    required this.reciverId,
    required this.text,
    required this.messageId,
    required this.type,
    required this.isSeen,
    required this.timeSent,
    required this.replyedMessage,
    required this.replyedMessageType,
    required this.replyedTo,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'reciverId': reciverId,
      'text': text,
      'messageId': messageId,
      'type': type.type,
      'isSeen': isSeen,
      'timeSent': timeSent.microsecondsSinceEpoch,
      'replyedTo': replyedTo,
      'replyedMessage': replyedMessage,
      'replyedMessageType': replyedMessageType.type,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] ?? '',
      reciverId: map['reciverId'] ?? '',
      text: map['text'] ?? '',
      messageId: map['messageId'] ?? '',
      type: (map['type'] as String).toEnum(),
      isSeen: map['isSeen'] ?? false,
      timeSent: DateTime.fromMicrosecondsSinceEpoch(map['timeSent']),
      replyedMessage: map['replyedMessage'] ?? '',
      replyedMessageType: (map['replyedMessageType'] as String).toEnum(),
      replyedTo: map['replyedTo'] ?? '',
    );
  }
}
