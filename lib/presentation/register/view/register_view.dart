import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frenzy_store/app/constants.dart';
import 'package:frenzy_store/app/dependency_injection.dart';
import 'package:frenzy_store/presentation/common/state_render/state_render_iml.dart';
import 'package:frenzy_store/presentation/register/viewmodel/register_viewmodel.dart';
import 'package:frenzy_store/presentation/resources/assets_manger.dart';
import 'package:frenzy_store/presentation/resources/color_manager.dart';
import 'package:frenzy_store/presentation/resources/routes_manager.dart';
import 'package:frenzy_store/presentation/resources/strings_manager.dart';

import '../../resources/values_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = getItInstance<RegisterViewModel>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  void _bind() {
    _viewModel.start();
    _userNameController.addListener(() {
      _viewModel.setUserName(_userNameController.text);
    });
    _emailController.addListener(() {
      _viewModel.setEmail(_emailController.text);
    });
    _passwordController.addListener(() {
      _viewModel.setPassword(_passwordController.text);
    });
    _mobileController.addListener(() {
      _viewModel.setMobileNumber(_mobileController.text);
    });
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
            onPressed: () {}, icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapShot) {
          return snapShot.data?.getScreenWidget(
                  context: context,
                  contentWidget: _getContentWidget(),
                  retryAction: () {
                    _viewModel.register();
                  }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Padding(
        padding: const EdgeInsets.only(top: AppPadding.p28),
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
                    StreamBuilder<String?>(
                        stream: _viewModel.outputErrorUserName,
                        builder: (context, snapshot) {
                          return TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _userNameController,
                            decoration: InputDecoration(
                              hintText: AppStrings.username,
                              labelText: AppStrings.username,
                              errorText: snapshot.data,
                            ),
                          );
                        }),
                    const SizedBox(height: AppSize.s18),

                    ///mobile
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p28),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: CountryCodePicker(
                                onChanged: (country) {
                                  _viewModel.setCountryMobileCode(
                                      country.code ?? Constants.token);
                                },
                                initialSelection: '+20',
                                favorite: const ['+39', 'FR', '+966'],
                                showCountryOnly: true,
                                hideMainText: true,
                                showOnlyCountryWhenClosed: true,
                              )),
                          Expanded(
                            flex: 4,
                            child: StreamBuilder<String?>(
                                stream: _viewModel.outputErrorMobileNumber,
                                builder: (context, snapshot) {
                                  return TextFormField(
                                    keyboardType: TextInputType.phone,
                                    controller: _mobileController,
                                    decoration: InputDecoration(
                                      hintText: AppStrings.mobileNumber,
                                      labelText: AppStrings.mobileNumber,
                                      errorText: snapshot.data,
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSize.s18),

                    ///email
                    StreamBuilder<String?>(
                        stream: _viewModel.outputErrorEmail,
                        builder: (context, snapshot) {
                          return TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: AppStrings.emailHint,
                              labelText: AppStrings.emailHint,
                              errorText: snapshot.data,
                            ),
                          );
                        }),
                    const SizedBox(height: AppSize.s18),

                    ///password text
                    StreamBuilder<String?>(
                        stream: _viewModel.outputErrorPassword,
                        builder: (context, snapshotValid) {
                          return StreamBuilder<bool>(
                              stream: _viewModel.outputIsShowHidePassword,
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
                                    errorText: snapshotValid.data,
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
                    const SizedBox(height: AppSize.s18),

                    ///profile field

                    const SizedBox(height: AppSize.s28),
                    SizedBox(
                      height: AppSize.s40,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: ColorManager.lightGrey,
                        )),
                        child: GestureDetector(
                          child: _getMediaWidget(),
                          onTap: () {
                            _showPicker(context);
                          },
                        ),
                      ),
                    ),

                    /// register button
                    StreamBuilder<bool>(
                        stream: _viewModel.outputAreAllInputsValid,
                        builder: (context, snapshot) {
                          return SizedBox(
                            width: double.infinity,
                            height: AppSize.s40,
                            child: ElevatedButton(
                              onPressed: (snapshot.data ?? false)
                                  ? () {
                                      _viewModel.register();
                                    }
                                  : null,
                              child: const Text(AppStrings.register),
                            ),
                          );
                        }),

                    /// row forget and register
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppPadding.p18, horizontal: AppPadding.p28),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.loginRoute);
                          },
                          child: Text(
                            AppStrings.alreadyHaveAccount,
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.end,
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget _getMediaWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(child: Text(AppStrings.profilePicture)),
          Flexible(
              child: StreamBuilder<File>(
            stream: _viewModel.outputIsProfile,
            builder: (context, snapshot) {
              return _imagePicket(snapshot.data);
            },
          )),
          Flexible(child: SvgPicture.asset(ImageAssets.photoCameraIc))
        ],
      ),
    );
  }

  Widget _getMediaWidget2() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(child: Text(AppStrings.profilePicture)),
          Flexible(
              child: StreamBuilder<File>(
            stream: _viewModel.outputIsProfile,
            builder: (context, snapshot) {
              return _imagePicket(snapshot.data);
            },
          )),
          Flexible(child: SvgPicture.asset(ImageAssets.photoCameraIc))
        ],
      ),
    );
  }

  Widget _imagePicket(File? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(image);
    } else {
      return const SizedBox();
    }
  }

  void _showPicker(BuildContext context) {}
}
