import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

class FirebaseService {
  final CollectionReference _tasksCollection = FirebaseFirestore.instance.collection('tasks');

  Stream<List<Task>> getTasks() {
    return _tasksCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Task.fromMap(doc.id, doc.data() as Map<String, dynamic>)).toList();
    });
  }

  Future<void> addTask(Task task) async {
    try {
      await _tasksCollection.doc(task.id).set(task.toMap());
    } catch (e) {
      print('Error adding task: $e');
      rethrow;
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await _tasksCollection.doc(task.id).set(task.toMap());
    } catch (e) {
      print('Error updating task: $e');
      rethrow;
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _tasksCollection.doc(taskId).delete();
    } catch (e) {
      print('Error deleting task: $e');
      rethrow;
    }
  }

  Future<void> deleteCompletedTasks() async {
    try {
      final snapshot = await _tasksCollection.where('isCompleted', isEqualTo: true).get();
      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      print('Error deleting completed tasks: $e');
      rethrow;
    }
  }
}