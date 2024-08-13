import 'dart:io';

String readJson(String name) {
  return File('test/helpers/dummy_data/$name').readAsStringSync();
}
