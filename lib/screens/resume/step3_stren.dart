import 'package:flutter/material.dart';
import 'package:halmoney/screens/resume/step4_career.dart';
import 'package:halmoney/screens/resume/userInput.dart';

class StepStrenPage extends StatefulWidget {
  final UserInput userInput;

  StepStrenPage({
    super.key,
    required this.userInput,
  });

  @override
  State<StepStrenPage> createState() => _StepStrenPageState();
}

class _StepStrenPageState extends State<StepStrenPage> {
  List<String> selectedStrens = [];

  void updateSelectedStrens(List<String> fields) {
    setState(() {
      selectedStrens = fields;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        title: Row(
          children: [
            Image.asset(
              'assets/images/img_logo.png',
              fit: BoxFit.contain,
              height: 40,
            ),
            Container(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  '할MONEY',
                  style: TextStyle(
                    fontFamily: 'NanumGothicFamily',
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                )),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: 25.0, right: 25.0, top: 25.0, bottom: 15.0),
        child: Column(
          children: [
            // 페이지 이동 영역
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 이전 페이지로 이동
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.chevron_left,
                        size: 30,
                      ),
                      Text('이전',
                          style: TextStyle(
                            fontFamily: 'NanumGothicFamily',
                            fontSize: 20.0,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),

                //다음 페이지로 이동
                GestureDetector(
                  onTap: () {
                    widget.userInput.editSelectedStrens(selectedStrens);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              StepCareerPage(userInput: widget.userInput)),
                    );
                  },
                  child: const Row(
                    children: [
                      Text('다음',
                          style: TextStyle(
                            fontFamily: 'NanumGothicFamily',
                            fontSize: 20.0,
                            color: Colors.black,
                          )),
                      Icon(
                        Icons.chevron_right,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 질문 텍스트 상자
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('자신의 장점은\n무엇이라고 생각하나요?',
                            style: TextStyle(
                              fontFamily: 'NanumGothicFamily',
                              fontWeight: FontWeight.w500,
                              fontSize: 28.0,
                              color: Colors.black,
                            )),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // 직무 선택 영역
                    StrenChooseWidget(
                      selectedStrens: selectedStrens,
                      onSelectedStrensChanged: updateSelectedStrens,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StrenChooseWidget extends StatefulWidget {
  final List<String> selectedStrens;
  final ValueChanged<List<String>> onSelectedStrensChanged;

  const StrenChooseWidget({
    super.key,
    required this.selectedStrens,
    required this.onSelectedStrensChanged,
  });

  @override
  State<StrenChooseWidget> createState() => _StrenChooseWidgetState();
}

class _StrenChooseWidgetState extends State<StrenChooseWidget> {
  List<String> fields = [
    '성실',
    '친절',
    '꼼꼼함',
    '책임감',
    '적극적',
    '배려심',
    '사교성',
    '세심함',
    '인사성',
    '습득력',
    '정리정돈',
    '긍정적'
  ];

  TextEditingController _searchTextEditingController = TextEditingController();

  String get _searchText => _searchTextEditingController.text.trim();

  @override
  void initState() {
    super.initState();
    _searchTextEditingController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchTextEditingController.dispose();
    super.dispose();
  }

  List<String> _filterStrens() {
    if (_searchText.isEmpty) return fields;

    return fields
        .where(
            (field) => field.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();
  }

  void _addNewTag(String tag) {
    setState(() {
      fields.add(tag);
      widget.selectedStrens.add(tag);
    });
    widget.onSelectedStrensChanged(widget.selectedStrens);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSelectedTags(),
        const SizedBox(height: 20),
        _buildSearchStren(),
        const SizedBox(height: 20),
        _buildTags(),
      ],
    );
  }

  Widget _buildSelectedTags() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: widget.selectedStrens.map((field) {
        return Chip(
          label: Text(
            field,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          deleteIcon: Icon(Icons.close, color: Colors.white),
          onDeleted: () {
            setState(() {
              widget.selectedStrens.remove(field);
            });
            widget.onSelectedStrensChanged(widget.selectedStrens);
          },
        );
      }).toList(),
    );
  }

  Widget _buildSearchStren() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchTextEditingController,
              decoration: const InputDecoration.collapsed(
                hintText: '장점을 검색하거나 추가하세요',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          if (_searchText.isNotEmpty)
            GestureDetector(
              onTap: () {
                if (_filterStrens().isEmpty &&
                    !widget.selectedStrens.contains(_searchText)) {
                  _addNewTag(_searchText);
                  _searchTextEditingController.clear();
                }
              },
              child: Icon(Icons.add, color: Colors.grey.shade600),
            )
          else
            Icon(Icons.search, color: Colors.grey.shade600),
        ],
      ),
    );
  }

  Widget _buildTags() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: _filterStrens().map((field) {
        final isSelected = widget.selectedStrens.contains(field);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                widget.selectedStrens.remove(field);
              } else {
                widget.selectedStrens.add(field);
              }
            });
            widget.onSelectedStrensChanged(widget.selectedStrens);
          },
          child: Chip(
            label: Text(
              field,
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.grey.shade300,
          ),
        );
      }).toList(),
    );
  }
}
