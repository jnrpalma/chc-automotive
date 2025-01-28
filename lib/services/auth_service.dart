import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Registrar usuário com email e senha
  Future<String?> registerUser({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      // Criar usuário no Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Atualizar nome do usuário no Firebase Authentication
      await userCredential.user?.updateDisplayName(name);

      // Salvar informações adicionais no Firestore
      await _firestore.collection("users").doc(userCredential.user?.uid).set({
        "name": name,
        "email": email,
        "phone": phone,
        "createdAt": DateTime.now(),
      });

      return null; // Registro bem-sucedido
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "Este email já está cadastrado.";
      } else if (e.code == "weak-password") {
        return "A senha deve ter pelo menos 6 caracteres.";
      } else {
        return e.message; // Mensagem genérica de erro
      }
    } catch (e) {
      return "Erro ao registrar usuário: $e";
    }
  }
}
