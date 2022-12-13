import 'package:equatable/equatable.dart';

class Services extends Equatable {
  final int id;
  final String title;
  final String image;

  const Services(this.id, this.title, this.image);

  @override
  List<Object> get props => [id, title, image];
}

class Banners extends Equatable {
  final int id;
  final String link;
  final String title;
  final String image;

  const Banners(this.id, this.link, this.title, this.image);

  @override
  List<Object> get props => [id, link, title, image];
}

class Stores extends Equatable {
  final int id;
  final String title;
  final String image;

  const Stores(this.id, this.title, this.image);

  @override
  List<Object> get props => [id, title, image];
}

class HomeData extends Equatable {
  final List<Services>? services;
  final List<Banners>? banners;
  final List<Stores>? stores;

  const HomeData(this.services, this.banners, this.stores);

  @override
  List<Object?> get props => [services, banners, stores];
}
