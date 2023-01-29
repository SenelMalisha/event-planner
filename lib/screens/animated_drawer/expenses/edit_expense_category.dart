import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/provider.dart';
import '../../../utils/constants.dart';
import '../../../widgets/app_bar.dart';
import 'add_category.dart';
import 'expense_category.dart';

class EditExpenseCategory extends StatefulWidget {
  final BuildContext buildContext;
  EditExpenseCategory(this.buildContext);
  @override
  _EditExpenseCategoryState createState() => _EditExpenseCategoryState();
}

class _EditExpenseCategoryState extends State<EditExpenseCategory> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangeExpenseItemEdit>(
        create: (context) => ChangeExpenseItemEdit(),
        child: Builder(
            builder: (contextEdit) => Scaffold(
                backgroundColor: blue1,
                appBar: EditCategoryAppBar(
                  AddCategory(
                      contextEx: widget.buildContext,
                      contextExEdit: contextEdit,
                      type: 'Expense',
                      appBarTitle:
                          'Add Expense Category',
                      description: ''),
                ),
                body: ExpenseCategoryBody(
                  contextExEdit: contextEdit,
                  contextEx: widget.buildContext,
                ))));
  }
}
