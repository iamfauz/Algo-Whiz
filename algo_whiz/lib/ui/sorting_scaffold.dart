import 'dart:async';
import 'dart:math';
import 'package:algo_whiz/paint/bar_painter.dart';
import 'package:algo_whiz/utils/colors.dart';
import 'package:flutter/material.dart';

const BUBBLE_SORT_KEY = "bubble";
const INSERTION_SORT_KEY = "selection";

class SortingScaffold extends StatefulWidget {
  SortingScaffold({Key key}) : super(key: key);

  @override
  _SortingScaffoldState createState() => _SortingScaffoldState();
}

class _SortingScaffoldState extends State<SortingScaffold> {
  List<int> _numbers = [];
  StreamController<List<int>> _streamController = StreamController();
  String _currentSortAlgo = INSERTION_SORT_KEY;
  double _sampleSize = 320;
  bool isSorted = false;
  bool isSorting = false;
  int speed = 0;
  static int duration = 1500;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Duration _getDuration() {
    return Duration(microseconds: duration);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sampleSize = MediaQuery.of(context).size.width / 2;
    for (int i = 0; i < _sampleSize; ++i) {
      _numbers.add(Random().nextInt(500));
    }
    setState(() {});
  }

  ///  Bubble Sort Algorithm
  void _bubbleSort() async {
    for (int i = 0; i < _numbers.length; ++i) {
      for (int j = 0; j < _numbers.length - i - 1; ++j) {
        if (_numbers[j] > _numbers[j + 1]) {
          int temp = _numbers[j];
          _numbers[j] = _numbers[j + 1];
          _numbers[j + 1] = temp;
        }

        await Future.delayed(_getDuration(), () {});

        _streamController.add(_numbers);
      }
    }
  }

  ///  Bubble Sort Algorithm
  void _selectionSort() async {
    for (int i = 0; i < _numbers.length; i++) {
      for (int j = i + 1; j < _numbers.length; j++) {
        if (_numbers[i] > _numbers[j]) {
          int temp = _numbers[j];
          _numbers[j] = _numbers[i];
          _numbers[i] = temp;
        }

        await Future.delayed(_getDuration(), () {});

        _streamController.add(_numbers);
      }
    }
  }

  _reset() {
    isSorted = false;
    _numbers = [];
    for (int i = 0; i < _sampleSize; ++i) {
      _numbers.add(Random().nextInt(500));
    }
    _streamController.add(_numbers);
  }

  _setSortAlgo(String type) {
    setState(() {
      _currentSortAlgo = type;
    });
  }

  _checkAndResetIfSorted() async {
    if (isSorted) {
      _reset();
      await Future.delayed(Duration(milliseconds: 200));
    }
  }

  String _getSortAlgoName() {
    switch (_currentSortAlgo) {
      case BUBBLE_SORT_KEY:
        return "Bubble Sort";
        break;
      case INSERTION_SORT_KEY:
        return "Selection Sort";
        break;
      default:
        return "Sort";
    }
  }

  void _changeSpeed() {
    if (speed >= 3) {
      speed = 0;
      duration = 1500;
    } else {
      speed++;
      duration = duration ~/ 2;
    }

    print(speed.toString() + " " + duration.toString());
    setState(() {});
  }

  _sort() async {
    setState(() {
      isSorting = true;
    });

    await _checkAndResetIfSorted();

    Stopwatch stopwatch = new Stopwatch()..start();

    switch (_currentSortAlgo) {
      case BUBBLE_SORT_KEY:
        await _bubbleSort();
        break;

      case INSERTION_SORT_KEY:
        await _selectionSort();
        break;
    }

    stopwatch.stop();

    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          "Sorting completed in ${stopwatch.elapsed.inMilliseconds} ms.",
        ),
      ),
    );
    setState(() {
      isSorting = false;
      isSorted = true;
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text(_getSortAlgoName()),
          backgroundColor: primaryColor,
          actions: <Widget>[
            PopupMenuButton<String>(
              initialValue: _currentSortAlgo,
              itemBuilder: (ctx) {
                return [
                  PopupMenuItem(
                    value: 'bubble',
                    child: Text("Bubble Sort"),
                  ),
                  PopupMenuItem(
                    value: 'selection',
                    child: Text("Selection Sort"),
                  ),
                ];
              },
              onSelected: (String value) {
                _reset();
                _setSortAlgo(value);
              },
            )
          ]),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 0.0),
          child: StreamBuilder<Object>(
              initialData: _numbers,
              stream: _streamController.stream,
              builder: (context, snapshot) {
                List<int> numbers = snapshot.data;
                int counter = 0;

                return Row(
                  children: numbers.map((int num) {
                    counter++;
                    return Container(
                      child: CustomPaint(
                        painter: SortingBarPainter(
                            index: counter,
                            value: num,
                            width: MediaQuery.of(context).size.width /
                                _sampleSize),
                      ),
                    );
                  }).toList(),
                );
              }),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            Expanded(
                child: FlatButton(
                    onPressed: isSorting
                        ? null
                        : () {
                            _reset();
                            _setSortAlgo(_currentSortAlgo);
                          },
                    child: Text("RESET"))),
            Expanded(
                child: FlatButton(
                    onPressed: _changeSpeed,
                    child: Text(
                      "${speed + 1}x",
                      style: TextStyle(fontSize: 20),
                    ))),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: isSorting ? null : _sort,
          child: Icon(Icons.play_arrow),
          backgroundColor: Color(0xFF3b3b98)),
    );
  }
}
