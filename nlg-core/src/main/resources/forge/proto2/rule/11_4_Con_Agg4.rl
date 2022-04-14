Sem<=>ASem node_word
[
  leftside = [
?Xl {
  ¬ ( c:blocked = "yes" & ¬c:cancel_block = "yes" )
  sem = ?s
}
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  sem = ?s
}
  ]
]

/*When a coordinating conjunction has to be added.*/
Sem<=>ASem introduce_coord_noRoot
[
  leftside = [
c:?Sl {
  c:?Xl {
    ?r-> c:?Zl {
      attach_coord = "yes"
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Sr {
  rc:<=> ?Sl
  rc:?Xr {
    rc:<=> ?Xl
    ?r-> ?ConjR {
      sem = "and"
      slex = "and"
      pos = "CC"
      Set-> rc:?Zr {
        rc:<=> ?Zl
        member = "A1"
        n = "1.0"
      }
    }
  }
  ?ConjR {}
}
  ]
]

/*When a coordinating conjunction has to be added.*/
Sem<=>ASem introduce_coord_Root
[
  leftside = [
c:?Sl {
  c:?Zl {
    attach_coord = "yes"
  }
}

¬c:?Xl { c:?r-> c:?Zl {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?Sr {
  rc:<=> ?Sl
  ?ConjR {
    sem = "and"
    slex = "and"
    pos = "CC"
    Set-> rc:?Zr {
      rc:<=> ?Zl
      member = "A1"
      n = "1.0"
    }
  }
  ?ConjR {}
}
  ]
]

/*Transfers all non-argumental relations.*/
Sem<=>ASem rel_copy
[
  leftside = [
c:?Xl {
  ?r-> c: ?Yl {
    ¬c:attach_coord = "yes"
  }
}

¬?r == mergeObjProgress
¬?r == mergeSubjProgress
¬?r == mergeSubjProgressA0
¬?r == mergeBubOnly
¬?r == CANCEL_AGG
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ?r-> rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

Sem<=>ASem add_rel_b
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:id = ?idS1
    ¬ ( c:blocked = "yes" & ¬c:cancel_block = "yes" )
    c:b-> c:?S4l {
      ( c:blocked = "yes" & ¬c:cancel_block = "yes" )
      c:*b-> c:?S2l {
        c:id = ?idS2
        ¬ ( c:blocked = "yes" & ¬c:cancel_block = "yes" )
      }
    }
  }
}

¬ ( c:?Tl { c:?S3l { c:id = ?idS3 ¬( c:blocked = "yes" & ¬c:cancel_block = "yes" ) } } & ?idS3 > ?idS1 & ?idS3 < ?idS2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  rc:<=> ?S1l
  b-> rc:?S2r {
    rc:<=> ?S2l
  }
}
  ]
]

Sem<=>ASem bubble_fill
[
  leftside = [
c:?Bubble {
  c:?Xl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?BubbleR {
  rc:<=> ?Bubble
  rc:+?Xr {
    rc:<=> ?Xl
  }
}
  ]
]

Sem<=>DSynt bubble_expand_dep
[
  leftside = [
c:?Sl {
  c:blocked = "yes"
  c:?Xl {
    c:?r-> c:?Yl {}
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?bubble {
  ¬rc:?Yr {
    rc:<=> ?Yl
  }
  rc:?Xr {
    rc:<=> ?Xl
    rc:?r-> rc:?Yr {
      rc:<=> ?Yl
    }
  }
  rc:+?Yr {}
}
  ]
]

Sem<=>DSynt bubble_expand_gov
[
  leftside = [
c:?Sl {
  c:blocked = "yes"
  c:?Xl {
    c:?r-> c:?Yl {}
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?bubble {
  ¬rc:?Xr {
    rc:<=> ?Xl
  }
  rc:?Yr {
    rc:<=> ?Yl
  }
  rc:+?Xr {
    rc:<=> ?Xl
    rc:?r-> rc:?Yr {
      rc:<=> ?Yl
    }
  }
}
  ]
]

Sem<=>ASem transfer_attribute
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*MindSpaces*/
Sem<=>ASem noMerge_Coord_changeParameter_emotion
[
  leftside = [
c:?S2l {
  blocked = "yes"
  parameterChange = "yes"
  c:?X2l {
    c:sem = "change"
  }
  noMergeCoord-> c:?S1l {
    subjectEmotion = "yes"
    c:?X1l {
      c:sem = "feel"
      c:attach_coord = "yes"
    }
  }
}

¬c:?Coord { c:Set-> c:?X2l {} }

// Aggregation was not detected as wrong in the previous grammar.
¬c:?S2l { c:CANCEL_AGG-> c:?S1l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  //rc:<=> ?S1l
  rc:?X1r {
    rc:<=> ?X1l
  }
  rc:+?X2r {
    rc:<=> ?X2l
  }
}

rc:?ConjR {
  rc:sem = "and"
  sem = "so"
  slex = "so"
  rc:Set-> rc:?X1r {
    rc:<=> ?X1l
  }
  Set-> rc:?X2r {
    rc:<=> ?X2l
  }
}
  ]
]

/*MindSpaces*/
Sem<=>ASem noMerge_Coord_changeParameter_emotion_COORD
[
  leftside = [
c:?S2l {
  blocked = "yes"
  parameterChange = "yes"
  c:?X2l {
    c:sem = "change"
  }
  noMergeCoord-> c:?S1l {
    subjectEmotion = "yes"
    c:?X1l {
      c:sem = "feel"
      c:attach_coord = "yes"
    }
  }
}

c:?Coord { c:Set-> c:?X2l {} }

// Aggregation was not detected as wrong in the previous grammar.
¬c:?S2l { c:CANCEL_AGG-> c:?S1l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  //rc:<=> ?S1l
  rc:?X1r {
    rc:<=> ?X1l
  }
  rc:+?X2r {
    rc:<=> ?X2l
  }
}

rc:?ConjR {
  rc:sem = "and"
  sem = "so"
  slex = "so"
  rc:Set-> rc:?X1r {
    rc:<=> ?X1l
  }
  Set-> rc:?CoordR {
    rc:<=> ?Coord
  }
}
  ]
]

/*For bubbles that have the same property but different objects (e.g. born + date; born + place )*/
Sem<=>ASem merge_ObjProg
[
  leftside = [
c:?Tl {
  c:?S2l {
    c:?X2l {
      c:?t-> c:?Y2l {
        c:sem = ?semY2
        c:id = ?idY2
        blocked = "yes"
      }
    }
    c:?s-> c:?S1l {
      c:?X1l {
        c:?r-> c:?Y1l {
          c:sem = ?semY1
          c:id = ?idY1
        }
      }
    }
  }
}

?semY1 == ?semY2
// Both Xs are roots
¬c:?N1l { c:?r1-> c:?X1l {} }
¬c:?N2l { c:?r2-> c:?X2l {} }

( ( ( ?r == A2 | ?r == A3 ) & ?s == mergeObjProgress ) | ( ?r == A1 & ?s == mergeSubjProgress ) | ( ?r == A0 & ?s == mergeSubjProgressA0 ) )

// Aggregation was not detected as wrong in the previous grammar.
¬c:?S2l { c:CANCEL_AGG-> c:?S1l {} }

// Priority to MindSpaces rule
¬c:?S1l { c:noMergeCoord-> c:?S11l {} }
¬c:?S2l { c:noMergeCoord-> c:?S12l {} }
¬c:?S13l { c:noMergeCoord-> c:?S1l {} }
¬c:?S14l { c:noMergeCoord-> c:?S2l {} }

//Priority to objProgress
¬ ( ?s == mergeSubjProgress & c:?S2l { c:mergeObjProgress-> c:?S4l {} } )
¬ ( ?s == mergeSubjProgressA0 & c:?S2l { c:mergeObjProgress-> c:?S8l {} } )
¬ ( ?s == mergeSubjProgressA0 & c:?S2l { c:mergeSubjProgress-> c:?S9l {} } )

//If ?S2 is involved in another objProgress aggregation, just keep one (170822a_known_input_multiple2.conll, sent.39; concurrent config: sent.12
¬ ( ?s == mergeObjProgress & c:?S2l { c:mergeObjProgress-> c:?S7l { c:id = ?id7 } } & ?id7 < ?S1l.id )

// ?S1 is not itself involved in an aggregation
¬ ( c:?S1l { c:?s3-> c:?S3l {} } & ( ?s3 == mergeObjProgress |  ?s3 == mergeSubjProgress |  ?s3 == mergeSubjProgressA0 ) )

// there isn't another dependent with the same sem (it happens!)
¬ ( c:?X2l { c:?r5-> c:?Y5l {c:sem = ?semY5 c:id = ?idY5 } } & ?semY5 == ?semY2 & ?idY5 < ?idY2 )
¬ ( c:?X1l { c:?r6-> c:?Y6l {c:sem = ?semY6 c:id = ?idY6 } } & ?semY6 == ?semY1 & ?idY6 < ?idY1 )

// The rule only applies once, with one ?X1l
¬ ( c:?X1l { c:id = ?idX1 } & c:?X10l { c:id = ?idX10 c:?r10-> c:?Y1l {} } 
  & ( ( ( ?r10 == A2 | ?r10 == A3 ) & ?s == mergeObjProgress ) | ( ?r10 == A1 & ?s == mergeSubjProgress ) | ( ?r10 == A0 & ?s == mergeSubjProgressA0 ) )
  & ¬c:?N10l { c:?s10-> c:?X10l {} } & ?idX10 < ?idX1
)

// To avoid aggregation in WELCOME interrogatives - but think about interrogatives in general in the future (progression aggregation doesn't make sense for interrogatives)
¬ ( project_info.project.name.WELCOME & ( ?X1l.clause_type == "INT" | ?X2l.clause_type == "INT" ))

//PATCH MindSpaces
¬ ( project_info.project.name.MindSpaces & ( ( ( ?X1l.sem == "contain" | ?X1l.sem == "occupy" | ?X1l.sem == "colourful" ) & ?X2l.sem == "element" ) | ( ( ?X2l.sem == "contain" | ?X2l.sem == "occupy" | ?X2l.sem == "colourful" )  & ?X1l.sem == "element" ) ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  //rc:<=> ?S1l
  rc:?X1r {
    rc:<=> ?X1l
    main_rheme = "yes"
  }
  rc:+?X2r {
    rc:<=> ?X2l
  }
}

rc:?X2r {
  rc:<=> ?X2l
  ?t-> rc:?Y1r {
    rc:<=> ?Y1l
  }
}
  ]
]

Sem<=>ASem merge_BubOnly
[
  leftside = [
c:?Tl {
  c:?S2l {
    c:?X2l {}
    c:mergeBubOnly-> c:?S1l {
      c:?X1l {}
    }
  }
}

// Both Xs are roots
¬c:?N1l { c:?r1-> c:?X1l {} }
¬c:?N2l { c:?r2-> c:?X2l {} }

// Aggregation was not detected as wrong in the previous grammar.
¬c:?S2l { c:CANCEL_AGG-> c:?S1l {} }

¬c:?S1l { c:noMergeCoord-> c:?S11l {} }
¬c:?S2l { c:noMergeCoord-> c:?S12l {} }
¬c:?S13l { c:noMergeCoord-> c:?S1l {} }
¬c:?S14l { c:noMergeCoord-> c:?S2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  rc:?X1r {
    rc:<=> ?X1l
  }
  rc:+?X2r {
    rc:<=> ?X2l
  }
}

rc:?ConjR {
  rc:sem = "and"
  rc:Set-> rc:?X1r {
    rc:<=> ?X1l
  } 
  Set-> rc:?X2r {
    rc:<=> ?X2l
  }
}
  ]
]

Sem<=>ASem merge_coord_Root
[
  leftside = [
c:?S2l {
  blocked = "yes"
  c:?X2l {
    c:?r2-> c:?Y2l {
    }
  }
  mergeRootCoord-> c:?S1l {
    c:?X1l {
      c:attach_coord = "yes"
      c:?r1-> c:?Y1l {
      }
    }
  }
}

?r1 == ?r2

// Aggregation was not detected as wrong in the previous grammar.
¬c:?S2l { c:CANCEL_AGG-> c:?S1l {} }

¬c:?S1l { c:noMergeCoord-> c:?S11l {} }
¬c:?S2l { c:noMergeCoord-> c:?S12l {} }
¬c:?S13l { c:noMergeCoord-> c:?S1l {} }
¬c:?S14l { c:noMergeCoord-> c:?S2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  //rc:<=> ?S1l
  rc:?X1r {
    rc:<=> ?X1l
  }
  rc:+?X2r {
    rc:<=> ?X2l
  }
  rc:+?Y2r {
    rc:<=> ?Y2l
  }
}

rc:?ConjR {
  rc:sem = "and"
  rc:Set-> rc:?X1r { rc:<=> ?X1l }
  Set-> rc:?X2r {}
}
  ]
]

/*When Region comes first, and Time second.*/
Sem<=>ASem merge_HighestTimeRegion1
[
  leftside = [
c:?Tl {
  c:?S2l {
    c:blocked = "yes"
    c:?Be2l {
      c:slex = "be"
      c:blocked = "yes"
      c:A1-> c:?Name2l {
        c:blocked = "yes"
        c:variable_class = "Name"
        c:sem = ?semN2
      }
      c:A2-> c:?Building2l {
        c:blocked = "yes"
      }
      c:Time-> c:?Time2l {}
    }
    c:mergeHighestTimeRegion-> c:?S1l {
      c:?Be1l {
        c:slex = "be"
        c:A1-> c:?Name1l {
          c:variable_class = "Name"
          c:sem = ?semN1
        }
        c:A2-> c:?Building1l {}
      }
    }
  }
}

?semN1 == ?semN2

c:?H1l { c:sem = "highest" c:A1-> c:?Building1l {} c:Location-> c:?Loc {} }
c:?H2l { c:sem = "highest" c:A1-> c:?Building2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  //rc:<=> ?S1l
  rc:?Be1r {
    rc:<=> ?Be1l
    Time-> rc:?Time2r {
      rc:<=> ?Time2l
    }
  }
  rc:+?Time2r {
    rc:<=> ?Time2l
  }
}
  ]
]

/*When Time comes first, and Region second. NOT TESTED.*/
Sem<=>ASem merge_HighestTimeRegion2
[
  leftside = [
c:?Tl {
  c:?S2l {
    c:blocked = "yes"
    c:?Be2l {
      c:slex = "be"
      c:blocked = "yes"
      c:A1-> c:?Name2l {
        c:blocked = "yes"
        c:variable_class = "Name"
        c:sem = ?semN2
      }
      c:A2-> c:?Building2l {
        c:blocked = "yes"
      }
    }
    c:mergeHighestTimeRegion-> c:?S1l {
      c:?Be1l {
        c:slex = "be"
        c:A1-> c:?Name1l {
          c:variable_class = "Name"
          c:sem = ?semN1
        }
        c:A2-> c:?Building1l {}
        c:Time-> c:?Time2l {}
      }
    }
  }
}

?semN1 == ?semN2

c:?H1l { c:sem = "highest" c:A1-> c:?Building1l {} c:Location-> c:?Loc {} }
c:?H2l { c:sem = "highest" c:A1-> c:?Building2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  //rc:<=> ?S1l
  rc:?Be1r {
    rc:<=> ?Be1l
    Location-> rc:?Locr {
      rc:<=> ?Loc
    }
  }
  rc:+?Locr {
    rc:<=> ?Loc
  }
}
  ]
]

excluded Sem<=>ASem mark_member2
[
  leftside = [
c:?S2l {
  c:blocked = "yes"
  c:?X2l {
    c:?s2-> c:?Z2l {}
  }
  c:mergeRootSubjCoord-> c:?S1l {
    c:?X1l {
      c:?s1-> c:?Z1l {
        c:attach_coord = "yes"
      }
    }
  }
}

¬ ( c:?Tl { c:?S2l {c:id = ?id2 } c:?S3l { c:id = ?id3 c:mergeRootSubjCoord-> c:?S1l {} } } & ?id3 < ?id2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Z2r {
  rc:<=> ?Z2l
  member = "A2"
  n = "2.0"
}
  ]
]

excluded Sem<=>ASem mark_conj_numMore
[
  leftside = [
c:?Tl {
  c:?S2l {
    c:id = ?id2
    c:?Z2l {}
    c:mergeRootSubjCoord-> c:?S1l {}
  }
  c:?S4l {
    c:id = ?id4
    c:?Z4l {}
    c:mergeRootSubjCoord-> c:?S1l {}
  }
}
  
// get the next conjunct only
¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:mergeRootSubjCoord-> c:?S1l {} } } & ?id3 > ?id2 & ?id3 < ?id4 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Coord {
  rc:Set-> rc:?Z2r {
    rc:<=> ?Z2l
    rc:n = ?cn2
  }
  rc:Set-> rc:?Z4r {
    rc:<=> ?Z4l
    ¬rc:n = ?cn4
    n = #?cn2+1#
    //member = #A+?Z4r.n#
  }
}
  ]
]

excluded Sem<=>ASem mark_member3
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:n = "3.0"
  member = "A3"
}
  ]
]

excluded Sem<=>ASem mark_member4
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:n = "4.0"
  member = "A4"
}
  ]
]

excluded Sem<=>ASem mark_member5
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:n = "5.0"
  member = "A5"
}
  ]
]

