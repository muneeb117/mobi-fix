import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AppBlocProviders {
  static get allBlocProvider => [
        // BlocProvider(create: (BuildContext context) => OnBoardingBloc()),
        // BlocProvider(
        //   create: (BuildContext context) =>
        //       ProfileBloc(databaseHelper: DatabaseHelper())..add(LoadProfile()),
        // ),
        //
        // // BlocProvider(create: (BuildContext context) => WelcomeBloc(),),
        // BlocProvider(create: (BuildContext context) => LoginBloc()),
        // BlocProvider(create: (BuildContext context) => RegisterBloc()),
        // BlocProvider(create: (BuildContext context) => AppBlocs()),
        // BlocProvider(create: (BuildContext context) => HomeBloc()),
        // BlocProvider(
        //     create: (BuildContext context) => DraftsBloc(
        //           draftRepository: GetIt.instance<DraftRepository>(),
        //         )),

//     BlocProvider(create: (BuildContext context) => DiscoverBloc()),
//     BlocProvider(create: (BuildContext context) => ScriptGenerationBloc()),
//
//   ];
// }
      ];
}
