/*BUG: gives an overlap with node_word if no c: !!*/
Sem<=>ASem node_word
[
  leftside = [
?Xl {
  ¬c:blocked = "yes"
  ¬c:flex = ?f
  c:sem = ?s
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

Sem<=>ASem node_word_flex
[
  leftside = [
?Xl {
  ¬c:blocked = "yes"
  c:flex = ?s
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

/*Transfers all non-argumental relations.*/
Sem<=>ASem rel_copy
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

/*Not needed so far*/
excluded Sem<=>DSynt bubble_expand_dep
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:include = bubble_of_dep
  rc:?r-> rc:?Xr {
    rc:<=> ?Xl
  }
}

rc:?bubble {
  rc:?Xr {
    rc:<=> ?Xl
  }
  rc:+?Yr {}
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

/*For bubbles that have the same property and subject but objects with different relations (e.g. born + date; born + place )*/
Sem<=>ASem merge_SameRootSubj_differentObjRel
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:?r1-> c:?Y1l {
        c:sem = ?semY1
      }
// update 08/11/2019: shoud we  require that X1l HAS another dependent?
      c:?s1-> c:?Z1l {}
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:sem = ?semX2
        c:?r2-> c:?Y2l {
          c:sem = ?semY2
        }
        c:?s2-> c:?Z2l {}
      }
    }
  }
}
// restrict to subjects for now
?r1 == ?r2
( ?r1 == A0 | ( ?r1 == A1 & c:?X1l { ¬c:A0-> c:?K1l {} } )
 | ( ?r1 == A2 & c:?X1l { ¬c:A0-> c:?A1l {} ¬c:A1-> c:?B1l {} } ) )
// the property and the subject are the same
?semX1 == ?semX2
?semY1 == ?semY2
// the dependent on the second instance of the property is not already present on the first instance.
//¬ ( c:?X1l { c:?s1-> c:?Z1l {} } & ?s1 == ?s2 ) Replaced by following line; See update 08/11/2019 above
¬?s1 == ?s2

//Both Xs are roots
¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// the rule in which the objects are the same too do not apply
// generalize as next condition?
//¬ ( c:?X1l { c:?s4-> c:?Y4l {} } & ?s4 ==?s2 )
//¬ ( c:?X2l { c:?s5-> c:?Y5l {} } & ?s5 ==?s1 )
// The root verbs don't have a dependent with the same relation (see same_Obj rules)
¬( c:?X1l { c:?r9-> c:?Dep9l {} } & c:?X2l { c:?r10-> c:?Dep10l {} } & ( ?r9 == ?r10 ) & ¬?r9 == ?r1 )

// There isn't a dependent on one of the arguments that is not on the dependent of the second sentence (to be improved)
¬ ( c:?Y1l { c:?r4-> c:?Dep4l { c:sem= ?semD4 } } & c:?Y2l { c:?r5-> c:?Dep5l { c:sem= ?semD5 } } & ( ¬?semD4 == ?semD5 | ¬?r4 == ?r5 ) )

// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:?X3l { c:sem = ?semX3 c:?r3-> c:?Y3l { c:sem = ?semY3 } } } }
    & ¬c:?Gov8l { c:?r8-> c:?X3l {} }
    & ?semX3 == ?semX2 & ?semY3 == ?semY2 & ?r3 == ?r2
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
    // & ¬ ( c:?X3l { c:?s3-> c:?Z3l {} } & ?s3 == ?s2 )
    & ¬ ( c:?X3l { c:?r11-> c:?Dep11l {} } & c:?X2l { c:?r12-> c:?Dep12l {} } & ?r11 == ?r12 )
)

// the verbs both have the same verbal tense or none at this point
( ( c:?X1l { ¬c:tense = ?t1 } & c:?X2l { ¬c:tense = ?t2 } )
  | ( c:?X1l { c:tense = ?tt1 } & c:?X2l { c:tense = ?tt2 } & ?tt1 == ?tt2 ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  mergeRootSubj-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X2r {
  rc:<=> ?X2l
  blocked = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  blocked = "yes"
}

rc:?X1r {
  rc:<=> ?X1l
  agg_trig = "yes"
}

rc:?Y1r {
  rc:<=> ?Y1l
  agg_trig = "yes"
}
  ]
]

/*For bubbles that have the same property and subject, and both have an object with the same relation (e.g. located north of X / south of Y )*/
Sem<=>ASem merge_SameRootSubj_sameObjRel
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:?r1-> c:?Y1l {
        c:sem = ?semY1
      }
      c:?s1-> c:?Z1l {}
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:sem = ?semX2
        c:?r2-> c:?Y2l {
          c:sem = ?semY2
        }
        c:?s2-> c:?Z2l {}
      }
    }
  }
}
// restrict to subjects for now
?r1 == ?r2
( ?r1 == A0 | ( ?r1 == A1 & c:?X1l { ¬c:A0-> c:?K1l {} } )
 | ( ?r1 == A2 & c:?X1l { ¬c:A0-> c:?A1l {} ¬c:A1-> c:?B1l {} } ) )
// the property and the subject are the same
?semX1 == ?semX2
?semY1 == ?semY2
// Test condition, add it to the other conditions below? Idea is that Zl should not be exactly the same (see 201005_test_triples_en_en_utf8_0900-1349.conll structure 0)
( ( ¬?Z1l.sem == ?Z2l.sem )
  | ( c:?Z1l { c:?r9Z1-> c:?Dr9Z1 { c:sem = ?sDr9Z1 } } & c:?Z2l { c:?r9Z2-> c:?Dr9Z2 { c:sem = ?sDr9Z2 } } & ¬?sDr9Z1 == ?sDr9Z2 )
  | ( c:?Gr9Z1 { c:sem = ?sGr9Z1 c:?gr9Z1-> c:?Z1l {} } & c:?Gr9Z2 { c:sem = ?sGr9Z2 c:?gr9Z2-> c:?Z2l {} } & ¬ ?sGr9Z1 == ?sGr9Z2 & ¬?sGr9Z1 == ?semX1 & ¬?sGr9Z2 == ?semX2 )
)

// the objects of the property have the same relation
?s1 == ?s2

//Both Xs are roots
¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// the objects both have the same subcat prep or none at this point
( ( c:?Z1l { ¬c:subcat_prep = ?a1 } & c:?Z2l { ¬c:subcat_prep = ?a2 } )
  | ( c:?Z1l { c:subcat_prep = ?scZ1 } & c:?Z2l { c:subcat_prep = ?scZ2 } & ?scZ1 == ?scZ2 ) )

// There isn't a dependent on one of the arguments that is not on the dependent of the second sentence (to be improved)
¬ ( c:?Y1l { c:?r4-> c:?Dep4l { c:sem= ?semD4 } } & c:?Y2l { c:?r5-> c:?Dep5l { c:sem= ?semD5 } } & ( ¬?semD4 == ?semD5 | ¬?r4 == ?r5 ) )

// the verbs both have the same verbal tense or none at this point
( ( c:?X1l { ¬c:tense = ?t1 } & c:?X2l { ¬c:tense = ?t2 } )
  | ( c:?X1l { c:tense = ?tt1 } & c:?X2l { c:tense = ?tt2 } & ?tt1 == ?tt2 ) )

//// the verbs don't have a modality attribute
//// AND ?S1l is the first sentence, to which all other sentences will point
//( ( ( c:?X1l { ¬c:modality = ?m1 } & c:?X2l { ¬c:modality = ?m2 } ) & ¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:?X3l { c:sem = ?semX3 ¬c:modality = ?m3 c:?r3-> c:?Y3l { c:sem = ?semY3 }  c:?s3-> c:?Z3l {} } } }
//    & ¬c:?Gov8l { c:?r8-> c:?X3l {} }
//    & ?semX3 == ?semX2 & ?semY3 == ?semY2 & ?r3 == ?r2 & ?s3 == ?s2
//    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1 ) )  
//// OR both verbs have the same modality and modality type
//// AND ?S1l is the first sentence, to which all other sentences will point    
//  | ( ( c:?X1l { c:modality = ?mm1 c:modality_type = ?mt1 } & c:?X2l { c:modality = ?mm2 c:modality_type = ?mt2 } & ?mm1 == ?mm2 & ?mt1 == ?mt2 ) &
//  ¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:?X3l { c:sem = ?semX3 c:modality = ?mm3 c:modality_type = ?mt3 c:?r3-> c:?Y3l { c:sem = ?semY3 }  c:?s3-> c:?Z3l {} } } }
//    & ¬c:?Gov8l { c:?r8-> c:?X3l {} }
//    & ?semX3 == ?semX2 & ?semY3 == ?semY2 & ?r3 == ?r2 & ?s3 == ?s2 & ?mm3 == ?mm2 & ?mt3 == ?mt2
//    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1 ) ) )

// The next condition only works if we ignore the requests for ?X and ?Z to have (or not have) specific attributes (modality, tense, subcat_prep)
// Note that Simon had already had problems with this type of requests inside the condition (it was commented)
// It is still not clear why those requests cannot be added as here below, but while this is being fixed, the condition above works...
// Problem: the ?S1 condition must be repeated for each condition on its nodes that includes an OR (at the moment it is only repeated for modality)

// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:?X3l { c:sem = ?semX3 c:?r3-> c:?Y3l { c:sem = ?semY3 }  c:?s3-> c:?Z3l {} } } }
    & ¬c:?Gov8l { c:?r8-> c:?X3l {} }
    & ?semX3 == ?semX2 & ?semY3 == ?semY2 & ?r3 == ?r2 & ?s3 == ?s2
    // next condition gives a bug, fix this later
//    & ( ( c:?Z3l { ¬c:subcat_prep = ?a3 } & c:?Z2l { ¬c:subcat_prep = ?a23 } )
//      | ( c:?Z3l { c:subcat_prep = ?scZ3 } & c:?Z2l { c:subcat_prep = ?scZ23 } & ?scZ3 == ?scZ23 ) )
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
)

¬ ( ?Z1l.variable_class == "Name" & ?Z2l.variable_class == "Scene" )

// If there is more than one root in the sentence, X has to be the main rheme
//¬ ( ( ?S1l.has_main_rheme == "yes" & ¬?X1l.main_rheme == "yes" )
// | ( ?S2l.has_main_rheme == "yes" & ¬?X2l.main_rheme == "yes" ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  mergeRootSubjCoord-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X2r {
  rc:<=> ?X2l
  blocked = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  blocked = "yes"
}

rc:?Z1r {
  rc:<=> ?Z1l
  attach_coord = "yes"
}

rc:?X1r {
  rc:<=> ?X1l
  agg_trig = "yes"
}

rc:?Y1r {
  rc:<=> ?Y1l
  agg_trig = "yes"
}
  ]
]

/*For bubbles that have the same property and subject, and  both have an object with the same relation (e.g. located north of X 7 south of Y )
Variant of RootSubj_sameObj but the subcat preps are not necessarily the same.*/
Sem<=>ASem merge_SameRootSubj_sameObjRel_Elab
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:?r1-> c:?Y1l {
        c:sem = ?semY1
      }
      c:?s1-> c:?Z1l {}
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:sem = ?semX2
        c:?r2-> c:?Y2l {
          c:sem = ?semY2
        }
        c:?s2-> c:?Z2l {}
      }
    }
  }
}
// restrict to subjects for now
?r1 == ?r2
( ?r1 == A0 | ( ?r1 == A1 & c:?X1l { ¬c:A0-> c:?K1l {} } )
 | ( ?r1 == A2 & c:?X1l { ¬c:A0-> c:?A1l {} ¬c:A1-> c:?B1l {} } ) )
