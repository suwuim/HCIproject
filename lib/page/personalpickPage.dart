import 'package:flutter/material.dart';
import 'package:travelmate/components/home_travelpickWidget.dart';
import 'package:travelmate/components/navigation_menu.dart';
import 'package:travelmate/design/color_system.dart';

class PersonalPickPage extends StatelessWidget {
  String profile = "assets/images/캐릭터.png";
  int age = 22;
  String sex = "여성";
  String destination = "뉴질랜드 퀸스타운";
  String duration = "4주";
  String partner = "혼자";
  String purpose = "문화탐방";
  String budget = "300~700만원";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          NavigationMenu(),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Color(0xFFDBE7ED),
                    child: Column(
                      children: [
                        SizedBox(height: 50,),
                        ClipOval(child: Image.asset(profile, width: 230, height: 230, fit: BoxFit.cover,),),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(age.toString(), style: TextStyle(fontSize: 30)), Text("세", style: TextStyle(fontSize: 30)),
                            SizedBox(width: 3,), Text(sex, style: TextStyle(fontSize: 30))
                          ],
                        ),
                        SizedBox(height: 50,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.share_location, size: 40, color: AppColors.DarkBlue),
                                  SizedBox(width: 10,),
                                  Text("여행지:  ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.DarkBlue),),
                                  Text(destination, style: TextStyle(fontSize: 20),)
                                ],
                              ),
                              SizedBox(height: 30,),
                              Row(
                                children: [
                                  Icon(Icons.calendar_month, size: 40, color: AppColors.DarkBlue),
                                  SizedBox(width: 10,),
                                  Text("기간:  ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.DarkBlue),),
                                  Text(duration, style: TextStyle(fontSize: 20),)
                                ],
                              ),
                              SizedBox(height: 30,),
                              Row(
                                children: [
                                  Icon(Icons.group_add, size: 40, color: AppColors.DarkBlue),
                                  SizedBox(width: 10,),
                                  Text("동반인:  ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.DarkBlue,),),
                                  Text(partner, style: TextStyle(fontSize: 20),)
                                ],
                              ),
                              SizedBox(height: 30,),
                              Row(
                                children: [
                                  Icon(Icons.flag, size: 40, color: AppColors.DarkBlue),
                                  SizedBox(width: 10,),
                                  Text("목적:  ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.DarkBlue),),
                                  Text(destination, style: TextStyle(fontSize: 20),)
                                ],
                              ),
                              SizedBox(height: 30,),
                              Row(
                                children: [
                                  Icon(Icons.payments_outlined, size: 40, color: AppColors.DarkBlue),
                                  SizedBox(width: 10,),
                                  Text("예산:  ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.DarkBlue),),
                                  Text(budget, style: TextStyle(fontSize: 20),)
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        //여행일정
                        Expanded(
                          flex: 1,
                          child: Container()),

                        //필수준비물 목록
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 50, horizontal: 80),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Text("필수 준비물 목록", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: AppColors.DarkBlue,
                                      ),
                                      child: Text('더 둘러보기', style: TextStyle(fontSize: 15),),
                                    ),
                                    SizedBox(width: 10),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: AppColors.DarkBlue,
                                      ),
                                      onPressed: () {},
                                      child: Text('참고해서 내 계획 만들기 ', style: TextStyle(fontSize: 15),),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}





