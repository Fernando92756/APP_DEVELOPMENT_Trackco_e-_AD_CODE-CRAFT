import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(StopwatchApp());

class StopwatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cronômetro Simples',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: StopwatchHomePage(),
    );
  }
}

class StopwatchHomePage extends StatefulWidget {
  @override
  _StopwatchHomePageState createState() => _StopwatchHomePageState();
}

class _StopwatchHomePageState extends State<StopwatchHomePage> {
  late Stopwatch _stopwatch;
  late Timer _timer;

  String _formattedTime = "00:00:000";

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      if (_stopwatch.isRunning) {
        setState(() {
          _formattedTime = _formatTime(_stopwatch.elapsedMilliseconds);
        });
      }
    });
  }

  String _formatTime(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate() % 100;
    int seconds = (milliseconds / 1000).truncate() % 60;
    int minutes = (milliseconds / (1000 * 60)).truncate();

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    String hundredsStr = hundreds.toString().padLeft(3, '0');

    return "$minutesStr:$secondsStr:$hundredsStr";
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _start() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
    }
  }

  void _pause() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
    }
  }

  void _reset() {
    _stopwatch.reset();
    setState(() {
      _formattedTime = "00:00:000";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cronômetro Simples'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              _formattedTime,
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _start,
                child: Text('Iniciar'),
                style: ElevatedButton.styleFrom(primary: Colors.green),
              ),
              ElevatedButton(
                onPressed: _pause,
                child: Text('Pausar'),
                style: ElevatedButton.styleFrom(primary: Colors.orange),
              ),
              ElevatedButton(
                onPressed: _reset,
                child: Text('Resetar'),
                style: ElevatedButton.styleFrom(primary: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
