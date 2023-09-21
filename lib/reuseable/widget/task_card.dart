import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/style/my_theme.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      elevation: 12,
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: .4,
          motion: const DrawerMotion(),
          children:  [
            SlidableAction(
              autoClose: true,
              onPressed: (context){},
              backgroundColor: Color(0xFFFE4A49),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              autoClose: true,
              onPressed: (context){},
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),

        child: Padding(
          padding: const EdgeInsets.only(left: 20,top: 25.0,bottom: 25,right: 25 ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      5.0), // Adjust the radius as needed
                  color: MyThemeData.lightColor,
                ),
                width: 4,
                height: MediaQuery.of(context).size.height*.08,
                child: const VerticalDivider(),
              ),
              const SizedBox(width: 25,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('hello world',style: Theme.of(context).textTheme.bodyLarge,),
                  const SizedBox(height: 5,),
                  Text('data',style: Theme.of(context).textTheme.bodySmall,),
                ],
              ),
              const Spacer(),
              ElevatedButton(onPressed: (){}, child: const Icon(Icons.done),),
            ],
          ),
        ),
      ),
    );
  }
}
