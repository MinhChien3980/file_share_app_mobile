library;

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:file_share_app/src/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';

import '../../../injector.dart';
import '../../core/network/upload_service.dart';
import '../../services/storage_service.dart';

part 'data/repositories/download_repository.dart';

part 'ui/binding/download_binding.dart';
part 'ui/view_model/download_view_model.dart';
part 'ui/pages/download_page.dart';
