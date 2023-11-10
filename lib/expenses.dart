import 'package:flutter/material.dart';
// import 'package:third_app/widgets/expenses_list';
import 'package:third_app/models/expense.dart';
import 'package:third_app/widgets/expenses_list/expenses_list.dart';
import 'package:third_app/widgets/expenses_list/new_expenses.dart';

class Expenses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Expensesstate();
  }
}

class Expensesstate extends State<Expenses> {
  final List<Expense> registeredexpenses = [
    Expense(
        title: 'Flutter course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'cinema',
        amount: 15.69,
        date: DateTime.now(),
        category: Category.leisure)
  ];
  void openadexpenseoverlay(){
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context, builder: (ctx)=>Newexpense(onaddexpense: addexpense,));
  }
  void addexpense(Expense expense){
    setState(() {
      registeredexpenses.add(expense);
    });
  }
  void removeexpense(Expense expense){
    final expenseindex=registeredexpenses.indexOf(expense);
    setState(() {
      registeredexpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Expenses deleted'),
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label:'undo' , 
        onPressed: (){
          setState(() {
            registeredexpenses.insert(expenseindex, expense);
          });
        }),)
    );
  }
  
  
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    Widget maincontent=Center(child: Text('No expenses found,start adding some'),);
    if (registeredexpenses.isNotEmpty){
      maincontent=Expenseslist(
        expenses: registeredexpenses, 
        removeexpense: removeexpense);
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            openadexpenseoverlay();
          }, icon: Icon(Icons.add))
        ],
        title: Text('Flutter Expense tracker'),
      ),
      body:width<600? Column(
        children: [
          Text('the chart'),
          Expanded(
              child: maincontent)
        ],
      ):Row(
        children: [
          Text('The chart'),
          Expanded(child: maincontent)
        ],
      )
    );
  }
}