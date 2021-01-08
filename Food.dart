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
}