excluded Sem<=>ASem mark_member6
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:n = "6.0"
  member = "A6"
}
  ]
]

excluded Sem<=>ASem mark_member7
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:n = "7.0"
  member = "A7"
}
  ]
]

Sem<=>ASem mark_member2_mergeBubOnly
[
  leftside = [
c:?S2l {
  c:blocked = "yes"
  c:?X2l {}
  c:?r-> c:?S1l {
    c:?X1l { c:attach_coord = "yes" }
  }
}

¬c:?N1l { c:?r1-> c:?X1l {} }
¬c:?N2l { c:?r2-> c:?X2l {} }

¬ ( c:?T1l { c:?S2l {c:id = ?id2 } c:?S3l { c:id = ?id3 c:mergeBubOnly-> c:?S1l {} } } & ?id3 < ?id2 )

(?r == mergeBubOnly | ?r == mergeRootCoord | ?r == noMergeCoord )
  ]
  mixed = [

  ]
  rightside = [
rc:?X2r {
  rc:<=> ?X2l
  member = "A2"
  n = "2.0"
}
  ]
]

/*mergeRootSubj
mergeRootSubjCoord
mergeRootObjCoord
mergeRootSubjElab
mergeRootCoord*/
Sem<=>ASem mark_conj_numMore
[
  leftside = [
c:?Tl {
  c:?S2l {
    c:id = ?id2
    c:?Z2l {}
    c:?r-> c:?S1l {}
  }
  c:?S4l {
    c:id = ?id4
    c:?Z4l {}
    c:?s-> c:?S1l {}
  }
}

?r == ?s
(?r == mergeBubOnly | ?r == mergeRootCoord )

// get the next conjunct only
¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:?t1-> c:?S1l {} } } & ?t1 == ?r & ?id3 > ?id2 & ?id3 < ?id4 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Coord {
  rc:Set-> rc:?Z2r {
    rc:<=> ?Z2l
    rc:n = ?cn2
  }
  rc:Set-> rc:?Z4r {
    rc:<=> ?Z4l
    ¬rc:n = ?cn4
    n = #?cn2+1#
    //member = #A+?Z4r.n#
  }
}
  ]
]

