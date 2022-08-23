import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:me_weather/app/cubit/app_cubit.dart';
import 'package:me_weather/app/cubit/app_states.dart';
import 'package:me_weather/app/resources/styles_manger.dart';
import 'package:me_weather/presentation/home/widgets/background_image.dart';
import 'package:mit_x/mit_x.dart';

import '../../../app/di.dart';
import '../../components/loading_indicator.dart';
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
    return BlocProvider(
      lazy: true,
      create: (context) =>
          AppCubit(di(), di(), di(), di(), di())..loadDataCites(),
      child: const PageWidget(),
    );
  }
}

class PageWidget extends StatelessWidget {
  const PageWidget({
    Key? key,
  }) : super(key: key);

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
                    return Scaffold(
                      body: Center(
                          child: MyText(
                        title: (state as AppErrorState).error,
                      )),
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
