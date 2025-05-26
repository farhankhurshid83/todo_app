import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskDetailsScreen extends StatefulWidget {
  final Task task;
  final Function(bool) onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskDetailsScreen({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  _TaskDetailsScreenState createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late bool _isCompleted;

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.task.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.task.name ?? 'No Name',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: _isCompleted,
                onChanged: (value) {
                  setState(() {
                    _isCompleted = value!;
                  });
                  widget.onToggle(value!);
                },
                activeColor: Colors.purple,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: widget.onEdit,
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: widget.onDelete,
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.task.imageBase64 != null)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    base64Decode(widget.task.imageBase64!),
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.broken_image,
                      size: 200,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            _buildDetailRow('Name', widget.task.name ?? 'N/A'),
            _buildDetailRow('Father\'s Name', widget.task.fatherName ?? 'N/A'),
            _buildDetailRow('AG Number', widget.task.agNumber ?? 'N/A'),
            _buildDetailRow('Email', widget.task.email ?? 'N/A'),
            _buildDetailRow('Degree', widget.task.degree ?? 'N/A'),
            _buildDetailRow('Description', widget.task.description ?? 'N/A'),
            _buildDetailRow('Due Date', widget.task.formattedDueDate),
            _buildDetailRow('Completed', _isCompleted ? 'Yes' : 'No'),
            _buildDetailRow('Semester 1 CGPA', widget.task.semester1Cgpa ?? 'N/A'),
            _buildDetailRow('Semester 2 CGPA', widget.task.semester2Cgpa ?? 'N/A'),
            _buildDetailRow('Semester 3 CGPA', widget.task.semester3Cgpa ?? 'N/A'),
            _buildDetailRow('Semester 4 CGPA', widget.task.semester4Cgpa ?? 'N/A'),
            _buildDetailRow('Semester 5 CGPA', widget.task.semester5Cgpa ?? 'N/A'),
            _buildDetailRow('Semester 6 CGPA', widget.task.semester6Cgpa ?? 'N/A'),
            _buildDetailRow('Phone Number', widget.task.phoneNumber ?? 'N/A'),
            _buildDetailRow('Address', widget.task.address ?? 'N/A'),
            _buildDetailRow('Major', widget.task.major ?? 'N/A'),
            _buildDetailRow('Minor', widget.task.minor ?? 'N/A'),
            _buildDetailRow('Enrollment Year', widget.task.enrollmentYear ?? 'N/A'),
            _buildDetailRow('Expected Graduation', widget.task.expectedGraduation ?? 'N/A'),
            _buildDetailRow('Advisor Name', widget.task.advisorName ?? 'N/A'),
            _buildDetailRow('Advisor Email', widget.task.advisorEmail ?? 'N/A'),
            _buildDetailRow('GPA', widget.task.gpa ?? 'N/A'),
            _buildDetailRow('Credits Completed', widget.task.creditsCompleted ?? 'N/A'),
            _buildDetailRow('Credits Remaining', widget.task.creditsRemaining ?? 'N/A'),
            _buildDetailRow('Scholarship Status', widget.task.scholarshipStatus ?? 'N/A'),
            _buildDetailRow('Internship Experience', widget.task.internshipExperience ?? 'N/A'),
            _buildDetailRow('Extracurricular Activities', widget.task.extracurricularActivities ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}