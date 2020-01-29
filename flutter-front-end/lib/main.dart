
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter File Upload Example',
      home: MyHomePage(title: 'Flutter File Upload Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<String> uploadImage(filename) async {
    var request = http.MultipartRequest('POST', Uri.parse('http://192.168.1.156:3000/upload'));
    request.files.add(await http.MultipartFile.fromPath('n', filename));
    var res = await request.send();
    return res.reasonPhrase;
  }
  String state = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(state)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var file = await ImagePicker.pickImage(source: ImageSource.gallery);
          var res = await uploadImage(file.path);
          setState(() {
            state = res;
            print(res);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
