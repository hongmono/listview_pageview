import 'package:flutter/material.dart';
import 'package:listview_test/card_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 500,
            child: CardView(
              space: 8,
              padding: const EdgeInsets.all(16),
              expandedChildren: [
                Container(
                  color: Colors.red,
                  child: const Center(
                    child: Text('Expanded 1'),
                  ),
                ),
                Container(
                  color: Colors.blue,
                  child: const Center(
                    child: Text('Expanded 2'),
                  ),
                ),
                Container(
                  color: Colors.green,
                  child: const Center(
                    child: Text('Expanded 3'),
                  ),
                ),
                Container(
                  color: Colors.yellow,
                  child: const Center(
                    child: Text('Expanded 4'),
                  ),
                ),
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.grey,
                        ),
                        child: const Center(
                          child: Text('Expanded 6'),
                        ),
                      ),
                    ),
                    TextButton(onPressed: () {}, child: const Text('asdf')),
                  ],
                ),
              ],
              children: [
                Container(
                  color: Colors.red,
                  child: const Center(
                    child: Text('List 1'),
                  ),
                ),
                Container(
                  color: Colors.blue,
                  child: const Center(
                    child: Text('List 2'),
                  ),
                ),
                Container(
                  color: Colors.green,
                  child: const Center(
                    child: Text('List 3'),
                  ),
                ),
                Container(
                  color: Colors.purple,
                  child: const Center(
                    child: Text('List 5'),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.grey,
                  ),
                  child: const Center(
                    child: Text('List 6'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
