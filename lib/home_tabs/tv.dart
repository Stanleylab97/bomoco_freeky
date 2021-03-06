import 'package:bomoco/models/interview.dart';
import 'package:bomoco/widgets/show_video.dart';
import 'package:bomoco/widgets/tv_components/hero_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class Tele extends StatefulWidget {
  var tutorials;

  @override
  _TeleState createState() => _TeleState();
}

class _TeleState extends State<Tele> {
  List<Interview> interviews;
  /* getListInterview() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('informations')
        .doc('various')
        .collection('tv')
        .get();

    print(snap.docs);

    snap.docs.forEach((document) {
      print(document.data()['imageUrl']);
      var de=document.data();
      var inter =  Interview(imageUrl:de['imageUrl'], videoUrl:de['videoUrl'], desc: de['desc']);
      interviews.add(inter);
      
    });

    return interviews;
  } */

  List<Tuple3> articles=  [
    const Tuple3<String, String, String>(
      'http://himdeve.com/wp-content/uploads/2020/01/1_1_simple_webview_en_banner.jpg',
      'Flutter Tutorials – #1.1 – First App – Simple WebView',
      'https://www.pexels.com/fr-fr/video/1389615/',
    ),
    const Tuple3<String, String, String>(
      'https://himdeve.com/wp-content/uploads/2020/01/1_2_webview_controller_en_banner.jpg',
      'Flutter Tutorials – #1.2 – WebView Controller – Completer, Future Builder, Await – Async',
      'https://himdeve.com/demo/himdeve_flutter_tutorial_webview_controller_1_2.mp4',
    ),
    const Tuple3<String, String, String>(
      'https://himdeve.com/wp-content/uploads/2020/01/1_3_webview_javascript_en_banner.jpg',
      'Flutter Tutorial – #1.3 – WebView – Navigation Controls, Javascript communication',
      'https://himdeve.com/demo/himdeve_flutter_tutorial_webview_javascript_1_3.mp4',
    ),
    const Tuple3<String, String, String>(
      'https://himdeve.com/wp-content/uploads/2020/01/1_4_drawer_en_banner_final.jpg',
      'Flutter Tutorials – #1.4 – DRAWER – PageRoute, Navigator, UserAccountsDrawerHeader',
      'https://himdeve.com/demo/himdeve_flutter_tutorial_drawer_1_4.mp4',
    ),
    const Tuple3<String, String, String>(
      'https://himdeve.com/wp-content/uploads/2020/02/1_5_sliverappbar_banner_en.jpg',
      'Flutter Tutorials – #1.5 – Sliver App Bar = Collapsing Toolbar',
      'https://himdeve.com/demo/himdeve_flutter_tutorial_sliverappbar_1_5.mp4',
    ),
    const Tuple3<String, String, String>(
      'https://himdeve.com/wp-content/uploads/2020/02/1_6_sliverlist_banner_en.jpg',
      'Flutter Tutorials – #1.6 – SliverList',
      'https://himdeve.com/demo/himdeve_flutter_tutorial_sliverlist_1_6.mp4',
    ),
    const Tuple3<String, String, String>(
      'https://himdeve.com/wp-content/uploads/2020/02/1_7_pageview_banner_en_final.jpg',
      'Flutter Tutorials – #1.7 – PageView & BottomNavigationBar',
      'https://himdeve.com/demo/himdeve_flutter_tutorial_pageview_1_7.mp4',
    ),
    const Tuple3<String, String, String>(
      'https://himdeve.com/wp-content/uploads/2020/02/1_8_tabbar_banner_en.jpg',
      'Flutter Tutorials – #1.8 – TabBar',
      'https://himdeve.com/demo/himdeve_flutter_tutorial_tabbar_1_8.mp4',
    ),
    const Tuple3<String, String, String>(
      'https://himdeve.com/wp-content/uploads/2020/03/1_9_gridview_slivergrid_en.jpg',
      'Flutter Tutorial – #1.9 – GridView & SliverGrid (Gallery)',
      'https://himdeve.com/demo/himdeve_flutter_tutorial_gridview_slivergrid_1_9.mp4',
    ),
    const Tuple3<String, String, String>(
      'https://himdeve.com/wp-content/uploads/2020/03/1_10_image_carousel_en.jpg',
      'Flutter Tutorial – #1.10 – Image Carousel & Carousel Slider [Gallery Detail]',
      'https://himdeve.com/demo/himdeve_flutter_tutorial_image_carousel_1_10.mp4',
    ),
    const Tuple3<String, String, String>(
      'https://himdeve.com/wp-content/uploads/2020/03/1_11_hero_animation_en.jpg',
      'Flutter Tutorial – #1.11 – HERO Animation | Page Transition',
      'https://himdeve.com/demo/himdeve_flutter_tutorial_hero_animation_1_11.mp4',
    ),
    const Tuple3<String, String, String>(
      'https://himdeve.com/wp-content/uploads/2020/04/1_12_video_player_en.jpg',
      'Flutter Tutorial – #1.12 – VIDEO Player | Chewie',
      'https://himdeve.com/demo/himdeve_flutter_tutorial_video_player_1_12.mp4',
    ),
  ]; 

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        _buildSliverContent(),
      ],
    );
  }

  SliverFixedExtentList _buildSliverContent() {
    var tutorials =articles;
    return SliverFixedExtentList(
      itemExtent: 110,
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return _buildListItem(context, tutorials[index]);
        },
        childCount: tutorials.length,
      ),
    );
  }

  Widget _buildListItem(BuildContext context, Tuple3 tutorial) {
    return Stack(
      children: <Widget>[
        _buildCardView(tutorial.item2, tutorial.item1),
        _buildRippleEffectNavigation(
            context, tutorial.item2, tutorial.item1, tutorial.item3),
      ],
    );
  }

  Widget _buildCardView(String desc, String imageUrl) {
    return Positioned.fill(
      child: Card(
        margin: const EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeroWidget(imageUrl),
            _buildDesc(desc),
          ],
        ),
      ),
    );
  }

  Expanded _buildDesc(String desc) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 0),
        child: Text(
          desc,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  HeroWidget _buildHeroWidget(String imageUrl) {
    return HeroWidget(
      width: 150,
      heroTag: imageUrl,
      builder: (BuildContext context) {
        return _buildHeroWidgetContent(imageUrl);
      },
    );
  }

  CachedNetworkImage _buildHeroWidgetContent(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildRippleEffectNavigation(
      BuildContext context, String desc, String imageUrl, String videoUrl) {
    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.red.withOpacity(0.5),
          highlightColor: Colors.red.withOpacity(0.5),
          onTap: () {
            Navigator.of(context).push(
              _createTutorialDetailRoute(desc, imageUrl, videoUrl),
            );
          },
        ),
      ),
    );
  }

  PageRoute<Object> _createTutorialDetailRoute(desc, imageUrl, videoUrl) {
    return PageRouteBuilder(
      transitionDuration: Duration(seconds: 1),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween(begin: Offset(1.0, 0.0), end: Offset.zero)
              .chain(CurveTween(curve: Curves.ease))
              .animate(animation),
          child: FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0)
                .chain(CurveTween(curve: Curves.ease))
                .animate(animation),
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) => DetailsTVPage(
        heroTag: imageUrl,
        desc: desc,
        videoUrl: videoUrl,
      ),
    );
  }
}
