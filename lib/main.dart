import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

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
      body: CardView(),
    );
  }
}

class CardView extends StatefulWidget {
  const CardView({super.key});

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: List.generate(
          5,
          (index) => AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            top: selectedIndex == index ? 0 : index * 60,
            left: 0,
            right: 0,
            height: selectedIndex == index ? 290 : 50,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (selectedIndex == null) {
                    selectedIndex = index;
                  } else {
                    selectedIndex = null;
                  }
                });
              },
              child: AnimatedOpacity(
                opacity: selectedIndex == null
                    ? 1
                    : selectedIndex == index
                        ? 1
                        : 0,
                duration: const Duration(milliseconds: 300),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(child: Text('$index')),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
