import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/database_service.dart';
import '../widgets/primary_button.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _studentIdController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _programController = TextEditingController();
  final _eventNameController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _studentIdController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _programController.dispose();
    _eventNameController.dispose();
    super.dispose();
  }

  void _showSnack(String msg, {bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: error ? Colors.red.shade600 : Colors.green.shade600,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    final student = Student(
      studentId: _studentIdController.text.trim(),
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      program: _programController.text.trim(),
      eventName: _eventNameController.text.trim(),
    );

    try {
      await DatabaseService().insertStudent(student);
      _showSnack('ลงทะเบียนสำเร็จ!');
      // Clear form
      _formKey.currentState!.reset();
    } catch (e) {
      _showSnack('เกิดข้อผิดพลาด: $e', error: true);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ลงทะเบียนกิจกรรม'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'ข้อมูลนักศึกษา',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _studentIdController,
                    decoration: const InputDecoration(
                      labelText: 'รหัสนักศึกษา',
                      prefixIcon: Icon(Icons.badge),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'กรุณากรอกรหัสนักศึกษา';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      labelText: 'ชื่อ',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'กรุณากรอกชื่อ';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      labelText: 'นามสกุล',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'กรุณากรอกนามสกุล';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _programController,
                    decoration: const InputDecoration(
                      labelText: 'หลักสูตร',
                      prefixIcon: Icon(Icons.school),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'กรุณากรอกหลักสูตร';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _eventNameController,
                    decoration: const InputDecoration(
                      labelText: 'ชื่อกิจกรรม',
                      prefixIcon: Icon(Icons.event),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'กรุณากรอกชื่อกิจกรรม';
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  PrimaryButton(
                    label: 'ลงทะเบียน',
                    loading: _loading,
                    onPressed: _submit,
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
