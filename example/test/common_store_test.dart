import 'dart:convert';

import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:test/test.dart';

void main(String description, CacheStore store) {
  group(description, () {
    Future<void> _addFooResponse() {
      final resp = CacheResponse(
        key: 'foo',
        url: 'https://foo.com',
        eTag: 'an etag',
        lastModified: null,
        maxStale: null,
        content: utf8.encode('foo'),
        headers: null,
        priority: CachePriority.normal,
      );

      return store.set(resp);
    }

    test('Empty by default', () async {
      expect(await store.exists('foo'), isFalse);
    });

    test('Add item', () async {
      await _addFooResponse();

      expect(await store.exists('foo'), isTrue);
    });

    test('Get item', () async {
      await _addFooResponse();

      final resp = await store.get('foo');
      expect(resp, isNotNull);
      expect(resp.key, 'foo');
      expect(resp.url, 'https://foo.com');
      expect(resp.eTag, 'an etag');
      expect(resp.lastModified, isNull);
      expect(resp.maxStale, isNull);
      expect(resp.content, utf8.encode('foo'));
      expect(resp.headers, isNull);
      expect(resp.priority, CachePriority.normal);
    });

    test('Delete item', () async {
      await _addFooResponse();
      expect(await store.exists('foo'), isTrue);

      await store.delete('foo');
      expect(await store.exists('foo'), isFalse);
    });
  });
}
