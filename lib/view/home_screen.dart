// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:test_projects/bottomsheet.dart';
import 'package:test_projects/widgets/complaint_card.dart';
import 'package:test_projects/widgets/innerrightcurveclipper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _complaints = [];
  final List<Map<String, dynamic>> _filteredComplaints = [];
  final TextEditingController _searchController = TextEditingController();

  void _addComplaint(Map<String, dynamic> complaint) {
    setState(() {
      _complaints.add(complaint);
      _filteredComplaints.add(complaint);
    });
  }

  void _filterComplaints(String query) {
    setState(() {
      _filteredComplaints.clear();
      if (query.isNotEmpty) {
        for (var complaint in _complaints) {
          if (complaint['username']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase())) {
            _filteredComplaints.insert(0, complaint);
          } else {
            _filteredComplaints.add(complaint);
          }
        }
      } else {
        _filteredComplaints.addAll(_complaints);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _filteredComplaints.addAll(_complaints);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          ClipPath(
            clipper: InnerRightCurveClipper(),
            child: Container(
              height: height * 0.37,
              color: const Color(0xFFE0847D),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05,
                  vertical: height * 0.05,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create your",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Complaints",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.07,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        FloatingActionButton(
                          onPressed: () async {
                            final result = await showModalBottomSheet<
                                Map<String, dynamic>>(
                              context: context,
                              backgroundColor: Colors.white,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return const BottomSheetReview();
                              },
                            );
                            if (result != null) {
                              _addComplaint(result);
                            }
                          },
                          backgroundColor: Colors.white,
                          // ignore: sort_child_properties_last
                          child:
                              const Icon(Icons.add, color: Color(0xFFE0847D)),
                          shape: const CircleBorder(),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      "Have something to rant about?",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: width * 0.04,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    TextField(
                      controller: _searchController,
                      onChanged: _filterComplaints,
                      decoration: InputDecoration(
                        hintText: "Search by Username...",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontSize: width * 0.04),
                        prefixIcon: GestureDetector(
                          onTap: () {
                            _filterComplaints(_searchController.text);
                          },
                          child: Icon(Icons.search,
                              color: Colors.grey, size: width * 0.06),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.03),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(width * 0.015),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Sort by",
                  style: TextStyle(
                      color: const Color(0xFFE0847D), fontSize: width * 0.04),
                ),
                DropdownButton<String>(
                  value: 'Date Added',
                  underline: const SizedBox(),
                  items: <String>['Date Added', 'Status', 'Name']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                            color: const Color(0xFFE0847D),
                            fontSize: width * 0.04),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    // Add sorting logic here
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredComplaints.length,
              itemBuilder: (context, index) {
                final complaint = _filteredComplaints[index];

                return ComplaintCard(
                  index: complaint['status'] == 'Resolved' ? 2 : 1,
                  complaintNumber: "${index + 1}",
                  userName: complaint['username'] ?? "Unknown User",
                  date: complaint['date'] ?? "No Date Provided",
                  description:
                      complaint['description'] ?? "No Description Provided",
                  category: complaint['category'] ?? "No Category Provided",
                  images: complaint['images'] is List
                      ? List<String>.from(complaint['images'])
                      : [],
                  onEdit: () => _showEditDialog(context, index),
                  onDelete: () {
                    setState(() {
                      _complaints.removeAt(index);
                      _filteredComplaints.removeAt(index);
                    });
                    print('Deleted complaint: ${complaint['complaintNumber']}');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, int index) {
    final TextEditingController _controller = TextEditingController();
    _controller.text = _filteredComplaints[index]['description'] ?? '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Complaint Description'),
          content: TextField(
            controller: _controller,
            decoration:
                const InputDecoration(hintText: "Enter new description"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  setState(() {
                    _filteredComplaints[index]['description'] =
                        _controller.text;
                    final originalIndex = _complaints.indexWhere((complaint) =>
                        complaint['complaintNumber'] ==
                        _filteredComplaints[index]['complaintNumber']);
                    if (originalIndex != -1) {
                      _complaints[originalIndex]['description'] =
                          _controller.text;
                    }
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
