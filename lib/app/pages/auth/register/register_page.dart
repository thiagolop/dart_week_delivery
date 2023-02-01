import 'package:dart_week_delivery/app/core/ui/styles/text_styles.dart';
import 'package:dart_week_delivery/app/core/ui/widgets/delivery_appbar.dart';
import 'package:flutter/material.dart';

import '../../../core/ui/widgets/delivery_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Cadastro', style: context.textStyles.textTitle),
              Text('Preencha os dados abaixo', style: context.textStyles.textMedium.copyWith(fontSize: 18)),
              const SizedBox(height: 30),
              TextFormField(decoration: const InputDecoration(labelText: 'Nome')),
              const SizedBox(height: 30),
              TextFormField(decoration: const InputDecoration(labelText: 'Email')),
              const SizedBox(height: 30),
              TextFormField(decoration: const InputDecoration(labelText: 'Senha')),
              const SizedBox(height: 30),
              TextFormField(decoration: const InputDecoration(labelText: 'Confirmar Senha')),
              const SizedBox(height: 50),
              Center(
                child: DeliveryButton(
                  label: 'CADASTRAR',
                  width: double.infinity,
                  onPressed: () {},
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
