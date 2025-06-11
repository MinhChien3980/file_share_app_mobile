library;

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_share_app/src/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../injector.dart';
import '../configs/config.dart';

part 'errors/app_error.dart';
part 'extensions/build_context_x.dart';
part 'extensions/date_time_x.dart';
part 'extensions/num_x.dart';
part 'extensions/string_x.dart';
part 'utils/result.dart';
part 'utils/validator.dart';
part 'network/rest_client.dart';
part 'network/interceptor/cache_interceptor.dart';
part 'network/interceptor/invalid_token_interceptor.dart';
