import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../../providers/provider.dart';
import '../../../utils/constants.dart';
import '../../../widgets/app_bar.dart';
import 'add_category.dart';
import 'income_category.dart';

class EditIncomeCategory extends StatelessWidget {
  final BuildContext? buildContext;
  EditIncomeCategory(this.buildContext);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangeIncomeItemEdit>(
        create: (context) => ChangeIncomeItemEdit(),
    child: Builder(
        builder: (contextEdit) => Scaffold(
        backgroundColor: blue1,
        appBar: EditCategoryAppBar(
          AddCategory(
            contextIn: this.buildContext,
            contextInEdit: contextEdit  ,
              type: 'Income',
              appBarTitle: 'Add Income Category',
              description: ''),
        ),
        body: IncomeCategoryBody( context: this.buildContext, contextEdit: contextEdit,editIncomeCategory: true))));
  }
}
