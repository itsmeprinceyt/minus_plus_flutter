import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Counter App',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const PortraitOnly(child: CounterScreen()),
    );
  }
}

class PortraitOnly extends StatelessWidget {
  final Widget child;

  const PortraitOnly({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.screen_rotation,
                      size: 80,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Please rotate your device',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'This app only works in portrait mode',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 255, 255, 0.1),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: BorderSide(
                            color: Color.fromRGBO(255, 255, 255, 0.3),
                          ),
                        ),
                      ),
                      icon: const Icon(Icons.phone_android, size: 16),
                      label: const Text(
                        'Rotate to Portrait',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return child;
      },
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = _prefs.getInt('counter') ?? 0;
    });
  }

  Future<void> _saveCounter() async {
    await _prefs.setInt('counter', _counter);
  }

  void _incrementCounter() {
    setState(() {
      if (_counter < 1000000000000000) {
        _counter++;
      }
      _saveCounter();
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
        _saveCounter();
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _saveCounter();
    });
  }

  String _formatNumber(int number) {
    const thresholds = [
      1000, // K
      1000000, // Million
      1000000000, // Billion
      1000000000000, // Trillion
      1000000000000000, // Quadrillion (max)
    ];
    const suffixes = ['', 'K', 'M', 'B', 'T', 'Q'];

    if (number >= 1000000000000000) {
      return "MAX REACHED!";
    }

    int suffixIndex = 0;
    double formattedNumber = number.toDouble();

    for (int i = thresholds.length - 1; i >= 0; i--) {
      if (number >= thresholds[i]) {
        suffixIndex = i + 1;
        formattedNumber = number / thresholds[i];
        break;
      }
    }

    if (suffixIndex == 0) {
      return number.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      );
    } else {
      bool isWholeNumber =
          formattedNumber.truncateToDouble() == formattedNumber;
      int decimalPlaces = isWholeNumber ? 0 : 1;

      if (formattedNumber >= 100 && decimalPlaces == 1) {
        decimalPlaces = 0;
      }

      return '${formattedNumber.toStringAsFixed(decimalPlaces)}${suffixes[suffixIndex]}';
    }
  }

  List<int> _getRGBValues(Color color) {
    final red = (color.r * 255.0).round().clamp(0, 255);
    final green = (color.g * 255.0).round().clamp(0, 255);
    final blue = (color.b * 255.0).round().clamp(0, 255);
    return [red, green, blue];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(0, 0, 0, 0.6),
                Color.fromRGBO(0, 0, 0, 0.9),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Text(
                      _formatNumber(_counter),
                      style: const TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        letterSpacing: 1.5,
                      ),
                    ),
                    if (_counter >= 1000 && _counter < 1000000000000000)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'Exact: $_counter',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(255, 255, 255, 0.7),
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildButton(
                      icon: Icons.remove,
                      onPressed: _decrementCounter,
                      color: Colors.red,
                    ),

                    const SizedBox(width: 40),

                    _buildButton(
                      icon: Icons.add,
                      onPressed: _incrementCounter,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 30),
                child: ElevatedButton.icon(
                  onPressed: _resetCounter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(
                        color: Color.fromRGBO(255, 255, 255, 0.2),
                        width: 1.5,
                      ),
                    ),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                  ),
                  icon: const Icon(Icons.refresh, size: 16),
                  label: const Text(
                    'Reset Counter',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 50),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  'Counter will automatically save locally\nand persist between app launches',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.7),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
  }) {
    final rgbValues = _getRGBValues(color);
    final red = rgbValues[0];
    final green = rgbValues[1];
    final blue = rgbValues[2];

    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.1),
        shape: BoxShape.circle,
        border: Border.all(color: Color.fromRGBO(255, 255, 255, 0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(red, green, blue, 0.8),
                  Color.fromRGBO(red, green, blue, 0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 32, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
