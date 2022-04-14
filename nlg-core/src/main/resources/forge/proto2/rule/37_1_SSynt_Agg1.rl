/*BUG: gives an overlap with node_word if no c: !!*/
SSynt<=>SSynt node_word
[
  leftside = [
?Xl {
  ¬c:block = "yes"
  c:slex = ?s
}
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

/*Transfers all non-argumental relations.*/
SSynt<=>SSynt rel_copy
[
  leftside = [
c:?Xl {
  ?r-> c: ?Yl {}
}
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

/*This rule aims as removing dependents that are already on the node that will remain after an aggregation.
If some dependents of the blocked node are not on the remaining node, move them to the remaining node.
This rule is a very simple version of what it should be (i.e. it should be checking the whole subtrees for identity).*/
SSynt<=>SSynt block_dependents_of_blocked
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:lex = ?semX1
      c:?r1-> c:?Y1l {
        c:?s1-> c:?Dep1 {
          c:slex = ?sD1
        }
      }
    }
    c:*~ c:?S2l {
      c:?X2l {
        c:lex = ?semX2
        c:?r2-> c:?Y2l {
          c:?s2-> c:?Dep2 {
            c:slex = ?sD2
          }
      
  }
      }
    }
  }
}

// We should check if the while subtree is the same or not; simplification for now
?sD1 == ?sD2

// restrict to subjects and objects  for now
?r1 == ?r2

// the main verb and the subject are the same
?semX1 == ?semX2
( c:?Y2l { c:<-> c:?Y1l {} } | ( c:?Y1l { c:<-> c:?Y0l {} } & c:?Y2l { c:<-> c:?Y0l {} } ) )

//Both Xs are roots.  Only second needs to be root for now, test this.
//¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  rc:blocked = "yes"
  rc:?merge-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?Dep2r {
  rc:<=> ?Dep2
  blocked = "yes"
  block_dependents = "yes"
}
  ]
]

/*Only block nodes that are below blocked node that are not roots.
Otherwise when the main verb is removed, the whole subtree goes with it.*/
SSynt<=>SSynt block_percolate
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Govr {
  rc:?s-> rc:?Xr {
    rc:<=> ?Xl
    rc:block_dependents = "yes"
    rc:blocked = "yes"
    rc:?r-> rc:?Yr {
      block_dependents = "yes"
      blocked = "yes"
    }
  }
}
  ]
]

/*Here we use "slex" on main verbs to check that they are the same, but "lex" in Agg2.*/
SSynt<=>SSynt mark_SameRootSubj_sameObjRel
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      //c:lex = ?semX1
      // Maybe slex is better than lex?
      c:lex = ?semX1
      c:?r1-> c:?Y1l {
        c:lex = ?semY1
        c:pos = ?posY1
      }
      c:?s1-> c:?Z1l {
        c:pos = ?posZ1
      }
      // there is not other dependent
      ¬c:?OD1-> c:?OtherDep1 {}
    }
    c:*~ c:?S2l {
      c:?X2l {
        c:lex = ?semX2
        // ?Y2L will be blocked, the dependents would remain disconnected
        c:?r2-> c:?Y2l { ¬c:?ODY2-> c:?OtherDepY2 { ¬c:pos = "DT" } 
          c:lex = ?semY2
        }
        c:?s2-> c:?Z2l {
          c:pos = ?posZ2
        }
        // there is not other dependent
        ¬c:?OD2-> c:?OtherDep2 {}
      }
    }
  }
}

// restrict to subjects and objects  for now
?r1 == ?r2
?s1 == ?s2
lexicon.dependencies_default_map.I.rel.?r1
( lexicon.dependencies_default_map.II.rel.?s1 | lexicon.dependencies_default_map.AUX.rel.?s1 )

// the main verb and the subject are the same
?semX1 == ?semX2
( ( ?semY1 == ?semY2 & ?posY1 == "WP" )
 | ( c:?Y2l { c:<-> c:?Y1l {} } | ( c:?Y1l { c:<-> c:?Y0l {} } & c:?Y2l { c:<-> c:?Y0l {} } ) ))

// both Z have the same PoS (this could be relaxed a bit)
?posZ1 == ?posZ2

// if one of the candidates has a specific status (e.g. meaning=locative_relation or temporal_relation), only apply if the other one has the same status.
( ( ¬?Z1l.meaning == ?mZ1 & ¬?Z2l.meaning == ?mZ2 ) | ?Z1l.meaning == ?Z2l.meaning )

//Both Xs are roots.  Only second needs to be root for now, test this.
//¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// There isn't a dependent on one of the arguments that is not on the dependent of the second sentence (to be improved)
// SHOULDN'T THIS CONDITION BE REPEATED ON THE COMPLEX CONDITIONS BELOW?
¬ ( c:?Y1l { c:?r4-> c:?Dep4l { c:slex= ?semD4 } } & c:?Y2l { c:?r5-> c:?Dep5l { c:slex= ?semD5 } } & ( ¬?semD4 == ?semD5 | ¬?r4 == ?r5 ) )

// There isn't a pronoun with external antecedent in the sentence to be moved (unless a mention to the same NE is already in the host sentence).
//( ¬ ( c:?S2l { c:?Pro11no { ( c:slex = "_PRO_" | c:pronominalized = yes ) } } )
//  | ( c:?S2l { c:?Pro11 { ( c:slex = "_PRO_" | c:pronominalized = yes ) c:<-> c:?Ante11 {} } }
//    & ( c:?S2l { c:?Ante11 {} } | c:?S1l { c:?Ante11 {} } | ( c:?S11l { c:?Ante11 {} } & c:?S1l { c:?Prob11 { c:<-> c:?Ante11 {} } } ) )
//  )
//)

// the verbs both have the same verbal tense
( c:?X1l { c:tense = ?tt1 } & c:?X2l { c:tense = ?tt2 } & ?tt1 == ?tt2 )
  
// ?S1l is the lightest sentence, to which all other sentences will point (simplified to first ID for now)
¬ ( c:?Tl { c:?S3l { c:*~ c:?S1l {} c:id = ?id3 c:?X3l { c:straight_weight = ?swX3 c:lex = ?semX3 c:?r3-> c:?Y3l { c:sem = ?semY3 c:pos = ?posY3 }  c:?s3-> c:?Z3l { c:pos = ?posZ3 } ¬c:?OD3-> c:?OtherDep3 {} } } }
    & ( ( ?semY3 == ?semY2 & ?posY3 == "WP" ) | ( c:?Y2l { c:<-> c:?Y3l {} } | c:?Y3l { c:<-> c:?Y2l {} } | ( c:?Y2l { c:<-> c:?Y00l {} } & c:?Y3l { c:<-> c:?Y00l {} } ) ) )
    & lexicon.dependencies_default_map.I.rel.?r3 & ( lexicon.dependencies_default_map.II.rel.?s3 | lexicon.dependencies_default_map.AUX.rel.?s3 )
    & ?r3 ==?r2 & ?s3 == ?s2 & ?semX3 == ?semX2 & ?posZ3 == ?posZ2
    & ( ( ¬?Z3l.meaning == ?mZ3 & ¬?Z2l.meaning == ?mZ2bis ) | ?Z3l.meaning == ?Z2l.meaning )
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
    //& c:?X1l { c:straight_weight = ?swX1 } & ?swX3 < ?iswX1
    & ( c:?X3l { c:tense = ?tt3 } & c:?X2l { c:tense = ?tt4 } & ?tt3 == ?tt4 )
    & ¬ ( c:?Y3l { c:?r6-> c:?Dep6l { c:slex= ?semD6 } } & c:?Y2l { c:?r8-> c:?Dep7l { c:slex= ?semD7 } } & ( ¬?semD6 == ?semD7 | ¬?r6 == ?r8 ) )
)

¬ project_info.project.name.MindSpaces
  ]
  mixed = [
//¬ ( c:?Tl { c:?S11l { c:*~ c:?S1l {} c:?X11l { c:lex = ?semX11 c:?r11-> c:?Y11l {}  c:?s11-> c:?Z11l { c:pos = ?posZ11 } ¬c:?OtherDep11 {} } } }
//    & ?r11 ==?r1 & ?s11 == ?s1 & ?semX11 == ?semX1 & c:?Z1l { c:pos = ?posZ1 } & ?posZ11 == ?posZ1
//    & ( c:?Y1l { c:<-> c:?Y11l {} } | ( c:?Y1l { c:<-> c:?Y101l {} } & c:?Y11l { c:<-> c:?Y101l {} } ) )
//    & lexicon.dependencies_default_map.I.rel.?r11 & lexicon.dependencies_default_map.II.rel.?s11
//    & ( ( ¬?Z11l.meaning == ?mZ11 & ¬?Z1l.meaning == ?mZ1 ) | ?Z11l.meaning == ?Z1l.meaning )
//    & ( c:?X11l { c:tense = ?tt11 } & c:?X1l { c:tense = ?tt11b } & ?tt11 == ?tt11b )
//)
  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked_potential = "yes"
  mergeRootSubjCoord-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X2r {
  rc:<=> ?X2l
  blocked_potential = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  blocked_potential = "yes"
}
  ]
]

/*Here we use "slex" on main verbs to check that they are the same, but "lex" in Agg2.
Simplify LS some day Alba, please.*/
SSynt<=>SSynt merge_SameRootSubj_sameObjRel
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      //c:lex = ?semX1
      // Maybe slex is better than lex?
      c:lex = ?semX1
      c:?r1-> c:?Y1l {
        c:lex = ?semY1
        c:pos = ?posY1
      }
      c:?s1-> c:?Z1l {
        c:pos = ?posZ1
      }
      // there is not other dependent
      ¬c:?OD1-> c:?OtherDep1 {}
    }
    c:*~ c:?S2l {
      c:?X2l {
        c:lex = ?semX2
        // ?Y2L will be blocked, the dependents would remain disconnected
        c:?r2-> c:?Y2l { ¬c:?ODY2-> c:?OtherDepY2 { ¬c:pos = "DT" } 
          c:lex = ?semY2
        }
        c:?s2-> c:?Z2l {
          c:pos = ?posZ2
        }
        // there is not other dependent
        ¬c:?OD2-> c:?OtherDep2 {}
      }
    }
  }
}

// restrict to subjects and objects  for now
?r1 == ?r2
?s1 == ?s2
lexicon.dependencies_default_map.I.rel.?r1
( lexicon.dependencies_default_map.II.rel.?s1 | lexicon.dependencies_default_map.AUX.rel.?s1 )

// the main verb and the subject are the same
?semX1 == ?semX2
( ( ?semY1 == ?semY2 & ?posY1 == "WP" )
 | ( c:?Y2l { c:<-> c:?Y1l {} } | ( c:?Y1l { c:<-> c:?Y0l {} } & c:?Y2l { c:<-> c:?Y0l {} } ) ) )

// both Z have the same PoS (this could be relaxed a bit)
?posZ1 == ?posZ2

// if one of the candidates has a specific status (e.g. meaning=locative_relation or temporal_relation), only apply if the other one has the same status.
( ( ¬?Z1l.meaning == ?mZ1 & ¬?Z2l.meaning == ?mZ2 ) | ?Z1l.meaning == ?Z2l.meaning )

//Both Xs are roots.  Only second needs to be root for now, test this.
//¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// There isn't a dependent on one of the arguments that is not on the dependent of the second sentence (to be improved)
// SHOULDN'T THIS CONDITION BE REPEATED ON THE COMPLEX CONDITIONS BELOW?
¬ ( c:?Y1l { c:?r4-> c:?Dep4l { c:slex= ?semD4 } } & c:?Y2l { c:?r5-> c:?Dep5l { c:slex= ?semD5 } } & ( ¬?semD4 == ?semD5 | ¬?r4 == ?r5 ) )

// There isn't a pronoun with external antecedent in the sentence to be moved (unless a mention to the same NE is already in the host sentence).
//( ¬ ( c:?S2l { c:?Pro11no { ( c:slex = "_PRO_" | c:pronominalized = yes ) } } )
//  | ( c:?S2l { c:?Pro11 { ( c:slex = "_PRO_" | c:pronominalized = yes ) c:<-> c:?Ante11 {} } }
//    & ( c:?S2l { c:?Ante11 {} } | c:?S1l { c:?Ante11 {} } | ( c:?S11l { c:?Ante11 {} } & c:?S1l { c:?Prob11 { c:<-> c:?Ante11 {} } } ) )
//  )
//)

// the verbs both have the same verbal tense
( c:?X1l { c:tense = ?tt1 } & c:?X2l { c:tense = ?tt2 } & ?tt1 == ?tt2 )

// ?X1l is the node with the smallest weigth, the only one that can be used as an anchor for coordination (to avoid multiple applications within one bubble).
¬ ( ?S1l { c:?X8l { c:id = ?idX8 c:lex = ?semX8 c:?r8 -> c:?Y8l {} c:?s8 -> c:?Z8l { c:pos = ?posZ8 } ¬c:?OD8-> c:?OtherDep8 {} } }
    & ( c:?Y2l { c:<-> c:?Y8l {} } | c:?Y8l { c:<-> c:?Y2l {} } | ( c:?Y2l { c:<-> c:?Y000l {} } & c:?Y8l { c:<-> c:?Y000l {} } ) )
    & lexicon.dependencies_default_map.I.rel.?r8 & ( lexicon.dependencies_default_map.II.rel.?s8 | lexicon.dependencies_default_map.AUX.rel.?s8 )
    & ?r8 ==?r2 & ?s8 == ?s2 & ?semX8 == ?semX2 & ?posZ8 == ?posZ2
    & ( ( ¬?Z8l.meaning == ?mZ8 & ¬?Z2l.meaning == ?mZ2ter ) | ?Z8l.meaning == ?Z2l.meaning )
    & c:?X1l { c:id = ?idX1 } & ?idX8 < ?idX1
    //& c:?X1l { c:straight_weight = ?idX1 } & ?idX8 < ?idX1
    & ( c:?X8l { c:tense = ?tt8 } & c:?X2l { c:tense = ?tt8b } & ?tt8 == ?tt8b )
    & ¬ ( c:?Y8l { c:?r6-> c:?Dep6l { c:slex= ?semD6 } } & c:?Y2l { c:?r8-> c:?Dep7l { c:slex= ?semD7 } } & ( ¬?semD6 == ?semD7 | ¬?r6 == ?r8 ) )
)

¬ project_info.project.name.MindSpaces
  ]
  mixed = [
//¬ ( c:?Tl { c:?S11l { c:*~ c:?S1l {} c:?X11l { c:lex = ?semX11 c:?r11-> c:?Y11l {}  c:?s11-> c:?Z11l { c:pos = ?posZ11 } ¬c:?OtherDep11 {} } } }
//    & ?r11 ==?r1 & ?s11 == ?s1 & ?semX11 == ?semX1 & c:?Z1l { c:pos = ?posZ1 } & ?posZ11 == ?posZ1
//    & ( c:?Y1l { c:<-> c:?Y11l {} } | ( c:?Y1l { c:<-> c:?Y101l {} } & c:?Y11l { c:<-> c:?Y101l {} } ) )
//    & lexicon.dependencies_default_map.I.rel.?r11 & lexicon.dependencies_default_map.II.rel.?s11
//    & ( ( ¬?Z11l.meaning == ?mZ11 & ¬?Z1l.meaning == ?mZ1 ) | ?Z11l.meaning == ?Z1l.meaning )
//    & ( c:?X11l { c:tense = ?tt11 } & c:?X1l { c:tense = ?tt11b } & ?tt11 == ?tt11b )
//)
  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  rc:blocked_potential = "yes"
  blocked = "yes"
  applied_agg = "mergeRootSubjCoord"
  rc:mergeRootSubjCoord-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X1r {
  rc:<=> ?X1l
  mergeRootSubjCoord = "anchor"
}

rc:?X2r {
  rc:<=> ?X2l
  rc:blocked_potential = "yes"
  blocked = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  rc:blocked_potential = "yes"
  blocked = "yes"
}

rc:?Z1r {
  rc:<=> ?Z1l
  attach_coord = "yes"
  conjunction_type = "coordination"
}

¬rc:?S3r { rc:mergeRootSubjCoord-> rc:?S2r { rc:<=> ?S2l } }
  ]
]

/*For bubbles that have the same property and subject but objects with different relations (e.g. born + date; born + place )
Or the same relation and dependents with a different "meaning" status (e.g. locative_relation or temporal_relation)

Here we use "slex" on main verbs to check that they are the same, but "lex" in Agg2.*/
SSynt<=>SSynt mark_SameRootSubj_differentObjRel
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:lex = ?semX1
      c:?r1-> c:?Y1l {
      }
      c:?s1-> c:?Z1l {}
      // there is not other dependent
      ¬c:?OD1-> c:?OtherDep1 {}
      }
    c:*~ c:?S2l {
      c:?X2l {
        c:lex = ?semX2
        c:?r2-> c:?Y2l { ¬c:?ODY2-> c:?OtherDepY2 { ¬c:pos = "DT" } }
        c:?s2-> c:?Z2l {}
        // there is not other dependent
        ¬c:?OD2-> c:?OtherDep2 {}
      }
    }
  }
}

// restrict to subjects and objects  for now
?r1 == ?r2
lexicon.dependencies_default_map.I.rel.?r1
( ( ¬ ?s1 == ?s2 & ( lexicon.dependencies_default_map.II.rel.?s1 | lexicon.dependencies_default_map.AUX.rel.?s1) & ( lexicon.dependencies_default_map.II.rel.?s2 | lexicon.dependencies_default_map.AUX.rel.?s2 ) )
  | ( ?s1 == ?s2 & ¬?Z1l.meaning == ?Z2l.meaning )
)
// the main verb and the subject are the same
?semX1 == ?semX2
// to avoid aggregations of auxiliary with verb
?X1l.spos == ?X2l.spos
( c:?Y2l { c:<-> c:?Y1l {} } | c:?Y1l { c:<-> c:?Y2l {} } | ( c:?Y1l { c:<-> c:?Y0l {} } & c:?Y2l { c:<-> c:?Y0l {} } ) )

