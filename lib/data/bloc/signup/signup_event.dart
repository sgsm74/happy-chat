abstract class SignUpEvent {
  SignUpEvent();
}

class SignUp extends SignUpEvent {
  int number;
  SignUp(this.number);
}
