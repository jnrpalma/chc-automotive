import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chc_aesthetics/views/register_page.dart';
import 'package:chc_aesthetics/views/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF30343F), // Fundo Gunmetal
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ícone e Nome do App
              const Icon(Icons.lock_outline,
                  size: 100, color: Color(0xFFE4D9FF)), // Periwinkle
              const SizedBox(height: 10),
              const Text(
                "Que bom ter você aqui!",
                style: TextStyle(
                  color: Color(0xFFFAFAFF), // Ghost White
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Confirme seus dados para continuar",
                style: TextStyle(
                  color: Color(0xFFE4D9FF), // Periwinkle
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Campos de entrada
              _buildTextField(_emailController, "Email", Icons.email),
              const SizedBox(height: 15),
              _buildTextField(_passwordController, "Senha", Icons.lock,
                  obscureText: true),
              const SizedBox(height: 20),

              // Botão de Login
              ElevatedButton(
                onPressed: _isLoading ? null : _loginUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF273469), // Delft Blue
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Color(0xFFFAFAFF))
                    : const Text(
                        "Login",
                        style: TextStyle(
                          color: Color(0xFFFAFAFF), // Ghost White
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
              const SizedBox(height: 20),

              // Esqueci minha senha
              TextButton(
                onPressed: _resetPassword,
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFE4D9FF), // Periwinkle
                ),
                child: const Text(
                  "Esqueci minha senha",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Link para cadastro
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Ainda não tem conta?",
                      style: TextStyle(color: Color(0xFFFAFAFF))),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFFE4D9FF), // Periwinkle
                    ),
                    child: const Text(
                      "Cadastre-se!",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Função para autenticar usuário com Firebase
  void _loginUser() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage("Por favor, preencha todos os campos");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _showMessage("Login realizado com sucesso!", success: true);

      // Navega para a HomePage após login bem-sucedido
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      _showMessage(e.message ?? "Erro ao fazer login");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Função para redefinir senha
  void _resetPassword() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      _showMessage("Digite seu email para redefinir a senha.");
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: email);
      _showMessage("Email de redefinição enviado!", success: true);
    } catch (e) {
      _showMessage("Erro ao enviar email. Tente novamente.");
    }
  }

  // Função para exibir mensagens na tela
  void _showMessage(String message, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  // Método para criar os campos de entrada
  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool obscureText = false,
      TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(color: Color(0xFFFAFAFF)), // Ghost White
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFFE4D9FF)), // Periwinkle
        filled: true,
        fillColor: const Color(0xFF1E2749), // Space Cadet (fundo do campo)
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(icon, color: const Color(0xFFE4D9FF)), // Periwinkle
      ),
    );
  }
}
