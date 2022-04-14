SSynt<=>SSynt node_word
[
  leftside = [
?Xl {
  ( ¬c:blocked = "yes" | c:cancel_block = "yes" )
  slex = ?s
}

// Don't transfer the Text bubble, which creates issues with linearization afterwards
¬ ( ?s =="Text" & ?Xl { c:?Sent {} } )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex = ?s
}
  ]
]

/*When a coordinating conjunction has to be added.*/
Sem<=>ASem introduce_coord
[
  leftside = [
c:?Sl {
  c:?Zl {
    attach_coord = "yes"
    ¬c:cancel_coord = "yes"
    conjunction_type = ?ct
  }
}

lexicon.miscellaneous.conjunction.coord_rel.?rel1
lexicon.miscellaneous.conjunction.?ct.?lex

lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos
lexicon.?lex.spos.?spos
  ]
  mixed = [

  ]
  rightside = [
rc:?Sr {
  // Disabled because ?Zr could have been moved already to another bubble
  // by another aggregation rule
  //rc:<=> ?Sl
  rc:?Zr {
    rc:<=> ?Zl
    member = "A1"
    n = "1.0"
    ?rel1-> ?ConjR {
      new_node = "yes"
      lex = ?lex
      slex = ?lem
      lemma = ?lem
      pos = ?pos
      spos = ?spos
      id = #randInt()#
      // used to distinguish from another potential coord conj already on ?Zr from the left side
      attach_coord = "yes"
      }
   }
 ?ConjR {}
}
  ]
]

/*Transfers all non-argumental relations.*/
SSynt<=>SSynt rel_copy
[
  leftside = [
c:?Xl {
  //¬c:?N {}
  ¬c:slex = "Sentence"
  ?r-> c: ?Yl {
    //¬c:attach_coord = "yes"
  }
}

// ( ?Xl.dpos == "CD" | ¬?Xl.agg_trig == "yes" | c:?Yl { ¬c:attach_coord = "yes" } )
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

Sem<=>ASem add_rel_precedence
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:id = ?idS1
    ( ¬c:blocked = "yes"
 | c:cancel_block = "yes" )
    c:~ c:?S4l {
      ( c:blocked = "yes" & ¬c:cancel_block = "yes" )
      c:*~ c:?S2l {
        c:id = ?idS2
        ( ¬c:blocked = "yes" | c:cancel_block = "yes" )
      }
    }
  }
}

¬ ( c:?Tl { c:?S3l { c:id = ?idS3 ( ¬c:blocked = "yes" | c:cancel_block = "yes" ) } } & ?idS3 > ?idS1 & ?idS3 < ?idS2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  rc:<=> ?S1l
  ~ rc:?S2r {
    rc:<=> ?S2l
  }
}
  ]
]

