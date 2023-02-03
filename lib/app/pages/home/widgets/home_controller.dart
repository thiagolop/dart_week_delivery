import 'package:bloc/bloc.dart';
import 'package:dart_week_delivery/app/dto/order_product_dto.dart';
import 'package:dart_week_delivery/app/pages/home/widgets/home_state.dart';
import 'package:dart_week_delivery/app/repositories/products/products_repository.dart';

class HomeController extends Cubit<HomeState> {
  final ProductsRepository _productsRepository;

  HomeController(
    this._productsRepository,
  ) : super(const HomeState.initial());

  Future<void> loadProducts() async {
    emit(state.copyWith(status: HomeStateStatus.loading));
    try {
      final products = await _productsRepository.findAllProducts();
      emit(state.copyWith(status: HomeStateStatus.loaded, products: products));
    } catch (e) {
      emit(state.copyWith(
        status: HomeStateStatus.error,
        errorMessage: 'Erro ao carregar produtos',
      ));
    }
  }

  void addOrUpdadeBag(OrderProductDto orderProduct) {
    final shoppingBag = [...state.shoppingBag];
    final orderIndex = shoppingBag.indexWhere((element) => element.product == orderProduct.product);
    if (orderIndex > -1) {
      if (orderProduct.amount == 0) {
        shoppingBag.removeAt(orderIndex);
      } else {
        shoppingBag[orderIndex] = orderProduct;
      }
    } else {
      shoppingBag.add(orderProduct);
    }
    emit(state.copyWith(shoppingBag: shoppingBag));
  }

  void updatebag(List<OrderProductDto> updatebag) {
    emit(state.copyWith(shoppingBag: updatebag));
  }
}
