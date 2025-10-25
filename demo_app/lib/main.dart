import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.amber[100],
        appBar: AppBar(title: Text("my app"),leading: Icon(Icons.home), backgroundColor: Colors.amber, elevation: 0, actions: [
          Icon(Icons.logout)
        ],),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Hello World!'),
                SizedBox(height: 25.0,),
                ElevatedButton(
                  onPressed: ()=>{
                  print("i have been clicked")
                }, child: Text('Click me'))
              ]
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: ()=>{},
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.amber,
          items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "profile"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "settings"),
        ]),
      ),
    );
  }
}
