import 'package:flutter/material.dart';

import '../../../app/cubit/app_cubit.dart';
import '../../components/my_input_field.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    Key? key,
    this.focusNode,
    required this.appCubit,
  }) : super(key: key);

  final FocusNode? focusNode;
  final AppCubit appCubit;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    AppCubit appCubit = AppCubit.get(context);
    controller.text = appCubit.searchTextController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
      child: Center(
        child: MyTextField(
          controller: controller,
          hintText: 'Search',
          focusNode: widget.focusNode,
          onChanged: (value) {
            widget.appCubit.searchForCity(value.toLowerCase());
          },
        ),
      ),
    );
  }
}
