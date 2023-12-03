import 'package:expense_tracker/components/expense_tile.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newExpenseNameController = TextEditingController();
  final newExpenseDollarController = TextEditingController();
  final newExpenseCentsController = TextEditingController();
  final newExpenseTypeController = TextEditingController();
  final newExpenseCategoryController = TextEditingController();

  int id = 0;
  int idToUpdate = 0;

  @override
  void initState() {
    super.initState();

    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add new Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newExpenseNameController,
              decoration: const InputDecoration(
                hintText: "Expense name",
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: newExpenseDollarController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Dollars",
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: newExpenseCentsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Cents",
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              controller: newExpenseTypeController,
              decoration: const InputDecoration(
                hintText: "Type",
              ),
            ),
            TextField(
              controller: newExpenseCategoryController,
              decoration: const InputDecoration(
                hintText: "Category",
              ),
            ),
          ],
        ),
        actions: [
          //Save button
          MaterialButton(
            onPressed: save,
            child: const Text('Save'),
          ),

          MaterialButton(
            onPressed: cancel,
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void updateExpense(ExpenseItem expense) {
    idToUpdate = expense.id;
    newExpenseNameController.text = expense.name;
    List<String> amountParts = expense.amount.split('.');
    newExpenseDollarController.text = amountParts[0];
    newExpenseCentsController.text = amountParts[1];
    newExpenseTypeController.text = expense.type;
    newExpenseCategoryController.text = expense.category;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add new Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newExpenseNameController,
              decoration: const InputDecoration(
                hintText: "Expense name",
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: newExpenseDollarController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Dollars",
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: newExpenseCentsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Cents",
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              controller: newExpenseTypeController,
              decoration: const InputDecoration(
                hintText: "Type",
              ),
            ),
            TextField(
              controller: newExpenseCategoryController,
              decoration: const InputDecoration(
                hintText: "Category",
              ),
            ),
          ],
        ),
        actions: [
          //Save button
          MaterialButton(
            onPressed: update,
            child: const Text('Update'),
          ),

          MaterialButton(
            onPressed: cancel,
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  void save() {
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseDollarController.text.isNotEmpty &&
        newExpenseCentsController.text.isNotEmpty &&
        newExpenseTypeController.text.isNotEmpty &&
        newExpenseCategoryController.text.isNotEmpty) {
      String amount =
          '${newExpenseDollarController.text}.${newExpenseCentsController.text}';

      ExpenseItem newExpense = ExpenseItem(
        id: id,
        name: newExpenseNameController.text,
        amount: amount,
        dateTime: DateTime.now(),
        type: newExpenseTypeController.text,
        category: newExpenseCategoryController.text,
      );
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);

      id++;

      Navigator.pop(context);
      clear();
    }
  }

  void update() {
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseDollarController.text.isNotEmpty &&
        newExpenseCentsController.text.isNotEmpty &&
        newExpenseTypeController.text.isNotEmpty &&
        newExpenseCategoryController.text.isNotEmpty) {
      String amount =
          '${newExpenseDollarController.text}.${newExpenseCentsController.text}';

      ExpenseItem newExpense = ExpenseItem(
        id: idToUpdate,
        name: newExpenseNameController.text,
        amount: amount,
        dateTime: DateTime.now(),
        type: newExpenseTypeController.text,
        category: newExpenseCategoryController.text,
      );
      Provider.of<ExpenseData>(context, listen: false)
          .updateExpense(newExpense);

      Navigator.pop(context);
      clear();
    }
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newExpenseNameController.clear();
    newExpenseDollarController.clear();
    newExpenseCentsController.clear();
    newExpenseTypeController.clear();
    newExpenseCategoryController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: value.getAllExpenseList().length,
          itemBuilder: (context, index) => ExpenseTile(
            name: value.getAllExpenseList()[index].name,
            amount: value.getAllExpenseList()[index].amount,
            dateTime: value.getAllExpenseList()[index].dateTime,
            type: value.getAllExpenseList()[index].type,
            category: value.getAllExpenseList()[index].category,
            deleteTapped: (p0) =>
                deleteExpense(value.getAllExpenseList()[index]),
            updateTapped: (p0) =>
                updateExpense(value.getAllExpenseList()[index]),
          ),
        ),
      ),
    );
  }
}
