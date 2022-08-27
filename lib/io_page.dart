import 'package:flutter/material.dart';
// riverpod を使う場合は忘れずに pubspec.yaml を編集して pub get
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'io_controller.dart';

void main(){//変更箇所20220827
  runApp(
    ProviderScope(
        child: const IoPage(),///https://zenn.dev/junki555/articles/17382e2862c46b
    ),
  );
}

// ページは描画しているだけなので詳しい内容はコントローラーへ GO
class IoPage extends ConsumerWidget {
  const IoPage({Key? key}) : super(key: key);
  static const String title = '外部データの入出力';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _ioProvider = ref.watch(ioProvider);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Scaffold(
            appBar: AppBar(
              title: const Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('アプリのローカルパス: \n${_ioProvider.appPath}'),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                        height: 25,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            _ioProvider.content,
                          ),
                        )),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await _ioProvider.write();
                        await _ioProvider.read();
                      },
                      child: const Text('いまの時間を書き込む'),
                    ),

                  ),
                ],
              ),
            ),
          ),
      );
  }
}