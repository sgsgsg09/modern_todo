// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
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
  String get localeName => 'ko';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addTaskCategoryLabel": MessageLookupByLibrary.simpleMessage("카테고리"),
        "addTaskColorSelection": MessageLookupByLibrary.simpleMessage("색상 선택"),
        "addTaskDeleteButton": MessageLookupByLibrary.simpleMessage("삭제하기"),
        "addTaskNotesLabel": MessageLookupByLibrary.simpleMessage("메모"),
        "addTaskSaveButton": MessageLookupByLibrary.simpleMessage("저장하기"),
        "addTaskTitleValidation":
            MessageLookupByLibrary.simpleMessage("제목을 입력하세요"),
        "categoryLoadError":
            MessageLookupByLibrary.simpleMessage("카테고리 로드 에러:"),
        "datetime": MessageLookupByLibrary.simpleMessage("날짜 & 시간"),
        "day": MessageLookupByLibrary.simpleMessage("일"),
        "generalError": MessageLookupByLibrary.simpleMessage("오류 발생:"),
        "greeting": MessageLookupByLibrary.simpleMessage("안녕, 세상!"),
        "month": MessageLookupByLibrary.simpleMessage("월"),
        "noTask": MessageLookupByLibrary.simpleMessage("해야할 일이 없습니다."),
        "taskLoadError": MessageLookupByLibrary.simpleMessage("Task 로드 에러:"),
        "time": MessageLookupByLibrary.simpleMessage("시간 설정"),
        "title": MessageLookupByLibrary.simpleMessage("제목")
      };
}
