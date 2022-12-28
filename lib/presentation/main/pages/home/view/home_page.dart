import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_store/app/dependency_injection.dart';
import 'package:frenzy_store/domain/models/home_model.dart' as home;
import 'package:frenzy_store/presentation/common/state_render/state_render_iml.dart';
import 'package:frenzy_store/presentation/main/pages/home/viewmodel/home_viewmodel.dart';
import 'package:frenzy_store/presentation/resources/color_manager.dart';
import 'package:frenzy_store/presentation/resources/routes_manager.dart';
import 'package:frenzy_store/presentation/resources/strings_manager.dart';
import 'package:frenzy_store/presentation/resources/values_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = getItInstance<HomeViewModel>();

  void _bind() {
    _viewModel.start();
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
    return Center(
      child: SingleChildScrollView(
        child: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(
                    context: context,
                    contentWidget: _getContentWidget(),
                    retryAction: () {
                      _viewModel.start();
                    }) ??
                _getContentWidget();
          },
        ),
      ),
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder<HomeViewObject>(
      stream: _viewModel.outputHomeData,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.only(
              left: AppPadding.p12, top: AppPadding.p12, bottom: AppPadding.p2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getBannersWidget(snapshot.data?.banners),
              _getSection(AppStrings.services.tr()),
              _getServicesWidget(snapshot.data?.services),
              _getSection(AppStrings.stores.tr()),
              _getStoresWidget(snapshot.data?.stores)
            ],
          ),
        );
      },
    );
  }

  Widget _getSection(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.labelSmall,
    );
  }

  Widget _getBannersWidget(List<home.Banner>? banners) {
    if (banners == null) {
      return const SizedBox();
    }

    return CarouselSlider(
      items: banners
          .map((banner) => SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: AppSize.s1_5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      side: BorderSide(
                          color: ColorManager.primary, width: AppSize.s1)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    child: Image.network(
                      banner.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ))
          .toList(),
      options: CarouselOptions(
          height: AppSize.s160,
          autoPlay: true,
          enableInfiniteScroll: true,
          enlargeCenterPage: true),
    );
  }

  Widget _getServicesWidget(List<home.Service>? services) {
    if (services == null) {
      return const SizedBox();
    }

    return Container(
      height: AppSize.s160,
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: services
            .map((service) => Card(
                  elevation: AppSize.s4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s40),
                      side: BorderSide(
                          color: ColorManager.white, width: AppSize.s1)),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.s40),
                        child: Image.network(
                          service.image,
                          fit: BoxFit.cover,
                          width: AppSize.s120,
                          height: AppSize.s120,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: AppPadding.p8),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              service.title,
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ))
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _getStoresWidget(List<home.Store>? stores) {
    if (stores == null) {
      return Container();
    }

    return Flex(
      direction: Axis.vertical,
      children: [
        GridView.count(
          crossAxisCount: AppSize.s2,
          crossAxisSpacing: AppSize.s8,
          mainAxisSpacing: AppSize.s8,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          children: List.generate(stores.length, (index) {
            return InkWell(
              onTap: () {
                // navigate to store details screen
                Navigator.of(context).pushNamed(Routes.storeDetailsRoute);
              },
              child: Card(
                elevation: AppSize.s4,
                child: Image.network(
                  stores[index].image,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
        )
      ],
    );
  }
}