// the property and the subject are the same
?semX1 == ?semX2
?semY1 == ?semY2
// the objects of the property have the same relation
?s1 == ?s2

//Both Xs are roots
¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// the objects DO NOT both have the same subcat prep or none at this point
¬ ( ( c:?Z1l { ¬c:subcat_prep = ?a1 } & c:?Z2l { ¬c:subcat_prep = ?a2 } )
  | ( c:?Z1l { c:subcat_prep = ?scZ1 } & c:?Z2l { c:subcat_prep = ?scZ2 } & ?scZ1 == ?scZ2 ) )
  
// There isn't a dependent on one of the arguments that is not on the dependent of the second sentence (to be improved)
¬ ( c:?Y1l { c:?r4-> c:?Dep4l { c:sem= ?semD4 } } & c:?Y2l { c:?r5-> c:?Dep5l { c:sem= ?semD5 } } & ( ¬?semD4 == ?semD5 | ¬?r4 == ?r5 ) )
  
// the verbs both have the same verbal tense or none at this point
( ( c:?X1l { ¬c:tense = ?t1 } & c:?X2l { ¬c:tense = ?t2 } )
  | ( c:?X1l { c:tense = ?tt1 } & c:?X2l { c:tense = ?tt2 } & ?tt1 == ?tt2 ) )
  
// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:?X3l { c:sem = ?semX3 c:?r3-> c:?Y3l { c:sem = ?semY3 }  c:?s3-> c:?Z3l {} } } }
    & ¬c:?Gov8l { c:?r8-> c:?X3l {} }
    & ?semX3 == ?semX2 & ?semY3 == ?semY2 & ?r3 == ?r2 & ?s3 == ?s2
    // next condition gives a bug, fix this later
//    & ( ( c:?Z3l { ¬c:subcat_prep = ?a3 } & c:?Z2l { ¬c:subcat_prep = ?a23 } )
//      | ( c:?Z3l { c:subcat_prep = ?scZ3 } & c:?Z2l { c:subcat_prep = ?scZ23 } & ?scZ3 == ?scZ23 ) )
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
)
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  mergeRootSubjElab-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X2r {
  rc:<=> ?X2l
  blocked = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  blocked = "yes"
}

rc:?Z1r {
  rc:<=> ?Z1l
  attach_elab = "yes"
}

rc:?X1r {
  rc:<=> ?X1l
  agg_trig = "yes"
}

rc:?Y1r {
  rc:<=> ?Y1l
  agg_trig = "yes"
}
  ]
]

/*When the property and the object/location/time are the same and the subject is different.*/
Sem<=>ASem merge_SameRootObj_sameSubjRel
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:?r1-> c:?Y1l {
        c:sem = ?semY1
      }
      c:?s1-> c:?Z1l {}
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:sem = ?semX2
        c:?r2-> c:?Y2l {
          c:sem = ?semY2
        }
        c:?s2-> c:?Z2l {}
      }
    }
  }
}

// Ugly patch till we implement same check as in Con_Agg3 (first mark, then choose).
¬ ( ?semX2 == "per" & c:?Gov9l { c:sem = "number_count" c:?r9-> c:?Z2l {} } )

// restrict to objects, Location and Time for now
?r1 == ?r2
 ( ?r1== Location | ?r1 == Time | ( ?r1 == A1 & c:?X1l { c:A0-> c:?K4l {} } ) | ( ?r1 == A2 & c:?X1l { ¬c:A0-> c:?Z4l {} c:A1-> c:?J4l {} } ) )

// the property and the object  are the same
?semX1 == ?semX2
?semY1 == ?semY2
¬ ?Z1l.sem == ?Z2l.sem

// the subjects of the property have the same relation
?s1 == ?s2
( ?s1 == A0 | ( ?s1 == A1 & c:?X1l { ¬c:A0-> c:?K1l {} } )
  | ( ?s1 == A2 & c:?X1l { ¬c:A0-> c:?A1l {} ¬c:A1-> c:?B1l {} } ) )
  
//Both Xs are roots
¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// the subjects both have the same subcat prep or none at this point
( ( c:?Z1l { ¬c:subcat_prep = ?a1 } & c:?Z2l { ¬c:subcat_prep = ?a2 } )
  | ( c:?Z1l { c:subcat_prep = ?scZ1 } & c:?Z2l { c:subcat_prep = ?scZ2 } & ?scZ1 == ?scZ2 ) )

// There isn't a dependent on one of the arguments that is not on the dependent of the second sentence (to be improved)
¬ ( c:?Y1l { c:?r4-> c:?Dep4l { c:sem= ?semD4 } } & c:?Y2l { c:?r5-> c:?Dep5l { c:sem= ?semD5 } } & ( ¬?semD4 == ?semD5 | ¬?r4 == ?r5 ) )

// the verbs both have the same verbal tense or none at this point
( ( c:?X1l { ¬c:tense = ?t1 } & c:?X2l { ¬c:tense = ?t2 } )
  | ( c:?X1l { c:tense = ?tt1 } & c:?X2l { c:tense = ?tt2 } & ?tt1 == ?tt2 ) )
  
// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:?X3l { c:sem = ?semX3 c:?r3-> c:?Y3l { c:sem = ?semY3 }  c:?s3-> c:?Z3l {} } } }
    & ¬c:?Gov8l { c:?r8-> c:?X3l {} }
    & ?semX3 == ?semX2 & ?semY3 == ?semY2 & ?r3 == ?r2 & ?s3 == ?s2
    // next condition gives a bug, fix this later
//    & ( ( c:?Z3l { ¬c:subcat_prep = ?a3 } & c:?Z2l { ¬c:subcat_prep = ?a23 } )
//      | ( c:?Z3l { c:subcat_prep = ?scZ3 } & c:?Z2l { c:subcat_prep = ?scZ23 } & ?scZ3 == ?scZ23 ) )
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
)
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  mergeRootObjCoord-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X2r {
  rc:<=> ?X2l
  blocked = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  blocked = "yes"
}

rc:?Z1r {
  rc:<=> ?Z1l
  attach_coord = "yes"
}

rc:?X1r {
  rc:<=> ?X1l
  agg_trig = "yes"
}

rc:?Y1r {
  rc:<=> ?Y1l
  agg_trig = "yes"
}
  ]
]

/*Covers different subj, obj.
Applies when roots are the same but none of the dependencies below the second root is the same as any below the first root.
Eg the first root has an A1, and the second root an A2 and/or an A3.*/
Sem<=>ASem noMerge_SameRoot_noOtherSame1
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:?r1-> c:?Y1l {}
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:sem = ?semX2
        c:?r2-> c:?Y2l {}
      }
    }
  }
}
// restrict to subjects for now
( ?r1 == A0 | ( ?r1 == A1 & c:?X1l { ¬c:A0-> c:?K1l {} } )
 | ( ?r1 == A2 & c:?X1l { ¬c:A0-> c:?A1l {} ¬c:A1-> c:?B1l {} } ) )
// the property/root is the same
?semX1 == ?semX2

//Both Xs are roots
¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// There isn't a same dependent on the predicate to aggregate
¬?r2 == ?r1
¬ ( c:?X2l { c:?r4-> c:?Y4l {}} & ?r4 == ?r1 )
  
// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:?X3l { c:sem = ?semX3 c:?r3-> c:?Y3l {} } } }
    & ¬c:?Gov8l { c:?r8-> c:?X3l {} }
    & ?semX3 == ?semX2 & ¬?r3 == ?r2
    // next condition gives a bug, fix this later
//    & ( ( c:?Z3l { ¬c:subcat_prep = ?a3 } & c:?Z2l { ¬c:subcat_prep = ?a23 } )
//      | ( c:?Z3l { c:subcat_prep = ?scZ3 } & c:?Z2l { c:subcat_prep = ?scZ23 } & ?scZ3 == ?scZ23 ) )
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
)

// If there is more than one root in the sentence, X has to be the main rheme
¬ ( ( ?S1l.has_main_rheme == "yes" & ¬?X1l.main_rheme == "yes" )
 | ( ?S2l.has_main_rheme == "yes" & ¬?X2l.main_rheme == "yes" ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  noMergeCoord-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X1r {
  rc:<=> ?X1l
  attach_coord = "yes"
}
  ]
]

/*! Activate and work on it ! This introduces quite some changes. And problems, see en_genInputs:
5, 19, 25, 51, 75, 82, 228, 229, 230, 248, 249, 255, 317, 318, 343, 344
Covers different subj, obj.
Same as noOtherSame1, but this time one of the dependencies can be the same, but not the dependent label.*/
excluded Sem<=>ASem noMerge_SameRoot_noOtherSame2
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:?r1-> c:?Y1l {
        c:sem = ?semY1
      }
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:sem = ?semX2
        c:?r2-> c:?Y2l {
          c:sem = ?semY2
        }
      }
    }
  }
}
// restrict to subjects for now
( ?r1 == A0 | ( ?r1 == A1 & c:?X1l { ¬c:A0-> c:?K1l {} } )
 | ( ?r1 == A2 & c:?X1l { ¬c:A0-> c:?A1l {} ¬c:A1-> c:?B1l {} } ) )
// the property/root is the same
?semX1 == ?semX2

//Both Xs are roots
¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

?r2 == ?r1
¬?semY1 == ?semY2
  
// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:?X3l { c:sem = ?semX3 c:?r3-> c:?Y3l { c:sem = ?semY3 } } } }
    & ¬c:?Gov8l { c:?r8-> c:?X3l {} }
    & ?semX3 == ?semX2 & ?r3 == ?r2
 & ¬?semY3 == ?semY2
    // next condition gives a bug, fix this later
//    & ( ( c:?Z3l { ¬c:subcat_prep = ?a3 } & c:?Z2l { ¬c:subcat_prep = ?a23 } )
//      | ( c:?Z3l { c:subcat_prep = ?scZ3 } & c:?Z2l { c:subcat_prep = ?scZ23 } & ?scZ3 == ?scZ23 ) )
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
)
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  noMergeCoord-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X1r {
  rc:<=> ?X1l
  attach_coord = "yes"
}
  ]
]

/*Covers same subj, obj with at least one different dependent.
Same as noOtherSame1, but this time one of the dependencies can be the same, and the dependent too.
In this case, we go lower in the graph to confirm that the dependents are not the same.*/
Sem<=>ASem noMerge_SameRoot_noOtherSame3
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:?r1-> c:?Y1l {
        c:sem = ?semY1
      }
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:sem = ?semX2
        c:?r2-> c:?Y2l {
          c:sem = ?semY2
        }
        // to distinguish from sameUniqueArgRel
        c:?r2b-> c:?Y2bl {}
      }
    }
  }
}

// restrict to subjects for now
( ?r1 == A0 | ( ?r1 == A1 & c:?X1l { ¬c:A0-> c:?K1l {} } )
 | ( ?r1 == A2 & c:?X1l { ¬c:A0-> c:?A1l {} ¬c:A1-> c:?B1l {} } ) )
// the property and the subject are the same
?semX1 == ?semX2
?semY1 == ?semY2
?r2 == ?r1

//Both Xs are roots
¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// one dependent of one of the Yl is not on the other Yl. Not sure about that condition (191119_CONNEXIONs sent 74, low index)
( ( c:?Y1l { c:?r9-> c:?Dep9 { c:sem = ?sD9 } } & ¬ ( c:?Y2l { c:?r10-> c:?Dep10 { c:sem = ?sD10 } } & ?r10 == ?r9 & ?sD10 == ?sD9 ) )
 | ( c:?Y2l { c:?r11-> c:?Dep11 { c:sem = ?sD11 } } & ¬ ( c:?Y1l { c:?r12-> c:?Dep12 { c:sem = ?sD12 } } & ?r12 == ?r11 & ?sD12 == ?sD11 ) )
)

// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:?X3l { c:sem = ?semX3 c:?r3-> c:?Y3l { c:sem = ?semY3 } } } }
    & ¬c:?Gov8l { c:?r8-> c:?X3l {} }
    & ?semX3 == ?semX2 & ?semY3 == ?semY2 & ?r3 == ?r2
    & ( ( c:?Y3l { c:?r13-> c:?Dep13 { c:sem = ?sD13 } } & ¬ ( c:?Y2l { c:?r14-> c:?Dep14 { c:sem = ?sD14 } } & ?r14 == ?r13 & ?sD14 == ?sD13 ) )
 | ( c:?Y2l { c:?r15-> c:?Dep15 { c:sem = ?sD15 } } & ¬ ( c:?Y3l { c:?r16-> c:?Dep16 { c:sem = ?sD16 } } & ?r16 == ?r15 & ?sD16 == ?sD15 ) ) )
    // next condition gives a bug, fix this later
//    & ( ( c:?Z3l { ¬c:subcat_prep = ?a3 } & c:?Z2l { ¬c:subcat_prep = ?a23 } )
//      | ( c:?Z3l { c:subcat_prep = ?scZ3 } & c:?Z2l { c:subcat_prep = ?scZ23 } & ?scZ3 == ?scZ23 ) )
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
)
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  noMergeCoord-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X1r {
  rc:<=> ?X1l
  attach_coord = "yes"
}
  ]
]

/*Same property, same argument slot, same dependent.
It doesn't look like this config is covered by any other rule so far. Found the rule deactivated but dunno why, reactivated it.*/
Sem<=>ASem merge_SameRoot_sameUniqueArg
[
  leftside = [
c:?Tl {
 
  c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:?r-> c:?Y1l {
        c:sem = ?semY1
      }
      ¬c:?s1-> c:?Z1l {}
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:sem = ?semX2
        c:?s-> c:?Y2l {
          c:sem = ?semY2
        }
        ¬c:?s2-> c:?Z2l {}
      }
    }
  }
}

project_info.project.gen_type.D2T

// see merge_SameRoot_sameUniqueLocRel
¬ ?r == Location

// Test condition that goes check the project dico for info about properties to aggregate; use for all other agg rules if satisfactory.
¬ ( c:?X1l { c:variable_class = ?vcX1 } & c:?X2l { c:variable_class = ?vcX2 } & project_info.properties_to_not_aggregate.?vcX1.prop.?vcX2 )

// see CONNEXIONs rules (NPerSentence)
¬ ( ?semY1 == "number_count" &  ?semY2 == "number_count"
   & c:?Y1l { c:NonCore-> c:?Z1al { c:sem = ?semZ1a } c:A2-> c:?Z1bl {} }
   & c:?Y2l { c:NonCore-> c:?Z2al { c:sem = ?semZ2a } c:A2-> c:?Z2bl {} }
   & c:?Per1l { c:sem = "per" c:A1-> c:?Z1bl {} c:A2-> c:?Ref1l { c:sem = ?semRef1 } }
   & c:?Per2l { c:sem = "per" c:A1-> c:?Z2bl {} c:A2-> c:?Ref2l { c:sem = ?semRef2 } }
   & ?semRef1 == ?semRef2 & ?semZ1a == ?semZ2a
)

// see V4Design rules (HighestStartEnd)
¬ ( ?semX1 == "highest" & c:?S1l { c:?Year { ( c:variable_class = "HighestEnd" | c:variable_class = "HighestStart" ) } } )

// the property is the same, the relation and the dependent too
?semX1 == ?semX2
?r == ?s
?semY1 == ?semY2

//Both Xs are roots
¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:?X3l { c:sem = ?semX3 c:?r3-> c:?Y3l { c:sem = ?semY3 }  ¬c:?s3-> c:?Z3l {} } } }
    & ¬c:?Gov8l { c:?r8-> c:?X3l {} }
    & ?semX3 == ?semX2 & ?semY3 == ?semY2
    & ?r3 == ?r
    // next condition gives a bug, fix this later
//    & ( ( c:?Z3l { ¬c:subcat_prep = ?a3 } & c:?Z2l { ¬c:subcat_prep = ?a23 } )
//      | ( c:?Z3l { c:subcat_prep = ?scZ3 } & c:?Z2l { c:subcat_prep = ?scZ23 } & ?scZ3 == ?scZ23 ) )
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
    & ¬ ( c:?X1l { c:variable_class = ?vcX10 } & c:?X3l { c:variable_class = ?vcX11 } & project_info.properties_to_not_aggregate.?vcX10.prop.?vcX11 )
)

// ?Y2l is not involved in another type of aggregation with ?Y1l (expand to other bubbles beyond ?S1?).
¬ ( c:?Gr9Z1 { c:sem = ?sGr9Z1 c:?gr9Z1-> c:?Y1l {} } & c:?Gr9Z2 { c:sem = ?sGr9Z2 c:?gr9Z2-> c:?Y2l {} } & ?sGr9Z1 == ?sGr9Z2 & ?gr9Z1 == ?gr9Z2 & ¬?sGr9Z1 == ?semX1 & ¬?sGr9Z2 == ?semX2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  mergeRootCoord-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X2r {
  rc:<=> ?X2l
  blocked = "yes"
}

rc:?Y1r {
  rc:<=> ?Y1l
  attach_coord = "yes"
}

rc:?X1r {
  rc:<=> ?X1l
  agg_trig = "yes"
}
  ]
]

/*For bubbles that have the same property and subject relation, but the subject is different.*/
Sem<=>ASem merge_SameRoot_sameUniqueArgRel
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:?r1-> c:?Y1l {
        c:sem = ?semY1
      }
      ¬c:?s1-> c:?Z1l {}
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:sem = ?semX2
        c:?r2-> c:?Y2l {
          c:sem = ?semY2
        }
        ¬c:?s2-> c:?Z2l {}
      }
    }
  }
}
// restrict to subjects for now
?r1 == ?r2
( ?r1 == A0 | ( ?r1 == A1 & c:?X1l { ¬c:A0-> c:?K1l {} } )
 | ( ?r1 == A2 & c:?X1l { ¬c:A0-> c:?A1l {} ¬c:A1-> c:?B1l {} } ) )
// the property and the subject are the same
?semX1 == ?semX2
¬?semY1 == ?semY2

//Both Xs are roots
¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }
  
// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:?X3l { c:sem = ?semX3 c:?r3-> c:?Y3l { c:sem = ?semY3 }  ¬c:?s3-> c:?Z3l {} } } }
    & ¬c:?Gov8l { c:?r8-> c:?X3l {} }
    & ?semX3 == ?semX2 & ¬?semY3 == ?semY2 & ?r3 == ?r2
    // next condition gives a bug, fix this later
//    & ( ( c:?Z3l { ¬c:subcat_prep = ?a3 } & c:?Z2l { ¬c:subcat_prep = ?a23 } )
//      | ( c:?Z3l { c:subcat_prep = ?scZ3 } & c:?Z2l { c:subcat_prep = ?scZ23 } & ?scZ3 == ?scZ23 ) )
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
)

// PATCH for xR4DRAMA, don't aggregate building info with stress level info
¬ ( c:?S1l { c:?X8l { c:variable_class = "Building" } } & c:?S2l { c:?X9l { c:variable_class = "StressLevel" } } )
¬ ( c:?S2l { c:?X10l { c:variable_class = "Building" } } & c:?S1l { c:?X11l { c:variable_class = "StressLevel" } } )

// ?Y2l is not involved in another type of aggregation with ?Y1l (expand to other bubbles beyond ?S1?).
¬ ( c:?Gr9Z1 { c:sem = ?sGr9Z1 c:?gr9Z1-> c:?Y1l {} } & c:?Gr9Z2 { c:sem = ?sGr9Z2 c:?gr9Z2-> c:?Y2l {} } & ?sGr9Z1 == ?sGr9Z2 & ?gr9Z1 == ?gr9Z2 & ¬?sGr9Z1 == ?semX1 & ¬?sGr9Z2 == ?semX2 )

// ?Y2l is not involved in a SameRoot_sameUnique Arg as ?S1 with another sentence
¬ ( c:?Tl { c:?S10l { c:id = ?id10 c:?X10l { c:sem = ?semX10 c:?r10-> c:?Y10l { c:sem = ?semY10 }  ¬c:?s10-> c:?Z10l {} } c:*b-> c:?S2l {} } }
    & ¬c:?Gov11l { c:?r11-> c:?X10l {} }
    & ?semX10 == ?semX2 & ?semY10 == ?semY2
    & ?r10 == ?r1
    // next condition gives a bug, fix this later
//    & ( ( c:?Z3l { ¬c:subcat_prep = ?a3 } & c:?Z2l { ¬c:subcat_prep = ?a23 } )
//      | ( c:?Z3l { c:subcat_prep = ?scZ3 } & c:?Z2l { c:subcat_prep = ?scZ23 } & ?scZ3 == ?scZ23 ) )
)

// ?Y2l is not involved in a SameRoot_sameUnique as ?S2 Arg with another sentence
¬ ( c:?Tl { c:?S2l { c:*b-> c:?S12l { c:id = ?id12 c:?X12l { c:sem = ?semX12 c:?r12-> c:?Y12l { c:sem = ?semY12 }  ¬c:?s12-> c:?Z12l {} } } } }
    & ¬c:?Gov13l { c:?r13-> c:?X12l {} }
    & ?semX12 == ?semX2 & ?semY12 == ?semY2
    & ?r12 == ?r1
    // next condition gives a bug, fix this later
//    & ( ( c:?Z3l { ¬c:subcat_prep = ?a3 } & c:?Z2l { ¬c:subcat_prep = ?a23 } )
//      | ( c:?Z3l { c:subcat_prep = ?scZ3 } & c:?Z2l { c:subcat_prep = ?scZ23 } & ?scZ3 == ?scZ23 ) )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  mergeRootCoord-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X2r {
  rc:<=> ?X2l
  blocked = "yes"
}

rc:?Y1r {
  rc:<=> ?Y1l
  attach_coord = "yes"
}

rc:?X1r {
  rc:<=> ?X1l
  agg_trig = "yes"
}
  ]
]

/*Originally for beAWARE: fire in Valencia and La Devesa*/
Sem<=>ASem merge_SameRoot_sameUniqueLocRel
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:Location-> c:?Y1l {
        c:sem = ?semY1
      }
      ¬c:?s1-> c:?Z1l {}
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:sem = ?semX2
        c:Location-> c:?Y2l {
          c:sem = ?semY2
        }
        ¬c:?s2-> c:?Z2l {}
      }
    }
  }
}

project_info.project.gen_type.D2T

// the property is the same, not the Location
?semX1 == ?semX2
¬?semY1 == ?semY2

//Both Xs are roots
¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// ?S2 is not invovled in another type of aggregation where the Loc is the same (see merge_SameRootLoc)
¬ ( c:?Tl { c:?S4l { c:?X4l { c:sem = ?semX4 c:Location-> c:?Y4l { c:sem = ?semY4 } ¬c:?s4-> c:?Z4l {} } c:*b-> c:?S2l { c:?X2l {} } } }
  & ?semX4 == ?semX2 & ?semY4 == ?semY2
  & ¬c:?Gov9l { c:?r9-> c:?X4l {} } & ¬c:?Gov10l { c:?r10-> c:?X2l {} }
)

// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:?X3l { c:sem = ?semX3 c:?r3-> c:?Y3l { c:sem = ?semY3 }  ¬c:?s3-> c:?Z3l {} } } }
    & ¬c:?Gov8l { c:?r8-> c:?X3l {} }
    & ?semX3 == ?semX2 & ¬?semY3 == ?semY2
    // next condition gives a bug, fix this later
//    & ( ( c:?Z3l { ¬c:subcat_prep = ?a3 } & c:?Z2l { ¬c:subcat_prep = ?a23 } )
//      | ( c:?Z3l { c:subcat_prep = ?scZ3 } & c:?Z2l { c:subcat_prep = ?scZ23 } & ?scZ3 == ?scZ23 ) )
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
)

//If locations have classes, it can be Region, Country, City, etc. Other aggregation rules apply.
¬ ( c:?X1l { c:NE = "YES" } & c:?X2l { c:NE = "YES" } )
//¬ ( c:?Y1l { c:class = ?c1 } & c:?Y2l { c:class = ?c2 } )
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  mergeRootCoord-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X2r {
  rc:<=> ?X2l
  blocked = "yes"
}

rc:?Y1r {
  rc:<=> ?Y1l
  attach_coord = "yes"
}

rc:?X1r {
  rc:<=> ?X1l
  agg_trig = "yes"
}
  ]
]

/*Originally for V4Design: borobudur is a temple in Indonesia in a catacomb environment*/
Sem<=>ASem merge_SameRoot_sameUniqueLocRel_NE
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:NE = "YES"
      c:Location-> c:?Y1l {
        c:sem = ?semY1
      }
      ¬c:?s1-> c:?Z1l {}
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:sem = ?semX2
        c:NE = "YES"
        c:Location-> c:?Y2l {
          c:sem = ?semY2
        }
        ¬c:?s2-> c:?Z2l {}
      }
    }
  }
}

project_info.project.gen_type.D2T

// the property is the same, not the Location
?semX1 == ?semX2
¬?semY1 == ?semY2

//Both Xs are roots
¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// ?S2 is not invovled in another type of aggregation where the Loc is the same (see merge_SameRootLoc)
¬ ( c:?Tl { c:?S4l { c:?X4l { c:sem = ?semX4 c:Location-> c:?Y4l { c:sem = ?semY4 } ¬c:?s4-> c:?Z4l {} } c:*b-> c:?S2l { c:?X2l {} } } }
  & ?semX4 == ?semX2 & ?semY4 == ?semY2
  & ¬c:?Gov9l { c:?r9-> c:?X4l {} } & ¬c:?Gov10l { c:?r10-> c:?X2l {} }
)

// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:?X3l { c:sem = ?semX3 c:?r3-> c:?Y3l { c:sem = ?semY3 }  ¬c:?s3-> c:?Z3l {} } } }
    & ¬c:?Gov8l { c:?r8-> c:?X3l {} }
    & ?semX3 == ?semX2 & ¬?semY3 == ?semY2
    // next condition gives a bug, fix this later
//    & ( ( c:?Z3l { ¬c:subcat_prep = ?a3 } & c:?Z2l { ¬c:subcat_prep = ?a23 } )
//      | ( c:?Z3l { c:subcat_prep = ?scZ3 } & c:?Z2l { c:subcat_prep = ?scZ23 } & ?scZ3 == ?scZ23 ) )
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
)

// see NE_Class rule
¬ ( c:?Y1l { c:class = ?c1 } & c:?Y2l { c:class = ?c2 } )
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  mergeLocNE-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X2r {
  rc:<=> ?X2l
  blocked = "yes"
}

rc:?X1r {
  rc:<=> ?X1l
  agg_trig = "yes"
}
  ]
]

/*Originally for V4Design: borobudur is a temple in Indonesia (Central Java)*/
Sem<=>ASem merge_SameRoot_sameUniqueLocRel_NE_Class
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:NE = "YES"
      c:Location-> c:?Y1l {
        c:sem = ?semY1
        c:class = ?c1
      }
      ¬c:?s1-> c:?Z1l {}
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:sem = ?semX2
        c:NE = "YES"
        c:Location-> c:?Y2l {
          c:sem = ?semY2
          c:class = ?c2
        }
        ¬c:?s2-> c:?Z2l {}
      }
    }
  }
}

project_info.project.gen_type.D2T

// the property is the same, not the Location
?semX1 == ?semX2
¬?semY1 == ?semY2

//Both Xs are roots
¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// ?S2 is not invovled in another type of aggregation where the Loc is the same (see merge_SameRootLoc)
¬ ( c:?Tl { c:?S4l { c:?X4l { c:sem = ?semX4 c:Location-> c:?Y4l { c:sem = ?semY4 } ¬c:?s4-> c:?Z4l {} } c:*b-> c:?S2l { c:?X2l {} } } }
  & ?semX4 == ?semX2 & ?semY4 == ?semY2
  & ¬c:?Gov9l { c:?r9-> c:?X4l {} } & ¬c:?Gov10l { c:?r10-> c:?X2l {} }
)

// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:?X3l { c:sem = ?semX3 c:?r3-> c:?Y3l { c:sem = ?semY3 }  ¬c:?s3-> c:?Z3l {} } } }
    & ¬c:?Gov8l { c:?r8-> c:?X3l {} }
    & ?semX3 == ?semX2 & ¬?semY3 == ?semY2
    // next condition gives a bug, fix this later
//    & ( ( c:?Z3l { ¬c:subcat_prep = ?a3 } & c:?Z2l { ¬c:subcat_prep = ?a23 } )
//      | ( c:?Z3l { c:subcat_prep = ?scZ3 } & c:?Z2l { c:subcat_prep = ?scZ23 } & ?scZ3 == ?scZ23 ) )
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
)
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  mergeLocClass-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X2r {
  rc:<=> ?X2l
  blocked = "yes"
}

rc:?X1r {
  rc:<=> ?X1l
  agg_trig = "yes"
}
  ]
]

Sem<=>ASem beAWARE
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>ASem CONNEXIONs
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>ASem E2E
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>ASem MindSpaces
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>ASem V4Design
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>ASem xR4DRAMA
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

excluded Sem<=>ASem cancel_block_sentence
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:*b-> c:?S2l {}
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  rc:blocked = "yes"
  cancel_block = "yes"
  //rc:mergeRootObjCoord-> rc:?S1r {
  rc:?r-> rc:?S1r {
    rc:<=> ?S1l
    rc:blocked = "yes"
    ¬rc:cancel_block = "yes"
    //rc:mergeRootSubjCoord-> rc:?S3r {
    rc:?s-> rc:?S3r {
      //rc:<=> ?S3l
    }
  }
}

// ( ?r == mergeRootSubj | ?r == mergeRootSubjCoord | ?r == mergeRootSubjElab | ?r == mergeRootObjCoord | ?r == mergeRootCoord | ?r == noMergeCoord | ?r == mergeLocNE | ?r == mergeLocClass | ?r == merge_eatType | ?r == merge_near_area | ?r == mergeObjProgress | ?r == mergeDateStartEnd | ?r == mergeDateStartEnd2 | ?r == mergeHighestStartEnd )
// ( ?s == mergeRootSubj | ?s == mergeRootSubjCoord | ?s == mergeRootSubjElab | ?s == mergeRootObjCoord | ?s == mergeRootCoord | ?s == noMergeCoord | ?s == mergeLocNE | ?s == mergeLocClass | ?s == merge_eatType | ?s == merge_near_area | ?s == mergeObjProgress | ?s == mergeDateStartEnd | ?s == mergeDateStartEnd2 | ?s == mergeHighestStartEnd )
  ]
]

Sem<=>ASem cancel_block_sentence2
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:*b-> c:?S2l {}
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  rc:blocked = "yes"
  cancel_block = "yes"
  // there is one node at least that's not blocked
  rc:?Xr { ¬rc:blocked = "yes" }
  // If ?S2 merges with ?S0 (or another sentence?), allow aggregation
  ¬rc:?t-> rc:?S0l {}
  rc:?r-> rc:?S1r {
    rc:<=> ?S1l
    rc:blocked = "yes"
    // bugs if activated...
    //¬rc:cancel_block = "yes"
    rc:?s-> rc:?S0l {}
  }
}

 ( ?r == mergeRootSubj | ?r == mergeRootSubjCoord | ?r == mergeRootSubjElab | ?r == mergeRootObjCoord | ?r == mergeRootCoord | ?r == noMergeCoord | ?r == mergeLocNE | ?r == mergeLocClass | ?r == merge_eatType | ?r == merge_near_area | ?r == mergeObjProgress | ?r == mergeDateStartEnd | ?r == mergeDateStartEnd2 | ?r == mergeHighestStartEnd )
 ( ?s == mergeRootSubj | ?s == mergeRootSubjCoord | ?s == mergeRootSubjElab | ?s == mergeRootObjCoord | ?s == mergeRootCoord | ?s == noMergeCoord | ?s == mergeLocNE | ?s == mergeLocClass | ?s == merge_eatType | ?s == merge_near_area | ?s == mergeObjProgress | ?s == mergeDateStartEnd | ?s == mergeDateStartEnd2 | ?s == mergeHighestStartEnd )
  ]
]

Sem<=>ASem cancel_block_node
[
  leftside = [
c:?Tl {
  c:?S1l {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  rc:<=> ?S1l
  rc:cancel_block = "yes"
  rc:?Xr {
    rc:blocked = "yes"
    cancel_block = "yes"
  }
}
  ]
]

Sem<=>ASem add_also
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:*b-> c:?S2l {
      c:?Xl {}
    }
  }
}


¬c:?Govl { c:?s-> c:?Xl {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  rc:cancel_block = "yes"
  rc:?Xr {
    rc:<=> ?Xl
    rc:cancel_block = "yes"
    type = "add_also"
  }
  rc:?r-> rc:?S1r {
    rc:<=> ?S1l
  }
}

( ?r == mergeRootSubjCoord | ?r == mergeRootObjCoord )
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
Sem<=>ASem attr_elaboration : transfer_attribute
[
  leftside = [
c:?Xl {
  Elaboration = ?d
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  Elaboration = ?d
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
  ¬c:flex = ?s
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

Sem<=>ASem attr_slex_flex : transfer_attribute
[
  leftside = [
c:?Xl {
  c:flex = ?s
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  slex = ?s
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

Sem<=>ASem attr_MindSpaces : transfer_attribute
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>ASem Rotowire : transfer_attribute
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*Simpler rule to test problems with conditions on parent rule (merge_SameRootSubj_sameObjRel)*/
excluded Sem<=>ASem merge : merge_SameRootSubj_sameObjRel
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:?s1-> c:?Z1l {}
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:sem = ?semX2
        c:?s2-> c:?Z2l {}
      }
    }
  }
}

?semX1 == ?semX2
?s1 == ?s2

// the roots both have the same modality or none at this point
( ( c:?X1l { ¬c:modality = ?m1 } & c:?X2l { ¬c:modality = ?m2 } )
  | ( c:?X1l { c:modality = ?mod1 } & c:?X2l { c:modality = ?mod2 } & ?mod1 == ?mod2 ) )
  
 //?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:?X3l { c:sem = ?semX3 c:?s3-> c:?Z3l {} } } }
    & ?semX3 == ?semX2 & ?s3 == ?s2
    // next condition gives a bug, fix this later
    & ( ( c:?X3l { ¬c:modality = ?m3 } & c:?X2l { ¬c:modality = ?m2 } )
      | ( c:?X3l { c:modality = ?attribute3 } ))
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
)
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  merge-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X2r {
  rc:<=> ?X2l
  blocked = "yes"
}

rc:?Z1r {
  rc:<=> ?Z1l
  attach_coord = "yes"
}

rc:?X1r {
  rc:<=> ?X1l
  agg_trig = "yes"
}
  ]
]

