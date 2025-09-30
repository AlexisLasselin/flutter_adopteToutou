import 'package:flutter/material.dart';

class Dog {
  final String name;
  final String sexe;
  final int age;
  final String imageUrl;
  final String breed;

  Dog({
    required this.name,
    required this.sexe,
    required this.age,
    required this.imageUrl,
    required this.breed,
  });
}

// Couleurs du projet
const Color brownLight = Color(0xFF684e32);
const Color brownDark = Color(0xFF5d3a00);
const Color yellowPale = Color(0xFFf9ea9a);
const Color orange = Color(0xFFf98948);
const Color yellowDark = Color(0xFF9b8816);

class UserPage extends StatefulWidget {
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final List<Dog> dogs = [
    Dog(name: 'Rex', sexe: 'Mâle', age: 3, imageUrl: 'https://placedog.net/400?id=1', breed: 'Labrador'),
    Dog(name: 'Bella', sexe: 'Femelle', age: 2, imageUrl: 'https://placedog.net/400?id=2', breed: 'Golden Retriever'),
    Dog(name: 'Charlie', sexe: 'Mâle', age: 5, imageUrl: 'https://placedog.net/400?id=3', breed: 'Beagle'),
    Dog(name: 'Luna', sexe: 'Femelle', age: 1, imageUrl: 'https://placedog.net/400?id=4', breed: 'Beagle'),
  ];

  String selectedBreed = 'Tous';

  void _showAppointmentDialog(BuildContext context, String dogName) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Prendre rendez-vous'),
        content: Text('Souhaitez-vous prendre rendez-vous pour adopter $dogName ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Annuler', style: TextStyle(color: brownDark)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: brownDark),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Rendez-vous demandé pour $dogName'),
                  backgroundColor: orange,
                ),
              );
            },
            child: Text('Confirmer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Liste des races uniques + "Tous"
    List<String> breeds = ['Tous', ...{...dogs.map((d) => d.breed)}];

    // Filtrage
    List<Dog> filteredDogs = selectedBreed == 'Tous'
        ? dogs
        : dogs.where((dog) => dog.breed == selectedBreed).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des chiens'),
        backgroundColor: brownLight,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Dropdown pour filtrer
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: DropdownButtonFormField<String>(
              value: selectedBreed,
              decoration: InputDecoration(
                labelText: 'Filtrer par race',
                border: OutlineInputBorder(),
              ),
              items: breeds.map((breed) {
                return DropdownMenuItem(
                  value: breed,
                  child: Text(breed),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedBreed = value;
                  });
                }
              },
            ),
          ),

          // Liste des chiens filtrés
          Expanded(
            child: ListView.builder(
              itemCount: filteredDogs.length,
              itemBuilder: (context, index) {
                final dog = filteredDogs[index];
                return Card(
                  color: yellowPale,
                  margin: EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 4,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                        child: Image.network(
                          dog.imageUrl,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dog.name,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: brownDark,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Âge : ${dog.age} ans',
                              style: TextStyle(
                                fontSize: 16,
                                color: yellowDark,
                              ),
                            ),
                            SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: brownDark,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () => _showAppointmentDialog(context, dog.name),
                                child: Text('Prendre rendez-vous'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
