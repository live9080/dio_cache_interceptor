import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import './common_store_test.dart' as commonStoreTest;

void main() {
  commonStoreTest.main('Common Mem store tests', MemCacheStore());
}