SSynt<=>SSynt transfer_rel_coref
[
  leftside = [
c:?Xl {
  <-> c: ?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  <-> rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

SSynt<=>SSynt transfer_rel_precedence
[
  leftside = [
c:?Xl {
  ~ c: ?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ~ rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

SSynt<=>SSynt bubble_fill
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

/*Not needed so far*/
SSynt<=>SSynt bubble_expand_dep
[
  leftside = [
c:?Sl {
  c:blocked = "yes"
  ¬c:cancel_block = "yes"
  c:?Xl {
    c:?r-> c:?Yl {}
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?bubble {
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

/*Not needed so far*/
SSynt<=>SSynt bubble_expand_gov
[
  leftside = [
c:?Sl {
  c:blocked = "yes"
  ¬c:cancel_block = "yes"
  c:?Xl {
    c:?r-> c:?Yl {}
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?bubble {
  rc:?Yr {
    rc:<=> ?Yl
  }
  ¬rc:?Xr { rc:<=> ?Xl }
  rc:+?Xr {
    rc:<=> ?Xl
    rc:?r-> rc:?Yr {}
  }
}
  ]
]

/*Not needed so far*/
SSynt<=>SSynt bubble_expand_gov_include
[
  leftside = [
c:?Sl {
  c:?Xl {
}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?bubble {
  rc:<=> ?Sl
  rc:?Xr {
    rc:<=> ?Xl
    rc:?r-> rc:?Yr {
      rc:include = bubble_of_gov
    }
  }
  rc:+?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

/*For bubbles that have the same property but different objects (e.g. born + date; born + place )
Here we use "lex" on main verbs to check that they are the same, but "slex" in Agg1.*/
SSynt<=>SSynt merge_SameRootSubj_differentObjRel
[
  leftside = [
c:?S2l {
  blocked = "yes"
  applied_agg = "mergeRootSubj"
  ¬c:cancel_block = "yes"
  c:?X2l {
    blocked = "yes"
    c:lex = ?semX2
    c:?r2-> c:?Y2l {
      c:lex = ?semY2
      blocked = "yes"
    }
    c:?s2-> c:?Z2l {
      ¬c:blocked = "yes"
    }
  }
  mergeRootSubj-> c:?S1l {
    c:?X1l {
      c:lex = ?semX1
      attach_mergeRootSubj = "yes"
      c:?r1-> c:?Y1l {
        c:lex = ?semY1
      }
    }
  }
}


?r1 == ?r2
// the property and the subject are the same
?semX1 == ?semX2
( ( ?semY1 == ?semY2 & ?posY1 == "WP" )
 | ( c:?Y2l { c:<-> c:?Y1l {} } | ( c:?Y1l { c:<-> c:?Y0l {} } & c:?Y2l { c:<-> c:?Y0l {} } ) ))

//Both Xs are roots.  Only second needs to be root for now, test this.
//¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// There isn't a dependent on one of the arguments that is not on the dependent of the second sentence (to be improved)
¬ ( c:?Y1l { c:?r4-> c:?Dep4l { c:lex= ?semD4 } } & c:?Y2l { c:?r5-> c:?Dep5l { c:lex= ?semD5 } } & ( ¬?semD4 == ?semD5 | ¬?r4 == ?r5 ) )

// the verbs both have the same verbal tense
( c:?X1l { c:tense = ?tt1 } & c:?X2l { c:tense = ?tt2 } & ?tt1 == ?tt2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  //rc:<=> ?S1l
  rc:?X1r {
    rc:<=> ?X1l
  }
  rc:+?Z2r {
    rc:<=> ?Z2l
  }
}

rc:?X1r {
  rc:<=> ?X1l
  ?s2-> rc:?Z2r {
    rc:<=> ?Z2l
  }
}
  ]
]

/*For bubbles that have the same property but different objects (e.g. born + date; born + place )
Here we use "lex" on main verbs to check that they are the same, but "slex" in Agg1.*/
SSynt<=>SSynt merge_SameRootDep_sameOtherRel
[
  leftside = [
c:?S2l {
  blocked = "yes"
  ¬c:cancel_block = "yes"
  c:?X2l {
    blocked = "yes"
    c:lex = ?semX2
    c:?r2-> c:?Y2l {
      c:lex = ?semY2
      blocked = "yes"
    }
    c:?s2-> c:?Z2l {
      ¬c:blocked = "yes"
    }
  }
  ?r-> c:?S1l {
    c:?X1l {
      c:lex = ?semX1
      c:?r1-> c:?Y1l {
        c:lex = ?semY1
        c:pos = ?posY1
      }
      c:?s1-> c:?Z1l {
        c:attach_coord = "yes"
        c:conjunction_type = ?ct
      }
    }
  }
}


?r1 == ?r2
// the property and the subject are the same
?semX1 == ?semX2
( ( ( ?semY1 == ?semY2 & ?posY1 == "WP" )
 | ( c:?Y2l { c:<-> c:?Y1l {} } | ( c:?Y1l { c:<-> c:?Y0l {} } & c:?Y2l { c:<-> c:?Y0l {} } ) ) )
 | ( c:?Y1l { c:pos = "VB" } & c:?Y2l { c:pos = "VB" } & ?Y1l.lex == ?Y2l.lex ) )

lexicon.miscellaneous.conjunction.coord_conj_rel.?rel2
lexicon.miscellaneous.conjunction.?ct.?lex

//( ?r == mergeRootSubjCoord | ?r == mergeRootObjCoord )
( ( ?r == mergeRootSubjCoord & c:?S2l { c:applied_agg = "mergeRootSubjCoord" } )
  | ( ?r == mergeRootObjCoord & c:?S2l { c:applied_agg = "mergeRootObjCoord" } )
)

// if one of the candidates has a specific status (e.g. meaning=locative_relation or temporal_relation), only apply if the other one has the same status.
( ( ¬?Z1l.meaning == ?mZ1 & ¬?Z2l.meaning == ?mZ2 ) | ?Z1l.meaning == ?Z2l.meaning )

//Both Xs are roots.  Only second needs to be root for now, test this.
//¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// There isn't a dependent on one of the arguments that is not on the dependent of the second sentence (to be improved)
¬ ( c:?Y1l { c:?r4-> c:?Dep4l { c:lex= ?semD4 } } & c:?Y2l { c:?r5-> c:?Dep5l { c:lex= ?semD5 } } & ( ¬?semD4 == ?semD5 | ¬?r4 == ?r5 ) )

// the verbs both have the same verbal tense
( c:?X1l { c:tense = ?tt1 } & c:?X2l { c:tense = ?tt2 } & ?tt1 == ?tt2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  rc:?Z1r {
    rc:<=> ?Z1l
  }
  rc:+?Z2r {
    rc:<=> ?Z2l
  }
}

rc:?Z1r {
  rc:<=> ?Z1l
  rc:?sR-> rc:?ConjR {
    rc:lex = ?lex
    // used to distinguish from another potential coord conj already on ?Zr from the left side
    rc:attach_coord = "yes"
    straight_weight = #?Z2l.straight_weight + 1#
    ?rel2-> rc:?Z2r {
      rc:<=> ?Z2l
    }
  }
}
  ]
]

/*For bubbles that have the same property but different objects (e.g. born + date; born + place )*/
SSynt<=>SSynt noMerge_Coord_1st
[
  leftside = [
c:?S2l {
  ( blocked = "yes" & ¬c:cancel_block = "yes" )
  c:?X2l {
}
  ?mg-> c:?S1l {
    c:?X1l {
      c:attach_coord = "yes"
      c:conjunction_type = ?ct
    }
  }
}

lexicon.miscellaneous.conjunction.coord_conj_rel.?rel2
lexicon.miscellaneous.conjunction.?ct.?lex

( ( ?mg == noMergeCoordSameSubj & c:?S2l { c:applied_agg = "noMergeCoordSameSubj" } )
  | ( ?mg == noMergeCoordSimSubj & c:?S2l { c:applied_agg = "noMergeCoordSimSubj" } )
  | ( ?mg == noMergeCoordSameRoot & c:?S2l { c:applied_agg = "noMergeCoordSameRoot"} )
  | ( ?mg == noMergeCoordContrastLex & c:?S2l { c:applied_agg = "noMergeCoordContrastLex" } )
)

//Both Xs are roots
//¬c:?Gov3l { c:?r3-> c:?X1l {} }
¬c:?Gov4l { c:?r4-> c:?X2l {} }

// In case several aggregations apply, there can be more than one anchor; reduce possibilities based on PoS?
// WebNLG2017 Test 63
( ?X2l.pos == ?X1l.pos | ( ?X2l.pos == "VB" & ?X1l.pos == "MD" ) | ( ?X1l.pos == "VB" & ?X2l.pos == "MD" ) )

// There isn't another sentence to be merged between S1 and S2
¬ ( c:?S1l { c:*~ c:?S0l { c:*~ c:?S2l { } c:?mg2-> c:?S1l {} } }
  & ( ( ?mg2 == noMergeCoordSameSubj & c:?S0l { c:applied_agg = "noMergeCoordSameSubj" } )
      | ( ?mg2 == noMergeCoordSimSubj & c:?S0l { c:applied_agg = "noMergeCoordSimSubj" } )
      | ( ?mg2 == noMergeCoordSameRoot & c:?S0l { c:applied_agg = "noMergeCoordSameRoot"} )
      | ( ?mg2 == noMergeCoordContrastLex & c:?S0l { c:applied_agg = "noMergeCoordContrastLex" } ) )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  //rc:<=> ?S1l
  rc:?X1r {
    rc:<=> ?X1l
    rc:?R-> rc:?ConjR {
      rc:lex = ?lex
      ?rel2-> rc:?X2r {
        rc:<=> ?X2l
      }
    }
  }
  rc:+?X2r {
    rc:<=> ?X2l
  }
}
  ]
]

/*For bubbles that have the same property but different objects (e.g. born + date; born + place )*/
SSynt<=>SSynt noMerge_Coord_next
[
  leftside = [
c:?S2l {
  c:?X2l {
    c:attach_coord = "yes"
    c:conjunction_type = ?ct
  
}
  c:?mg1-> c:?S1l {
}
  c:*~ c:?S3l {
    // no c: on blocked gives an overlap sometimes, check that
    // 200229_test_triples...0450-0899.conll, sent 202
    ( c:blocked = "yes" & ¬c:cancel_block = "yes" )
    c:?X3l {}
    ?mg2-> c:?S1l {}
  }
}

// ?mg1 == ?mg2

( ( ?mg1 == noMergeCoordSameSubj & c:?S2l { c:applied_agg = "noMergeCoordSameSubj" } )
  | ( ?mg1 == noMergeCoordSimSubj & c:?S2l { c:applied_agg = "noMergeCoordSimSubj" } )
  | ( ?mg1 == noMergeCoordSameRoot & c:?S2l { c:applied_agg = "noMergeCoordSameRoot"} )
  | ( ?mg1 == noMergeCoordContrastLex & c:?S2l { c:applied_agg = "noMergeCoordContrastLex" } )
)

( ( ?mg2 == noMergeCoordSameSubj & c:?S3l { c:applied_agg = "noMergeCoordSameSubj" } )
  | ( ?mg2 == noMergeCoordSimSubj & c:?S3l { c:applied_agg = "noMergeCoordSimSubj" } )
  | ( ?mg2 == noMergeCoordSameRoot & c:?S3l { c:applied_agg = "noMergeCoordSameRoot"} )
  | ( ?mg2 == noMergeCoordContrastLex & c:?S3l { c:applied_agg = "noMergeCoordContrastLex" } )
)



lexicon.miscellaneous.conjunction.coord_conj_rel.?rel2
lexicon.miscellaneous.conjunction.?ct.?lex

//Both Xs are roots
¬c:?Gov4l { c:?r4-> c:?X2l {} }
¬c:?Gov5l { c:?r5-> c:?X3l {} }

// There isn't another sentence to be merged between S2 and S3
¬ ( c:?S2l { c:*~ c:?S0l { c:*~ c:?S3l { } c:?mg3-> c:?S1l {} } }
  & ( ( ?mg3 == noMergeCoordSameSubj & c:?S0l { c:applied_agg = "noMergeCoordSameSubj" } )
      | ( ?mg3 == noMergeCoordSimSubj & c:?S0l { c:applied_agg = "noMergeCoordSimSubj" } )
      | ( ?mg3 == noMergeCoordSameRoot & c:?S0l { c:applied_agg = "noMergeCoordSameRoot"} )
      | ( ?mg3 == noMergeCoordContrastLex & c:?S0l { c:applied_agg = "noMergeCoordContrastLex" } ) )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  //rc:<=> ?S1l
  rc:?X2r {
    rc:<=> ?X2l
    rc:?R-> rc:?ConjR {
      rc:lex = ?lex
      ?rel2-> rc:?X3r {
        rc:<=> ?X3l
      }
    }
  }
  rc:+?X3r {
    rc:<=> ?X3l
  }
}
  ]
]

excluded SSynt<=>SSynt mark_replace_conjunction
[
  leftside = [
c:?S2l {
  c:?X2l {}
  c:noMergeCoord-> c:?S1l {
}
  c:*~ c:?S3l {
    c:?X3l {}
    c:noMergeCoord-> c:?S1l {}
  }
}


lexicon.miscellaneous.conjunction.coord_rel.?rel1
lexicon.miscellaneous.conjunction.coord_conj_rel.?rel2

//Both Xs are roots
¬c:?Gov4l { c:?r4-> c:?X2l {} }
¬c:?Gov5l { c:?r5-> c:?X3l {} }

// There isn't another sentence to be merged between S2 and S3
c:?S2l { ¬c:*~ c:?S0l { c:*~ c:?S3l { } c:noMergeCoord-> c:?S1l {} } }
  ]
  mixed = [

  ]
  rightside = [
rc:?And1r {
  rc:pos = "CC"
  comma_substitute = "yes"
  rc:?REL2-> rc:?X2r {
    rc:<=> ?X2l
    rc:?REL1-> rc:?ConjR {
      rc:pos = "CC"
      //rc:lex = ?lex
      rc:?REL3-> rc:?X3r {
        rc:<=> ?X3l
      }
    }
  }
}

// BUG: can't use ?rel1 and ?rel2 directly
?REL1 == ?rel1
?REL2 == ?rel2
?REL3 == ?rel2
  ]
]

/*Some coordinations are moved during this transduction, so there may be a need for changing some conjunctions by commas.*/
SSynt<=>SSynt cord_comma_substitute
[
  leftside = [
c:?Xl {}

lexicon.miscellaneous.conjunction.coord_conj_rel.?conj
lexicon.miscellaneous.conjunction.coord_rel.?coord
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
}

rc:?And1 {
  rc:lex = ?lex1
  rc:slex = ?s
  comma_substitute = "yes"
  rc:?conjR-> rc:?Xr {
    rc:?coordR-> rc:?And2 {
      rc:lex = ?lex2
    }
  }
}

?lex1 == ?lex2
?conjR == ?conj
?coordR == ?coord
  ]
]

SSynt<=>SSynt EN_merge_SameRootObjLoc_sameSubjRel_AND
[
  leftside = [
c:?Tl {
  c:?S2l {
    c:?X2l {
      c:lex = "be_VB_01"
      blocked = "yes"
      c:SBJ-> c:?There2 {
        c:slex = "there"
        blocked = "yes"
      }
      c:PRD-> c:?Z2l {}
      c:ADV-> c:?IN2l {
        // c:pos = "IN"
        blocked = "yes"
        // c:PMOD-> c:?Y2l {
          // blocked = "yes"
        // }
      }
    }
    c:?mg-> c:?S1l {
      c:?X1l {
        c:lex = "be_VB_01"
        c:SBJ-> c:?There1 {
          c:slex = "there"
        }
        c:PRD-> c:?Z1l {
          c:attach_coord = "yes"
          c:conjunction_type = ?ct
        }
        c:ADV-> c:?IN1l {
          c:pos = "IN"
          c:PMOD-> c:?Y1l {}
        }
      }
    }
  }
}

lexicon.miscellaneous.conjunction.coord_conj_rel.?rel2
lexicon.miscellaneous.conjunction.?ct.?lex

( ( ?mg == mergeRootSubjCoordAndLoc & c:?S2l { c:applied_agg = "mergeRootSubjCoordAndLoc" } )
  | ( ?mg == mergeRootSubjCoordContrastLoc & c:?S2l { c:applied_agg = "mergeRootSubjCoordContrastLoc" } )
  | ( ?mg == mergeRootSubjCoordAndLocIn & c:?S2l { c:applied_agg = "mergeRootSubjCoordAndLocIn" } )
  | ( ?mg == mergeRootSubjCoordContrastLocIn & c:?S2l { c:applied_agg = "mergeRootSubjCoordContrastLocIn" } )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  rc:?Z1r {
    rc:<=> ?Z1l
  }
  rc:+?Z2r {
    rc:<=> ?Z2l
  }
}

rc:?Z1r {
  rc:<=> ?Z1l
  rc:?sR-> rc:?ConjR {
    rc:lex = ?lex
    // used to distinguish from another potential coord conj already on ?Zr from the left side
    rc:attach_coord = "yes"
    // large weight so it is linearised after another eventual coordination on the same node (Z1r)
    straight_weight = #?Z2l.straight_weight + 100#
    ?rel2-> rc:?Z2r {
      rc:<=> ?Z2l
    }
  }
}
  ]
]

SSynt<=>SSynt EN_merge_SameRootSubj_sameObjRel_Interrogatives_1st : EN_merge_SameRootObjLoc_sameSubjRel_AND
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?SupportV1{
      c:clause_type = "INT"
      c:spos = auxiliary
      c:tense = ?tense1
      c:VC-> c:?MainV1 {
        c:lex = ?semV1
        c:?r1-> c:?Obj1 {}
      }
      c:SBJ-> c:?Subj1 {
        c:lex = ?semS1
      }
      // there is not other dependent
      ¬c:?OD1-> c:?OtherDep1 {}
    }
    c:*~ c:?S2l {
      c:?SupportV2 {
        c:clause_type = "INT"
        c:spos = auxiliary
        c:tense = ?tense2
        c:VC-> c:?MainV2 {
          c:lex = ?semV2
          c:?r2-> c:?Obj2 {
            //c:coord_type = ?ct
          }
        }
        c:SBJ-> c:?Subj2 {
          c:lex = ?semS2
        }
        // there is not other dependent
        ¬c:?OD2-> c:?OtherDep2 {}
      }
    }
  }
}

lexicon.miscellaneous.conjunction.coord_conj_rel.?rel2

// the object relation is the same
?r1 == ?r2

// the main verb and the subject are the same
?semV1 == ?semV2
?semS1 == ?semS2

// the support verbs both have the same verbal tense
?tense1 == ?tense2


//( c:?Obj2 { coord_type = ?ct } | lexicon.miscellaneous.conjunction.?ct.and_CC_01 )
//lexicon.miscellaneous.conjunction.?ct.and_CC_01

// There isn't a dependent on one of the subjects that is not a dependent of the subject in the other sentence (to be improved)
// SHOULDN'T THIS CONDITION BE REPEATED ON THE COMPLEX CONDITIONS BELOW?
¬ ( c:?Subj1 { c:?r4-> c:?Dep4l { c:slex= ?semD4 } } & c:?Subj2 { c:?r5-> c:?Dep5l { c:slex= ?semD5 } } & ( ¬?semD4 == ?semD5 | ¬?r4 == ?r5 ) )

// There isn't another sentence to be merged between S1 and S2
¬ ( c:?S1l { c:*~ c:?S0l { c:*~ c:?S2l { } c:mergeRootSubjCoord-> c:?S1l {} } } )

// ?S1l is the lightest sentence, to which all other sentences will point (simplified to first ID for now)
¬ (
c:?Tl {
  c:?S3l {
  c:*~ c:?S1l {}
  c:id = ?id3
    c:?SupportV3{
      c:clause_type = "INT"
      c:spos = auxiliary
      c:tense = ?tense3
      c:VC-> c:?MainV3 {
        c:lex = ?semV3
        c:?r3-> c:?Obj3 {}
      }
      c:SBJ-> c:?Subj3 {
        c:lex = ?semS3
      }
      // there is not other dependent
      ¬c:?OD3-> c:?OtherDep3 {}
    }
  }
}
  & ?r1 == ?r2
  & ?semV1 == ?semV2
  & ?semS1 == ?semS2
  & ?tense1 == ?tense2
  & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
)
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  rc:?Obj1r {
    rc:<=> ?Obj1
  }
  rc:+?Obj2r {
    rc:<=> ?Obj2
  }
}

rc:?Obj1r {
  rc:<=> ?Obj1
  rc:?sR-> rc:?ConjR {
    rc:lex = ?lex
    // used to distinguish from another potential coord conj already on ?Zr from the left side
    rc:attach_coord = "yes"
    straight_weight = #?Obj2.straight_weight + 1#
    ?rel2-> rc:?Obj2r {
      rc:<=> ?Obj2
    }
  }
}
  ]
]

SSynt<=>SSynt EN_merge_SameRootSubj_sameObjRel_Interrogatives_next : EN_merge_SameRootObjLoc_sameSubjRel_AND
[
  leftside = [
c:?S2l {
  c:?Obj2 {
    c:mergeRootSubjCoord = "anchor"
    c:attach_coord = "yes"
    c:conjunction_type = ?ct2
  }
  c:mergeRootSubjCoord-> c:?S1l {}
  c:*~ c:?S3l {
    blocked = "yes"
    ¬c:cancel_block = "yes"
    applied_agg = "mergeRootSubjCoord"
    c:?Obj3 {
      mergeRootSubjCoord = "anchor"
    }
    mergeRootSubjCoord-> c:?S1l {}
  }
}

lexicon.miscellaneous.conjunction.coord_conj_rel.?rel3
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  rc:?Obj2r {
    rc:<=> ?Obj2
  }
  rc:+?Obj3r {
    rc:<=> ?Obj3
  }
}

rc:?Obj2r {
  rc:<=> ?Obj2
  rc:?sR-> rc:?ConjR {
    rc:lex = ?lex
    // used to distinguish from another potential coord conj already on ?Zr from the left side
    rc:attach_coord = "yes"
    straight_weight = #?Obj3.straight_weight + 1#
    ?rel3-> rc:?Obj3r {
      rc:<=> ?Obj3
    }
  }
}
  ]
]

/*This rule aims as moving dependents that are left after their governor was blocked during the aggregation.
The dependent are moved to the coreferring node in the destination sentence of the rest of the unblocked nodes.*/
SSynt<=>SSynt relocate_dependents_of_blocked
[
  leftside = [
c:?Tl {
  c:?S2l {
    c:blocked = "yes"
    ¬c:cancel_block = "yes"
    c:?Y2l {
      c:blocked = "yes"
      c:?s2-> c:?Dep2 {
        ¬c:blocked = "yes"
      }
    }
    c:?merge-> c:?S1l {
      c:?Y1l {}
    }
  }
}

( c:?Y2l { c:<-> c:?Y1l {} } | ( c:?Y1l { c:<-> c:?Y0l {} } & c:?Y2l { c:<-> c:?Y0l {} } ) )

¬?Y1l.spos == "relative_pronoun"
¬?Y1l.spos == relative_pronoun
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  rc:<=> ?S1l
  rc:?Y1r {
    rc:<=> ?Y1l
    ?s2-> rc:?Dep2r {
      rc:<=> ?Dep2
    }
  }
  rc:+?Dep2r {}
}
  ]
]

/*if the rules at this level bring together two (or more) relative clauses below the same node, add a coord conj to the 2nd relative and forward.*/
excluded SSynt<=>SSynt EN_add_coord_multiple_relatives
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*For bubbles that have the same property but different objects (e.g. born + date; born + place )*/
excluded SSynt<=>SSynt merge_SameRootSubj_sameObjRel_Elab
[
  leftside = [
c:?S2l {
  blocked = "yes"
  c:?X2l {
    blocked = "yes"
    c:sem = ?semX2
    c:?r2-> c:?Y2l {
      c:sem = ?semY2
      blocked = "yes"
    }
    c:?s2-> c:?Z2l {
      ¬c:blocked = "yes"
    }
  }
  mergeRootSubjElab-> c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:?r1-> c:?Y1l {
        c:sem = ?semY1
      }
      c:?s1-> c:?Z1l {
        c:attach_elab = "yes"
      }
    }
  }
}


?r1 == ?r2
// the property and the subject are the same
?semX1 == ?semX2
?semY1 == ?semY2
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  //rc:<=> ?S1l
  rc:?Z1r {
    rc:<=> ?Z1l
  }
  rc:+?Z2r {
    rc:<=> ?Z2l
  }
}

rc:?Z1r {
  rc:<=> ?Z1l
  Elaboration-> rc:?Z2r {
    rc:<=> ?Z2l
    type = "parenthetical"
  }
}
  ]
]

SSynt<=>SSynt add_also_fromSynt_noWhile
[
  leftside = [
c:?S1l {
  c:?Root1 {
    c:slex = ?slr1
    c:?r1-> c:?Subj1 {
      c:dsyntRel= I
    }
    c:?s1-> c:?Obj1 {
      c:dsyntRel= II
      c:slex = ?slo1
      ¬c:?t1-> c:?Dep2 {}
    }
  }
  c:~ c:?S2l {
    c:?Root2 {
    ¬c:type = "add_also"
      c:slex = ?slr2
      c:?r2-> c:?Subj2 {
        c:dsyntRel= I
      }
      c:?s2-> c:?Obj2 {
        c:dsyntRel= II
        c:slex = ?slo2
        ¬c:?t2-> c:?Dep2 {}
      }
    }
  }
}
// Roots are roots
¬ c:?Gov1 { c:?g1-> c:?Root1 {}}
¬ c:?Gov2 { c:?g2-> c:?Root2 {}}
//The root and the object are the same (the object has no dependent; can relax rule when subtree identity checking is made possible)
?slr1 ==  ?slr2
?slo1 ==  ?slo2

lexicon.miscellaneous.adverbs.also.?lex
lexicon.miscellaneous.adverbs.rel.?R
lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos
lexicon.?lex.spos.?spos

// ?S1 is not moved
¬ c:?S1l { c:?rMerge3-> c:?S3l {} }

// ?S1 will not receive a contrasted coordination (A is high while B is low)
¬ ( c:?S4l { c:?rMerge4-> c:?S1l {} } & c:?Root1 { c:conjunction_type = "contrast" } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Root2
  rc:slex = ?s
  ?R-> ?IT {
    slex = ?lem
    lex = ?lex
    pos = ?pos
    spos = ?spos
    dsyntRel = ATTR
    include = bubble_of_gov
    id = #randInt()#
  }
}
  ]
]

SSynt<=>SSynt add_also_fromSynt_While
[
  leftside = [
c:?S1l {
  c:?Root1 {
    c:conjunction_type = "contrast"
  }
  c:*~ c:?S2l {
    c:?Root2 {
    ¬c:type = "add_also"
      c:lex = ?lr2
      c:?r2-> c:?Subj2 {
        c:dsyntRel= I
      }
      c:?s2-> c:?Obj2 {
        c:dsyntRel= II
        c:lex = ?lo2
        ¬c:?t2-> c:?Dep2 {}
      }
    }
    ¬c:?rMerge2-> c:?SXl {}
  }
  c:*~c:?S3l {
    c:?Root3 {
      ¬c:type = "add_also"
      c:lex = ?lr3
      c:?r3-> c:?Subj3 {
        c:dsyntRel= I
      }
      c:?s3-> c:?Obj3 {
        c:dsyntRel= II
        c:lex = ?lo3
        ¬c:?t3-> c:?Dep3 {}
      }
    }
    c:?rMerge3-> c:?S1l {}
  }
}

// Roots are roots
¬ c:?Gov3 { c:?g3-> c:?Root3 {}}
¬ c:?Gov2 { c:?g2-> c:?Root2 {}}
//The root and the object are the same (the object has no dependent; can relax rule when subtree identity checking is made possible)
?lr3 ==  ?lr2
?lo2 == ?lo3

// roots are copulas
lexicon.miscellaneous.verbs.copula.?lr2

lexicon.miscellaneous.adverbs.also.?lex
lexicon.miscellaneous.adverbs.rel.?R
lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos
lexicon.?lex.spos.?spos

// There is no need to make sure that S3 is the last aggregated sentence since for now aggregations with contrast can only apply to two sentences.
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  rc:<=> ?S1l
  rc:~ rc:?S2r {
    rc:<=> ?S2l
  }
}

rc:?Yr {
  rc:<=> ?Root2
  rc:slex = ?s
  ?R-> ?IT {
    slex = ?lem
    lex = ?lex
    pos = ?pos
    spos = ?spos
    dsyntRel = ATTR
    include = bubble_of_gov
    id = #randInt()#
  }
}
  ]
]

SSynt<=>SSynt transfer_attributes
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

SSynt<=>SSynt weight
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*If a subtree is relocated within a subtree marked with nmodif, mark the moved subtree too.*/
SSynt<=>SSynt nmodif
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

SSynt<=>SSynt agreement
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

SSynt<=>SSynt mark_block
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*If a node X2 has a coreference relation with a NE node of another bubble in which there is another NE, mark X2.
If no NE has a class.*/
excluded Sem<=>ASem mark_ambiguous_antecedent_coref
[
  leftside = [
c:?S1l {
  c:?X1l {
    c:NE = "YES"
  }
  c:*~ c:?S2l {
    c:?X2l {
      c:<-> c:?X1l {}
    } 
  }
}

// If  X1 is the subject of the main verb, let the pronominalisation take place.
¬ ( c:?GovX1 { c:?r1-> c:?X1l {} } & ¬c:?GrandGov { c:?r2-> c:?GovX1 {} }
    & lexicon.dependencies_default_map.I.rel.?r1 )
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  rc:<=> ?S1l
  rc:slex = "Sentence"
  rc:?X1r {
    rc:<=> ?X1l
    rc:id = ?id1
    rc:NE = "YES"
    ¬rc:class = ?mX1
  }
  rc:?X3r {
    rc:id = ?id3
    rc:NE = "YES"
    ¬rc:class = ?mX3
    ¬rc:pos = "CD"
    ¬rc:slex = "e-book"
    ¬rc:relativized = yes
  }
}
//  rc:~ rc:?S2r {
//    rc:<=> ?S2l
    rc:?X2r {
      rc:<=> ?X2l
      ambiguous_antecedent = "yes"
    }
//  }
//}

// We shouldn't be requesting that S2r corrsponds to S2l since node can move bubbles during the aggregation.
// When deactivated, we need some additional rules to check if whithin S2, X2 may not be ambiguous anymore, e.g. if there is an element coreferring with it above in the tree.
(  rc:?S1r { rc:?X2r {} } | rc:?S1r { rc:~ rc:?S2r { rc:<=> ?S2l rc:?X2r { } } } )

¬ ?id1 == ?id3

¬ ( ?X1r.id == ?X3r.antecedent_id )
¬ ( ?X3r.id == ?X1r.antecedent_id )
//¬ ( ?X1r.antecedent_id == ?X3r.antecedent_id )
//¬ ( rc:?X1r { rc:antecedent_id = ?aid1 } & rc:?X3r { rc:antecedent_id = ?aid3 } & ?aid1 == ?aid3 )
¬ ( ?X1r.antecedent_id > 0 & ?X1r.antecedent_id == ?X3r.antecedent_id )

// BUG? This condition doesnt't seem to work, I suspect that the correspondences are being used to link RS variables.
¬ ( rc:?X3r { rc:slex = ?sx } & ( ?sx == 0 |  ?sx < 0 | ?sx > 0 | ?sx == "e-book" ) )

// Doesn't work; BUG? Split in two rules.
//( ( rc:?X1r { ¬rc:class = ?mX1 } & rc:?X3r { ¬rc:class = ?mX3 } ) | ?X1r.class == ?X3r.class )

//BUG can't use coref rels with rc:
//rc:?X1r { ¬ rc:<-> rc:?X3r {} }
//rc:?X3r { ¬ rc:<-> rc:?X1r {} }
//¬ ( rc:?X1r { rc:<-> rc:?Xante {} } & rc:?X3r { rc:<-> rc:?Xante {} } )
  ]
]

/*If a node X2 has a coreference relation with a NE node of another bubble in which there is another NE, mark X2.
If both NEs have a class.*/
excluded Sem<=>ASem mark_ambiguous_antecedent_coref_class
[
  leftside = [
c:?S1l {
  c:?X1l {
    c:NE = "YES"
  }
  c:*~ c:?S2l {
    c:?X2l {
      c:<-> c:?X1l {}
    } 
  }
}

// If  X1 is the subject of the main verb, let the pronominalisation take place.
( ¬ ( c:?GovX1 { c:?r1-> c:?X1l {} } & ¬c:?GrandGov { c:?r2-> c:?GovX1 {} } & lexicon.dependencies_default_map.I.rel.?r1 )
  // but if the subject had conjuncts below that could be ambiguous, back to blocking the pronominalisation.
  | ( c:?X1l { c:?Coord-> c:?And { c:?Conj-> c:?XConj { c:class = ?class } } } & ?class == ?X1l.class
      & lexicon.dependencies_default_map.COORD.rel.?Coord & lexicon.dependencies_default_map.II.rel.?Conj )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  rc:<=> ?S1l
  rc:?X1r {
    rc:<=> ?X1l
    rc:id = ?id1
    rc:NE = "YES"
    rc:class = ?mX1
  }
  rc:?X3r {
    rc:id = ?id3
    rc:NE = "YES"
    rc:class = ?mX3
    ¬rc:relativized = yes
  }
}
//  rc:~ rc:?S2r {
//    rc:<=> ?S2l
    rc:?X2r {
      rc:<=> ?X2l
      ambiguous_antecedent = "yes"
    }
//  }
//}

// We shouldn't be requesting that S2r corrsponds to S2l since node can move bubbles during the aggregation.
// When deactivated, we need some additional rules to check if whithin S2, X2 may not be ambiguous anymore, e.g. if there is an element coreferring with it above in the tree.
(  rc:?S1r { rc:?X2r {} } | rc:?S1r { rc:~ rc:?S2r { rc:<=> ?S2l rc:?X2r {} } } )

¬ ?id1 == ?id3

// Doesn't work; BUG? Split in two rules.
//( ( rc:?X1r { ¬rc:class = ?mX1 } & rc:?X3r { ¬rc:class = ?mX3 } ) | ?X1r.class == ?X3r.class )
?mX1 == ?mX3

¬ ( ?X1r.id == ?X3r.antecedent_id )
¬ ( ?X3r.id == ?X1r.antecedent_id )
//¬ ( ?X1r.antecedent_id == ?X3r.antecedent_id )
//¬ ( rc:?X1r { rc:antecedent_id = ?aid1 } & rc:?X3r { rc:antecedent_id = ?aid3 } & ?aid1 == ?aid3 )
¬ ( ?X1r.antecedent_id > 0 & ?X1r.antecedent_id == ?X3r.antecedent_id )

//BUG can't use coref rels with rc:
//rc:?X1r { ¬ rc:<-> rc:?X3r {} }
//rc:?X3r { ¬ rc:<-> rc:?X1r {} }
//¬ ( rc:?X1r { rc:<-> rc:?Xante {} } & rc:?X3r { rc:<-> rc:?Xante {} } )
  ]
]

/*If a node X2 has a coreference relation with a NE node of another bubble in which there is another NE, mark X2.
If one NE has a class, and the other doesn't.
For classes that are referred to with the same kind of pronoun (non persons), there is ambiguity if a pronoun is introduced.*/
excluded Sem<=>ASem mark_ambiguous_antecedent_coref_both
[
  leftside = [
c:?S1l {
  c:?X1l {
    c:NE = "YES"
  }
  c:*~ c:?S2l {
    c:?X2l {
      c:<-> c:?X1l {}
    } 
  }
}

// If  X1 is the subject of the main verb, let the pronominalisation take place.
( ¬ ( c:?GovX1 { c:?r1-> c:?X1l {} } & ¬c:?GrandGov { c:?r2-> c:?GovX1 {} } & lexicon.dependencies_default_map.I.rel.?r1 )
  // but if the subject had conjuncts below that could be ambiguous, back to blocking the pronominalisation.
  | ( c:?X1l { c:?Coord-> c:?And { c:?Conj-> c:?XConj { c:class = ?class } } } & ?class == ?X1l.class
      & lexicon.dependencies_default_map.COORD.rel.?Coord & lexicon.dependencies_default_map.II.rel.?Conj )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  rc:<=> ?S1l
  rc:?X1r {
    rc:<=> ?X1l
    rc:id = ?id1
    rc:NE = "YES"
    rc:class = ?mX1
  }
  rc:?X3r {
    rc:id = ?id3
    rc:NE = "YES"
    ¬rc:class = ?mX3
    ¬rc:pos = "CD"
    ¬rc:slex = "e-book"
    ¬rc:relativized = yes
  }
}
//  rc:~ rc:?S2r {
//    rc:<=> ?S2l
    rc:?X2r {
      rc:<=> ?X2l
      ambiguous_antecedent = "yes"
    }
//  }
//}

// We shouldn't be requesting that S2r corrsponds to S2l since node can move bubbles during the aggregation.
// When deactivated, we need some additional rules to check if whithin S2, X2 may not be ambiguous anymore, e.g. if there is an element coreferring with it above in the tree.
(  rc:?S1r { rc:?X2r {} } | rc:?S1r { rc:~ rc:?S2r { rc:<=> ?S2l rc:?X2r {} } } )

¬ ?id1 == ?id3

// Doesn't work; BUG? Split in two rules.
//( ( rc:?X1r { ¬rc:class = ?mX1 } & rc:?X3r { ¬rc:class = ?mX3 } ) | ?X1r.class == ?X3r.class )
¬ ?mX1 == "Person"

¬ ( ?X1r.id == ?X3r.antecedent_id )
¬ ( ?X3r.id == ?X1r.antecedent_id )
//¬ ( ?X1r.antecedent_id == ?X3r.antecedent_id )
//¬ ( rc:?X1r { rc:antecedent_id = ?aid1 } & rc:?X3r { rc:antecedent_id = ?aid3 } & ?aid1 == ?aid3 )
¬ ( ?X1r.antecedent_id > 0 & ?X1r.antecedent_id == ?X3r.antecedent_id )

// BUG? This condition doesnt't seem to work, I suspect that the correspondences are being used to link RS variables.
¬ ( rc:?X3r { rc:slex = ?sx } & ( ?sx == 0 |  ?sx < 0 | ?sx > 0 | ?sx == "e-book" ) )

//BUG can't use coref rels with rc:
//rc:?X1r { ¬ rc:<-> rc:?X3r {} }
//rc:?X3r { ¬ rc:<-> rc:?X1r {} }
//¬ ( rc:?X1r { rc:<-> rc:?Xante {} } & rc:?X3r { rc:<-> rc:?Xante {} } )
  ]
]

/*If a node X2 has a coreference relation with a NE node of another bubble in which there is another NE, mark X2.
*/
excluded Sem<=>ASem mark_ambiguous_antecedent_coref_SentBetween
[
  leftside = [
c:?S1l {
  c:?X1l {
    c:NE = "YES"
  }
  c:*~ c:?S2l {
    c:?X2l {
      c:<-> c:?X1l {}
    } 
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  rc:<=> ?S1l
  rc:id = ?id1
  rc:slex = "Sentence"
  rc:?X1r {
    rc:<=> ?X1l
    rc:NE = "YES"
    ¬rc:class = ?mX1
  }
  rc:*~ rc:?Snr {
    rc:id = ?idn
    rc:?X3r {
      rc:NE = "YES"
      ¬rc:class = ?mX3
      ¬rc:pos = "CD"
      ¬rc:slex = "e-book"
      ¬rc:relativized = yes
    }
    // we should check that RootR is a root, but doesn't seem to work (see bottom of RS)
    // ¬rc:?RootR { rc:SBJ-> rc:?CorefR { rc:antecedent_id = ?idCr } }
    rc:~ rc:?S2r {
    // We shouldn't be requesting that S2r corrsponds to S2l since node can move bubbles during the aggregation.
    // When deactivated, we need some additional rules to check if whithin S2, X2 may not be ambiguous anymore, e.g. if there is an element coreferring with it above in the tree.
      rc:<=> ?S2l
      rc:id = ?id2
      rc:?X2r {
        rc:<=> ?X2l
        ambiguous_antecedent = "yes"
      }
    }
  }
}

¬ ?id1 == ?idn
¬ ?id1 == ?id2

//BUG can't use coref rels with rc:
//rc:?X1r { ¬ rc:<-> rc:?X3r {} }
//rc:?X3r { ¬ rc:<-> rc:?X1r {} }
//¬ ( rc:?X1r { rc:<-> rc:?Xante {} } & rc:?X3r { rc:<-> rc:?Xante {} } )
¬ ( ?X1r.id == ?X3r.antecedent_id )
¬ ( ?X3r.id == ?X1r.antecedent_id )
//¬ ( ?X1r.antecedent_id == ?X3r.antecedent_id )
//¬ ( rc:?X1r { rc:antecedent_id = ?aid1 } & rc:?X3r { rc:antecedent_id = ?aid3 } & ?aid1 == ?aid3 )
¬ ( ?X1r.antecedent_id > 0 & ?X1r.antecedent_id == ?X3r.antecedent_id )

// BUG? This condition doesnt't seem to work, I suspect that the correspondences are being used to link RS variables.
¬ ( rc:?X3r { rc:slex = ?sx } & ( ?sx == 0 |  ?sx < 0 | ?sx > 0 | ?sx == "e-book" ) )

// Doesn't work; BUG? Split in two rules.
//( ( rc:?X1r { ¬rc:class = ?mX1 } & rc:?X3r { ¬rc:class = ?mX3 } ) | ?X1r.class == ?X3r.class )

// If  the main verb of the sentence that contains Xr3 has a subject that corefers with X2, let the pronominalisation take place; can't make RS lexicon calls; BUG: doesn't work?
//¬ ( rc:?Snr { rc:?Root1R { rc:SBJ-> rc:?Coref1R { rc:antecedent_id = ?idC1r } } } & ?idCr1 == ?X1r.id & ¬rc:?GrandGov1 { rc:?r1-> rc:?Root1R {} } )
  ]
]

/*If a node X2 has a coreference relation with a NE node of another bubble in which there is another NE, mark X2.
If both NEs have a class.*/
excluded Sem<=>ASem mark_ambiguous_antecedent_coref_class_SentBetween
[
  leftside = [
c:?S1l {
  c:?X1l {
    c:NE = "YES"
  }
  c:*~ c:?S2l {
    c:?X2l {
      c:<-> c:?X1l {}
    } 
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  rc:<=> ?S1l
  rc:id = ?id1
  rc:?X1r {
    rc:<=> ?X1l
    rc:NE = "YES"
    rc:class = ?mX1
  }
  rc:*~ rc:?Snr {
    rc:id = ?idn
    rc:?X3r {
      rc:NE = "YES"
      rc:class = ?mX3
      ¬rc:relativized = yes
    }
    rc:~ rc:?S2r {
    // We shouldn't be requesting that S2r corrsponds to S2l since node can move bubbles during the aggregation.
    // When deactivated, we need some additional rules to check if whithin S2, X2 may not be ambiguous anymore, e.g. if there is an element coreferring with it above in the tree.
      rc:<=> ?S2l
      rc:id = ?id2
      rc:?X2r {
        rc:<=> ?X2l
        ambiguous_antecedent = "yes"
      }
    }
  }
}

¬ ?id1 == ?idn
¬ ?id1 == ?id2

// Doesn't work; BUG? Split in two rules.
//( ( rc:?X1r { ¬rc:class = ?mX1 } & rc:?X3r { ¬rc:class = ?mX3 } ) | ?X1r.class == ?X3r.class )
?mX1 == ?mX3

//BUG can't use coref rels with rc:
//rc:?X1r { ¬ rc:<-> rc:?X3r {} }
//rc:?X3r { ¬ rc:<-> rc:?X1r {} }
//¬ ( rc:?X1r { rc:<-> rc:?Xante {} } & rc:?X3r { rc:<-> rc:?Xante {} } )
¬ ( ?X1r.id == ?X3r.antecedent_id )
¬ ( ?X3r.id == ?X1r.antecedent_id )
//¬ ( ?X1r.antecedent_id == ?X3r.antecedent_id )
//¬ ( rc:?X1r { rc:antecedent_id = ?aid1 } & rc:?X3r { rc:antecedent_id = ?aid3 } & ?aid1 == ?aid3 )
¬ ( ?X1r.antecedent_id > 0 & ?X1r.antecedent_id == ?X3r.antecedent_id )

// If  X3 is the subject of the main verb, let the pronominalisation take place; can't make RS lexicon calls
¬ ( rc:?GovX1 { rc:SBJ-> rc:?X3r {} } & ¬rc:?GrandGov1 { rc:?r1-> rc:?X3r {} } )
¬ ( rc:?GovX2 { rc:subj-> rc:?X3r {} } & ¬rc:?GrandGov2 { rc:?r2-> rc:?X3r {} } )

// If  the main verb of the sentence that contains Xr3 has a subject that corefers with X2, let the pronominalisation take place; can't make RS lexicon calls; BUG: doesn't work?
//¬ ( rc:?Snr { rc:?Root1R { rc:SBJ-> rc:?Coref1R { rc:antecedent_id = ?idC1r } } } & ?idCr1 == ?X1r.id & ¬rc:?GrandGov1 { rc:?r1-> rc:?Root1R {} } )
  ]
]

/*In this level, we need info on the RS about coreference chains, and cannot use the relations, so we put this attribute.*/
SSynt<=>SSynt mark_antecedent_coref_add : transfer_attributes
[
  leftside = [
c:?Xl {
  c:<-> c:?Yl {
    c:id = ?id
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  antecedent_id = ?id
}
  ]
]

SSynt<=>SSynt K_attr_gestures : transfer_attributes
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

SSynt<=>SSynt anaphora : transfer_attributes
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*No c: on added_prep gives an overlap with transfer_node_basic...*/
SSynt<=>SSynt attr_added_prep : transfer_attributes
[
  leftside = [
c:?Xl {
  c:added_prep = ?n
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  added_prep=?n
}
  ]
]

SSynt<=>SSynt attr_case : transfer_attributes
[
  leftside = [
c:?Xl {
  case = ?n
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  case=?n
}
  ]
]

SSynt<=>SSynt attr_class : transfer_attributes
[
  leftside = [
c:?Xl {
  class = ?n
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  class =?n
}
  ]
]

SSynt<=>SSynt attr_clause_type : transfer_attributes
[
  leftside = [
c:?Xl {
  clause_type = ?n
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  clause_type=?n
}
  ]
]

/*dpos should be VB, NN, RB, JJ (see pos rules below)*/
SSynt<=>SSynt attr_coord_type : transfer_attributes
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

excluded SSynt<=>SSynt attr_definiteness : transfer_attributes
[
  leftside = [
c:?Xl {
  definiteness = ?n
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  definiteness=?n
}
  ]
]

SSynt<=>SSynt attr_depth : transfer_attributes
[
  leftside = [
c:?Xl {
  depth = ?n
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  depth=?n
}
  ]
]

/*Needed for generation of prosody.*/
SSynt<=>SSynt attr_dsyntRel : transfer_attributes
[
  leftside = [
c:?Xl {
  dsyntRel = ?r
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  dsyntRel = ?r
}
  ]
]

SSynt<=>SSynt attr_elide : transfer_attributes
[
  leftside = [
c:?Xl {
  elide = ?lex
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  elide = ?lex
}
  ]
]

SSynt<=>SSynt attr_finiteness : transfer_attributes
[
  leftside = [
c:?Xl {
  finiteness = ?n
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  finiteness=?n
}
  ]
]

SSynt<=>SSynt attr_gender : transfer_attributes
[
  leftside = [
c:?Xl {
  gender = ?n
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  gender=?n
}
  ]
]

SSynt<=>SSynt attr_gender_default : transfer_attributes
[
  leftside = [
c:?Yl {
  c:pos = "NN"
  ¬c:gender = ?num
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:gender=?g
  gender = "MASC"
}
  ]
]

SSynt<=>SSynt attr_has3rdArg : transfer_attributes
[
  leftside = [
c:?Xl {
  has3rdArg = ?lex
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  has3rdArg = ?lex
}
  ]
]

SSynt<=>SSynt attr_id : transfer_attributes
[
  leftside = [
c:?Xl {
  id = ?lex
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  id = ?lex
}
  ]
]

SSynt<=>SSynt attr_id_fromRandom : transfer_attributes
[
  leftside = [
c:?Xl {
  ¬c:id = ?id
  random_id = ?lex
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  id = ?lex
}
  ]
]

SSynt<=>SSynt attr_lex : transfer_attributes
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

SSynt<=>SSynt attr_meaning : transfer_attributes
[
  leftside = [
c:?Xl {
  meaning = ?n
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  meaning = ?n
}
  ]
]

SSynt<=>SSynt attr_mood : transfer_attributes
[
  leftside = [
c:?Xl {
  c:mood = ?m
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  mood = ?m
}
  ]
]

SSynt<=>SSynt attr_mood_default : transfer_attributes
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  ¬c:mood = ?m
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:finiteness = "FIN"
  mood = "IND"
}
  ]
]

SSynt<=>SSynt attr_NE : transfer_attributes
[
  leftside = [
c:?Xl {
  NE = ?NE
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

SSynt<=>SSynt attr_nmodif : transfer_attributes
[
  leftside = [
c:?Xl {
  n_modif = ?n
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  n_modif = ?n
}
  ]
]

SSynt<=>SSynt attr_number : transfer_attributes
[
  leftside = [
c:?Xl {
  number = ?n
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  number=?n
}
  ]
]

SSynt<=>SSynt attr_number_default : transfer_attributes
[
  leftside = [
c:?Yl {
  ( c:pos = "NN" | c:pos = "NP" | c:pos = "CD" )
  ¬c:number = ?num
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:pos = "IN"
  number = "SG"
}
  ]
]

SSynt<=>SSynt attr_num_deps : transfer_attributes
[
  leftside = [
c:?Xl {
  num_deps = ?n
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  num_deps=?n
}
  ]
]

SSynt<=>SSynt attr_parenth : transfer_attributes
[
  leftside = [
c:?Xl {
  parenth = ?n
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  parenth =?n
}
  ]
]

SSynt<=>SSynt attr_person : transfer_attributes
[
  leftside = [
c:?Yl {
  c:person = ?num
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  person = ?num
}
  ]
]

SSynt<=>SSynt attr_person_default : transfer_attributes
[
  leftside = [
c:?Yl {
  ( c:pos = "NN" | c:pos = "NP" )
  ¬c:person = ?num
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:pos = "IN"
  person = "3"
}
  ]
]

SSynt<=>SSynt attr_pos : transfer_attributes
[
  leftside = [
c:?Xl {
  pos = ?pv
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  pos = ?pv
}
  ]
]

SSynt<=>SSynt attr_predV : transfer_attributes
[
  leftside = [
c:?Xl {
  predValue = ?pv
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

SSynt<=>SSynt attr_pronominalized : transfer_attributes
[
  leftside = [
c:?Xl {
  pronominalized = ?n
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  pronominalized=?n
}
  ]
]

SSynt<=>SSynt attr_quotes : transfer_attributes
[
  leftside = [
c:?Xl {
  quotes = ?n
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  quotes =?n
}
  ]
]

SSynt<=>SSynt attr_relativized : transfer_attributes
[
  leftside = [
c:?Xl {
  relativized = ?n
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  relativized=?n
}
  ]
]

SSynt<=>SSynt attr_spos_copy : transfer_attributes
[
  leftside = [
c:?Xl {
  c:spos = ?spos
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  spos = ?spos
}
  ]
]

SSynt<=>SSynt attr_straight_weight_up : transfer_attributes
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:straight_weight = ?s
  straight_weight = #?s+1#
  ¬rc:straight_weight_up = "yes"
  straight_weight_up = "yes"
  rc:?r-> rc:?Yr {
    rc:straight_weight_up = "yes"
  }
}
  ]
]

DSynt<=>SSynt attr_tc : transfer_attributes
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

SSynt<=>SSynt attr_tense : transfer_attributes
[
  leftside = [
c:?Xl {
  tense = ?n
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  tense=?n
}
  ]
]

SSynt<=>SSynt attr_tense_default : transfer_attributes
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  ¬c:tense = ?m
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:finiteness = "FIN"
  tense = "PRES"
}
  ]
]

SSynt<=>SSynt attr_thematicity : transfer_attributes
[
  leftside = [
c:?Xl {
  thematicity = ?n
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  thematicity=?n
}
  ]
]

SSynt<=>SSynt attr_type : transfer_attributes
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

SSynt<=>SSynt attr_uri : transfer_attributes
[
  leftside = [
c:?Xl{
  uri = ?u
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  uri = ?u
}
  ]
]

SSynt<=>SSynt attr_vncls : transfer_attributes
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

/*works for MS, test with KRISTINA*/
SSynt<=>SSynt attr_number_added : transfer_attributes
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  ¬c:number = ?num
  c:SBJ-> c:?Yl{
    c:slex = "that"
    c:number = ?n
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  number=?n
}
  ]
]

SSynt<=>SSynt attr_variable_class : transfer_attributes
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

SSynt<=>SSynt attr_voice : transfer_attributes
[
  leftside = [
c:?Xl {
  voice = ?vncls
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  voice = ?vncls
}
  ]
]

SSynt<=>SSynt attr_weight : transfer_attributes
[
  leftside = [
c:?Xl {
  weight = ?vncls
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  weight = ?vncls
}
  ]
]

/*The depth rules will work if enough relations are created before the 3rd cluster, which is usually the case.
It weirdly done, and probably can be done better. The idea is to get at the leaves when the whole tree is built, not before,
 which is why we start from the root (the ssynt tree is built from the root).*/
SSynt<=>SSynt depth_root : weight
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:spos = ?l
  depth = "1.0"
}

¬ rc:?GovR { rc:?r-> rc:?Xr {} }
  ]
]

