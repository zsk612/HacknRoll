import 'package:intl/intl.dart';

import 'status.dart';

class Food {
  String foodName;
  double foodNumber;
  String foodPosition;
  DateTime foodExpireDate;
  final DateTime currentDate = DateTime.now();

  Food(String foodName, double foodNumber, String foodPosition, DateTime foodExpireDate) {
    this.foodName = foodName;
    this.foodNumber = foodNumber;
    this.foodPosition = foodPosition;
    this.foodExpireDate = foodExpireDate;
  }

  String get name {
    return foodName;
  }

  double get number {
    return foodNumber;
  }

  String get position {
    return foodPosition;
  }

  DateTime get expireDate {
    return foodExpireDate;
  }

  void set name(String foodName) {
    name = foodName;
  }

  void set number(double foodNumber) {
    number = foodNumber;
  }

  void set position(String foodPosition) {
    position = foodPosition;
  }

  void set expireDate(DateTime foodExpireDate) {
    expireDate = foodExpireDate;
  }

  bool isNearExpire(DateTime foodExpireDate) {
    return true;
  }

  bool isExpired(DateTime foodExpireDate) {
    return true;
  }

  Status getStatus() {
    final diffDt = foodExpireDate.difference(currentDate);
    if (diffDt.inDays >= 3) {
      return Status.fresh;
    } else if (diffDt.inDays < 0) {
      return Status.expired;
    } else {
      return Status.expiring;
    }
  }

  Food.fromMap(Map map){
    this.foodName = map['name'];
    this.foodNumber = map['number'];
    this.foodPosition = map['position'];
    this.foodExpireDate = DateTime.parse(map['expireDate']);
  }

  Map toMap(){
    return{
      'name': this.foodName,
      'number': this.foodNumber,
      'position': this.foodPosition,
      'expireDate': formatDate(this.foodExpireDate),
    };
  }

  String formatDate(DateTime unformattedDate){
    String formattedDate = DateFormat('yyyy-MM-dd').format(unformattedDate);
    return formattedDate;
  }


}