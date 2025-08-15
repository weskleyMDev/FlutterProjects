import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_v2/repositories/coupon/icoupon_repository.dart';

class CouponRepository implements ICouponRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<Map<String, dynamic>?> getCoupon(String coupon) async {
    try {
      final doc = await _firestore.collection('coupons').doc(coupon).get();
      if (doc.exists) {
        return doc.data();
      } else {
        throw Exception('Coupon not found');
      }
    } catch (e) {
      rethrow;
    }
  }
}
