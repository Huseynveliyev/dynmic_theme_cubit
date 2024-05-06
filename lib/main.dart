
import 'package:dynmic_theme_cubit/cubit/theme_cubit_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(BlocProvider(
    create: (context) => ThemeCubit()..setInitalTheme(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Dynamic Theme Flutter',
          theme: state.themeData,
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text(
          isDarkMode? 
          'Light Theme'  : 'DarkTheme'
          ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme(!isDarkMode);
              },
              child: Text(isDarkMode ? 'LightTheme' : 'DarkTheme'),
            ),
             const CustomSwitch()
          ],
        ),
      ),
    );
  }
}


class CustomSwitch extends StatefulWidget {
   const CustomSwitch({
    super.key,
    
  });
  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

 bool isSelected = false;
class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch( 
      value: isSelected,
      onChanged: (value) {
       
        setState(
          () {
            context.read<ThemeCubit>().toggleTheme(isSelected);
            isSelected = value;

          },
        );
      },
    );
  }
}
