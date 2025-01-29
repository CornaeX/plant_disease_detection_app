import 'package:flutter/material.dart';

class ThemeService with ChangeNotifier {
  ThemeData _currentTheme = _whiteTheme; // Default theme

  ThemeData get currentTheme => _currentTheme;

  void setTheme(ThemeData theme) {
    _currentTheme = theme;
    notifyListeners();
  }

  // Expose each theme through a method
  ThemeData get whiteTheme => _whiteTheme;
  ThemeData get blackTheme => _blackTheme;
  ThemeData get darkBlueTheme => _darkBlueTheme;
  ThemeData get brightPinkTheme => _brightPinkTheme;
  ThemeData get customTheme => _customTheme;

  // Define your themes here with updated text style names and icon colors
  static final ThemeData _whiteTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(color: Colors.black), // Icon color for AppBar
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
    ),
    iconTheme: IconThemeData(color: Colors.black), // Default icon color
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 255, 247, 253),
      unselectedItemColor: Colors.black54,
      selectedItemColor: Colors.black,
    ),
  );

  static final ThemeData _blackTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(color: Colors.white), // Icon color for AppBar
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
    ),
    iconTheme: IconThemeData(color: Colors.white), // Default icon color
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 17, 17, 17),
      unselectedItemColor: Colors.white54,
      selectedItemColor: Colors.white,
    ),
  );

  static final ThemeData _darkBlueTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue[900],
    scaffoldBackgroundColor: Colors.blueGrey[900],
    appBarTheme: AppBarTheme(
      color: Colors.blue[900],
      iconTheme: IconThemeData(color: Colors.white), // Icon color for AppBar
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
    ),
    iconTheme: IconThemeData(color: Colors.white), // Default icon color
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: Colors.white54,
      selectedItemColor: Colors.white,
    ),
  );

  static final ThemeData _brightPinkTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.pinkAccent,
    scaffoldBackgroundColor: Colors.pink[50],
    appBarTheme: AppBarTheme(
      color: Colors.pinkAccent,
      iconTheme: IconThemeData(color: Colors.black), // Icon color for AppBar
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
    ),
    iconTheme: IconThemeData(color: Colors.black), // Default icon color
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: Colors.black54,
      selectedItemColor: Colors.black,
    ),
  );

  static final ThemeData _customTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.teal,
    scaffoldBackgroundColor: Colors.teal[50],
    appBarTheme: AppBarTheme(
      color: Colors.teal,
      iconTheme: IconThemeData(color: Colors.teal[900]), // Icon color for AppBar
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.teal[900]),
    ),
    iconTheme: IconThemeData(color: Colors.teal[900]), // Default icon color
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: Colors.teal[600],
      selectedItemColor: Colors.teal[900],
    ),
  );
}