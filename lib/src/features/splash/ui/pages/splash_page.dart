part of '../../splash.dart';

class SplashPage extends BaseView<SplashViewModel> {
  const SplashPage({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Assets.img.logo.image(
                    width: 200,
                    height: 200,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Shared File',
                  style: text24.bold.white,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const SizedBox(
            height: 32,
            width: 32,
            child: CircularProgressIndicator(
              color: whiteColor,
              strokeWidth: 2,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(height: context.mediaQueryPadding.bottom)
        ],
      ),
    );
  }
}
