import 'package:flutter/material.dart';
import 'pages/user.dart';    // 👈 Import de la page des chiens
import 'pages/admin.dart';  // 👈 Import de la page admin


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adopt\'Toutou',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const HomePage(),
      routes: {
          '/dogs-list': (context) => UserPage(),
          '/admin': (context) => AdminPage(),

      },
    );
  }
}

// ============================================
// PAGE D'ACCUEIL
// ============================================

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tapCount = 0;
  DateTime? _lastTap;

  void _handleLogoTap() {
    final now = DateTime.now();
    
    // Réinitialiser le compteur si plus de 2 secondes se sont écoulées
    if (_lastTap == null || now.difference(_lastTap!) > const Duration(seconds: 2)) {
      _tapCount = 1;
    } else {
      _tapCount++;
    }
    
    _lastTap = now;
    
    // Si 3 taps rapides, ouvrir la page admin
    if (_tapCount >= 3) {
      _tapCount = 0;
      _lastTap = null;
      Navigator.pushNamed(context, '/admin');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9EA9A),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                
                // Logo cliquable (bouton caché pour admin)
                GestureDetector(
                  onTap: _handleLogoTap,
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF5D3A00).withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Titre
                const Text(
                  'ADOPT\'TOUTOU',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D3A00),
                    letterSpacing: 2,
                  ),
                ),
                
                const SizedBox(height: 10),
                
               
                
                const Spacer(flex: 2),
                
                // Bouton principal
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/dogs-list');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF98948),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 8,
                    shadowColor: const Color(0xFF5D3A00).withOpacity(0.3),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Voir les chiens',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.pets, size: 24),
                    ],
                  ),
                ),
                
                const Spacer(flex: 1),
                
                // Indication discrète pour l'admin
                Text(
                  '🐾',
                  style: TextStyle(
                    fontSize: 20,
                    color: const Color(0xFF9B8816).withOpacity(0.3),
                  ),
                ),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}