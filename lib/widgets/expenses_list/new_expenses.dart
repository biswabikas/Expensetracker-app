import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:third_app/models/expense.dart';

class Newexpense extends StatefulWidget {
  Newexpense({super.key,required this.onaddexpense,});
  final void Function(Expense expense) onaddexpense;

  @override
  State<StatefulWidget> createState() {
    return Newexpensestate();
  }
}

class Newexpensestate extends State<Newexpense> {
  final titlecontroller = TextEditingController();
  final amountcontroller = TextEditingController();
  DateTime? selecteddate;
  Category selectedcategory=Category.leisure;
  void presentdatepicker() async {
    final now = DateTime.now();
    final datepicked = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(now.year - 1, now.month, now.day),
        lastDate: now);
    setState(() {
      selecteddate = datepicked;
    });
  }
  void submitexpensedata(){
    final enteredamount=double.tryParse(amountcontroller.text);
    final amountisinvalid=enteredamount==null || enteredamount<=0;
    if (titlecontroller.text.trim().isEmpty || amountisinvalid|| selecteddate==null){
      showDialog(context: context, builder: (ctx)=>AlertDialog(
        title: Text('invalid input'),
        content: Text('please make sure a valid title'),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(ctx);
          }, child: Text('okay'))
        ],
      ));
    }
    widget.onaddexpense(
      Expense(title: titlecontroller.text, amount: enteredamount!, date: selecteddate!, category: selectedcategory)
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titlecontroller.dispose();
    amountcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardspace=MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (context,Constraints){
      return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16,48,16,16,),
        child: Column(
          children: [
            TextField(
              controller: titlecontroller,
              maxLength: 50,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(label: Text('Title')),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: amountcontroller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text('Amount'),
                      prefixText: '\$ ',
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(selecteddate == null
                            ? 'No date selected'
                            : formatter.format(selecteddate!)),
                        IconButton(
                            onPressed: () {
                              presentdatepicker();
                            },
                            icon: Icon(Icons.calendar_month))
                      ]),
                )
              ],
            ),
            SizedBox(height: 16,),
            Row(
              children: [
                DropdownButton(
                  value: selectedcategory,
                    items: Category.values
                        .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category.name.toUpperCase()),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value==null){
                        return;
                      }
                      setState(() {
                        selectedcategory=value;
                      });
                    }
                    ),
                    Spacer(),
                ElevatedButton(
                  onPressed: () {
                    submitexpensedata();
                  },
                  child: Text('save expense'),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('cancel'))
              ],
            )
          ],
        ),
      ),
    );
  }
    );
}

}