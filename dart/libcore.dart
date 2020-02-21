import 'dart:ffi';
import 'package:ffi/ffi.dart';

final dylib = DynamicLibrary.open('lib/libcore.so');

typedef hello_func = Void Function();
typedef str_func = Pointer<Utf8> Function();
typedef echo_func = Void Function(Pointer<Utf8> s);

typedef Hello = void Function();
typedef Echo = void Function(Pointer<Utf8> s);

final Hello hello =
    dylib.lookup<NativeFunction<hello_func>>('hello').asFunction();

final str =
    dylib.lookup<NativeFunction<str_func>>('str').asFunction<str_func>();

final Echo echo = dylib.lookup<NativeFunction<echo_func>>('echo').asFunction();

class Coordinate extends Struct {
  @Double()
  double latitude;
  @Double()
  double longitude;
}

typedef create_coordinate_func = Pointer<Coordinate> Function(
    Double latitude, Double longitude);
typedef free_coordinate_func = Void Function(Pointer<Coordinate>);

typedef CreateCoordinate = Pointer<Coordinate> Function(
    double latitude, double longitude);
typedef FreeCoordinate = void Function(Pointer<Coordinate>);

final CreateCoordinate createCoordinate = dylib
    .lookup<NativeFunction<create_coordinate_func>>('create_coordinate')
    .asFunction();
final FreeCoordinate freeCoordinate = dylib
    .lookup<NativeFunction<free_coordinate_func>>('free_coordinate')
    .asFunction();

class Nums extends Struct {
  @Int32()
  int len;
  Pointer<Int32> data;
}

typedef nums_func = Pointer<Nums> Function();
typedef free_nums_func = Void Function(Pointer<Nums>);
typedef FreeNums = void Function(Pointer<Nums>);

final nums =
    dylib.lookup<NativeFunction<nums_func>>('nums').asFunction<nums_func>();
final FreeNums freeNums =
    dylib.lookup<NativeFunction<free_nums_func>>('free_nums').asFunction();
