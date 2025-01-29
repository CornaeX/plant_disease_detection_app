import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'payment_service.dart';  
// import 'login_page.dart';     
import 'home_page.dart';     
// import 'testHomePage.dart';    
// import 'register_page.dart';  
import 'theme_service.dart';  
// import 'settingPage/account_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (context) => PaymentService()),
        ChangeNotifierProvider(create: (context) => ThemeService()),   // Provide ThemeService
      ],
      child: MyApp(),
    ),
  );
}

Future<String> fetchUsername() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('username') ?? 'No username found';
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);

    return MaterialApp(
      title: 'Flutter App',
      theme: themeService.currentTheme, // Use the current theme from ThemeService
      initialRoute: '/home',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          // case '/':
          //   return MaterialPageRoute(builder: (context) => LoginPage());
          // case '/home':
          //   return MaterialPageRoute(builder: (context) => PlantAppHomePage());
          // case '/login':
          //   return MaterialPageRoute(builder: (context) => LoginPage());
          // case '/register':
          //   return MaterialPageRoute(builder: (context) => RegisterPage());
          // case '/account':
            // return MaterialPageRoute(
              // builder: (context) => FutureBuilder<String>(
                // future: fetchUsername(),
                // builder: (context, snapshot) {
                  // if (snapshot.connectionState == ConnectionState.waiting) {
                    // return const Scaffold(
                      // body: Center(child: CircularProgressIndicator()),
                    // );
                  // } else if (snapshot.hasError) {
                    // return const Scaffold(
                      // body: Center(child: Text('Error fetching username')),
                    // );
                  // } else {
                    // String username = snapshot.data ?? 'No username found';
                    // return AccountPage(username: username);
                  // }
                // },
              // ),
            // );
          // default:
            // return MaterialPageRoute(builder: (context) => LoginPage());
        }
      },
    );
  }
}