import 'package:flutter/material.dart';

class CabeceraBack extends StatelessWidget {
  const CabeceraBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.5, //16/9,
      child: LayoutBuilder(builder: (_, constrains) {
        return Container(
          //color: Colors.red,
          //height: 600,
          child: Stack(
            children: <Widget>[
              Positioned(
                //top: constrains.maxHeight * 0.26,
                top: 0,
                right: 0,
                child: Image.asset(
                  'img/menu.png',
                  //width: constrains.maxWidth,
                  height: constrains.maxHeight * 1.0,
                ),
              ),
              Positioned(
                top: 12,
                right: 10,
                //right: 0,
                child: Image.asset(
                  'img/ups.png',
                  height: constrains.maxHeight * 0.6,
                ),
              ),
              Positioned(
                //top: constrains.maxHeight * 0.26,
                top: 15,
                left: 10,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                   
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'img/back.png',
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                ),
              ),

              // Positioned(
              //     top: constrains.maxHeight * 0.32,
              //     left: 120,
              //     child: SvgPicture.asset(
              //       "imagen/clouds.svg",
              //       width: constrains.maxWidth,
              //       height: constrains.maxHeight * 0.4,
              //     )),
              // Positioned(
              //     top: constrains.maxHeight * 0.32,
              //     left: 5,
              //     child: SvgPicture.asset(
              //       "imagen/cloud.svg",
              //       width: constrains.maxWidth,
              //       height: constrains.maxHeight * 0.4,
              //     ))
            ],
          ),
        );
      }),
    );
  }
}
