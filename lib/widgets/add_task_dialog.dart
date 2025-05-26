import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

class AddTaskDialog extends StatefulWidget {
  final Function(Map<String, String>, DateTime?, String?) onSave;
  final Task? task;

  const AddTaskDialog({super.key, required this.onSave, this.task});

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _formKey = GlobalKey<FormState>();
  late Map<String, TextEditingController> _controllers;
  DateTime? _dueDate;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _controllers = {
      'name': TextEditingController(text: widget.task?.name ?? ''),
      'fatherName': TextEditingController(text: widget.task?.fatherName ?? ''),
      'agNumber': TextEditingController(text: widget.task?.agNumber ?? ''),
      'email': TextEditingController(text: widget.task?.email ?? ''),
      'degree': TextEditingController(text: widget.task?.degree ?? ''),
      'description': TextEditingController(text: widget.task?.description ?? ''),
      'semester1Cgpa': TextEditingController(text: widget.task?.semester1Cgpa ?? ''),
      'semester2Cgpa': TextEditingController(text: widget.task?.semester2Cgpa ?? ''),
      'semester3Cgpa': TextEditingController(text: widget.task?.semester3Cgpa ?? ''),
      'semester4Cgpa': TextEditingController(text: widget.task?.semester4Cgpa ?? ''),
      'semester5Cgpa': TextEditingController(text: widget.task?.semester5Cgpa ?? ''),
      'semester6Cgpa': TextEditingController(text: widget.task?.semester6Cgpa ?? ''),
      'phoneNumber': TextEditingController(text: widget.task?.phoneNumber ?? ''),
      'address': TextEditingController(text: widget.task?.address ?? ''),
      'major': TextEditingController(text: widget.task?.major ?? ''),
      'minor': TextEditingController(text: widget.task?.minor ?? ''),
      'enrollmentYear': TextEditingController(text: widget.task?.enrollmentYear ?? ''),
      'expectedGraduation': TextEditingController(text: widget.task?.expectedGraduation ?? ''),
      'advisorName': TextEditingController(text: widget.task?.advisorName ?? ''),
      'advisorEmail': TextEditingController(text: widget.task?.advisorEmail ?? ''),
      'gpa': TextEditingController(text: widget.task?.gpa ?? ''),
      'creditsCompleted': TextEditingController(text: widget.task?.creditsCompleted ?? ''),
      'creditsRemaining': TextEditingController(text: widget.task?.creditsRemaining ?? ''),
      'scholarshipStatus': TextEditingController(text: widget.task?.scholarshipStatus ?? ''),
      'internshipExperience': TextEditingController(text: widget.task?.internshipExperience ?? ''),
      'extracurricularActivities': TextEditingController(text: widget.task?.extracurricularActivities ?? ''),
    };
    _dueDate = widget.task?.dueDate;
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick Image'),
              ),
              if (_image != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Image.file(_image!, height: 100, width: 100),
                ),
              const SizedBox(height: 16),
              ExpansionTile(
                title: const Text('Personal Information'),
                initiallyExpanded: true,
                children: [
                  _buildTextField('name'),
                  _buildTextField('fatherName'),
                  _buildTextField('agNumber'),
                  _buildTextField('email'),
                  _buildTextField('phoneNumber'),
                  _buildTextField('address'),
                ],
              ),
              ExpansionTile(
                title: const Text('Academic Information'),
                children: [
                  _buildTextField('degree'),
                  _buildTextField('semester1Cgpa'),
                  _buildTextField('semester2Cgpa'),
                  _buildTextField('semester3Cgpa'),
                  _buildTextField('semester4Cgpa'),
                  _buildTextField('semester5Cgpa'),
                  _buildTextField('semester6Cgpa'),
                  _buildTextField('major'),
                  _buildTextField('minor'),
                  _buildTextField('enrollmentYear'),
                  _buildTextField('expectedGraduation'),
                  _buildTextField('gpa'),
                  _buildTextField('creditsCompleted'),
                  _buildTextField('creditsRemaining'),
                ],
              ),
              ExpansionTile(
                title: const Text('Additional Information'),
                children: [
                  _buildTextField('description'),
                  _buildTextField('advisorName'),
                  _buildTextField('advisorEmail'),
                  _buildTextField('scholarshipStatus'),
                  _buildTextField('internshipExperience'),
                  _buildTextField('extracurricularActivities'),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _dueDate == null
                          ? 'No due date'
                          : DateFormat('MMM dd, yyyy').format(_dueDate!),
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _dueDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) {
                        setState(() => _dueDate = picked);
                      }
                    },
                    child: const Text('Pick Due Date'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
          ),
          onPressed: () async {
            String? imageBase64;
            if (_image != null) {
              final bytes = await _image!.readAsBytes();
              imageBase64 = base64Encode(bytes);
            }
            widget.onSave(
              {for (var e in _controllers.entries) e.key: e.value.text},
              _dueDate,
              imageBase64,
            );
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  Widget _buildTextField(String key) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: _controllers[key],
        decoration: InputDecoration(
          labelText: key
              .replaceAllMapped(RegExp(r'([A-Z])'), (m) => ' ${m[1]}')
              .split(' ')
              .map((word) => word[0].toUpperCase() + word.substring(1))
              .join(' '),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}