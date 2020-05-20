import 'package:flutter/material.dart';
import 'package:imageview360/imageview360.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Menu Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: DemoPage(title: 'Food Menu'),
    );
  }
}

class DemoPage extends StatefulWidget {
  DemoPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  List<AssetImage> imageList = List<AssetImage>();
  bool autoRotate = true;
  int rotationCount = 2;
  int swipeSensitivity = 2;
  bool allowSwipeToRotate = true;
  RotationDirection rotationDirection = RotationDirection.anticlockwise;
  Duration frameChangeDuration = Duration(milliseconds: 50);
  bool imagePrecached = false;

  @override
  void initState() {
    //* To load images from assets after first frame build up.
    WidgetsBinding.instance
        .addPostFrameCallback((_) => updateImageList(context));
    super.initState();
  }

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
            (imagePrecached == true)
                ? ImageView360(
                    key: UniqueKey(),
                    imageList: imageList,
                    autoRotate: autoRotate,
                    rotationCount: rotationCount,
                    rotationDirection: RotationDirection.anticlockwise,
                    frameChangeDuration: Duration(milliseconds: 30),
                    swipeSensitivity: swipeSensitivity,
                    allowSwipeToRotate: allowSwipeToRotate,
                  )
                : Text("Pre-Caching images..."),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "French Fries",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text("Air Fried French Fries"),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text("Serve: Max 2"),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text("Cost: 150/-"),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                  "Payment options: All Digital Wallets available."),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text("Swipe to interact with dish"),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text("Enjoy the Experience."),
            ),
          ],
        ),
      ),
    );
  }

  void updateImageList(BuildContext context) async {
    for (int i = 1; i <= 52; i++) {
      imageList.add(AssetImage('assets/sample/$i.png'));
      //* To precache images so that when required they are loaded faster.
      await precacheImage(AssetImage('assets/sample/$i.png'), context);
    }
    setState(() {
      imagePrecached = true;
    });
  }
}
