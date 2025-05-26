import 'package:cloud_firestore/cloud_firestore.dart';

class DbService {
  factory DbService() {
    return _instance;
  }

  DbService._internal();

  static final DbService _instance = DbService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getEstoque() async {
    try {
      final collectionRef = _firestore.collection('EstoqueLoja');
      final snapshot = await collectionRef.get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> addStock(
    int codigo,
    String produto,
    int quantidade,
    String tipo,
    double preco,
    String categoria,
  ) async {
    try {
      final collectionRef = _firestore.collection('EstoqueLoja');

      await collectionRef.add({
        'codigo': codigo,
        'produto': produto,
        'quantidade': quantidade,
        'tipo': tipo,
        'preco': preco,
        'categoria': categoria,
      });

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> updateStock(
    int codigo,
    String produto,
    int quantidade,
    String tipo,
    double preco,
  ) async {
    try {
      final collectionRef = _firestore.collection('EstoqueLoja');

      final querySnapshot =
          await collectionRef.where('codigo', isEqualTo: codigo).get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.update({
          'produto': produto,
          'tipo': tipo,
          'quantidade': FieldValue.increment(quantidade),
          'preco': preco,
        });
        return null;
      } else {
        return 'Item não encontrado';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<int> getCurrentCode() async {
    try {
      final collectionRef = _firestore.collection('CodigoProdutos');
      final docRef = collectionRef.doc('CodigoGlobal');
      final docSnapshot = await docRef.get();

      int currentCode = 1;
      if (docSnapshot.exists) {
        currentCode = docSnapshot['codigo'];
      }

      return currentCode;
    } catch (e) {
      return -1;
    }
  }

  Future<void> incrementCode() async {
    try {
      final collectionRef = _firestore.collection('CodigoProdutos');
      final docRef = collectionRef.doc('CodigoGlobal');
      final docSnapshot = await docRef.get();

      int nextCode = 1;
      if (docSnapshot.exists) {
        nextCode = docSnapshot['codigo'];
      }

      await docRef.set({'codigo': nextCode + 1});
    } catch (e) {
      throw Exception("Erro ao incrementar o código");
    }
  }
}
