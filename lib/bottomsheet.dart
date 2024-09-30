import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_projects/image_picker.dart';
import 'package:test_projects/widgets/button.dart';

class BottomSheetReview extends StatefulWidget {
  final String? username;
  final String? description;
  final String? category;

  const BottomSheetReview({
    Key? key,
    this.username,
    this.description,
    this.category,
  }) : super(key: key);

  @override
  _BottomSheetReviewState createState() => _BottomSheetReviewState();
}

class _BottomSheetReviewState extends State<BottomSheetReview> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<XFile> _images = [];

  String _status = 'Pending';
  String _category = 'General';
  final List<String> _statuses = ['Pending', 'Resolved'];
  final List<String> _categories = ['General', 'Technical', 'Billing', 'Other'];

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _images.add(pickedFile);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.username != null) {
      _usernameController.text = widget.username!;
    }
    if (widget.description != null) {
      _descriptionController.text = widget.description!;
    }
    if (widget.category != null) {
      _category = widget.category!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: height * 0.08),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: const TextStyle(color: Color(0xFFE0847D)),
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.03),
                    borderSide: const BorderSide(
                      color: Color(0xFFE0847D),
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.03),
                    borderSide: const BorderSide(
                      color: Color(0xFFE0847D),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              DropdownButtonFormField<String>(
                value: _category,
                onChanged: (String? newValue) {
                  setState(() {
                    _category = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Select Category',
                  labelStyle: const TextStyle(color: Color(0xFFE0847D)),
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.03),
                    borderSide: const BorderSide(
                      color: Color(0xFFE0847D),
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.03),
                    borderSide: const BorderSide(
                      color: Color(0xFFE0847D),
                      width: 2.0,
                    ),
                  ),
                ),
                items: _categories.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: height * 0.02),
              TextField(
                controller: _descriptionController,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: const TextStyle(color: Color(0xFFE0847D)),
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.03),
                    borderSide: const BorderSide(
                      color: Color(0xFFE0847D),
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.03),
                    borderSide: const BorderSide(
                      color: Color(0xFFE0847D),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DropdownButton<String>(
                    value: _status,
                    onChanged: (String? newValue) {
                      setState(() {
                        _status = newValue!;
                      });
                    },
                    items:
                        _statuses.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: height * 0.01),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(
                        'Attachments',
                        style: TextStyle(
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                    SizedBox(height: height * 0.01),
                    FloatingActionButton(
                      onPressed: () {
                        showImageSourceDialog(context, _pickImage);
                      },
                      backgroundColor: Colors.white,
                      child: const Icon(Icons.add, color: Color(0xFFE0847D)),
                      mini: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.01),
              Wrap(
                spacing: 8,
                children: _images.map((image) {
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.file(
                        File(image.path),
                        width: width * 0.25,
                        height: height * 0.12,
                        fit: BoxFit.cover,
                      ),
                      IconButton(
                        icon:
                            const Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            _images.remove(image);
                          });
                        },
                      ),
                    ],
                  );
                }).toList(),
              ),
              SizedBox(height: height * 0.02),
              Elevated(
                onPressed: () {
                  Navigator.of(context).pop({
                    'username': _usernameController.text,
                    'description': _descriptionController.text,
                    'status': _status,
                    'category': _category,
                    'date': DateTime.now().toString(),
                    'images': _images.map((image) => image.path).toList(),
                  });
                },
              )
            ],
          ),
          Positioned(
            top: height * -0.07,
            left: width * 0.25,
            right: width * 0.25,
            child: Container(
              height: height * 0.1,
              decoration: BoxDecoration(
                color: const Color(0xFFE0847D),
                borderRadius: BorderRadius.circular(width * 0.05),
              ),
              alignment: Alignment.center,
              child: Text(
                'New Complaint',
                style: TextStyle(
                  fontSize: width * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
