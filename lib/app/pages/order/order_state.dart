import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import 'package:dart_week_delivery/app/dto/order_product_dto.dart';
import 'package:dart_week_delivery/app/models/payment_type_model.dart';
part 'order_state.g.dart';

@match
enum OrderStatus {
  initial,
  loading,
  loaded,
  error,
  updadeOrder,
  confirmDeleteProduct,
  emptyBag,
  success,
}

class OrderState extends Equatable {
  final OrderStatus status;
  final List<OrderProductDto> ordersProducts;
  final List<PaymentTypeModel> paymentTypes;
  final String? errorMessage;

  const OrderState({
    required this.status,
    required this.ordersProducts,
    required this.paymentTypes,
    this.errorMessage,
  });

  const OrderState.initial()
      : status = OrderStatus.initial,
        ordersProducts = const [],
        paymentTypes = const [],
        errorMessage = null;

  double get totalOrder => ordersProducts.fold(0.0, (previousValue, element) => previousValue + element.totalPrice);

  @override
  List<Object?> get props => [status, ordersProducts, paymentTypes, errorMessage];

  OrderState copyWith({
    OrderStatus? status,
    List<OrderProductDto>? ordersProducts,
    List<PaymentTypeModel>? paymentTypes,
    String? errorMessage,
  }) {
    return OrderState(
      status: status ?? this.status,
      ordersProducts: ordersProducts ?? this.ordersProducts,
      paymentTypes: paymentTypes ?? this.paymentTypes,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class OrderConfirmDeleteProductState extends OrderState {
  final OrderProductDto orderProductDto;
  final int index;

  const OrderConfirmDeleteProductState({
    required this.orderProductDto,
    required this.index,
    required super.status,
    required super.ordersProducts,
    required super.paymentTypes,
    super.errorMessage,
  });
}
