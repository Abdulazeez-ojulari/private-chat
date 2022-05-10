class APIPath{
  static String user({required String uid}) => 'users/$uid';
  static String usersInfo({required String uid}) => 'users';

  static const String users = 'users';
  static const String id = 'id';
}