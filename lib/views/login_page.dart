import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chc_aesthetics/views/register_page.dart';
import 'package:chc_aesthetics/views/home_page.dart';
import 'package:chc_aesthetics/utils/app_colors.dart'; // Importando cores centralizadas

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
      resizeToAvoidBottomInset: false, // Impede que o layout inteiro se mova
      backgroundColor: AppColors.background,
      body: GestureDetector(
        onTap: () =>
            FocusScope.of(context).unfocus(), // Fecha o teclado ao tocar fora
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  // **Cabeçalho fixo**
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.lock_outline,
                          size: 90, // Tamanho ajustado
                          color: AppColors.accent, // Periwinkle
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Que bom ter você aqui!",
                          style: TextStyle(
                            color: AppColors.textLight, // Ghost White
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Confirme seus dados para continuar",
                          style: TextStyle(
                            color: AppColors.accent, // Periwinkle
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(), // Garante que o cabeçalho não suba

                  // **Campos do formulário com rolagem**
                  Expanded(
                    flex: 3, // Garante uma proporção equilibrada
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          _buildTextField(
                              _emailController, "Email", Icons.email),
                          const SizedBox(height: 15),
                          _buildTextField(
                              _passwordController, "Senha", Icons.lock,
                              obscureText: true),
                          const SizedBox(height: 20),

                          // **Botão de Login**
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _loginUser,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppColors.secondary, // Delft Blue
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                              ),
                              child: _isLoading
                                  ? const CircularProgressIndicator(
                                      color: AppColors.textLight)
                                  : const Text(
                                      "Login",
                                      style: TextStyle(
                                        color:
                                            AppColors.textLight, // Ghost White
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // **Esqueci minha senha**
                          TextButton(
                            onPressed: _resetPassword,
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.accent, // Periwinkle
                            ),
                            child: const Text(
                              "Esqueci minha senha",
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // **Link para cadastro**
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Ainda não tem conta?",
                                  style: TextStyle(color: AppColors.textLight)),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterPage()),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor:
                                      AppColors.accent, // Periwinkle
                                ),
                                child: const Text(
                                  "Cadastre-se!",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),

                          // **Compensação para teclado**
                          SizedBox(
                              height: MediaQuery.of(context).viewInsets.bottom),
                        ],
                      ),
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

  // **Função para autenticar usuário com Firebase**
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

  // **Função para redefinir senha**
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

  // **Função para exibir mensagens na tela**
  void _showMessage(String message, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  // **Método para criar os campos de entrada**
  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool obscureText = false,
      TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(color: AppColors.textLight), // Ghost White
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.accent), // Periwinkle
        filled: true,
        fillColor: AppColors.primary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(icon, color: AppColors.accent), // Periwinkle
      ),
    );
  }
}
