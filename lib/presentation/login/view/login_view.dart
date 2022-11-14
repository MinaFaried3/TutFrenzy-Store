import 'package:flutter/material.dart';
import 'package:frenzy_store/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:frenzy_store/presentation/resources/assets_manger.dart';
import 'package:frenzy_store/presentation/resources/color_manager.dart';
import 'package:frenzy_store/presentation/resources/routes_manager.dart';
import 'package:frenzy_store/presentation/resources/strings_manager.dart';
import 'package:frenzy_store/presentation/resources/values_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = LoginViewModel();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  void _bind() {
    _viewModel.start();
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
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
    return _getWidgetContent();
  }

  Widget _getWidgetContent() {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: AppPadding.p100),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: Column(
                  children: [
                    /// logo
                    const Center(
                      child: Image(
                        image: AssetImage(ImageAssets.splashLogo),
                      ),
                    ),
                    const SizedBox(height: AppSize.s28),

                    /// user name text
                    StreamBuilder<bool>(
                        stream: _viewModel.outIsUserNameValid,
                        builder: (context, snapshot) {
                          return TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _userNameController,
                            decoration: InputDecoration(
                              hintText: AppStrings.username,
                              labelText: AppStrings.username,
                              errorText: (snapshot.data ?? true)
                                  ? null
                                  : AppStrings.usernameError,
                            ),
                          );
                        }),
                    const SizedBox(height: AppSize.s28),

                    ///password text

                    StreamBuilder<bool>(
                        stream: _viewModel.outIsPasswordValid,
                        builder: (context, snapshotValid) {
                          return StreamBuilder<bool>(
                              stream: _viewModel.outputShowHidePassword,
                              builder: (context, snapshotShow) {
                                return TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: (snapshotShow.data ?? true)
                                      ? true
                                      : false,
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    hintText: AppStrings.password,
                                    labelText: AppStrings.password,
                                    errorText: (snapshotValid.data ?? true)
                                        ? null
                                        : AppStrings.passwordError,
                                    suffix: IconButton(
                                      padding:
                                          const EdgeInsets.all(AppPadding.p0),
                                      constraints: const BoxConstraints(),
                                      onPressed: () {
                                        _viewModel.showHidePassword();
                                      },
                                      icon: Icon(
                                        (snapshotShow.data ?? true)
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: ColorManager.primary,
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }),
                    const SizedBox(height: AppSize.s28),

                    /// login button
                    StreamBuilder<bool>(
                        stream: _viewModel.outputAreAllInputsValid,
                        builder: (context, snapshot) {
                          return SizedBox(
                            width: double.infinity,
                            height: AppSize.s40,
                            child: ElevatedButton(
                              onPressed: (snapshot.data ?? false)
                                  ? () {
                                      _viewModel.login();
                                    }
                                  : null,
                              child: const Text(AppStrings.login),
                            ),
                          );
                        }),

                    /// row forget and register
                    Padding(
                      padding: const EdgeInsets.only(top: AppPadding.p8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ///forget
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, Routes.forgotPasswordRoute);
                              },
                              child: Text(
                                AppStrings.forgetPassword,
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.end,
                              )),

                          ///register
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, Routes.registerRoute);
                              },
                              child: Text(
                                AppStrings.registerText,
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.end,
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
