import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:umrahcar_driver/models/driver_status_model.dart';

import '../../models/pending_transaction_model.dart';
import '../../service/rest_api_service.dart';
import '../../utils/const.dart';
import '../../widgets/navbar.dart';
import '../add_card_page.dart';
import '../homepage_screen.dart';

class PendingTransactionPage extends StatefulWidget {
  const PendingTransactionPage({super.key});

  @override
  State<PendingTransactionPage> createState() => _PendingTransactionPageState();
}

class _PendingTransactionPageState extends State<PendingTransactionPage> {
  PendingTransactiontModel summaryAgentModel = PendingTransactiontModel();
  getSummaryAgent() async {
    print("userIdId $userId");
    var mapData = {"users_drivers_id": userId.toString()};
    summaryAgentModel = await DioClient().pendingTransactions(mapData, context);
    if (summaryAgentModel.data != null) {
      print(
          "getProfileResponse name: ${summaryAgentModel.data![0].usersDriversAccountsId}");
    }
    setState(() {});
  }

  @override
  void initState() {
    getSummaryAgent();
    // TODO: implement initState
    super.initState();
  }
DriverStatusModel deleteTransaction=DriverStatusModel();
  Future<void> _showAlertDialog(String? id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('Delete Transaction'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want to Delete Transaction?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {});
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {

                var jsonData = {"users_drivers_accounts_id": "$id"};
                deleteTransaction= await DioClient().deleteTransaction(jsonData, context);
                if(deleteTransaction.message!=null){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${deleteTransaction.message}")));
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => NavBar(indexNmbr: 3,walletPage: 2,)),
                          (Route<dynamic> route) => false);
                setState(() {

                });
                }

              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        body: summaryAgentModel.data != null
            ? ListView.builder(
                itemCount: summaryAgentModel.data!.length,
                itemBuilder: (BuildContext context, i) {
                  final flavor = summaryAgentModel.data![i];
                  return Column(children: [
                    Slidable(
                      key: const ValueKey(0),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) async {
                              _showAlertDialog(summaryAgentModel
                                  .data![i].usersDriversAccountsId);
                              setState(() {

                              });
                            },
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                                "$imageUrl${summaryAgentModel.data![i].image}"),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 175,
                                child: Text(
                                  "Txn Type: ${summaryAgentModel.data![i].txnType!}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                     fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: size.height * 0.005),
                              Text(
                                "amount: ${summaryAgentModel.data![i].amount!}",
                                style: const TextStyle(
                                  color: Color(0xFF565656),
                                  fontSize: 10,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: size.height * 0.005),
                              Text(
                                "description: ${summaryAgentModel.data![i].description!}",
                                style: const TextStyle(
                                  color: Color(0xFF565656),
                                  fontSize: 10,
                                   fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: size.height * 0.005),
                              Text(
                                "date: ${summaryAgentModel.data![i].txnDate!}",
                                style: const TextStyle(
                                  color: Color(0xFF565656),
                                  fontSize: 10,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: size.height * 0.005),
                              Text(
                                "Accounts Head Name: ${summaryAgentModel.data![i].accountsHeadsId!.name!}",
                                style: const TextStyle(
                                  color: Color(0xFF565656),
                                  fontSize: 10,
                                   fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: size.height * 0.005),
                              Text(
                                "Driver Name: ${summaryAgentModel.data![i].usersDriversId!.name!}",
                                style: const TextStyle(
                                  color: Color(0xFF565656),
                                  fontSize: 10,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: size.height * 0.005),
                              Text(
                                "Company Name: ${summaryAgentModel.data![i].usersDriversId!.companyName!}",
                                style: const TextStyle(
                                  color: Color(0xFF565656),
                                  fontSize: 10,
                                   fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.02),
                          Container(
                            width: size.width * 0.2,
                            height: size.height * 0.024,
                            margin: const EdgeInsets.only(left: 20),
                            child: Text(
                              summaryAgentModel.data![i].status!,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 225, 240, 14),
                                fontSize: 12,
                               fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ]);
                })
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 100),
                    child: Text(
                      'No Pending Transaction Found',
                      style: TextStyle(
                        color: Color(0xFF565656),
                        fontSize: 12,
                         fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ));
  }
}
