import 'package:dart_week_delivery/app/core/ui/base_state/base_state.dart';
import 'package:dart_week_delivery/app/core/ui/helpes/loader.dart';
import 'package:dart_week_delivery/app/core/ui/widgets/delivery_appbar.dart';
import 'package:dart_week_delivery/app/pages/home/widgets/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/ui/helpes/messages.dart';
import 'delivery_product_tile.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  @override
  void onReady() {
    controller.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),
      body: BlocConsumer<HomeController, HomeState>(
        listener: (context, state) {
          state.status.matchAny(
            any: () => hideLoader(),
            loading: () => showLoader(),
            error: () {
              hideLoader();
              showError(state.errorMessage ?? 'Erro desconhecido');
            },
          );
        },
        buildWhen: (previous, current) => current.status.matchAny(
          any: () => false,
          initial: () => true,
          loaded: () => true,
        ),
        builder: (context, state) {
          return Column(children: [
            Expanded(
              child: ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return DeliveryProductTile(
                    product: product,
                  );
                },
              ),
            ),
          ]);
        },
      ),
    );
  }
}
