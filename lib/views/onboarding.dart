import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/controllers/onboarding_controller.dart';
import 'package:patient_tracker/customs/customtext.dart';

class OnboardingView extends StatelessWidget {
  OnboardingView({Key? key}) : super(key: key);

  final OnboardingController _controller = Get.put(OnboardingController());
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: blackColor,
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _controller.pageController,
                    onPageChanged: _controller.selectedPageIndex,
                    itemCount: _controller.onboardingScreens.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 14,
                            ),
                            child: Image.asset(
                              _controller.onboardingScreens[index].imageAsset.toString(),
                              fit: BoxFit.cover,
                              width: screenWidth,
                              height: screenHeight * 0.57,
                            )
                          ),
                          Padding(padding: EdgeInsets.only(top: screenHeight * 0.45),
                           child: SizedBox(
                            width: screenWidth * 0.9,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,

                              children: [
                                Padding(padding: const EdgeInsets.symmetric(
                                  horizontal: 13,
                                ),
                                child: CustomText(
                                  label: _controller.onboardingScreens[index].title,
                                  fontSize: 16,
                                  labelColor: appbartextColor,
                                )
                                ),
                                const SizedBox(height: 12,),
                                Padding(padding: const EdgeInsets.symmetric(
                                        horizontal: 13,
                                ),
                                child: CustomText(
                                  label: _controller.onboardingScreens[index].description,
                                  fontSize: 13,
                                  labelColor: appbartextColor,
                                  italic: true,
                                )),
                                const SizedBox(height: 12,),
                                Padding(padding: const EdgeInsets.only(
                                 left: 0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    _controller.onboardingScreens.length,
                                    (index) => Obx(() {
                                     return GestureDetector(
                                       onTap: () {
                                         _controller.pageController.animateToPage(index, duration: const Duration(microseconds: 300), curve: Curves.easeInOut);
                                       },
                                       child: Container(
                                         margin: const EdgeInsets.all(4),
                                         width: 12,
                                         height: 12,
                                         decoration: BoxDecoration( 
                                           color: _controller.selectedPageIndex.value == index ? primaryColor : greyColor,
                                           shape: BoxShape.circle,
                                         ),
                                       ),
                                     );
                                    }),
                                  ),
                                )
                                )

                              ],
                            )
                           )
                          ),
                        ],
                      );
                    },
                  ),
                  Positioned(
                    left: (screenWidth - 200) / 2,
                    right: (screenWidth - 200) / 2,
                    bottom: 20,
                    child: Obx(() => _controller.isLastScreen ? Padding(padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Get.offAll('/login');
                      },
                      child: Container(
                        width: screenWidth * 0.75,
                        height: screenHeight * 0.065,
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:  const Center(
                          child: CustomText(
                            label: 'Proceed',
                            fontSize: 20,
                            labelColor: primaryColor,
                          ),
                        )
                      )
                    ),
                    ): const Center()),
                  )
                ],
              )),
        ));
  }
}
