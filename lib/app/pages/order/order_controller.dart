import 'package:dart_week_delivery/app/dto/order_product_dto.dart';
import 'package:dart_week_delivery/app/pages/order/order_state.dart';
import 'package:dart_week_delivery/app/repositories/order/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dto/orderdto.dart';

class OrderController extends Cubit<OrderState> {
  final OrderRepository _orderRepository;
  OrderController(this._orderRepository) : super(const OrderState.initial());

  Future<void> load(List<OrderProductDto> products) async {
    try {
      emit(state.copyWith(status: OrderStatus.loading));
      final paymentTypes = await _orderRepository.getAllPaymentTypes();
      emit(state.copyWith(
        ordersProducts: products,
        status: OrderStatus.loaded,
        paymentTypes: paymentTypes,
      ));
    } catch (e) {
      emit(state.copyWith(status: OrderStatus.error, errorMessage: 'Erro ao carregar pagina'));
    }
  }

  void incrementPoduct(int index) {
    final orders = [...state.ordersProducts];
    final order = orders[index];
    orders[index] = order.copyWith(amount: order.amount + 1);
    emit(
      state.copyWith(ordersProducts: orders, status: OrderStatus.updadeOrder),
    );
  }

  void decrementPoduct(int index) {
    final orders = [...state.ordersProducts];
    final order = orders[index];
    final amount = order.amount;
    if (amount == 1) {
      if (state.status != OrderStatus.confirmDeleteProduct) {
        emit(OrderConfirmDeleteProductState(
          orderProductDto: order,
          index: index,
          status: OrderStatus.confirmDeleteProduct,
          ordersProducts: state.ordersProducts,
          paymentTypes: state.paymentTypes,
          errorMessage: state.errorMessage,
        ));
        return;
      } else {
        orders.removeAt(index);
      }
    } else {
      orders[index] = order.copyWith(amount: order.amount - 1);
    }
    if (orders.isEmpty) {
      emit(state.copyWith(status: OrderStatus.emptyBag));
      return;
    }
    emit(
      state.copyWith(ordersProducts: orders, status: OrderStatus.updadeOrder),
    );
  }

  void updatebag(List<OrderProductDto> updatebag) {
    emit(
      state.copyWith(ordersProducts: updatebag),
    );
  }

  void cancelDeleteProcess() {
    emit(
      state.copyWith(status: OrderStatus.loaded),
    );
  }

  void emptyBag() {
    emit(
      state.copyWith(status: OrderStatus.emptyBag),
    );
  }

  void saveOrder({required String address, required String document, required int paymentMethodID}) async {
    emit(state.copyWith(status: OrderStatus.loading));
    await _orderRepository.saveOrder(
      Orderdto(
        products: state.ordersProducts,
        address: address,
        document: document,
        paymentMethodID: paymentMethodID,
      ),
    );
    emit(state.copyWith(status: OrderStatus.success));
  }
}
