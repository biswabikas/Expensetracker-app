import 'package:flutter/material.dart';
import 'package:third_app/models/expense.dart';

class Expenseitem extends StatelessWidget{
  Expenseitem(this.expense,{super.key});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20
        ),
        child: Column(
          children: [
            Text(expense.title,style: Theme.of(context).textTheme.titleLarge,),
            SizedBox(height: 4,),
            Row(
              children: [
                Text('${expense.amount.toStringAsFixed(2)}'),
                Spacer(),
                Row(
                  children: [
                   Icon(categoryicons[expense.category]),
                    SizedBox(width: 8,),
                    Text(expense.formatteddate)
                  ],
                )
              ],
            )
          ],
        ),
    )
    );
  }
}