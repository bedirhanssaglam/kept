import 'package:easy_localization/easy_localization.dart';

/// UI copy loaded by easy_localization from `assets/translations`.
final class AppStrings {
  const AppStrings();

  String greetingNamed(String hello, String name) => 'greetingNamed'.tr(
    namedArgs: {'hello': hello.toString(), 'name': name.toString()},
  );
  String vowsStillOpen(int count) => 'vowsStillOpen'.plural(count);
  String percentKept(int percent) =>
      'percentKept'.tr(namedArgs: {'percent': percent.toString()});
  String stillQuiet(int count) => 'stillQuiet'.plural(count);
  String andNMore(int count) =>
      'andNMore'.tr(namedArgs: {'count': count.toString()});
  String feedLoadFailed(String error) =>
      'feedLoadFailed'.tr(namedArgs: {'error': error.toString()});
  String timeMinutes(int count) =>
      'timeMinutes'.tr(namedArgs: {'count': count.toString()});
  String timeHours(int count) =>
      'timeHours'.tr(namedArgs: {'count': count.toString()});
  String timeDays(int count) =>
      'timeDays'.tr(namedArgs: {'count': count.toString()});
  String likeCount(int count) => 'likeCount'.plural(count);
  String viewComments(int count) => 'viewComments'.plural(count);
  String couldNotLoadVows(String error) =>
      'couldNotLoadVows'.tr(namedArgs: {'error': error.toString()});
  String memberCount(int count) => 'memberCount'.plural(count);
  String couldNotLoadProfile(String error) =>
      'couldNotLoadProfile'.tr(namedArgs: {'error': error.toString()});
  String membersTitle(String title) =>
      'membersTitle'.tr(namedArgs: {'title': title.toString()});
  String inRoom(int count) =>
      'inRoom'.tr(namedArgs: {'count': count.toString()});
  String tabChatCount(int count) =>
      'tabChatCount'.tr(namedArgs: {'count': count.toString()});
  String todayLine(String day) =>
      'todayLine'.tr(namedArgs: {'day': day.toString()});
  String yesterdayLine(int kept, int broke) => 'yesterdayLine'.tr(
    namedArgs: {'kept': kept.toString(), 'broke': broke.toString()},
  );
  String seeAllMembers(int count) =>
      'seeAllMembers'.tr(namedArgs: {'count': count.toString()});
  String verdictQuiet(String verdict, String quiet) => 'verdictQuiet'.tr(
    namedArgs: {'verdict': verdict.toString(), 'quiet': quiet.toString()},
  );
  String get appTitle => 'appTitle'.tr();
  String get navHome => 'navHome'.tr();
  String get navDiscover => 'navDiscover'.tr();
  String get navProfile => 'navProfile'.tr();
  String get newVow => 'newVow'.tr();
  String get notifications => 'notifications'.tr();
  String get notificationsSoon => 'notificationsSoon'.tr();
  String get greetingMorning => 'greetingMorning'.tr();
  String get greetingAfternoon => 'greetingAfternoon'.tr();
  String get greetingEvening => 'greetingEvening'.tr();
  String get greetingFallbackName => 'greetingFallbackName'.tr();
  String get tagline => 'tagline'.tr();
  String get greetingSignedIn => 'greetingSignedIn'.tr();
  String get closeTheDayHere => 'closeTheDayHere'.tr();
  String get noOneHasSpoken => 'noOneHasSpoken'.tr();
  String get iKeptIt => 'iKeptIt'.tr();
  String get iBrokeIt => 'iBrokeIt'.tr();
  String get feedQuiet => 'feedQuiet'.tr();
  String get openRoom => 'openRoom'.tr();
  String get keptJournal => 'keptJournal'.tr();
  String get article => 'article'.tr();
  String get readArticle => 'readArticle'.tr();
  String get keptIt => 'keptIt'.tr();
  String get brokeIt => 'brokeIt'.tr();
  String get steppedIn => 'steppedIn'.tr();
  String get saidSomething => 'saidSomething'.tr();
  String get categoryHealth => 'categoryHealth'.tr();
  String get categoryQuit => 'categoryQuit'.tr();
  String get categoryMove => 'categoryMove'.tr();
  String get categoryFocus => 'categoryFocus'.tr();
  String get categoryCustom => 'categoryCustom'.tr();
  String get categoryWater => 'categoryWater'.tr();
  String get categoryHabits => 'categoryHabits'.tr();
  String get timeNow => 'timeNow'.tr();
  String get discoverSubtitle => 'discoverSubtitle'.tr();
  String get noPublicVows => 'noPublicVows'.tr();
  String get enterRoom => 'enterRoom'.tr();
  String get policyOpen => 'policyOpen'.tr();
  String get policyApprovalShort => 'policyApprovalShort'.tr();
  String get policyInviteShort => 'policyInviteShort'.tr();
  String get policyClosedShort => 'policyClosedShort'.tr();
  String get policyApproval => 'policyApproval'.tr();
  String get policyInvite => 'policyInvite'.tr();
  String get policyClosed => 'policyClosed'.tr();
  String get policyOpenToJoin => 'policyOpenToJoin'.tr();
  String get signIn => 'signIn'.tr();
  String get signOut => 'signOut'.tr();
  String get retry => 'retry'.tr();
  String get yourRooms => 'yourRooms'.tr();
  String get roomsEmptyHint => 'roomsEmptyHint'.tr();
  String get roomsTapHint => 'roomsTapHint'.tr();
  String get noMemberships => 'noMemberships'.tr();
  String get ownYourWord => 'ownYourWord'.tr();
  String get signInProfileBody => 'signInProfileBody'.tr();
  String get statKept => 'statKept'.tr();
  String get statBroke => 'statBroke'.tr();
  String get statOpen => 'statOpen'.tr();
  String get makeANewVow => 'makeANewVow'.tr();
  String get createLead => 'createLead'.tr();
  String get fieldTitle => 'fieldTitle'.tr();
  String get titleHint => 'titleHint'.tr();
  String get fieldRule => 'fieldRule'.tr();
  String get ruleHint => 'ruleHint'.tr();
  String get fieldCategory => 'fieldCategory'.tr();
  String get examplesLead => 'examplesLead'.tr();
  String get exampleWaterTitle => 'exampleWaterTitle'.tr();
  String get exampleWaterRule => 'exampleWaterRule'.tr();
  String get examplePhoneTitle => 'examplePhoneTitle'.tr();
  String get examplePhoneRule => 'examplePhoneRule'.tr();
  String get exampleWalkTitle => 'exampleWalkTitle'.tr();
  String get exampleWalkRule => 'exampleWalkRule'.tr();
  String get fieldLength => 'fieldLength'.tr();
  String get durationWeek => 'durationWeek'.tr();
  String get durationThreeWeeks => 'durationThreeWeeks'.tr();
  String get durationOpen => 'durationOpen'.tr();
  String get fieldStart => 'fieldStart'.tr();
  String get startsToday => 'startsToday'.tr();
  String get startsTomorrow => 'startsTomorrow'.tr();
  String get startsTomorrowLabel => 'startsTomorrowLabel'.tr();
  String startsOnDay(String day) =>
      'startsOnDay'.tr(namedArgs: {'day': day.toString()});
  String get startTodayHelp => 'startTodayHelp'.tr();
  String get startTomorrowHelp => 'startTomorrowHelp'.tr();
  String get previewLead => 'previewLead'.tr();
  String get previewEmptyTitle => 'previewEmptyTitle'.tr();
  String get previewEmptyRule => 'previewEmptyRule'.tr();
  String get vowFinished => 'vowFinished'.tr();
  String get vowNotStarted => 'vowNotStarted'.tr();
  String get whoCanJoin => 'whoCanJoin'.tr();
  String get creating => 'creating'.tr();
  String get createVow => 'createVow'.tr();
  String get policyOpenLabel => 'policyOpenLabel'.tr();
  String get policyOpenHelp => 'policyOpenHelp'.tr();
  String get policyApprovalLabel => 'policyApprovalLabel'.tr();
  String get policyApprovalHelp => 'policyApprovalHelp'.tr();
  String get policyInviteLabel => 'policyInviteLabel'.tr();
  String get policyInviteHelp => 'policyInviteHelp'.tr();
  String get policyClosedLabel => 'policyClosedLabel'.tr();
  String get policyClosedHelp => 'policyClosedHelp'.tr();
  String get onboardingPublicTitle => 'onboardingPublicTitle'.tr();
  String get onboardingPublicBody => 'onboardingPublicBody'.tr();
  String get onboardingDailyTitle => 'onboardingDailyTitle'.tr();
  String get onboardingDailyBody => 'onboardingDailyBody'.tr();
  String get onboardingLiveTitle => 'onboardingLiveTitle'.tr();
  String get onboardingLiveBody => 'onboardingLiveBody'.tr();
  String get skip => 'skip'.tr();
  String get next => 'next'.tr();
  String get letsGo => 'letsGo'.tr();
  String get almostThere => 'almostThere'.tr();
  String get signInHeadline => 'signInHeadline'.tr();
  String get usernameStepBody => 'usernameStepBody'.tr();
  String get emailStepBody => 'emailStepBody'.tr();
  String get chooseUsername => 'chooseUsername'.tr();
  String get usernameSubtitle => 'usernameSubtitle'.tr();
  String get usernameHint => 'usernameHint'.tr();
  String get usernameRules => 'usernameRules'.tr();
  String get continueAction => 'continueAction'.tr();
  String get keepYourWord => 'keepYourWord'.tr();
  String get signInSheetBody => 'signInSheetBody'.tr();
  String get signedIn => 'signedIn'.tr();
  String get comments => 'comments'.tr();
  String get noComments => 'noComments'.tr();
  String get addComment => 'addComment'.tr();
  String get members => 'members'.tr();
  String get roleOwner => 'roleOwner'.tr();
  String get roleAdmin => 'roleAdmin'.tr();
  String get roleMember => 'roleMember'.tr();
  String get statusQuiet => 'statusQuiet'.tr();
  String get statusKept => 'statusKept'.tr();
  String get statusBroke => 'statusBroke'.tr();
  String get vowClosed => 'vowClosed'.tr();
  String get requestPending => 'requestPending'.tr();
  String get requestSent => 'requestSent'.tr();
  String get inviteCode => 'inviteCode'.tr();
  String get inviteHint => 'inviteHint'.tr();
  String get cancel => 'cancel'.tr();
  String get join => 'join'.tr();
  String get done => 'done'.tr();
  String get joinRequests => 'joinRequests'.tr();
  String get noPendingRequests => 'noPendingRequests'.tr();
  String get wantsToJoin => 'wantsToJoin'.tr();
  String get noteKeptPrompt => 'noteKeptPrompt'.tr();
  String get noteBrokePrompt => 'noteBrokePrompt'.tr();
  String get noteBody => 'noteBody'.tr();
  String get noteKeptHint => 'noteKeptHint'.tr();
  String get noteBrokeHint => 'noteBrokeHint'.tr();
  String get shareToFeed => 'shareToFeed'.tr();
  String get shareToFeedHelp => 'shareToFeedHelp'.tr();
  String get postKept => 'postKept'.tr();
  String get postBroke => 'postBroke'.tr();
  String get vowRoom => 'vowRoom'.tr();
  String get tabToday => 'tabToday'.tr();
  String get tabChat => 'tabChat'.tr();
  String get official => 'official'.tr();
  String get waitingApproval => 'waitingApproval'.tr();
  String get joinToCheckIn => 'joinToCheckIn'.tr();
  String get joinApprovalHelp => 'joinApprovalHelp'.tr();
  String get joinInviteHelp => 'joinInviteHelp'.tr();
  String get joinClosedHelp => 'joinClosedHelp'.tr();
  String get joinOpenHelp => 'joinOpenHelp'.tr();
  String get requestToJoin => 'requestToJoin'.tr();
  String get joinWithCode => 'joinWithCode'.tr();
  String get joinThisVow => 'joinThisVow'.tr();
  String get enterInviteToJoin => 'enterInviteToJoin'.tr();
  String get requests => 'requests'.tr();
  String get loggedKept => 'loggedKept'.tr();
  String get loggedBroke => 'loggedBroke'.tr();
  String get chatInviteOnly => 'chatInviteOnly'.tr();
  String get chatNeedsApproval => 'chatNeedsApproval'.tr();
  String get chatMembersOnly => 'chatMembersOnly'.tr();
  String get chatJoinToSee => 'chatJoinToSee'.tr();
  String get chatForMembers => 'chatForMembers'.tr();
  String get enterInviteOnToday => 'enterInviteOnToday'.tr();
  String get chatEmpty => 'chatEmpty'.tr();
  String activeVows(int count) => 'activeVows'.plural(count);
  String get about => 'about'.tr();
  String get aboutBody => 'aboutBody'.tr();
  String get versionLabel => 'versionLabel'.tr();
  String activityKept(String name) =>
      'activityKept'.tr(namedArgs: {'name': name});
  String activityKeptNote(String name, String note) =>
      'activityKeptNote'.tr(namedArgs: {'name': name, 'note': note});
  String activityBroke(String name) =>
      'activityBroke'.tr(namedArgs: {'name': name});
  String activityBrokeNote(String name, String note) =>
      'activityBrokeNote'.tr(namedArgs: {'name': name, 'note': note});
  String activityJoined(String name) =>
      'activityJoined'.tr(namedArgs: {'name': name});
  String activityCreated(String name) =>
      'activityCreated'.tr(namedArgs: {'name': name});
  String get chatHint => 'chatHint'.tr();
  String get language => 'language'.tr();
  String get languageEnglish => 'languageEnglish'.tr();
  String get languageTurkish => 'languageTurkish'.tr();
  String get appearance => 'appearance'.tr();
  String get themeDark => 'themeDark'.tr();
  String get themeLight => 'themeLight'.tr();
}
