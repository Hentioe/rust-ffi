import 'dart:ffi';
import 'package:ffi/ffi.dart';

final dylib = DynamicLibrary.open('lib/libcore.so');

typedef hello_func = Void Function();
typedef str_func = Pointer<Utf8> Function();
typedef echo_func = Void Function(Pointer<Utf8> str);

typedef Hello = void Function();
typedef Echo = void Function(Pointer<Utf8> str);

final Hello call_hello = dylib
   .lookup<NativeFunction<hello_func>>('hello')
   .asFunction();

final call_str = dylib
  .lookup<NativeFunction<str_func>>('str')
  .asFunction<str_func>();

final Echo call_echo = dylib
  .lookup<NativeFunction<echo_func>>('echo')
  .asFunction();
