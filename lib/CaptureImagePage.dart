import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'config.dart';

class CaptureImagePage extends StatefulWidget {
  @override
  _CaptureImagePageState createState() => _CaptureImagePageState();
}

class _CaptureImagePageState extends State<CaptureImagePage> {
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage(File image) async {
    try {
      final uri = Uri.parse('${Config.baseUrl}/upload'); // Replace with your server URL

      var request = http.MultipartRequest('POST', uri);
      
      // Add the image to the request
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          image.path,
          contentType: MediaType('image', 'jpeg'), // Adjust MIME type if needed
        ),
      );

      // Send the request
      var streamedResponse = await request.send();
      
      // Get the response from the stream
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
        print('Server response: ${response.body}');
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Capture Image',
          style: TextStyle(
            fontSize: 20, // Set your desired font size here
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 400, // Increased height
              width: 300,  // Increased width
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.grey[200], // Background color if no image is present
              ),
              child: _image == null
                  ? Icon(
                      Icons.image_not_supported,
                      color: Colors.grey[400],
                      size: 100,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            SizedBox(height: 20),
            _image != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildCoolActionButton(
                        icon: Icons.close,
                        color: Colors.red,
                        gradientColors: [Colors.redAccent, Colors.red],
                        onPressed: () {
                          setState(() {
                            _image = null;
                          });
                        },
                      ),
                      SizedBox(width: 50),
                      _buildCoolActionButton(
                        icon: Icons.check,
                        color: Colors.green,
                        gradientColors: [Colors.greenAccent, Colors.green],
                        onPressed: () async {
                          if (_image != null) {
                            await _uploadImage(_image!);
                            setState(() {
                              _image = null;
                            });
                          }
                        },
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildCoolButton(
                        icon: Icons.camera_alt,
                        label: 'Camera',
                        onPressed: () => _pickImage(ImageSource.camera),
                        colors: [Colors.blueAccent, Colors.lightBlue],
                      ),
                      SizedBox(width: 20),
                      _buildCoolButton(
                        icon: Icons.photo_library,
                        label: 'Gallery',
                        onPressed: () => _pickImage(ImageSource.gallery),
                        colors: [Colors.pinkAccent, Colors.purpleAccent],
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoolActionButton({
    required IconData icon,
    required Color color,
    required List<Color> gradientColors,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget _buildCoolButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required List<Color> colors,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent, // Keeps the button background transparent
        shadowColor: Colors.transparent, // Removes the shadow
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 0, // Removes elevation to avoid shadow
      ).copyWith(
        side: MaterialStateProperty.resolveWith<BorderSide>(
          (states) => BorderSide(color: Colors.transparent), // Removes border side color
        ),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
          (states) => Colors.black.withOpacity(0.1), // Overlay color on button press
        ),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          constraints: BoxConstraints(
            minWidth: 150,
            minHeight: 50,
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white),
              SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}