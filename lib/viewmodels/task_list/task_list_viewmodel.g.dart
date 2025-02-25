// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_list_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskListViewModelHash() => r'a9f3933af2584231b4ee66033a44838e962e4d6d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$TaskListViewModel
    extends BuildlessAutoDisposeAsyncNotifier<List<Task>> {
  late final DateTime selectedDate;

  FutureOr<List<Task>> build(
    DateTime selectedDate,
  );
}

/// See also [TaskListViewModel].
@ProviderFor(TaskListViewModel)
const taskListViewModelProvider = TaskListViewModelFamily();

/// See also [TaskListViewModel].
class TaskListViewModelFamily extends Family<AsyncValue<List<Task>>> {
  /// See also [TaskListViewModel].
  const TaskListViewModelFamily();

  /// See also [TaskListViewModel].
  TaskListViewModelProvider call(
    DateTime selectedDate,
  ) {
    return TaskListViewModelProvider(
      selectedDate,
    );
  }

  @override
  TaskListViewModelProvider getProviderOverride(
    covariant TaskListViewModelProvider provider,
  ) {
    return call(
      provider.selectedDate,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'taskListViewModelProvider';
}

/// See also [TaskListViewModel].
class TaskListViewModelProvider extends AutoDisposeAsyncNotifierProviderImpl<
    TaskListViewModel, List<Task>> {
  /// See also [TaskListViewModel].
  TaskListViewModelProvider(
    DateTime selectedDate,
  ) : this._internal(
          () => TaskListViewModel()..selectedDate = selectedDate,
          from: taskListViewModelProvider,
          name: r'taskListViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$taskListViewModelHash,
          dependencies: TaskListViewModelFamily._dependencies,
          allTransitiveDependencies:
              TaskListViewModelFamily._allTransitiveDependencies,
          selectedDate: selectedDate,
        );

  TaskListViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.selectedDate,
  }) : super.internal();

  final DateTime selectedDate;

  @override
  FutureOr<List<Task>> runNotifierBuild(
    covariant TaskListViewModel notifier,
  ) {
    return notifier.build(
      selectedDate,
    );
  }

  @override
  Override overrideWith(TaskListViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: TaskListViewModelProvider._internal(
        () => create()..selectedDate = selectedDate,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        selectedDate: selectedDate,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<TaskListViewModel, List<Task>>
      createElement() {
    return _TaskListViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskListViewModelProvider &&
        other.selectedDate == selectedDate;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, selectedDate.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TaskListViewModelRef on AutoDisposeAsyncNotifierProviderRef<List<Task>> {
  /// The parameter `selectedDate` of this provider.
  DateTime get selectedDate;
}

class _TaskListViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TaskListViewModel,
        List<Task>> with TaskListViewModelRef {
  _TaskListViewModelProviderElement(super.provider);

  @override
  DateTime get selectedDate =>
      (origin as TaskListViewModelProvider).selectedDate;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
