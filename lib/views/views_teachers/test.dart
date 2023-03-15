import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_summernote/flutter_summernote.dart';

class Test extends StatefulWidget {
  const Test({required this.title});

  final String title;

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  GlobalKey<FlutterSummernoteState> _keyEditor = GlobalKey();
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              final value = (await _keyEditor.currentState?.getText());
              print(value);
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //   duration: Duration(seconds: 5),
              //   content: Text(value ?? '-'),
              // ));
            },
          )
        ],
      ),
      backgroundColor: Colors.amber,
      body: FlutterSummernote(
        hint: 'Your text here...',
        key: _keyEditor,
        hasAttachment: true,
        customToolbar: """
          [
            ['style', ['style']],
            ['font', ['bold', 'underline', 'clear']],
            ['fontname', ['fontname']],
            ['color', ['color']],
            ['para', ['ul', 'ol', 'paragraph']],
            ['table', ['table']],
            ['insert', ['link', 'picture', 'video']],
            ['view', ['fullscreen', 'codeview', 'help']],
          ]
        """,
      ),
    );
  }
}
