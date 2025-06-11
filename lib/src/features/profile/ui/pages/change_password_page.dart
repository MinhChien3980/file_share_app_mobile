part of '../../profile.dart';

class ChangePasswordPage extends BaseView<ChangePasswordViewModel> {
  const ChangePasswordPage({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Obx(
                  () => TextFormField(
                    controller: viewModel.currentPasswordController,
                    obscureText: !viewModel.visiblePassword,
                    decoration: InputDecoration(
                      labelText: 'Current Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(viewModel.visiblePassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          viewModel.toggleVisiblePassword();
                        },
                      ),
                    ),
                    validator: Validator.validatePassword,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: viewModel.newPasswordController,
                  obscureText: !viewModel.visibleNewPassword,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(viewModel.visibleNewPassword ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        viewModel.toggleVisibleNewPassword();
                      },
                    ),
                  ),
                  validator: Validator.validatePassword,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: viewModel.confirmPasswordController,
                  obscureText: !viewModel.visibleConfirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Confirm New Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(viewModel.visibleConfirmPassword ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        viewModel.toggleVisibleConfirmPassword();
                      },
                    ),
                  ),
                  validator: (value) {
                    return Validator.validateConfirmPassword(
                      value,
                      viewModel.newPasswordController.text,
                    );
                  },
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    viewModel.onSubmitPress();
                  },
                  child: const Text('Change Password'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
