import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/api_connection/api_connection.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/models/api_model.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../widgets.dart';

class CreateActivityContainer extends StatefulWidget {
  final RefreshCallback onCreate;

  const CreateActivityContainer({Key key, this.onCreate}) : super(key: key);

  @override
  _CreateActivityContainerState createState() =>
      _CreateActivityContainerState();
}

class _CreateActivityContainerState extends State<CreateActivityContainer> {
  final _captionController = TextEditingController();
  // String _caption = "";
  Image _image;
  PickedFile _byteImage;
  final picker = ImagePicker();
  Activity activity = Activity();

  Future takeImage(bool isCamera) async {
    final pickedFile = isCamera
        ? await picker.getImage(source: ImageSource.camera, maxWidth: 1080.0)
        : await picker.getImage(source: ImageSource.gallery, maxWidth: 1080.0);

    print(pickedFile.path);

    setState(() {
      if (pickedFile != null) {
        if (!kIsWeb)
          _image = Image.file(File(pickedFile.path));
        else
          _image = Image.network(pickedFile.path);
        _byteImage = pickedFile;
      } else {
        print('No image selected.');
      }
    });
  }

  void _buttonPressed() {
    if (_captionController.text != "" || _captionController.text != null) {
      if (_image == null) {
        createActivity(_captionController.text, "").then((value) {
          print(value);
          _captionController.text = "";
          setState(() {});
          widget.onCreate();
        });
      } else {
        UploadedImage uimage;
        uploadImage2(_byteImage).then((value) {
          uimage = value;
          print(uimage.linkImg);

          createActivity(_captionController.text, uimage.linkImg).then((value) {
            print(value);
            _captionController.text = "";
            _image = null;
            setState(() {});
            widget.onCreate();
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    return Card(
      margin: EdgeInsets.symmetric(
          // horizontal: isDesktop ? 5.0 : 0.0,
          // vertical: 5.0,
          ),
      elevation: isDesktop ? 1.0 : 0.0,
      shape: isDesktop
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
          : null,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 0.0),
        // color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                ProfileAvatar(
                    imageUrl:
                        "http://103.81.86.241:2812/api/images/X55z8gW8V4zeGTiB5pVU.png"),
                const SizedBox(width: 15.0),
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 14.0),
                    decoration: InputDecoration(
                        // isDense: true,
                        // contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                        border: InputBorder.none,
                        hintText: 'Mô tả hoạt động'),
                    controller: _captionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                )
              ],
            ),
            SizedBox(height: 10.0),
            _image == null
                ? SizedBox.shrink()
                : Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      // Image.file(_image),

                      Container(
                        height: 600,
                        decoration: BoxDecoration(
                          // color: Colors.green,
                          image: DecorationImage(
                              image: _image.image // <--- .image added here
                              ),
                        ),
                      ),
                      RawMaterialButton(
                        constraints:
                            BoxConstraints(minWidth: 30.0, minHeight: 30.0),
                        elevation: 2.0,
                        onPressed: () {
                          _image = null;
                          setState(() {});
                        },
                        child: new Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 20,
                        ),
                        shape: CircleBorder(),
                        fillColor: Colors.white,
                        // padding: const EdgeInsets.all(10.0),
                      ),
                    ],
                  ),
            const Divider(height: 5.0, thickness: 0.5),
            Container(
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: FlatButton.icon(
                      onPressed: () {
                        takeImage(true);
                        // setState(() {});
                      },
                      icon: const Icon(
                        Icons.add_a_photo_outlined,
                        color: Colors.green,
                      ),
                      label: Text(''),
                    ),
                  ),
                  // const VerticalDivider(width: 8.0),
                  Expanded(
                    child: FlatButton.icon(
                      onPressed: () {
                        takeImage(false);
                        // setState(() {});
                      },
                      icon: const Icon(
                        Icons.add_photo_alternate_outlined,
                        color: Colors.orange,
                      ),
                      label: Text(''),
                    ),
                  ),
                  const VerticalDivider(width: 10.0),
                  Expanded(
                    flex: 3,
                    child: TextButton(
                      onPressed: () {
                        // print(_captionController.text);
                        // print(_image.path);
                        _buttonPressed();
                      },
                      child: Text("Đăng"),
                      style: ButtonStyle(
                        // padding: MaterialStateProperty.all(
                        //     EdgeInsets.symmetric(vertical: 15.0)),
                        backgroundColor:
                            MaterialStateProperty.all(Palette.koniuBlue),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                    ),
                  ),
                  // const VerticalDivider(width: 8.0),
                  // FlatButton.icon(
                  //   onPressed: () => print('Photo'),
                  //   icon: const Icon(
                  //     Icons.photo_library,
                  //     color: Colors.green,
                  //   ),
                  //   label: Text('Photo'),
                  // ),
                  // const VerticalDivider(width: 8.0),
                  // FlatButton.icon(
                  //   onPressed: () => print('Room'),
                  //   icon: const Icon(
                  //     Icons.video_call,
                  //     color: Colors.purpleAccent,
                  //   ),
                  //   label: Text('Room'),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

typedef RefreshCallback = void Function();
