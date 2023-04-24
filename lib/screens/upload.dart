import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

File? _image;

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image Upload'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              ),
              SizedBox(width: 25,),
              ElevatedButton(
                onPressed:() => _uploadImage(context),
                child: Text('Upload Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _uploadImage(BuildContext context) async {
  if (_image == null) {
    return;
  }

  final url = Uri.parse('https://codelime.in/api/remind-app-token');
  final request = http.MultipartRequest('POST', url);
  request.files.add(
    http.MultipartFile(
      'file',
      _image!.readAsBytes().asStream(),
      _image!.lengthSync(),
      filename: _image!.path.split('/').last,
    ),
  );

  final response = await request.send();
   final responseBody = await response.stream.bytesToString();
  if (response.statusCode == 200) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Image uploaded'),
        content: Text(responseBody),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  } else {
    print('Error uploading image: ${response.statusCode}');
  }
}