/*Once the root has been marked, count down till the leaf.*/
SSynt<=>SSynt depth_down : weight
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:count_depth = "STOP"
  rc: depth = ?w
  rc:?r-> rc:?Yr {
    depth = #?w + 1#
  }
}
  ]
]

/*When down to the leaf, go up again, counting from the bottom.
That way, we end up with each subtree having a number for its depth.*/
SSynt<=>SSynt weight_up_leaf_1 : weight
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:?r-> rc:?Yr {
    rc:depth = ?d2
    straight_weight = "1.0"
    ¬rc:weight = ?w
    ¬rc:?s-> rc:?Zr {}
  }
}
  ]
]

/*Some units have their own weight in the lexicon, in this case we sum up this weight instead of 1.*/
DSynt<=>SSynt weight_up_leaf_lexicon : weight
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:?r-> rc:?Yr {
    rc:depth = ?d2
    rc:weight = ?w
    straight_weight = ?w
    ¬rc:?s-> rc:?Zr {}
  }
}
  ]
]

/*When down to the leaf, go up again, counting from the bottom.
That way, we end up with each subtree having a number for its depth.*/
SSynt<=>SSynt weight_up_Block : weight
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:updated_weight = "yes"
  straight_weight = ?w
  rc:?r-> rc:?Yr {
    rc:straight_weight = ?w
   rc:block = "yes"
    ¬rc:updated_weight = "yes"
  }
}
  ]
]

