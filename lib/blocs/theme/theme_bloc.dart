import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_assistant/blocs/theme/theme_event.dart';
import 'package:sales_assistant/blocs/theme/theme_state.dart';
import 'package:sales_assistant/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<ToggleThemeEvent>((event, emit) async {
      final themeData =
          event.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isDarkMode', event.isDarkMode);

      emit(ThemeLoaded(themeData, event.isDarkMode));
    });
  }

  Future<void> loadThemeFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    add(ToggleThemeEvent(isDarkMode));
  }
}
