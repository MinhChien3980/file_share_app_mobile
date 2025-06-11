part of '../../auth.dart';

class AuthPage extends BaseView<AuthViewModel> {
  const AuthPage({super.key});
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: Get.nestedKey(RouterName.auth.hashCode),
        onGenerateRoute: (settings) {
          return GetPageRoute(
            settings: settings,
            page: () {
              switch (settings.name) {
                case RouterName.login:
                  return GetBuilder(
                    init: Get.find<LoginViewModel>(),
                    autoRemove: false,
                    builder: (controller) => const LoginPage(),
                  );
                case RouterName.register:
                  return GetBuilder(
                    init: Get.find<RegisterViewModel>(),
                    autoRemove: false,
                    builder: (controller) => const RegisterPage(),
                  );
                case RouterName.forgotPassword:
                  return GetBuilder(
                    init: Get.find<ForgetPasswordViewModel>(),
                    autoRemove: false,
                    builder: (controller) => const ForgetPasswordPage(),
                  );
                default:
                  return const _OnAuthPage();
              }
            },
          );
        },
      ),
    );
  }
}

class _OnAuthPage extends StatelessWidget {
  const _OnAuthPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: Assets.img.auth.image(
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Column(
              children: [
                gap32h,
                Text(
                  'Welcome to our App',
                  style: context.textTheme.titleMedium,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(
                            RouterName.login,
                            id: RouterName.auth.hashCode,
                          );
                        },
                        child: const Text('Login'),
                      ),
                      gap20h,
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: blackColor,
                          ),
                        ),
                        onPressed: () {
                          Get.toNamed(
                            RouterName.register,
                            id: RouterName.auth.hashCode,
                          );
                        },
                        child: const Text('Register'),
                      ),
                      gap20h,
                      TextButton(
                        onPressed: () {
                          Get.toNamed(
                            RouterName.forgotPassword,
                            id: RouterName.auth.hashCode,
                          );
                        },
                        child: const Text(
                          'Forgot Password',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
