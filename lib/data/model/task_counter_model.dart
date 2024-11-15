class StatusModel {
  String? sId;
  int? sum;

  StatusModel({this.sId, this.sum});

  StatusModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sum = json['sum'];
  }
}
//