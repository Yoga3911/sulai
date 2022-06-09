abstract class SocialService {
  String name = "";
  Future<dynamic> signIn();
  Future<void> signOut();
}
