import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Envoi d\'images multiples',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ImagePicker imagePicker = ImagePicker();

  List<XFile> selectedImages = [];
  List<String> uploadedImageUrls = [];
  bool isUploading = false;

  final TextEditingController _controller = TextEditingController();

  final String backendUrl = 'https://exercices-mobile.onrender.com';

  Future<void> pickMultipleImages() async {
    final List<XFile>? images = await imagePicker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      setState(() {
        selectedImages = images;
        uploadedImageUrls = [];
        isUploading = true;
      });
      await uploadImages();
      setState(() {
        isUploading = false;
      });
    }
  }

  Future<String> uploadImage(XFile image) async {
    final uri = Uri.parse('$backendUrl/exos/file');
    var request = http.MultipartRequest('POST', uri);
    String mimeType = 'image/jpeg';
    if (image.path.toLowerCase().endsWith('.png')) {
      mimeType = 'image/png';
    }
    request.files.add(await http.MultipartFile.fromPath(
      'file',
      image.path,
      contentType: MediaType.parse(mimeType),
    ));
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      final imageId = response.body.trim();
      return '$backendUrl/exos/file/$imageId';
    } else {
      throw Exception('Failed to upload image: ${response.statusCode}');
    }
  }

  Future<void> uploadImages() async {
    List<String> urls = [];
    for (var image in selectedImages) {
      try {
        String url = await uploadImage(image);
        urls.add(url);
        setState(() {
          uploadedImageUrls = List.from(urls);
        });
      } catch (e) {
        print('Erreur upload image ${image.name} : $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Multiple Images'),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_library),
            tooltip: 'Choisir plusieurs images',
            onPressed: pickMultipleImages,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Votre nom',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final name = _controller.text.trim();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Bonjour, $name!')),
                );
              },
              child: const Text('Envoyer'),
            ),
            const SizedBox(height: 16),
            if (isUploading) const CircularProgressIndicator(),
            if (uploadedImageUrls.isNotEmpty) ...[
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: uploadedImageUrls.length,
                  itemBuilder: (context, index) {
                    final url = uploadedImageUrls[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Image.network(
                        url,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 150),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
