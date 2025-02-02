// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cocoon_service/src/model/ci_yaml/target.dart';
import 'package:cocoon_service/src/model/luci/buildbucket.dart';
import 'package:test/test.dart';

import '../../src/utilities/entity_generators.dart';

void main() {
  group('Target', () {
    group('properties', () {
      test('default properties', () {
        final Target target = generateTarget(1);
        expect(target.getProperties(), <String, Object>{
          'bringup': false,
          'dependencies': <String>[],
        });
      });

      test('properties with xcode overrides platform properties', () {
        final Target target = generateTarget(
          1,
          platform: 'Mac_ios',
          platformProperties: <String, String>{
            // This should be overrided by the target specific property
            'xcode': 'abc',
          },
          properties: <String, String>{
            'xcode': '12abc',
          },
        );
        expect(target.getProperties(), <String, Object>{
          'bringup': false,
          'dependencies': <String>[],
          '\$flutter/devicelab_osx_sdk': <String, Object>{
            'sdk_version': '12abc',
          },
          'xcode': '12abc',
        });
      });

      test('platform properties with xcode', () {
        final Target target = generateTarget(
          1,
          platform: 'Mac_ios',
          platformProperties: <String, String>{
            'xcode': '12abc',
          },
        );
        expect(target.getProperties(), <String, Object>{
          'bringup': false,
          'dependencies': <String>[],
          '\$flutter/devicelab_osx_sdk': <String, Object>{
            'sdk_version': '12abc',
          },
          'xcode': '12abc',
        });
      });
    });

    group('dimensions', () {
      test('no dimensions', () {
        final Target target = generateTarget(1);
        expect(target.getDimensions().length, 0);
      });

      test('dimensions exit', () {
        final Target target = generateTarget(1, properties: <String, String>{'os': 'abc'});
        final List<RequestedDimension> dimensions = target.getDimensions();
        expect(dimensions.length, 1);
        expect(dimensions[0].key, 'os');
        expect(dimensions[0].value, 'abc');
      });
    });
  });
}
