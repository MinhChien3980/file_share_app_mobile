library;

import 'package:dio/dio.dart';
import 'package:file_share_app/src/core/ui/ui.dart';
import 'package:file_share_app/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide ContextExtensionss;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../injector.dart';
import 'package:file_share_app/src/router/router.dart';
import 'package:file_share_app/src/shared/shared.dart';

import '../../../gen/assets.gen.dart';
import '../../core/core.dart';
import '../../services/storage_service.dart';

part 'data/models/auth_model.dart';
part 'data/repositories/auth_repository.dart';
part 'ui/binding/auth_binding.dart';
part 'ui/pages/auth_page.dart';
part 'ui/pages/login_page.dart';
part 'ui/pages/register_page.dart';
part 'ui/pages/forget_password.dart';
part 'ui/view_model/auth_view_model.dart';
part 'ui/view_model/login_view_model.dart';
part 'ui/view_model/register_view_model.dart';
part 'ui/view_model/forget_password_view_model.dart';
