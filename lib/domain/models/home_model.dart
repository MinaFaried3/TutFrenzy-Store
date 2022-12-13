import 'package:equatable/equatable.dart';

class Service extends Equatable {
  final int id;
  final String title;
  final String image;

  const Service(this.id, this.title, this.image);

  @override
  List<Object> get props => [id, title, image];
}

class Banner extends Equatable {
  final int id;
  final String link;
  final String title;
  final String image;

  const Banner(this.id, this.link, this.title, this.image);

  @override
  List<Object> get props => [id, link, title, image];
}

class Store extends Equatable {
  final int id;
  final String title;
  final String image;

  const Store(this.id, this.title, this.image);

  @override
  List<Object> get props => [id, title, image];
}

class HomeData extends Equatable {
  final List<Service>? services;
  final List<Banner>? banners;
  final List<Store>? stores;

  const HomeData(this.services, this.banners, this.stores);

  @override
  List<Object?> get props => [services, banners, stores];
}
