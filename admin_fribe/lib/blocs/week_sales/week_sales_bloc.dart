import 'package:admin_fribe/models/product_sales.dart';
import 'package:admin_fribe/models/sales_receipt_model.dart';
import 'package:admin_fribe/models/week_product_sales.dart';
import 'package:admin_fribe/models/week_sales.dart';
import 'package:admin_fribe/utils/capitalize_text.dart';
import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'week_sales_event.dart';
part 'week_sales_state.dart';

class WeekSalesBloc extends Bloc<WeekSalesEvent, WeekSalesState> {
  WeekSalesBloc() : super(WeekSalesState.initial()) {
    on<WeekSalesRequested>(_onWeekSalesRequested);
  }

  Future<void> _onWeekSalesRequested(
    WeekSalesRequested event,
    Emitter<WeekSalesState> emit,
  ) async {
    emit(
      state.copyWith(status: WeekSalesStatus.inProgress, errorMessage: null),
    );

    try {
      final result = _buildWeekSales(
        receipts: event.receipts,
        locale: event.locale,
        month: event.month,
      );

      emit(
        state.copyWith(
          weekSales: result.weekSales,
          productsSoldByWeek: result.productsSoldByWeek,
          selectedMonth: result.selectedMonth,
          locale: event.locale,
          status: WeekSalesStatus.success,
          allMonths: result.allMonths,
          originalReceipts: event.receipts,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: WeekSalesStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  _WeekSalesResult _buildWeekSales({
    required List<SalesReceipt> receipts,
    required String locale,
    required String month,
  }) {
    final startDate = DateTime(2025, 10, 1);

    final allMonthsSet = <String>{};
    final mapMonthToDate = <String, DateTime>{};

    for (final receipt in receipts) {
      if (receipt.createAt.isBefore(startDate)) continue;

      final mKey = _monthKey(receipt.createAt, locale);
      allMonthsSet.add(mKey);
      mapMonthToDate[mKey] = DateTime(
        receipt.createAt.year,
        receipt.createAt.month,
      );
    }

    final allMonths = allMonthsSet.toList()
      ..sort((a, b) => mapMonthToDate[b]!.compareTo(mapMonthToDate[a]!));

    final selectedMonth = (month.isNotEmpty)
        ? month
        : (allMonths.isNotEmpty ? allMonths.first : null);

    final filteredReceipts = receipts.where((receipt) {
      if (receipt.createAt.isBefore(startDate)) return false;
      final mKey = _monthKey(receipt.createAt, locale);
      return mKey == selectedMonth;
    }).toList();

    final groupedMap = <String, WeekSales>{};
    for (final receipt in filteredReceipts) {
      final key = _weekKey(receipt.createAt, locale);
      final existing = groupedMap[key];
      if (existing == null) {
        groupedMap[key] = WeekSales.empty().copyWith(
          id: key,
          salesReceipts: [receipt],
        );
      } else {
        groupedMap[key] = existing.addReceipt(receipt);
      }
    }

    final grouped = groupedMap.values.toList()
      ..sort((a, b) {
        final startA = DateFormat.yMd(
          locale,
        ).parse(a.id.split(' - ').first.trim());
        final startB = DateFormat.yMd(
          locale,
        ).parse(b.id.split(' - ').first.trim());
        return startB.compareTo(startA);
      });

    final productsSoldByWeek = <WeekProductSales>[];
    for (final weekSales in grouped) {
      final productTotals = <String, Decimal>{};

      for (final receipt in weekSales.salesReceipts) {
        for (final item in receipt.cart) {
          final productId = item.productId;
          final quantity = _safeDecimalParse(item.quantity.toString());
          productTotals[productId] =
              (productTotals[productId] ?? Decimal.zero) + quantity;
        }
      }

      final productSalesList = productTotals.entries
          .map(
            (entry) => ProductSales.empty().copyWith(
              productId: entry.key,
              totalSales: entry.value,
            ),
          )
          .toList();

      productsSoldByWeek.add(
        WeekProductSales.empty().copyWith(
          id: weekSales.id,
          productSales: productSalesList,
        ),
      );
    }

    return _WeekSalesResult(
      weekSales: grouped,
      productsSoldByWeek: productsSoldByWeek,
      selectedMonth: selectedMonth,
      allMonths: allMonths,
    );
  }
}

String _weekKey(DateTime date, String locale) {
  final startDay = DateTime(2025, 10, 1);
  final daysSinceStart = date.difference(startDay).inDays;
  final weekIndex = (daysSinceStart / 7).floor();
  final weekStart = startDay.add(Duration(days: weekIndex * 7));
  final weekEnd = weekStart.add(const Duration(days: 6));
  return '${DateFormat.yMd(locale).format(weekStart)} - ${DateFormat.yMd(locale).format(weekEnd)}';
}

String _monthKey(DateTime date, String locale) {
  return DateFormat.yMMMM(locale).format(date).capitalize();
}

Decimal _safeDecimalParse(String? input) {
  if (input == null) return Decimal.zero;
  final cleaned = input.replaceAll(RegExp(r'[^\d.-]'), '');
  return (cleaned.isEmpty || cleaned == '.' || cleaned == '-')
      ? Decimal.zero
      : Decimal.tryParse(cleaned) ?? Decimal.zero;
}

class _WeekSalesResult {
  final List<WeekSales> weekSales;
  final List<WeekProductSales> productsSoldByWeek;
  final String? selectedMonth;
  final List<String> allMonths;

  _WeekSalesResult({
    required this.weekSales,
    required this.productsSoldByWeek,
    required this.selectedMonth,
    required this.allMonths,
  });
}
