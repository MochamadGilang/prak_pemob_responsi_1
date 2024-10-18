class ApiUrl {
  static const String baseUrl =
      'http://responsi.webwizards.my.id'; // sesuaikan dengan IP komputer Anda
  static const String baseUrlKeuangan = baseUrl + "/api/keuangan";
  static const String registrasi = baseUrl + '/api/registrasi';
  static const String login = baseUrl + '/api/login';
  static const String getAll = baseUrlKeuangan + '/catatan_transaksi';
  static const String create = baseUrlKeuangan + '/catatan_transaksi';
  static String update(int id) {
    return baseUrlKeuangan + '/catatan_transaksi/' + id.toString() + '/update';
  }

  static String show(int id) {
    return baseUrlKeuangan + '/catatan_transaksi/' + id.toString();
  }

  static String delete(int id) {
    return baseUrlKeuangan + '/catatan_transaksi/' + id.toString() + '/delete';
  }
}
