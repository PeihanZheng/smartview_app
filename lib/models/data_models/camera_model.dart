class CameraModel {
  int? camId;
  String? name;
  double? lat;
  double? long;

  CameraModel({this.camId, this.name, this.lat, this.long});

  CameraModel.fromJson(Map<String, dynamic> json) {
    camId = json['cam_id'];
    name = json['name'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cam_id'] = camId;
    data['name'] = name;
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}