/*When down to the leaf, go up again, counting from the bottom.
That way, we end up with each subtree having a number for its depth.*/
SSynt<=>SSynt weight_up_notBlock_1 : weight
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:updated_weight = "yes"
  ¬rc:weight = ?ow
  straight_weight = # ?w + 1 #
  rc:?r-> rc:?Yr {
    rc:straight_weight = ?w
    ¬rc:block = "yes"
    ¬rc:updated_weight = "yes"
  }
}
  ]
]

/*Some units have their own weight in the lexicon, in this case we sum up this weight instead of 1.*/
DSynt<=>SSynt weight_up_notBlock_lexicon : weight
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:updated_weight = "yes"
  rc:weight = ?ow
  straight_weight = # ?w + ?ow #
  rc:?r-> rc:?Yr {
    rc:straight_weight = ?w
    ¬rc:block = "yes"
    ¬rc:updated_weight = "yes"
  }
}
  ]
]

/*Testing a hack to linearise better multiple PRD in English (e.g. is a complex of offices in Liverpool), where the prep goes after.*/
SSynt<=>SSynt EN_add_weight_PRD_loc : weight
[
  leftside = [
c:?S1l {
  // another bubble will merge with X's bubble.
  c:?X1l {
    c:slex = ?s1
  }
  c:?rel-> c:?S2l {
    c:?X2l {
      c:slex = ?s2
      c:PRD-> c:?P2l {}
    }
  }
}


// X1 is a root; to reduce number of candidates
¬c:?Gov { c:?r-> c:?X1l {} }
?s1 == ?s2
  ]
  mixed = [

  ]
  rightside = [
rc:?X2r {
  rc:<=> ?X2l
  rc:PRD-> rc:?P1r {
    ¬rc:pos = "IN"
  }
  rc:PRD-> rc:?P2r {
    rc:pos = "IN"
    ¬rc:updated_weight = "yes"
    rc:straight_weight = ?sw
    increase_weight = "yes"
  }
}
  ]
]

