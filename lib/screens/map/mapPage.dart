import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halmoney/address/address_bloc.dart';
import 'package:halmoney/address/address_event.dart';
import 'package:halmoney/address/address_state.dart';
import 'package:halmoney/address/address_model.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return BlocProvider<AddressDepthBloc>(
      create: (_) => AddressDepthBloc(),
      child: BlocConsumer<AddressDepthBloc, AddressDepthState>(
        listener: (context, state){
          if (state is AddressDepthErrorState){
            Navigator.of(context).pop();
          }
        },
        builder: (context, state){
          if (state is AddressDepthInitState){
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color:Color (0xff1044FC),
                ),
              ),
            );
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: GoogleFonts.notoSansKrTextTheme(
                Theme.of(context).textTheme,
              ),
            ),

            home : SafeArea(
              top: true,
              left: false,
              bottom: true,
              right: false,
              child: Scaffold(
                appBar: AppBar(
                  title : const Text('지역 검색'),
                  centerTitle: true,
                  backgroundColor: Colors.white,
                ),
                body:
                  ListView(
                    children: [
                      Divider(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            child:
                              Text("채용 공고를 검색할 지역을 선택하세요",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // 시,도 표시
                              if (state.address!.major.current != null) ...[
                                GestureDetector(
                                  onTap: () => context
                                      .read<AddressDepthBloc>()
                                      .add(AddressDepthResetEvent(type: 0)),
                                  child:
                                    Text(state.address!.major.current!.name,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                      ),
                                    )
                                ),
                              ]
                              else ...[
                                Text("시/도",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                              Icon(Icons.keyboard_arrow_right),

                              // 구,시 표시
                              if (state.address!.middle.current != null) ...[
                                GestureDetector(
                                    onTap: () => context
                                        .read<AddressDepthBloc>()
                                        .add(AddressDepthResetEvent(type: 0)),
                                    child:
                                    Text(state.address!.middle.current!.name,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                      ),
                                    )
                                ),
                              ]
                              else ...[
                                Text("구/시",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                              Icon(Icons.keyboard_arrow_right),

                              // 동, 구 표시
                              if (state.address!.minor.current != null) ...[
                                Text(state.address!.major.current!.name,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                )
                              ]
                              else ...[
                                Text("동/구",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(5.0),
                                //padding: const EdgeInsets.all(5.0),
                                height: 30,
                                width: 80,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(7),
                                  ),
                                ),
                                child:
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "다시선택",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(5.0),
                                //padding: const EdgeInsets.all(5.0),
                                height: 30,
                                width: 80,
                                decoration: const BoxDecoration(
                                  color: Color(0xff1044FC),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(7),
                                  ),
                                ),
                                child:
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "검색하기",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 15,),
                            ],
                          ),
                          SizedBox(height: 10,),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,

                              child: Container(
                                width: 40,
                                child: Column(
                                  children: [
                                    Text("서울시",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text('경기도',
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,

                              child: Container(
                                width: 40,
                                child: Column(
                                  children: [
                                    Text("강동구",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text("광진구",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),flex: 1,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,

                              child: Container(
                                width: 40,
                                child: Column(
                                  children: [
                                    Text("서울시",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text("서울시",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),flex: 1,
                          ),
                        ]
                      ),
                    ],
                  ),
              ),
            ),
          );
        }
      )
    );
  }
}