Sem<=>ASem mark_member3
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:n = "3.0"
  member = "A3"
}
  ]
]

Sem<=>ASem mark_member4
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:n = "4.0"
  member = "A4"
}
  ]
]

Sem<=>ASem mark_member5
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:n = "5.0"
  member = "A5"
}
  ]
]

Sem<=>ASem mark_member6
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:n = "6.0"
  member = "A6"
}
  ]
]

Sem<=>ASem mark_member7
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:n = "7.0"
  member = "A7"
}
  ]
]

Sem<=>ASem mark_member8
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:n = "8.0"
  member = "A8"
}
  ]
]

Sem<=>ASem mark_member9
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:n = "9.0"
  member = "A9"
}
  ]
]

Sem<=>ASem mark_member10
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:n = "10.0"
  member = "A10"
}
  ]
]

Sem<=>ASem mark_member11
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:n = "11.0"
  member = "A11"
}
  ]
]

/*Sometimes two predicates that have the same two arguments end-up being combined by this grammar.
E.g. 201005_test_triples_en_en_utf8_1350-1778.conll input 99.*/
Sem<=>ASem add_coord_weird_agg
[
  leftside = [
c:?Tl {
  c:?S2l {
    c:?X2l {
      c:?t-> c:?Y2l { c:id = ?id1 }
      c:?u-> c:?Z2l { c:id = ?id2 }
    }
    c:?s-> c:?S1l {
      c:?X1l {
        c:?r-> c:?Y1l { c:id = ?id3 }
        c:?v-> c:?Z1l { c:id = ?id4 }
      }
    }
  }
}

// I didn't think too much about the LS, just copied from the merge rules above.
( ( ( ?r == A2 | ?r == A3 ) & ?s == mergeObjProgress ) | ( ?r == A1 & ?s == mergeSubjProgress ) | ( ?r == A0 & ?s == mergeSubjProgressA0 ) )

?id1 > ?id2
?id3 > ?id4
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  //rc:<=> ?S1l
  rc:?X1r {
    rc:<=> ?X1l
    rc:?t1-> rc:?Y1r {
      rc:<=> ?Y1l
    }
    rc:?t2-> rc:?Z1r {
      rc:<=> ?Z1l
    }
  }
  rc:?X2r {
    rc:<=> ?X2l
    rc:?t3-> rc:?Y1r {
      rc:<=> ?Y1l
    }
    rc:?t4-> rc:?Z1r {
      rc:<=> ?Z1l
    }
  }
  ?And {
    sem = "and"
    slex = "and"
    pos = "CC"
    Set-> rc:?X1r {
      rc:<=> ?X1l
      member = "A1"
      n = "1.0"
    }
    Set-> rc:?X2r {
      rc:<=> ?X2l
      member = "A2"
      n = "2.0"
    }
  }
}
  ]
]

