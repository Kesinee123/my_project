import 'package:flutter/material.dart';

class AppBarActionItems extends StatelessWidget {
  const AppBarActionItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('User Name',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
        SizedBox(width: 30,),
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/avatan.jpg'),
        ),
        // IconButton(onPressed: (){}, icon: Icon(Icons.arrow_drop_down_outlined,color: Colors.black,))
      ],
    );
  }
}