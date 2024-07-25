import 'package:app_teste/app/model/person.dart';
import 'package:app_teste/app/person_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditCardScreen extends StatefulWidget {
  final int index;

  const EditCardScreen({super.key, required this.index});

  @override
  _EditCardScreenState createState() => _EditCardScreenState();
}

class _EditCardScreenState extends State<EditCardScreen> {
  late TextEditingController _nameController;
  late TextEditingController _roleController;
  late TextEditingController _descriptionController;
  // final descriptionController = TextEditingController();
  // final roleController = TextEditingController();
  // final nameController = TextEditingController();

  
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final person = context.read<PersonProvider>().people[widget.index];
    _nameController = TextEditingController(text: person.name);
    _roleController = TextEditingController(text: person.role);
    _descriptionController = TextEditingController(text: person.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1)); // Simula o tempo de salvamento

    final updatedPerson = Person(
      name: _nameController.text,
      role: _roleController.text,
      description: _descriptionController.text,
      imagePath: context.read<PersonProvider>().people[widget.index].imagePath, // Mantém o mesmo imagePath
    );

    Navigator.pop(context, updatedPerson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Card'),
        backgroundColor: const Color.fromARGB(255, 173, 169, 169),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height - 56, // Ajuste para evitar overflow
            ),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _roleController,
                      decoration: InputDecoration(
                        labelText: 'Cargo',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Descrição',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: _saveChanges,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text('Salvar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