SSynt<=>SSynt increase_weight : weight
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:increase_weight = "yes"
  rc:straight_weight = ?sw
  ¬rc:updated_weight = "yes"
  straight_weight = #?sw + 12#
  updated_weight = "yes"
}
  ]
]

SSynt<=>SSynt add_nmodif_newcoord : nmodif
[
  leftside = [
c:?Sl {
  c:?Zl {
    c:attach_coord = "yes"
    c:conjunction_type = ?ct
    c:n_modif = ?nm
  }
}

// BUG: can't use these relations as rc: on the RS
//lexicon.miscellaneous.conjunction.coord_rel.?rel1
//lexicon.miscellaneous.conjunction.?ct.?lex
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  rc:member = "A1"
  rc:n = "1.0"
  rc:?rel1-> rc:?ConjR {
    rc:new_node = "yes"
    //rc:lex = ?lex
    n_modif = ?nm
  }
}
  ]
]

SSynt<=>SSynt nmodif_mark : nmodif
[
  leftside = [
c:?Gov1l {
  c:blocked = "yes"
  c:?r1-> c:?Xl {
    ¬c:blocked = "yes"
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?NewGov {
  rc:n_modif = ?nm
  rc:?R-> rc:?Xr {
    rc:<=> ?Xl
    n_modif = ?nm
  }
}
  ]
]

SSynt<=>SSynt nmodif_percolate : nmodif
[
  leftside = [
c:?Xl {
  ¬c:blocked = "yes"
  ¬c:n_modif = "yes"
  c:?r-> c:?Yl {
    ¬c:blocked = "yes"
    ¬c:n_modif = "yes"
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:n_modif = ?nm
  rc:?R-> rc:?Yr {
    rc:<=> ?Yl
    n_modif = ?nm
  }
}
  ]
]

/*These agrements rules intially come from grammar 35. The input to grammar 37.2 is slightly diffferent, so make specific rules if needed.*/
excluded SSynt<=>SSynt agreement_sibling_number_NOUN_copul : agreement
[
  leftside = [
c:?Xl {
  c:?r-> c:?Subj {
    //c:gender = ?gen
    c:number = ?num
    ¬c:COORD-> c:?Coord {}
    ¬c:coord-> c:?Coord {}
  }
  c:?s-> c:?Obj {
    c:pos = "NN"
  }
}


( ?r == subj | ?r == SBJ )
( ?s == copul | ?s == PRD )

// we need to encode semantic pluralness in lexicon and make this rule more generic
¬ ( language.id.iso.EN & ( ?Obj.slex == "group" | ?Obj.slex == "ethnic_group" ) )
¬ ( language.id.iso.ES & ( ?Obj.slex == "grupo" | ?Obj.slex == "grupo étnico" ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?ObjR {
  rc:<=> ?Obj
  //gender = ?gen.
  rc:number = ?n
  number = ?num
  ¬rc:update_num_RS = "yes"
  update_num_RS = "yes"
}
  ]
]

/*These agrements rules intially come from grammar 35. The input to grammar 37.2 is slightly diffferent, so make specific rules if needed.*/
excluded SSynt<=>DMorph agreement_sibling_number_NOUN_copul_COORD : agreement
[
  leftside = [
c:?Xl {
  c:?r-> c:?Subj {
    c:?t-> c:?Coord {}
  }
  c:?s-> c:?Obj {
    c:pos = "NN"
  }
}


( ?r == subj | ?r == SBJ )
( ?s == copul | ?s == PRD )
( ?t == coord | ?t == COORD )


// we need to encode semantic pluralness in lexicon and make this rule more generic
¬ ( language.id.iso.EN & ( ?Obj.slex == "group" | ?Obj.slex == "ethnic_group" ) )
¬ ( language.id.iso.ES & ( ?Obj.slex == "grupo" | ?Obj.slex == "grupo étnico" ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?ObjR {
  rc:<=> ?Obj
  //gender = ?gen
  rc:number = ?n
  number = "PL"
  update_num_deps = "yes"
}
  ]
]

/*marks nodes involved in a coordination that have one different dependent.
would be better to mark if there are no different dependents but I don't manage to make it work properly on seome examples (CONNEXIONs Esco_5 and Word_43).*/
SSynt<=>SSynt mark_if_different_deps : mark_block
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:pos = "NN"
  rc:slex = ?sX
  has_diff_deps_wrt_next_conjunct = "yes"
  rc:?Coord-> rc:?Conj {
    rc:?conj-> rc:?Yr {
      rc:pos = "NN"
      rc:slex = ?sY
    }
  }
}

//?sX == ?sY

( ( ?Coord == COORD & ?conj == CONJ ) | ( ?Coord == coord & ?conj == coord_conj ) )

( rc:?Xr { rc:?RX1-> rc:?DX1 { rc:slex = ?sDX1 } } & ¬ ( rc:?Yr { rc:?RY1-> rc:?DY1 { rc:slex = ?sDY1 } } & ?sDX1 == ?sDY1 & ?RX1 == ?RY1 ) & ¬ ?RX1 == ?Coord )
( rc:?Yr { rc:?RY2-> rc:?DY2 { rc:slex = ?sDY2 } } & ¬ ( rc:?Xr { rc:?RX2-> rc:?DX2 { rc:slex = ?sDX2 } } & ?sDX2 == ?sDY2 & ?RX2 == ?RY2 ) )
  ]
]

/*to elide parts of conjuncts that are the same and avoid repetitions. If we do so, the first conjunct gets a number = PL.
Only edlide if there is an argument left for now.
E.g; the ratio of commas and of dots is high.*/
SSynt<=>SSynt mark_block_same_conjuncts : mark_block
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:slex = ?sX
  rc:pos = "NN"
  // so mark_if_different_deps has applied already
  rc:straight_weight = ?swX
  ¬rc:has_diff_deps_wrt_next_conjunct = "yes"
  rc:?Coord-> rc:?Conj {
    rc:?conj-> rc:?Yr {
      rc:slex = ?sY
      rc:pos = "NN"
      elide = "yes"
      rc:?R1-> rc:?DepY1R {
      //  only block nodes that have no dependents; will create problems to solve later :)
        ¬rc:?R2-> rc:?DepY2R {}
        elide = "yes"
      }
      rc:?S1-> rc:?DepY3R {
        ¬rc:elide = "yes"
        ( rc:dsyntRel = I | rc:dsyntRel = II | rc:dsyntRel = III )
      }
    }
  }
}

?sX == ?sY

( ( ?Coord == COORD & ?conj == CONJ ) | ( ?Coord == coord & ?conj == coord_conj ) )
  ]
]

/*to elide parts of conjuncts that are the same and avoid repetitions. If we do so, the first conjunct gets a number = PL.*/
SSynt<=>SSynt mark_PL_top_non_elided_conjunct : mark_block
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:slex = ?sX
  rc:pos = "NN"
  ¬rc:elide = "yes"
  number = "PL"
  rc:?Coord-> rc:?Conj {
    rc:?conj-> rc:?Yr {
      rc:slex = ?sY
      rc:pos = "NN"
      rc:elide = "yes"
    }
  }
}

