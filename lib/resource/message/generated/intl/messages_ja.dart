// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ja';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addTaskCategoryLabel": MessageLookupByLibrary.simpleMessage("カテゴリー"),
        "addTaskColorSelection": MessageLookupByLibrary.simpleMessage("色の選択"),
        "addTaskDeleteButton": MessageLookupByLibrary.simpleMessage("削除"),
        "addTaskNotesLabel": MessageLookupByLibrary.simpleMessage("メモ"),
        "addTaskSaveButton": MessageLookupByLibrary.simpleMessage("保存"),
        "addTaskTitleValidation":
            MessageLookupByLibrary.simpleMessage("タイトルを入力してください"),
        "categoryLoadError":
            MessageLookupByLibrary.simpleMessage("カテゴリー読み込みエラー:"),
        "datetime": MessageLookupByLibrary.simpleMessage("日付と時刻"),
        "day": MessageLookupByLibrary.simpleMessage("日"),
        "generalError": MessageLookupByLibrary.simpleMessage("エラー発生:"),
        "greeting": MessageLookupByLibrary.simpleMessage("こんにちは、世界！"),
        "month": MessageLookupByLibrary.simpleMessage("月"),
        "noTask": MessageLookupByLibrary.simpleMessage("実行すべきタスクがありません。"),
        "taskLoadError": MessageLookupByLibrary.simpleMessage("タスク読み込みエラー:"),
        "time": MessageLookupByLibrary.simpleMessage("時間設定"),
        "title": MessageLookupByLibrary.simpleMessage("シンプル・トゥードゥ")
      };
}
