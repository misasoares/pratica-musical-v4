import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../../content/domain/entities/program.dart';
import '../stores/admin_store.dart';

class AdminProgramEditPage extends StatefulWidget {
  final String? programId;

  const AdminProgramEditPage({super.key, this.programId});

  @override
  State<AdminProgramEditPage> createState() => _AdminProgramEditPageState();
}

class _AdminProgramEditPageState extends State<AdminProgramEditPage> {
  final AdminStore _store = GetIt.I<AdminStore>();
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _orderController = TextEditingController();

  bool _isVisible = false;
  File? _selectedImage;
  String? _currentImageUrl;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.programId != null) {
      _isEditing = true;
      _loadProgram(widget.programId!);
    } else {
      _orderController.text = '1';
    }
  }

  void _loadProgram(String id) {
    try {
      final program = _store.programs.firstWhere((p) => p.id == id);
      _titleController.text = program.title;
      _descriptionController.text = program.description;
      _orderController.text = program.order.toString();
      _isVisible = program.isVisible;
      _currentImageUrl = program.thumbnailUrl;
    } catch (e) {
      // Handle error or navigate back
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final title = _titleController.text;
    final description = _descriptionController.text;
    final order = int.tryParse(_orderController.text) ?? 1;

    if (_selectedImage == null &&
        (_currentImageUrl == null || _currentImageUrl!.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecione uma imagem.')),
      );
      return;
    }

    final programId = _isEditing ? widget.programId! : const Uuid().v4();

    // Preserve existing modules if editing, or empty list if new
    // Note: In a real app we might fetch the full object again to be sure
    final existingProgram = _isEditing
        ? _store.programs.firstWhere((p) => p.id == programId)
        : null;

    final program = Program(
      id: programId,
      title: title,
      description: description,
      thumbnailUrl: _currentImageUrl ??
          '', // Will be updated by store if image is selected
      order: order,
      isVisible: _isVisible,
      createdAt: existingProgram?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
      modules: existingProgram?.modules ?? [],
    );

    final result = _isEditing
        ? await _store.updateProgram(program, _selectedImage)
        : await _store.createProgram(program, _selectedImage);

    result.fold(
      (l) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro: $l')),
          );
        }
      },
      (r) {
        if (mounted) {
          Navigator.pop(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Programa' : 'Novo Programa'),
      ),
      body: Observer(
        builder: (_) {
          if (_store.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _selectedImage != null
                          ? Image.file(_selectedImage!, fit: BoxFit.cover)
                          : (_currentImageUrl != null &&
                                  _currentImageUrl!.isNotEmpty)
                              ? Image.network(_currentImageUrl!,
                                  fit: BoxFit.cover)
                              : const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_a_photo, size: 50),
                                    Text('Toque para adicionar imagem'),
                                  ],
                                ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Título'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um título';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Descrição'),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira uma descrição';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _orderController,
                    decoration: const InputDecoration(labelText: 'Ordem'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a ordem';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Insira um número válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Visível'),
                    value: _isVisible,
                    onChanged: (value) {
                      setState(() {
                        _isVisible = value;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _save,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                          _isEditing ? 'Salvar Alterações' : 'Criar Programa'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
