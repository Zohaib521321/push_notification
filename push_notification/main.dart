import 'package:firebase/login_logout/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
Future<void> backgroundHandler(RemoteMessage message) async{
  print(message.data.toString());
  print(message.notification!.title);
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
        options: const FirebaseOptions(apiKey: "",
          appId: "",
          messagingSenderId: "",
          projectId: "",
          storageBucket: "f",
          databaseURL: "",
          measurementId: "G-152CRVZ7BS",
        )
    );
  }else{
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  }
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void initializemessage()async{
RemoteMessage?message =await FirebaseMessaging.instance.getInitialMessage();
 if (message!=null) {
   if (message.data["page"]=="email") {
     Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));

   }
   else{
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
       content: Text(message.notification!.title.toString()),duration: Duration(seconds: 10),backgroundColor: Colors.redAccent,

     ));
   }
 }  
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   initializemessage();
    FirebaseMessaging.onMessage.listen((message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message.notification!.title.toString()),duration: Duration(seconds: 5),backgroundColor: Colors.redAccent,

      ));
    });
FirebaseMessaging.onMessageOpenedApp.listen((message){
Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
    });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:
Text("hi")
    );
  }
}
