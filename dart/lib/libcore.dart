import 'dart:ffi';
import 'package:ffi/ffi.dart';

final dylib = DynamicLibrary.open('libraries/libcore.so');

typedef hello_func = Void Function();
typedef str_func = Pointer<Utf8> Function();
typedef free_str_func = Void Function(Pointer<Utf8>);
typedef echo_func = Void Function(Pointer<Utf8>);

typedef Hello = void Function();
typedef FreeStr = void Function(Pointer<Utf8>);
typedef Echo = void Function(Pointer<Utf8>);

final Hello hello =
    dylib.lookup<NativeFunction<hello_func>>('hello').asFunction();

final str =
    dylib.lookup<NativeFunction<str_func>>('str').asFunction<str_func>();
final FreeStr free_str =
    dylib.lookup<NativeFunction<free_str_func>>('free_str').asFunction();

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
typedef free_int_array_func = Void Function(Pointer<Nums>);
typedef FreeIntArray = void Function(Pointer<Nums>);

final nums =
    dylib.lookup<NativeFunction<nums_func>>('nums').asFunction<nums_func>();
final FreeIntArray freeIntArray = dylib
    .lookup<NativeFunction<free_int_array_func>>('free_int_array')
    .asFunction();

typedef sum_func = Int32 Function(Pointer<Int32> nums, Int32 len);
typedef Sum = int Function(Pointer<Int32> nums, int len);

final Sum sum = dylib.lookup<NativeFunction<sum_func>>('sum').asFunction();

class Names extends Struct {
  @Int32()
  int len;
  Pointer<Pointer<Utf8>> data;
}

typedef names_func = Pointer<Names> Function();
final names =
    dylib.lookup<NativeFunction<names_func>>('names').asFunction<names_func>();

typedef free_names_func = Void Function(Pointer<Names>);
typedef FreeNames = void Function(Pointer<Names>);
final FreeNames freeNames = dylib
    .lookup<NativeFunction<free_names_func>>('free_string_array')
    .asFunction();

typedef last_error_length_func = Int32 Function();
typedef LastErrorLength = int Function();
final LastErrorLength lastErrorLength = dylib
    .lookup<NativeFunction<last_error_length_func>>('last_error_length')
    .asFunction();

typedef last_error_message_func = Int32 Function(
    Pointer<Utf8> buffer, Int32 length);
typedef LastErrorMessage = int Function(Pointer<Utf8> buffer, int length);
final LastErrorMessage lastErrorMessage = dylib
    .lookup<NativeFunction<last_error_message_func>>('last_error_message')
    .asFunction();

typedef div_func = Int32 Function(Int32 n1, Int32 n2);
typedef Div = int Function(int n1, int n2);
final Div div = dylib.lookup<NativeFunction<div_func>>('div').asFunction();
