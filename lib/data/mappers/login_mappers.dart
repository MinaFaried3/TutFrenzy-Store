import 'package:frenzy_store/app/constants.dart';
import 'package:frenzy_store/app/extension.dart';
import 'package:frenzy_store/data/response/responses.dart';

import '../../domain/models/login_model.dart';

extension CustomerResponseMapper on CustomerResponse? {
  //we use ?? operator if the main object(CustomerResponse) was null
  Customer toDomain() {
    return Customer(
      id: this?.id.orEmpty() ?? Constants.empty,
      name: this?.name.orEmpty() ?? Constants.empty,
      notificationNumber: this?.notificationNumber.orZero() ?? Constants.zero,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
      phone: this?.phone.orEmpty() ?? Constants.empty,
      email: this?.email.orEmpty() ?? Constants.empty,
      link: this?.link.orEmpty() ?? Constants.empty,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
        contacts: this?.contacts.toDomain(),
        customer: this?.customer.toDomain());
  }
}
