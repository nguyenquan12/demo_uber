import 'package:flutter/material.dart';
import 'package:uber_app/models/jcbSearchDestinationModel.dart';

class SearchDestinationScreen extends StatefulWidget {
  const SearchDestinationScreen({super.key});

  @override
  State<SearchDestinationScreen> createState() =>
      _SearchDestinationScreenState();
}

class _SearchDestinationScreenState extends State<SearchDestinationScreen> {
  List<JCBSearchDestinationModel> destinationList = jcbDestinationsList();

  TextEditingController destination = TextEditingController();
  List<String> addedDestinations = [];

  bool showAdd = false;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
