import 'package:cryptop/components/custom_buttom/custom_button.dart';
import 'package:cryptop/components/text_component/text_component.dart';
import 'package:flutter/material.dart';
import 'smart_trade_list_item_body.dart';

class SmartTradeList extends StatelessWidget {
  const SmartTradeList({
    Key? key,
    this.setIndex,
    this.activeIndex,
    this.edit,
    this.delete,
    this.status,
  }) : super(key: key);

  final Function? edit;
  final Function? delete;
  final Function? status;
  final Function? setIndex;
  final int? activeIndex;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => InkWell(
          onTap: () => setIndex!(index),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.white, width: 1),
              ),
            ),
            child: Column(
              children: [
                activeIndex == index
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const TextComponent(
                            align: TextAlign.start,
                            fontSize: 14.0,
                            line: 1,
                            textColor: Colors.white,
                            title: 'BTCUSDT',
                            weight: FontWeight.bold,
                          ),
                          activeIndex == index
                              ? const SizedBox()
                              : CustomButtom(
                                  borderColor: Colors.transparent,
                                  borderRadius: 5.0,
                                  buttonColor:
                                      index == 4 ? Colors.grey : Colors.amber,
                                  buttonText: 'Active',
                                  buttonTextColor: Colors.white,
                                  fontSize: 12,
                                  hasImage: false,
                                  height: 30.0,
                                  horizontal: 10.0,
                                  vertical: 4.0,
                                  imageUrl: '',
                                  onTap: () => {},
                                ),
                        ],
                      ),
                activeIndex == index
                    ? SmartTradeListItemBody(
                        activeIndex: activeIndex,
                        edit: edit,
                        delete: delete,
                        status: status,
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}