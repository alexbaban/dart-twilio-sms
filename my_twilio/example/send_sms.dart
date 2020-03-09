// send_sms.dart

import 'dart:io' show Platform;

import 'package:my_twilio/my_twilio.dart';

Future<void> main() async {
  // See http://twil.io/secure for important security information
  String _accountSid = Platform.environment['TWILIO_ACCOUNT_SID'];
  String _authToken = Platform.environment['TWILIO_AUTH_TOKEN'];

  // Your Account SID and Auth Token from www.twilio.com/console
  // You can skip this block if you store your credentials in environment variables
  _accountSid ??= 'ACXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
  _authToken ??= 'your_auth_token';

  // Create an authenticated Twilio Client instance
  MyTwilio client = new MyTwilio(_accountSid, _authToken);

  // Send a text message
  // Returns a Map object (key/value pairs)
  Map message = await client.messages.create({
    'body': 'Hello from Dart!',
    'from': '+12345678901', // a valid Twilio number
    'to': '+12345678902' // your phone number
  });

  // access individual properties using the square bracket notation
  // for example print(message['sid']);
  print(message);
}
