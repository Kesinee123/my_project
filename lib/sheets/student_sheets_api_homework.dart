import 'package:gsheets/gsheets.dart';

import '../models/student.dart';
import '../models/student_homeword.dart';

class StudentSheetApiHomeWork {
  static const _credential = r'''
{
  "type": "service_account",
  "project_id": "quiz-project-dd8f7",
  "private_key_id": "c4a24b1eb64e05dd60a15ebc72dcbf4501958d42",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDqxLwGFw15l5YT\nYbaXmep/rwbZrYTEcqzQWHEF/Bq+1u8dOFChGfjrh9L3AN+PUBaWQZH4EEPE+W4B\nXiaw4vki8vTg+yofQfH1ksXZFo2QQFh94FqC5SreqnZ8SxhkQ4j6cQCj/XUyKEC4\nlQxF0oJe01fcxG7lrEg6WrFElbCJuwNNO5RZpBN8mumwUBAzoN0LwUnDn4LXj6sA\nsAMQtha6de/xAFk3h63vgjxFCimWlVjZ3IfJxtuY/fYPChFzzE51LzhyGhuFcIp2\n0M3OynnW3rp2gWw6Mb+pZrGtRjSk/ou9mlraZme69pBpTkg/qHdrn07wA+fWomBQ\nDASnuEftAgMBAAECggEAOQdxZUlUTKU2H58s68bH4Bx0XYx5I/93W2Ugj4OeO52a\nmE6Fx5y3iv+Dj9z2canS0s062DebPs4Ymtx0KaP5QTQjqENbCBzM2gq9ZO7FlLUM\nygcl9YYV0+E0xxy24CRHsg6hSTTYs0Zz8mLCiHOKl95fCZHuHnyrTwGY7kAukkYU\ne9ji+MD9J5ssEt4uxfwrJh71m0bSmUWSFZ9ap30AVQ350T6vkMuTqsyfT8/UBSo1\nh7DfqemeJNwFftzAu/HmhYJOFgNPXFJ8C0ftMZfo8IHPCRuzU1xkVO2kspsWVJ49\njvB1I0irHyvopVla0ReqYjq8227CykxWhFZuBPBgAQKBgQD2QI/6GmD5LiuuG51s\nX9ptKPBGH84wclcLBJlrI3Rc7E42KdavVmEVEdvsu3efw2jFOLA7IzNZowyQ7pLY\nfUBDP2U4BKFxeibP72iTi+RFcPvEUCr+EBdVTmP/6OyalZ5erntLmsQZr8WYM/qh\nlEzdSjJxNqfY/4shxShBcJa4bQKBgQD0D8zPvH82eD0AsZszU3h2BijRTfEAk6ie\nhK8o7SI2CqUK1fLZOoHcr9kXP7664uWmo2K50vAAUBZHG0ipAAY3FkIYvG+Sow6s\n7b5IQk125lthAV9+IZ4FvDuoPk6m7drd3DXkepZ+zVRZcT4JTKLxcucXg6g+SuI6\n7f57gcUdgQKBgCi7FRVxN4j/sgniV2+NiztzAgsXR6uLvgn8gMPP4XddPrKGyRPH\nXdd2VMIbX/X1BGdasQuXDu9MoM94JqHYVcDJw5w4Z9u1MKZEGzAMe31g6sPV3saX\nMsTRaojxpfELvl46zfn7Z2Q4Rp6eOl5vgSc5Fo7TU3/5BLJZQgdQ8B0hAoGBAMYg\nNXHGYbcEMPFpPMaT0kxtf6E6FpUTSWU17UPaDVW1mnmLaVNzLYzLq/41n03zd96o\n8DJNzMtUOGGNApU/EcySYyHVhvWRLQ6xCTF7sYr+Qdwj0zN/ctrRDdTsj8jveid0\n5sMNyTIy2XCqf2PpNLWxQ2xRUrkO7UxNe7Mji7MBAoGAGgMiLoRjkV7wWPjCm8Xk\nDLRDfBqGtgA0XG9DRLUWYJnkjfMOH0KKU9WGl+Vkf6CbDSNW6JhJI1fL8kXf+gXT\nn2oExylktwouOUU6WgvhW1QWtXdH0iRqVg0TtWnjkph4IqGlopXtTp0IK36V2hvF\nKgknH8rr1ATKzmrRmsG7LAs=\n-----END PRIVATE KEY-----\n",
  "client_email": "quiz-score-homework@quiz-project-dd8f7.iam.gserviceaccount.com",
  "client_id": "103888447909654025829",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/quiz-score-homework%40quiz-project-dd8f7.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';

  static final String _spreadsheetId = '1pT_N-78yVKmjEEuHgsF8Uchr9Vhr10EVaqEpbWniy2I';
  static final GSheets _gsheets = GSheets(_credential);
  static Worksheet? _studentSheetHW;

  static Future<void> init() async {
    try {
      final Spreadsheet spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _studentSheetHW = await _getOrCreateWorksheetHW(spreadsheet, title: 'การบ้าน');

      final firstRow = StudentFieldsHomeWork.getFieldsHomeWork();
      await _studentSheetHW!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init Error: $e');
    }
  }

  static Future<Worksheet> _getOrCreateWorksheetHW(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      final Worksheet? existingWorksheet = spreadsheet.worksheetByTitle(title);
      if (existingWorksheet != null) {
        return existingWorksheet;
      } else {
        throw e;
      }
    }
  }

  static Future<void> insert(List<Map<String, dynamic>> rowList) async {
    if (_studentSheetHW == null) return;
    await _studentSheetHW!.values.map.appendRows(rowList);
  }
}