import 'dart:convert';

import 'package:aplikasimanajemenkeuangan/helpers/api.dart';
import 'package:aplikasimanajemenkeuangan/helpers/api_url.dart';
import 'package:aplikasimanajemenkeuangan/model/catatan_transaksi.dart';

class CatatanTransaksiBloc {
  static Future<List<CatatanTransaksi>> getCatatanTransaksi() async {
    String apiUrl = ApiUrl.getAll;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listTransaksi = (jsonObj as Map<String, dynamic>)['data'];
    List<CatatanTransaksi> transaksi = [];
    for (int i = 0; i < listTransaksi.length; i++) {
      transaksi.add(CatatanTransaksi.fromJson(listTransaksi[i]));
    }
    return transaksi;
  }

  static Future addCatatanTransaksi({CatatanTransaksi? transaksi}) async {
    String apiUrl = ApiUrl.create;
    var body = {
      "detail": transaksi!.detail,
      "amount": transaksi.amount.toString(),
      "category": transaksi.category
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateCatatanTransaksi(
      {required CatatanTransaksi transaksi}) async {
    String apiUrl = ApiUrl.update(transaksi.id!);
    var body = {
      "detail": transaksi.detail,
      "amount": transaksi.amount.toString(),
      "category": transaksi.category
    };
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteCatatanTransaksi({required int id}) async {
    String apiUrl = ApiUrl.delete(id);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['status'];
  }
}
