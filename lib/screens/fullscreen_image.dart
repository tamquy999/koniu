import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';

// class FullscreenImage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Hero(
//         tag: "abc",
//         child: Center(
//           child: CachedNetworkImage(
//             imageUrl:
//                 'https://images.unsplash.com/photo-1525253086316-d0c936c814f8',
//           ),
//         ),
//       ),
//     );
//   }
// }

class FullscreenImage extends StatefulWidget {
  final String tag;
  final String url;

  const FullscreenImage({Key key, @required this.tag, @required this.url})
      : super(key: key);

  @override
  _FullscreenImageState createState() => _FullscreenImageState();
}

class _FullscreenImageState extends State<FullscreenImage> {
  @override
  initState() {
    // SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  void dispose() {
    //SystemChrome.restoreSystemUIOverlays();
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // const String herotag = widget.tag;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("image"),
      // ),
      // backgroundColor: Colors.white,
      body: Hero(
        tag: widget.tag,
        // child: Center(
        //   child: CachedNetworkImage(
        //     imageUrl: widget.url,
        //   ),
        //   // child: Text(widget.tag),
        // ),
        child: PhotoView(
          imageProvider: CachedNetworkImageProvider(
            widget.url,
          ),
        ),
      ),
      // body: PhotoView(
      //   imageProvider: CachedNetworkImageProvider(
      //     widget.url,
      //   ),
      //   heroAttributes: const PhotoViewHeroAttributes(
      //     tag: "abc",
      //     transitionOnUserGestures: true,
      //   ),
      // ),
    );
    //   onTap: () => Navigator.pop(context),
    // );
  }
}