Sem<=>ASem attr_bnId : transfer_attribute
[
  leftside = [
c:?Xl{
  bnId = ?u
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  bnId = ?u
}
  ]
]

Sem<=>ASem attr_cardinality : transfer_attribute
[
  leftside = [
c:?Xl {
  cardinality = ?u
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  cardinality = ?u
}
  ]
]

Sem<=>ASem attr_class : transfer_attribute
[
  leftside = [
c:?Xl {
  class = ?u
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  class = ?u
}
  ]
]

/*dpos should be VB, NN, RB, JJ (see pos rules below)*/
Sem<=>ASem attr_clause_type : transfer_attribute
[
  leftside = [
c:?Xl {
  clause_type = ?ds
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  clause_type = ?ds
}
  ]
]

/*dpos should be VB, NN, RB, JJ (see pos rules below)*/
Sem<=>ASem attr_coord_type : transfer_attribute
[
  leftside = [
c:?Xl {
  coord_type = ?ds
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  coord_type = ?ds
}
  ]
]

Sem<=>ASem attr_coref_id : transfer_attribute
[
  leftside = [
c:?Xl {
  coref_id = ?u
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  coref_id = ?u
}
  ]
]

/*dpos should be VB, NN, RB, JJ (see pos rules below)*/
Sem<=>ASem attr_date_type : transfer_attribute
[
  leftside = [
c:?Xl {
  date_type = ?ds
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  date_type = ?ds
}
  ]
]