//Both Xs are roots.  Only second needs to be root for now, test this.
// ¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// There isn't a dependent on one of the arguments that is not on the dependent of the second sentence (to be improved)
¬ ( c:?Y1l { c:?r4-> c:?Dep4l { c:slex= ?semD4 } } & c:?Y2l { c:?r5-> c:?Dep5l { c:slex= ?semD5 } } & ( ¬?semD4 == ?semD5 | ¬?r4 == ?r5 ) )

// There isn't a pronoun with external antecedent in the sentence to be moved (unless a mention to the same NE is already in the host sentence).
//( ¬ ( c:?S2l { c:?Pro11no { ( c:slex = "_PRO_" | c:pronominalized = yes ) } } )
//  | ( c:?S2l { c:?Pro11 { ( c:slex = "_PRO_" | c:pronominalized = yes ) c:<-> c:?Ante11 {} } }
//    & ( c:?S2l { c:?Ante11 {} } | c:?S1l { c:?Ante11 {} } | ( c:?S11l { c:?Ante11 {} } & c:?S1l { c:?Prob11 { c:<-> c:?Ante11 {} } } ) )
//  )
//)
    
// the verbs both have the same verbal tense
( c:?X1l { c:tense = ?tt1 } & c:?X2l { c:tense = ?tt2 } & ?tt1 == ?tt2 )
  
// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:*~ c:?S1l {} c:?X3l { c:lex = ?semX3 c:?r3-> c:?Y3l {}  c:?s3-> c:?Z3l {} ¬c:?OD3-> c:?OtherDep3 {} } } }
    & ?r3 ==?r2 & ?semX3 == ?semX2
    & ( c:?Y2l { c:<-> c:?Y3l {} } | c:?Y3l { c:<-> c:?Y2l {} } | ( c:?Y2l { c:<-> c:?Y00l {} } & c:?Y3l { c:<-> c:?Y00l {} } ) )
    & ( ( ¬ ?s3 == ?s2 &  ( lexicon.dependencies_default_map.II.rel.?s3 | lexicon.dependencies_default_map.AUX.rel.?s3 ) & ( lexicon.dependencies_default_map.II.rel.?s2 | lexicon.dependencies_default_map.AUX.rel.?s2 ) ) | ( ?s3 == ?s2 & ¬ ?Z3l.meaning == ?Z2l.meaning ) )
    & ( c:?X3l { c:tense = ?tt3 } & c:?X2l { c:tense = ?tt4 } & ?tt3 == ?tt4 )
    & ?X2l.spos == ?X3l.spos
    & ¬ ( c:?Y3l { c:?r6-> c:?Dep6l { c:slex= ?semD6 } } & c:?Y2l { c:?r8-> c:?Dep7l { c:slex= ?semD7 } } & ( ¬?semD6 == ?semD7 | ¬?r6 == ?r8 ) )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked_potential = "yes"
  mergeRootSubj-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X2r {
  rc:<=> ?X2l
  blocked_potential = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  blocked_potential = "yes"
}
  ]
]

/*For bubbles that have the same property and subject but objects with different relations (e.g. born + date; born + place )
Or the same relation and dependents with a different "meaning" status (e.g. locative_relation or temporal_relation)

Here we use "slex" on main verbs to check that they are the same, but "lex" in Agg2.*/
SSynt<=>SSynt merge_SameRootSubj_differentObjRel
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:lex = ?semX1
      c:?r1-> c:?Y1l {
      }
      c:?s1-> c:?Z1l {}
      // there is not other dependent
      ¬c:?OD1-> c:?OtherDep1 {}
      }
    c:*~ c:?S2l {
      c:?X2l {
        c:lex = ?semX2
        c:?r2-> c:?Y2l { ¬c:?ODY2-> c:?OtherDepY2 { ¬c:pos = "DT" } }
        c:?s2-> c:?Z2l {}
        // there is not other dependent
        ¬c:?OD2-> c:?OtherDep2 {}
      }
    }
  }
}

// restrict to subjects and objects  for now
?r1 == ?r2
lexicon.dependencies_default_map.I.rel.?r1
( ( ¬ ?s1 == ?s2 & ( lexicon.dependencies_default_map.II.rel.?s1 | lexicon.dependencies_default_map.AUX.rel.?s1) & ( lexicon.dependencies_default_map.II.rel.?s2 | lexicon.dependencies_default_map.AUX.rel.?s2 ) )
  | ( ?s1 == ?s2 & ¬?Z1l.meaning == ?Z2l.meaning )
)
// the main verb and the subject are the same
?semX1 == ?semX2
// to avoid aggregations of auxiliary with verb
?X1l.spos == ?X2l.spos
( c:?Y2l { c:<-> c:?Y1l {} } | c:?Y1l { c:<-> c:?Y2l {} } | ( c:?Y1l { c:<-> c:?Y0l {} } & c:?Y2l { c:<-> c:?Y0l {} } ) )

// the nodes to be aggregated

//Both Xs are roots.  Only second needs to be root for now, test this.
// ¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// There isn't a dependent on one of the arguments that is not on the dependent of the second sentence (to be improved)
¬ ( c:?Y1l { c:?r4-> c:?Dep4l { c:slex= ?semD4 } } & c:?Y2l { c:?r5-> c:?Dep5l { c:slex= ?semD5 } } & ( ¬?semD4 == ?semD5 | ¬?r4 == ?r5 ) )

// There isn't a pronoun with external antecedent in the sentence to be moved (unless a mention to the same NE is already in the host sentence).
//( ¬ ( c:?S2l { c:?Pro11no { ( c:slex = "_PRO_" | c:pronominalized = yes ) } } )
//  | ( c:?S2l { c:?Pro11 { ( c:slex = "_PRO_" | c:pronominalized = yes ) c:<-> c:?Ante11 {} } }
//    & ( c:?S2l { c:?Ante11 {} } | c:?S1l { c:?Ante11 {} } | ( c:?S11l { c:?Ante11 {} } & c:?S1l { c:?Prob11 { c:<-> c:?Ante11 {} } } ) )
//  )
//)
    
// the verbs both have the same verbal tense
( c:?X1l { c:tense = ?tt1 } & c:?X2l { c:tense = ?tt2 } & ?tt1 == ?tt2 )
  
// ?X1l is the node with the smallest weigth, the only one that can be used as an anchor for coordination (to avoid multiple applications within one bubble).
¬ ( c:?S1l { c:?X8l { c:id = ?idX8 c:lex = ?semX8 c:?r8-> c:?Y8l {}  c:?s8-> c:?Z8l {} ¬c:?OD8-> c:?OtherDep8 {} } }
    & ?r8 ==?r2 & ?semX8 == ?semX2
    & ( c:?Y2l { c:<-> c:?Y8l {} } | c:?Y8l { c:<-> c:?Y2l {} } | ( c:?Y2l { c:<-> c:?Y01l {} } & c:?Y8l { c:<-> c:?Y01l {} } ) )
    & lexicon.dependencies_default_map.I.rel.?r8
    & ( ( ¬ ?s8 == ?s2 &  ( lexicon.dependencies_default_map.II.rel.?s8 | lexicon.dependencies_default_map.AUX.rel.?s8 ) & ( lexicon.dependencies_default_map.II.rel.?s2 | lexicon.dependencies_default_map.AUX.rel.?s2 ) ) | ( ?s8 == ?s2 & ¬ ?Z8l.meaning == ?Z2l.meaning ) )
    & c:?X1l { c:id = ?idX1 } & ?idX8 < ?idX1
    & ( c:?X8l { c:tense = ?tt8 } & c:?X2l { c:tense = ?tt9 } & ?tt8 == ?tt9 )
    & ?X2l.spos == ?X8l.spos
    & ¬ ( c:?Y3l { c:?r6-> c:?Dep6l { c:slex= ?semD6 } } & c:?Y2l { c:?r8-> c:?Dep7l { c:slex= ?semD7 } } & ( ¬?semD6 == ?semD7 | ¬?r6 == ?r8 ) )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  rc:blocked_potential = "yes"
  blocked = "yes"
  applied_agg = "mergeRootSubj"
  rc:mergeRootSubj-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X1r {
  rc:<=> ?X1l
  attach_mergeRootSubj = "yes"
}

rc:?X2r {
  rc:<=> ?X2l
  rc:blocked_potential = "yes"
  blocked = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  rc:blocked_potential = "yes"
  blocked = "yes"
}

¬rc:?S3r { rc:mergeRootSubj-> rc:?S2r {}
                ¬rc:mergeRootSubjCoord-> rc:?S31r {} }
¬rc:?S4r { rc:mergeRootSubjCoord-> rc:?S2r {} }
¬rc:?S2r { rc:mergeRootSubjCoord-> rc:?S5r {} }
//¬rc:?S6r { rc:mergeRootSubjCoord-> rc:?S1r {} }
//¬rc:?S1r { rc:mergeRootSubjCoord-> rc:?S8r {} }
  ]
]

/*For bubbles that have the same verb and obj, and both have a subject with the same relation.
Note that auxiliaries are somewhat considered obj at the moment.

Here we use "slex" on main verbs to check that they are the same, but "lex" in Agg2.*/
SSynt<=>SSynt mark_SameRootObj_onlySubjRel
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:lex = ?semX1
      c:?r1-> c:?Y1l {
}
      c:?s1-> c:?Z1l {
        c:pos = ?posZ1
      }
      // there is not other dependent
      ¬c:?OD1-> c:?OtherDep1 {}
    }
    c:*~ c:?S2l {
      c:?X2l {
        c:lex = ?semX2
        c:?r2-> c:?Y2l { ¬c:?ODY2-> c:?OtherDepY2 { ¬c:pos = "DT" } 
}
        c:?s2-> c:?Z2l {
          c:pos = ?posZ2
        }
        // there is not other dependent
        ¬c:?OD2-> c:?OtherDep2 {}
      }
    }
  }
}

// restrict to subjects and objects  for now
?r1 == ?r2
?s1 == ?s2
( lexicon.dependencies_default_map.II.rel.?r1 | lexicon.dependencies_default_map.AUX.rel.?r1 )
lexicon.dependencies_default_map.I.rel.?s1

// the main verb and the Object are the same
?semX1 == ?semX2
( c:?Y2l { c:<-> c:?Y1l {} } | c:?Y1l { c:<-> c:?Y2l {} } | ( c:?Y1l { c:<-> c:?Y0l {} } & c:?Y2l { c:<-> c:?Y0l {} } )
 | ( c:?Y1l { c:pos = "VB" } & c:?Y2l { c:pos = "VB" } & ?Y1l.slex == ?Y2l.slex & c:?Y1l { ¬c:?OD10-> c:?OtherDep10 {} } )
)

// both Z have the same PoS (this could be relaxed a bit)
?posZ1 == ?posZ2

// if one of the candidates has a specific status (e.g. meaning=locative_relation or temporal_relation), only apply if the other one has the same status.
( ( ¬?Z1l.meaning == ?mZ1 & ¬?Z2l.meaning == ?mZ2 ) | ?Z1l.meaning == ?Z2l.meaning )

//Both Xs are roots.  Only second needs to be root for now, test this.
//¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// There isn't a dependent on one of the arguments that is not on the dependent of the second sentence (to be improved)
// SHOULDN'T THIS CONDITION BE REPEATED ON THE COMPLEX CONDITIONS BELOW?
¬ ( c:?Y1l { c:?r4-> c:?Dep4l { c:slex= ?semD4 } } & c:?Y2l { c:?r5-> c:?Dep5l { c:slex= ?semD5 } } & ( ¬?semD4 == ?semD5 | ¬?r4 == ?r5 ) )

// There isn't a pronoun with external antecedent in the sentence to be moved (unless a mention to the same NE is already in the host sentence).
//( ¬ ( c:?S2l { c:?Pro11no { ( c:slex = "_PRO_" | c:pronominalized = yes ) } } )
//  | ( c:?S2l { c:?Pro11 { ( c:slex = "_PRO_" | c:pronominalized = yes ) c:<-> c:?Ante11 {} } }
//    & ( c:?S2l { c:?Ante11 {} } | c:?S1l { c:?Ante11 {} } | ( c:?S11l { c:?Ante11 {} } & c:?S1l { c:?Prob11 { c:<-> c:?Ante11 {} } } ) )
//  )
//)
    
// the verbs both have the same verbal tense
( c:?X1l { c:tense = ?tt1 } & c:?X2l { c:tense = ?tt2 } & ?tt1 == ?tt2 )
  
// ?S1l is the lightest sentence, to which all other sentences will point (simplified to first ID for now)
¬ ( c:?Tl { c:?S3l { c:*~ c:?S1l {} c:id = ?id3 c:?X3l { c:straight_weight = ?swX3 c:lex = ?semX3 c:?r3-> c:?Y3l {}  c:?s3-> c:?Z3l { c:pos = ?posZ3 } ¬c:?OD3-> c:?OtherDep3 {} } } }
    & ( c:?Y2l { c:<-> c:?Y3l {} } | c:?Y3l { c:<-> c:?Y2l {} } | ( c:?Y2l { c:<-> c:?Y00l {} } & c:?Y3l { c:<-> c:?Y00l {} } ) | ( c:?Y3l { c:pos = "VB" } & c:?Y2l { c:pos = "VB" } & ?Y3l.slex == ?Y2l.slex & c:?Y1l { ¬c:?OD11-> c:?OtherDep11 {} } ) )
    & lexicon.dependencies_default_map.I.rel.?r3 & ( lexicon.dependencies_default_map.II.rel.?s3 | lexicon.dependencies_default_map.AUX.rel.?s3 )
    & ?r3 ==?r2 & ?s3 == ?s2 & ?semX3 == ?semX2 & ?posZ3 == ?posZ2
    & ( ( ¬?Z3l.meaning == ?mZ3 & ¬?Z2l.meaning == ?mZ2bis ) | ?Z3l.meaning == ?Z2l.meaning )
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
    //& c:?X1l { c:straight_weight = ?swX1 } & ?swX3 < ?iswX1
    & ( c:?X3l { c:tense = ?tt3 } & c:?X2l { c:tense = ?tt4 } & ?tt3 == ?tt4 )
    & ¬ ( c:?Y3l { c:?r6-> c:?Dep6l { c:slex= ?semD6 } } & c:?Y2l { c:?r8-> c:?Dep7l { c:slex= ?semD7 } } & ( ¬?semD6 == ?semD7 | ¬?r6 == ?r8 ) )
)
  ]
  mixed = [
//¬ ( c:?Tl { c:?S11l { c:*~ c:?S1l {} c:?X11l { c:lex = ?semX11 c:?r11-> c:?Y11l {}  c:?s11-> c:?Z11l { c:pos = ?posZ11 } ¬c:?OtherDep11 {} } } }
//    & ?r11 ==?r1 & ?s11 == ?s1 & ?semX11 == ?semX1 & c:?Z1l { c:pos = ?posZ1 } & ?posZ11 == ?posZ1
//    & ( c:?Y1l { c:<-> c:?Y11l {} } | ( c:?Y1l { c:<-> c:?Y101l {} } & c:?Y11l { c:<-> c:?Y101l {} } ) )
//    & lexicon.dependencies_default_map.I.rel.?r11 & lexicon.dependencies_default_map.II.rel.?s11
//    & ( ( ¬?Z11l.meaning == ?mZ11 & ¬?Z1l.meaning == ?mZ1 ) | ?Z11l.meaning == ?Z1l.meaning )
//    & ( c:?X11l { c:tense = ?tt11 } & c:?X1l { c:tense = ?tt11b } & ?tt11 == ?tt11b )
//)
  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked_potential = "yes"
  mergeRootObjCoord-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X2r {
  rc:<=> ?X2l
  blocked_potential = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  blocked_potential = "yes"
}
  ]
]

/*For bubbles that have the same verb and obj, and both have a subject with the same relation.
Note that auxiliaries are somewhat considered obj at the moment.

Here we use "slex" on main verbs to check that they are the same, but "lex" in Agg2.*/
SSynt<=>SSynt merge_SameRootObj_onlySubjRel
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:lex = ?semX1
      c:?r1-> c:?Y1l {
}
      c:?s1-> c:?Z1l {
        c:pos = ?posZ1
      }
      // there is not other dependent
      ¬c:?OD1-> c:?OtherDep1 {}
    }
    c:*~ c:?S2l {
      c:?X2l {
        c:lex = ?semX2
        c:?r2-> c:?Y2l { ¬c:?ODY2-> c:?OtherDepY2 { ¬c:pos = "DT" } 
}
        c:?s2-> c:?Z2l {
          c:pos = ?posZ2
        }
        // there is not other dependent
        ¬c:?OD2-> c:?OtherDep2 {}
      }
    }
  }
}

// restrict to subjects and objects  for now
?r1 == ?r2
?s1 == ?s2
( lexicon.dependencies_default_map.II.rel.?r1 | lexicon.dependencies_default_map.AUX.rel.?r1 )
lexicon.dependencies_default_map.I.rel.?s1

