class MQQTDetail {
  static String ip = '185.86.181.206';
  static int port = 31789;
  static String username = 'challenge';
  static String password = '8dAtPHvjPNC4erjFRfy';

  static String publishToTopic(String otpToken, String userToken) {
    return 'challenge/user/' + otpToken + '/' + userToken + '/';
  }

  static String subscribeToTopic(String otpToken, String userToken) {
    return 'challenge/user/' + userToken + '/' + otpToken + '/';
  }
}
