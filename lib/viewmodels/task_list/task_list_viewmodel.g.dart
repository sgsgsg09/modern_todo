// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_list_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskListViewModelHash() => r'83c7c29794fb169af874117e3ac16c74cafab563';

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
  late final TaskListFilter filter;

  FutureOr<List<Task>> build(
    TaskListFilter filter,
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
    TaskListFilter filter,
  ) {
    return TaskListViewModelProvider(
      filter,
    );
  }

  @override
  TaskListViewModelProvider getProviderOverride(
    covariant TaskListViewModelProvider provider,
  ) {
    return call(
      provider.filter,
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
    TaskListFilter filter,
  ) : this._internal(
          () => TaskListViewModel()..filter = filter,
          from: taskListViewModelProvider,
          name: r'taskListViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$taskListViewModelHash,
          dependencies: TaskListViewModelFamily._dependencies,
          allTransitiveDependencies:
              TaskListViewModelFamily._allTransitiveDependencies,
          filter: filter,
        );

  TaskListViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.filter,
  }) : super.internal();

  final TaskListFilter filter;

  @override
  FutureOr<List<Task>> runNotifierBuild(
    covariant TaskListViewModel notifier,
  ) {
    return notifier.build(
      filter,
    );
  }

  @override
  Override overrideWith(TaskListViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: TaskListViewModelProvider._internal(
        () => create()..filter = filter,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        filter: filter,
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
    return other is TaskListViewModelProvider && other.filter == filter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, filter.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TaskListViewModelRef on AutoDisposeAsyncNotifierProviderRef<List<Task>> {
  /// The parameter `filter` of this provider.
  TaskListFilter get filter;
}

class _TaskListViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TaskListViewModel,
        List<Task>> with TaskListViewModelRef {
  _TaskListViewModelProviderElement(super.provider);

  @override
  TaskListFilter get filter => (origin as TaskListViewModelProvider).filter;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
