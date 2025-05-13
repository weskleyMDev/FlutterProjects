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
    String codigo,
    String produto,
    int quantidade,
    double preco,
    String categoria,
  ) async {
    try {
      // Reference to the 'estoque' collection
      final collectionRef = _firestore.collection('estoque');

      // Add a document to the collection
      await collectionRef.add({
        'codigo': codigo,
        'produto': produto,
        'quantidade': quantidade,
        'preco': preco,
        'venda': preco + (preco * 0.3),
        'total': (preco + (preco * 0.3)) * quantidade,
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
  Future<String?> updateStock(
    String codigo,
    int quantidade,
    double preco,
  ) async {
    try {
      // Reference to the 'estoque' collection
      final collectionRef = _firestore.collection('estoque');

      // Get the document by codigo
      final querySnapshot = await collectionRef
          .where('codigo', isEqualTo: codigo)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Update the document
        await querySnapshot.docs.first.reference.update({
          'quantidade': FieldValue.increment(quantidade),
          'preco': preco,
          'venda': preco + (preco * 0.3),
          'total': (preco + (preco * 0.3)) * (querySnapshot.docs.first['quantidade'] + quantidade),
        });
        return null; // Return null if the operation is successful
      } else {
        return 'Item not found'; // Return error if item not found
      }
    } catch (e) {
      return e.toString(); // Return the error message if something goes wrong
    }
  }
}
