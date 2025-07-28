import 'package:flutter/material.dart';

class OnboardingCarousel extends StatefulWidget {
  final List<Widget> carouselWidgets;
  const OnboardingCarousel({super.key, required this.carouselWidgets});

  @override
  State<OnboardingCarousel> createState() => _OnboardingCarouselState();
}

class _OnboardingCarouselState extends State<OnboardingCarousel> {
  late PageController _pageController;
  int currentPage = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.17,
          child: PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.carouselWidgets.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: widget.carouselWidgets[index],
              );
            },
          ),
        ),
        const SizedBox(height: 30),
        // Page indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.carouselWidgets.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentPage == index
                    ? const Color.fromARGB(255, 240, 242, 240)
                    : const Color.fromARGB(255, 228, 228, 228)
                        .withValues(alpha: 0.3),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (currentPage < widget.carouselWidgets.length - 1) {
                setState(() {
                  currentPage++;
                });
                _pageController.animateToPage(
                  currentPage,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                // TODO: Navigate to main app
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color.fromARGB(255, 9, 96, 4),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              currentPage < widget.carouselWidgets.length - 1
                  ? 'Continuar'
                  : 'Comenzar',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
