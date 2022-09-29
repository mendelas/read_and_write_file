import 'package:flutter/material.dart';
// riverpod を使う場合は忘れずに pubspec.yaml を編集して pub get
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'io_controller.dart';


void main(){//変更箇所20220827
  runApp(
    const ProviderScope(
        child: IoPage(),///https://zenn.dev/junki555/articles/17382e2862c46b
    ),
  );
}

// ページは描画しているだけなので詳しい内容はコントローラーへ GO
class IoPage extends ConsumerWidget {
  const IoPage({Key? key}) : super(key: key);
  static const String title = '外部データの入出力';
  //static const items = <String>[];
  static const double _appBarBottomBtnPosition = 0.0;//change this value to position your button vertically
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _ioProvider = ref.watch(ioProvider);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Scaffold(
            /*appBar: AppBar(
              title: const Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),*/
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  /*title: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),*/

                  floating: true,
                  flexibleSpace: Placeholder(),
                  expandedHeight: 200,

                  actions: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'アプリのローカルパス: \n${_ioProvider.appPath}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 8,
                              overflow: TextOverflow.ellipsis,//いい感じに折り返してくれる．．．できてないけど
                            ),
                          ),
                          SizedBox(
                                height: 25,
                                child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Text(
                                    _ioProvider.content,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      overflow: TextOverflow.ellipsis,//いい感じに折り返してくれる
                                    ),
                                  ),
                                )),
                        ],
                      ),
                  ],
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(0.0),
                    child: Transform.translate(
                      offset: const Offset(0, _appBarBottomBtnPosition),
                      child: ElevatedButton(
                        onPressed: () async {
                          await _ioProvider.write();
                          await _ioProvider.read();
                        },
                        child: Text('いまの時間を書き込む'),
                      ),
                    ),
                  ),
                ),

                SliverList(delegate: SliverChildBuilderDelegate(
                      (context, index) => ListTile(title: Text(
                          'Item #$index ${_ioProvider.content}',
                      )),
                ),
                ),
              ]
            ),
            ),
          );
  }
}