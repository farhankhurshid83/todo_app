import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/task.dart';
import 'dart:ui'; // Required for ImageFilter

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Construct subtitle with description and degree
    final subtitleParts = [
      if (task.description != null) task.description,
      if (task.degree != null) task.degree,
    ];
    final subtitle = subtitleParts.isNotEmpty
        ? subtitleParts.join(', ')
        : 'No Description';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.grey[200]!.withOpacity(0.3), // Light gray tint for white background
        gradient: LinearGradient(
          colors: [
            Colors.grey[400]!.withOpacity(0.7),
            Colors.white.withOpacity(0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.5), // Stronger border for visibility
          width: 1.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 4), // Slightly stronger shadow
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8), // Softer blur for subtle effect
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Circular avatar
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white!.withOpacity(0.4), // Subtle glassy avatar
                    child: task.imageBase64 != null
                        ? ClipOval(
                      child: Image.memory(
                        base64Decode(task.imageBase64!),
                        width: 52,
                        height: 52,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.person,
                          size: 28,
                          color: Colors.grey[800]!.withOpacity(0.7),
                        ),
                      ),
                    )
                        : Icon(
                      Icons.person,
                      size: 28,
                      color: Colors.grey[800]!.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Main content (name and subtitle)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.name ?? 'No Name',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: task.isCompleted
                                ? Colors.grey[700]
                                : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Timestamp
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        task.formattedDueDate == 'No due date'
                            ? ''
                            : task.formattedDueDate,
                        style: TextStyle(
                          fontSize: 12,
                          color: task.isCompleted
                              ? Colors.black
                              : Colors.green,
                        ),
                      ),
                      if (task.isCompleted)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Icon(
                            Icons.check_circle,
                            size: 16,
                            color: Colors.green,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}