import 'package:gsheets/gsheets.dart';

import '../models/student.dart';

class StudentSheetApi {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "quiz-project-dd8f7",
  "private_key_id": "17c13ac3038c69d0e09bf012deabee6b784da7db",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCh7cVF/V6P6PuI\nuM9qggiCcmAcDDiyRTWVtfe7prrr1ll7SezN8PPlOazSQtZAO4OI8S8W8Y/D2zql\n1Z37JZIYd2KtgrAnOigOEeuDf90jlaVFaG9Irw9ai/q3wXdAmmBjwh3f/DSJrCvU\n9o2P2PO96/+5LKUxfSNgL/S4plNRLlDXaoZW+XewK+plIJBa30FoH0fHbPwoEKX9\nN0+TtroTVOBMQ9y+T44ChmVqJKJy5jLNayvjG40ixoyFAftcUMSgZ539mJUITzuw\nB9Xsush9PeP8gcG/xtCIKT5u0Ry2OJGx8gJhnhutNupm3k8tty4pxI5lvE8tMHPJ\n9lttApujAgMBAAECggEAFv/bJ8RDlKQuae56A3JBvCl7rjAsM2HyKPgGHmChpxK0\ndfb7jAq/0ZyeB+VXYhsx5RcArb0UwuhWDazoOf5NoG0Alo178K5pdwojjfNw2PeN\n2GxrdgLrZtx/+W6gvgvPSgwNyz0axz0topt8YuSZRi4Jjech9YQFLMnS9BEnv11f\nIeC2G+3ZB67qb5wR3m6V1FTREUazEm0BFzpl25/vBh+/xlZquEGzh+UJE8x9nkuS\n/epfZB+afHuOkMOFq9bh8zFXmDoJftlYsLJFay/H08HwR1argMn/bhE0f4tLMCJX\niUPHk7ZE5mNV5ZN9UrSYXu2RZ0QuMgySdZio2XLUNQKBgQDgMdLZuHmMkLxKeqoA\nNCWIZN3FoIhkkkpjG1teKsd3XcYWn9egNwzuPEmLBY8JPxDXRxejkj19D1MxVdj4\ndkEKjc0OWfzZ6NURufajiyIcqYy+RG5GhKoDYPzRcc1Ae8/aI/7/2EL+EiyitjeT\nGsuj4FAxiRGz1rW5yBFDCyjITQKBgQC45pxkJe7nIlpLNbUvZmu4dwjC5vi2vbf5\nQPJeSeeVYLwgkBq/R9fo0P0zecJDeL9cqpPLrnhDFt+Whi/jd84yK7RurSXWrs6Q\n0QmBxCS1r2xybXOXMAP5m5k1A/OEkX4UyFAimpOExiuQJVShh4QXG+ZLGbRJ2ATe\nHNDa/s/rrwKBgDxIaV+toNFRIbANJ6UCYI06Qf+f2MziISpg8sJxUk0gY+E1fa9Q\n3iM5BrVg+0MLOCYKsaqD6hC0jDQZ10uH0Jlb46VWQQz+9Dvd+xmikbuPQ47tq5E+\nntBlxdUzenM6V3tabniw1+KlVGc0A+GENPmNmUKYjrACrb6Usz+Jwp+JAoGANwbq\npCNl5gOjO57QPTsN8+f5A4gZnMj5Z4ScnNMByMLxOf+o9iQ7bV5E/HzQA6R7zug0\n8/kIcW7tO67Tsa6F/whiuk1tZWbAsviDC8uD4U5DyAoqzGPNywsznUN/xYRHMYgr\n0SCPpoQTkuKJPUlHVllHQDJ2JUPUrwWEYqhS2KECgYAibKlHhYP9zFuLKBBgy4Cc\n6eZgQKVL3pVKzGEA7mPZsrP38fZrafnNq5hYziDGrZaJAu7ZE2RnCJvPPLxrbLaL\nzvw0v8Es9CDcyuBtOsgDjLCMu/OjIDl2+0RJ8ggn63hnwlHJliccqSKAAFOOplei\n1otIC9ECvWo3NxNmc07EEg==\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@quiz-project-dd8f7.iam.gserviceaccount.com",
  "client_id": "100732036952912381207",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40quiz-project-dd8f7.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';

  static final _spreadsheetId = '1uGvlfCEIKvWK1I1LoToIUFVGVh0xttKSA0BtWf_9mqE';
  static final _gsheets = GSheets(_credentials); 
  static Worksheet? _studentsheet;

  static Future init() async {
    try{
    final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
    _studentsheet =await _getWorkSheet(spreadsheet , title: 'ห้องเรียน');

    final firstRow = StudentFields.getFields();
    _studentsheet!.values.insertRow(1, firstRow);
  } catch (e) {
      print('Init Error : $e');
    } 
  }
 
  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet , {
      required String title,
    }) async {
      try {
        return await spreadsheet.addWorksheet(title);
      } catch (e) {
        return spreadsheet.worksheetByTitle(title)!;
      }
    }

    static Future insert(List<Map<String , dynamic>> rowList) async {
      if (_studentsheet == null) return ;
      _studentsheet!.values.map.appendRows(rowList);
    }
}
