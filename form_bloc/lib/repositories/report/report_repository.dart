import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form_bloc/models/report_model.dart';
import 'package:form_bloc/repositories/report/ireport_repository.dart';

final class ReportRepository implements IReportRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<ReportModel>> getReports(String uid) => _firestore
      .collection('reports')
      .where('userId', isEqualTo: uid)
      .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  Map<String, dynamic> _toFirestore(ReportModel report, SetOptions? options) =>
      report.toMap();

  ReportModel _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    if (data != null) {
      return ReportModel.fromMap(data);
    } else {
      throw Exception('Invalid data');
    }
  }

  @override
  Future<void> addReport(ReportModel report) async {
    try {
      await _firestore
          .collection('reports')
          .doc(report.id)
          .withConverter(
            fromFirestore: _fromFirestore,
            toFirestore: _toFirestore,
          )
          .set(report);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeReport(ReportModel report) async {
    try {
      await _firestore.collection('reports').doc(report.id).delete();
    } catch (e) {
      rethrow;
    }
  }
}