// the main verb and the Object are the same
?semX1 == ?semX2
( c:?Y2l { c:<-> c:?Y1l {} } | c:?Y1l { c:<-> c:?Y2l {} } | ( c:?Y1l { c:<-> c:?Y0l {} } & c:?Y2l { c:<-> c:?Y0l {} } )
 | ( c:?Y1l { c:pos = "VB" } & c:?Y2l { c:pos = "VB" } & ?Y1l.slex == ?Y2l.slex & c:?Y1l { ¬c:?OD10-> c:?OtherDep10 {} } )
)

// both Z have the same PoS (this could be relaxed a bit)
?posZ1 == ?posZ2

// if one of the candidates has a specific status (e.g. meaning=locative_relation or temporal_relation), only apply if the other one has the same status.
( ( ¬?Z1l.meaning == ?mZ1 & ¬?Z2l.meaning == ?mZ2 ) | ?Z1l.meaning == ?Z2l.meaning )

//Both Xs are roots.  Only second needs to be root for now, test this.
//¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// There isn't a dependent on one of the arguments that is not on the dependent of the second sentence (to be improved)
// SHOULDN'T THIS CONDITION BE REPEATED ON THE COMPLEX CONDITIONS BELOW?
¬ ( c:?Y1l { c:?r4-> c:?Dep4l { c:slex= ?semD4 } } & c:?Y2l { c:?r5-> c:?Dep5l { c:slex= ?semD5 } } & ( ¬?semD4 == ?semD5 | ¬?r4 == ?r5 ) )

// There isn't a pronoun with external antecedent in the sentence to be moved (unless a mention to the same NE is already in the host sentence).
//( ¬ ( c:?S2l { c:?Pro11no { ( c:slex = "_PRO_" | c:pronominalized = yes ) } } )
//  | ( c:?S2l { c:?Pro11 { ( c:slex = "_PRO_" | c:pronominalized = yes ) c:<-> c:?Ante11 {} } }
//    & ( c:?S2l { c:?Ante11 {} } | c:?S1l { c:?Ante11 {} } | ( c:?S11l { c:?Ante11 {} } & c:?S1l { c:?Prob11 { c:<-> c:?Ante11 {} } } ) )
//  )
//)
    
// the verbs both have the same verbal tense
( c:?X1l { c:tense = ?tt1 } & c:?X2l { c:tense = ?tt2 } & ?tt1 == ?tt2 )

// ?X1l is the node with the smallest weigth, the only one that can be used as an anchor for coordination (to avoid multiple applications within one bubble).
¬ ( ?S1l { c:?X8l { c:id = ?idX8 c:lex = ?semX8 c:?r8 -> c:?Y8l {} c:?s8 -> c:?Z8l { c:pos = ?posZ8 } ¬c:?OD8-> c:?OtherDep8 {} } }
    & ( c:?Y2l { c:<-> c:?Y8l {} } | c:?Y8l { c:<-> c:?Y2l {} } | ( c:?Y2l { c:<-> c:?Y000l {} } & c:?Y8l { c:<-> c:?Y000l {} } ) | ( c:?Y8l { c:pos = "VB" } & c:?Y2l { c:pos = "VB" } & ?Y8l.slex == ?Y2l.slex ) & c:?Y1l { ¬c:?OD12-> c:?OtherDep12 {} } )
    & lexicon.dependencies_default_map.I.rel.?r8 & ( lexicon.dependencies_default_map.II.rel.?s8 | lexicon.dependencies_default_map.AUX.rel.?s8 )
    & ?r8 ==?r2 & ?s8 == ?s2 & ?semX8 == ?semX2 & ?posZ8 == ?posZ2
    & ( ( ¬?Z8l.meaning == ?mZ8 & ¬?Z2l.meaning == ?mZ2ter ) | ?Z8l.meaning == ?Z2l.meaning )
    & c:?X1l { c:id = ?idX1 } & ?idX8 < ?idX1
    //& c:?X1l { c:straight_weight = ?idX1 } & ?idX8 < ?idX1
    & ( c:?X8l { c:tense = ?tt8 } & c:?X2l { c:tense = ?tt8b } & ?tt8 == ?tt8b )
    & ¬ ( c:?Y8l { c:?r6-> c:?Dep6l { c:slex= ?semD6 } } & c:?Y2l { c:?r8-> c:?Dep7l { c:slex= ?semD7 } } & ( ¬?semD6 == ?semD7 | ¬?r6 == ?r8 ) )
)
  ]
  mixed = [
//¬ ( c:?Tl { c:?S11l { c:*~ c:?S1l {} c:?X11l { c:lex = ?semX11 c:?r11-> c:?Y11l {}  c:?s11-> c:?Z11l { c:pos = ?posZ11 } ¬c:?OtherDep11 {} } } }
//    & ?r11 ==?r1 & ?s11 == ?s1 & ?semX11 == ?semX1 & c:?Z1l { c:pos = ?posZ1 } & ?posZ11 == ?posZ1
//    & ( c:?Y1l { c:<-> c:?Y11l {} } | ( c:?Y1l { c:<-> c:?Y101l {} } & c:?Y11l { c:<-> c:?Y101l {} } ) )
//    & lexicon.dependencies_default_map.I.rel.?r11 & lexicon.dependencies_default_map.II.rel.?s11
//    & ( ( ¬?Z11l.meaning == ?mZ11 & ¬?Z1l.meaning == ?mZ1 ) | ?Z11l.meaning == ?Z1l.meaning )
//    & ( c:?X11l { c:tense = ?tt11 } & c:?X1l { c:tense = ?tt11b } & ?tt11 == ?tt11b )
//)
  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  rc:blocked_potential = "yes"
  blocked = "yes"
  applied_agg = "mergeRootObjCoord"
  rc:mergeRootObjCoord-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X1r {
  rc:<=> ?X1l
  mergeRootObjCoord = "anchor"
}

rc:?X2r {
  rc:<=> ?X2l
  rc:blocked_potential = "yes"
  blocked = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  rc:blocked_potential = "yes"
  blocked = "yes"
}

rc:?Z1r {
  rc:<=> ?Z1l
  attach_coord = "yes"
  conjunction_type = "coordination"
}

¬rc:?S3r { rc:mergeRootObjCoord-> rc:?S2r {}
                ¬rc:mergeRootSubjCoord-> rc:?S31r {}
                ¬rc:mergeRootSubj-> rc:?S32r {} }
¬rc:?S4r { rc:mergeRootSubjCoord-> rc:?S2r {} }
¬rc:?S2r { rc:mergeRootSubjCoord-> rc:?S5r {} }
//¬rc:?S6r { rc:mergeRootSubjCoord-> rc:?S1r {} }
//¬rc:?S1r { rc:mergeRootSubjCoord-> rc:?S8r {} }
¬rc:?S9r { rc:mergeRootSubj-> rc:?S2r {} }
¬rc:?S2r { rc:mergeRootSubj-> rc:?S10r {} }
//¬rc:?S11r { rc:mergeRootSubj-> rc:?S1r {} }
//¬rc:?S1r { rc:mergeRootSubj-> rc:?S14r {} }
  ]
]

/*Here we use "slex" on main verbs to check that they are the same, but "lex" in Agg2.*/
SSynt<=>SSynt mark_sameSubj
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:lex = ?semX1
      c:straight_weight = ?swX1
      c:num_deps = ?ndX1
      c:?r1-> c:?Y1l {}
    }
    c:*~ c:?S2l {
      c:?X2l {
        c:lex = ?semX2
        c:straight_weight = ?swX2
        c:num_deps = ?ndX2
        c:?r2-> c:?Y2l {}
      }
    }
  }
}

// restrict to subjects
?r1 == ?r2
lexicon.dependencies_default_map.I.rel.?r1

// both trees have a max depth and width of 3
( ?swX1 < 5 & ?ndX1 < 4 & ?swX2 < 5 & ?ndX2 < 4 )

// the main verbs are NOT the same (to not overlap with SameRootSubj rules)
( ¬?semX1 == ?semX2 | ¬?X1l.tense == ?X2l.tense )
// the subjects are the same
( c:?Y2l { c:<-> c:?Y1l {} } | c:?Y1l { c:<-> c:?Y2l {} } | ( c:?Y1l { c:<-> c:?Y0l {} } & c:?Y2l { c:<-> c:?Y0l {} } ) )

//Both Xs are roots. Not sure that's how it should be but safer and easier for now
¬c:?Gov91l { c:?s91-> c:?X1l {} }
¬c:?Gov92l { c:?s92-> c:?X2l {} }

// There isn't a pronoun with external antecedent in the sentence to be moved (unless a mention to the same NE is already in the host sentence).
//( ¬ ( c:?S2l { c:?Pro11no { ( c:slex = "_PRO_" | c:pronominalized = yes ) } } )
//  | ( c:?S2l { c:?Pro11 { ( c:slex = "_PRO_" | c:pronominalized = yes ) c:<-> c:?Ante11 {} } }
//    & ( c:?S2l { c:?Ante11 {} } | c:?S1l { c:?Ante11 {} } | ( c:?S11l { c:?Ante11 {} } & c:?S1l { c:?Prob11 { c:<-> c:?Ante11 {} } } ) )
//  )
//)

// ?S1l is the first preceding sentence with which this aggregation is possible
¬ ( c:?Tl { c:?S3l { c:*~ c:?S1l {} c:id = ?id3 c:?X3l { c:straight_weight = ?swX3 c:num_deps = ?ndX3 c:lex = ?semX3 c:?r3-> c:?Y3l {} } } }
    & ?r3 ==?r2 & lexicon.dependencies_default_map.I.rel.?r3  & ?swX3 < 5 & ?ndX3 < 4
    & ( ¬?semX3 == ?semX2 | ¬?X3l.tense == ?X2l.tense )
    & ( c:?Y2l { c:<-> c:?Y3l {} } | c:?Y3l { c:<-> c:?Y2l {} } | ( c:?Y2l { c:<-> c:?Y00l {} } & c:?Y3l { c:<-> c:?Y00l {} } ) )
    & ¬c:?Gov3l { c:?s3-> c:?X3l {} }
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
)
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked_potential = "yes"
  noMergeCoordSameSubj-> rc:?S1r {
    rc:<=> ?S1l
  }
}
  ]
]

/*Here we use "slex" on main verbs to check that they are the same, but "lex" in Agg2.*/
SSynt<=>SSynt merge_sameSubj
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:lex = ?semX1
      c:straight_weight = ?swX1
      c:num_deps = ?ndX1
      c:?r1-> c:?Y1l {}
    }
    c:*~ c:?S2l {
      c:?X2l {
        c:lex = ?semX2
        c:straight_weight = ?swX2
        c:num_deps = ?ndX2
        c:?r2-> c:?Y2l {}
      }
    }
  }
}

// restrict to subjects
?r1 == ?r2
lexicon.dependencies_default_map.I.rel.?r1

// both trees have a max depth and width of 3
( ?swX1 < 5 & ?ndX1 < 4 & ?swX2 < 5 & ?ndX2 < 4 )

// the main verbs are NOT the same (to not overlap with SameRootSubj rules)
( ¬?semX1 == ?semX2 | ¬?X1l.tense == ?X2l.tense )
// the subjects are the same
( c:?Y2l { c:<-> c:?Y1l {} } | c:?Y1l { c:<-> c:?Y2l {} } | ( c:?Y1l { c:<-> c:?Y0l {} } & c:?Y2l { c:<-> c:?Y0l {} } ) )

//Both Xs are roots. Not sure that's how it should be but safer and easier for now
¬c:?Gov91l { c:?s91-> c:?X1l {} }
¬c:?Gov92l { c:?s92-> c:?X2l {} }

// There isn't a pronoun with external antecedent in the sentence to be moved (unless a mention to the same NE is already in the host sentence).
//( ¬ ( c:?S2l { c:?Pro11no { ( c:slex = "_PRO_" | c:pronominalized = yes ) } } )
//  | ( c:?S2l { c:?Pro11 { ( c:slex = "_PRO_" | c:pronominalized = yes ) c:<-> c:?Ante11 {} } }
//    & ( c:?S2l { c:?Ante11 {} } | c:?S1l { c:?Ante11 {} } | ( c:?S11l { c:?Ante11 {} } & c:?S1l { c:?Prob11 { c:<-> c:?Ante11 {} } } ) )
//  )
//)
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  rc:blocked_potential = "yes"
  blocked = "yes"
  applied_agg = "noMergeCoordSameSubj"
  rc:noMergeCoordSameSubj-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X1r {
  rc:<=> ?X1l
  attach_coord = "yes"
  conjunction_type = "coordination"
}


¬rc:?S3r { rc:noMergeCoordSameSubj-> rc:?S2r {}
                ¬rc:mergeRootSubjCoord-> rc:?S31r {}
                ¬rc:mergeRootSubj-> rc:?S32r {}
                ¬rc:mergeRootObjCoord-> rc:?S33r {} }
¬rc:?S4r { rc:mergeRootSubjCoord-> rc:?S2r {} }
¬rc:?S2r { rc:mergeRootSubjCoord-> rc:?S5r {} }
//¬rc:?S6r { rc:mergeRootSubjCoord-> rc:?S1r { rc:<=> ?S1l } }
//¬rc:?S7r { rc:<=> ?S1l rc:mergeRootSubjCoord-> rc:?S8r {} }
¬rc:?S9r { rc:mergeRootSubj-> rc:?S2r {} }
¬rc:?S2r { rc:mergeRootSubj-> rc:?S10r {} }
//¬rc:?S11r { rc:mergeRootSubj-> rc:?S12r { rc:<=> ?S1l } }
//¬rc:?S13r { rc:<=> ?S1l rc:mergeRootSubj-> rc:?S14r {} }
¬rc:?S15r { rc:mergeRootObjCoord-> rc:?S2r {} }
¬rc:?S2r { rc:mergeRootObjCoord-> rc:?S16r {} }
//¬rc:?S17r { rc:mergeRootObjCoord-> rc:?S18r { rc:<=> ?S1l } }
//¬rc:?S19r { rc:<=> ?S1l rc:mergeRootObjCoord-> rc:?S20r {} }
  ]
]

/*Here we use "slex" on main verbs to check that they are the same, but "lex" in Agg2.*/
SSynt<=>SSynt mark_similarSubj
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:slex = ?semX1
      c:straight_weight = ?swX1
      c:num_deps = ?ndX1
      c:?r1-> c:?Y1l {}
    }
    c:*~ c:?S2l {
      c:?X2l {
        c:slex = ?semX2
        c:straight_weight = ?swX2
        c:num_deps = ?ndX2
        c:?r2-> c:?Y2l {}
      }
    }
  }
}

// restrict to subjects
?r1 == ?r2
lexicon.dependencies_default_map.I.rel.?r1

// both trees have a max depth and width of 3
( ?swX1 < 5 & ?ndX1 < 4 & ?swX2 < 5 & ?ndX2 < 4 )

// the main verbs are NOT the same (to not overlap with SameRootSubj rules)
( ¬?semX1 == ?semX2 | ¬?X1l.tense == ?X2l.tense
  | ( c:?X1l { c:?r16-> c:?Part16 { c:lex = ?lp16 } } & c:?X2l { c:?r17-> c:?Part17 { c:lex = ?lp17 } } & ¬ ?lp16 == ?lp17 & lexicon.dependencies_default_map.AUX.rel.?r16 & lexicon.dependencies_default_map.AUX.rel.?r17 ) )
// the subjects are not the same but have the same head
¬( c:?Y2l { c:<-> c:?Y1l {} } | c:?Y1l { c:<-> c:?Y2l {} } | ( c:?Y1l { c:<-> c:?Y0l {} } & c:?Y2l { c:<-> c:?Y0l {} } ) )
?Y1l.lex == ?Y2l.lex
( c:?Y1l { c:?r12-> c:?Dep12l { c:slex= ?semD12 } } & c:?Y2l { c:?r13-> c:?Dep13l { c:slex= ?semD13 } } & ( ¬?semD12 == ?semD13 | ¬?r12 == ?r13 ) )

//Both Xs are roots. Not sure that's how it should be but safer and easier for now
¬c:?Gov91l { c:?s91-> c:?X1l {} }
¬c:?Gov92l { c:?s92-> c:?X2l {} }

// There isn't a pronoun with external antecedent in the sentence to be moved (unless a mention to the same NE is already in the host sentence).
//( ¬ ( c:?S2l { c:?Pro11no { ( c:slex = "_PRO_" | c:pronominalized = yes ) } } )
//   | ( c:?S2l { c:?Pro11 { ( c:slex = "_PRO_" | c:pronominalized = yes ) c:<-> c:?Ante11 {} } }
//     & ( c:?S2l { c:?Ante11 {} } | c:?S1l { c:?Ante11 {} } | ( c:?S11l { c:?Ante11 {} } & c:?S1l { c:?Prob11 { c:<-> c:?Ante11 {} } } ) )
//   )
//)

// ?S1l is the first preceding sentence with which this aggregation is possible
¬ ( c:?Tl { c:?S3l { c:*~ c:?S1l {} c:id = ?id3 c:?X3l { c:straight_weight = ?swX3 c:num_deps = ?ndX3 c:lex = ?semX3 c:?r3-> c:?Y3l {} } } }
    & ?r3 ==?r2 & lexicon.dependencies_default_map.I.rel.?r3  & ?swX3 < 5 & ?ndX3 < 4
    & ( ¬?semX3 == ?semX2 | ¬?X3l.tense == ?X2l.tense
        | ( c:?X1l { c:?r18-> c:?Part18 { c:lex = ?lp18 } } & c:?X2l { c:?r19-> c:?Part19 { c:lex = ?lp19 } } & ¬ ?lp18 == ?lp19 & lexicon.dependencies_default_map.AUX.rel.?r18 & lexicon.dependencies_default_map.AUX.rel.?r19 ) )
    & ¬( c:?Y2l { c:<-> c:?Y3l {} } | c:?Y3l { c:<-> c:?Y2l {} } | ( c:?Y2l { c:<-> c:?Y00l {} } & c:?Y3l { c:<-> c:?Y00l {} } ) )
    & ?Y3l.lex == ?Y2l.lex
    & ( c:?Y3l { c:?r14-> c:?Dep14l { c:slex= ?semD14 } } & c:?Y2l { c:?r15-> c:?Dep15l { c:slex= ?semD15 } } & ( ¬?semD14 == ?semD15 | ¬?r14 == ?r15 ) )
    & ¬c:?Gov3l { c:?s3-> c:?X3l {} }
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
)
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked_potential = "yes"
  noMergeCoordSimSubj-> rc:?S1r {
    rc:<=> ?S1l
  }
}
  ]
]

