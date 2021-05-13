import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Hero(
          tag: widget.tag,
          child: Center(
            child: CachedNetworkImage(
              imageUrl: widget.url,
            ),
            // child: Text(widget.tag),
          ),
        ),
        // body: Center(child: Text(widget.tag)),
      ),
      onTap: () => Navigator.pop(context),
    );
  }
}
