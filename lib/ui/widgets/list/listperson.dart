import 'package:flutter/material.dart';
import 'package:provider_arc/core/models/person.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';

class ListPerson extends StatefulWidget {
  final List<PersonObj> list;
  final int selected;

  const ListPerson({Key key, this.list, this.selected}) : super(key: key);

  @override
  _ListPersonState createState() => _ListPersonState();
}

class _ListPersonState extends State<ListPerson> {
  Widget _buildItemperson(PersonObj personObj) {
    return Container(
      child: Card(
          child: ListTile(
        title: Text(personObj.name),
        subtitle: Text(personObj.address),
      )),
    );
  }

  Widget _buildItempersonSeelected(PersonObj personObj) {
    return Container(
      child: Card(
          child: ListTile(
        title: Text(personObj.name),
        subtitle: Text(personObj.address),
        trailing: Icon(
          Icons.check_circle_outline,
          color: PrimaryColor,
        ),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.list == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey,
            ),
            shrinkWrap: true,
            itemCount: widget.list.length,
            itemBuilder: (context, index) {
              return index == widget.selected
                  ? _buildItempersonSeelected(widget.list[index])
                  : InkWell(
                      onTap: () {},
                      child: _buildItemperson(widget.list[index]));
            },
          );
  }
}
