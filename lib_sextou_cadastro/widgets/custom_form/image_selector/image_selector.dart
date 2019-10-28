import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sextou_cadastro/widgets/global_widgets/relative_sized_image/relative_size_file_image.dart';
import 'image_selector_bloc.dart';

class ImageSelector extends StatelessWidget {

  ImageSelector({@required this.callback});

  final _imageSelectorBloc = ImageSelectorBloc();

  Function callback;

  Future<void> choosePhoto() async {
    File selected = await ImagePicker.pickImage(source: ImageSource.gallery);
    _imageSelectorBloc.changeFile(file: selected);
  }

  Future<void> takePhoto() async {
    File selected = await ImagePicker.pickImage(source: ImageSource.camera);
    _imageSelectorBloc.changeFile(file: selected);
  }

  void clearPhoto() {
    _imageSelectorBloc.clearPhoto();
  }

  File getFile() {
    return _imageSelectorBloc.getFile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Stack(
        children: <Widget>[
          StreamBuilder(
            stream: _imageSelectorBloc.stream,
            builder: (context, snapshot) {

              ImageProvider _imageProvider = NetworkImage("https://www.grouphealth.ca/wp-content/uploads/2018/05/placeholder-image-300x225.png");

              if (snapshot.data != null) {
                _imageProvider = FileImage(snapshot.data);
                callback(snapshot.data);
              }

              return Center(
                child: GestureDetector(
                  onTap: choosePhoto,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white38,
                        width: 1,
                      )
                    ),
                    child: RelativeSizeImage.relative(
                      image: _imageProvider,
                      fit: BoxFit.cover,
                      heightFactor: 0.3,
                      widthFactor: 1,
                    ),
                  ),
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 5, right: 5),
                child: IconButton(
                  icon: Icon(Icons.close,size: 40,),
                  onPressed: clearPhoto,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
