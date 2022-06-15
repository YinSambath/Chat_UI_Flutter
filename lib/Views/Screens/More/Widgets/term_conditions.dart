import 'package:flutter_svg/flutter_svg.dart';
import 'package:mcircle_project_ui/chat_app.dart';

class TermCondition extends StatelessWidget {
  TermCondition({Key? key}) : super(key: key);
  final backgroundColor = Color.fromRGBO(248, 248, 248, 1);
  final black = Colors.black;
  final white = Colors.white;
  final pink = Colors.pink;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: ScrollController(),
        child: Container(
          width: 820,
          child: Scrollbar(
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      height: 40,
                      width: 800,
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Term & Conditions",
                        style: TextStyle(
                          color: black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 800,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "These terms and conditions (the Terms & Conditions) contain set of obligations as listed by the owner of MCircle platform (the Owner) which shall bind each user (the User) of MCircel platform (the Platform). Each User is required to accept these Terms & Conditions as a whole, otherwise, the User must not use the Platform.",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "I.  SCOPE OF APPLICABILITY OF THE TERMS & CONDITIONS These Terms & Conditions are applicable to the use of the Platform, as users and owner of the page (the User). All structure of, and form of page (Page) and account (Account) on, the Platform and all instructions thereon constitute forming part of these Terms & Conditions.",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "II.  PROPRIETARY RIGHT OVER THE TERMS & CONDITIONS The Platform is under the sole and exclusive ownership and intellectual proprietary right of the Owner. The Owner reserves the right to make changes to or abolish the Platform and/or these Terms & Conditions at its sole discretion without prior notice to the User and to which no User shall be entitled to make objection.",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "III.  INTENDED USE OF THE TERMS & CONDITIONS \n\n3.1  General: The purpose of use of the Platform is to MCircle was built on an aspiration to provide users a smart application to handle and process hiring in an organized and structured fashions that will save users a lot time and money. Now it’s a lot easier for users (recruiters) to post job opportunities themselves, keep tracks of every posting activities, manage their posting and engage with applicants directly. Other users (job seekers) are able to use smart search tools to get to specific jobs they like to get. Both recruiters and job seekers can engage directly on the platforms in a meaningful way.",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                " 3.2  Use Case by Users The Platform was intended for Users to share information considered useful for economic, trade or commerce activities especially job opportunity and hiring.",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                " 3.3  Prohibited Use: User may only use the Platform for the Intended Use as provided under the Clauses 10.1 and 10.2. Below are illustrative but not limitative examples of prohibited use of the Platform:",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "•  Violating the law and regulations in force, theses Terms & Conditions, morality, social order or aiming to attack or violate any person’s right;\n•  Infringing intellectual proprietary right, trademark, tangible or intangible property, trade secret and other similar form of infringement/violation;",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "•  Posting phone number, address or name or other private information of any person without due authorization;",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "•  Posting any content with malicious intent, antisocial act or affecting smooth functioning of the Platform or deviating from the Intended Use thereof;",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "•  Contacting to Consumer for more than once a month or in contradiction to the principles as laid down by the Owner;",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "•  Participating in any act which causes obstruction to other’s use or enjoyment of the Platform;",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "•  Instigating or encouraging others to participate in any prohibited use as listed above.",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "IV.  MANNER OF USE OF THE TERMS & CONDITIONS",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "4.1  Creation of Account",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "4.1.1  User must provide information and meet all requirements as instructed at the creation of the Account.",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "4.2  Management of Account",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "4.2.1  User has to use the Account her/himself. For legal entity, the Account must be managed by duly appointed personnel to that effect.",
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "4.2.2  User may only post information matching with the rubrics as indicated on their Page.",
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "4.2.10  Information updating must not affect its credibility, such as irregularly too frequent updates.",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "V.  RELATIONSHIP BETWEEN CONSUMER AND RESTAURANT VIA THE USE OF THE PLATFORM",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "5.1  Level of Responsibility of the Platform\n\n5.1.1  It’s expected that there will be some degrees of engagement that leads business tractions among Users which could either be in form of recruiter and job seeker or buyer or seller.  Performance or non-performance of such transaction shall not cause any responsibility or liability whatsoever against the Owner; yet, this shall not prejudice the Owner’s rights as provided under these Terms & Conditions.",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "5.1.2  The Owner shall neither be liable to any User or third party, nor be taken as in breach hereof, for any problem or malfunctioning of the Platform, including but not limited to:",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "a.  Delay or unsmooth functioning of the Platform due to internet or problem of the device or negligence or incorrect use of the Platform by the Users, including without limitation to failure to update the device;",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "b.  Uncertainty or inaccuracy of any information of any User or failure to contact to any User due to a problem not caused by the Platform;",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "c.  Closure or suspension of functioning of the Platform whether in whole or in part due to attack on the system of the Platform or attack from third party or by virus which happens in cyber space;",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "d.  Force Majeure, including but not limited to flood, storm, riot, strike, pandemics, etc.",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "e.  Loss of personal data or information on the Page due the negligence or fault of the User;",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "f.  Non-compliance or ceasing of compliance with the law and regulation of the Users on the Platform or inexistence of the right to purchase of any Consumer;",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "g.  Fake profile on any Account;",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "h.  Delay or non-performance of delivery.",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "5.2  Inexistence of Exclusivity and/or special privilege: Each User enjoy the same rights and obligations in the use of the Platform and no User is entitled to exclusive or priority right or any special privilege in the use of the Platform. Likewise, competing Users may be found on the Platform.",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "5.10  Dispute: All disputes arisen from the business (hiring or sale-purchase) transaction shall be resolved by the Users themselves, and the Owner shall not get involved therein or be liable/responsible therefor to any extent whatsoever.",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "VI.  REPRESENTATIONS AND WARRANTIES",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 1.5),
                              Text(
                                "Each and all Users represent and warrant to the Owner, that:",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "a.  Each User has lawful right to create Account on the Platform and/or provide information and/or use the Platform and/or enter into sale-purchase transaction or perform their obligation as per such transaction;",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "b.  All information provided to the Owner via the Platform and/or shown on their Page and/or provided in the process of the Platform, is true and accurate;",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "c.  All Pages (business page) registered in the Account are lawful and conduct lawful activities;",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "d.  All Users shall resolve all disputes arisen from the hiring (sale-purchase) transaction by themselves and shall not allow such disputes to affect the Owner and/or the Platform to any extent whatsoever; where such dispute affects the Owner/Platform, the relevant Users shall indemnify and compensate the Owner against all damages;",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "VII.  MEASURES FROM THE OWNER",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "7.1  Where any User breaches any provisions hereof, the Owner reserves the right to take the followings measures at its sole discretion:",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "a.  Close the Account and/or terminate membership of the User promptly without prior notice;",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "b.  Take other measures as the Owner deems fit to ensure sustainability of the Platform and protect relevant rights at stage;",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "c.  Conduct investigation or cause investigation to be conducted vis-à-vis any complaints as to breach of these Terms & Conditions to the extent Aas authorized by the law;",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "d.  Delete or adjust the contents which breaches this Terms & Conditions, the law or which causes disturbance or non-compliance to these Terms & Conditions;",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "7.2   Whether there be any breach or not of these Terms & Conditions, the Owner is entitled to demolish the whole Platform as it deems necessary at its sole discretion.",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "7.10  Exercise by the Owner of the discretion as provided under the Clauses 7.1 and 7.2 shall not be considered as fault or, or trigger any labilities whatsoever to any User/third party against, the Owner",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "VIII.  Provisions on Private Data and Information",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "8.1  General Information: With the creation of the Account and use of the Platform, the Owner shall collect relevant data and information that User may enter or which arises from transaction/processing of the Platform in order to provide facilitation and convenience to the User as well as to enhance effectiveness of the Platform, including but not limited to name, address, email, phone numbers, password, location on the map, photo, logos, stock, lists of items, personnel in charge, etc",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "8.2  Cookies: The Owner is entitled to collect cookies left by the User in order to facilitate the search and functioning of the Platform, save for the case where a User elects to block all cookies via setting of the search engine of the User.",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "8.10  Protection of Information: All information as provided under the Clauses 8.1 and 8.2 shall be protected from being disclosed to third party without consent from the relevant User. The Owner applies a certain number of necessary measures to protect the information of the Users from hacks as well as other cyber security with best efforts. For the matter of certainty, the Owner shall not warrant full protection of the information as provided above.",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "8.4  Exception from Protection of Information: The Owner is relieved from obligation of protection of the information as provided under the Clause 8.10 where:",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "a.  Consented by the owner of the Information;",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "b.  The information become public domain by means which do not imply any fault from the Owner. Publication/posting of information on the Page of the User on the Platform is considered a waiver of the User from protection of such information;",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "c.  Information required to be disclosed by law, regulations, relevant public authorities, court or competent police officer; or",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "d.  The use of information within the process of investigation on breach hereof.",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "IX.  GENERAL PROVISION",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "9.1  Severability: Where any provision of these Terms & Conditions is found to be invalid or unenforceable by any reason, such provision shall not affect the validity and enforceability of other provision of these Terms & Conditions",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "9.2  Amendment: These Terms & Conditions are effective and binding vis-à-vis all Users and may be amended or adjusted or improved or abolished or updated on unilateral basis by the Owner at its sole discretion without prior notice to the User and without any Users being entitled to make objection thereto.",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "9.3  Governing Law: These Terms & Conditions are under the law of the Kingdom of Cambodia.",
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
