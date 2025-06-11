part of '../../profile.dart';

class EditProfilePage extends BaseView<EditProfileViewModel> {
  const EditProfilePage({super.key});

  @override
  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh sửa hồ sơ'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      backgroundColor: Colors.grey.shade50,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Form(
                key: viewModel.keyForm,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Cập nhật thông tin',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ImagePickInput(
                      controller: viewModel.imageController,
                      // Image is optional for profile updates
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: viewModel.usernameController,
                      enabled: false,
                      decoration: const InputDecoration(
                        labelText: 'Tên đăng nhập',
                        hintText: 'Tên đăng nhập không thể thay đổi',
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        filled: true,
                        fillColor: Color(0xFFF5F5F5),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: viewModel.firstNameController,
                      decoration: const InputDecoration(
                        labelText: 'Họ',
                        hintText: 'Nhập họ',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      validator: Validator.validateName,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: viewModel.lastNameController,
                      decoration: const InputDecoration(
                        labelText: 'Tên',
                        hintText: 'Nhập tên',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      validator: Validator.validateName,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: viewModel.emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Nhập địa chỉ email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      validator: Validator.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: viewModel.phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Số điện thoại',
                        hintText: 'Nhập số điện thoại',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                      validator: Validator.validatePhoneNumber,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        viewModel.onSubmitPress();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Lưu thay đổi',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
