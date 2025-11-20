sealed class Async<T> {
  const Async();

  T? call();
}

final class Success<T> extends Async<T> {
  final T data;

  const Success(this.data);

  @override
  T? call() => data;
}

final class Fail<T> extends Async<T> {
  final String message;

  const Fail(this.message);

  @override
  T? call() => null;
}

final class Loading<T> extends Async<T> {
  const Loading();

  @override
  T? call() => null;
}

final class Uninitialized extends Async<Never> {
  const Uninitialized();

  @override
  Never? call() => null;
}
