

import 'package:flutter/material.dart';

class Mini extends StatelessWidget{


  String? newtask;

  @override
  Widget build(BuildContext context) {

    return Column(

      mainAxisSize: MainAxisSize.min,
      children: [Text('Change Info',textAlign: TextAlign.center,style: TextStyle(
        fontSize: 20,color:Colors.black,
      )
        ,),
        TextField(
          autofocus: true,
          textAlign: TextAlign.center,
          style:TextStyle(fontSize: 20,color:Color.fromRGBO(67, 37, 95, 1)),
          onChanged: (newText){
            newtask=newText;
          },
        ), ElevatedButton(onPressed: () { },
          child:  const Text(
            'change',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25
            ),),style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.fromLTRB( 100, 15, 100, 15)),backgroundColor: MaterialStateProperty.all(Colors.orange)),),],
    );
  }

}