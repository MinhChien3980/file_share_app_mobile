library;

import 'dart:io';

import 'package:dio/dio.dart' hide FormData, MultipartFile;
import 'package:dio/dio.dart' as dio show FormData, MultipartFile;
import 'package:file_share_app/src/configs/config.dart';
import 'package:file_share_app/src/core/network/upload_service.dart';
import 'package:file_share_app/src/shared/shared.dart';
import 'package:file_share_app/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

import '../../../injector.dart';
import '../../core/core.dart';
import '../../core/ui/page/html_page.dart';
import '../../core/ui/widget/image_pick_input.dart';
import '../../core/ui/widget/full_screen_image_viewer.dart';
import '../../router/router.dart';
import '../../services/storage_service.dart';

part 'data/models/profile_model.dart';
part 'data/repositories/profile_repository.dart';
part 'ui/binding/profile_binding.dart';
part 'ui/binding/edit_profile_binding.dart';
part 'ui/binding/change_password_binding.dart';
part 'ui/pages/profile_page.dart';
part 'ui/pages/edit_profile_page.dart';
part 'ui/pages/change_password_page.dart';
part 'ui/view_model/profile_view_model.dart';
part 'ui/view_model/edit_profile_view_model.dart';
part 'ui/view_model/change_password_view_model.dart';
