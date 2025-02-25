// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_detail_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskDetailViewModelHash() =>
    r'5f5fa65398bb248ea1d7dea92860f7e73fbc78f3';

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

abstract class _$TaskDetailViewModel
    extends BuildlessAutoDisposeAsyncNotifier<Task> {
  late final Task initialTask;

  FutureOr<Task> build(
    Task initialTask,
  );
}

/// See also [TaskDetailViewModel].
@ProviderFor(TaskDetailViewModel)
const taskDetailViewModelProvider = TaskDetailViewModelFamily();

/// See also [TaskDetailViewModel].
class TaskDetailViewModelFamily extends Family<AsyncValue<Task>> {
  /// See also [TaskDetailViewModel].
  const TaskDetailViewModelFamily();

  /// See also [TaskDetailViewModel].
  TaskDetailViewModelProvider call(
    Task initialTask,
  ) {
    return TaskDetailViewModelProvider(
      initialTask,
    );
  }

  @override
  TaskDetailViewModelProvider getProviderOverride(
    covariant TaskDetailViewModelProvider provider,
  ) {
    return call(
      provider.initialTask,
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
  String? get name => r'taskDetailViewModelProvider';
}

/// See also [TaskDetailViewModel].
class TaskDetailViewModelProvider
    extends AutoDisposeAsyncNotifierProviderImpl<TaskDetailViewModel, Task> {
  /// See also [TaskDetailViewModel].
  TaskDetailViewModelProvider(
    Task initialTask,
  ) : this._internal(
          () => TaskDetailViewModel()..initialTask = initialTask,
          from: taskDetailViewModelProvider,
          name: r'taskDetailViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$taskDetailViewModelHash,
          dependencies: TaskDetailViewModelFamily._dependencies,
          allTransitiveDependencies:
              TaskDetailViewModelFamily._allTransitiveDependencies,
          initialTask: initialTask,
        );

  TaskDetailViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.initialTask,
  }) : super.internal();

  final Task initialTask;

  @override
  FutureOr<Task> runNotifierBuild(
    covariant TaskDetailViewModel notifier,
  ) {
    return notifier.build(
      initialTask,
    );
  }

  @override
  Override overrideWith(TaskDetailViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: TaskDetailViewModelProvider._internal(
        () => create()..initialTask = initialTask,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        initialTask: initialTask,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<TaskDetailViewModel, Task>
      createElement() {
    return _TaskDetailViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskDetailViewModelProvider &&
        other.initialTask == initialTask;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, initialTask.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TaskDetailViewModelRef on AutoDisposeAsyncNotifierProviderRef<Task> {
  /// The parameter `initialTask` of this provider.
  Task get initialTask;
}

class _TaskDetailViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TaskDetailViewModel, Task>
    with TaskDetailViewModelRef {
  _TaskDetailViewModelProviderElement(super.provider);

  @override
  Task get initialTask => (origin as TaskDetailViewModelProvider).initialTask;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
