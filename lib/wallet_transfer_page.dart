import 'package:etherwallet/components/wallet/transfer_form.dart';
import 'package:etherwallet/context/transfer/wallet_transfer_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'components/wallet/loading.dart';

class WalletTransferPage extends HookWidget {
  const WalletTransferPage({Key key,  this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final transferStore = useWalletTransfer(context);
    final qrcodeAddress = useState('');

    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: !transferStore.state.loading
                ? () {
                    Navigator.of(context).pushNamed(
                      '/qrcode_reader',
                      arguments: (scannedAddress) {
                        qrcodeAddress.value = scannedAddress.toString();
                      },
                    );
                  }
                : null,
          ),
        ],
      ),
      body: transferStore.state.loading
          ? const Loading()
          : TransferForm(
              address: qrcodeAddress.value,
              onSubmit: (address, amount) async {
                final success = await transferStore.transfer(address, amount);

                if (success) {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                }
              },
            ),
    );
  }
}
