import 'package:flutter/material.dart';
import 'package:morphable_shape/morphable_shape.dart';
import 'package:aurora_decoration/aurora_decoration.dart';

import 'dart:math';

class EditGradientPage extends StatefulWidget {
  const EditGradientPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<EditGradientPage> createState() => _EditGradientPageState();
}

class _EditGradientPageState extends State<EditGradientPage> {
  bool toggleStyle = true;

  var rng = Random();
  @override
  Widget build(BuildContext context) {
    List<Gradient>? gradients = [];
    List<double>? blurs = [];

    for (int i = 0; i < 3; i++) {
      Color joint = Color.fromARGB(rng.nextInt(100), rng.nextInt(255),
          rng.nextInt(255), rng.nextInt(255));
      gradients.add(SweepGradient(
          center: Alignment(
              (rng.nextDouble() - 0.5) * 2, (rng.nextDouble() - 0.5) * 2),
          colors: [
            joint,
            Colors.transparent,
            Color.fromARGB(rng.nextInt(100), rng.nextInt(255), rng.nextInt(255),
                rng.nextInt(255)),
            joint
          ],
          stops: [
            0,
            rng.nextDouble() * 0.4 + 0.2,
            rng.nextDouble() * 0.4 + 0.6,
            1,
          ]));
      blurs.add(rng.nextDouble() * 10 + 10);
    }

    for (int i = 0; i < 5; i++) {
      Color center = Color.fromARGB(rng.nextInt(200), rng.nextInt(255),
          rng.nextInt(255), rng.nextInt(255));
      gradients.add(RadialGradient(
          radius: rng.nextDouble() * 3 + 2,
          center: Alignment(
              (rng.nextDouble() - 0.5) * 2, (rng.nextDouble() - 0.5) * 2),
          colors: [
            center,
            Colors.transparent
          ],
          stops: [
            0,
            rng.nextDouble() * 0.4 + 0.2,
          ]));
      blurs.add(rng.nextDouble() * 5 + 5);
    }

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: AnimatedDecoratedShadowedShape(
          duration: Duration(seconds: 2),
          shape: RectangleShapeBorder(
              border: DynamicBorderSide(width: 2, color: Colors.black),
              borderRadius: DynamicBorderRadius.all(
                  DynamicRadius.circular(30.toPXLength))),
          decoration: AuroraDecoration(
              color: Color(0xFFd199ff),
              gradientBlurs: blurs,
              gradients: gradients),
          child: Container(
              width: 300,
              height: 300,
              alignment: Alignment.center,
              child: Text("Hello")),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            toggleStyle = !toggleStyle;
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
