import 'package:admin_fribe/blocs/update_amount/update_amount_bloc.dart';
import 'package:admin_fribe/logs/update_amount_log.dart';
import 'package:admin_fribe/models/update_amount_result.dart';
import 'package:admin_fribe/repositories/products/product_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';

class MockProductRepository extends Mock implements IProductRepository {}

class MockUpdateAmountLog extends Mock implements IUpdateAmountLog {}

void main() {
  late IProductRepository mockProductRepository;
  late IUpdateAmountLog mockUpdateAmountLog;

  setUp(() {
    mockProductRepository = MockProductRepository();
    mockUpdateAmountLog = MockUpdateAmountLog();
  });

  blocTest<UpdateAmountBloc, UpdateAmountState>(
    'should update amount and write log when submission succeeds',
    build: () {
      when(
        () => mockProductRepository.updateProductAmount(
          productId: any(named: 'productId'),
          newAmount: any(named: 'newAmount'),
        ),
      ).thenAnswer(
        (_) async => const UpdateAmountResult(
          oldAmount: '10',
          addedAmount: '5',
          newAmount: '15',
        ),
      );

      when(
        () => mockUpdateAmountLog.writeLog(logEntry: any(named: 'logEntry')),
      ).thenAnswer((_) async {});

      return UpdateAmountBloc(
        productRepository: mockProductRepository,
        updateAmountLog: mockUpdateAmountLog,
      );
    },

    act: (bloc) {
      bloc
        ..add(const AmountInputChanged('5'))
        ..add(const UpdateAmountSubmitted('product123'));
    },

    expect: () => [
      isA<UpdateAmountState>().having(
        (state) => state.amountInput.value,
        'amount',
        '5',
      ),

      isA<UpdateAmountState>().having(
        (state) => state.submissionStatus,
        'status',
        FormzSubmissionStatus.inProgress,
      ),

      isA<UpdateAmountState>().having(
        (state) => state.submissionStatus,
        'status',
        FormzSubmissionStatus.success,
      ),
    ],

    verify: (_) {
      verify(
        () => mockProductRepository.updateProductAmount(
          productId: 'product123',
          newAmount: '5',
        ),
      ).called(1);

      final captured = verify(
        () => mockUpdateAmountLog.writeLog(
          logEntry: captureAny(named: 'logEntry'),
        ),
      ).captured;

      expect(captured.length, 1);

      final log = captured.first as String;

      print(log);

      expect(log, contains('[UPDATE_AMOUNT]'));
      expect(log, contains('ProductId=product123'));
      expect(log, contains('Old=10'));
      expect(log, contains('Added=5'));
      expect(log, contains('New=15'));
    },
  );

  blocTest<UpdateAmountBloc, UpdateAmountState>(
    'should emit failure when repository throws an exception',
    build: () {
      when(
        () => mockProductRepository.updateProductAmount(
          productId: any(named: 'productId'),
          newAmount: any(named: 'newAmount'),
        ),
      ).thenThrow(Exception('Product not found'));

      return UpdateAmountBloc(
        productRepository: mockProductRepository,
        updateAmountLog: mockUpdateAmountLog,
      );
    },

    act: (bloc) {
      bloc
        ..add(const AmountInputChanged('5'))
        ..add(const UpdateAmountSubmitted('product123'));
    },

    expect: () => [
      isA<UpdateAmountState>().having(
        (state) => state.amountInput.value,
        'amount',
        '5',
      ),

      isA<UpdateAmountState>().having(
        (state) => state.submissionStatus,
        'status',
        FormzSubmissionStatus.inProgress,
      ),

      isA<UpdateAmountState>()
          .having(
            (state) => state.submissionStatus,
            'status',
            FormzSubmissionStatus.failure,
          )
          .having(
            (state) => state.errorMessage,
            'errorMessage',
            contains('Product not found'),
          ),
    ],

    verify: (_) {
      print('Repository foi chamado');
      verify(
        () => mockProductRepository.updateProductAmount(
          productId: 'product123',
          newAmount: '5',
        ),
      ).called(1);

      verifyNever(
        () => mockUpdateAmountLog.writeLog(logEntry: any(named: 'logEntry')),
      );
      print('Log não foi chamado');
    },
  );

  blocTest<UpdateAmountBloc, UpdateAmountState>(
    'should not submit when amount input is invalid',
    build: () {
      return UpdateAmountBloc(
        productRepository: mockProductRepository,
        updateAmountLog: mockUpdateAmountLog,
      );
    },

    act: (bloc) {
      bloc.add(const UpdateAmountSubmitted('product123'));
    },

    expect: () => [],

    verify: (_) {
      verifyNever(
        () => mockProductRepository.updateProductAmount(
          productId: any(named: 'productId'),
          newAmount: any(named: 'newAmount'),
        ),
      );

      verifyNever(
        () => mockUpdateAmountLog.writeLog(logEntry: any(named: 'logEntry')),
      );
    },
  );
}
