import 'package:dart_week_delivery/app/core/extensions/formatter_extensions.dart';
import 'package:dart_week_delivery/app/core/ui/styles/text_styles.dart';
import 'package:dart_week_delivery/app/core/ui/widgets/delivery_appbar.dart';
import 'package:dart_week_delivery/app/core/ui/widgets/delivery_button.dart';
import 'package:dart_week_delivery/app/models/payment_type_model.dart';
import 'package:dart_week_delivery/app/pages/order/order_controller.dart';
import 'package:dart_week_delivery/app/pages/order/order_state.dart';
import 'package:dart_week_delivery/app/pages/order/widget/order_field.dart';
import 'package:dart_week_delivery/app/pages/order/widget/order_product_tile.dart';
import 'package:dart_week_delivery/app/pages/order/widget/payment_types_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';
import '../../core/ui/base_state/base_state.dart';
import '../../dto/order_product_dto.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends BaseState<OrderPage, OrderController> {
  final formKey = GlobalKey<FormState>();
  final addressEC = TextEditingController();
  final documentEC = TextEditingController();
  int? paymentTypesId;
  final paymentTypeValid = ValueNotifier<bool>(true);

  @override
  void onReady() {
    final products = ModalRoute.of(context)!.settings.arguments as List<OrderProductDto>;
    controller.load(products);
  }

  void _showConfirmProductDeleteDialog(OrderConfirmDeleteProductState state) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Deseja excluir o produto ${state.orderProductDto.product.name} ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.cancelDeleteProcess();
              },
              child: const Text('Cancelar', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                controller.decrementPoduct(state.index);
              },
              child: const Text('Confirmar', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderController, OrderState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          loading: () => showLoader(),
          error: () {
            hideLoader();
            showError(state.errorMessage ?? 'Erro não identificado');
          },
          confirmDeleteProduct: () {
            hideLoader();
            if (state is OrderConfirmDeleteProductState) {
              _showConfirmProductDeleteDialog(state);
            }
          },
          emptyBag: () {
            showInfo('Seu carrinho está vazio');
            Navigator.pop(context, <OrderProductDto>[]);
          },
          success: () {
            hideLoader();
            showInfo('Pedido realizado com sucesso');
            Navigator.of(context).popAndPushNamed('/order/completed', result: <OrderProductDto>[]);
          },
        );
      },
      child: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(controller.state.ordersProducts);
          return false;
        },
        child: Scaffold(
          appBar: DeliveryAppbar(),
          body: Form(
            key: formKey,
            child: CustomScrollView(slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        'Carrinho',
                        style: context.textStyles.textTitle,
                      ),
                      IconButton(
                        onPressed: () {
                          controller.emptyBag();
                        },
                        icon: Image.asset('assets/images/trashRegular.png'),
                      ),
                    ],
                  ),
                ),
              ),
              BlocSelector<OrderController, OrderState, List<OrderProductDto>>(
                  selector: (state) => state.ordersProducts,
                  builder: (context, ordersProducts) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: ordersProducts.length,
                        (context, index) {
                          final orderProduct = ordersProducts[index];
                          return Column(
                            children: [
                              OrderProductTile(
                                index: index,
                                orderProductDto: orderProduct,
                              ),
                              const Divider(color: Colors.grey),
                            ],
                          );
                        },
                      ),
                    );
                  }),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total do Pedido', style: context.textStyles.textExtraBold.copyWith(fontSize: 16)),
                          BlocSelector<OrderController, OrderState, double>(
                            selector: (state) => state.totalOrder,
                            builder: (context, totalOrder) {
                              return Text(totalOrder.currencyPTBR, style: context.textStyles.textExtraBold.copyWith(fontSize: 20));
                            },
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.grey),
                    const SizedBox(height: 10),
                    OrderField(
                      title: 'Endereço de Entrega',
                      controller: addressEC,
                      validator: Validatorless.required('Endereço é obrigatório'),
                      hinText: 'Digite um Endereço',
                    ),
                    const SizedBox(height: 10),
                    OrderField(
                      title: 'CPF',
                      controller: documentEC,
                      validator: Validatorless.required('CPF é obrigatório'),
                      hinText: 'Digite o CPF',
                    ),
                    const SizedBox(height: 15),
                    BlocSelector<OrderController, OrderState, List<PaymentTypeModel>>(
                      selector: (state) => state.paymentTypes,
                      builder: (context, paymentTypes) {
                        return ValueListenableBuilder(
                            valueListenable: paymentTypeValid,
                            builder: (_, paymentTypeValidValue, child) {
                              return PaymentTypesField(
                                paymentTypes: paymentTypes,
                                valueChanged: (value) {
                                  paymentTypesId = value;
                                },
                                valid: paymentTypeValidValue,
                                valueSelected: paymentTypesId.toString(),
                              );
                            });
                      },
                    )
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Divider(color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: DeliveryButton(
                        width: double.infinity,
                        height: 48,
                        label: 'FINALIZAR',
                        onPressed: () {
                          final valid = formKey.currentState?.validate() ?? false;
                          final paymentTypeSelected = paymentTypesId != null;
                          paymentTypeValid.value = paymentTypeSelected;
                          if (valid && paymentTypeSelected) {
                            controller.saveOrder(
                              address: addressEC.text,
                              document: documentEC.text,
                              paymentMethodID: paymentTypesId!,
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
