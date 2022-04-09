// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';
import 'package:shelf/shelf.dart';

import '../request_handling/authentication.dart';
import 'request_handler.dart';
import '../service/config.dart';

/// A [RequestHandler] that handles API requests.
///
///  * All requests must be authenticated per [CronAuthProvider].
@immutable
abstract class AuthenticatedRequestHandler extends RequestHandler {
  /// Creates a new [ApiRequestHandler].
  const AuthenticatedRequestHandler({
    required Config config,
    required this.cronAuthProvider,
  }) : super(config: config);

  /// Service responsible for authenticating this [Request].
  final CronAuthProvider cronAuthProvider;
}
