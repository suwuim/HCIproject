import 'package:flutter/material.dart';
import 'package:travelmate/design/color_system.dart';

class ChatSchedule extends StatefulWidget {
  @override
  State<ChatSchedule> createState() => _ChatScheduleState();
}

class _ChatScheduleState extends State<ChatSchedule> {
  static const double containerWidth = 0.6;

  bool showFirstContent = true;
  bool isLoading = true;

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Container(color: Color(0xFFDBE7ED),),


        Padding(
          padding: const EdgeInsets.only(left: 30, right: 270, top: 30, bottom: 30),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        showFirstContent = true;
                      });
                    },
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: showFirstContent ? AppColors.DarkBlue : Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          border: Border.all(
                            color: AppColors.DarkBlue
                          ),
                        ),
                        child: Text(
                          "플래너",
                          style: TextStyle(
                            color: showFirstContent ? Colors.white : AppColors.DarkBlue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        showFirstContent = false;
                      });
                    },
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: showFirstContent ? Colors.white : AppColors.DarkBlue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          border: Border.all(
                              color: AppColors.DarkBlue
                          ),
                        ),
                        child: Text(
                          "준비물",
                          style: TextStyle(
                            color: showFirstContent ? AppColors.DarkBlue : Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: showFirstContent
                    ? PlanContent(country: "퀸스타운",) : PrepareContent(),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 30, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xFF28466A),
                    width: 2,
                  ),
                ),
                child: Icon(Icons.download, color: Colors.black, size: 25,),
              ),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    color: Color(0xFF28466A),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Text("공유하기", style: TextStyle(color: Colors.white ,fontSize: 15),),
              )
            ],
          ),
        ),
      ],
    );
  }
}


class PlanContent extends StatefulWidget {
  String country;

  PlanContent({
    required this.country
  });

  @override
  State<PlanContent> createState() => _PlanContentState();
}

class _PlanContentState extends State<PlanContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.DarkBlue),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "여행일정: " + widget.country,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    ElevatedButton(onPressed: () {}, child: Icon(Icons.undo, color: Colors.white,), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF90A2B1)),),
                    SizedBox(width: 10,),
                    ElevatedButton(onPressed: () {}, child: Icon(Icons.redo, color: Colors.white,), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF90A2B1),),)
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Image.asset("assets/images/일정데코.png"),
          ),
          Expanded(child: Container())
        ],
      ),
    );
  }
}




class PrepareContent extends StatefulWidget {
  const PrepareContent({super.key});

  @override
  State<PrepareContent> createState() => _PrepareContentState();
}

class _PrepareContentState extends State<PrepareContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.DarkBlue),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "당신의 여행에 필요한 준비물",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    ElevatedButton(onPressed: () {}, child: Icon(Icons.undo, color: Colors.white,), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF90A2B1)),),
                    SizedBox(width: 10,),
                    ElevatedButton(onPressed: () {}, child: Icon(Icons.redo, color: Colors.white,), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF90A2B1)),)
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Image.asset("assets/images/일정데코.png"),
          ),
          Expanded(child: Container())
        ],
      ),
    );
  }
}

