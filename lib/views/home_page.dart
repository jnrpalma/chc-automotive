import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _backgroundImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _backgroundImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF30343F), // Fundo Gunmetal
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E2749), // Space Cadet
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFFFAFAFF)), // Ghost White
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Color(0xFFFAFAFF)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // **Cabeçalho clicável para alterar o fundo**
          GestureDetector(
            onTap: _pickImage, // Abre a galeria ao clicar
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E2749), // Cor padrão Space Cadet
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                    image: _backgroundImage != null
                        ? DecorationImage(
                            image: FileImage(_backgroundImage!),
                            fit: BoxFit.cover,
                          )
                        : null, // Mantém o fundo azul se nenhuma imagem for escolhida
                  ),
                  child: _backgroundImage == null
                      ? const Center(
                          child: Text(
                            "Clique para alterar o fundo",
                            style: TextStyle(
                              color: Color(0xFFE4D9FF), // Periwinkle
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : null, // Esconde o texto quando há uma imagem
                ),
                Positioned(
                  top: 110,
                  child: CircleAvatar(
                    radius: 75, // Aumentado o tamanho do avatar
                    backgroundColor: const Color(0xFFFAFAFF), // Ghost White
                    child: const CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/300'), // Avatar temporário
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 80),

          // **Título "Últimos serviços"**
          const Text(
            "Últimos serviços",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE4D9FF), // Periwinkle
            ),
          ),

          const SizedBox(height: 20),

          // **Lista de Serviços**
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                ServiceCard(
                  service: "Lavagem simples",
                  car: "Honda Civic",
                  price: "+70\$",
                  date: "22/01/2025",
                ),
                ServiceCard(
                  service: "Revitalização de farol",
                  car: "Honda Civic",
                  price: "+140\$",
                  date: "15/01/2025",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// **Widget para os cartões de serviços**
class ServiceCard extends StatelessWidget {
  final String service;
  final String car;
  final String price;
  final String date;

  const ServiceCard({
    super.key,
    required this.service,
    required this.car,
    required this.price,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF273469), // Delft Blue (Fundo do card)
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFAFAFF), // Ghost White
                  ),
                ),
                Text(
                  car,
                  style:
                      const TextStyle(color: Color(0xFFE4D9FF)), // Periwinkle
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFAFAFF), // Ghost White
                  ),
                ),
                Text(
                  date,
                  style:
                      const TextStyle(color: Color(0xFFE4D9FF)), // Periwinkle
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
