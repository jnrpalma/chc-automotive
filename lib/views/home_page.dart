import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // **Cabeçalho arredondado**
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(30)),
                ),
              ),
              Positioned(
                top: 110,
                child: const CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 80),

          const Text(
            "Últimos serviços",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 20),

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
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(car, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(date, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
