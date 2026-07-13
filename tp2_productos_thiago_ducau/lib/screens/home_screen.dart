import 'package:flutter/material.dart';
import 'package:tp2_productos_thiago_ducau/core/router/entities/product.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  final String? username;

  const HomeScreen({super.key, this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();

  final List<Product> products = [];

  void _addProduct() {
    if (formKey.currentState!.validate()) {
      setState(() {
        final newProduct = Product(
          name: nameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          quantity: int.parse(quantityController.text),
        );

        products.add(newProduct);

        nameController.clear();
        descriptionController.clear();
        priceController.clear();
        quantityController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Producto agregado con éxito'),
            backgroundColor: Colors.green, // Feedback visual positivo
          ),
        );
      });
    }
  }

  void _calculateResults() {
    if (products.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debe ingresar al menos un producto'),
          backgroundColor: Colors.orange, // Feedback visual de advertencia
        ),
      );
      return;
    }

    final mostExpensiveProduct =
        products.reduce((a, b) => a.price > b.price ? a : b);
    final cheapestProduct =
        products.reduce((a, b) => a.price < b.price ? a : b);
    final highestQuantityProduct =
        products.reduce((a, b) => a.quantity > b.quantity ? a : b);
    final lowestQuantityProduct =
        products.reduce((a, b) => a.quantity < b.quantity ? a : b);
    final totalPrice = products.fold(0.0, (sum, item) => sum + item.price);
    final averagePrice = totalPrice / products.length;

    final results = {
      'mostExpensiveName': mostExpensiveProduct.name,
      'mostExpensiveDescription': mostExpensiveProduct.description,
      'cheapestName': cheapestProduct.name,
      'cheapestDescription': cheapestProduct.description,
      'highestQuantityName': highestQuantityProduct.name,
      'highestQuantityDescription': highestQuantityProduct.description,
      'lowestQuantityName': lowestQuantityProduct.name,
      'lowestQuantityDescription': lowestQuantityProduct.description,
      'averagePrice': averagePrice,
    };

    context.go('/results', extra: results);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Fondo ligeramente gris para que resalte la tarjeta
      appBar: AppBar(
        title: Text('Hola, ${widget.username ?? 'Usuario'}'),
        backgroundColor: Colors.indigo, // Color clásico y elegante para el AppBar
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 3, // Sombra sutil
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Bordes un poco redondeados
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0), // Espaciado interno de la tarjeta
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Para que la tarjeta se adapte al contenido
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Nuevo Producto",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nombre',
                        prefixIcon: Icon(Icons.shopping_bag_outlined),
                        border: OutlineInputBorder(), // Borde estándar de Material
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Requerido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Descripción',
                        prefixIcon: Icon(Icons.description_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Requerido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: priceController,
                      decoration: const InputDecoration(
                        labelText: 'Precio',
                        prefixIcon: Icon(Icons.attach_money),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Requerido';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Número inválido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: quantityController,
                      decoration: const InputDecoration(
                        labelText: 'Cantidad',
                        prefixIcon: Icon(Icons.numbers),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Requerido';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Entero inválido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _addProduct,
                      icon: const Icon(Icons.add),
                      label: const Text('Agregar Producto'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.green, // Botón de acción principal
                        foregroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _calculateResults,
                      icon: const Icon(Icons.analytics_outlined),
                      label: const Text('Ver Resultados'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.indigo, // Botón secundario
                        foregroundColor: Colors.white,
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