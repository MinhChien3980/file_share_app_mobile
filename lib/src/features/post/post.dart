library;

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_share_app/src/features/home/home.dart';
import 'package:file_share_app/src/features/post/data/models/meta_data_file.dart';
import 'package:file_share_app/src/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../injector.dart';
import '../../core/core.dart';
import '../../core/ui/widget/full_screen_image_viewer.dart';

import '../../core/network/upload_service.dart';
import '../../router/router.dart';
import '../../services/storage_service.dart';
import '../../theme/theme.dart';
import '../download/download.dart';

part 'data/models/post_model.dart';
part 'data/repositories/post_repository.dart';
part 'ui/binding/explorer_binding.dart';
part 'ui/binding/post_detail_binding.dart';
part 'ui/binding/create_post_binding.dart';
part 'ui/binding/my_post_binding.dart';
part 'ui/binding/post_search_binding.dart';

part 'ui/pages/explorer_page.dart';
part 'ui/pages/post_detail_page.dart';
part 'ui/pages/post_search_page.dart';
part 'ui/pages/create_post_page.dart';
part 'ui/pages/my_post_page.dart';

part 'ui/view_model/explorer_view_model.dart';
part 'ui/view_model/post_detail_view_model.dart';
part 'ui/view_model/post_search_view_model.dart';
part 'ui/view_model/create_post_view_model.dart';
part 'ui/view_model/my_post_view_model.dart';
part 'ui/widgets/post_card.dart';