/*dpos should be VB, NN, RB, JJ (see pos rules below)*/
Sem<=>ASem attr_dative_shift : transfer_attribute
[
  leftside = [
c:?Xl {
  dative_shift = ?ds
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  dative_shift = ?ds
}
  ]
]

Sem<=>ASem attr_defniniteness : transfer_attribute
[
  leftside = [
c:?Xl {
  definiteness = ?def
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  definiteness = ?def
}
  ]
]

/*In KRISTINA, we cannot have A0 as inputs so far, so no need to keep track of extArg predicates for next levels.
However, we do map the A1 to A0 in case the predicate is identified as extArg (see markers)*/
Sem<=>ASem attr_extArg : transfer_attribute
[
  leftside = [
c:?Xl {
  hasExtArg = ?d
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  hasExtArg = ?d
}
  ]
]

Sem<=>ASem attr_gender : transfer_attribute
[
  leftside = [
c: ?Xl{
  gender = ?i
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr{
  rc: <=> ?Xl
  gender = ?i
}
  ]
]

Sem<=>ASem attr_GovLex : transfer_attribute
[
  leftside = [
c:?Xl {
  GovLex = ?tc
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  GovLex = ?tc
}
  ]
]

/*numbering of conjuncts in coordination*/
Sem<=>ASem attr_has_main_rheme : transfer_attribute
[
  leftside = [
c:?Xl {
  has_main_rheme = ?m
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  has_main_rheme = ?m
}
  ]
]

Sem<=>ASem attr_id : transfer_attribute
[
  leftside = [
c: ?Xl{
  id = ?i
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr{
  rc: <=> ?Xl
  id = ?i
}
  ]
]

Sem<=>ASem attr_id0 : transfer_attribute
[
  leftside = [
c: ?Xl{
  id0 = ?i
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr{
  rc: <=> ?Xl
  id0 = ?i
}
  ]
]

/*numbering of conjuncts in coordination*/
Sem<=>ASem attr_juxpatos : transfer_attribute
[
  leftside = [
c:?Xl {
  juxtaposition = ?m
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  juxtaposition = ?m
}
  ]
]

Sem<=>ASem attr_lex_copy : transfer_attribute
[
  leftside = [
c:?Xl {
  lex = ?lex
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  lex = ?lex
}
  ]
]

/*numbering of conjuncts in coordination*/
Sem<=>ASem attr_main_rheme : transfer_attribute
[
  leftside = [
c:?Xl {
  ¬c:cancel_rheme = "yes"
  main_rheme = ?m
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  main_rheme = ?m
}
  ]
]

/*numbering of conjuncts in coordination*/
Sem<=>ASem attr_main_theme : transfer_attribute
[
  leftside = [
c:?Xl {
  main_theme = ?m
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  main_theme = ?m
}
  ]
]

/*numbering of conjuncts in coordination*/
Sem<=>ASem attr_member : transfer_attribute
[
  leftside = [
c:?Xl {
  member = ?m
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  member = ?m
}
  ]
]

Sem<=>ASem attr_modality : transfer_attribute
[
  leftside = [
c:?Xl {
  modality = ?t
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  modality = ?t
}
  ]
]

Sem<=>ASem attr_modality_type : transfer_attribute
[
  leftside = [
c:?Xl {
  modality_type = ?t
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  modality_type = ?t
}
  ]
]

Sem<=>ASem attr_NE : transfer_attribute
[
  leftside = [
c:?Xl {
  c:NE = ?NE
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  NE = ?NE
}
  ]
]

excluded Sem<=>ASem attr_NE_NP : transfer_attribute
[
  leftside = [
c:?Xl {
  c:dpos = "NP"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  NE = "YES"
}
  ]
]

Sem<=>ASem attr_num : transfer_attribute
[
  leftside = [
c:?Xl {
  number = ?num
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  number = ?num
}
  ]
]

Sem<=>ASem attr_orig_rel : transfer_attribute
[
  leftside = [
c:?Xl {
  original_rel = ?num
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  original_rel = ?num
}
  ]
]

/*dpos should be VB, NN, RB, JJ (see pos rules below)*/
Sem<=>ASem attr_pos : transfer_attribute
[
  leftside = [
c:?Xl {
  dpos = ?dpos
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  dpos = ?dpos
}
  ]
]

Sem<=>ASem attr_predN : transfer_attribute
[
  leftside = [
c:?Xl {
  pred_Name = ?pn
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  predName = ?pn
}
  ]
]

Sem<=>ASem attr_predV : transfer_attribute
[
  leftside = [
c:?Xl {
  pred_Value = ?pv
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  predValue = ?pv
}
  ]
]

Sem<=>ASem attr_sent_type : transfer_attribute
[
  leftside = [
c:?Xl {
  sent_type = ?tc
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  sent_type = ?tc
}
  ]
]

Sem<=>ASem attr_slex : transfer_attribute
[
  leftside = [
c:?Xl {
  slex = ?v
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  slex = ?v
}
  ]
]

Sem<=>ASem attr_subcat_prep : transfer_attribute
[
  leftside = [
c:?Xl {
  subcat_prep = ?tc
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  subcat_prep = ?tc
}
  ]
]

Sem<=>ASem subcat_prep_new : transfer_attribute
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>ASem attr_tc : transfer_attribute
[
  leftside = [
c:?Xl {
  tem_constituency = ?tc
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  tem_constituency = ?tc
}
  ]
]

Sem<=>ASem attr_tense : transfer_attribute
[
  leftside = [
c:?Xl {
  tense = ?t
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  tense = ?t
}
  ]
]

Sem<=>ASem attr_type : transfer_attribute
[
  leftside = [
c:?Xl {
  type = ?t
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  type = ?t
}
  ]
]

Sem<=>ASem attr_variable_class : transfer_attribute
[
  leftside = [
c:?Xl {
  variable_class = ?u
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  variable_class = ?u
}
  ]
]

Sem<=>ASem attr_vncls : transfer_attribute
[
  leftside = [
c:?Xl {
  vncls = ?vncls
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  vncls = ?vncls
}
  ]
]

Sem<=>ASem attr_voice : transfer_attribute
[
  leftside = [
c:?Xl {
  voice = ?v
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  voice = ?v
}
  ]
]

Sem<=>ASem attr_E2E : transfer_attribute
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>ASem subcat_prep_A0 : subcat_prep_new
[
  leftside = [
c:?Xl {
  A0 = ?tc
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  A0 = ?tc
}
  ]
]

Sem<=>ASem subcat_prep_A1 : subcat_prep_new
[
  leftside = [
c:?Xl {
  A1 = ?tc
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  A1 = ?tc
}
  ]
]

Sem<=>ASem subcat_prep_A2 : subcat_prep_new
[
  leftside = [
c:?Xl {
  A2 = ?tc
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  A2 = ?tc
}
  ]
]

Sem<=>ASem subcat_prep_A3 : subcat_prep_new
[
  leftside = [
c:?Xl {
  A3 = ?tc
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  A3 = ?tc
}
  ]
]

Sem<=>ASem subcat_prep_A4 : subcat_prep_new
[
  leftside = [
c:?Xl {
  A4 = ?tc
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  A4 = ?tc
}
  ]
]

Sem<=>ASem subcat_prep_Location : subcat_prep_new
[
  leftside = [
c:?Xl {
  Location = ?tc
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  Location = ?tc
}
  ]
]

Sem<=>ASem subcat_prep_Time : subcat_prep_new
[
  leftside = [
c:?Xl {
  Time = ?tc
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  Time = ?tc
}
  ]
]

excluded Sem<=>ASem attr_bubble_area : attr_E2E
[
  leftside = [
c:?Xl {
  area = "yes"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  area = "yes"
}
  ]
]

excluded Sem<=>ASem attr_bubble_customerRating : attr_E2E
[
  leftside = [
c:?Xl {
  customerRating = "yes"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  customerRating = "yes"
}
  ]
]

excluded Sem<=>ASem attr_bubble_eatType : attr_E2E
[
  leftside = [
c:?Xl {
  eatType = "yes"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  eatType = "yes"
}
  ]
]

/*Used in grammar 13 to block the node of the restaurant name.*/
Sem<=>ASem attr_bubble_familyFriendly : attr_E2E
[
  leftside = [
c:?Xl {
  familyFriendly = "yes"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  familyFriendly = "yes"
}
  ]
]

excluded Sem<=>ASem attr_bubble_food : attr_E2E
[
  leftside = [
c:?Xl {
  food = "yes"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  food = "yes"
}
  ]
]

excluded Sem<=>ASem attr_bubble_name : attr_E2E
[
  leftside = [
c:?Xl {
  name = "yes"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  name = "yes"
}
  ]
]

excluded Sem<=>ASem attr_bubble_near : attr_E2E
[
  leftside = [
c:?Xl {
  near = "yes"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  near = "yes"
}
  ]
]

excluded Sem<=>ASem attr_bubble_priceRange : attr_E2E
[
  leftside = [
c:?Xl {
  priceRange = "yes"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  priceRange = "yes"
}
  ]
]

