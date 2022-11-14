import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final String id;
  final String name;
  final int notificationNumber;

  const Customer(
      {required this.id, required this.name, required this.notificationNumber});

  @override
  List<Object> get props => [id, name, notificationNumber];
}

class Contacts extends Equatable {
  final String phone;
  final String email;
  final String link;

  const Contacts(
      {required this.phone, required this.email, required this.link});

  @override
  List<Object> get props => [phone, email, link];
}

class Authentication extends Equatable {
  // notice here we didn't get the status code and message
  final Customer? customer;
  final Contacts? contacts;

  const Authentication({
    this.customer,
    this.contacts,
  });

  @override
  List<Object?> get props => [customer, contacts];
}
