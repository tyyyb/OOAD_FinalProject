import 'package:ooad_final_project_fall21/functions/Observers/observer.dart';

class Customer implements Observer {
  String _id;
  String _name;
  String _phoneNumber;
  String _email;
  String _role;

  static Customer _customer = Customer._(
      "guest", "guest", "123-456-7890", "guest@ooad.com", "Customer");
  Customer._(this._id, this._name, this._phoneNumber, this._email, this._role);

  Map<String, dynamic> toMap() {
    return {
      'uid': _id,
      'userEmail': _email,
      'userName': _name,
      'userPhone': _phoneNumber,
      "userRole": _role
    };
  }

  String get id => _id;

  set setId(String value) {
    _id = value;
  }

  static getCustomer() {
    return _customer;
  }

  void reset() {
    _id = 'guest';
    _name = 'guest';
    _phoneNumber = '123-456-7890';
    _email = 'guest@ooad.com';
    _role = 'Customer';
  }

  @override
  void update(Map<String, String> news) {}

  String get name => _name;

  set setName(String value) {
    _name = value;
  }

  String get phoneNumber => _phoneNumber;

  set setPhoneNumber(String value) {
    _phoneNumber = value;
  }

  String get email => _email;

  set setEmail(String value) {
    _email = value;
  }

  String get role => _role;

  set setRole(String value) {
    _role = value;
  }
}
