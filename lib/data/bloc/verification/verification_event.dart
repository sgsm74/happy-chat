abstract class VerificationEvent {
  VerificationEvent();
}

class Verification extends VerificationEvent {
  String code;
  Verification(this.code);
}

class ResendCode extends VerificationEvent {
  ResendCode();
}