?sX == ?sY

( ( ?Coord == COORD & ?conj == CONJ ) | ( ?Coord == coord & ?conj == coord_conj ) )
  ]
]

/*If a node X2 has a coreference relation with a NE node of another bubble in which there is another NE, mark X2.
If one NE has a class, and the other doesn't.
For classes that are referred to with the same kind of pronoun (non persons), there is ambiguity if a pronoun is introduced.*/
excluded Sem<=>ASem mark_ambiguous_antecedent_coref_both_SentBetween : mark_ambiguous_antecedent_coref_both
[
  leftside = [
c:?S1l {
  c:?X1l {
    c:NE = "YES"
  }
  c:*~ c:?S2l {
    c:?X2l {
      c:<-> c:?X1l {}
    } 
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  rc:<=> ?S1l
  rc:id = ?id1
  rc:?X1r {
    rc:<=> ?X1l
    rc:NE = "YES"
    rc:class = ?mX1
  }
  rc:*~ rc:?Snr {
    rc:id = ?idn
    rc:?X3r {
      rc:NE = "YES"
      ¬rc:class = ?mX3
      ¬rc:pos = "CD"
      ¬rc:slex = "e-book"
      ¬rc:relativized = yes
    }
    rc:~ rc:?S2r {
    // We shouldn't be requesting that S2r corrsponds to S2l since node can move bubbles during the aggregation.
    // When deactivated, we need some additional rules to check if whithin S2, X2 may not be ambiguous anymore, e.g. if there is an element coreferring with it above in the tree.
      rc:<=> ?S2l
      rc:id = ?id2
      rc:?X2r {
        rc:<=> ?X2l
        ambiguous_antecedent = "yes"
      }
    }
  }
}

¬ ?id1 == ?idn
¬ ?id1 == ?id2

// Doesn't work; BUG? Split in two rules.
//( ( rc:?X1r { ¬rc:class = ?mX1 } & rc:?X3r { ¬rc:class = ?mX3 } ) | ?X1r.class == ?X3r.class )
¬ ?mX1 == "Person"

//BUG can't use coref rels with rc:
//rc:?X1r { ¬ rc:<-> rc:?X3r {} }
//rc:?X3r { ¬ rc:<-> rc:?X1r {} }
//¬ ( rc:?X1r { rc:<-> rc:?Xante {} } & rc:?X3r { rc:<-> rc:?Xante {} } )
¬ ( ?X1r.id == ?X3r.antecedent_id )
¬ ( ?X3r.id == ?X1r.antecedent_id )
//¬ ( ?X1r.antecedent_id == ?X3r.antecedent_id )
//¬ ( rc:?X1r { rc:antecedent_id = ?aid1 } & rc:?X3r { rc:antecedent_id = ?aid3 } & ?aid1 == ?aid3 )
¬ ( ?X1r.antecedent_id > 0 & ?X1r.antecedent_id == ?X3r.antecedent_id )

// BUG? This condition doesnt't seem to work, I suspect that the correspondences are being used to link RS variables.
¬ ( rc:?X3r { rc:slex = ?sx } & ( ?sx == 0 |  ?sx < 0 | ?sx > 0 | ?sx == "e-book" ) )

// If  X3 is the subject of the main verb, let the pronominalisation take place; can't make RS lexicon calls
¬ ( rc:?GovX1 { rc:SBJ-> rc:?X3r {} } & ¬rc:?GrandGov1 { rc:?r1-> rc:?X3r {} } )
¬ ( rc:?GovX2 { rc:subj-> rc:?X3r {} } & ¬rc:?GrandGov2 { rc:?r2-> rc:?X3r {} } )

// If  the main verb of the sentence that contains Xr3 has a subject that corefers with X2, let the pronominalisation take place; can't make RS lexicon calls; BUG: doesn't work?
//¬ ( rc:?Snr { rc:?Root1R { rc:SBJ-> rc:?Coref1R { rc:antecedent_id = ?idC1r } } } & ?idCr1 == ?X1r.id & ¬rc:?GrandGov1 { rc:?r1-> rc:?Root1R {} } )
  ]
]

SSynt<=>SSynt K_attr_gest_fen : K_attr_gestures
[
  leftside = [
c:?Xl{
  FacialEnthusiasm = ?u
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  FacialEnthusiasm = ?u
}
  ]
]

SSynt<=>SSynt K_attr_gest_fex : K_attr_gestures
[
  leftside = [
c:?Xl{
  FacialExpression = ?u
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  FacialExpression = ?u
}
  ]
]

SSynt<=>SSynt K_attr_gest_fin : K_attr_gestures
[
  leftside = [
c:?Xl{
  FacialIntensity = ?u
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  FacialIntensity = ?u
}
  ]
]

SSynt<=>SSynt K_attr_gest_att : K_attr_gestures
[
  leftside = [
c:?Xl{
  hasAttitude = ?u
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  hasAttitude = ?u
}
  ]
]

SSynt<=>SSynt K_attr_gest_exp : K_attr_gestures
[
  leftside = [
c:?Xl{
  hasExpressivity = ?u
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  hasExpressivity = ?u
}
  ]
]

SSynt<=>SSynt K_attr_gest_pro : K_attr_gestures
[
  leftside = [
c:?Xl{
  hasProximity = ?u
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  hasProximity = ?u
}
  ]
]

SSynt<=>SSynt K_attr_gest_soc : K_attr_gestures
[
  leftside = [
c:?Xl{
  hasSocial = ?u
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  hasSocial = ?u
}
  ]
]

SSynt<=>SSynt K_attr_gest_sty : K_attr_gestures
[
  leftside = [
c:?Xl{
  hasStyle = ?u
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  hasStyle = ?u
}
  ]
]

SSynt<=>SSynt K_attr_gest_sa : K_attr_gestures
[
  leftside = [
c:?Xl{
  speechAct = ?u
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  speechAct = ?u
}
  ]
]

SSynt<=>SSynt attr_ambiguous_antecedent : anaphora
[
  leftside = [
c:?Xl{
  ambiguous_antecedent = ?u
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ambiguous_antecedent = ?u
}
  ]
]

SSynt<=>SSynt attr_definiteness : anaphora
[
  leftside = [
c:?Xl {
  definiteness = ?n
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  definiteness = ?n
}
  ]
]

SSynt<=>SSynt attr_SameLocAsPrevious : anaphora
[
  leftside = [
c:?Xl {
  SameLocAsPrevious = ?n
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  SameLocAsPrevious = ?n
}
  ]
]

SSynt<=>SSynt attr_Subtree_coref : anaphora
[
  leftside = [
c:?Xl {
  subtree_coref = ?n
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  subtree_coref = ?n
}
  ]
]

