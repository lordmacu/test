import 'package:etherwallet/components/copyButton/copy_button.dart';
import 'package:etherwallet/utils/eth_amount_formatter.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Balance extends StatelessWidget {
  const Balance({
    Key key,
     this.address,
     this.ethBalance,
     this.tokenBalance,
  }) : super(key: key);

  final String address;
  final BigInt ethBalance;
  final BigInt tokenBalance;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(address ?? ''),
          CopyButton(
            text: const Text('Copy address'),
            value: address,
          ),
          if (address != null)
            QrImage(
              data: address,
              size: 150.0,
            ),
          Text(
            '${EthAmountFormatter(tokenBalance).format()} tokens',
            style:
                Theme.of(context).textTheme.bodyText2?.apply(fontSizeDelta: 6),
          ),
          Text(
            '${EthAmountFormatter(ethBalance).format()} eth',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.apply(color: Colors.blueGrey),
          )
        ],
      ),
    );
  }
}
