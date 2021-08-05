abstract class VerificationState {
  VerificationState();
}

class InitialVerificationState extends VerificationState {
  InitialVerificationState();
}

class LoadingVerificationState extends VerificationState {
  LoadingVerificationState();
}

class SuccessVerificationState extends VerificationState {
  SuccessVerificationState();
}

class FailedVerificationState extends VerificationState {
  FailedVerificationState();
}

//**************************** */
class InitialResendCode extends VerificationState {
  InitialResendCode();
}

class SuccessResendCode extends VerificationState {
  int count;
  SuccessResendCode(this.count);
}