/*Originally for beAWARE*/
Sem<=>ASem merge_SameRootLoc_noOtherDep : beAWARE
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:Location-> c:?Y1l {
        c:sem = ?semY1
      }
      ¬c:?s1-> c:?Z1l {}
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:sem = ?semX2
        c:Location-> c:?Y2l {
          c:sem = ?semY2
        }
        ¬c:?s2-> c:?Z2l {}
      }
    }
  }
}

project_info.project.gen_type.D2T

// the property and the Location  are the same
?semX1 == ?semX2
?semY1 == ?semY2

//Both Xs are roots
¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }
  
// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:?X3l { c:sem = ?semX3 c:?r3-> c:?Y3l { c:sem = ?semY3 }  ¬c:?s3-> c:?Z3l {} } } }
    & ¬c:?Gov8l { c:?r8-> c:?X3l {} }
    & ?semX3 == ?semX2 & ?semY3 == ?semY2
    // next condition gives a bug, fix this later
//    & ( ( c:?Z3l { ¬c:subcat_prep = ?a3 } & c:?Z2l { ¬c:subcat_prep = ?a23 } )
//      | ( c:?Z3l { c:subcat_prep = ?scZ3 } & c:?Z2l { c:subcat_prep = ?scZ23 } & ?scZ3 == ?scZ23 ) )
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
)
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  mergeRootCoord-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X2r {
  rc:<=> ?X2l
  blocked = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  blocked = "yes"
}

rc:?X1r {
  rc:<=> ?X1l
  agg_trig = "yes"
}

rc:?Y1r {
  rc:<=> ?Y1l
  agg_trig = "yes"
}
  ]
]

/*Same property, same argument slot, same dependent.*/
Sem<=>ASem merge_SameRoot_sameUniqueArg_NPerSentence : CONNEXIONs
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:?r-> c:?Y1l {
        c:sem = ?semY1
        c:NonCore-> c:?Z1al { c:sem = ?semZ1a }
        c:A2-> c:?Z1bl {}
      }
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:sem = ?semX2
        c:?s-> c:?Y2l {
          c:sem = ?semY2
          c:NonCore-> c:?Z2al { c:sem = ?semZ2a }
          c:A2-> c:?Z2bl {}
        }
      }
    }
  }
}

// see merge_SameRoot_sameUniqueLocRel
¬ ?r == Location

project_info.project.name.CONNEXIONs

// the property is the same, the relation and the dependent too
?semX1 == ?semX2
?semY1 == ?semY2
?semZ1a == ?semZ2a
?r == ?s
// Store here meanings that will give similar constructions
?semY1 == "number_count"

// There's a "per"
c:?Per1l { c:sem = "per" c:A1-> c:?Z1bl {} c:A2-> c:?Ref1l { c:sem = ?semRef1 } }
c:?Per2l { c:sem = "per" c:A1-> c:?Z2bl {} c:A2-> c:?Ref2l { c:sem = ?semRef2 } }
?semRef1 == ?semRef2

//Both Xs are roots
¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:?X3l { c:sem = ?semX3 c:?r3-> c:?Y3l { c:sem = ?semY3 c:NonCore-> c:?Z3al { c:sem = ?semZ3a } c:A2-> c:?Z3bl {} } } } }
    & c:?Per3l { c:sem = "per" c:A1-> c:?Z3bl {} c:A2-> c:?Ref3l { c:sem = ?semRef3 } }
    & ?semRef3 == ?semRef2
    & ¬c:?Gov8l { c:?r8-> c:?X3l {} }
    & ?semX3 == ?semX2 & ?semY3 == ?semY2 & ?semZ3a == ?semZ2a
    & ?r3 == ?r
    // next condition gives a bug, fix this later
//    & ( ( c:?Z3l { ¬c:subcat_prep = ?a3 } & c:?Z2l { ¬c:subcat_prep = ?a23 } )
//      | ( c:?Z3l { c:subcat_prep = ?scZ3 } & c:?Z2l { c:subcat_prep = ?scZ23 } & ?scZ3 == ?scZ23 ) )
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
)
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  mergeRootSubjCoord-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X2r {
  rc:<=> ?X2l
  blocked = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  blocked = "yes"
}

rc:?Z2ar {
  rc:<=> ?Z2al
  blocked = "yes"
}

rc:?Per2r {
  rc:<=> ?Per2l
  blocked = "yes"
}

rc:?Ref2r {
  rc:<=> ?Ref2l
  blocked = "yes"
}

rc:?Z1br {
  rc:<=> ?Z1bl
  attach_coord = "yes"
}

rc:?Y1r {
  rc:<=> ?Y1l
  agg_trig = "yes"
}

rc:?Per1r {
  rc:<=> ?Per1l
  agg_trig = "yes"
  coord_type = "shared_dep"
}
  ]
]

/*If there is a mention of the type of establishment (eatType), move the priceRange to it.*/
Sem<=>ASem merge_eatType_priceRange : E2E
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      ( c:sem = "restaurant" | c:sem = "pub" | c:sem = "coffee_shop" )
      c:A1-> c:?Y1l {
        c:sem = ?semY1
      }
    }
    c:*b-> c:?S2l {
      c:?X2l {
        ( c:sem = "cheap" | c:sem = "expensive" | c:sem = "low-priced" | c:sem = "mid-priced" | c:sem = "average-priced" | c:sem = "high-priced" | c:sem = "moderately priced" )
        c:A1-> c:?Y2l {
          c:sem = ?semY2
        }
      }
    }
  }
}

// the subjects are the same
?semY1 == ?semY2
// X2 is the root in its bubble
¬c:?GovX2l { c:?rgovX2-> c:?X2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  merge_eatType-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X1r {
  rc:<=> ?X1l
  eatType_anchor = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  blocked = "yes"
}
  ]
]

/*Merge family-friendly=yes with the type of establishment.
Applies if there is no priceRange, which aggregates with priority.*/
Sem<=>ASem merge_eatType_familyFriendly : E2E
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      ( c:sem = "restaurant" | c:sem = "pub" | c:sem = "coffee_shop" )
      c:A1-> c:?Y1l {
        c:sem = ?semY1
      }
    }
    c:*b-> c:?S2l {
      c:?X2l {
        ( c:sem = "family-friendly" | c:sem = "child-friendly" | c:sem = "kid-friendly" )
        c:A1-> c:?Y2l {
          c:sem = ?semY2
        }
      }
    }
  }
  ¬c:?S3l {
    c:priceRange = "yes"
  }
}

// the subjects are the same
?semY1 == ?semY2
// X2 is the root in its bubble
¬c:?GovX2l { c:?rgovX2-> c:?X2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  merge_eatType-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X1r {
  rc:<=> ?X1l
  eatType_anchor = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  blocked = "yes"
}
  ]
]

/*Merge food with eatType when there is also priceRange or family-friendly=yes, or if there is no other property at all.*/
Sem<=>ASem merge_eatType_food : E2E
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      ( c:sem = "restaurant" | c:sem = "pub" | c:sem = "coffee_shop" )
      c:A1-> c:?Y1l {
        c:sem = ?semY1
      }
    }
    c:*b-> c:?S2l {
      c:?X2l {
        ( c:sem = "food" | c:sem = "meal" | c:sem = "course" | c:sem = "cuisine" )
      }
      c:?Y2l {
        c:sem = ?semY2
      }
    }
  }
  ( c:?S3l { c:priceRange = "yes" } | c:?S4l {  c:?X4l { ( c:sem = "family-friendly" | c:sem = "child-friendly" | c:sem = "kid-friendly" ) } }
    | (
      ¬c:?S5l {
        c:priceRange = "yes"
      }
      ¬c:?S6l {
        c:familyFriendly = "yes"
        c:?FamL { ( c:sem = "family-friendly" | c:sem = "child-friendly" | c:sem = "kid-friendly" ) }
      }
      ¬c:?S7l {
        c:area = "yes"
      }
      ¬c:?S8l {
        c:near = "yes"
     }
      ¬ c:?S9l {
          c:customerRating = "yes"
      }
    )
  )
}

// the subjects are the same
?semY1 == ?semY2
// X2 is the root in its bubble
¬c:?GovX1l { c:?rgovX1-> c:?X1l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  merge_eatType-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X1r {
  rc:<=> ?X1l
  eatType_anchor = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  blocked = "yes"
}
  ]
]

/*Merge family-friendly=yes with the type of establishment.
Applies if there is no priceRange, which aggregates with priority.*/
Sem<=>ASem merge_eatType_area : E2E
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      ( c:sem = "restaurant" | c:sem = "pub" | c:sem = "coffee_shop" )
      c:A1-> c:?Y1l {
        c:sem = ?semY1
      }
    }
    c:*b-> c:?S2l {
      c:area = "yes"
      c:?X2l {
        c:?r-> c:?Y2l {
          c:sem = ?semY2
        }
      }
    }
  }
  ¬c:?S3l {
    c:priceRange = "yes"
  }
  ¬c:?S4l {
    c:familyFriendly = "yes"
    c:?FamL { ( c:sem = "family-friendly" | c:sem = "child-friendly" | c:sem = "kid-friendly" ) }
  }
}

// the subjects are the same
?semY1 == ?semY2
// X2 is the root in its bubble
¬c:?GovX2l { c:?rgovX2-> c:?X2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  merge_eatType-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X1r {
  rc:<=> ?X1l
  eatType_anchor = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  blocked = "yes"
}
  ]
]

/*Merge family-friendly=yes with the type of establishment.
Applies if there is no priceRange, which aggregates with priority.*/
Sem<=>ASem merge_eatType_near : E2E
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      ( c:sem = "restaurant" | c:sem = "pub" | c:sem = "coffee_shop" )
      c:A1-> c:?Y1l {
        c:sem = ?semY1
      }
    }
    c:*b-> c:?S2l {
      c:near = "yes"
      c:?X2l {
        c:?r-> c:?Y2l {
          c:sem = ?semY2
        }
      }
    }
  }
  ¬c:?S3l {
    c:priceRange = "yes"
  }
  ¬c:?S4l {
    c:familyFriendly = "yes"
    c:?FamL { ( c:sem = "family-friendly" | c:sem = "child-friendly" | c:sem = "kid-friendly" ) }
  }
  ¬c:?S5l {
    c:area = "yes"
  }
}

// the subjects are the same
?semY1 == ?semY2
// X2 is the root in its bubble
¬c:?GovX2l { c:?rgovX2-> c:?X2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  merge_eatType-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X1r {
  rc:<=> ?X1l
  eatType_anchor = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  blocked = "yes"
}
  ]
]

/*Merge family-friendly=yes with the type of establishment.
Applies if there is no priceRange, which aggregates with priority.*/
Sem<=>ASem merge_eatType_customerRating : E2E
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      ( c:sem = "restaurant" | c:sem = "pub" | c:sem = "coffee_shop" )
      c:A1-> c:?Y1l {
        c:sem = ?semY1
      }
    }
    c:*b-> c:?S2l {
      c:customerRating = "yes"
      c:?X2l {
        c:?r-> c:?Y2l {
          c:sem = ?semY2
        }
      }
    }
  }
  ¬c:?S3l {
    c:priceRange = "yes"
  }
  ¬c:?S4l {
    c:familyFriendly = "yes"
    c:?FamL { ( c:sem = "family-friendly" | c:sem = "child-friendly" | c:sem = "kid-friendly" ) }
  }
  ¬c:?S5l {
    c:area = "yes"
  }
  ¬c:?S6l {
    c:near = "yes"
  }
}

