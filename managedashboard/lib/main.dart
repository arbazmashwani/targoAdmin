import 'package:flutter/material.dart';
import 'package:managedashboard/database/firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:managedashboard/screens/homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> initialize =
        Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: FutureBuilder(
            future: initialize,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.connectionState == ConnectionState.done) {
                  return const HomePageChart();
                }
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}
