import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/task.dart';
import '../services/firebase_service.dart';
import '../widgets/add_task_dialog.dart';
import '../widgets/task_card.dart';
import 'task_details_screen.dart';

enum TaskFilter { all, active, completed }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TaskFilter _filter = TaskFilter.all;
  final FirebaseService firebaseService = FirebaseService();

  void _clearCompletedTasks() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Clear Completed Tasks'),
        content: const Text('Are you sure you want to delete all completed tasks?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              await firebaseService.deleteCompletedTasks();
              Navigator.pop(context);
            },
            child: const Text('Clear', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('To-Do List', style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(color: Colors.purple),
        ),
        actions: [
          PopupMenuButton<TaskFilter>(
            onSelected: (value) => setState(() => _filter = value),
            itemBuilder: (context) => [
              const PopupMenuItem(value: TaskFilter.all, child: Text('All')),
              const PopupMenuItem(value: TaskFilter.active, child: Text('Active')),
              const PopupMenuItem(value: TaskFilter.completed, child: Text('Completed')),
            ],
            icon: const Icon(Icons.filter_list, color: Colors.white),
          ),
          IconButton(
            icon: const Icon(Icons.delete_sweep, color: Colors.white),
            onPressed: _clearCompletedTasks,
          ),
        ],
      ),
      body: StreamBuilder<List<Task>>(
        stream: firebaseService.getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading tasks'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tasks yet!'));
          }

          final tasks = snapshot.data!.where((task) {
            if (_filter == TaskFilter.active) return !task.isCompleted;
            if (_filter == TaskFilter.completed) return task.isCompleted;
            return true;
          }).toList();

       return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 300),
                child: TaskCard(
                  task: task,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetailsScreen(
                          task: task,
                          onToggle: (value) {
                            firebaseService.updateTask(
                              Task(
                                id: task.id,
                                name: task.name,
                                fatherName: task.fatherName,
                                agNumber: task.agNumber,
                                email: task.email,
                                degree: task.degree,
                                description: task.description,
                                isCompleted: value,
                                dueDate: task.dueDate,
                                imageBase64: task.imageBase64,
                                semester1Cgpa: task.semester1Cgpa,
                                semester2Cgpa: task.semester2Cgpa,
                                semester3Cgpa: task.semester3Cgpa,
                                semester4Cgpa: task.semester4Cgpa,
                                semester5Cgpa: task.semester5Cgpa,
                                semester6Cgpa: task.semester6Cgpa,
                                phoneNumber: task.phoneNumber,
                                address: task.address,
                                major: task.major,
                                minor: task.minor,
                                enrollmentYear: task.enrollmentYear,
                                expectedGraduation: task.expectedGraduation,
                                advisorName: task.advisorName,
                                advisorEmail: task.advisorEmail,
                                gpa: task.gpa,
                                creditsCompleted: task.creditsCompleted,
                                creditsRemaining: task.creditsRemaining,
                                scholarshipStatus: task.scholarshipStatus,
                                internshipExperience: task.internshipExperience,
                                extracurricularActivities: task.extracurricularActivities,
                              ),
                            );
                          },
                          onEdit: () {
                            showDialog(
                              context: context,
                              builder: (context) => AddTaskDialog(
                                task: task,
                                onSave: (fields, dueDate, imageBase64) {
                                  firebaseService.updateTask(
                                    Task(
                                      id: task.id,
                                      name: fields['name'],
                                      fatherName: fields['fatherName'],
                                      agNumber: fields['agNumber'],
                                      email: fields['email'],
                                      degree: fields['degree'],
                                      description: fields['description'],
                                      isCompleted: task.isCompleted,
                                      dueDate: dueDate,
                                      imageBase64: imageBase64,
                                      semester1Cgpa: fields['semester1Cgpa'],
                                      semester2Cgpa: fields['semester2Cgpa'],
                                      semester3Cgpa: fields['semester3Cgpa'],
                                      semester4Cgpa: fields['semester4Cgpa'],
                                      semester5Cgpa: fields['semester5Cgpa'],
                                      semester6Cgpa: fields['semester6Cgpa'],
                                      phoneNumber: fields['phoneNumber'],
                                      address: fields['address'],
                                      major: fields['major'],
                                      minor: fields['minor'],
                                      enrollmentYear: fields['enrollmentYear'],
                                      expectedGraduation: fields['expectedGraduation'],
                                      advisorName: fields['advisorName'],
                                      advisorEmail: fields['advisorEmail'],
                                      gpa: fields['gpa'],
                                      creditsCompleted: fields['creditsCompleted'],
                                      creditsRemaining: fields['creditsRemaining'],
                                      scholarshipStatus: fields['scholarshipStatus'],
                                      internshipExperience: fields['internshipExperience'],
                                      extracurricularActivities: fields['extracurricularActivities'],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          onDelete: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                title: const Text('Delete Task'),
                                content: const Text('Are you sure you want to delete this task?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                    onPressed: () {
                                      firebaseService.deleteTask(task.id);
                                      Navigator.pop(context);
                                      Navigator.pop(context); // Pop TaskDetailsScreen
                                    },
                                    child: const Text('Delete', style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddTaskDialog(
              onSave: (fields, dueDate, imageBase64) {
                final task = Task(
                  id: const Uuid().v4(),
                  name: fields['name'],
                  fatherName: fields['fatherName'],
                  agNumber: fields['agNumber'],
                  email: fields['email'],
                  degree: fields['degree'],
                  description: fields['description'],
                  dueDate: dueDate,
                  imageBase64: imageBase64,
                  semester1Cgpa: fields['semester1Cgpa'],
                  semester2Cgpa: fields['semester2Cgpa'],
                  semester3Cgpa: fields['semester3Cgpa'],
                  semester4Cgpa: fields['semester4Cgpa'],
                  semester5Cgpa: fields['semester5Cgpa'],
                  semester6Cgpa: fields['semester6Cgpa'],
                  phoneNumber: fields['phoneNumber'],
                  address: fields['address'],
                  major: fields['major'],
                  minor: fields['minor'],
                  enrollmentYear: fields['enrollmentYear'],
                  expectedGraduation: fields['expectedGraduation'],
                  advisorName: fields['advisorName'],
                  advisorEmail: fields['advisorEmail'],
                  gpa: fields['gpa'],
                  creditsCompleted: fields['creditsCompleted'],
                  creditsRemaining: fields['creditsRemaining'],
                  scholarshipStatus: fields['scholarshipStatus'],
                  internshipExperience: fields['internshipExperience'],
                  extracurricularActivities: fields['extracurricularActivities'],
                );
                firebaseService.addTask(task);
              },
            ),
          );
        },
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        child: const Icon(Icons.add),
      ),
    );
  }
}