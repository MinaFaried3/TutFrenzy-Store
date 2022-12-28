import 'package:equatable/equatable.dart';

class StoreDetails extends Equatable {
  final int id;
  final String title;
  final String image;
  final String details;
  final String services;
  final String about;

  const StoreDetails(
      {required this.id,
      required this.title,
      required this.image,
      required this.details,
      required this.services,
      required this.about});

  @override
  List<Object> get props => [id, title, image, details, services, about];
}
