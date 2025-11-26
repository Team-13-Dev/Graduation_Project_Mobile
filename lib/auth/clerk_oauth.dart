import 'package:clerk_auth/clerk_auth.dart' as auth;
import 'package:clerk_flutter/clerk_flutter.dart' as clerk;

class ClerkOAuth {
  //late final clerk.ClerkAuthState _auth;

  Future<void> loginWithGoogle(clerk.ClerkAuthState _auth) async {
    await _auth.oauthConnect(
      strategy: auth.Strategy.oauthGoogle,
      redirect: Uri.parse("myapp://callback"),
    );
  }
}
