part of '../../onboard.dart';

class OnboardPage extends BaseView<OnboardViewModel> {
  const OnboardPage({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _OnboardPageView(
                      image: Assets.svg.myFile.svg(),
                      title: 'Welcome to the App',
                      description: 'This is the first page of the onboarding process.',
                    ),
                    _OnboardPageView(
                      image: Assets.svg.searchFile.svg(),
                      title: 'Discover Features',
                      description: 'Learn about the amazing features we offer.',
                    ),
                    _OnboardPageView(
                      image: Assets.svg.uploadFile.svg(),
                      title: 'Get Started',
                      description: 'Let\'s get started with your journey!',
                    ),
                  ],
                ),
              ),
              gap20,
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: controller.currentPage == index ? primaryColor : greyColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
              gap20,
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    if (controller.isLastPage) {
                      controller.finishOnboarding();
                    } else {
                      controller.changePage(controller.currentPage + 1);
                    }
                  },
                  child: Obx(() => Text(controller.isLastPage ? 'Finish' : 'Next')),
                ),
              ),
              gap20,
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardPageView extends StatelessWidget {
  final Widget image;
  final String title;
  final String description;

  const _OnboardPageView({
    this.image = const SizedBox.shrink(),
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ColoredBox(
                      color: quaternaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: image,
                      )),
                ),
              ),
            ),
          ),
          Text(
            title,
            style: context.textTheme.headlineMedium,
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: context.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
