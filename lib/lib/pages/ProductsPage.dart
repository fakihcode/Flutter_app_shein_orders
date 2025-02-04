
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/UserData/UserData.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

// ignore: must_be_immutable
class ProductsPage extends StatefulWidget {
  final int PersonId;

  ProductsPage({super.key, required this.PersonId});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  Userdata user_data = Userdata();
  List<String> _imageList = []; // Change to List<String>

  @override
  void initState() {
    super.initState();
    user_data.initHive().then((_) async {
      await user_data.ensureListExists(widget.PersonId);
      _imageList = user_data.GetFile(widget.PersonId);
      setState(() {});
    });
  }

  Future<void> pickImageAndSave(String folderName) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final dirPath = await getApplicationDocumentsDirectoryPath();
      final myFolder = Directory('$dirPath/$folderName');

      if (!await myFolder.exists()) {
        await myFolder.create(recursive: true);
      }

      final imagePath = '${myFolder.path}/${pickedFile.name}';
      await pickedFile.saveTo(imagePath);
      _imageList.add(imagePath); // Store the path as a string
      await user_data.SetaList(
          widget.PersonId, _imageList); // Save updated paths in Hive

      print('Image saved to folder: $imagePath');
      setState(() {}); // Update the UI to reflect the new image
    } else {
      print('No image selected.');
    }
  }

  Future<String> getApplicationDocumentsDirectoryPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Images')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await pickImageAndSave("ProductsImages");
        },
        child: Icon(Icons.add_a_photo),
      ),
      body: _imageList.isEmpty
          ? Center(child: Text('No images available.'))
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 1,
              ),
              itemCount: _imageList.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Image.file(File(_imageList[index])),
                );
              },
            ),
    );
  }
}
