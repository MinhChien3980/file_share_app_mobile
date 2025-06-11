library;

import 'package:dio/dio.dart';
import 'package:file_share_app/src/core/core.dart';
import 'package:file_share_app/src/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

import '../../../injector.dart';
import '../../router/router.dart';
import '../download/download.dart';
import '../post/post.dart';
import '../profile/profile.dart';

part 'data/models/home.dart';
part 'data/models/user_model.dart';
part 'data/repositories/home_repository.dart';
part 'ui/binding/home_binding.dart';
part 'ui/pages/home_page.dart';
part 'ui/view_model/home_view_model.dart';
