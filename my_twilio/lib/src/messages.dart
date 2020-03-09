// messages.dart

import 'dart:convert' show json;

import 'package:http/http.dart' as http;

import './constants.dart';
import './utils.dart';

class Messages {
  final String _accountSid;
  final String _authToken;

  const Messages(this._accountSid, this._authToken);

  Future<Map> create(data) async {
    http.Client client = http.Client();

    String url =
        '${TWILIO_SMS_API_BASE_URL}/Accounts/${_accountSid}/Messages.json';
    print(url);
    print('Basic ' + toAuthCredentials(_accountSid, _authToken));

    try {
      http.Response response = await client.post(url, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Basic ' + toAuthCredentials(_accountSid, _authToken)
      }, body: {
        'From': data['from'],
        'To': data['to'],
        'Body': data['body']
      });

      return (json.decode(response.body));
    } catch (e) {
      return ({'Runtime Error': e});
    } finally {
      client.close();
    }
  }
}
