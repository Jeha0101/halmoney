import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                  color:Color(0xff1044FC),
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
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios_rounded,),
                    color: Colors.grey,
                  ),
                ),
                body:
                  ListView(
                    children: [
                      Container(
                        height: 180,
                        child:
                          Column(
                            children: [
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    child:
                                      Text("채용 공고를 검색할 지역을 선택하세요",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                  ),
                                ],
                              ),
                              Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  // 시,도 표시
                                  if (state.address!.major.current != null) ...[
                                    GestureDetector(
                                      onTap: () => context
                                          .read<AddressDepthBloc>()
                                          .add(AddressDepthResetEvent(type: 0)),
                                      child:
                                        Container(
                                          width: _width/3,
                                          child: Center(
                                            child:
                                              Text(state.address!.major.current!.name,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                          ),
                                        )
                                    ),
                                  ]
                                  else ...[
                                    Container(
                                      width: _width/3,
                                      child:
                                        Center(
                                          child:
                                            Text("시/도",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey,
                                              ),
                                            ),
                                        ),
                                    ),
                                  ],
                                  Icon(Icons.keyboard_arrow_right),

                                  // 시,구,군 표시
                                  if (state.address!.middle.current != null) ...[
                                    GestureDetector(
                                        onTap: () => context
                                            .read<AddressDepthBloc>()
                                            .add(AddressDepthResetEvent(type: 0)),
                                        child:
                                        Container(
                                          width: _width/3-30,
                                          child: Center(
                                            child: Text(state.address!.middle.current!.name,
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),

                                        )
                                    ),
                                  ]
                                  else ...[
                                    Container(
                                      width: _width/3-30,
                                      child:
                                        Center(
                                          child:
                                          Text("시/구/군",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey,
                                            ),
                                          )
                                        ),
                                    ),
                                  ],
                                  Icon(Icons.keyboard_arrow_right),

                                  // 동 표시
                                  if (state.address!.minor.current != null) ...[
                                    Container(
                                      width: _width/3-30,
                                      child: Center(
                                        child:
                                          Text(state.address!.minor.current!.name,
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                      ),
                                    )
                                  ]
                                  else ...[
                                    Container(
                                      width: _width/3-30,
                                      child:
                                        Center(
                                          child:
                                            Text("동",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey,
                                              ),
                                            ),
                                        ),
                                    ),
                                  ],
                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
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
                                    const Center(
                                      child:
                                        Text(
                                          "검색하기",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                    ),
                                  ),
                                  SizedBox(width: 15,),
                                ],
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),
                      ),
                      Divider(),
                      Container(
                        height: MediaQuery.of(context).size.height-260,
                        child: Row(
                        children: [
                          _listView(
                            width: _width/3,
                            color: Colors.white,
                            selecteColor: Colors.grey,
                            onTap: (i) => context.read<AddressDepthBloc>().add(
                              AddressDepthMiddleEvent(selected: state.address!.major.address[i]),
                            ),
                            address: state.address!.major.address,
                            selected: state.address!.major.current,
                          ),
                          if (state is AddressDepthMiddleState || state is AddressDepthMinorState)...[
                            _listView(
                              width: _width/3,
                              color: Colors.white,
                              selecteColor: Colors.grey,
                              onTap: (i) => context.read<AddressDepthBloc>().add(
                                AddressDepthMinorEvent(selected: state.address!.middle.address[i]),
                              ),
                              address: state.address!.middle.address,
                              selected: state.address!.middle.current,
                            )
                          ],
                          if (state is AddressDepthMinorState)...[
                            _listView(
                              width: _width/3,
                              color: Colors.white,
                              selecteColor: Colors.grey,
                              onTap: (i) => context.read<AddressDepthBloc>().add(
                                AddressDepthFinishEvent(selected: state.address!.minor.address[i]),
                              ),
                              address: state.address!.minor.address,
                              selected: state.address!.minor.current,
                            )
                          ],
                        ],
                      )
                    ),
                  ]
                )
              ),
            ),
          );
        }
      )
    );
  }
  _listView({
    required double width,
    required Function(int) onTap,
    required List<AddressDepthServerModel> address,
    required Color color,
    required Color selecteColor,
    required AddressDepthServerModel? selected,
  }) {
    return Container(
      color: color,
      width: width,
      child: ListView.builder(
        itemCount: address.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              color: selected == null
                  ? Colors.transparent
                  : selected == address[index]
                    ?selecteColor
                    : color,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Text(
                      address[index].name,
                      style: const TextStyle(
                        fontSize: 15,
                      )
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
