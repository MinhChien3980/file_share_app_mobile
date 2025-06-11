part of '../../auth.dart';

class LoginPage extends BaseView<LoginViewModel> {
  const LoginPage({super.key});
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: blackColor,
          ),
          onPressed: () {
            Get.back(id: RouterName.auth.hashCode);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Welcome back! Please login to your account',
                style: Theme.of(context).textTheme.headlineSmall!.bold,
              ),
              const SizedBox(height: 20),
              Form(
                key: viewModel.formKey,
                child: Column(
                  spacing: 20,
                  children: [
                    TextFormField(
                      controller: viewModel.usernameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: Validator.validateUsername,
                    ),
                    Obx(
                      () => TextFormField(
                        controller: viewModel.passwordController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              viewModel.visiblePassword ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              viewModel.togglePasswordVisibility();
                            },
                          ),
                        ),
                        obscureText: true,
                        validator: Validator.validatePassword,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed(RouterName.forgotPassword, id: RouterName.auth.hashCode);
                        },
                        child: const Text('Forgot Password?'),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          viewModel.login();
                        },
                        child: const Text('Login'),
                      ),
                    ),
                  ],
                ),
              ),
              gap20h,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: greyColor,
                          height: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Or login with'),
                      ),
                      Expanded(
                        child: Divider(
                          color: greyColor,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  gap20,
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () {
                          viewModel.loginWithGoogle();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Assets.svg.google.svg(
                              width: 24,
                              height: 24,
                            ),
                            gap8w,
                            const Expanded(
                                child: Text(
                              'Google',
                              textAlign: TextAlign.center,
                            )),
                          ],
                        )),
                  ),
                ],
              ),
              gap40h,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  gap4w,
                  TextButton(
                    onPressed: () {
                      Get.toNamed(RouterName.register, id: RouterName.auth.hashCode);
                    },
                    child: const Text('Register'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
