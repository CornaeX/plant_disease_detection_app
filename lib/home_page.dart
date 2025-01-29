// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'payment_service.dart';
import 'CaptureImagePage.dart';  
import 'AIAnalysisPage.dart';    
// import 'IoTSensorDataPage.dart';
// import 'ThemeSelectionPage.dart';
// import 'communityPage/community_page.dart';   
// import 'package:pdd_test01/settingPage/setting_page.dart'; 
import 'theme_service.dart'; // Import ThemeService

// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Tracks the currently selected tab index

  @override
  void initState() {
    super.initState();
    _fetchPaymentStatus();
  }

  Future<void> _fetchPaymentStatus() async {
    // final paymentService = Provider.of<PaymentService>(context, listen: false);
    // try {
    //   await paymentService.fetchPaymentStatus();
    //   // ignore: duplicate_ignore
    //   // ignore: avoid_print
    //   print('Payment Status: ${paymentService.isPaid}');
    // } catch (e) {
    //   print('Error: $e');
    // }
  }

  Future<void> _handleRefresh() async {
    await _fetchPaymentStatus();
  }

  // Page options based on the selected tab
  final List<Widget> _pageOptions = <Widget>[
    // CommunityPage(), // New Community Page
    // IoTSensorDataPage(),
    CaptureImagePage(),
    // AIAnalysisPage(),
    // SettingsPage(), // Settings is now represented by ThemeSelectionPage
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final paymentService = Provider.of<PaymentService>(context);
    final themeService = Provider.of<ThemeService>(context);

    // print('Building HomePage with isPaid: ${paymentService.isPaid}');

    return Scaffold(
      appBar: PreferredSize(
  preferredSize: const Size.fromHeight(60.0), // Set the height of the AppBar
  child: Container(
    color: themeService.currentTheme.bottomNavigationBarTheme.backgroundColor ?? Colors.transparent, // Use the bottom nav bar color for the AppBar background
    child: Padding(
      padding: const EdgeInsets.only(top: 40.0), // Adjust padding as needed
      child: Center(
        child: Text(
          'AI Plant Disease Detector v0.2.14',
          style: themeService.currentTheme.appBarTheme.titleTextStyle ?? TextStyle(fontSize: 25, color: themeService.currentTheme.bottomNavigationBarTheme.selectedItemColor), // Use theme text style for AppBar title
        ),
      ),
    ),
  ),
),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: _pageOptions[_selectedIndex], // Display selected page
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Active tab index
        onTap: _onItemTapped, // Update selected tab
        type: BottomNavigationBarType.fixed,
        backgroundColor: themeService.currentTheme.bottomNavigationBarTheme.backgroundColor, // Use theme color for BottomNavigationBar background
        selectedItemColor: themeService.currentTheme.bottomNavigationBarTheme.selectedItemColor, // Use theme color for selected item
        unselectedItemColor: themeService.currentTheme.bottomNavigationBarTheme.unselectedItemColor, // Use theme color for unselected items
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sensors),
            label: 'IoT Data',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Capture',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'AI Analysis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}