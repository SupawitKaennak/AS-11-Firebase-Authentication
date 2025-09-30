import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/database_service.dart';

class ViewRegistrationsScreen extends StatefulWidget {
  const ViewRegistrationsScreen({super.key});

  @override
  State<ViewRegistrationsScreen> createState() => _ViewRegistrationsScreenState();
}

class _ViewRegistrationsScreenState extends State<ViewRegistrationsScreen> {
  List<Student> _students = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    setState(() => _loading = true);
    try {
      final students = await DatabaseService().getStudents();
      setState(() => _students = students);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('เกิดข้อผิดพลาด: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายการลงทะเบียน'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadStudents,
            tooltip: 'รีเฟรช',
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _students.isEmpty
              ? const Center(child: Text('ไม่มีข้อมูลการลงทะเบียน'))
              : RefreshIndicator(
                  onRefresh: _loadStudents,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _students.length,
                    itemBuilder: (context, index) {
                      final student = _students[index];
                      return Card(
                        elevation: 6,
                        margin: const EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        shadowColor: Colors.indigo.shade100,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.person, color: Colors.indigo.shade700),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      '${student.firstName} ${student.lastName}',
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigo.shade900,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'รหัสนักศึกษา: ${student.studentId}',
                                style: TextStyle(color: Colors.indigo.shade700, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'หลักสูตร: ${student.program}',
                                style: TextStyle(color: Colors.indigo.shade700, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'กิจกรรม: ${student.eventName}',
                                style: TextStyle(color: Colors.indigo.shade700, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
