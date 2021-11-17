class User {
  final String warehouseName;
  final String username;
  final String password;
  final String isReceivingActive;
  final String isPutAwayActive;
  final String isPickingActive;
  final String isLoadingActive;
  final String isReplenishmentActive;
  final String isCycleCountActive;

  User({
    required this.warehouseName,
    required this.username,
    required this.password,
    required this.isReceivingActive,
    required this.isPutAwayActive,
    required this.isPickingActive,
    required this.isLoadingActive,
    required this.isReplenishmentActive,
    required this.isCycleCountActive,
  });
}
