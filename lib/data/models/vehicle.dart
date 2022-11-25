class Vehicle {
  String? vehicleId;
  String? brand;
  String? model;
  String? year;
  String? color;
  String? registration;
  String? userid;

  Vehicle(
      {this.vehicleId,
      this.brand,
      this.model,
      this.year,
      this.color,
      this.registration,
      this.userid});

  Vehicle.fromJson(Map<String, dynamic> json) {
    vehicleId = json['vehicleId'];
    brand = json['brand'];
    model = json['model'];
    year = json['year'];
    color = json['color'];
    registration = json['registration'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand'] = this.brand;
    data['model'] = this.model;
    data['year'] = this.year;
    data['color'] = this.color;
    data['registration'] = this.registration;
    data['userid'] = this.userid;
    return data;
  }
}