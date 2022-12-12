import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/enum/message_enum.dart';
import 'package:whatsapp_clone/common/providers/message_reply_provider.dart';
import 'package:whatsapp_clone/features/chat/widgets/display_image_file_GIF.dart';

class MessageReplyPreview extends ConsumerWidget {
  const MessageReplyPreview({super.key});
  void cancelReply(WidgetRef ref) {
    ref.read(messageRepplyProvider.notifier).update((state) => null);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageReply = ref.watch(messageRepplyProvider);
    return Container(
      width: 350,
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  messageReply!.isMe ? 'Me' : 'opposite',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              GestureDetector(
                child: IconButton(
                    onPressed: () => cancelReply(ref),
                    icon: const Icon(Icons.close)),
              ),
            ],
          ),
          Text(messageReply.messageType.toString()),
          const SizedBox(
            height: 10,
          ),
          DisplyImageFileGIF(
              message: messageReply.message, type: messageReply.messageType),
        ],
      ),
    );
  }
}
