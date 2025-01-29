import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chc_aesthetics/components/service_card.dart';
import 'package:chc_aesthetics/utils/app_colors.dart';
import 'package:chc_aesthetics/views/login_page.dart'; // Importando LoginPage para o Logout

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _backgroundImage;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _backgroundImage = File(pickedFile.path);
      });
    }
  }

  void _logout() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: AppColors.textLight),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: AppColors.textLight),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: AppColors.primary,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: AppColors.primary),
              accountName: Text(
                user?.displayName ?? "Usuário",
                style: const TextStyle(color: AppColors.textLight),
              ),
              accountEmail: Text(
                user?.email ?? "email@example.com",
                style: const TextStyle(color: AppColors.accent),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: AppColors.accent,
                backgroundImage: user?.photoURL != null
                    ? NetworkImage(user!.photoURL!)
                    : const NetworkImage('https://i.pravatar.cc/300'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: AppColors.textLight),
              title: const Text("Meu Perfil",
                  style: TextStyle(color: AppColors.textLight)),
              onTap: () {
                // Navegar para a tela de perfil (implementar depois)
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.calendar_today, color: AppColors.textLight),
              title: const Text("Meus Agendamentos",
                  style: TextStyle(color: AppColors.textLight)),
              onTap: () {
                // Navegar para a tela de agendamentos (implementar depois)
              },
            ),
            const Divider(color: AppColors.accent),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.redAccent),
              title: const Text("Logout",
                  style: TextStyle(color: Colors.redAccent)),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                    image: _backgroundImage != null
                        ? DecorationImage(
                            image: FileImage(_backgroundImage!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _backgroundImage == null
                      ? const Center(
                          child: Text(
                            "Clique para alterar o fundo",
                            style: TextStyle(
                              color: AppColors.accent,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : null,
                ),
                Positioned(
                  top: 110,
                  child: CircleAvatar(
                    radius: 75,
                    backgroundColor: AppColors.textLight,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: user?.photoURL != null
                          ? NetworkImage(user!.photoURL!)
                          : const NetworkImage('https://i.pravatar.cc/300'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 100),
          const Text(
            "Últimos serviços",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.accent,
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
