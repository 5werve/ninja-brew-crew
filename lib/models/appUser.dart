class AppUser {
  final String uid;

  AppUser({required this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserData(
      {required this.uid,
      required this.sugars,
      required this.name,
      required this.strength});
}
