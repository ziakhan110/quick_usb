import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:libusb/libusb.dart';

const int _maxSize = 2048;

extension LibusbExtension on Libusb {
  String describeError(int error) {
    var array = libusb_error_name(error);
    var nativeString = array.asTypedList(_maxSize);
    var strlen = nativeString.indexWhere((char) => char == 0);
    return utf8.decode(array.asTypedList(strlen));
  }
}

extension CharList on Pointer<Char> {
  Uint8List asTypedList(int size) {
    final data = Uint8List(size);
    for (var i = 0; i < size; i++) {
      data[i] = elementAt(i).value;
    }
    return data;
  }
}
