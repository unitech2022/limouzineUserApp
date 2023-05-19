class GroupLocation {
  final int id;
  final int groupId;
  final int driverId;
  final String userId;
  final String startLocation;
  final String endLocation;
  final int status;
  final String createdAt;

  GroupLocation(
      {required this.id,
      required this.groupId,
      required this.driverId,
      required this.userId,
      required this.startLocation,
      required this.endLocation,
      required this.status,
      required this.createdAt});

  factory GroupLocation.fromJson(Map<String, dynamic> json) => GroupLocation(
        id: json['id'],
        groupId: json['groupId'],
        driverId: json['driverId'],
        userId: json['userId'],
        startLocation: json['startLocation'],
        endLocation: json['endLocation'],
        status: json['status'],
        createdAt: json['createdAt'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['groupId'] = this.groupId;
    data['driverId'] = this.driverId;
    data['userId'] = this.userId;
    data['startLocation'] = this.startLocation;
    data['endLocation'] = this.endLocation;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    return data;
  }
}