/*Here we use "slex" on main verbs to check that they are the same, but "lex" in Agg2.*/
SSynt<=>SSynt merge_similarSubj
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:slex = ?semX1
      c:straight_weight = ?swX1
      c:num_deps = ?ndX1
      c:?r1-> c:?Y1l {}
    }
    c:*~ c:?S2l {
      c:?X2l {
        c:slex = ?semX2
        c:straight_weight = ?swX2
        c:num_deps = ?ndX2
        c:?r2-> c:?Y2l {}
      }
    }
  }
}

// restrict to subjects
?r1 == ?r2
lexicon.dependencies_default_map.I.rel.?r1

// both trees have a max depth and width of 3
( ?swX1 < 5 & ?ndX1 < 4 & ?swX2 < 5 & ?ndX2 < 4 )

// the main verbs are NOT the same (to not overlap with SameRootSubj rules)
( ¬?semX1 == ?semX2 | ¬?X1l.tense == ?X2l.tense
  | ( c:?X1l { c:?r16-> c:?Part16 { c:lex = ?lp16 } } & c:?X2l { c:?r17-> c:?Part17 { c:lex = ?lp17 } } & ¬ ?lp16 == ?lp17 & lexicon.dependencies_default_map.AUX.rel.?r16 & lexicon.dependencies_default_map.AUX.rel.?r17 ) )
// the subjects are not the same but have the same head
¬( c:?Y2l { c:<-> c:?Y1l {} } | c:?Y1l { c:<-> c:?Y2l {} } | ( c:?Y1l { c:<-> c:?Y0l {} } & c:?Y2l { c:<-> c:?Y0l {} } ) )
?Y1l.lex == ?Y2l.lex
( c:?Y1l { c:?r12-> c:?Dep12l { c:slex= ?semD12 } } & c:?Y2l { c:?r13-> c:?Dep13l { c:slex= ?semD13 } } & ( ¬?semD12 == ?semD13 | ¬?r12 == ?r13 ) )

//Both Xs are roots. Not sure that's how it should be but safer and easier for now
¬c:?Gov91l { c:?s91-> c:?X1l {} }
¬c:?Gov92l { c:?s92-> c:?X2l {} }

// There isn't a pronoun with external antecedent in the sentence to be moved (unless a mention to the same NE is already in the host sentence).
//( ¬ ( c:?S2l { c:?Pro11no { ( c:slex = "_PRO_" | c:pronominalized = yes ) } } )
//   | ( c:?S2l { c:?Pro11 { ( c:slex = "_PRO_" | c:pronominalized = yes ) c:<-> c:?Ante11 {} } }
//     & ( c:?S2l { c:?Ante11 {} } | c:?S1l { c:?Ante11 {} } | ( c:?S11l { c:?Ante11 {} } & c:?S1l { c:?Prob11 { c:<-> c:?Ante11 {} } } ) )
//   )
//)
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  rc:blocked_potential = "yes"
  blocked = "yes"
  applied_agg = "noMergeCoordSimSubj"
  rc:noMergeCoordSimSubj-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X1r {
  rc:<=> ?X1l
  attach_coord = "yes"
  conjunction_type = "coordination"
}

¬rc:?S3r { rc:noMergeCoordSimSubj-> rc:?S2r {}
                ¬rc:mergeRootSubjCoord-> rc:?S31r {}
                ¬rc:mergeRootSubj-> rc:?S32r {}
                ¬rc:mergeRootObjCoord-> rc:?S33r {}
                ¬rc:noMergeCoordSameSubj-> rc:?S34r {} }
¬rc:?S4r { rc:mergeRootSubjCoord-> rc:?S2r {} }
¬rc:?S2r { rc:mergeRootSubjCoord-> rc:?S5r {} }
//¬rc:?S6r { rc:mergeRootSubjCoord-> rc:?S1r { rc:<=> ?S1l } }
//¬rc:?S7r { rc:<=> ?S1l rc:mergeRootSubjCoord-> rc:?S8r {} }
¬rc:?S9r { rc:mergeRootSubj-> rc:?S2r {} }
¬rc:?S2r { rc:mergeRootSubj-> rc:?S10r {} }
//¬rc:?S11r { rc:mergeRootSubj-> rc:?S12r { rc:<=> ?S1l } }
//¬rc:?S13r { rc:<=> ?S1l rc:mergeRootSubj-> rc:?S14r {} }
¬rc:?S15r { rc:mergeRootObjCoord-> rc:?S2r {} }
¬rc:?S2r { rc:mergeRootObjCoord-> rc:?S16r {} }
//¬rc:?S17r { rc:mergeRootObjCoord-> rc:?S18r { rc:<=> ?S1l } }
//¬rc:?S19r { rc:<=> ?S1l rc:mergeRootObjCoord-> rc:?S20r {} }
¬rc:?S21r { rc:noMergeCoordSameSubj-> rc:?S2r {} }
¬rc:?S2r { rc:noMergeCoordSameSubj-> rc:?S22r {} }
//¬rc:?S23r { rc:noMergeCoordSameSubj-> rc:?S24r { rc:<=> ?S1l } }
//¬rc:?S25r { rc:<=> ?S1l rc:noMergeCoordSameSubj-> rc:?S26r {} }
  ]
]

/*For bubbles that have the same verb and arguments slots, but none of the arguments is the same. Aggregate the sentences which mention the same entity.
Update: removed the condition that states that the root must be the same. Good idea? Update: No; need another rule to restrict more the aggregations.
Here we use "slex" on main verbs to check that they are the same, but "lex" in Agg2.*/
SSynt<=>SSynt mark_SameRootOnly
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:lex = ?semX1
      c:straight_weight = ?swX1
      c:num_deps = ?ndX1
      c:?r1-> c:?Y1l {
}
      c:?s1-> c:?Z1l {}
    }
    c:*~ c:?S2l {
      c:?X2l {
        c:lex = ?semX2
        c:straight_weight = ?swX2
        c:num_deps = ?ndX2
        c:?r2-> c:?Y2l {
}
        c:?s2-> c:?Z2l {}
      }
    }
  }
}

// ?Y and ?Z are arguments (good condition?)
( lexicon.dependencies_default_map.I.rel.?r1 | lexicon.dependencies_default_map.II.rel.?r1 | lexicon.dependencies_default_map.AUX.rel.?r1 | lexicon.dependencies_default_map.III.rel.?r1 | lexicon.dependencies_default_map.IV.rel.?r1 | lexicon.dependencies_default_map.V.rel.?r1 )
( lexicon.dependencies_default_map.I.rel.?s1 | lexicon.dependencies_default_map.II.rel.?s1 | lexicon.dependencies_default_map.AUX.rel.?s1 | lexicon.dependencies_default_map.III.rel.?s1 | lexicon.dependencies_default_map.IV.rel.?s1 | lexicon.dependencies_default_map.V.rel.?s1 )

// both trees have a max depth and width of 3
( ?swX1 < 7 & ?ndX1 < 4 & ?swX2 < 7 & ?ndX2 < 4 )

// only the main verb and the argument slots are the same
?r1 == ?r2
?s1 == ?s2
?semX1 == ?semX2
¬ ( c:?Y2l { c:<-> c:?Y1l {} } | c:?Y1l { c:<-> c:?Y2l {} } | ( c:?Y1l { c:<-> c:?Y0l {} } & c:?Y2l { c:<-> c:?Y0l {} } ) )
¬ ( c:?Z2l { c:<-> c:?Z1l {} } | c:?Z1l { c:<-> c:?Z2l {} } | ( c:?Z1l { c:<-> c:?Z0l {} } & c:?Z2l { c:<-> c:?Z0l {} } ) )
// Not activated yet, just to see what happens; seems to give some issues, so reactivated. (where? I deactivated again)
// Reasons for last deactivation: WebNLG2017-test 5, 160
//¬ ?Y1l.slex == ?Y2l.slex
//¬ ?Z1l.slex == ?Z2l.slex

// The two bubbles have one node that mentions the same entity
( c:?S1l { c:?NE1l {} } & c:?S2l { c:?NE2l {} } & ( c:?NE2l { c:<-> c:?NE1l {} } | ( c:?NE1l { c:<-> c:?OriNEl {} } & c:?NE2l { c:<-> c:?OriNEl {} } ) ) )
// There isn't a person  in the sentence to be aggregated that is not in the first sentence (to avoid confusions with pronouns in the sentence after S1).
¬ ( c:?S1l { c:?NE3l { c:class = "Person" } } & c:?S2l { c:?NE4l { c:class = "Person" } } & ¬?NE3l.slex == ?NE4l.slex )

// so rule applies once only
?Y1l.id < ?Z1l.id
// Activate if not checking that the relations are the same.
//?Y2l.id < ?Z2l.id

//Both Xs are roots.  Only second needs to be root for now, test this.
//¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }
// The first element is not the modifier of another element; aggregating something to X1 would probably destroy the meaning of the sentence.
¬ ( c:?Gov6l { c:?r6-> c:?X1l {} } & lexicon.dependencies_default_map.ATTR.rel.?r6 )

// There isn't a pronoun with external antecedent in the sentence to be moved (unless a mention to the same NE is already in the host sentence).
//( ¬ ( c:?S2l { c:?Pro11no { ( c:slex = "_PRO_" | c:pronominalized = yes ) } } )
//  | ( c:?S2l { c:?Pro11 { ( c:slex = "_PRO_" | c:pronominalized = yes ) c:<-> c:?Ante11 {} } }
//    & ( c:?S2l { c:?Ante11 {} } | c:?S1l { c:?Ante11 {} } | ( c:?S11l { c:?Ante11 {} } & c:?S1l { c:?Prob11 { c:<-> c:?Ante11 {} } } ) )
//  )
//)

// the verbs both have the same verbal tense
//( c:?X1l { c:tense = ?tt1 } & c:?X2l { c:tense = ?tt2 } & ?tt1 == ?tt2 )
  
// ?S1l is the lightest sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:*~ c:?S2l {} c:id = ?id3 c:?X3l { c:straight_weight = ?swX3 c:num_deps = ?ndX3 c:lex = ?semX3 c:?r3-> c:?Y3l {}  c:?s3-> c:?Z3l {} } } }
    & ¬ ( c:?Y2l { c:<-> c:?Y3l {} } | c:?Y3l { c:<-> c:?Y2l {} } | ( c:?Y2l { c:<-> c:?Y00l {} } & c:?Y3l { c:<-> c:?Y00l {} } ) )
    & ¬ ( c:?Z2l { c:<-> c:?Z3l {} } | c:?Z3l { c:<-> c:?Z2l {} } | ( c:?Z2l { c:<-> c:?Z00l {} } & c:?Z3l { c:<-> c:?Z00l {} } ) )
    & ?semX3 == ?semX2 & ?r3 ==?r2 & ?s3 == ?s2
    //& ( c:?X3l { c:tense = ?tt3 } & c:?X2l { c:tense = ?tt4 } & ?tt3 == ?tt4 )
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
    & ( ?swX3 < 7 & ?ndX3 < 4 )
    // Once the rule is more or less stable, make counterpart rule to cover when the weights are the same, using the IDs this time.
    // & ( ( ?swX3 < ?swX1 | ?swX3 == ?swX1 ) & ?ndX3 < 4 )
    & ¬c:?Gov3l { c:?r03-> c:?X3l {} }
    & ( c:?S2l { c:?NES2l {} } & c:?S3l { c:?NES3l {} } & ( c:?NES2l { c:<-> c:?NES3l {} } | ( c:?NES2l { c:<-> c:?OriNE4l {} } & c:?NES3l { c:<-> c:?OriNE4l {} } ) ) )
    &¬ ( c:?S3l { c:?NE8l { c:class = "Person" } } & c:?S2l { c:?NE9l { c:class = "Person" } } & ¬?NE8l.slex == ?NE9l.slex )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked_potential = "yes"
  noMergeCoordSameRoot-> rc:?S1r {
    rc:<=> ?S1l
  }
}
  ]
]

/*For bubbles that have the same verb and arguments slots, but none of the arguments is the same. Aggregate the sentences which mention the same entity.
Update: removed the condition that states that the root must be the same. Good idea? Update: No; need another rule to restrict more the aggregations.
Here we use "slex" on main verbs to check that they are the same, but "lex" in Agg2.*/
SSynt<=>SSynt merge_SameRootOnly
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:lex = ?semX1
      c:straight_weight = ?swX1
      c:num_deps = ?ndX1
      c:?r1-> c:?Y1l {
}
      c:?s1-> c:?Z1l {}
    }
    c:*~ c:?S2l {
      c:?X2l {
        c:lex = ?semX2
        c:straight_weight = ?swX2
        c:num_deps = ?ndX2
        c:?r2-> c:?Y2l {
}
        c:?s2-> c:?Z2l {}
      }
    }
  }
}

// ?Y and ?Z are arguments (good condition?)
( lexicon.dependencies_default_map.I.rel.?r1 | lexicon.dependencies_default_map.II.rel.?r1 | lexicon.dependencies_default_map.AUX.rel.?r1 | lexicon.dependencies_default_map.III.rel.?r1 | lexicon.dependencies_default_map.IV.rel.?r1 | lexicon.dependencies_default_map.V.rel.?r1 )
( lexicon.dependencies_default_map.I.rel.?s1 | lexicon.dependencies_default_map.II.rel.?s1 | lexicon.dependencies_default_map.AUX.rel.?s1 | lexicon.dependencies_default_map.III.rel.?s1 | lexicon.dependencies_default_map.IV.rel.?s1 | lexicon.dependencies_default_map.V.rel.?s1 )

// both trees have a max depth and width of 3
( ?swX1 < 7 & ?ndX1 < 4 & ?swX2 < 7 & ?ndX2 < 4 )

// only the main verb and the argument slots are the same
?r1 == ?r2
?s1 == ?s2
?semX1 == ?semX2
¬ ( c:?Y2l { c:<-> c:?Y1l {} } | c:?Y1l { c:<-> c:?Y2l {} } | ( c:?Y1l { c:<-> c:?Y0l {} } & c:?Y2l { c:<-> c:?Y0l {} } ) )
¬ ( c:?Z2l { c:<-> c:?Z1l {} } | c:?Z1l { c:<-> c:?Z2l {} } | ( c:?Z1l { c:<-> c:?Z0l {} } & c:?Z2l { c:<-> c:?Z0l {} } ) )
// Not activated yet, just to see what happens; seems to give some issues, so reactivated. (where? I deactivated again)
// Reasons for last deactivation: WebNLG2017-test 5, 160
//¬ ?Y1l.slex == ?Y2l.slex
//¬ ?Z1l.slex == ?Z2l.slex

// The two bubbles have one node that mentions the same entity
( c:?S1l { c:?NE1l {} } & c:?S2l { c:?NE2l {} } & ( c:?NE2l { c:<-> c:?NE1l {} } | ( c:?NE1l { c:<-> c:?OriNEl {} } & c:?NE2l { c:<-> c:?OriNEl {} } ) ) )
// There isn't a person  in the sentence to be aggregated that is not in the first sentence (to avoid confusions with pronouns in the sentence after S1).
¬ ( c:?S1l { c:?NE3l { c:class = "Person" } } & c:?S2l { c:?NE4l { c:class = "Person" } } & ¬?NE3l.slex == ?NE4l.slex )

// so rule applies once only
?Y1l.id < ?Z1l.id
// Activate if not checking that the relations are the same.
//?Y2l.id < ?Z2l.id

//Both Xs are roots.  Only second needs to be root for now, test this.
//¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }
// The first element is not the modifier of another element; aggregating something to X1 would probably destroy the meaning of the sentence.
¬ ( c:?Gov6l { c:?r6-> c:?X1l {} } & lexicon.dependencies_default_map.ATTR.rel.?r6 )

// There isn't a pronoun with external antecedent in the sentence to be moved (unless a mention to the same NE is already in the host sentence).
//( ¬ ( c:?S2l { c:?Pro11no { ( c:slex = "_PRO_" | c:pronominalized = yes ) } } )
//  | ( c:?S2l { c:?Pro11 { ( c:slex = "_PRO_" | c:pronominalized = yes ) c:<-> c:?Ante11 {} } }
//    & ( c:?S2l { c:?Ante11 {} } | c:?S1l { c:?Ante11 {} } | ( c:?S11l { c:?Ante11 {} } & c:?S1l { c:?Prob11 { c:<-> c:?Ante11 {} } } ) )
//  )
//)

// the verbs both have the same verbal tense
//( c:?X1l { c:tense = ?tt1 } & c:?X2l { c:tense = ?tt2 } & ?tt1 == ?tt2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  rc:blocked_potential = "yes"
  blocked = "yes"
  applied_agg = "noMergeCoordSameRoot"
  rc:noMergeCoordSameRoot-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X1r {
  rc:<=> ?X1l
  attach_coord = "yes"
  conjunction_type = "coordination"
}

