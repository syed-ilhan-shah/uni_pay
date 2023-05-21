import '../../utils/uni_enums.dart';

class UniPayAddress {
  ///* Customer address name e.g: Olaya street, Al qadir
  late String addressName;

  ///* Address city
  late String city;

  ///* Customer country
  late UniPayCountry country;

  UniPayAddress({
    required this.addressName,
    required this.city,
    this.country = UniPayCountry.sa,
  });

  UniPayAddress.fromJson(Map<String, dynamic> data) {
    addressName = data['address_name'];
    city = data['city'];
    country = UniPayCountry.values[data['country']];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['address_name'] = addressName;
    data['city'] = city;
    data['country'] = country.index;
    return data;
  }
}
