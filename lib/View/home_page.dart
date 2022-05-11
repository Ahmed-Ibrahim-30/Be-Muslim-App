import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kf_drawer/kf_drawer.dart';
import '../Model/Calculate_AM_PM.dart';
import 'Container.dart';
import '../Model/Functions.dart';
import '../Model/UserSimplePreferences.dart';
import '../Model/Variable_declarations.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class Home_Page extends KFDrawerContent {
  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  TimeOfDay timeOfDay = TimeOfDay.now();
  Timer timer;

  initState()  {
    retrieve_information();
    retrievelocation();
    int last_index=0,count=0; bool enter=false;
    super.initState();
    timer=Timer.periodic(Duration(seconds: 1), (timer) {
      if (second != DateTime.now().second) {
        setState(() {
          if(enter)count++;
          time_now = DateFormat('HH:mm:ss').format(DateTime.now());
          last_index=min[0];
          min=difference(time_now);
          if(last_index!=min[0])colors[last_index]=Colors.white70;
          diff=59-DateTime.now().second;
          time_now=Calculate_time(diff, min[1], min[2]);
          if(min[0]==0) {
            Pray="صلاه الفجر";
            Is_AM_PM=true;
          }
          else if(min[0]==1) {
            Pray="الشروق";
            Is_AM_PM=false;
          }
          else if(min[0]==2) {
            Pray="صلاه الظهر";
            Is_AM_PM=false;
          }
          else if(min[0]==3) {
            Pray="صلاه العصر";
            Is_AM_PM=false;
          }
          else if(min[0]==4) {
            Pray="صلاه المغرب";
            Is_AM_PM=true;
          }
          else if(min[0]==5) {
            Pray="صلاه العشاء";
            Is_AM_PM=true;
          }
          if(time_now=='00:00:00' && min[0]!=1 && !enter){
            default_layout=1;
            Pray_index=min[0];
            count=0; enter=true;
            AudioCache player=new AudioCache(prefix: 'sound/');
            if(Pray_index==0) {player.play('Fajr.mp3'); sound_duration=232;}
            else if(Pray_index==2 ) {player.play('adhan.mp3'); sound_duration=210;}
            else if(Pray_index==3 ) {player.play('adhan1.mp3'); sound_duration=250;}
            else if(Pray_index==4 ||Pray_index==5) {player.play('adhan2.mp3'); sound_duration=127;}
          }
          if(time_now=='00:00:00'  && !enter){
            if(min[0]==1||min[0]==2||min[0]==3)AM(min[0]);
            else PM(min[0]);
          }
          if(sound_duration==count){
            default_layout=0;
            enter=false;
            count=0;
          }
        }
        );
      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var duhur=timer_Pray[2].split(":"); int duhur_hour=num.parse(duhur[0]);
    String Dhuhr_period = duhur_hour < 12 ? "AM" : "PM";
    return SafeArea(
      child: Scaffold(
        body: default_layout==0?Container(
          decoration: BoxDecoration(
            color: const Color(0xff7c94b6),
                image: DecorationImage(
                  image: new ExactAssetImage(backgroundimage),
                  colorFilter: new ColorFilter.mode(background_color, BlendMode.dstATop),
                  fit: BoxFit.cover,
                ),
          ),
          child: Stack(
            children: [
              Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: height*0.008,horizontal:width*0.023 ),
                        child: lastUpdatesContainer(Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Builder(
                                builder: (context) => IconButton(
                                  icon: Icon(Icons.menu_rounded),
                                  onPressed: widget.onMenuPressed,
                                ),
                            ),
                            Center(
                              child: ScaleAnimatedTextKit(
                                text: [
                                  "سبــحـــان  الـلـــه",
                                  "الحـــمــد  الــلــه",
                                  "صـــلــي عـلـي الـنـبـي",
                                  "لا اله إلا الله",
                                  "الــلــه   أكـــبــر"
                                ],
                                duration: Duration(seconds: 6),
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'ArefRuqaa',
                                    fontSize: width * 0.069+height*0.009,
                                    color: Colors.pink
                                ),
                              ),
                            ),
                            ImageIcon(
                              AssetImage("Images/img1.png"),
                              color: Colors.blue,
                              size: height * 0.038+width*0.008,
                            ),
                          ],
                        ),Appbar_background)
                      ),
                      Center(
                        child: Column(
                          children: [
                            SizedBox(height: height*0.040,),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: height*0.007,horizontal: width*0.009),
                              child: Column(
                                children: [
                                  future("AM","الفجر",colors[0],width,height,0),
                                  future("AM","الشروق",colors[1],width,height,1),
                                  future("${Dhuhr_period}","الظهر",colors[2],width,height,2),
                                  future("PM","العصر",colors[3],width,height,3),
                                  future("PM","المغرب",colors[4],width,height,4),
                                  future("PM","العشاء",colors[5],width,height,5)
                                ],
                              ),
                            ),
                          ],
                        ))
                    ],
                  ),
                ],
              ),
              DraggableScrollableSheet(
                  initialChildSize: 0.28,
                  builder: (context, scrollController) {
                    return Container(
                      alignment: Alignment.center,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(width*0.18),
                        image: DecorationImage(
                          image:AssetImage(background_small),
                          colorFilter: new ColorFilter.mode(Colors.red.withOpacity(0.6), BlendMode.dstOut),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding:
                        EdgeInsets.only(top: height*0.009, left: 20, right: 20),
                        child: ListView(
                          controller: scrollController,
                          children: [
                            container("باقي علي $Pray", remain_color, width,height),
                            container_time(time_now, Colors.black87,width,height),
                            Container(
                                margin: EdgeInsets.fromLTRB(width*0.0045, height*0.0045, 0, 0),
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.blue,
                                      size: height * 0.03+width*0.003,
                                    ),
                                    getlocation(),
                                  ],
                                )),
                            SizedBox(height: height*0.09,),
                            Container(
                              alignment: Alignment.center,
                              child: TypewriterAnimatedTextKit(
                                text: [
                                  "أَتَخْشَوْنَهُمْ فَاللَّهُ أَحَقُّ أَن تَخْشَوْهُ إِن كُنتُم مُّؤْمِنِينَ",
                                  "أَمْ حَسِبْتُمْ أَن تَدْخُلُوا الْجَنَّةَ وَلَمَّا يَأْتِكُم مَّثَلُ الَّذِينَ خَلَوْا مِن قَبْلِكُم  مَّسَّتْهُمُ الْبَأْسَاءُ وَالضَّرَّاءُ وَزُلْزِلُوا حَتَّىٰ يَقُولَ الرَّسُولُ وَالَّذِينَ آمَنُوا مَعَهُ مَتَىٰ نَصْرُ اللَّهِ أَلَا إِنَّ نَصْرَ اللَّهِ قَرِيبٌ",
                                  "أَلَمْ يَأْنِ لِلَّذِينَ آمَنُوا أَن تَخْشَعَ قُلُوبُهُمْ لِذِكْرِ اللَّهِ وَمَا نَزَلَ مِنَ الْحَقِّ وَلَا يَكُونُوا كَالَّذِينَ أُوتُوا الْكِتَابَ مِن قَبْلُ فَطَالَ عَلَيْهِمُ الْأَمَدُ فَقَسَتْ قُلُوبُهُمْ ۖ وَكَثِيرٌ مِّنْهُمْ فَاسِقُونَ",
                                  "وَاصْبِرْ نَفْسَكَ مَعَ الَّذِينَ يَدْعُونَ رَبَّهُمْ بِالْغَدَاةِ وَالْعَشِيِّ يُرِيدُونَ وَجْهَهُ وَلَا تَعْدُ عَيْنَاكَ عَنْهُمْ تُرِيدُ زِينَةَ الْحَيَاةِ الدُّنْيَا وَلَا تُطِعْ مَنْ أَغْفَلْنَا قَلْبَهُ عَنْ ذِكْرِنَا وَاتَّبَعَ هَوَاهُ وَكَانَ أَمْرُهُ فُرُطًا ",
                                  "وَلَا تَحْسَبَنَّ اللَّهَ غَافِلًا عَمَّا يَعْمَلُ الظَّالِمُونَ ۚ إِنَّمَا يُؤَخِّرُهُمْ لِيَوْمٍ تَشْخَصُ فِيهِ الْأَبْصَارُ",
                                  "وَأَنْذِرْهُمْ يَوْمَ الْحَسْرَةِ إِذْ قُضِيَ الْأَمْرُ وَهُمْ فِي غَفْلَةٍ وَهُمْ لَا يُؤْمِنُونَ "
                                  "إِنَّ الَّذِينَ أَجْرَمُوا كَانُوا مِنَ الَّذِينَ آمَنُوا يَضْحَكُونَ ۝ وَإِذَا مَرُّوا بِهِمْ يَتَغَامَزُونَ ۝ وَإِذَا انْقَلَبُوا إِلَى أَهْلِهِمُ انْقَلَبُوا فَكِهِينَ ۝ وَإِذَا رَأَوْهُمْ قَالُوا إِنَّ هَؤُلاءِ لَضَالُّونَ ۝ وَمَا أُرْسِلُوا عَلَيْهِمْ حَافِظِينَ ۝ فَالْيَوْمَ الَّذِينَ آمَنُوا مِنَ الْكُفَّارِ يَضْحَكُونَ ۝ عَلَى الأَرَائِكِ يَنْظُرُونَ ۝ هَلْ ثُوِّبَ الْكُفَّارُ مَا كَانُوا يَفْعَلُونَ",
                                  "يَا أَيُّهَا النَّاسُ إِنَّ وَعْدَ اللَّهِ حَقٌّ فَلَا تَغُرَّنَّكُمُ الْحَيَاةُ الدُّنْيَا وَلَا يَغُرَّنَّكُمْ بِاللَّهِ الْغَرُورُ ",
                                  "وَمَا كَانَ قَوْلَهُمْ إِلَّا أَن قَالُوا رَبَّنَا اغْفِرْ لَنَا ذُنُوبَنَا وَإِسْرَافَنَا فِي أَمْرِنَا وَثَبِّتْ أَقْدَامَنَا وَانصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ ۝ فَآتَاهُمُ اللَّهُ ثَوَابَ الدُّنْيَا وَحُسْنَ ثَوَابِ الْآخِره وَاللَّهُ يُحِبُّ الْمُحْسِنِينَ",
                                  "وَقَالَ مُوسَى رَبَّنَآ إِنَّكَ ءَاتَيْتَ فِرْعَوْنَ وَمَلأَهُ زِينَةً وَأَمْوَالاً فِي الْحَيَاةِ الدُّنْيَا رَبَّنَا لِيُضِلُّوا عَن سَبِيلِكَ رَبَّنَا اطْمِسْ عَلَى أَمْوَالِهِمْ وَاشْدُدْ عَلَى قُلُوبِهِمْ فَلا يُؤْمِنُوا حَتَّى يَرَوُا الْعَذَابَ الاَلِيمَ",
                                  "إِنَّ الَّذِينَ يُؤْذُونَ اللَّهَ وَرَسُولَهُ لَعَنَهُمُ اللَّهُ فِي الدُّنْيَا وَالْآخِرَةِ وَأَعَدَّ لَهُمْ عَذَابًا مُّهِينًا ۝ وَالَّذِينَ يُؤْذُونَ الْمُؤْمِنِينَ وَالْمُؤْمِنَاتِ بِغَيْرِ مَا اكْتَسَبُوا فَقَدِ احْتَمَلُوا بُهْتَانًا وَإِثْمًا مُّبِينًا ",
                                  " يَا أَيُّهَا النَّبِيُّ قُل لِّأَزْوَاجِكَ وَبَنَاتِكَ وَنِسَاءِ الْمُؤْمِنِينَ يُدْنِينَ عَلَيْهِنَّ مِن جَلَابِيبِهِنَّ ۚ ذَٰلِكَ أَدْنَىٰ أَن يُعْرَفْنَ فَلَا يُؤْذَيْنَ وَكَانَ اللَّهُ غَفُورًا رَّحِيمًا ۝ ۞ لَّئِن لَّمْ يَنتَهِ الْمُنَافِقُونَ وَالَّذِينَ فِي قُلُوبِهِم مَّرَضٌ وَالْمُرْجِفُونَ فِي الْمَدِينَةِ لَنُغْرِيَنَّكَ بِهِمْ ثُمَّ لَا يُجَاوِرُونَكَ فِيهَا إِلَّا قَلِيلًا ۝ مَّلْعُونِينَ أَيْنَمَا ثُقِفُوا أُخِذُوا وَقُتِّلُوا تَقْتِيلًا ۝ سُنَّةَ اللَّهِ فِي الَّذِينَ خَلَوْا مِن قَبْلُ ۖ وَلَن تَجِدَ لِسُنَّةِ اللَّهِ تَبْدِيلًا ",
                                  "يَسْأَلُكَ النَّاسُ عَنِ السَّاعهۖ قُلْ إِنَّمَا عِلْمُهَا عِندَ اللَّهِ ۚ وَمَا يُدْرِيكَ لَعَلَّ السَّاعَةَ تَكُونُ قَرِيبًا ۝ إِنَّ اللَّهَ لَعَنَ الْكَافِرِينَ وَأَعَدَّ لَهُمْ سَعِيرًا ۝ خَالِدِينَ فِيهَا أَبَدًا ۖ لَّا يَجِدُونَ وَلِيًّا وَلَا نَصِيرًا ۝ يَوْمَ تُقَلَّبُ وُجُوهُهُمْ فِي النَّارِ يَقُولُونَ يَا لَيْتَنَا أَطَعْنَا اللَّهَ وَأَطَعْنَا الرَّسُولَا ۝ وَقَالُوا رَبَّنَا إِنَّا أَطَعْنَا سَادَتَنَا وَكُبَرَاءَنَا فَأَضَلُّونَا السَّبِيلَا ۝ رَبَّنَا آتِهِمْ ضِعْفَيْنِ مِنَ الْعَذَابِ وَالْعَنْهُمْ لَعْنًا كَبِيرًا",
                                  "يَا أَيُّهَا الَّذِينَ آمَنُوا لَا تَكُونُوا كَالَّذِينَ آذَوْا مُوسَىٰ فَبَرَّأَهُ اللَّهُ مِمَّا قَالُوا ۚ وَكَانَ عِندَ اللَّهِ وَجِيهًا ۝ يَا أَيُّهَا الَّذِينَ آمَنُوا اتَّقُوا اللَّهَ وَقُولُوا قَوْلًا سَدِيدًا۝يُصْلِحْ لَكُمْ أَعْمَالَكُمْ وَيَغْفِرْ لَكُمْ ذُنُوبَكُمْ ۗ وَمَن يُطِعِ اللَّهَ وَرَسُولَهُ فَقَدْ فَازَ فَوْزًا عَظِيمًا",
                                  "۞ قَالَ قَرِينُهُ رَبَّنَا مَا أَطْغَيْتُهُ وَلَٰكِن كَانَ فِي ضَلَالٍ بَعِيدٍ ۝ قَالَ لَا تَخْتَصِمُوا لَدَيَّ وَقَدْ قَدَّمْتُ إِلَيْكُم بِالْوَعِيدِ ۝ مَا يُبَدَّلُ الْقَوْلُ لَدَيَّ وَمَا أَنَا بِظَلَّامٍ لِّلْعَبِيدِ ۝ يَوْمَ نَقُولُ لِجَهَنَّمَ هَلِ امْتَلَأْتِ وَتَقُولُ هَلْ مِن مَّزِيدٍ ۝ وَأُزْلِفَتِ الْجَنَّةُ لِلْمُتَّقِينَ غَيْرَ بَعِيدٍ ۝ هَٰذَا مَا تُوعَدُونَ لِكُلِّ أَوَّابٍ حَفِيظٍ ۝ مَّنْ خَشِيَ الرَّحْمَٰنَ بِالْغَيْبِ وَجَاءَ بِقَلْبٍ مُّنِيبٍ ۝ ادْخُلُوهَا بِسَلَامٍ ۖ ذَٰلِكَ يَوْمُ الْخُلُودِ ۝ لَهُم مَّا يَشَاءُونَ فِيهَا وَلَدَيْنَا مَزِيدٌ ",
                                  " مَّا يَلْفِظُ مِن قَوْلٍ إِلَّا لَدَيْهِ رَقِيبٌ عَتِيدٌ ۝ وَجَاءَتْ سَكْرَةُ الْمَوْتِ بِالْحَق ذَٰلِكَ مَا كُنتَ مِنْهُ تَحِيدُ ۝ وَنُفِخَ فِي الصُّورِ ۚ ذَٰلِكَ يَوْمُ الْوَعِيدِ ۝ وَجَاءَتْ كُلُّ نَفْسٍ مَّعَهَا سَائِقٌ وَشَهِيدٌ ۝ لَّقَدْ كُنتَ فِي غَفْلَةٍ مِّنْ هَٰذَا فَكَشَفْنَا عَنكَ غِطَاءَكَ فَبَصَرُكَ الْيَوْمَ حَدِيدٌ ۝ وَقَالَ قَرِينُهُ هَٰذَا مَا لَدَيَّ عَتِيدٌ ۝ أَلْقِيَا فِي جَهَنَّمَ كُلَّ كَفَّارٍ عَنِيدٍ ۝ مَّنَّاعٍ لِّلْخَيْرِ مُعْتَدٍ مُّرِيبٍ ۝ الَّذِي جَعَلَ مَعَ اللَّهِ إِلَٰهًا آخَرَ فَأَلْقِيَاهُ فِي الْعَذَابِ الشَّدِيدِ ۝",
                                  "أَتَخْشَوْنَهُمْ ۚ فَاللَّهُ أَحَقُّ أَن تَخْشَوْهُ إِن كُنتُم مُّؤْمِنِينَ",
                                  "وَذَرِ الَّذِينَ اتَّخَذُوا دِينَهُمْ لَعِبًا وَلَهْوًا وَغَرَّتْهُمُ الْحَيَاةُ الدُّنْياَۚ وَذَكِّرْ بِهِ أَن تُبْسَلَ نَفْسٌ بِمَا كَسَبَتْ لَيْسَ لَهَا مِن دُونِ اللَّهِ وَلِيٌّ وَلَا شَفِيعٌ وَإِن تَعْدِلْ كُلَّ عَدْلٍ لَّا يُؤْخَذْ مِنْهَا أُولَٰئِكَ الَّذِينَ أُبْسِلُوا بِمَا كَسَبُوا لَهُمْ شَرَابٌ مِّنْ حَمِيمٍ وَعَذَابٌ أَلِيمٌ بِمَا كَانُوا يَكْفُرُونَ",
                                  "وَإِذَا كُنْتَ فِيهِمْ فَأَقَمْتَ لَهُمُ الصَّلَاةَ فَلْتَقُمْ طَائِفَةٌ مِنْهُمْ مَعَكَ وَلْيَأْخُذُوا أَسْلِحَتَهُمْ فَإِذَا سَجَدُوا فَلْيَكُونُوا مِنْ وَرَائِكُمْ وَلْتَأْتِ طَائِفَةٌ أُخْرَى لَمْ يُصَلُّوا فَلْيُصَلُّوا مَعَكَ وَلْيَأْخُذُوا حِذْرَهُمْ وَأَسْلِحَتَهُمْ ۗ وَدَّ الَّذِينَ كَفَرُوا لَوْ تَغْفُلُونَ عَنْ أَسْلِحَتِكُمْ وَأَمْتِعَتِكُمْ فَيَمِيلُونَ عَلَيْكُمْ مَيْلَةً وَاحِدَةً ۚ وَلَا جُنَاحَ عَلَيْكُمْ إِنْ كَانَ بِكُمْ أَذًى مِنْ مَطَرٍ أَوْ كُنْتُمْ مَرْضَى أَنْ تَضَعُوا أَسْلِحَتَكُمۖ وَخُذُوا حِذْرَكُمْ إِنَّ اللَّهَ أَعَدَّ لِلْكَافِرِينَ عَذَابًا مُهِينًا",
                                  "وَإِنْ يَرَوْا كُلَّ آيَةٍ لَا يُؤْمِنُوا بِهَا وَإِنْ يَرَوْا سَبِيلَ الرُّشْدِ لَا يَتَّخِذُوهُ سَبِيلًا وَإِنْ يَرَوْا سَبِيلَ الْغَيِّ يَتَّخِذُوهُ سَبِيلًا ۚ ذَلِكَ بِأَنَّهُمْ كَذَّبُوا بِآيَاتِنَا وَكَانُوا عَنْهَا غَافِلِينَ ",
                                ],
                                duration: Duration(seconds:700),
                                textAlign: TextAlign.center,
                                textStyle: TextStyle(
                                    shadows: [
                                      Shadow(
                                          blurRadius: 19,
                                          color: Colors.blueAccent

                                      )
                                    ],
                                    color: Colors.yellow,
                                    fontSize: width*0.05,
                                    fontFamily: "font6"
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ):Layout(Pray_index,width,height),
      ),
    );
  }
}