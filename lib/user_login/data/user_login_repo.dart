abstract class UserLoginRepo {
  Future<String> auth(String usr, String pwd);
}