¬rc:?S3r { rc:noMergeCoordSameRoot-> rc:?S2r {}
                ¬rc:mergeRootSubjCoord-> rc:?S31r {}
                ¬rc:mergeRootSubj-> rc:?S32r {}
                ¬rc:mergeRootObjCoord-> rc:?S33r {}
                ¬rc:noMergeCoordSameSubj-> rc:?S34r {}
                ¬rc:noMergeCoordSimSubj-> rc:?S35r {} }
¬rc:?S4r { rc:mergeRootSubjCoord-> rc:?S2r {} }
¬rc:?S2r { rc:mergeRootSubjCoord-> rc:?S5r {} }
//¬rc:?S6r { rc:mergeRootSubjCoord-> rc:?S1r { rc:<=> ?S1l } }
//¬rc:?S7r { rc:<=> ?S1l rc:mergeRootSubjCoord-> rc:?S8r {} }
¬rc:?S9r { rc:mergeRootSubj-> rc:?S2r {} }
¬rc:?S2r { rc:mergeRootSubj-> rc:?S10r {} }
//¬rc:?S11r { rc:mergeRootSubj-> rc:?S12r { rc:<=> ?S1l } }
//¬rc:?S13r { rc:<=> ?S1l rc:mergeRootSubj-> rc:?S14r {} }
¬rc:?S15r { rc:mergeRootObjCoord-> rc:?S2r {} }
¬rc:?S2r { rc:mergeRootObjCoord-> rc:?S16r {} }
//¬rc:?S17r { rc:mergeRootObjCoord-> rc:?S18r { rc:<=> ?S1l } }
//¬rc:?S19r { rc:<=> ?S1l rc:mergeRootObjCoord-> rc:?S20r {} }
¬rc:?S21r { rc:noMergeCoordSameSubj-> rc:?S2r {} }
¬rc:?S2r { rc:noMergeCoordSameSubj-> rc:?S22r {} }
//¬rc:?S23r { rc:noMergeCoordSameSubj-> rc:?S24r { rc:<=> ?S1l } }
//¬rc:?S25r { rc:<=> ?S1l rc:noMergeCoordSameSubj-> rc:?S26r {} }
¬rc:?S27r { rc:noMergeCoordSimSubj-> rc:?S2r {} }
¬rc:?S2r { rc:noMergeCoordSimSubj-> rc:?S28r {} }
//¬rc:?S29r { rc:noMergeCoordSimSubj-> rc:?S30r { rc:<=> ?S1l } }
//¬rc:?S31r { rc:<=> ?S1l rc:noMergeCoordSimSubj-> rc:?S32r {} }
  ]
]

SSynt<=>SSynt CONNEXIONs_mark_contrast
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:lex = ?semX1
      c:?r1-> c:?Y1l {
        c:lex = ?semY1
      }
      c:?s1-> c:?Z1l {}
      // there is not other dependent
      ¬c:?OD1-> c:?OtherDep1 {}
    }
    c:*~ c:?S2l {
      c:?X2l {
        c:lex = ?semX2
        c:?r2-> c:?Y2l {
          c:lex = ?semY2
        }
        c:?s2-> c:?Z2l {}
        // there is not other dependent
        ¬c:?OD2-> c:?OtherDep2 {}
      }
    }
  }
}

// restrict to subjects and objects  for now
?r1 == ?r2
?s1 == ?s2
( lexicon.dependencies_default_map.II.rel.?r1 | lexicon.dependencies_default_map.AUX.rel.?r1 )
lexicon.dependencies_default_map.I.rel.?s1

// the main verb is the same and the Objects are markede as contrasting in the lexicon
//?semX1 == "be"
lexicon.miscellaneous.verbs.copula.?semX1
?semX1 == ?semX2
//( ( ?semY1 == "high" | ?semY2 == "low" ) | ( ?semY1 == "extremely_high" & ?semY2 == "extremely_low" ) | ( ?semY1 == "very_high" & ?semY2 == "very_low" )
//  | ( ?semY2 == "high" | ?semY1 == "low" ) | ( ?semY2 == "extremely_high" & ?semY1 == "extremely_low" ) | ( ?semY2 == "very_high" & ?semY1 == "very_low" ) )
( ( lexicon.?semY1.contrast.?cY1 & ?cY1 == ?semY2 ) | ( lexicon.?semY2.contrast.?cY2 & ?cY2 == ?semY1 ) )

// the verbs both have the same verbal tense
( c:?X1l { c:tense = ?tt1 } & c:?X2l { c:tense = ?tt2 } & ?tt1 == ?tt2 )

// Limit the weight of the sentences to be aggregated; only first one needs limiting?
?X1l.straight_weight < 15
//?X2l.straight_weight < 15

// The objects are not coreferring (see SameRootObj)
¬( c:?Y2l { c:<-> c:?Y1l {} } | ( c:?Y1l { c:<-> c:?Y0l {} } & c:?Y2l { c:<-> c:?Y0l {} } ) )

// The two bubbles don't have one node that mentions the same entity (see same RootOnly)
¬( c:?S1l { c:?NE1l {} } & c:?S2l { c:?NE2l {} } & ( c:?NE2l { c:<-> c:?NE1l {} } | ( c:?NE1l { c:<-> c:?OriNEl {} } & c:?NE2l { c:<-> c:?OriNEl {} } ) ) )

// if one of the candidates has a specific status (e.g. meaning=locative_relation or temporal_relation), only apply if the other one has the same status.
//( ( ¬?Z1l.meaning == ?mZ1 & ¬?Z2l.meaning == ?mZ2 ) | ?Z1l.meaning == ?Z2l.meaning )

//Both Xs are roots.  Only second needs to be root for now, test this.
//¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// There isn't a pronoun with external antecedent in the sentence to be moved (unless a mention to the same NE is already in the host sentence and there is no other coref with another sentence).
//( ¬ ( c:?S2l { c:?Pro11no { ( c:slex = "_PRO_" | c:pronominalized = yes ) } } )
//  | ( c:?S2l { c:?Pro11 { ( c:slex = "_PRO_" | c:pronominalized = yes ) c:<-> c:?Ante11 {} } }
//    & ( c:?S2l { c:?Ante11 {} } | c:?S1l { c:?Ante11 {} } | ( c:?S11l { c:?Ante11 {} } & c:?S1l { c:?Prob11 { c:<-> c:?Ante11 {} } } ) )
    //& ¬( c:?S2l { c:?Pro12 { ( c:slex = "_PRO_" | c:pronominalized = "yes" ) c:<-> c:?Ante12 {} } } & c:?S12l { c:?Ante12 {} } & ¬?S12l.id == ?S1l.id )
//  )
//)
  
// ?S1l is the lightest sentence, to which all other sentences will point (simplified to first ID for now)
¬ ( c:?Tl { c:?S3l { c:*~ c:?S1l {} c:id = ?id3 c:?X3l { c:straight_weight = ?swX3 c:lex = ?semX3 c:?r3-> c:?Y3l { c:lex = ?semY3 }  c:?s3-> c:?Z3l { c:pos = ?posZ3 } ¬c:?OD3-> c:?OtherDep3 {} } } }
    & ¬( c:?Y2l { c:<-> c:?Y3l {} } | ( c:?Y2l { c:<-> c:?Y00l {} } & c:?Y3l { c:<-> c:?Y00l {} } ) )
    & ¬( c:?S3l { c:?NE01l {} } & c:?S2l { c:?NE02l {} } & ( c:?NE02l { c:<-> c:?NE01l {} } | ( c:?NE01l { c:<-> c:?OriNE0l {} } & c:?NE02l { c:<-> c:?OriNE0l {} } ) ) )
    & ( ( lexicon.?semY3.contrast.?cY3 & ?cY3 == ?semY2 ) | ( lexicon.?semY2.contrast.?cY2 & ?cY2 == ?semY3 ) )
    & ?r3 ==?r2 & ?s3 == ?s2 & ?semX3 == ?semX2
    & ?swX3 < 15
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
    & ( c:?X3l { c:tense = ?tt3 } & c:?X2l { c:tense = ?tt4 } & ?tt3 == ?tt4 )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked_potential = "yes"
  noMergeCoordContrastLex-> rc:?S1r {
    rc:<=> ?S1l
  }
}
  ]
]

SSynt<=>SSynt CONNEXIONs_merge_contrast
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:lex = ?semX1
      c:?r1-> c:?Y1l {
        c:lex = ?semY1
      }
      c:?s1-> c:?Z1l {}
      // there is not other dependent
      ¬c:?OD1-> c:?OtherDep1 {}
    }
    c:*~ c:?S2l {
      c:?X2l {
        c:lex = ?semX2
        c:?r2-> c:?Y2l {
          c:lex = ?semY2
        }
        c:?s2-> c:?Z2l {}
        // there is not other dependent
        ¬c:?OD2-> c:?OtherDep2 {}
      }
    }
  }
}

// restrict to subjects and objects  for now
?r1 == ?r2
?s1 == ?s2
( lexicon.dependencies_default_map.II.rel.?r1 | lexicon.dependencies_default_map.AUX.rel.?r1 )
lexicon.dependencies_default_map.I.rel.?s1

// the main verb is the same and the Objects are markede as contrasting in the lexicon
//?semX1 == "be"
lexicon.miscellaneous.verbs.copula.?semX1
?semX1 == ?semX2
//( ( ?semY1 == "high" | ?semY2 == "low" ) | ( ?semY1 == "extremely_high" & ?semY2 == "extremely_low" ) | ( ?semY1 == "very_high" & ?semY2 == "very_low" )
//  | ( ?semY2 == "high" | ?semY1 == "low" ) | ( ?semY2 == "extremely_high" & ?semY1 == "extremely_low" ) | ( ?semY2 == "very_high" & ?semY1 == "very_low" ) )
( ( lexicon.?semY1.contrast.?cY1 & ?cY1 == ?semY2 ) | ( lexicon.?semY2.contrast.?cY2 & ?cY2 == ?semY1 ) )

// the verbs both have the same verbal tense
( c:?X1l { c:tense = ?tt1 } & c:?X2l { c:tense = ?tt2 } & ?tt1 == ?tt2 )

// Limit the weight of the sentences to be aggregated; only first one needs limiting?
?X1l.straight_weight < 15
//?X2l.straight_weight < 15

// The objects are not coreferring (see SameRootObj)
¬( c:?Y2l { c:<-> c:?Y1l {} } | ( c:?Y1l { c:<-> c:?Y0l {} } & c:?Y2l { c:<-> c:?Y0l {} } ) )

// The two bubbles don't have one node that mentions the same entity (see same RootOnly)
¬( c:?S1l { c:?NE1l {} } & c:?S2l { c:?NE2l {} } & ( c:?NE2l { c:<-> c:?NE1l {} } | ( c:?NE1l { c:<-> c:?OriNEl {} } & c:?NE2l { c:<-> c:?OriNEl {} } ) ) )

// if one of the candidates has a specific status (e.g. meaning=locative_relation or temporal_relation), only apply if the other one has the same status.
//( ( ¬?Z1l.meaning == ?mZ1 & ¬?Z2l.meaning == ?mZ2 ) | ?Z1l.meaning == ?Z2l.meaning )

//Both Xs are roots.  Only second needs to be root for now, test this.
//¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// There isn't a pronoun with external antecedent in the sentence to be moved (unless a mention to the same NE is already in the host sentence and there is no other coref with another sentence).
//( ¬ ( c:?S2l { c:?Pro11no { ( c:slex = "_PRO_" | c:pronominalized = yes ) } } )
//  | ( c:?S2l { c:?Pro11 { ( c:slex = "_PRO_" | c:pronominalized = yes ) c:<-> c:?Ante11 {} } }
//    & ( c:?S2l { c:?Ante11 {} } | c:?S1l { c:?Ante11 {} } | ( c:?S11l { c:?Ante11 {} } & c:?S1l { c:?Prob11 { c:<-> c:?Ante11 {} } } ) )
    //& ¬( c:?S2l { c:?Pro12 { ( c:slex = "_PRO_" | c:pronominalized = "yes" ) c:<-> c:?Ante12 {} } } & c:?S12l { c:?Ante12 {} } & ¬?S12l.id == ?S1l.id )
//  )
//)
  
// This rules applies only once in case several sentences S2 can be merged (add support for multiple S2 at some point)
¬ ( c:?Tl { c:?S1l { c:*~ c:?S4l { c:id = ?id4 c:?X4l { c:lex = ?semX4 c:?r4-> c:?Y4l { c:lex = ?semY4 }  c:?s4-> c:?Z4l { c:pos = ?posZ4 } ¬c:?OD4-> c:?OtherDep4 {} } } } }
    & ¬( c:?Y4l { c:<-> c:?Y1l {} } | ( c:?Y4l { c:<-> c:?Y004l {} } & c:?Y1l { c:<-> c:?Y004l {} } ) )
    & ¬( c:?S1l { c:?NE01bl {} } & c:?S4l { c:?NE04l {} } & ( c:?NE04l { c:<-> c:?NE01bl {} } | ( c:?NE01bl { c:<-> c:?OriNE04l {} } & c:?NE04l { c:<-> c:?OriNE04l {} } ) ) )
    & ( ( lexicon.?semY4.contrast.?cY4 & ?cY4 == ?semY1 ) | ( lexicon.?semY1.contrast.?cY1 & ?cY1 == ?semY4 ) )
    & ?r4 ==?r1 & ?s4 == ?s1 & ?semX4 == ?semX1
    //& ( ( ¬?Z3l.meaning == ?mZ3 & ¬?Z2l.meaning == ?mZ2bis ) | ?Z3l.meaning == ?Z2l.meaning )
    & c:?S2l { c:id = ?id2 } & ?id4 < ?id2
    & ¬c:?Gov4l { c:?r4b-> c:?X4l {} }
    & ( c:?X4l { c:tense = ?tt4b} & ?tt4b == ?tt1 )
)
  
// This rule doesn't apply if S2 can be merged with another S after it
¬ ( c:?Tl { c:?S2l { c:*~ c:?S5l { c:id = ?id5 c:?X5l { c:lex = ?semX5 c:?r5-> c:?Y5l { c:lex = ?semY5 }  c:?s5-> c:?Z5l { c:pos = ?posZ5 } ¬c:?OD5-> c:?OtherDep5 {} } } } }
    & ¬( c:?Y5l { c:<-> c:?Y2l {} } | ( c:?Y2l { c:<-> c:?Y005l {} } & c:?Y2l { c:<-> c:?Y005l {} } ) )
    & ¬( c:?S2l { c:?NE02bl {} } & c:?S5l { c:?NE05l {} } & ( c:?NE05l { c:<-> c:?NE02bl {} } | ( c:?NE02bl { c:<-> c:?OriNE05l {} } & c:?NE05l { c:<-> c:?OriNE05l {} } ) ) )
    & ( ( lexicon.?semY5.contrast.?cY5 & ?cY5 == ?semY2 ) | ( lexicon.?semY2.contrast.?cY2b & ?cY2b == ?semY5 ) )
    & ?r5 ==?r2 & ?s5 == ?s2 & ?semX5 == ?semX2
    //& ( ( ¬?Z3l.meaning == ?mZ3 & ¬?Z2l.meaning == ?mZ2bis ) | ?Z3l.meaning == ?Z2l.meaning )
    //& c:?S2l { c:id = ?id2 } & ?id4 < ?id2
    & ¬c:?Gov5l { c:?r5b-> c:?X5l {} }
    & ( c:?X5l { c:tense = ?tt5b} & ?tt5b == ?tt2 )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  rc:blocked_potential = "yes"
  blocked = "yes"
  applied_agg = "noMergeCoordContrastLex"
  rc:noMergeCoordContrastLex-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X1r {
  rc:<=> ?X1l
  attach_coord = "yes"
  conjunction_type = "contrast"
}

¬rc:?S3r { rc:noMergeCoordContrastLex-> rc:?S2r {}
                ¬rc:mergeRootSubjCoord-> rc:?S31r {}
                ¬rc:mergeRootSubj-> rc:?S32r {}
                ¬rc:mergeRootObjCoord-> rc:?S33r {}
                ¬rc:noMergeCoordSameSubj-> rc:?S34r {}
                ¬rc:noMergeCoordSimSubj-> rc:?S35r {}
                ¬rc:noMergeCoordSameRoot-> rc:?S36r {} }
¬rc:?S4r { rc:mergeRootSubjCoord-> rc:?S2r {} }
¬rc:?S2r { rc:mergeRootSubjCoord-> rc:?S5r {} }
//¬rc:?S6r { rc:mergeRootSubjCoord-> rc:?S1r { rc:<=> ?S1l } }
//¬rc:?S7r { rc:<=> ?S1l rc:mergeRootSubjCoord-> rc:?S8r {} }
¬rc:?S9r { rc:mergeRootSubj-> rc:?S2r {} }
¬rc:?S2r { rc:mergeRootSubj-> rc:?S10r {} }
//¬rc:?S11r { rc:mergeRootSubj-> rc:?S12r { rc:<=> ?S1l } }
//¬rc:?S13r { rc:<=> ?S1l rc:mergeRootSubj-> rc:?S14r {} }
¬rc:?S15r { rc:mergeRootObjCoord-> rc:?S2r {} }
¬rc:?S2r { rc:mergeRootObjCoord-> rc:?S16r {} }
//¬rc:?S17r { rc:mergeRootObjCoord-> rc:?S18r { rc:<=> ?S1l } }
//¬rc:?S19r { rc:<=> ?S1l rc:mergeRootObjCoord-> rc:?S20r {} }
¬rc:?S21r { rc:noMergeCoordSameSubj-> rc:?S2r {} }
¬rc:?S2r { rc:noMergeCoordSameSubj-> rc:?S22r {} }
//¬rc:?S23r { rc:noMergeCoordSameSubj-> rc:?S24r { rc:<=> ?S1l } }
//¬rc:?S25r { rc:<=> ?S1l rc:noMergeCoordSameSubj-> rc:?S26r {} }
¬rc:?S27r { rc:noMergeCoordSimSubj-> rc:?S2r {} }
¬rc:?S2r { rc:noMergeCoordSimSubj-> rc:?S28r {} }
//¬rc:?S29r { rc:noMergeCoordSimSubj-> rc:?S30r { rc:<=> ?S1l } }
//¬rc:?S31r { rc:<=> ?S1l rc:noMergeCoordSimSubj-> rc:?S32r {} }
¬rc:?S33r { rc:noMergeCoordSameRoot-> rc:?S2r {} }
¬rc:?S2r { rc:noMergeCoordSameRoot-> rc:?S34r {} }
//¬rc:?S35r { rc:noMergeCoordSameRoot-> rc:?S36r { rc:<=> ?S1l } }
//¬rc:?S37r { rc:<=> ?S1l rc:noMergeCoordSameRoot-> rc:?S38r {} }
  ]
]

