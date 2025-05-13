import 'package:cloud_firestore/cloud_firestore.dart';

class DbService {
  // Factory constructor to return the same instance
  factory DbService() {
    return _instance;
  }

  // Private constructor
  DbService._internal();

  // Singleton instance
  static final DbService _instance = DbService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a new document to the 'estoque' collection
  Future<String?> addStock(
    int codigo,
    String produto,
    int quantidade,
    double preco,
    String categoria,
  ) async {
    try {
      // Reference to the 'estoque' collection
      final collectionRef = _firestore.collection('EstoqueLoja');

      // Add a document to the collection
      await collectionRef.add({
        'codigo': codigo,
        'produto': produto,
        'quantidade': quantidade,
        'preco': preco,
        'categoria': categoria,
      });

      return null; // Return null if the operation is successful
    } catch (e) {
      return e.toString(); // Return the error message if something goes wrong
    }
  }

  // Update an existing document in the 'estoque' collection
  // update only the quantidade and preco fields by codigo
  // quantidade = old quantidade + new quantidade
  Future<String?> updateStock(int codigo, int quantidade, double preco) async {
    try {
      // Reference to the 'EstoqueLoja' collection
      final collectionRef = _firestore.collection('EstoqueLoja');

      // Get the document by codigo
      final querySnapshot =
          await collectionRef.where('codigo', isEqualTo: codigo).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Update the document
        await querySnapshot.docs.first.reference.update({
          'quantidade': FieldValue.increment(quantidade),
          'preco': preco,
        });
        return null; // Return null if the operation is successful
      } else {
        return 'Item not found'; // Return error if item not found
      }
    } catch (e) {
      return e.toString(); // Return the error message if something goes wrong
    }
  }

  Future<int> getCurrentCode() async {
    try {
      final collectionRef = _firestore.collection('CodigoProdutos');
      final docRef = collectionRef.doc('CodigoGlobal');
      final docSnapshot = await docRef.get();

      int currentCode = 1; // Valor inicial
      if (docSnapshot.exists) {
        currentCode = docSnapshot['codigo'];
      }

      return currentCode;
    } catch (e) {
      return -1; // Em caso de erro, retorna -1
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

      // Incrementa o código no Firestore
      await docRef.set({'codigo': nextCode + 1});
    } catch (e) {
      // Lidar com erros, caso necessário
      throw Exception("Erro ao incrementar o código");
    }
  }
}
