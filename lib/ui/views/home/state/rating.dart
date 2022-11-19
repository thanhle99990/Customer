import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:provider_arc/core/models/rating.dart';
import 'package:provider_arc/core/services/authentication_service.dart';
import 'package:provider_arc/core/viewmodels/views/map_view_model.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/widgets/custom/mycontainer.dart';
import 'package:provider_arc/ui/widgets/custom/mytext.dart';
import 'package:provider_arc/ui/widgets/my/mybutton.dart';

class Rating extends StatefulWidget {
  final MapViewModel model;

  const Rating({Key key, this.model}) : super(key: key);

  @override
  _RatingState createState() => _RatingState(model);
}

class _RatingState extends State<Rating> {
  final MapViewModel model;
  TextEditingController controllerText = new TextEditingController();
  int rating = 3;

  _RatingState(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        MyContainer(
          child: Column(
            children: <Widget>[
              UIHelper.verticalSpaceSmall,
              MyH2(
                text: "YOU ARRIVED",
              ),
              UIHelper.verticalSpaceMedium,
              Text("Rating your driver"),
              UIHelper.verticalSpaceSmall,
              RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  onRatingUpdate: (rating) {
                    print(rating);
                    setState(() {
                      this.rating = rating.toInt();
                    });
                  }),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    //border corner radius
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), //color of shadow
                        spreadRadius: 1, //spread radius
                        blurRadius: 1, // blur radius
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                      //you can set more BoxShadow() here
                    ],
                  ),
                  padding: EdgeInsets.all(8),
                  child: TextField(
                      controller: controllerText,
                      decoration: InputDecoration(
                        hintText: "Say something about your driver",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.multiline,
                      minLines: 4,
                      maxLines: null),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyButton(
                  caption: "Submit",
                  fullsize: true,
                  onPressed: () {
                    RatingObj obj = RatingObj();
                    obj.iddriver = model.rideobj.iddriver;
                    obj.idcustomer = model.rideobj.idcustomer;
                    obj.code = model.rideobj.code;
                    obj.idride = model.rideobj.idride;
                    obj.fromcustomer = 1;
                    obj.rating = this.rating;
                    obj.comment = controllerText.text;

                    Provider.of<AuthenticationService>(context, listen: false)
                        .getUserDetail();
                    model.submitRating(obj);
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
