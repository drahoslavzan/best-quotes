import 'package:flutter/material.dart';
import 'display_card.dart';

class AdCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DisplayCard(
      // TODO: implement native ad
      child: null
      /*
      child: NativeAdmobBannerView(
        adUnitID: nativeAdUnitId,
        style: BannerStyle.dark, // enum dark or light
        showMedia: true, // whether to show media view or not
        contentPadding: EdgeInsets.all(10), // content padding
        onCreate: (controller) {
          controller.setStyle(BannerStyle.light); // Dynamic update style
        },
      )
      */
    );
  }

  // TODO: replace with real native ID
  static const nativeAdUnitId = 'ca-app-pub-3940256099942544/2247696110';
}