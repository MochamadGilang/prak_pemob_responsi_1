class CatatanTransaksi {
  int? id;
  String? detail;
  int? amount;
  String? category;

  CatatanTransaksi({this.id, this.detail, this.amount, this.category});

  factory CatatanTransaksi.fromJson(Map<String, dynamic> obj) {
    return CatatanTransaksi(
      id: obj['id'],
      detail: obj['detail'],
      amount: int.tryParse(
          obj['amount'].toString()), // Konversi dari String ke Integer
      category: obj['category'],
    );
  }
}
