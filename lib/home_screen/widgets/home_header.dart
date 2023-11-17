import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {

  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      //color: AppColors.additional,
      margin: const EdgeInsets.only(top: 10),
      elevation: 10,
      child: SizedBox(
        height: 100,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            Container(
              height: 90,
              width: 150,
              margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(20))
                ),
              child: const Icon(
                Icons.account_circle_outlined,
                color: Colors.grey,
                size: 70,
                ),
            ),


            Container(
              height: 90,
              width: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(20))
                ),
              //margin: const EdgeInsets.only(top: 30),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                    width: 100,
                    child: Text('UserName', ),
                    ),
                  SizedBox(
                    height: 30,
                    width: 100,
                    child: Text('My ToDos'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
