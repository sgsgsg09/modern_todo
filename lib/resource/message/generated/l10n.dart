// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `제목`
  String get title {
    return Intl.message(
      '제목',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `안녕, 세상!`
  String get greeting {
    return Intl.message(
      '안녕, 세상!',
      name: 'greeting',
      desc: '',
      args: [],
    );
  }

  /// `오류 발생:`
  String get generalError {
    return Intl.message(
      '오류 발생:',
      name: 'generalError',
      desc: '',
      args: [],
    );
  }

  /// `Task 로드 에러:`
  String get taskLoadError {
    return Intl.message(
      'Task 로드 에러:',
      name: 'taskLoadError',
      desc: '',
      args: [],
    );
  }

  /// `카테고리 로드 에러:`
  String get categoryLoadError {
    return Intl.message(
      '카테고리 로드 에러:',
      name: 'categoryLoadError',
      desc: '',
      args: [],
    );
  }

  /// `해야할 일이 없습니다.`
  String get noTask {
    return Intl.message(
      '해야할 일이 없습니다.',
      name: 'noTask',
      desc: '',
      args: [],
    );
  }

  /// `날짜 & 시간`
  String get datetime {
    return Intl.message(
      '날짜 & 시간',
      name: 'datetime',
      desc: '',
      args: [],
    );
  }

  /// `월`
  String get month {
    return Intl.message(
      '월',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `일`
  String get day {
    return Intl.message(
      '일',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `시간 설정`
  String get time {
    return Intl.message(
      '시간 설정',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `제목을 입력하세요`
  String get addTaskTitleValidation {
    return Intl.message(
      '제목을 입력하세요',
      name: 'addTaskTitleValidation',
      desc: '',
      args: [],
    );
  }

  /// `카테고리`
  String get addTaskCategoryLabel {
    return Intl.message(
      '카테고리',
      name: 'addTaskCategoryLabel',
      desc: '',
      args: [],
    );
  }

  /// `메모`
  String get addTaskNotesLabel {
    return Intl.message(
      '메모',
      name: 'addTaskNotesLabel',
      desc: '',
      args: [],
    );
  }

  /// `색상 선택`
  String get addTaskColorSelection {
    return Intl.message(
      '색상 선택',
      name: 'addTaskColorSelection',
      desc: '',
      args: [],
    );
  }

  /// `저장하기`
  String get addTaskSaveButton {
    return Intl.message(
      '저장하기',
      name: 'addTaskSaveButton',
      desc: '',
      args: [],
    );
  }

  /// `삭제하기`
  String get addTaskDeleteButton {
    return Intl.message(
      '삭제하기',
      name: 'addTaskDeleteButton',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ja'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
