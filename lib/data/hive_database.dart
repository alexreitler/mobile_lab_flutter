import 'package:expense_tracker/models/expense_item.dart';
import 'package:hive/hive.dart';

class HiveDatabase {
  final _myBox = Hive.box("expense_database");

  void saveData(List<ExpenseItem> allExpense) {
    List<List<dynamic>> allExpenseFormatted = [];

    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.id.toString(),
        expense.name,
        expense.amount,
        expense.dateTime,
        expense.category,
        expense.type,
      ];
      allExpenseFormatted.add(expenseFormatted);
    }
    _myBox.put("ALL_EXPENSES", allExpenseFormatted);
  }

  List<ExpenseItem> readData() {
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      int id = int.parse(savedExpenses[i][0]);
      String name = savedExpenses[i][1];
      String amount = savedExpenses[i][2];
      DateTime dateTime = savedExpenses[i][3];
      String category = savedExpenses[i][4];
      String type = savedExpenses[i][5];

      ExpenseItem expense = ExpenseItem(
          id: id,
          name: name,
          amount: amount,
          dateTime: dateTime,
          type: type,
          category: category);
      allExpenses.add(expense);
    }
    return allExpenses;
  }
}
