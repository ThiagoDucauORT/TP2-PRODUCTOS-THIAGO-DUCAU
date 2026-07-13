import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResultsScreen extends StatelessWidget {
  final Map<String, dynamic> results;

  const ResultsScreen({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    // Función auxiliar para crear tarjetas de resultados
    Widget buildResultCard(String title, String name, String description) {
      return Card(
        color: Colors.blueGrey[800],
        elevation: 6,
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.tealAccent[100],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blueGrey[300],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: const Text('Resultados'),
        backgroundColor: Colors.blueGrey[900],
        elevation: 0,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.go('/home'), // Volver a la pantalla de inicio
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildResultCard(
              'Producto más caro',
              results['mostExpensiveName'] ?? 'N/A',
              results['mostExpensiveDescription'] ?? 'N/A',
            ),
            buildResultCard(
              'Producto más barato',
              results['cheapestName'] ?? 'N/A',
              results['cheapestDescription'] ?? 'N/A',
            ),
            buildResultCard(
              'Producto con mayor cantidad',
              results['highestQuantityName'] ?? 'N/A',
              results['highestQuantityDescription'] ?? 'N/A',
            ),
            buildResultCard(
              'Producto con menor cantidad',
              results['lowestQuantityName'] ?? 'N/A',
              results['lowestQuantityDescription'] ?? 'N/A',
            ),
            Card(
              color: Colors.blueGrey[800],
              elevation: 6,
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Precio promedio',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.tealAccent[100],
                      ),
                    ),
                    Text(
                      '\$${(results['averagePrice'] as double?)?.toStringAsFixed(2) ?? '0.00'}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.greenAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              child: const Text('Salir'),
            ),
          ],
        ),
      ),
    );
  }
}