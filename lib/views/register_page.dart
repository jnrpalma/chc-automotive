import 'package:flutter/material.dart';
import 'package:chc_aesthetics/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final AuthService _authService = AuthService();

  bool _isLoading = false; // Indicador de carregamento

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Impede o layout de mudar com o teclado
      backgroundColor: const Color(0xFF30343F), // Fundo Gunmetal
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              // **Cabeçalho fixo**
              Container(
                padding: const EdgeInsets.only(top: 60, bottom: 30),
                color: Colors.transparent,
                child: Column(
                  children: [
                    const Icon(
                      Icons.car_repair,
                      size: 100,
                      color: Color(0xFFE4D9FF), // Periwinkle
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "CHC Estética Automotiva",
                      style: TextStyle(
                        color: Color(0xFFFAFAFF), // Ghost White
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // **Área Rolável dos Campos**
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      _buildTextField(
                          _nameController, "Nome completo", Icons.person),
                      const SizedBox(height: 15),
                      _buildTextField(_emailController, "Email", Icons.email,
                          keyboardType: TextInputType.emailAddress),
                      const SizedBox(height: 15),
                      _buildTextField(_phoneController, "Telefone", Icons.phone,
                          keyboardType: TextInputType.phone),
                      const SizedBox(height: 15),
                      _buildTextField(_passwordController, "Senha", Icons.lock,
                          obscureText: true),
                      const SizedBox(height: 15),
                      _buildTextField(_confirmPasswordController,
                          "Confirme sua senha", Icons.lock_outline,
                          obscureText: true),
                      const SizedBox(height: 30),

                      // **Botão de Cadastro**
                      ElevatedButton(
                        onPressed: _isLoading ? null : _registerUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF273469), // Delft Blue
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 15),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Color(0xFFFAFAFF))
                            : const Text(
                                "Cadastrar",
                                style: TextStyle(
                                  color: Color(0xFFFAFAFF), // Ghost White
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      const SizedBox(height: 20),

                      // **Botão para voltar ao login**
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Já tem uma conta?",
                              style: TextStyle(color: Color(0xFFFAFAFF))),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  const Color(0xFFE4D9FF), // Periwinkle
                            ),
                            child: const Text(
                              "Faça login",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // **Método para lidar com o cadastro do usuário**
  void _registerUser() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showMessage("Por favor, preencha todos os campos");
      return;
    }

    if (password != confirmPassword) {
      _showMessage("As senhas não coincidem");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    String? errorMessage = await _authService.registerUser(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );

    setState(() {
      _isLoading = false;
    });

    if (errorMessage == null) {
      _showMessage("Cadastro realizado com sucesso!", success: true);
      Navigator.pop(context); // Volta para a tela de login
    } else {
      _showMessage(errorMessage);
    }
  }

  // **Método para exibir mensagens**
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
