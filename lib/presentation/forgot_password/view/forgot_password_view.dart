import 'package:flutter/material.dart';
import 'package:frenzy_store/app/dependency_injection.dart';
import 'package:frenzy_store/presentation/common/state_render/state_render_iml.dart';
import 'package:frenzy_store/presentation/forgot_password/viewmodel/forgot_password_viewmodel.dart';
import 'package:frenzy_store/presentation/resources/routes_manager.dart';
import 'package:frenzy_store/presentation/resources/strings_manager.dart';
import 'package:frenzy_store/presentation/resources/values_manager.dart';

import '../../resources/assets_manger.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final ForgotPasswordViewModel _viewModel =
      getItInstance<ForgotPasswordViewModel>();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  void _bind() {
    _viewModel.start();
    _emailController
        .addListener(() => _viewModel.setEmail(_emailController.text));
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          },
        ),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                  context: context,
                  contentWidget: _getWidgetContent(),
                  retryAction: () {
                    _viewModel.forgotPassword();
                  }) ??
              _getWidgetContent();
        },
      ),
    );
  }

  Widget _getWidgetContent() {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: AppPadding.p28,
              right: AppPadding.p28,
              top: AppPadding.p100),
          child: Column(
            children: [
              /// logo
              const Center(
                child: Image(
                  image: AssetImage(ImageAssets.splashLogo),
                ),
              ),
              const SizedBox(height: AppSize.s28),

              /// email text
              Column(
                children: [
                  StreamBuilder<bool>(
                    stream: _viewModel.outIsEmailValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: InputDecoration(
                            hintText: AppStrings.email,
                            labelText: AppStrings.email,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.invalidEmail),
                      );
                    },
                  ),
                  const SizedBox(height: AppSize.s28),

                  /// forgotPassword button
                  StreamBuilder<bool>(
                      stream: _viewModel.outputAreAllInputsValid,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: double.infinity,
                          height: AppSize.s40,
                          child: ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? () {
                                    _viewModel.forgotPassword();
                                  }
                                : null,
                            child: const Text(AppStrings.forgetPassword),
                          ),
                        );
                      }),
                ],
              ),

              // const SizedBox(height: double.infinity),
            ],
          ),
        ),
      ),
    );
  }
}
