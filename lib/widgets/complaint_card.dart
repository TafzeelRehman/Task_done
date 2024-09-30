import 'dart:io';
import 'package:flutter/material.dart';

class ComplaintCard extends StatelessWidget {
  final int index;
  final String complaintNumber;
  final String userName;
  final String date;
  final String description;
  final String category;
  final List<String> images;
  final Function() onEdit;
  final Function() onDelete;

  const ComplaintCard({
    Key? key,
    required this.index,
    required this.complaintNumber,
    required this.userName,
    required this.date,
    required this.description,
    required this.category,
    required this.images,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.005),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(width * 0.03),
        ),
        margin: EdgeInsets.only(bottom: height * 0.005),
        child: Padding(
          padding: EdgeInsets.all(width * 0.025),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Complaint Number",
                  style: TextStyle(color: Colors.grey)),
              SizedBox(height: height * 0.004),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    complaintNumber,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: width * 0.04),
                  ),
                  // Status Container
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02, vertical: height * 0.005),
                    decoration: BoxDecoration(
                      color:
                          index == 2 ? Colors.green : const Color(0xFFE0847D),
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                    child: Text(
                      index == 2 ? "Resolved" : "Pending",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.035,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.01),
              Row(
                children: [
                  Icon(Icons.person,
                      size: width * 0.04, color: const Color(0xFFE0847D)),
                  SizedBox(width: width * 0.01),
                  Text(
                    userName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: width * 0.035),
                  ),
                  const Spacer(),
                  Icon(Icons.calendar_today_outlined,
                      size: width * 0.04, color: const Color(0xFFE0847D)),
                  SizedBox(width: width * 0.01),
                  Text(
                    date,
                    style: TextStyle(fontSize: width * 0.03),
                  ),
                ],
              ),
              SizedBox(height: height * 0.01),
              const Text("Complaint Category"),
              SizedBox(height: height * 0.004),
              Text(
                category,
                style: TextStyle(fontSize: width * 0.03, color: Colors.grey),
              ),
              SizedBox(height: height * 0.01),
              const Text("Complaint Description"),
              SizedBox(height: height * 0.004),
              Text(
                description,
                style: TextStyle(fontSize: width * 0.03, color: Colors.grey),
              ),
              if (images.isNotEmpty)
                Wrap(
                  spacing: 8,
                  children: images.map((imagePath) {
                    return Image.file(
                      File(imagePath),
                      width: width * 0.25,
                      height: height * 0.12,
                      fit: BoxFit.cover,
                    );
                  }).toList(),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onEdit,
                    child: const Text('Edit',
                        style: TextStyle(color: Colors.green)),
                  ),
                  SizedBox(width: width * 0.02),
                  TextButton(
                    onPressed: onDelete,
                    child: const Text('Delete',
                        style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
