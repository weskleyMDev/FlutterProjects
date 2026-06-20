import 'package:equatable/equatable.dart';

final class UpdateAmountResult extends Equatable {
  final String oldAmount;
  final String addedAmount;
  final String newAmount;

  const UpdateAmountResult({
    required this.oldAmount,
    required this.addedAmount,
    required this.newAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'oldAmount': oldAmount,
      'addedAmount': addedAmount,
      'newAmount': newAmount,
    };
  }

  @override
  List<Object> get props => [oldAmount, addedAmount, newAmount];
}