import 'package:chat_mobile/ui/home/providers/delete_chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatsPage extends ConsumerStatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  ChatsPageState createState() => ChatsPageState();
}

class ChatsPageState extends ConsumerState<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    final deleteChat = ref.watch(deleteChatProvider('sajio'));

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: deleteChat.when(data: ((data) {
            return Text('${data.failure}');
          }), error: (error, s) {
            return Text('error $error');
          }, loading: () {
            return const CircularProgressIndicator();
          }),
        ),
      ),
    );
  }
}
