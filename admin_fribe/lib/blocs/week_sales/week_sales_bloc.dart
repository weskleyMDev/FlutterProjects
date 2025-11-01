import 'package:admin_fribe/models/product_sales.dart';
import 'package:admin_fribe/models/sales_receipt_model.dart';
import 'package:admin_fribe/models/week_product_sales.dart';
import 'package:admin_fribe/models/week_sales.dart';
import 'package:admin_fribe/repositories/sales_receipt/isales_receipt_repository.dart';
import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'week_sales_event.dart';
part 'week_sales_state.dart';

class WeekSalesBloc extends Bloc<WeekSalesEvent, WeekSalesState> {
  final ISalesReceiptRepository _salesReceiptRepository;
  WeekSalesBloc(this._salesReceiptRepository)
    : super(WeekSalesState.initial()) {
    on<WeekSalesRequested>(_onWeekSalesRequested);
  }

  Future<void> _onWeekSalesRequested(
    WeekSalesRequested event,
    Emitter<WeekSalesState> emit,
  ) async {
    emit(
      state.copyWith(
        status: WeekSalesStatus.inProgress,
        clearErrorMessage: true,
      ),
    );
    try {
      final startDate = DateTime(event.year, event.month, 1);
      final endDate = DateTime(
        event.year,
        event.month + 1,
        1,
      ).subtract(Duration(milliseconds: 1));

      final receipts = await _salesReceiptRepository.getSalesReceiptsByMonth(
        startDate: startDate,
        endDate: endDate,
      );

      final result = _buildWeekSales(
        receipts: receipts,
        locale: event.locale,
        year: event.year,
        month: event.month,
        startDate: startDate,
        endDate: endDate,
      );

      emit(
        state.copyWith(
          weekSales: result.weekSales,
          productsSoldByWeek: result.productsSoldByWeek,
          selectedMonth: result.selectedMonth.month,
          selectedYear: result.selectedMonth.year,
          locale: event.locale,
          status: WeekSalesStatus.success,
          allMonths: result.allMonths.whereType<DateTime>().toList(),
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
    required int year,
    required int month,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    final allMonthsSet = <DateTime>{};

    for (final receipt in receipts) {
      allMonthsSet.add(DateTime(receipt.createAt.year, receipt.createAt.month));
    }

    final allMonths = allMonthsSet.toList()..sort((a, b) => b.compareTo(a));

    final DateTime selectedMonth = allMonths.firstWhere(
      (date) => date.year == year && date.month == month,
      orElse: () =>
          allMonths.isNotEmpty ? allMonths.first : DateTime(year, month),
    );

    final filteredReceipts = receipts.where((receipt) {
      final receiptMonth = DateTime(
        receipt.createAt.year,
        receipt.createAt.month,
      );
      return !receipt.createAt.isBefore(startDate) &&
          !receipt.createAt.isAfter(endDate) &&
          receiptMonth == selectedMonth;
    }).toList();

    final groupedMap = <String, WeekSales>{};
    for (final receipt in filteredReceipts) {
      final key = _weekKey(receipt.createAt, locale, startDate, endDate);
      groupedMap[key] =
          groupedMap[key]?.addReceipt(receipt) ??
          WeekSales.empty().copyWith(id: key, salesReceipts: [receipt]);
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

    final productsSoldByWeek = grouped.map((weekSales) {
      final productTotals = <String, Decimal>{};
      for (final receipt in weekSales.salesReceipts) {
        for (final item in receipt.cart) {
          final quantity = _safeDecimalParse(item.quantity.toString());
          productTotals[item.productId] =
              (productTotals[item.productId] ?? Decimal.zero) + quantity;
        }
      }

      final productSalesList = productTotals.entries.map((entry) {
        return ProductSales.empty().copyWith(
          productId: entry.key,
          totalSales: entry.value,
        );
      }).toList();

      return WeekProductSales.empty().copyWith(
        id: weekSales.id,
        productSales: productSalesList,
      );
    }).toList();

    return _WeekSalesResult(
      weekSales: grouped,
      productsSoldByWeek: productsSoldByWeek,
      selectedMonth: selectedMonth,
      allMonths: allMonths,
    );
  }
}

String _weekKey(
  DateTime date,
  String locale,
  DateTime startDate,
  DateTime endDate,
) {
  final daysSinceStart = date.difference(startDate).inDays;
  final weekIndex = (daysSinceStart / 7).floor();
  final weekStart = startDate.add(Duration(days: weekIndex * 7));
  final tentativeWeekEnd = weekStart.add(const Duration(days: 6));
  final weekEnd = tentativeWeekEnd.isAfter(endDate)
      ? endDate
      : tentativeWeekEnd;
  return '${DateFormat.yMd(locale).format(weekStart)} - ${DateFormat.yMd(locale).format(weekEnd)}';
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
  final DateTime selectedMonth;
  final List<DateTime> allMonths;

  _WeekSalesResult({
    required this.weekSales,
    required this.productsSoldByWeek,
    required this.selectedMonth,
    required this.allMonths,
  });
}
