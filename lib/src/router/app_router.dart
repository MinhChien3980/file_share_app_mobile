part of 'router.dart';

class AppRouter {
  AppRouter._();
  static String get initialRoute => RouterName.splash;
  static List<GetPage> get routes => [
        GetPage(
          name: RouterName.splash,
          page: () => const SplashPage(),
          binding: SplashBinding(),
        ),
        GetPage(
          name: RouterName.onBoard,
          page: () => const OnboardPage(),
          binding: OnboardBinding(),
        ),
        GetPage(
          name: RouterName.auth,
          page: () => const AuthPage(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: RouterName.home,
          page: () => const HomePage(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: RouterName.editProfile,
          page: () => const EditProfilePage(),
          binding: EditProfileBinding(),
        ),
        GetPage(
          name: RouterName.changePassword,
          page: () => const ChangePasswordPage(),
          binding: ChangePasswordBinding(),
        ),
        GetPage(
          name: RouterName.postDetail,
          page: () => const PostDetailPage(),
          binding: PostDetailBinding(),
        ),
        GetPage(
          name: RouterName.createPost,
          page: () => const CreatePostPage(),
          binding: CreatePostBinding(),
        ),
        GetPage(
          name: RouterName.myPosts,
          page: () => const MyPostPage(),
          binding: MyPostBinding(),
        ),
      ];
}

class RouterName {
  RouterName._();

  static const String splash = '/splash';

  static const String onBoard = '/onBoard';
  static const String auth = '/auth';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/auth/forgotPassword';

  static const String home = '/home';

  static const String profile = '/profile';
  static const String editProfile = '/profile_edit';
  static const String changePassword = '/change_password';

  static const String postDetail = '/post_detail';
  static const String myPosts = '/my_posts';
  static const String createPost = '/create_post';
}
