abstract class AuthenticationState {
  AuthenticationState();
}

class InitialAuthenticationState extends AuthenticationState {
  InitialAuthenticationState();
}

class SuccessAuthenticationState extends AuthenticationState {
  SuccessAuthenticationState();
}

class FailedAuthenticationState extends AuthenticationState {
  FailedAuthenticationState();
}
