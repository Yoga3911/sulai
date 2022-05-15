class Rekap {
  final int val;
  final String saleMonth;
  final String colorVal;

  Rekap({
    required this.val,
    required this.colorVal,
    required this.saleMonth,
  });

  factory Rekap.fromMap(Map<String, dynamic> map) => Rekap(
        val: map["val"],
        colorVal: map["saleMonth"],
        saleMonth: map["colorVal"],
      );
}
