import 'package:flutter/material.dart';
import 'package:frenzy_store/app/dependency_injection.dart';
import 'package:frenzy_store/domain/usecase/forgot_password_use_case.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController _controller = TextEditingController();
  final ForgotPasswordUseCase forgotPasswordUseCase =
      getItInstance<ForgotPasswordUseCase>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
            ),
            TextButton(
                onPressed: () {
                  forgotPasswordUseCase
                      .execute(ForgotPasswordInput(_controller.text));
                },
                child: Text("send"))
          ],
        ),
      ),
    );
  }
}
