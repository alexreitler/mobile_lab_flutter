class ExpenseItem {
  final int id;
  String name;
  String amount;
  DateTime dateTime;
  String type;
  String category;

  ExpenseItem(
      {required this.id,
      required this.name,
      required this.amount,
      required this.dateTime,
      required this.type,
      required this.category});
}
