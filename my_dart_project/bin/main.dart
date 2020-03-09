// main.dart

import 'dart:io' show Platform, exit;

import 'package:args/args.dart';
import 'package:my_twilio/my_twilio.dart';

ArgResults argResults;

void processCommandLineArguments(arguments) {
  final parser = new ArgParser()
    ..addOption('from',
        abbr: 'f', help: 'A valid Twilio number (in E.164 format).')
    ..addOption('to',
        abbr: 't', help: 'Your (destination) phone number (in E.164 format).')
    ..addOption('body',
        abbr: 'b',
        help: 'The text of the message. (surrounded with quotation marks)');

  try {
    argResults = parser.parse(arguments);

    // if required arguments are not present throw exception
    // usage will be printed
    if (argResults.options.isEmpty ||
        argResults['from'] == null ||
        argResults['to'] == null ||
        argResults['body'] == null) {
      throw ArgParserException;
    }
  } catch (e) {
    print('Sends a text message via Twilio\'s API\n' +
        'usage: sms --from|-f <phone number> --to|-t <phone number> --body|-b <message text>');
    print(parser.usage);
    print(
        'example: sms -f +12345678901 -t +12345678902 -b "Hey, how\'s it going?"');
    exit(1);
  }
}

Future<void> main(List<String> args) async {
  // ensure the required command-line arguments are present
  // then parse and save them in the argResults variable
  processCommandLineArguments(args);

  // See http://twil.io/secure for important security information
  String _accountSid = Platform.environment['TWILIO_ACCOUNT_SID'];
  String _authToken = Platform.environment['TWILIO_AUTH_TOKEN'];

  // Your Account SID and Auth Token from www.twilio.com/console
  // You can skip this block if you store your credentials in environment variables
  _accountSid ??= 'ACXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
  _authToken ??= 'your_auth_token';

  // Create an authenticated client instance for Twilio API
  MyTwilio client = new MyTwilio(_accountSid, _authToken);

  // Send a text message
  // Returns a Map object (key/value pairs)
  Map message = await client.messages.create({
    'body': argResults['body'], // the text of the message
    'from': argResults['from'], // a valid Twilio number
    'to': argResults['to'] // your phone number
  });

  // access individual properties using the square bracket notation
  // for example print(message['sid']);
  print(message);
}