// the subjects are the same
?semY1 == ?semY2
// X2 is the root in its bubble
¬c:?GovX2l { c:?rgovX2-> c:?X2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  merge_eatType-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X1r {
  rc:<=> ?X1l
  eatType_anchor = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  blocked = "yes"
}
  ]
]

/*Merge area and near together, if either priceRange or familyFriendly are in the text (aggregated with eatType in priority).*/
Sem<=>ASem merge_area_near : E2E
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:area = "yes"
    c:?X1l {
      c:?r1-> c:?Y1l {
        c:sem = ?semY1
      }
      c:?s1-> c:?Z1l {}
    }
    c:*b-> c:?S2l {
      c:near = "yes"
      c:?X2l {
        c:?r2-> c:?Y2l {
          c:sem = ?semY2
        }
      }
    }
  }
  ( c:?S3l { c:priceRange = "yes" }
    | c:?S4l { c:familyFriendly = "yes" c:?FamL { ( c:sem = "family-friendly" | c:sem = "child-friendly" | c:sem = "kid-friendly" ) } }
  )
}

// the subjects are the same
?semY1 == ?semY2
// X1 and X2 are the roots in their respective bubble
¬c:?GovX1l { c:?rgovX1-> c:?X1l {} }
¬c:?GovX2l { c:?rgovX2-> c:?X2l {} }
// see merge_RS rules (area and near can have the same lexicalization "locate")
¬ ?X1l.sem == ?X2l.sem

// choose last argument for aggregation
( ?s1 == A3 | ( ?s1 == A2 & c:?X1l { ¬c:A3-> c:?Dep1l {} } ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  merge_near_area-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?Z1r {
  rc:<=> ?Z1l
  near_area_anchor = "yes"
}

rc:?X1r {
  rc:<=> ?X1l
  near_area_coord_anchor = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  blocked = "yes"
}
  ]
]

/*If there is no mention of the type of establishment (eatType), but there is the food type, move the priceRange to it.*/
Sem<=>ASem merge_food_priceRange : E2E
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      ( c:sem = "food" | c:sem = "meal" | c:sem = "course" | c:sem = "cuisine" )
    }
    c:?Y1l {
      c:sem = ?semY1
    }
    c:*b-> c:?S2l {
      c:?X2l {
        ( c:sem = "cheap" | c:sem = "expensive" | c:sem = "low-priced" | c:sem = "mid-priced" | c:sem = "average-priced" | c:sem = "high-priced" | c:sem = "moderately priced" )
        c:A1-> c:?Y2l {
          c:sem = ?semY2
        }
      }
    }
  }
}


¬ ( c:?Tl { c:?S3l { c:?X3l { ( c:sem = "restaurant" | c:sem = "pub" | c:sem = "coffee_shop" ) c:A1-> c:?Y3l { c:sem = ?semY3 } } } } & ?semY3 == ?semY1 )
// the subjects are the same
?semY1 == ?semY2
// X2 is the root in its bubble
¬c:?GovX2l { c:?rgovX2-> c:?X2l {} }

// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S4l { c:id = ?id4 c:?X4l { ( c:sem = "food" | c:sem = "meal" | c:sem = "course" | c:sem = "cuisine" ) } c:?Y4l { c:sem = ?semY4 } } }
    & ?semY4 == ?semY2 & c:?S1l { c:id = ?id1 } & ?id4 < ?id1
)
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  merge_eatType-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X1r {
  rc:<=> ?X1l
  eatType_anchor = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  blocked = "yes"
}
  ]
]

Sem<=>ASem merge_roomParameters : MindSpaces
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:roomParameter = "yes"
    c:?X1l {
      ( c:sem = "light" | c:dpos = "JJ" )
      //c:A1-> c:?Y1l {
        //c:sem = ?semY1
      //}
    }
    c:*b-> c:?S2l {
      c:roomParameter = "yes"
      c:?X2l {
        ( c:sem = "light" | c:dpos = "JJ" )
        //c:A1-> c:?Y2l {
          //c:sem = ?semY2
        //}
      }
    }
  }
}

// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:roomParameter = "yes" c:id = ?id3 c:?X3l { ( c:sem = "light" | c:dpos = "JJ" ) } } }
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
)
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  noMergeCoord-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X1r {
  rc:<=> ?X1l
  attach_coord = "yes"
}
  ]
]

/*MindSpaces*/
excluded Sem<=>ASem merge_emotion_changeParameter : MindSpaces
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:subjectEmotion = "yes"
    c:?X1l {
      c:sem = "feel"
      //c:A1-> c:?Y1l {
        //c:sem = ?semY1
      //}
    }
    c:*b-> c:?S2l {
      c:parameterChange = "yes"
      c:?X2l {
        c:sem = "change"
        //c:A1-> c:?Y2l {
          //c:sem = ?semY2
        //}
      }
    }
  }
}

// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:subjectEmotion = "yes" c:id = ?id3 c:?X3l { c:sem = "feel" } } }
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
)
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  noMergeCoord-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X1r {
  rc:<=> ?X1l
  attach_coord = "yes"
}
  ]
]

Sem<=>ASem merge_changeParameter : MindSpaces
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:parameterChange = "yes"
    c:?X1l {
      c:tense = ?tc1
      //c:A1-> c:?Y1l {
        //c:sem = ?semY1
      //}
    }
    c:*b-> c:?S2l {
      c:parameterChange = "yes"
      c:?X2l {
        c:tense = ?tc2
        //c:A1-> c:?Y2l {
          //c:sem = ?semY2
        //}
      }
    }
  }
}

// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:parameterChange = "yes" c:id = ?id3 c:?X3l { c:tense = ?tc3 } } }
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
)
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  noMergeCoord-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X1r {
  rc:<=> ?X1l
  attach_coord = "yes"
}
  ]
]

/*If there is a mention of the type of establishment (eatType), move the priceRange to it.*/
Sem<=>ASem merge_Style_Date1 : V4Design
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:A1-> c:?Y1l {

        c:variable_class = "Style"
      }
      c:A2-> c:?Z1l {
        c:sem = ?semZ1
      }
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:sem = ?semX2
        c:Time-> c:?Y2l {
          c:variable_class = "DateStart"
        }
        c:A2-> c:?Z2l {
            c:sem = ?semZ2
        }
      }
    }
  }
}

// The roots are not the same (generic rules would apply)
¬?semX1 == ?semX2

// the buildings are the same
?semZ1 == ?semZ2
// X2 is the root in its bubble
¬c:?GovX2l { c:?rgovX2-> c:?X2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  rc:?Z2r {
    rc:<=> ?Z2l
    blocked = "yes"
  }
  mergeObjProgress-> rc:?S1r {
    rc:<=> ?S1l
    //rc:?X2r {}
    //rc:id = ?id1
    //¬rc:mergeObjProgress-> rc:?S3r {}
    //¬rc:mergeSubjProgress-> rc:?S4r {}
  }
}

// So the rule only applies once in case of multiple possible merges.
¬rc:?Tr { rc:?S2r { rc:mergeObjProgress-> rc:?S3r { rc:*b-> rc:?S1r {} } } }
  ]
]

/*If there is a mention of the type of establishment (eatType), move the priceRange to it.*/
Sem<=>ASem merge_Style_Date2 : V4Design
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:Time-> c:?Y1l {

        c:variable_class = "DateStart"
      }
      c:A2-> c:?Z1l {
          c:sem = ?semZ1
      }
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:sem = ?semX2
        c:A1-> c:?Y2l {
          c:variable_class = "Style"
        }
        c:A2-> c:?Z2l {
          c:sem = ?semZ2
        }
      }
    }
  }
}

// The roots are not the same (generic rules would apply)
¬?semX1 == ?semX2

// the buildings are the same
?semZ1 == ?semZ2
// X2 is the root in its bubble
¬c:?GovX2l { c:?rgovX2-> c:?X2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  rc:?Z2r {
    rc:<=> ?Z2l
    blocked = "yes"
  }
  mergeObjProgress-> rc:?S1r {
    rc:<=> ?S1l
    //rc:?X2r {}
    //rc:id = ?id1
    //¬rc:mergeObjProgress-> rc:?S3r {}
    //¬rc:mergeSubjProgress-> rc:?S4r {}
  }
}

// So the rule only applies once in case of multiple possible merges.
¬rc:?Tr { rc:?S2r { rc:mergeObjProgress-> rc:?S3r { rc:*b-> rc:?S1r {} } } }
  ]
]

/*If there is a mention of the type of establishment (eatType), move the priceRange to it.*/
Sem<=>ASem merge_Style_DateStart1 : V4Design
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:A1-> c:?Y1l {

        c:variable_class = "Style"
      }
      c:A2-> c:?Z1l {
        c:sem = ?semZ1
      }
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:sem = ?semX2
        c:Time-> c:?Y2l {
          c:variable_class = "DateStart"
        }
        c:A1-> c:?B2l {
          c:sem = "construction"
          c:A2-> c:?Z2l {
            c:sem = ?semZ2
          }
        }
      }
    }
  }
}

// The roots are not the same (generic rules would apply)
¬?semX1 == ?semX2

// the buildings are the same
?semZ1 == ?semZ2
// X2 is the root in its bubble
¬c:?GovX2l { c:?rgovX2-> c:?X2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  rc:?Z2r {
    rc:<=> ?Z2l
    blocked = "yes"
  }
  mergeObjProgress-> rc:?S1r {
    rc:<=> ?S1l
    //rc:?X2r {}
    //rc:id = ?id1
    //¬rc:mergeObjProgress-> rc:?S3r {}
    //¬rc:mergeSubjProgress-> rc:?S4r {}
  }
}

// So the rule only applies once in case of multiple possible merges.
¬rc:?Tr { rc:?S2r { rc:mergeObjProgress-> rc:?S3r { rc:*b-> rc:?S1r {} } } }
  ]
]

/*If there is a mention of the type of establishment (eatType), move the priceRange to it.*/
Sem<=>ASem merge_Style_DateStart2 : V4Design
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:Time-> c:?Y1l {

        c:variable_class = "DateStart"
      }
      c:A1-> c:?B1l {
        c:sem = "construction"
        c:A2-> c:?Z1l {
          c:sem = ?semZ1
        }
      }
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:sem = ?semX2
        c:A1-> c:?Y2l {
          c:variable_class = "Style"
        }
        c:A2-> c:?Z2l {
          c:sem = ?semZ2
        }
      }
    }
  }
}

// The roots are not the same (generic rules would apply)
¬?semX1 == ?semX2

// the buildings are the same
?semZ1 == ?semZ2
// X2 is the root in its bubble
¬c:?GovX2l { c:?rgovX2-> c:?X2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  rc:?Z2r {
    rc:<=> ?Z2l
    blocked = "yes"
  }
  mergeObjProgress-> rc:?S1r {
    rc:<=> ?S1l
    //rc:?X2r {}
    //rc:id = ?id1
    //¬rc:mergeObjProgress-> rc:?S3r {}
    //¬rc:mergeSubjProgress-> rc:?S4r {}
  }
}

// So the rule only applies once in case of multiple possible merges.
¬rc:?Tr { rc:?S2r { rc:mergeObjProgress-> rc:?S3r { rc:*b-> rc:?S1r {} } } }
  ]
]

/*If there is a mention of the type of establishment (eatType), move the priceRange to it.*/
Sem<=>ASem merge_Style_DateStart_DateEnd_build : V4Design
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:sem = "build"
      c:Time-> c:?Y1l {

        c:variable_class = "DateStart"
      }
      c:A2-> c:?Z1l {
        c:sem = ?semZ1
      }
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:sem = "complete"
        c:A3-> c:?Y2l {
          c:variable_class = "DateEnd"
        }
        c:A2-> c:?Z2l {
          c:sem = ?semZ2
        }
      }
    }
  }
}

