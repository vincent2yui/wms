class User {
  final String username;
  final String password;
  final String? warehouseName;
  final String? isReceivingActive;
  final String? isPutAwayActive;
  final String? isPickingActive;
  final String? isLoadingActive;
  final String? isReplenishmentActive;
  final String? isCycleCountActive;

  User({
    required this.username,
    required this.password,
    this.warehouseName,
    this.isReceivingActive,
    this.isPutAwayActive,
    this.isPickingActive,
    this.isLoadingActive,
    this.isReplenishmentActive,
    this.isCycleCountActive,
  });
}
