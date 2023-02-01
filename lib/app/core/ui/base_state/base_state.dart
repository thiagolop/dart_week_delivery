import 'package:dart_week_delivery/app/core/ui/helpes/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../helpes/messages.dart';

abstract class BaseState<T extends StatefulWidget, C extends BlocBase> extends State<T> with Loader, Messages {
  late final C controller;
  @override
  void initState() {
    super.initState();
    controller = context.read<C>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onReady();
    });
  }

  void onReady() {
    
  }
}
