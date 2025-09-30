import 'package:flutter/material.dart';

// Modèle de données pour un chien
class Dog {
  final String id;
  String name;
  String sex;
  int age;
  String race;
  String imageUrl;

  Dog({
    required this.id,
    required this.name,
    required this.sex,
    required this.age,
    required this.race,
    required this.imageUrl,
  });
}

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  // Liste des chiens (exemple avec des données de démo)
  List<Dog> dogs = [
    Dog(
      id: '1',
      name: 'Max',
      sex: 'Mâle',
      age: 3,
      race: 'Labrador',
      imageUrl:
          'https://images.unsplash.com/photo-1552053831-71594a27632d?w=400',
    ),
    Dog(
      id: '2',
      name: 'Luna',
      sex: 'Femelle',
      age: 2,
      race: 'Golden Retriever',
      imageUrl:
          'https://images.unsplash.com/photo-1633722715463-d30f4f325e24?w=400',
    ),
  ];

  void _deleteDog(String id) {
    setState(() {
      dogs.removeWhere((dog) => dog.id == id);
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Un meilleur ami trouvé')));
  }

  void _showAddEditDialog({Dog? dog}) {
    final isEditing = dog != null;
    final nameController = TextEditingController(text: dog?.name ?? '');
    final sexController = TextEditingController(text: dog?.sex ?? '');
    final ageController = TextEditingController(
      text: dog?.age.toString() ?? '',
    );
    final raceController = TextEditingController(text: dog?.race ?? '');
    final imageController = TextEditingController(text: dog?.imageUrl ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? 'Modifier le chien' : 'Ajouter un chien'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nom'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: sexController,
                decoration: const InputDecoration(labelText: 'Sexe'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(labelText: 'Âge'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: raceController,
                decoration: const InputDecoration(labelText: 'Race'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: imageController,
                decoration: const InputDecoration(labelText: 'URL Image'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              if (isEditing) {
                setState(() {
                  dog.name = nameController.text;
                  dog.sex = sexController.text;
                  dog.age = int.tryParse(ageController.text) ?? 0;
                  dog.race = raceController.text;
                  dog.imageUrl = imageController.text;
                });
              } else {
                setState(() {
                  dogs.add(
                    Dog(
                      id: DateTime.now().toString(),
                      name: nameController.text,
                      sex: sexController.text,
                      age: int.tryParse(ageController.text) ?? 0,
                      race: raceController.text,
                      imageUrl: imageController.text,
                    ),
                  );
                });
              }
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF98948),
            ),
            child: Text(isEditing ? 'Modifier' : 'Ajouter'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E7),
      appBar: AppBar(
        title: const Text('Administration'),
        backgroundColor: const Color(0xFF9B8816),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle, size: 32),
            onPressed: () => _showAddEditDialog(),
            tooltip: 'Ajouter un chien',
          ),
        ],
      ),
      body: dogs.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.pets, size: 80, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text(
                    'Aucun chien pour le moment',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: dogs.length,
              itemBuilder: (context, index) {
                final dog = dogs[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        // Image du chien
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            dog.imageUrl,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 100,
                                height: 100,
                                color: Colors.grey.shade300,
                                child: const Icon(Icons.pets, size: 40),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Infos du chien
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dog.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF5D3A00),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${dog.sex} • ${dog.age} ans',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              Text(
                                dog.race,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 12),
                              // Boutons d'action
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () =>
                                          _showAddEditDialog(dog: dog),
                                      icon: const Icon(Icons.edit, size: 18),
                                      label: const Text('Modifier'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF9B8816,
                                        ),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () => _deleteDog(dog.id),
                                      icon: const Icon(
                                        Icons.favorite,
                                        size: 18,
                                      ),
                                      label: const Text('Adopté'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFFF98948,
                                        ),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
