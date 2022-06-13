import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import '../helper.dart';

class Reservation {
  final String? userId;
  final String stationId;
  final String reservationDateTime;
  final String charger;

  Reservation(
      this.userId, this.stationId, this.reservationDateTime, this.charger);

  static Future<bool> createReservation(Reservation reservation) async {
    bool trustSelfSigned = true;
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = IOClient(httpClient);

    var response = await ioClient.post(
      Uri.parse('$url/reservation'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: json.encode(
        {
          'userId': reservation.userId,
          'stationId': reservation.stationId,
          'date': reservation.reservationDateTime
        },
      ),
    );
    return response.statusCode == 200;
  }

  static Future<List<Reservation>> getAll() async {
    List<Reservation> allreservations = [];
    bool trustSelfSigned = true;
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = IOClient(httpClient);

    var response = await ioClient.get(
      Uri.parse('$url/reservation/getForUser?userId=${user?.id}'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    var reservations = jsonDecode(response.body);
    for (var reservation in reservations) {
      allreservations.add(
        Reservation(user?.id, reservation['id'], reservation['date'],
            '${reservation['fullCharger']['fullStation']['name']}-${reservation['fullCharger']['serialNumber']}'),
      );
    }
    return allreservations;
  }
}
