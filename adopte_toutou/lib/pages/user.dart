import 'package:flutter/material.dart';

class Dog {
  final String name;
  final String sexe;
  final int age;
  final String imageUrl;
  final String breed;

  Dog({required this.name, required this.sexe, required this.age, required this.imageUrl, required this.breed});
}

class UserPage extends StatelessWidget {
  final List<Dog> dogs = [
    Dog(name: 'Rex', sexe: 'Mâle', age: 3, imageUrl: 'https://placedog.net/400?id=1', breed: 'Labrador'),
    Dog(name: 'Bella', sexe: 'Femelle', age: 2, imageUrl: 'https://placedog.net/400?id=2', breed: 'Golden Retriever'),
    Dog(name: 'Charlie', sexe: 'Mâle', age: 5, imageUrl: 'https://placedog.net/400?id=3', breed: 'Beagle'),
  ];

  void _showAppointmentDialog(BuildContext context, String dogName) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Prendre rendez-vous'),
        content: Text('Souhaitez-vous prendre rendez-vous pour adopter $dogName ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Logique pour prise de rendez-vous ici
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Rendez-vous demandé pour $dogName')),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des chiens'),
      ),
      body: ListView.builder(
        itemCount: dogs.length,
        itemBuilder: (context, index) {
          final dog = dogs[index];
          return Card(
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
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Âge : ${dog.age} ans',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
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
    );
  }
}