// The roots are not the same (generic rules would apply)
//¬?semX1 == ?semX2

// the buildings are the same
?semZ1 == ?semZ2
// X2 is the root in its bubble
¬c:?GovX2l { c:?rgovX2-> c:?X2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  rc:?Z2r {
    rc:<=> ?Z2l
    blocked = "yes"
  }
  rc:?X2r {
    rc:<=> ?X2l
    blocked = "yes"
  }
  mergeDateStartEnd-> rc:?S1r {
    rc:<=> ?S1l
    //rc:?X2r {}
    //rc:id = ?id1
    //¬rc:mergeObjProgress-> rc:?S3r {}
    //¬rc:mergeSubjProgress-> rc:?S4r {}
  }
}

// So the rule only applies once in case of multiple possible merges.
//¬rc:?Tr { rc:?S2r { rc:mergeObjProgress-> rc:?S3r { rc:*b-> rc:?S1r {} } } }
  ]
]

/*If there is a mention of the type of establishment (eatType), move the priceRange to it.*/
Sem<=>ASem merge_Style_DateStart_DateEnd_review : V4Design
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:sem = "review"
      c:Time-> c:?Y1l {

        c:variable_class = "DateStart"
      }
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:sem = "review"
        c:Time-> c:?Y2l {
          c:variable_class = "DateEnd"
        }
      }
    }
  }
}

// The roots are not the same (generic rules would apply)
//¬?semX1 == ?semX2

// X2 is the root in its bubble
¬c:?GovX2l { c:?rgovX2-> c:?X2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  rc:?X2r {
    rc:<=> ?X2l
    blocked = "yes"
  }
  mergeDateStartEnd-> rc:?S1r {
    rc:<=> ?S1l
    //rc:?X2r {}
    //rc:id = ?id1
    //¬rc:mergeObjProgress-> rc:?S3r {}
    //¬rc:mergeSubjProgress-> rc:?S4r {}
  }
}

// So the rule only applies once in case of multiple possible merges.
//¬rc:?Tr { rc:?S2r { rc:mergeObjProgress-> rc:?S3r { rc:*b-> rc:?S1r {} } } }
  ]
]

/*If there is a mention of the type of establishment (eatType), move the priceRange to it.*/
Sem<=>ASem merge_Style_DateStart_DateEnd_construction : V4Design
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:sem = "begin"
      c:Time-> c:?Y1l {

        c:variable_class = "DateStart"
      }
      c:A1-> c:?B1l {
        c:sem = "construction"
        c:A2-> c:?Z1l {
          c:sem = ?semZ1
        }
      }
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:sem = "complete"
        c:A3-> c:?Y2l {
          c:variable_class = "DateEnd"
        }
        c:A2-> c:?Z2l {
          c:sem = ?semZ2
        }
      }
    }
  }
}

// The roots are not the same (generic rules would apply)
//¬?semX1 == ?semX2

// the buildings are the same
?semZ1 == ?semZ2
// X2 is the root in its bubble
¬c:?GovX2l { c:?rgovX2-> c:?X2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  rc:?Z2r {
    rc:<=> ?Z2l
    blocked = "yes"
  }
  rc:?X2r {
    rc:<=> ?X2l
    blocked = "yes"
  }
  mergeDateStartEnd2-> rc:?S1r {
    rc:<=> ?S1l
    rc:?B1r {
      rc:<=> ?B1l
      blocked = "yes"
    }
    //rc:?X2r {}
    //rc:id = ?id1
    //¬rc:mergeObjProgress-> rc:?S3r {}
    //¬rc:mergeSubjProgress-> rc:?S4r {}
  }
}

// So the rule only applies once in case of multiple possible merges.
//¬rc:?Tr { rc:?S2r { rc:mergeObjProgress-> rc:?S3r { rc:*b-> rc:?S1r {} } } }
  ]
]

/*If there is a mention of the type of establishment (eatType), move the priceRange to it.*/
Sem<=>ASem merge_Creator_Style : V4Design
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:A1-> c:?Y1l {

        ( c:variable_class = "Style" | c:variable_class = "Creator" )
      }
      c:A2-> c:?Z1l {
        c:sem = ?semZ1
      }
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:sem = ?semX2
        c:A1-> c:?Y2l {
          ( c:variable_class = "Style" | c:variable_class = "Creator" )
        }
        c:A2-> c:?Z2l {
          c:sem = ?semZ2
        }
      }
    }
  }
}

 // There is no Date
¬ ( c:?Tl { c:?S3l { c:?X3l { c:A2-> c:?Z3l { c:sem = ?semZ3 } c:Time-> c:?Y3l { c:variable_class = "DateStart" } } } } 
    & ¬c:?GovX3l { c:?rgovX3-> c:?X3l {} } & ?semZ3 == ?semZ1
)
¬ ( c:?Tl { c:?S4l { c:?X4l { c:A1-> c:?B4 { c:A2-> c:?Z4l { c:sem = ?semZ4 } } c:Time-> c:?Y4l { c:variable_class = "DateStart" } } } } 
    & ¬c:?GovX4l { c:?rgovX4-> c:?X4l {} } & ?semZ4 == ?semZ1
)

// The roots are not the same (generic rules would apply)
¬?semX1 == ?semX2

// the buildings are the same
?semZ1 == ?semZ2
// X2 is the root in its bubble
¬c:?GovX2l { c:?rgovX2-> c:?X2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  rc:?Z2r {
    rc:<=> ?Z2l
    blocked = "yes"
  }
  mergeObjProgress-> rc:?S1r {
    rc:<=> ?S1l
    //rc:?X2r {}
    //rc:id = ?id1
    //¬rc:mergeObjProgress-> rc:?S3r {}
    //¬rc:mergeSubjProgress-> rc:?S4r {}
  }
}

// So the rule only applies once in case of multiple possible merges.
¬rc:?Tr { rc:?S2r { rc:mergeObjProgress-> rc:?S3r { rc:*b-> rc:?S1r {} } } }
  ]
]

Sem<=>ASem merge_HighestStartEnd : V4Design
[
  leftside = [
c:?Tl {
  c:?S1l {
     c:?Be1l {
      c:slex = "be"
      c:tense = ?tbe1
      c:A1-> c:?Name1l {
        c:variable_class = "Name"
        c:sem = ?semN1
      }
      c:A2-> c:?Building1l {}
    }
    c:*b-> c:?S2l {
      c:?Be2l {
        c:slex = "be"
        c:tense = ?tbe2
        c:A1-> c:?Name2l {
          c:variable_class = "Name"
          c:sem = ?semN2
        }
        c:A2-> c:?Building2l {}
      }
    }
  }
}

?semN1 == ?semN2

c:?H1l { c:sem = "highest" c:A1-> c:?Building1l {} }
c:?H2l { c:sem = "highest" c:A1-> c:?Building2l {} }

c:?Time1l { c:sem = "posteriority_time" c:A1-> c:?Be1l {} }
c:?Time2l { c:sem = "anteriority_time" c:A1-> c:?Be2l {} c:A2-> c:?Date2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  rc:?H2r {
    rc:<=> ?H2l
    blocked = "yes"
  }
  rc:?Be2r {
    rc:<=> ?Be2l
    blocked = "yes"
  }
  rc:?Building2r {
    rc:<=> ?Building2l
    blocked = "yes"
  }
  rc:?Name2r {
    rc:<=> ?Name2l
    blocked = "yes"
  }
  rc:?Time2r {
    rc:<=> ?Time2l
    blocked = "yes"
  }
  mergeHighestStartEnd-> rc:?S1r {
    rc:<=> ?S1l
    //rc:?X2r {}
    //rc:id = ?id1
    //¬rc:mergeObjProgress-> rc:?S3r {}
    //¬rc:mergeSubjProgress-> rc:?S4r {}
  }
}
  ]
]

/*Not tested*/
Sem<=>ASem merge_HighestStartEnd2 : V4Design
[
  leftside = [
c:?Tl {
  c:?S1l {
     c:?Be1l {
      c:slex = "be"
      c:tense = ?tbe1
      c:A1-> c:?Name1l {
        c:variable_class = "Name"
        c:sem = ?semN1
      }
      c:A2-> c:?Building1l {}
    }
    c:*b-> c:?S2l {
      c:?Be2l {
        c:slex = "be"
        c:tense = ?tbe2
        c:A1-> c:?Name2l {
          c:variable_class = "Name"
          c:sem = ?semN2
        }
        c:A2-> c:?Building2l {}
      }
    }
  }
}

?semN1 == ?semN2

c:?H1l { c:sem = "highest" c:A1-> c:?Building1l {} }
c:?H2l { c:sem = "highest" c:A1-> c:?Building2l {} }

c:?Time1l { c:sem = "anteriority_time" c:A1-> c:?Be1l {} }
c:?Time2l { c:sem = "posteriority_time" c:A1-> c:?Be2l {} c:A2-> c:?Date2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  rc:?H2r {
    rc:<=> ?H2l
    blocked = "yes"
  }
  rc:?Be2r {
    rc:<=> ?Be2l
    blocked = "yes"
  }
  rc:?Building2r {
    rc:<=> ?Building2l
    blocked = "yes"
  }
  rc:?Name2r {
    rc:<=> ?Name2l
    blocked = "yes"
  }
  rc:?Time2r {
    rc:<=> ?Time2l
    blocked = "yes"
  }
  mergeHighestStartEnd-> rc:?S1r {
    rc:<=> ?S1l
    //rc:?X2r {}
    //rc:id = ?id1
    //¬rc:mergeObjProgress-> rc:?S3r {}
    //¬rc:mergeSubjProgress-> rc:?S4r {}
  }
}
  ]
]

excluded Sem<=>ASem merge_HighestTimeRegion1 : V4Design
[
  leftside = [
c:?Tl {
  c:?S1l {
     c:?Be1l {
      c:slex = "be"
      c:tense = ?tbe1
      c:A1-> c:?Name1l {
        c:variable_class = "Name"
        c:sem = ?semN1
      }
      c:A2-> c:?Building1l {}
    }
    c:*b-> c:?S2l {
      c:?Be2l {
        c:slex = "be"
        c:tense = ?tbe2
        c:A1-> c:?Name2l {
          c:variable_class = "Name"
          c:sem = ?semN2
        }
        c:A2-> c:?Building2l {}
      }
    }
  }
}

?semN1 == ?semN2

c:?H1l { c:sem = "highest" c:A1-> c:?Building1l {} c:Location-> c:?Loc {} }
c:?H2l { c:sem = "highest" c:A1-> c:?Building2l {} }

c:?Time2l { c:sem = "posteriority_time" c:A1-> c:?Be2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  rc:?H2r {
    rc:<=> ?H2l
    blocked = "yes"
  }
  rc:?Be2r {
    rc:<=> ?Be2l
    blocked = "yes"
  }
  rc:?Building2r {
    rc:<=> ?Building2l
    blocked = "yes"
  }
  rc:?Name2r {
    rc:<=> ?Name2l
    blocked = "yes"
  }
  rc:?Time2r {
    rc:<=> ?Time2l
    blocked = "yes"
  }
  mergeHighestTimeRegion-> rc:?S1r {
    rc:<=> ?S1l
    //rc:?X2r {}
    //rc:id = ?id1
    //¬rc:mergeObjProgress-> rc:?S3r {}
    //¬rc:mergeSubjProgress-> rc:?S4r {}
  }
}
  ]
]