/*Adds an anchor for coord to the second and more conjuncts*/
SSynt<=>SSynt add_attach_coord_sameSubj
[
  leftside = [
c:?Tl {
  c:?S1l {
    // c:?X1l {}
    c:*~ c:?S2l {
      c:?X2l {}
      c:*~ c:?S3l {
        c:?X3l {}
      }
    }
  }
}

//Both Xs are roots. Not sure that's how it should be but safer and easier for now
//¬c:?Gov91l { c:?s91-> c:?X1l {} }
¬c:?Gov92l { c:?s92-> c:?X2l {} }
¬c:?Gov93l { c:?s93-> c:?X3l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  rc:blocked = "yes"
  rc:applied_agg = ?aaS1
  rc:?R1-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?S3r {
  rc:<=> ?S3l
  rc:blocked = "yes"
  rc:applied_agg = ?aaS3
  rc:?R2-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X2r {
  rc:<=> ?X2l
  ¬rc:blocked = "yes"
  ¬rc:attach_coord = "yes"
  attach_coord = "yes"
  conjunction_type = "coordination"
}

?R1 == ?R2
?aaS1 == ?aaS3
  ]
]

/*Adds an anchor for coord to the second and more conjuncts*/
SSynt<=>SSynt add_attach_coord_sameRootSubj
[
  leftside = [
c:?Tl {
  c:?S1l {
    // c:?X1l {}
    c:*~ c:?S2l {
      c:?Z2l {}
      c:*~ c:?S3l {}
    }
  }
}

  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  rc:blocked = "yes"
  rc:applied_agg = "mergeRootSubjCoord"
  rc:mergeRootSubjCoord-> rc:?S1r {
    rc:<=> ?S1l
    rc:?Z1r{
      rc:conjunction_type = ?ct
    }
  }
}

rc:?S3r {
  rc:<=> ?S3l
  rc:blocked = "yes"
  rc:applied_agg = "mergeRootSubjCoord"
  rc:mergeRootSubjCoord-> rc:?S1r {
    rc:<=> ?S1l
  }
}


rc:?Z2r {
  rc:<=> ?Z2l
  rc:mergeRootSubjCoord = "anchor"
  ¬rc:attach_coord = "yes"
  attach_coord = "yes"
  conjunction_type = ?ct
}
  ]
]

/*Aggregates "there is" constructions when adverbials are coreferring but not both prepositional.
Test rule to have AND vs BUT.*/
SSynt<=>SSynt EN_mark_SameRootObjLoc_sameSubjRel_AND
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:lex = "be_VB_01"
      c:SBJ-> c:?There1 {
        c:slex = "there"
      }
      c:PRD-> c:?Z1l {
        c:pos = ?posZ1
}
      c:ADV-> c:?IN1l {
        c:pos = "IN"
        c:slex = ?slexIN1
        c:PMOD-> c:?Y1l {}
      }
      // there is not other dependent
      ¬c:?OD1-> c:?OtherDep1 {}
    }
    c:*~ c:?S2l {
      c:?X2l {
        c:lex = "be_VB_01"
        c:SBJ-> c:?There2 {
          c:slex = "there"
        }
        c:PRD-> c:?Z2l {
          c:pos = ?posZ2
        }
        c:ADV-> c:?Y2l {}
        // there is not other dependent
        ¬c:?OD2-> c:?OtherDep2 {}
      }
    }
  }
}

( c:?Y2l { c:<-> c:?Y1l {} } | ( c:?Y1l { c:<-> c:?Y0l {} } & c:?Y2l { c:<-> c:?Y0l {} } ) )

// both Z have the same PoS (this could be relaxed a bit)
?posZ1 == ?posZ2
// both Z are instanciated variables (to prevent possible excessive applications of this rule; if Zs are variables, they are more likely to be "light" and aggregable (I guess)).
// Should replace with actual weight checking when possible.
( c:?Z1l { c:variable_class = ?vc1 } & c:?Z2l { c:variable_class = ?vc2 } )

// if one of the candidates has a specific status (e.g. meaning=locative_relation or temporal_relation), only apply if the other one has the same status.
( ( ¬?Z1l.meaning == ?mZ1 & ¬?Z2l.meaning == ?mZ2 ) | ?Z1l.meaning == ?Z2l.meaning )

// should also check on possible conjuncts below the Zs
( ( c:?Z1l { ¬c:NMOD-> c:?No1 { c:slex = "no" } } & c:?Z2l { ¬c:NMOD-> c:?No2 { c:slex = "no" } } )
  | ( c:?Z1l { c:NMOD-> c:?No3 { c:slex = "no" } } & c:?Z2l { c:NMOD-> c:?No4 { c:slex = "no" } } ) )

//Both Xs are roots.  Only second needs to be root for now, test this.
//¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// There isn't a dependent on one of the arguments that is not on the dependent of the second sentence (to be improved)
// SHOULDN'T THIS CONDITION BE REPEATED ON THE COMPLEX CONDITIONS BELOW?
¬ ( c:?Y1l { c:?r4-> c:?Dep4l { c:lex= ?semD4 } } & c:?Y2l { c:?r5-> c:?Dep5l { c:lex= ?semD5 } } & ( ¬?semD4 == ?semD5 | ¬?r4 == ?r5 ) )

// the verbs both have the same verbal tense
( c:?X1l { c:tense = ?tt1 } & c:?X2l { c:tense = ?tt2 } & ?tt1 == ?tt2 )
  ]
  mixed = [
//¬ ( c:?Tl { c:?S11l { c:*~ c:?S1l {} c:?X11l { c:lex = ?semX11 c:?r11-> c:?Y11l {}  c:?s11-> c:?Z11l { c:pos = ?posZ11 } ¬c:?OtherDep11 {} } } }
//    & ?r11 ==?r1 & ?s11 == ?s1 & ?semX11 == ?semX1 & c:?Z1l { c:pos = ?posZ1 } & ?posZ11 == ?posZ1
//    & ( c:?Y1l { c:<-> c:?Y11l {} } | ( c:?Y1l { c:<-> c:?Y101l {} } & c:?Y11l { c:<-> c:?Y101l {} } ) )
//    & lexicon.dependencies_default_map.I.rel.?r11 & lexicon.dependencies_default_map.II.rel.?s11
//    & ( ( ¬?Z11l.meaning == ?mZ11 & ¬?Z1l.meaning == ?mZ1 ) | ?Z11l.meaning == ?Z1l.meaning )
//    & ( c:?X11l { c:tense = ?tt11 } & c:?X1l { c:tense = ?tt11b } & ?tt11 == ?tt11b )
//)
  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked_potential = "yes"
  mergeRootSubjCoordAndLoc-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X2r {
  rc:<=> ?X2l
  blocked_potential = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  blocked_potential = "yes"
}

rc:?There2r {
  rc:<=> ?There2
  blocked_potential = "yes"
}
  ]
]

/*Aggregates "there is" constructions when adverbials are coreferring but not both prepositional.
Test rule to have AND vs BUT.*/
SSynt<=>SSynt EN_merge_SameRootObjLoc_sameSubjRel_AND
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:lex = "be_VB_01"
      c:SBJ-> c:?There1 {
        c:slex = "there"
      }
      c:PRD-> c:?Z1l {
        c:pos = ?posZ1
}
      c:ADV-> c:?IN1l {
        c:pos = "IN"
        c:slex = ?slexIN1
        c:PMOD-> c:?Y1l {}
      }
      // there is not other dependent
      ¬c:?OD1-> c:?OtherDep1 {}
    }
    c:*~ c:?S2l {
      c:?X2l {
        c:lex = "be_VB_01"
        c:SBJ-> c:?There2 {
          c:slex = "there"
        }
        c:PRD-> c:?Z2l {
          c:pos = ?posZ2
        }
        c:ADV-> c:?Y2l {}
        // there is not other dependent
        ¬c:?OD2-> c:?OtherDep2 {}
      }
    }
  }
}

( c:?Y2l { c:<-> c:?Y1l {} } | ( c:?Y1l { c:<-> c:?Y0l {} } & c:?Y2l { c:<-> c:?Y0l {} } ) )

// both Z have the same PoS (this could be relaxed a bit)
?posZ1 == ?posZ2
// both Z are instanciated variables (to prevent possible excessive applications of this rule; if Zs are variables, they are more likely to be "light" and aggregable (I guess)).
// Should replace with actual weight checking when possible.
( c:?Z1l { c:variable_class = ?vc1 } & c:?Z2l { c:variable_class = ?vc2 } )

// if one of the candidates has a specific status (e.g. meaning=locative_relation or temporal_relation), only apply if the other one has the same status.
( ( ¬?Z1l.meaning == ?mZ1 & ¬?Z2l.meaning == ?mZ2 ) | ?Z1l.meaning == ?Z2l.meaning )

// should also check on possible conjuncts below the Zs
( ( c:?Z1l { ¬c:NMOD-> c:?No1 { c:slex = "no" } } & c:?Z2l { ¬c:NMOD-> c:?No2 { c:slex = "no" } } )
  | ( c:?Z1l { c:NMOD-> c:?No3 { c:slex = "no" } } & c:?Z2l { c:NMOD-> c:?No4 { c:slex = "no" } } ) )

//Both Xs are roots.  Only second needs to be root for now, test this.
//¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// There isn't a dependent on one of the arguments that is not on the dependent of the second sentence (to be improved)
// SHOULDN'T THIS CONDITION BE REPEATED ON THE COMPLEX CONDITIONS BELOW?
¬ ( c:?Y1l { c:?r4-> c:?Dep4l { c:lex= ?semD4 } } & c:?Y2l { c:?r5-> c:?Dep5l { c:lex= ?semD5 } } & ( ¬?semD4 == ?semD5 | ¬?r4 == ?r5 ) )

// the verbs both have the same verbal tense
( c:?X1l { c:tense = ?tt1 } & c:?X2l { c:tense = ?tt2 } & ?tt1 == ?tt2 )
  ]
  mixed = [
//¬ ( c:?Tl { c:?S11l { c:*~ c:?S1l {} c:?X11l { c:lex = ?semX11 c:?r11-> c:?Y11l {}  c:?s11-> c:?Z11l { c:pos = ?posZ11 } ¬c:?OtherDep11 {} } } }
//    & ?r11 ==?r1 & ?s11 == ?s1 & ?semX11 == ?semX1 & c:?Z1l { c:pos = ?posZ1 } & ?posZ11 == ?posZ1
//    & ( c:?Y1l { c:<-> c:?Y11l {} } | ( c:?Y1l { c:<-> c:?Y101l {} } & c:?Y11l { c:<-> c:?Y101l {} } ) )
//    & lexicon.dependencies_default_map.I.rel.?r11 & lexicon.dependencies_default_map.II.rel.?s11
//    & ( ( ¬?Z11l.meaning == ?mZ11 & ¬?Z1l.meaning == ?mZ1 ) | ?Z11l.meaning == ?Z1l.meaning )
//    & ( c:?X11l { c:tense = ?tt11 } & c:?X1l { c:tense = ?tt11b } & ?tt11 == ?tt11b )
//)
  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  rc:blocked_potential = "yes"
  blocked = "yes"
  applied_agg = "mergeRootSubjCoordAndLoc"
  rc:mergeRootSubjCoordAndLoc-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X2r {
  rc:<=> ?X2l
  rc:blocked_potential = "yes"
  blocked = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  rc:blocked_potential = "yes"
  blocked = "yes"
}

rc:?There2r {
  rc:<=> ?There2
  rc:blocked_potential = "yes"
  blocked = "yes"
}

rc:?Z1r {
  rc:<=> ?Z1l
  attach_coord = "yes"
  conjunction_type = "coordination"
}

¬rc:?S4r { rc:?r1-> rc:?S2r {} }
¬rc:?S2r { rc:?r2-> rc:?S5r {} }
¬ ( rc:?S6r { rc:?r3-> rc:?S1r {} } & ¬ ?S6r.id == ?S2r.id )
¬rc:?S1r { rc:?r4-> rc:?S8r {} }
  ]
]

/*Aggregates "there is" constructions when adverbials are coreferring but not both prepositional.
Test rule to have AND vs BUT.*/
SSynt<=>SSynt EN_mark_SameRootObjLoc_sameSubjRel_BUT
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:lex = "be_VB_01"
      c:SBJ-> c:?There1 {
        c:slex = "there"
      }
      c:PRD-> c:?Z1l {
        c:pos = ?posZ1
}
      c:ADV-> c:?IN1l {
        c:pos = "IN"
        c:slex = ?slexIN1
        c:PMOD-> c:?Y1l {}
      }
      // there is not other dependent
      ¬c:?OD1-> c:?OtherDep1 {}
    }
    c:*~ c:?S2l {
      c:?X2l {
        c:lex = "be_VB_01"
        c:SBJ-> c:?There2 {
          c:slex = "there"
        }
        c:PRD-> c:?Z2l {
          c:pos = ?posZ2
        }
        c:ADV-> c:?Y2l {}
        // there is not other dependent
        ¬c:?OD2-> c:?OtherDep2 {}
      }
    }
  }
}

( c:?Y2l { c:<-> c:?Y1l {} } | ( c:?Y1l { c:<-> c:?Y0l {} } & c:?Y2l { c:<-> c:?Y0l {} } ) )

// both Z have the same PoS (this could be relaxed a bit)
?posZ1 == ?posZ2
// both Z are instanciated variables (to prevent possible excessive applications of this rule; if Zs are variables, they are more likely to be "light" and aggregable (I guess)).
// Should replace with actual weight checking when possible.
( c:?Z1l { c:variable_class = ?vc1 } & c:?Z2l { c:variable_class = ?vc2 } )

// if one of the candidates has a specific status (e.g. meaning=locative_relation or temporal_relation), only apply if the other one has the same status.
( ( ¬?Z1l.meaning == ?mZ1 & ¬?Z2l.meaning == ?mZ2 ) | ?Z1l.meaning == ?Z2l.meaning )

// should also check on possible conjuncts below the Zs
( ( c:?Z1l { ¬c:NMOD-> c:?No1 { c:slex = "no" } } & c:?Z2l { c:NMOD-> c:?No2 { c:slex = "no" } } )
  | ( c:?Z1l { c:NMOD-> c:?No3 { c:slex = "no" } } & c:?Z2l { ¬c:NMOD-> c:?No4 { c:slex = "no" } } ) )

//Both Xs are roots.  Only second needs to be root for now, test this.
//¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// There isn't a dependent on one of the arguments that is not on the dependent of the second sentence (to be improved)
// SHOULDN'T THIS CONDITION BE REPEATED ON THE COMPLEX CONDITIONS BELOW?
¬ ( c:?Y1l { c:?r4-> c:?Dep4l { c:lex= ?semD4 } } & c:?Y2l { c:?r5-> c:?Dep5l { c:lex= ?semD5 } } & ( ¬?semD4 == ?semD5 | ¬?r4 == ?r5 ) )

// the verbs both have the same verbal tense
( c:?X1l { c:tense = ?tt1 } & c:?X2l { c:tense = ?tt2 } & ?tt1 == ?tt2 )
  ]
  mixed = [
//¬ ( c:?Tl { c:?S11l { c:*~ c:?S1l {} c:?X11l { c:lex = ?semX11 c:?r11-> c:?Y11l {}  c:?s11-> c:?Z11l { c:pos = ?posZ11 } ¬c:?OtherDep11 {} } } }
//    & ?r11 ==?r1 & ?s11 == ?s1 & ?semX11 == ?semX1 & c:?Z1l { c:pos = ?posZ1 } & ?posZ11 == ?posZ1
//    & ( c:?Y1l { c:<-> c:?Y11l {} } | ( c:?Y1l { c:<-> c:?Y101l {} } & c:?Y11l { c:<-> c:?Y101l {} } ) )
//    & lexicon.dependencies_default_map.I.rel.?r11 & lexicon.dependencies_default_map.II.rel.?s11
//    & ( ( ¬?Z11l.meaning == ?mZ11 & ¬?Z1l.meaning == ?mZ1 ) | ?Z11l.meaning == ?Z1l.meaning )
//    & ( c:?X11l { c:tense = ?tt11 } & c:?X1l { c:tense = ?tt11b } & ?tt11 == ?tt11b )
//)
  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked_potential = "yes"
  mergeRootSubjCoordContrastLoc-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X2r {
  rc:<=> ?X2l
  blocked_potential = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  blocked_potential = "yes"
}

rc:?There2r {
  rc:<=> ?There2
  blocked_potential = "yes"
}
  ]
]

