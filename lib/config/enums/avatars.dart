import 'package:flutter/material.dart';
import 'package:rapid_rounds/config/utils/avatars_icons.dart';

enum AvatarIcon {
  annoyed1,
  annoyed,
  bored,
  confused,
  crying,
  death,
  evil1,
  excited1,
  freak,
  excited,
  happy1,
  goofy,
  happy3,
  happy2,
  happy4,
  happy6,
  happy8,
  heartEyes,
  grumpy,
  inLove,
  love2,
  happy9,
  laughing,
  love3,
  love1,
  sad,
  sad1,
  scared,
  shocked,
  scared1,
  silly,
  love,
  worried,
  worried1,
  worried3,
  amazed2,
  zombie,
  amazed,
  worried2,
  angry3,
  angry1,
  sad2,
  evil,
  angry,
  happy,
  shocked1,
  angry4,
  unamused,
  angry2,
  amazed1,
}

extension AvatarIconExtension on AvatarIcon {
  IconData get icon {
    switch (this) {
      case AvatarIcon.annoyed1:
        return Avatars.annoyed_1;
      case AvatarIcon.annoyed:
        return Avatars.annoyed;
      case AvatarIcon.bored:
        return Avatars.bored;
      case AvatarIcon.confused:
        return Avatars.confused;
      case AvatarIcon.crying:
        return Avatars.crying;
      case AvatarIcon.death:
        return Avatars.death;
      case AvatarIcon.evil1:
        return Avatars.evil_1;
      case AvatarIcon.excited1:
        return Avatars.excited_1;
      case AvatarIcon.freak:
        return Avatars.freak;
      case AvatarIcon.excited:
        return Avatars.excited;
      case AvatarIcon.happy1:
        return Avatars.happy_1;
      case AvatarIcon.goofy:
        return Avatars.goofy;
      case AvatarIcon.happy3:
        return Avatars.happy_3;
      case AvatarIcon.happy2:
        return Avatars.happy_2;
      case AvatarIcon.happy4:
        return Avatars.happy_4;
      case AvatarIcon.happy6:
        return Avatars.happy_6;
      case AvatarIcon.happy8:
        return Avatars.happy_8;
      case AvatarIcon.heartEyes:
        return Avatars.heart_eyes;
      case AvatarIcon.grumpy:
        return Avatars.grumpy;
      case AvatarIcon.inLove:
        return Avatars.in_love;
      case AvatarIcon.love2:
        return Avatars.love_2;
      case AvatarIcon.happy9:
        return Avatars.happy_9;
      case AvatarIcon.laughing:
        return Avatars.laughing;
      case AvatarIcon.love3:
        return Avatars.love_3;
      case AvatarIcon.love1:
        return Avatars.love_1;
      case AvatarIcon.sad:
        return Avatars.sad;
      case AvatarIcon.sad1:
        return Avatars.sad_1;
      case AvatarIcon.scared:
        return Avatars.scared;
      case AvatarIcon.shocked:
        return Avatars.shocked;
      case AvatarIcon.scared1:
        return Avatars.scared_1;
      case AvatarIcon.silly:
        return Avatars.silly;
      case AvatarIcon.love:
        return Avatars.love;
      case AvatarIcon.worried:
        return Avatars.worried;
      case AvatarIcon.worried1:
        return Avatars.worried_1;
      case AvatarIcon.worried3:
        return Avatars.worried_3;
      case AvatarIcon.amazed2:
        return Avatars.amazed_2;
      case AvatarIcon.zombie:
        return Avatars.zombie;
      case AvatarIcon.amazed:
        return Avatars.amazed;
      case AvatarIcon.worried2:
        return Avatars.worried_2;
      case AvatarIcon.angry3:
        return Avatars.angry_3;
      case AvatarIcon.angry1:
        return Avatars.angry_1;
      case AvatarIcon.sad2:
        return Avatars.sad_2;
      case AvatarIcon.evil:
        return Avatars.evil;
      case AvatarIcon.angry:
        return Avatars.angry;
      case AvatarIcon.happy:
        return Avatars.happy;
      case AvatarIcon.shocked1:
        return Avatars.shocked_1;
      case AvatarIcon.angry4:
        return Avatars.angry_4;
      case AvatarIcon.unamused:
        return Avatars.unamused;
      case AvatarIcon.angry2:
        return Avatars.angry_2;
      case AvatarIcon.amazed1:
        return Avatars.amazed_1;
    }
  }
}