/*For bubbles that have the same property and subject, and  both have an object with the same relation (e.g. located north of X 7 south of Y )
Variant of RootSubj_sameObj but the subcat preps are not necessarily the same.*/
Sem<=>ASem merge_SameRootSubj_sameObjRel_Elab_Scene : V4Design
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:?r1-> c:?Y1l {
        c:sem = ?semY1
      }
      c:?s1-> c:?Z1l {
        c:variable_class = "Name"
      }
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:sem = ?semX2
        c:?r2-> c:?Y2l {
          c:sem = ?semY2
        }
        c:?s2-> c:?Z2l {
          c:variable_class = "Scene"
        }
      }
    }
  }
}
// restrict to subjects for now
?r1 == ?r2
( ?r1 == A0 | ( ?r1 == A1 & c:?X1l { ¬c:A0-> c:?K1l {} } )
 | ( ?r1 == A2 & c:?X1l { ¬c:A0-> c:?A1l {} ¬c:A1-> c:?B1l {} } ) )
// the property and the subject are the same
?semX1 == ?semX2
?semY1 == ?semY2

// the objects of the property have the same relation
?s1 == ?s2

//Both Xs are roots
¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// the objects both have the same subcat prep or none at this point
( ( c:?Z1l { ¬c:subcat_prep = ?a1 } & c:?Z2l { ¬c:subcat_prep = ?a2 } )
  | ( c:?Z1l { c:subcat_prep = ?scZ1 } & c:?Z2l { c:subcat_prep = ?scZ2 } & ?scZ1 == ?scZ2 ) )

// There isn't a dependent on one of the arguments that is not on the dependent of the second sentence (to be improved)
¬ ( c:?Y1l { c:?r4-> c:?Dep4l { c:sem= ?semD4 } } & c:?Y2l { c:?r5-> c:?Dep5l { c:sem= ?semD5 } } & ( ¬?semD4 == ?semD5 | ¬?r4 == ?r5 ) )

// the verbs both have the same verbal tense or none at this point
( ( c:?X1l { ¬c:tense = ?t1 } & c:?X2l { ¬c:tense = ?t2 } )
  | ( c:?X1l { c:tense = ?tt1 } & c:?X2l { c:tense = ?tt2 } & ?tt1 == ?tt2 ) )
  
// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:?X3l { c:sem = ?semX3 c:?r3-> c:?Y3l { c:sem = ?semY3 }  c:?s3-> c:?Z3l {} } } }
    & ¬c:?Gov8l { c:?r8-> c:?X3l {} }
    & ?semX3 == ?semX2 & ?semY3 == ?semY2 & ?r3 == ?r2 & ?s3 == ?s2
    // next condition gives a bug, fix this later
//    & ( ( c:?Z3l { ¬c:subcat_prep = ?a3 } & c:?Z2l { ¬c:subcat_prep = ?a23 } )
//      | ( c:?Z3l { c:subcat_prep = ?scZ3 } & c:?Z2l { c:subcat_prep = ?scZ23 } & ?scZ3 == ?scZ23 ) )
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
)
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  mergeRootSubjElab-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X2r {
  rc:<=> ?X2l
  blocked = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  blocked = "yes"
}

rc:?Z1r {
  rc:<=> ?Z1l
  attach_elab = "yes"
}

rc:?X1r {
  rc:<=> ?X1l
  agg_trig = "yes"
}

rc:?Y1r {
  rc:<=> ?Y1l
  agg_trig = "yes"
}
  ]
]

/*Originally for xR4DRAMA: power outlet and parking onsite; road and river in the surroundings*/
Sem<=>ASem merge_SameLoc_sameUniqueRootRel : xR4DRAMA
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:Location-> c:?Y1l {
        c:sem = ?semY1
      }
      ¬c:?s1-> c:?Z1l {}
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:sem = ?semX2
        c:Location-> c:?Y2l {
          c:sem = ?semY2
        }
        ¬c:?s2-> c:?Z2l {}
      }
    }
  }
}

project_info.project.gen_type.D2T

// the property is the same, not the Location
¬?semX1 == ?semX2
?semY1 == ?semY2

//Both Xs are roots
¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }

// ?S2 is not invovled in another type of aggregation where the Loc is the same (see merge_SameRootLoc)
¬ ( c:?Tl { c:?S4l { c:?X4l { c:sem = ?semX4 c:Location-> c:?Y4l { c:sem = ?semY4 } ¬c:?s4-> c:?Z4l {} } c:*b-> c:?S2l { c:?X2l {} } } }
  & ?semX4 == ?semX2 & ?semY4 == ?semY2
  & ¬c:?Gov9l { c:?r9-> c:?X4l {} } & ¬c:?Gov10l { c:?r10-> c:?X2l {} }
)

// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:?X3l { c:sem = ?semX3 c:?r3-> c:?Y3l { c:sem = ?semY3 }  ¬c:?s3-> c:?Z3l {} } } }
    & ¬c:?Gov8l { c:?r8-> c:?X3l {} }
    & ¬?semX3 == ?semX2 & ?semY3 == ?semY2
    // next condition gives a bug, fix this later
//    & ( ( c:?Z3l { ¬c:subcat_prep = ?a3 } & c:?Z2l { ¬c:subcat_prep = ?a23 } )
//      | ( c:?Z3l { c:subcat_prep = ?scZ3 } & c:?Z2l { c:subcat_prep = ?scZ23 } & ?scZ3 == ?scZ23 ) )
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
)

//If locations have classes, it can be Region, Country, City, etc. Other aggregation rules apply.
¬ ( c:?X1l { c:NE = "YES" } & c:?X2l { c:NE = "YES" } )
//¬ ( c:?Y1l { c:class = ?c1 } & c:?Y2l { c:class = ?c2 } )
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  mergeLocCoord-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?Y2r {
  rc:<=> ?Y2l
  blocked = "yes"
}

rc:?X1r {
  rc:<=> ?X1l
  attach_coord = "yes"
}

rc:?Y1r {
  rc:<=> ?Y1l
  agg_trig = "yes"
}
  ]
]

Sem<=>ASem merge_stressLevel : xR4DRAMA
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:sem = "detect"
      c:A2-> c:?Z1l {
        c:sem = "level"
        c:NonCore-> c:?Y1l {
          c:variable_class = "StressLevel"
        }
      }
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:variable_class = "StressLevelConfidence"
        c:A1-> c:?Y2l {
          c:sem = "confidence"
          c:?r2-> c:?Z2l {
            c:sem = "level"
            c:?s2-> c:?W2l {
              c:sem = "stress"
            }
          }
        }
      }
    }
  }
}


// X2 is the root in its bubble
¬c:?GovX2l { c:?rgovX2-> c:?X2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked = "yes"
  MergeElab-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X1r {
  rc:<=> ?X1l
  attach_elab = "yes"
}

rc:?Y2r {
  rc:<=> ?Y2l
  elab_anchor = "yes"
}

rc:?Z2r {
  rc:<=> ?Z2l
  blocked = "yes"
}

rc:?W2r {
  rc:<=> ?W2l
  blocked = "yes"
}
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

Sem<=>ASem attr_bubble_area : attr_E2E
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

Sem<=>ASem attr_bubble_customerRating : attr_E2E
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

Sem<=>ASem attr_bubble_eatType : attr_E2E
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

Sem<=>ASem attr_bubble_food : attr_E2E
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

Sem<=>ASem attr_bubble_name : attr_E2E
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

Sem<=>ASem attr_bubble_near : attr_E2E
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

Sem<=>ASem attr_bubble_priceRange : attr_E2E
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

Sem<=>ASem attr_roomParameter : attr_MindSpaces
[
  leftside = [
c:?Xl {
  roomParameter = "yes"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  roomParameter = "yes"
}
  ]
]

Sem<=>ASem attr_subjectEmotion : attr_MindSpaces
[
  leftside = [
c:?Xl {
  subjectEmotion = "yes"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  subjectEmotion = "yes"
}
  ]
]

Sem<=>ASem attr_parameterChange : attr_MindSpaces
[
  leftside = [
c:?Xl {
  parameterChange = "yes"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  parameterChange = "yes"
}
  ]
]

/*There may be an error on that rule: all coreferring nodes are expected to be marked with "coref_id", and this rule does not mark the initial node.*/
Sem<=>ASem attr_coref_room : attr_MindSpaces
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:roomParameter = "yes"
    c:?X1l {
      ( c:sem = "room" | c:sem = "wall" | c:sem = "ceiling" | c:sem = "light" | c:sem = "colour" | c:sem = "height" | c:sem = "shape" | c:sem = "subject" )
      c:id = ?id
      //c:A1-> c:?Y1l {
        //c:sem = ?semY1
      //}
    }
    c:*b-> c:?S2l {
      c:roomParameter = "yes"
      c:?X2l {
        ( c:sem = "room" | c:sem = "wall" | c:sem = "ceiling" | c:sem = "light" | c:sem = "colour" | c:sem = "height" | c:sem = "shape" | c:sem = "subject" )
        //c:A1-> c:?Y2l {
          //c:sem = ?semY2
        //}
      }
    }
  }
}

?X1l.sem == ?X2l.sem

// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:?X3l { ( c:sem = "room" | c:sem = "wall" | c:sem = "ceiling" | c:sem = "light" | c:sem = "colour" | c:sem = "height" | c:sem = "shape" ) } } }
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1 & ?X3l.sem == ?X1l.sem
)
  ]
  mixed = [

  ]
  rightside = [
rc:?X2r {
  rc:<=>?X2l
  coref_id = ?id
}
  ]
]

/*Mark initial mention of team or player*/
Sem<=>ASem attr_coref_player_team0 : Rotowire
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:id = ?id
      ( c:variable_class = "PlayerName" | c:variable_class = "TeamName" )
    }
  }
}

// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:*b-> c:?S1l {} c:id = ?id3 c:?X3l { c:sem = ?sx3 ( c:variable_class = "PlayerName" | c:variable_class = "TeamName" ) } } }
  & ?sx3 == ?X1l.sem
)
  ]
  mixed = [

  ]
  rightside = [
rc:?X1r {
  rc:<=>?X1l
  coref_id = ?id
}
  ]
]

/*On a large input (50 bubbles Rotowire), it seems to be ~ 0.3 sec faster to duplicate this rule in two (PlayerName and TeamName).*/
Sem<=>ASem attr_coref_player1 : Rotowire
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:variable_class = "PlayerName"
      c:id = ?id
      //c:A1-> c:?Y1l {
        //c:sem = ?semY1
      //}
    }
    c:*b-> c:?S2l {
      c:?X2l {
       c:variable_class = "PlayerName"
        //c:A1-> c:?Y2l {
          //c:sem = ?semY2
        //}
      }
    }
  }
}

?X1l.sem == ?X2l.sem

// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:?X3l { c:variable_class = "PlayerName" } } }
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1 & ?X3l.sem == ?X1l.sem
)
  ]
  mixed = [

  ]
  rightside = [
rc:?X2r {
  rc:<=>?X2l
  coref_id = ?id
}
  ]
]

Sem<=>ASem attr_coref_team2 : Rotowire
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:variable_class = "TeamName"
      c:id = ?id
      //c:A1-> c:?Y1l {
        //c:sem = ?semY1
      //}
    }
    c:*b-> c:?S2l {
      c:?X2l {
       c:variable_class = "TeamName"
        //c:A1-> c:?Y2l {
          //c:sem = ?semY2
        //}
      }
    }
  }
}

?X1l.sem == ?X2l.sem

// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:?X3l { c:variable_class = "TeamName" } } }
    & c:?S1l { c:id = ?id1 } & ?id3 < ?id1 & ?X3l.sem == ?X1l.sem
)
  ]
  mixed = [

  ]
  rightside = [
rc:?X2r {
  rc:<=>?X2l
  coref_id = ?id
}
  ]
]