/*Aggregates "there is" constructions when adverbials are coreferring but not both prepositional.
Test rule to have AND vs BUT.*/
SSynt<=>SSynt EN_merge_SameRootObjLoc_sameSubjRel_BUT
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:lex = "be_VB_01"
      c:SBJ-> c:?There1 {
        c:slex = "there"
      }
      c:PRD-> c:?Z1l {
        c:pos = ?posZ1
}
      c:ADV-> c:?IN1l {
        c:pos = "IN"
        c:slex = ?slexIN1
        c:PMOD-> c:?Y1l {}
      }
      // there is not other dependent
      ¬c:?OD1-> c:?OtherDep1 {}
    }
    c:*~ c:?S2l {
      c:?X2l {
        c:lex = "be_VB_01"
        c:SBJ-> c:?There2 {
          c:slex = "there"
        }
        c:PRD-> c:?Z2l {
          c:pos = ?posZ2
        }
        c:ADV-> c:?Y2l {}
        // there is not other dependent
        ¬c:?OD2-> c:?OtherDep2 {}
      }
    }
  }
}

( c:?Y2l { c:<-> c:?Y1l {} } | ( c:?Y1l { c:<-> c:?Y0l {} } & c:?Y2l { c:<-> c:?Y0l {} } ) )

// both Z have the same PoS (this could be relaxed a bit)
?posZ1 == ?posZ2
// both Z are instanciated variables (to prevent possible excessive applications of this rule; if Zs are variables, they are more likely to be "light" and aggregable (I guess)).
// Should replace with actual weight checking when possible.
( c:?Z1l { c:variable_class = ?vc1 } & c:?Z2l { c:variable_class = ?vc2 } )

// if one of the candidates has a specific status (e.g. meaning=locative_relation or temporal_relation), only apply if the other one has the same status.
( ( ¬?Z1l.meaning == ?mZ1 & ¬?Z2l.meaning == ?mZ2 ) | ?Z1l.meaning == ?Z2l.meaning )

// should also check on possible conjuncts below the Zs
( ( c:?Z1l { ¬c:NMOD-> c:?No1 { c:slex = "no" } } & c:?Z2l { c:NMOD-> c:?No2 { c:slex = "no" } } )
  | ( c:?Z1l { c:NMOD-> c:?No3 { c:slex = "no" } } & c:?Z2l { ¬c:NMOD-> c:?No4 { c:slex = "no" } } ) )

//Both Xs are roots.  Only second needs to be root for now, test this.
//¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// There isn't a dependent on one of the arguments that is not on the dependent of the second sentence (to be improved)
// SHOULDN'T THIS CONDITION BE REPEATED ON THE COMPLEX CONDITIONS BELOW?
¬ ( c:?Y1l { c:?r4-> c:?Dep4l { c:lex= ?semD4 } } & c:?Y2l { c:?r5-> c:?Dep5l { c:lex= ?semD5 } } & ( ¬?semD4 == ?semD5 | ¬?r4 == ?r5 ) )

// the verbs both have the same verbal tense
( c:?X1l { c:tense = ?tt1 } & c:?X2l { c:tense = ?tt2 } & ?tt1 == ?tt2 )
  ]
  mixed = [
//¬ ( c:?Tl { c:?S11l { c:*~ c:?S1l {} c:?X11l { c:lex = ?semX11 c:?r11-> c:?Y11l {}  c:?s11-> c:?Z11l { c:pos = ?posZ11 } ¬c:?OtherDep11 {} } } }
//    & ?r11 ==?r1 & ?s11 == ?s1 & ?semX11 == ?semX1 & c:?Z1l { c:pos = ?posZ1 } & ?posZ11 == ?posZ1
//    & ( c:?Y1l { c:<-> c:?Y11l {} } | ( c:?Y1l { c:<-> c:?Y101l {} } & c:?Y11l { c:<-> c:?Y101l {} } ) )
//    & lexicon.dependencies_default_map.I.rel.?r11 & lexicon.dependencies_default_map.II.rel.?s11
//    & ( ( ¬?Z11l.meaning == ?mZ11 & ¬?Z1l.meaning == ?mZ1 ) | ?Z11l.meaning == ?Z1l.meaning )
//    & ( c:?X11l { c:tense = ?tt11 } & c:?X1l { c:tense = ?tt11b } & ?tt11 == ?tt11b )
//)
  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  rc:blocked_potential = "yes"
  blocked = "yes"
  applied_agg = "mergeRootSubjCoordContrastLoc"
  rc:mergeRootSubjCoordContrastLoc-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X2r {
  rc:<=> ?X2l
  rc:blocked_potential = "yes"
  blocked = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  rc:blocked_potential = "yes"
  blocked = "yes"
}

rc:?There2r {
  rc:<=> ?There2
  rc:blocked_potential = "yes"
  blocked = "yes"
}

rc:?Z1r {
  rc:<=> ?Z1l
  attach_coord = "yes"
  conjunction_type = "contrast2"
}

¬rc:?S4r { rc:?r1-> rc:?S2r {} }
¬rc:?S2r { rc:?r2-> rc:?S5r {} }
¬ ( rc:?S6r { rc:?r3-> rc:?S1r {} } & ¬ ?S6r.id == ?S2r.id )
¬rc:?S1r { rc:?r4-> rc:?S8r {} }
  ]
]

/*Aggregates "there is" constructions when adverbials are the same prepositional group.

Lots of conditions missing to restrict the application of this rule in case other rules can apply.*/
SSynt<=>SSynt EN_mark_SameRootObjLoc_IN_sameSubjRel_AND
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:lex = "be_VB_01"
      c:SBJ-> c:?There1 {
        c:slex = "there"
      }
      c:PRD-> c:?Z1l {
        c:pos = ?posZ1
}
      c:ADV-> c:?IN1l {
        c:pos = "IN"
        c:slex = ?slexIN1
        c:PMOD-> c:?Y1l {}
      }
      // there is not other dependent
      ¬c:?OD1-> c:?OtherDep1 {}
    }
    c:*~ c:?S2l {
      c:?X2l {
        c:lex = "be_VB_01"
        c:SBJ-> c:?There2 {
          c:slex = "there"
        }
        c:PRD-> c:?Z2l {
          c:pos = ?posZ2
        }
        c:ADV-> c:?IN2l {
          c:pos = "IN"
          c:slex = ?slexIN2
          c:PMOD-> c:?Y2l {}
        }
        // there is not other dependent
        ¬c:?OD2-> c:?OtherDep2 {}
      }
    }
  }
}

// the prepositions are the same
?slexIN1 == ?slexIN2
( c:?Y2l { c:<-> c:?Y1l {} } | ( c:?Y1l { c:<-> c:?Y0l {} } & c:?Y2l { c:<-> c:?Y0l {} } ) )

// both Z have the same PoS (this could be relaxed a bit)
?posZ1 == ?posZ2

// if one of the candidates has a specific status (e.g. meaning=locative_relation or temporal_relation), only apply if the other one has the same status.
( ( ¬?Z1l.meaning == ?mZ1 & ¬?Z2l.meaning == ?mZ2 ) | ?Z1l.meaning == ?Z2l.meaning )

// should also check on possible conjuncts below the Zs
( ( c:?Z1l { ¬c:NMOD-> c:?No1 { c:slex = "no" } } & c:?Z2l { ¬c:NMOD-> c:?No2 { c:slex = "no" } } )
  | ( c:?Z1l { c:NMOD-> c:?No3 { c:slex = "no" } } & c:?Z2l { c:NMOD-> c:?No4 { c:slex = "no" } } ) )

//Both Xs are roots.  Only second needs to be root for now, test this.
//¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// There isn't a dependent on one of the arguments that is not on the dependent of the second sentence (to be improved)
// SHOULDN'T THIS CONDITION BE REPEATED ON THE COMPLEX CONDITIONS BELOW?
¬ ( c:?Y1l { c:?r4-> c:?Dep4l { c:lex= ?semD4 } } & c:?Y2l { c:?r5-> c:?Dep5l { c:lex= ?semD5 } } & ( ¬?semD4 == ?semD5 | ¬?r4 == ?r5 ) )

// the verbs both have the same verbal tense
( c:?X1l { c:tense = ?tt1 } & c:?X2l { c:tense = ?tt2 } & ?tt1 == ?tt2 )

// there isn't another SameRootObjLoc rule that can apply.
¬ ( c:?Tl { c:?S1l { c:?X1l { c:lex = "be_VB_01" c:SBJ-> c:?There1 { c:slex = "there" } c:PRD-> c:?Z1l { c:pos = ?posZ1 } c:ADV-> c:?IN1l { c:pos = "IN" c:slex = ?slexIN1 c:PMOD-> c:?Y1l {} }¬c:?OD1-> c:?OtherDep1 {} }
         c:*~ c:?S3l { c:?X3l { c:lex = "be_VB_01" c:SBJ-> c:?There3 { c:slex = "there" } c:PRD-> c:?Z3l { c:pos = ?posZ3 } c:ADV-> c:?Y3l {} ¬c:?OD3-> c:?OtherDep3 {} } } } }
 & ( c:?Y3l { c:<-> c:?Y1l {} } | ( c:?Y1l { c:<-> c:?Y03l {} } & c:?Y3l { c:<-> c:?Y03l {} } ) )
)
  ]
  mixed = [
//¬ ( c:?Tl { c:?S11l { c:*~ c:?S1l {} c:?X11l { c:lex = ?semX11 c:?r11-> c:?Y11l {}  c:?s11-> c:?Z11l { c:pos = ?posZ11 } ¬c:?OtherDep11 {} } } }
//    & ?r11 ==?r1 & ?s11 == ?s1 & ?semX11 == ?semX1 & c:?Z1l { c:pos = ?posZ1 } & ?posZ11 == ?posZ1
//    & ( c:?Y1l { c:<-> c:?Y11l {} } | ( c:?Y1l { c:<-> c:?Y101l {} } & c:?Y11l { c:<-> c:?Y101l {} } ) )
//    & lexicon.dependencies_default_map.I.rel.?r11 & lexicon.dependencies_default_map.II.rel.?s11
//    & ( ( ¬?Z11l.meaning == ?mZ11 & ¬?Z1l.meaning == ?mZ1 ) | ?Z11l.meaning == ?Z1l.meaning )
//    & ( c:?X11l { c:tense = ?tt11 } & c:?X1l { c:tense = ?tt11b } & ?tt11 == ?tt11b )
//)
  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked_potential = "yes"
  mergeRootSubjCoordAndLocIn-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X2r {
  rc:<=> ?X2l
  blocked_potential = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  blocked_potential = "yes"
}

rc:?There2r {
  rc:<=> ?There2
  blocked_potential = "yes"
}

rc:?IN2r {
  rc:<=> ?IN2l
  blocked_potential = "yes"
}
  ]
]

/*Aggregates "there is" constructions when adverbials are the same prepositional group.

Lots of conditions missing to restrict the application of this rule in case other rules can apply.*/
SSynt<=>SSynt EN_merge_SameRootObjLoc_IN_sameSubjRel_AND
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:lex = "be_VB_01"
      c:SBJ-> c:?There1 {
        c:slex = "there"
      }
      c:PRD-> c:?Z1l {
        c:pos = ?posZ1
}
      c:ADV-> c:?IN1l {
        c:pos = "IN"
        c:slex = ?slexIN1
        c:PMOD-> c:?Y1l {}
      }
      // there is not other dependent
      ¬c:?OD1-> c:?OtherDep1 {}
    }
    c:*~ c:?S2l {
      c:?X2l {
        c:lex = "be_VB_01"
        c:SBJ-> c:?There2 {
          c:slex = "there"
        }
        c:PRD-> c:?Z2l {
          c:pos = ?posZ2
        }
        c:ADV-> c:?IN2l {
          c:pos = "IN"
          c:slex = ?slexIN2
          c:PMOD-> c:?Y2l {}
        }
        // there is not other dependent
        ¬c:?OD2-> c:?OtherDep2 {}
      }
    }
  }
}

// the prepositions are the same
?slexIN1 == ?slexIN2
( c:?Y2l { c:<-> c:?Y1l {} } | ( c:?Y1l { c:<-> c:?Y0l {} } & c:?Y2l { c:<-> c:?Y0l {} } ) )

// both Z have the same PoS (this could be relaxed a bit)
?posZ1 == ?posZ2

// if one of the candidates has a specific status (e.g. meaning=locative_relation or temporal_relation), only apply if the other one has the same status.
( ( ¬?Z1l.meaning == ?mZ1 & ¬?Z2l.meaning == ?mZ2 ) | ?Z1l.meaning == ?Z2l.meaning )

// should also check on possible conjuncts below the Zs
( ( c:?Z1l { ¬c:NMOD-> c:?No1 { c:slex = "no" } } & c:?Z2l { ¬c:NMOD-> c:?No2 { c:slex = "no" } } )
  | ( c:?Z1l { c:NMOD-> c:?No3 { c:slex = "no" } } & c:?Z2l { c:NMOD-> c:?No4 { c:slex = "no" } } ) )

//Both Xs are roots.  Only second needs to be root for now, test this.
//¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// There isn't a dependent on one of the arguments that is not on the dependent of the second sentence (to be improved)
// SHOULDN'T THIS CONDITION BE REPEATED ON THE COMPLEX CONDITIONS BELOW?
¬ ( c:?Y1l { c:?r4-> c:?Dep4l { c:lex= ?semD4 } } & c:?Y2l { c:?r5-> c:?Dep5l { c:lex= ?semD5 } } & ( ¬?semD4 == ?semD5 | ¬?r4 == ?r5 ) )

// the verbs both have the same verbal tense
( c:?X1l { c:tense = ?tt1 } & c:?X2l { c:tense = ?tt2 } & ?tt1 == ?tt2 )

// there isn't another SameRootObjLoc rule that can apply.
¬ ( c:?Tl { c:?S1l { c:?X1l { c:lex = "be_VB_01" c:SBJ-> c:?There1 { c:slex = "there" } c:PRD-> c:?Z1l { c:pos = ?posZ1 } c:ADV-> c:?IN1l { c:pos = "IN" c:slex = ?slexIN1 c:PMOD-> c:?Y1l {} }¬c:?OD1-> c:?OtherDep1 {} }
         c:*~ c:?S3l { c:?X3l { c:lex = "be_VB_01" c:SBJ-> c:?There3 { c:slex = "there" } c:PRD-> c:?Z3l { c:pos = ?posZ3 } c:ADV-> c:?Y3l {} ¬c:?OD3-> c:?OtherDep3 {} } } } }
 & ( c:?Y3l { c:<-> c:?Y1l {} } | ( c:?Y1l { c:<-> c:?Y03l {} } & c:?Y3l { c:<-> c:?Y03l {} } ) )
)
  ]
  mixed = [
//¬ ( c:?Tl { c:?S11l { c:*~ c:?S1l {} c:?X11l { c:lex = ?semX11 c:?r11-> c:?Y11l {}  c:?s11-> c:?Z11l { c:pos = ?posZ11 } ¬c:?OtherDep11 {} } } }
//    & ?r11 ==?r1 & ?s11 == ?s1 & ?semX11 == ?semX1 & c:?Z1l { c:pos = ?posZ1 } & ?posZ11 == ?posZ1
//    & ( c:?Y1l { c:<-> c:?Y11l {} } | ( c:?Y1l { c:<-> c:?Y101l {} } & c:?Y11l { c:<-> c:?Y101l {} } ) )
//    & lexicon.dependencies_default_map.I.rel.?r11 & lexicon.dependencies_default_map.II.rel.?s11
//    & ( ( ¬?Z11l.meaning == ?mZ11 & ¬?Z1l.meaning == ?mZ1 ) | ?Z11l.meaning == ?Z1l.meaning )
//    & ( c:?X11l { c:tense = ?tt11 } & c:?X1l { c:tense = ?tt11b } & ?tt11 == ?tt11b )
//)
  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  rc:blocked_potential = "yes"
  blocked = "yes"
  applied_agg = "mergeRootSubjCoordAndLocIn"
  rc:mergeRootSubjCoordAndLocIn-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X2r {
  rc:<=> ?X2l
  rc:blocked_potential = "yes"
  blocked = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  rc:blocked_potential = "yes"
  blocked = "yes"
}

rc:?There2r {
  rc:<=> ?There2
  rc:blocked_potential = "yes"
  blocked = "yes"
}

rc:?IN2r {
  rc:<=> ?IN2l
  rc:blocked_potential = "yes"
  blocked = "yes"
}

rc:?Z1r {
  rc:<=> ?Z1l
  attach_coord = "yes"
  conjunction_type = "coordination"
}

¬rc:?S4r { rc:?r1-> rc:?S2r {} }
¬ ( rc:?S2r { rc:?r2-> rc:?S5r {} } & ¬ ?S5r.id == ?S1r.id )
¬ ( rc:?S6r { rc:?r3-> rc:?S1r {} } & ¬ ?S6r.id == ?S2r.id )
¬rc:?S1r { rc:?r4-> rc:?S8r {} }
  ]
]

