part of 'localizatio_cubit.dart';

@immutable
abstract class LocalizatioState {
  Locale locale;
  LocalizatioState(this.locale);
}

final class LocalizatioInitial extends LocalizatioState {
  LocalizatioInitial():super (Locale('en'));
}

final class LocalChange extends LocalizatioState {
  final Locale locale;
  LocalChange(this.locale) : super(locale);
}
