import 'package:flutter/material.dart';
import 'package:frenzy_store/app/constants.dart';
import 'package:frenzy_store/presentation/resources/assets_manger.dart';
import 'package:frenzy_store/presentation/resources/color_manager.dart';
import 'package:frenzy_store/presentation/resources/font_manager.dart';
import 'package:frenzy_store/presentation/resources/strings_manager.dart';
import 'package:frenzy_store/presentation/resources/style_manager.dart';
import 'package:frenzy_store/presentation/resources/values_manager.dart';
import 'package:lottie/lottie.dart';

enum StateRenderType {
  ///popup state (dialog)
  popupLoadingState,
  popupErrorState,

  ///full screen state (screen)
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,

  ///general
  contentState
}

class StateRenderer extends StatelessWidget {
  final StateRenderType stateRenderType;
  final String message;
  final String title;
  final Function retryAction;

  const StateRenderer(
      {Key? key,
      required this.stateRenderType,
      this.message = AppStrings.loading,
      this.title = Constants.empty,
      required this.retryAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRenderType) {
      case StateRenderType.popupLoadingState:
        return _getPopupDialog(context, [
          _getAnimatedImage(JsonAssets.loading),
        ]);
      case StateRenderType.popupErrorState:
        return _getPopupDialog(context, [
          _getAnimatedImage(JsonAssets.error),
          _getTitle(message),
          _getButtonState(AppStrings.ok, context),
        ]);
      case StateRenderType.fullScreenLoadingState:
        return _getStateItems([
          _getAnimatedImage(JsonAssets.loading),
          _getTitle(message),
        ]);
      case StateRenderType.fullScreenErrorState:
        return _getStateItems([
          _getAnimatedImage(JsonAssets.error),
          _getTitle(message),
          _getButtonState(AppStrings.retryAgain, context),
        ]);
      case StateRenderType.fullScreenEmptyState:
        return _getStateItems([
          _getAnimatedImage(JsonAssets.empty),
          _getTitle(message),
        ]);
      case StateRenderType.contentState:
        return Container();
      default:
        return Container();
    }
  }

  Widget _getPopupDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14)),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: const [BoxShadow(color: Colors.black26)],
        ),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getStateItems(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationPath) {
    return SizedBox(
      width: AppSize.s100,
      height: AppSize.s100,
      child: Lottie.asset(animationPath),
    );
  }

  Widget _getTitle(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          message,
          style: getRegularStyle(
              color: ColorManager.black, fontSize: FontSize.s18),
        ),
      ),
    );
  }

  Widget _getButtonState(String title, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  if (stateRenderType == StateRenderType.fullScreenErrorState) {
                    // if full screen error state call function
                    retryAction.call();
                  } else {
                    //popup
                    Navigator.of(context).pop();
                  }
                },
                child: Text(title))),
      ),
    );
  }
}
