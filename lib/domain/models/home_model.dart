import 'package:equatable/equatable.dart';

class Service extends Equatable {
  final int id;
  final String title;
  final String image;

  const Service({required this.id, required this.title, required this.image});

  @override
  List<Object> get props => [id, title, image];
}

class Banner extends Equatable {
  final int id;
  final String link;
  final String title;
  final String image;

  const Banner(
      {required this.id,
      required this.link,
      required this.title,
      required this.image});

  @override
  List<Object> get props => [id, link, title, image];
}

class Store extends Equatable {
  final int id;
  final String title;
  final String image;

  const Store({required this.id, required this.title, required this.image});

  @override
  List<Object> get props => [id, title, image];
}

class HomeData extends Equatable {
  final List<Service> services;
  final List<Banner> banners;
  final List<Store> stores;

  const HomeData(
      {required this.services, required this.banners, required this.stores});

  @override
  List<Object?> get props => [services, banners, stores];
}

class Home extends Equatable {
  final HomeData data;

  const Home({required this.data});

  @override
  List<Object?> get props => [data];
}
