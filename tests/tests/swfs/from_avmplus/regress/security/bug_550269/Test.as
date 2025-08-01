/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */
package {import flash.display.MovieClip; public class Test extends MovieClip {}}

import com.adobe.test.Assert;

//     var SECTION = "RegExp";
//     var VERSION = "as3";
//     var TITLE   = "https://bugzilla.mozilla.org/show_bug.cgi?id=550269";


    // CVE-2008-0674: large number of characters with Unicode code points greater than 255
    var utf8RegExp:String = "[^ABCDEFGHIJKLMNOPQRSTUVWXYZÃ€ÃÃ‚ÃƒÃ„Ã…Ã†Ã‡ÃˆÃ‰ÃŠÃ‹ÃŒÃÃŽÃÃÃ‘Ã’Ã“Ã”Ã•Ã–Ã˜Ã™ÃšÃ›ÃœÃÃžÄ€Ä‚Ä„Ä†ÄˆÄŠÄŒÄŽÄÄ’Ä”Ä–Ä˜ÄšÄœÄžÄ Ä¢Ä¤Ä¦Ä¨ÄªÄ¬Ä®Ä°Ä²Ä´Ä¶Ä¹Ä»Ä½Ä¿ÅÅƒÅ…Å‡ÅŠÅŒÅŽÅÅ’Å”Å–Å˜ÅšÅœÅžÅ Å¢Å¤Å¦Å¨ÅªÅ¬Å®Å°Å²Å´Å¶Å¸Å¹Å»Å½ÆÆ‚Æ„Æ†Æ‡Æ‰ÆŠÆ‹ÆŽÆÆÆ‘Æ“Æ”Æ–Æ—Æ˜ÆœÆÆŸÆ Æ¢Æ¤Æ¦Æ§Æ©Æ¬Æ®Æ¯Æ±Æ²Æ³ÆµÆ·Æ¸Æ¼Ç„Ç‡ÇŠÇÇÇ‘Ç“Ç•Ç—Ç™Ç›ÇžÇ Ç¢Ç¤Ç¦Ç¨ÇªÇ¬Ç®Ç±Ç´Ç¶Ç·Ç¸ÇºÇ¼Ç¾È€È‚È„È†ÈˆÈŠÈŒÈŽÈÈ’È”È–È˜ÈšÈœÈžÈ È¢È¤È¦È¨ÈªÈ¬È®È°È²ÈºÈ»È½È¾ÉÎ†ÎˆÎ‰ÎŠÎŒÎŽÎÎ‘Î’Î“Î”Î•Î–Î—Î˜Î™ÎšÎ›ÎœÎÎžÎŸÎ Î¡Î£Î¤Î¥Î¦Î§Î¨Î©ÎªÎ«Ï’Ï“Ï”Ï˜ÏšÏœÏžÏ Ï¢Ï¤Ï¦Ï¨ÏªÏ¬Ï®Ï´Ï·Ï¹ÏºÏ½Ï¾Ï¿Ð€ÐÐ‚ÐƒÐ„Ð…Ð†Ð‡ÐˆÐ‰ÐŠÐ‹ÐŒÐÐŽÐÐÐ‘Ð’Ð“Ð”Ð•Ð–Ð—Ð˜Ð™ÐšÐ›ÐœÐÐžÐŸÐ Ð¡Ð¢Ð£Ð¤Ð¥Ð¦Ð§Ð¨Ð©ÐªÐ«Ð¬Ð­Ð®Ð¯Ñ Ñ¢Ñ¤Ñ¦Ñ¨ÑªÑ¬Ñ®Ñ°Ñ²Ñ´Ñ¶Ñ¸ÑºÑ¼Ñ¾Ò€ÒŠÒŒÒŽÒÒ’Ò”Ò–Ò˜ÒšÒœÒžÒ Ò¢Ò¤Ò¦Ò¨ÒªÒ¬Ò®Ò°Ò²Ò´Ò¶Ò¸ÒºÒ¼Ò¾Ó€ÓÓƒÓ…Ó‡Ó‰Ó‹ÓÓÓ’Ó”Ó–Ó˜ÓšÓœÓžÓ Ó¢Ó¤Ó¦Ó¨ÓªÓ¬Ó®Ó°Ó²Ó´Ó¶Ó¸Ô€Ô‚Ô„Ô†ÔˆÔŠÔŒÔŽÔ±Ô²Ô³Ô´ÔµÔ¶Ô·Ô¸Ô¹ÔºÔ»Ô¼Ô½Ô¾Ô¿Õ€ÕÕ‚ÕƒÕ„Õ…Õ†Õ‡ÕˆÕ‰ÕŠÕ‹ÕŒÕÕŽÕÕÕ‘Õ’Õ“Õ”Õ•Õ–á‚ á‚¡á‚¢á‚£á‚¤á‚¥á‚¦á‚§á‚¨á‚©á‚ªá‚«á‚¬á‚­á‚®á‚¯á‚°á‚±á‚²á‚³á‚´á‚µá‚¶á‚·á‚¸á‚¹á‚ºá‚»á‚¼á‚½á‚¾á‚¿áƒ€áƒáƒ‚áƒƒáƒ„áƒ…á¸€á¸‚á¸„á¸†á¸ˆá¸Šá¸Œá¸Žá¸á¸’á¸”á¸–á¸˜á¸šá¸œá¸žá¸ á¸¢á¸¤á¸¦á¸¨á¸ªá¸¬á¸®á¸°á¸²á¸´á¸¶á¸¸á¸ºá¸¼á¸¾á¹€á¹‚á¹„á¹†á¹ˆá¹Šá¹Œá¹Žá¹á¹’á¹”á¹–á¹˜á¹šá¹œá¹žá¹ á¹¢á¹¤á¹¦á¹¨á¹ªá¹¬á¹®á¹°á¹²á¹´á¹¶á¹¸á¹ºá¹¼á¹¾áº€áº‚áº„áº†áºˆáºŠáºŒáºŽáºáº’áº”áº áº¢áº¤áº¦áº¨áºªáº¬áº®áº°áº²áº´áº¶áº¸áººáº¼áº¾á»€á»‚á»„á»†á»ˆá»Šá»Œá»Žá»á»’á»”á»–á»˜á»šá»œá»žá» á»¢á»¤á»¦á»¨á»ªá»¬á»®á»°á»²á»´á»¶á»¸á¼ˆá¼‰á¼Šá¼‹á¼Œá¼á¼Žá¼á¼˜á¼™á¼šá¼›á¼œá¼á¼¨á¼©á¼ªá¼«á¼¬á¼­á¼®á¼¯á¼¸á¼¹á¼ºá¼»á¼¼á¼½á¼¾á¼¿á½ˆá½‰á½Šá½‹á½Œá½á½™á½›á½á½Ÿá½¨á½©á½ªá½«á½¬á½­á½®á½¯á¾¸á¾¹á¾ºá¾»á¿ˆá¿‰á¿Šá¿‹á¿˜á¿™á¿šá¿›á¿¨á¿©á¿ªá¿«á¿¬á¿¸á¿¹á¿ºá¿»abcdefghijklmnopqrstuvwxyzÂªÂµÂºÃŸÃ Ã¡Ã¢Ã£Ã¤Ã¥Ã¦Ã§Ã¨Ã©ÃªÃ«Ã¬Ã­Ã®Ã¯Ã°Ã±Ã²Ã³Ã´ÃµÃ¶Ã¸Ã¹ÃºÃ»Ã¼Ã½Ã¾Ã¿ÄÄƒÄ…Ä‡Ä‰Ä‹ÄÄÄ‘Ä“Ä•Ä—Ä™Ä›ÄÄŸÄ¡Ä£Ä¥Ä§Ä©Ä«Ä­Ä¯Ä±Ä³ÄµÄ·Ä¸ÄºÄ¼Ä¾Å€Å‚Å„Å†ÅˆÅ‰Å‹ÅÅÅ‘Å“Å•Å—Å™Å›ÅÅŸÅ¡Å£Å¥Å§Å©Å«Å­Å¯Å±Å³ÅµÅ·ÅºÅ¼Å¾Å¿Æ€ÆƒÆ…ÆˆÆŒÆÆ’Æ•Æ™ÆšÆ›ÆžÆ¡Æ£Æ¥Æ¨ÆªÆ«Æ­Æ°Æ´Æ¶Æ¹ÆºÆ½Æ¾Æ¿Ç†Ç‰ÇŒÇŽÇÇ’Ç”Ç–Ç˜ÇšÇœÇÇŸÇ¡Ç£Ç¥Ç§Ç©Ç«Ç­Ç¯Ç°Ç³ÇµÇ¹Ç»Ç½Ç¿ÈÈƒÈ…È‡È‰È‹ÈÈÈ‘È“È•È—È™È›ÈÈŸÈ¡È£È¥È§È©È«È­È¯È±È³È´ÈµÈ¶È·È¸È¹È¼È¿É€ÉÉ‘É’É“É”É•É–É—É˜É™ÉšÉ›ÉœÉÉžÉŸÉ É¡É¢É£É¤É¥É¦É§É¨É©ÉªÉ«É¬É­É®É¯É°É±É²É³É´ÉµÉ¶É·É¸É¹ÉºÉ»É¼É½É¾É¿Ê€ÊÊ‚ÊƒÊ„Ê…Ê†Ê‡ÊˆÊ‰ÊŠÊ‹ÊŒÊÊŽÊÊÊ‘Ê’Ê“Ê”Ê•Ê–Ê—Ê˜Ê™ÊšÊ›ÊœÊÊžÊŸÊ Ê¡Ê¢Ê£Ê¤Ê¥Ê¦Ê§Ê¨Ê©ÊªÊ«Ê¬Ê­Ê®Ê¯ÎÎ¬Î­Î®Î¯Î°Î±Î²Î³Î´ÎµÎ¶Î·Î¸Î¹ÎºÎ»Î¼Î½Î¾Î¿Ï€ÏÏ‚ÏƒÏ„Ï…Ï†Ï‡ÏˆÏ‰ÏŠÏ‹ÏŒÏÏŽÏÏ‘Ï•Ï–Ï—Ï™Ï›ÏÏŸÏ¡Ï£Ï¥Ï§Ï©Ï«Ï­Ï¯Ï°Ï±Ï²Ï³ÏµÏ¸Ï»Ï¼Ð°Ð±Ð²Ð³Ð´ÐµÐ¶Ð·Ð¸Ð¹ÐºÐ»Ð¼Ð½Ð¾Ð¿Ñ€ÑÑ‚ÑƒÑ„Ñ…Ñ†Ñ‡ÑˆÑ‰ÑŠÑ‹ÑŒÑÑŽÑÑÑ‘Ñ’Ñ“Ñ”Ñ•Ñ–Ñ—Ñ˜Ñ™ÑšÑ›ÑœÑÑžÑŸÑ¡Ñ£Ñ¥Ñ§Ñ©Ñ«Ñ­Ñ¯Ñ±Ñ³ÑµÑ·Ñ¹Ñ»Ñ½Ñ¿ÒÒ‹ÒÒÒ‘Ò“Ò•Ò—Ò™Ò›ÒÒŸÒ¡Ò£Ò¥Ò§Ò©Ò«Ò­Ò¯Ò±Ò³ÒµÒ·Ò¹Ò»Ò½Ò¿Ó‚Ó„Ó†ÓˆÓŠÓŒÓŽÓ‘Ó“Ó•Ó—Ó™Ó›ÓÓŸÓ¡Ó£Ó¥Ó§Ó©Ó«Ó­Ó¯Ó±Ó³ÓµÓ·Ó¹ÔÔƒÔ…Ô‡Ô‰Ô‹ÔÔÕ¡Õ¢Õ£Õ¤Õ¥Õ¦Õ§Õ¨Õ©ÕªÕ«Õ¬Õ­Õ®Õ¯Õ°Õ±Õ²Õ³Õ´ÕµÕ¶Õ·Õ¸Õ¹ÕºÕ»Õ¼Õ½Õ¾Õ¿Ö€ÖÖ‚ÖƒÖ„Ö…Ö†Ö‡á´€á´á´‚á´ƒá´„á´…á´†á´‡á´ˆá´‰á´Šá´‹á´Œá´á´Žá´á´á´‘á´’á´“á´”á´•á´–á´—á´˜á´™á´šá´›á´œá´á´žá´Ÿá´ á´¡á´¢á´£á´¤á´¥á´¦á´§á´¨á´©á´ªá´«áµ¢áµ£áµ¤áµ¥áµ¦áµ§áµ¨áµ©áµªáµ«áµ¬áµ­áµ®áµ¯áµ°áµ±áµ²áµ³áµ´áµµáµ¶áµ·áµ¹áµºáµ»áµ¼áµ½áµ¾áµ¿á¶€á¶á¶‚á¶ƒá¶„á¶…á¶†á¶‡á¶ˆá¶‰á¶Šá¶‹á¶Œá¶á¶Žá¶á¶á¶‘á¶’á¶“á¶”á¶•á¶–á¶—á¶˜á¶™á¶šá¸á¸ƒá¸…á¸‡á¸‰á¸‹á¸á¸á¸‘á¸“á¸•á¸—á¸™á¸›á¸á¸Ÿá¸¡á¸£á¸¥á¸§á¸©á¸«á¸­á¸¯á¸±á¸³á¸µá¸·á¸¹á¸»á¸½á¸¿á¹á¹ƒá¹…á¹‡á¹‰á¹‹á¹á¹á¹‘á¹“á¹•á¹—á¹™á¹›á¹á¹Ÿá¹¡á¹£á¹¥á¹§á¹©á¹«á¹­á¹¯á¹±á¹³á¹µá¹·á¹¹á¹»á¹½á¹¿áºáºƒáº…áº‡áº‰áº‹áºáºáº‘áº“áº•áº–áº—áº˜áº™áºšáº›áº¡áº£áº¥áº§áº©áº«áº­áº¯áº±áº³áºµáº·áº¹áº»áº½áº¿á»á»ƒá»…á»‡á»‰á»‹á»á»á»‘á»“á»•á»—á»™á»›á»á»Ÿá»¡á»£á»¥á»§á»©á»«á»­á»¯á»±á»³á»µá»·á»¹á¼€á¼á¼‚á¼ƒá¼„á¼…á¼†á¼‡á¼á¼‘á¼’á¼“á¼”á¼•á¼ á¼¡á¼¢á¼£á¼¤á¼¥á¼¦á¼§á¼°á¼±á¼²á¼³á¼´á¼µá¼¶á¼·á½€á½á½‚á½ƒá½„á½…á½á½‘á½’á½“á½”á½•á½–á½—á½ á½¡á½¢á½£á½¤á½¥á½¦á½§á½°á½±á½²á½³á½´á½µá½¶á½·á½¸á½¹á½ºá½»á½¼á½½á¾€á¾á¾‚á¾ƒá¾„á¾…á¾†á¾‡á¾á¾‘á¾’á¾“á¾”á¾•á¾–á¾—á¾ á¾¡á¾¢á¾£á¾¤á¾¥á¾¦á¾§á¾°á¾±á¾²á¾³á¾´á¾¶á¾·á¾¾á¿‚á¿ƒá¿„á¿†á¿‡á¿á¿‘á¿’á¿“á¿–á¿—á¿ á¿¡á¿¢á¿£á¿¤á¿¥á¿¦á¿§á¿²á¿³á¿´á¿¶á¿·â²â²ƒâ²…â²‡â²‰â²‹â²â²â²‘â²“â²•â²—â²™â²›â²â²Ÿâ²¡â²£â²¥â²§â²©â²«â²­â²¯â²±â²³â²µâ²·â²¹â²»â²½â²¿â³â³ƒâ³…â³‡â³‰â³‹â³â³â³‘â³“â³•â³—â³™â³›â³â³Ÿâ³¡â³£â³¤â´€â´â´‚â´ƒâ´„â´…â´†â´‡â´ˆâ´‰â´Šâ´‹â´Œâ´â´Žâ´â´â´‘â´’â´“â´”â´•â´–â´—â´˜â´™â´šâ´›â´œâ´â´žâ´Ÿâ´ â´¡â´¢â´£â´¤â´¥ï¬€ï¬ï¬‚ï¬ƒï¬„ï¬…ï¬†ï¬“ï¬”ï¬•ï¬–ï¬—\d-_^]";
    var evilRegExp:RegExp = new RegExp(utf8RegExp);
    evilRegExp.exec("Hello World");
    // If testcase runs then we are good, previously this would crash
    Assert.expectEq(
      "CVE-2008-0674",
       true,
       true
      );


    // CVE-2008-2371 begins with an option and contains multiple branches.
    var optionsRegExp:String = "(?i)[\xc3\xa9\xc3\xbd]|[\xc3\xa9\xc3\xbdA]";
    var evilRegExp2:RegExp = new RegExp(optionsRegExp);
    evilRegExp2.exec("Hello World");
    // If testcase runs then we are good, previously this would crash
    Assert.expectEq(
      "CVE-2008-2371",
       true,
       true
      );

