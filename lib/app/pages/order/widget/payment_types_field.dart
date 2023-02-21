import 'package:dw9_delivery_app/app/core/ui/helpers/size_extensions.dart';
import 'package:dw9_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:dw9_delivery_app/app/models/payment_type_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';

class PaymentTypesField extends StatelessWidget {
  final List<PaymentTypeModel> paymentTypes;

  const PaymentTypesField({super.key, required this.paymentTypes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Forma de Pagamento", style: context.textStyles.textRegular.copyWith(fontSize: 16)),
          SmartSelect<String>.single(
            title: '',
            selectedValue: '',
            modalType: S2ModalType.bottomSheet,
            onChange: (value) {},
            tileBuilder: (context, state) {
              return InkWell(
                onTap: state.showModal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: context.screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            state.selected.title ?? 'Selecione uma forma de pagamento',
                            style: context.textStyles.textRegular,
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            choiceItems: S2Choice.listFrom<String, Map<String, String>>(
              source: paymentTypes
                  .map((payment) => {
                        'value': payment.id.toString(),
                        'title': payment.name,
                      })
                  .toList(),
              title: ((index, item) => item['title'] ?? ''),
              value: ((index, item) => item['value'] ?? ''),
              group: ((index, item) => 'Selecione uma forma de pagamento'),
            ),
            choiceType: S2ChoiceType.radios,
            choiceGrouped: true,
            modalFilter: false,
            placeholder: '',
          ),
        ],
      ),
    );
  }
}
