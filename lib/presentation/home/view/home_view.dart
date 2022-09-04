import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:me_weather/app/cubit/app_cubit.dart';
import 'package:me_weather/app/cubit/app_states.dart';
import 'package:me_weather/presentation/home/widgets/background_image.dart';
import 'package:mit_x/mit_x.dart';
import '../../components/loading_indicator.dart';
import '../../components/my_input_field.dart';
import '../../components/my_text.dart';
import '../widgets/build_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        BlocBuilder<AppCubit, AppStates>(
          builder: (context, state) {
            return BuildCondition(
              condition: state is! AppLoadAppDataState,
              fallback: (context) => const LoadingIndicator(),
              builder: (context) {
                return BuildCondition(
                  condition: state is! AppErrorState,
                  fallback: (context) {
                    AppCubit appCubit = AppCubit.get(context);
                    return Scaffold(
                      body: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15),
                          child: SizedBox(
                            width: context.width,
                            child: Column(
                              children: [
                                MyTextField(
                                  hintText: 'Search',
                                  onChanged: (value) {
                                    appCubit.searchForCity(value.toLowerCase());
                                  },
                                ),
                                SizedBox(height: context.height * .35),
                                MyText(
                                  title: (state as AppErrorState).error,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  builder: (context) {
                    return const BuildPage();
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
