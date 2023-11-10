import 'package:flutter/material.dart';
import 'package:third_app/models/expense.dart';
import 'package:third_app/widgets/expenses_list/expenses_items.dart';
import 'package:third_app/expenses.dart';

class Expenseslist extends StatelessWidget{
  Expenseslist({super.key,
  required this.expenses,
  required this.removeexpense});
  final List<Expense> expenses;
  final void Function(Expense expense) removeexpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (ctx,index)=>Dismissible(
      key: ValueKey(expenses[index]),
      background: Container(
        color: Theme.of(context).colorScheme.error,
      ),
      onDismissed:(direction) {
        removeexpense(expenses[index]);
      },
      child: Expenseitem(expenses[index])),
    itemCount: expenses.length,);
  }
}