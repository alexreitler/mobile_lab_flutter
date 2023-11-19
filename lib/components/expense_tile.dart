import "package:flutter/material.dart";
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  final String type;
  final String category;
  void Function(BuildContext)? deleteTapped;
  void Function(BuildContext)? updateTapped;

  ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.type,
    required this.category,
    required this.deleteTapped,
    required this.updateTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: deleteTapped,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(4),
          ),
          SlidableAction(
            onPressed: updateTapped,
            icon: Icons.settings,
            backgroundColor: Colors.green,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
            '$name - ${dateTime.day} / ${dateTime.month} / ${dateTime.year}'),
        subtitle: Text('$type - $category'),
        trailing: Text('\$$amount'),
      ),
    );
  }
}
