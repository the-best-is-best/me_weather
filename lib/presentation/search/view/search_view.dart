import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:me_weather/presentation/home/widgets/background_image.dart';

import '../../../app/cubit/app_cubit.dart';
import '../../../app/cubit/app_states.dart';
import '../../../app/resources/font_manager.dart';
import '../../../app/resources/styles_manger.dart';
import '../../components/my_input_field.dart';
import '../../components/my_text.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const BackgroundImage(),
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BlocBuilder<AppCubit, AppStates>(
                        builder: (context, state) {
                      final AppCubit appCubit = AppCubit.get(context);
                      return Column(
                        children: [
                          MyTextField(
                            hintText: 'Search',
                            onChanged: (value) {
                              appCubit.searchForCity(value.toLowerCase());
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 15),
                            child: SizedBox(
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () {
                                    appCubit.addMoreCites(
                                        appCubit.searchCity[index].city);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText(
                                        title: appCubit.searchCity[index].city,
                                        style: getMediumStyle(
                                            fontSize: FontSize.s30),
                                      ),
                                      const SizedBox(height: 5),
                                      MyText(
                                          title: appCubit
                                              .searchCity[index].timezone,
                                          style: getRegularStyle()),
                                    ],
                                  ),
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 10),
                                itemCount: appCubit.searchCity.length,
                              ),
                            ),
                          )
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
