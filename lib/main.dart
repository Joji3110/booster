import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_booster/cubit/measurement_cubit.dart';
import 'package:flutter_booster/graphql/graphql_config.dart';
import 'package:flutter_booster/screens/create_article_screen.dart';
import 'package:flutter_booster/utils/constants/color.dart';

void main() {
  runApp(const Booster());
}

class Booster extends StatelessWidget {
  const Booster({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MeasurementCubit(
            client: GraphQLConfig().client(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Booster',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Ubuntu',
          scaffoldBackgroundColor: TColors.lightColor,
        ),
        home: const CreateArticleScreen(),
      ),
    );
  }
}
