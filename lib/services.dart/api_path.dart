class APIPath {
  static String user({required String uid}) => 'users/$uid';
  static String usersInfo({required String uid}) => 'users';

  static String messages({required String id1, required String id2}) =>
      "messages/$id1/$id2";

  static const String users = 'users';
  static const String id = 'id';
}
