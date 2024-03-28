import 'package:flutter/material.dart';
import 'package:umrahcar_driver/screens/wallet_tab/wallet_tabbar.dart';


import '../models/summary_agent_model.dart';
import '../service/rest_api_service.dart';
import '../utils/colors.dart';
import 'add_card_page.dart';
import 'homepage_screen.dart';

class WalletPage extends StatefulWidget {
  int? indexNmbr=0;
   WalletPage({super.key,this.indexNmbr});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  SummaryDriversModel getAgentsWidgetData=SummaryDriversModel();
  getSummaryAgent()async{
    print("userIdId $userId");
    var mapData={
      "users_drivers_id": userId.toString()
    };
    getAgentsWidgetData= await DioClient().summaryAgent(mapData, context);
    if(getAgentsWidgetData.data !=null ) {
      print("getProfileResponse name: ${getAgentsWidgetData.data!.totalDriversBalance}");
    }
    setState(() {

    });
  }


  @override
  void initState() {
    getSummaryAgent();
    print(" widget.indexNmbr: ${ widget.indexNmbr}");
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: mainColor,
        body: getAgentsWidgetData.data !=null ?
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFFB940),
            // image: DecorationImage(
            //   image: AssetImage('assets/images/background.png'),
            //   fit: BoxFit.cover,
            // ),
          ),
          child: Column(
            children: [
              Container(
                color: Colors.transparent,
                width: size.width,
                height: size.height * 0.12,
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      'My Wallet',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w700,
                        fontSize: 26,
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(height: size.height * 0.04),
              Container(
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        bignoimagebox('${getAgentsWidgetData.data!.totalDriversBalance}', 'Wallet Amount', context),
                        SizedBox(width: size.width * 0.04),
                        InkWell(
                            onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddCardPage()));
                            setState(() {

                            });
                            },
                            child: bignoimageredbox('Debit/Credit', 'Transactions', context)),
                      ],
                    ),
                    SizedBox(height: size.height * 0.03),
                 widget.indexNmbr==null?   WalletTabBarScreen(indexNmbr: 0): WalletTabBarScreen(indexNmbr: 1),
                  ],
                ),
              ),
            ],
          ),
        )
            :SizedBox(
          height: MediaQuery.of(context).size.height/1,
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          ),
        ),
      ),
    );
  }
}



Widget bignoimagebox(priceText, titleText, context) {
  return Center(
    child: Container(
      height: MediaQuery.of(context).size.height * 0.09,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        color: const Color(0xfffffb940),
        // gradient: const LinearGradient(
        //   begin: Alignment(-0, -1),
        //   end: Alignment(0.037, 1.01),
        //   colors: [Color(0x84438f01), Color(0xff7cd037)],
        //   stops: [0, 1],
        // ),
        // gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   tileMode: TileMode.clamp,
        //   colors: [
        //     const Color(0xFF438F02).withOpacity(0.52),
        //     const Color(0xFF7DD038),
        //   ],
        // ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: MediaQuery.of(context).size.width * 0.04),
          Text(
            priceText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text(
            titleText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
           fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 8,
            ),
          ),
        ],
      ),
    ),
  );
}
Widget bignoimageredbox(priceText, titleText, context) {
  return Center(
    child: Container(
      height: MediaQuery.of(context).size.height * 0.09,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
       color:   const Color(0xFFDD9519),
        // gradient: const LinearGradient(
        //   begin: Alignment(-0, -1),
        //   end: Alignment(0.037, 1.01),
        //   colors: [Color(0xffE03B3B), Color(0xffBF4242)],
        //   stops: [0, 1],
        // ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: MediaQuery.of(context).size.width * 0.04),
          Text(
            priceText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
               fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text(
            titleText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
               fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 8,
            ),
          ),
        ],
      ),
    ),
  );
}