/*Aggregates "there is" constructions when adverbials are the same prepositional group.

Lots of conditions missing to restrict the application of this rule in case other rules can apply.*/
SSynt<=>SSynt EN_mark_SameRootObjLoc_IN_sameSubjRel_BUT
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:lex = "be_VB_01"
      c:SBJ-> c:?There1 {
        c:slex = "there"
      }
      c:PRD-> c:?Z1l {
        c:pos = ?posZ1
}
      c:ADV-> c:?IN1l {
        c:pos = "IN"
        c:slex = ?slexIN1
        c:PMOD-> c:?Y1l {}
      }
      // there is not other dependent
      ¬c:?OD1-> c:?OtherDep1 {}
    }
    c:*~ c:?S2l {
      c:?X2l {
        c:lex = "be_VB_01"
        c:SBJ-> c:?There2 {
          c:slex = "there"
        }
        c:PRD-> c:?Z2l {
          c:pos = ?posZ2
        }
        c:ADV-> c:?IN2l {
          c:pos = "IN"
          c:slex = ?slexIN2
          c:PMOD-> c:?Y2l {}
        }
        // there is not other dependent
        ¬c:?OD2-> c:?OtherDep2 {}
      }
    }
  }
}

// the prepositions are the same
?slexIN1 == ?slexIN2
( c:?Y2l { c:<-> c:?Y1l {} } | ( c:?Y1l { c:<-> c:?Y0l {} } & c:?Y2l { c:<-> c:?Y0l {} } ) )

// both Z have the same PoS (this could be relaxed a bit)
?posZ1 == ?posZ2

// if one of the candidates has a specific status (e.g. meaning=locative_relation or temporal_relation), only apply if the other one has the same status.
( ( ¬?Z1l.meaning == ?mZ1 & ¬?Z2l.meaning == ?mZ2 ) | ?Z1l.meaning == ?Z2l.meaning )

// should also check on possible conjuncts below the Zs
( ( c:?Z1l { ¬c:NMOD-> c:?No1 { c:slex = "no" } } & c:?Z2l { c:NMOD-> c:?No2 { c:slex = "no" } } )
  | ( c:?Z1l { c:NMOD-> c:?No3 { c:slex = "no" } } & c:?Z2l { ¬c:NMOD-> c:?No4 { c:slex = "no" } } ) )

//Both Xs are roots.  Only second needs to be root for now, test this.
//¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// There isn't a dependent on one of the arguments that is not on the dependent of the second sentence (to be improved)
// SHOULDN'T THIS CONDITION BE REPEATED ON THE COMPLEX CONDITIONS BELOW?
¬ ( c:?Y1l { c:?r4-> c:?Dep4l { c:lex= ?semD4 } } & c:?Y2l { c:?r5-> c:?Dep5l { c:lex= ?semD5 } } & ( ¬?semD4 == ?semD5 | ¬?r4 == ?r5 ) )

// the verbs both have the same verbal tense
( c:?X1l { c:tense = ?tt1 } & c:?X2l { c:tense = ?tt2 } & ?tt1 == ?tt2 )

// there isn't another SameRootObjLoc rule that can apply.
¬ ( c:?Tl { c:?S1l { c:?X1l { c:lex = "be_VB_01" c:SBJ-> c:?There1 { c:slex = "there" } c:PRD-> c:?Z1l { c:pos = ?posZ1 } c:ADV-> c:?IN1l { c:pos = "IN" c:slex = ?slexIN1 c:PMOD-> c:?Y1l {} }¬c:?OD1-> c:?OtherDep1 {} }
         c:*~ c:?S3l { c:?X3l { c:lex = "be_VB_01" c:SBJ-> c:?There3 { c:slex = "there" } c:PRD-> c:?Z3l { c:pos = ?posZ3 } c:ADV-> c:?Y3l {} ¬c:?OD3-> c:?OtherDep3 {} } } } }
 & ( c:?Y3l { c:<-> c:?Y1l {} } | ( c:?Y1l { c:<-> c:?Y03l {} } & c:?Y3l { c:<-> c:?Y03l {} } ) )
)
  ]
  mixed = [
//¬ ( c:?Tl { c:?S11l { c:*~ c:?S1l {} c:?X11l { c:lex = ?semX11 c:?r11-> c:?Y11l {}  c:?s11-> c:?Z11l { c:pos = ?posZ11 } ¬c:?OtherDep11 {} } } }
//    & ?r11 ==?r1 & ?s11 == ?s1 & ?semX11 == ?semX1 & c:?Z1l { c:pos = ?posZ1 } & ?posZ11 == ?posZ1
//    & ( c:?Y1l { c:<-> c:?Y11l {} } | ( c:?Y1l { c:<-> c:?Y101l {} } & c:?Y11l { c:<-> c:?Y101l {} } ) )
//    & lexicon.dependencies_default_map.I.rel.?r11 & lexicon.dependencies_default_map.II.rel.?s11
//    & ( ( ¬?Z11l.meaning == ?mZ11 & ¬?Z1l.meaning == ?mZ1 ) | ?Z11l.meaning == ?Z1l.meaning )
//    & ( c:?X11l { c:tense = ?tt11 } & c:?X1l { c:tense = ?tt11b } & ?tt11 == ?tt11b )
//)
  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked_potential = "yes"
  mergeRootSubjCoordContrastLocIn-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X2r {
  rc:<=> ?X2l
  blocked_potential = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  blocked_potential = "yes"
}

rc:?There2r {
  rc:<=> ?There2
  blocked_potential = "yes"
}

rc:?IN2r {
  rc:<=> ?IN2l
  blocked_potential = "yes"
}
  ]
]

/*Aggregates "there is" constructions when adverbials are the same prepositional group.

Lots of conditions missing to restrict the application of this rule in case other rules can apply.*/
SSynt<=>SSynt EN_merge_SameRootObjLoc_IN_sameSubjRel_BUT
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:lex = "be_VB_01"
      c:SBJ-> c:?There1 {
        c:slex = "there"
      }
      c:PRD-> c:?Z1l {
        c:pos = ?posZ1
}
      c:ADV-> c:?IN1l {
        c:pos = "IN"
        c:slex = ?slexIN1
        c:PMOD-> c:?Y1l {}
      }
      // there is not other dependent
      ¬c:?OD1-> c:?OtherDep1 {}
    }
    c:*~ c:?S2l {
      c:?X2l {
        c:lex = "be_VB_01"
        c:SBJ-> c:?There2 {
          c:slex = "there"
        }
        c:PRD-> c:?Z2l {
          c:pos = ?posZ2
        }
        c:ADV-> c:?IN2l {
          c:pos = "IN"
          c:slex = ?slexIN2
          c:PMOD-> c:?Y2l {}
        }
        // there is not other dependent
        ¬c:?OD2-> c:?OtherDep2 {}
      }
    }
  }
}

// the prepositions are the same
?slexIN1 == ?slexIN2
( c:?Y2l { c:<-> c:?Y1l {} } | ( c:?Y1l { c:<-> c:?Y0l {} } & c:?Y2l { c:<-> c:?Y0l {} } ) )

// both Z have the same PoS (this could be relaxed a bit)
?posZ1 == ?posZ2

// if one of the candidates has a specific status (e.g. meaning=locative_relation or temporal_relation), only apply if the other one has the same status.
( ( ¬?Z1l.meaning == ?mZ1 & ¬?Z2l.meaning == ?mZ2 ) | ?Z1l.meaning == ?Z2l.meaning )

// should also check on possible conjuncts below the Zs
( ( c:?Z1l { ¬c:NMOD-> c:?No1 { c:slex = "no" } } & c:?Z2l { c:NMOD-> c:?No2 { c:slex = "no" } } )
  | ( c:?Z1l { c:NMOD-> c:?No3 { c:slex = "no" } } & c:?Z2l { ¬c:NMOD-> c:?No4 { c:slex = "no" } } ) )

//Both Xs are roots.  Only second needs to be root for now, test this.
//¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// There isn't a dependent on one of the arguments that is not on the dependent of the second sentence (to be improved)
// SHOULDN'T THIS CONDITION BE REPEATED ON THE COMPLEX CONDITIONS BELOW?
¬ ( c:?Y1l { c:?r4-> c:?Dep4l { c:lex= ?semD4 } } & c:?Y2l { c:?r5-> c:?Dep5l { c:lex= ?semD5 } } & ( ¬?semD4 == ?semD5 | ¬?r4 == ?r5 ) )

// the verbs both have the same verbal tense
( c:?X1l { c:tense = ?tt1 } & c:?X2l { c:tense = ?tt2 } & ?tt1 == ?tt2 )

// there isn't another SameRootObjLoc rule that can apply.
¬ ( c:?Tl { c:?S1l { c:?X1l { c:lex = "be_VB_01" c:SBJ-> c:?There1 { c:slex = "there" } c:PRD-> c:?Z1l { c:pos = ?posZ1 } c:ADV-> c:?IN1l { c:pos = "IN" c:slex = ?slexIN1 c:PMOD-> c:?Y1l {} }¬c:?OD1-> c:?OtherDep1 {} }
         c:*~ c:?S3l { c:?X3l { c:lex = "be_VB_01" c:SBJ-> c:?There3 { c:slex = "there" } c:PRD-> c:?Z3l { c:pos = ?posZ3 } c:ADV-> c:?Y3l {} ¬c:?OD3-> c:?OtherDep3 {} } } } }
 & ( c:?Y3l { c:<-> c:?Y1l {} } | ( c:?Y1l { c:<-> c:?Y03l {} } & c:?Y3l { c:<-> c:?Y03l {} } ) )
)
  ]
  mixed = [
//¬ ( c:?Tl { c:?S11l { c:*~ c:?S1l {} c:?X11l { c:lex = ?semX11 c:?r11-> c:?Y11l {}  c:?s11-> c:?Z11l { c:pos = ?posZ11 } ¬c:?OtherDep11 {} } } }
//    & ?r11 ==?r1 & ?s11 == ?s1 & ?semX11 == ?semX1 & c:?Z1l { c:pos = ?posZ1 } & ?posZ11 == ?posZ1
//    & ( c:?Y1l { c:<-> c:?Y11l {} } | ( c:?Y1l { c:<-> c:?Y101l {} } & c:?Y11l { c:<-> c:?Y101l {} } ) )
//    & lexicon.dependencies_default_map.I.rel.?r11 & lexicon.dependencies_default_map.II.rel.?s11
//    & ( ( ¬?Z11l.meaning == ?mZ11 & ¬?Z1l.meaning == ?mZ1 ) | ?Z11l.meaning == ?Z1l.meaning )
//    & ( c:?X11l { c:tense = ?tt11 } & c:?X1l { c:tense = ?tt11b } & ?tt11 == ?tt11b )
//)
  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  rc:blocked_potential = "yes"
  blocked = "yes"
  applied_agg = "mergeRootSubjCoordContrastLocIn"
  rc:mergeRootSubjCoordContrastLocIn-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X2r {
  rc:<=> ?X2l
  rc:blocked_potential = "yes"
  blocked = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  rc:blocked_potential = "yes"
  blocked = "yes"
}

rc:?There2r {
  rc:<=> ?There2
  rc:blocked_potential = "yes"
  blocked = "yes"
}

rc:?IN2r {
  rc:<=> ?IN2l
  rc:blocked_potential = "yes"
  blocked = "yes"
}

rc:?Z1r {
  rc:<=> ?Z1l
  attach_coord = "yes"
  conjunction_type = "contrast2"
}

¬rc:?S4r { rc:?r1-> rc:?S2r {} }
¬ ( rc:?S2r { rc:?r2-> rc:?S5r {} } & ¬ ?S5r.id == ?S1r.id )
¬ ( rc:?S6r { rc:?r3-> rc:?S1r {} } & ¬ ?S6r.id == ?S2r.id )
¬rc:?S1r { rc:?r4-> rc:?S8r {} }
  ]
]

/*Here we use "slex" on main verbs to check that they are the same, but "lex" in Agg2.*/
SSynt<=>SSynt EN_mark_SameRootSubj_sameObjRel_Interrogatives
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
          c:?r2-> c:?Obj2 {}
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

// the object relation is the same
?r1 == ?r2

// the main verb and the subject are the same
?semV1 == ?semV2
?semS1 == ?semS2

// the support verbs both have the same verbal tense
?tense1 == ?tense2

// There isn't a dependent on one of the subjects that is not a dependent of the subject in the other sentence (to be improved)
// SHOULDN'T THIS CONDITION BE REPEATED ON THE COMPLEX CONDITIONS BELOW?
¬ ( c:?Subj1 { c:?r4-> c:?Dep4l { c:slex= ?semD4 } } & c:?Subj2 { c:?r5-> c:?Dep5l { c:slex= ?semD5 } } & ( ¬?semD4 == ?semD5 | ¬?r4 == ?r5 ) )

// There isn't a pronoun with external antecedent in the sentence to be moved (unless a mention to the same NE is already in the host sentence).
//( ¬ ( c:?S2l { c:?Pro11no { ( c:slex = "_PRO_" | c:pronominalized = yes ) } } )
//  | ( c:?S2l { c:?Pro11 { ( c:slex = "_PRO_" | c:pronominalized = yes ) c:<-> c:?Ante11 {} } }
//    & ( c:?S2l { c:?Ante11 {} } | c:?S1l { c:?Ante11 {} } | ( c:?S11l { c:?Ante11 {} } & c:?S1l { c:?Prob11 { c:<-> c:?Ante11 {} } } ) )
//  )
//)

  
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
rc:?S2r {
  rc:<=> ?S2l
  blocked_potential = "yes"
  mergeRootSubjCoord-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?SupportV2r {
  rc:<=> ?SupportV2
  blocked_potential = "yes"
}

rc:?MainV2r {
  rc:<=> ?MainV2
  blocked_potential = "yes"
}

rc:?Subj2r {
  rc:<=> ?Subj2
  blocked_potential = "yes"
}
  ]
]

/*Here we use "slex" on main verbs to check that they are the same, but "lex" in Agg2.
Simplify LS some day Alba, please.*/
SSynt<=>SSynt EN_merge_SameRootSubj_sameObjRel_Interrogatives
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
          c:?r2-> c:?Obj2 {}
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

// the object relation is the same
?r1 == ?r2

// the main verb and the subject are the same
?semV1 == ?semV2
?semS1 == ?semS2

// the support verbs both have the same verbal tense
?tense1 == ?tense2

( lexicon.miscellaneous.conjunction.default_type.?ct | c:?Obj2 { c:coord_type = ?ct } )

// There isn't a dependent on one of the subjects that is not a dependent of the subject in the other sentence (to be improved)
// SHOULDN'T THIS CONDITION BE REPEATED ON THE COMPLEX CONDITIONS BELOW?
¬ ( c:?Subj1 { c:?r4-> c:?Dep4l { c:slex= ?semD4 } } & c:?Subj2 { c:?r5-> c:?Dep5l { c:slex= ?semD5 } } & ( ¬?semD4 == ?semD5 | ¬?r4 == ?r5 ) )

// There isn't a pronoun with external antecedent in the sentence to be moved (unless a mention to the same NE is already in the host sentence).
//( ¬ ( c:?S2l { c:?Pro11no { ( c:slex = "_PRO_" | c:pronominalized = yes ) } } )
//  | ( c:?S2l { c:?Pro11 { ( c:slex = "_PRO_" | c:pronominalized = yes ) c:<-> c:?Ante11 {} } }
//    & ( c:?S2l { c:?Ante11 {} } | c:?S1l { c:?Ante11 {} } | ( c:?S11l { c:?Ante11 {} } & c:?S1l { c:?Prob11 { c:<-> c:?Ante11 {} } } ) )
//  )
//)

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
rc:?S2r {
  rc:<=> ?S2l
  rc:blocked_potential = "yes"
  blocked = "yes"
  applied_agg = "mergeRootSubjCoord"
  rc:mergeRootSubjCoord-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?SupportV2r {
  rc:<=> ?SupportV2
  rc:blocked_potential = "yes"
  blocked = "yes"
}

rc:?MainV2r {
  rc:<=> ?MainV2
  rc:blocked_potential = "yes"
  blocked = "yes"
}

rc:?Subj2r {
  rc:<=> ?Subj2
  rc:blocked_potential = "yes"
  blocked = "yes"
}

rc:?Obj1r {
  rc:<=> ?Obj1
  attach_coord = "yes"
  conjunction_type = ?ct
}

rc:?Obj2r {
  rc:<=> ?Obj2
  mergeRootSubjCoord = "anchor"
}


¬rc:?S3r { rc:mergeRootSubjCoord-> rc:?S2r {} }
  ]
]

/*It can happen that with 4 sentences A, B, C and D, we have the following aggregation pattern:
D -> C -> B -> A
In this case, the output text is A while B while C while D. We may want to cut the aggregation between C and B in this case.*/
SSynt<=>SSynt mark_block_merge_multiple_contrast
[
  leftside = [
c:?S1l {
  c:*~ c:?S2l {
    c:?X2l {}
    c:*~ c:?S3l {
      c:?X3l {}
      c:*~ c:?S4l {
      }
    }
  }
}

¬c:?Gov1l { c:?r1-> c:?X2l {} }
¬c:?Gov2l { c:?r2-> c:?X3l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S4r {
  rc:<=> ?S4l
  rc:blocked = "yes"
  rc:noMergeCoordContrastLex-> rc:?S3r {
    rc:<=> ?S3l
    rc:blocked = "yes"
    cancel_block = "yes"
    rc:?X3r {
      rc:<=> ?X3l
      rc:attach_coord = "yes"
      rc:conjunction_type = "contrast"
    }
    rc:noMergeCoordContrastLex-> rc:?S2r {
      rc:<=> ?S2l
      rc:blocked = "yes"
      rc:?X2r {
        rc:<=> ?X2l
        rc:attach_coord = "yes"
        rc:conjunction_type = "contrast"
        cancel_coord = "yes"
      }
      rc:noMergeCoordContrastLex-> rc:?S1r {
        rc:<=> ?S1l
      }
    }
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

SSynt<=>SSynt attr_straight_weight : transfer_attributes
[
  leftside = [
c:?Xl {
  straight_weight = ?s
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  straight_weight = ?s
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

