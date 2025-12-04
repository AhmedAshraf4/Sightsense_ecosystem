import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'image_upload_page.dart';
import 'emergency_contacts_page.dart';
import 'settings_page.dart';
import 'maps_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const OrderTrackingPage(),
    );
  }
}

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);

  @override
  _OrderTrackingPageState createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  int _selectedIndex = 0;
  late stt.SpeechToText _speech;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const MapsPage(),
          ImageUploadPage(),
          const MapsPage(), // For Voice Commands, keeping the map page
          EmergencyContactsPage(),
          SettingsPage(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavigationBarItem(Icons.map, 0),
            _buildNavigationBarItem(Icons.image, 1),
            _buildVoiceCommandButton(Icons.mic, 2),
            _buildNavigationBarItem(Icons.contacts, 3),
            _buildNavigationBarItem(Icons.settings, 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationBarItem(IconData icon, int index) {
    return IconButton(
      onPressed: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      icon: Icon(
        icon,
        color: _selectedIndex == index ? Colors.green : Colors.black,
        size: 30,
      ),
    );
  }

  Widget _buildVoiceCommandButton(IconData icon, int index) {
    return IconButton(
      onPressed: () {
        _startListening();
      },
      icon: Icon(
        icon,
        color: _selectedIndex == index ? Colors.green : Colors.black,
        size: 65,
      ),
    );
  }

  void _startListening() async {
    if (!_speech.isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) => print('Status: $status'),
        onError: (error) => print('Error: $error'),
      );
      if (available) {
        _speech.listen(
          onResult: (result) {
            setState(() {
              // Handle voice input result
              _handleVoiceInput(result.recognizedWords);
            });
          },
        );
      } else {
        print('Speech recognition not available');
      }
    }
  }

  void _handleVoiceInput(String input) {
    // Implement logic to handle voice input
    print('Voice input: $input');
    // Use the input for searching and marking on the map
  }
}
