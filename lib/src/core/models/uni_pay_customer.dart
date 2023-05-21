import 'uni_pay_address.dart';

class UniPayCustomerInfo {
  ///* Customer name
  late String fullName;

  ///* Customer phone number
  late String phoneNumber;

  ///* Customer email
  late String email;

  ///* Customer address
  late UniPayAddress address;

  UniPayCustomerInfo({
    required this.fullName,
    required this.phoneNumber,
    this.email = "",
    required this.address,
  });

  UniPayCustomerInfo.fromJson(Map<String, dynamic> data) {
    fullName = data['fullName'];
    phoneNumber = data['phone_number'];
    email = data['email'];
    address = UniPayAddress.fromJson(data['address']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['address'] = address.toJson();
    return data;
  }
}
