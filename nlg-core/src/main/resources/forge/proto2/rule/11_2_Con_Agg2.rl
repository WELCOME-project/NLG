Sem<=>ASem node_word
[
  leftside = [
?Xl {
  ( ¬c:blocked = "yes"
 | c:cancel_block = "yes" )
  sem = ?s
}

( ¬ ( c:?S2l { c:mergeHighestStartEnd-> c:?S1l { ?Xl {} } } & ?s == "posteriority_time" )
 | ( c:?S6l { c:mergeHighestStartEnd-> c:?S5l { ?Xl { c:blocked = "yes" } } } & ?s == "posteriority_time" ) )
 
( ¬ ( c:?S4l { c:mergeHighestStartEnd-> c:?S3l { ?Xl {} } } & ?s == "anteriority_time" )
 | ( c:?S8l { c:mergeHighestStartEnd-> c:?S7l { ?Xl { c:blocked = "yes" } } } & ?s == "anteriority_time" ) )
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

/*Ideally should check for a HighestEnd if there is no HighestStart*/
Sem<=>ASem node_add_region_highestBuilding
[
  leftside = [
c:?Tl {
  c:?Sl {
    c:?PT {
      c:A1-> c:?Be {
        c:A2-> c:?Building {}
      }
      c:A2-> c:?Xl {
        c:variable_class = "HighestStart"
      }
    }
    c:?Hl {
      c:A1-> c:?Building {}
    }
  }
  ¬c:?S2l {
    c:?X2l {
      c:variable_class = "HighestRegion"
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Sr {
  rc:?Hr {
    rc:<=> ?Hl
    Location-> ?LocR {
      sem = "world"
      slex = "world"
      definiteness = "DEF"
    }
  }
  ?LocR {}
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
  }
}
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
    id = #randInt()#
    Set-> rc:?Zr {
      rc:<=> ?Zl
      member = "A1"
      n = "1.0"
    }
  }
}
  ]
]

/*When a coordinating conjunction has to be added, but the anchor to the coord has moved bubble.*/
Sem<=>ASem introduce_coord_moved_bubble
[
  leftside = [
c:?S1l {
  c:blocked = "yes"
  ¬c:cancel_block = "yes"
  c:?Zl {
    attach_coord = "yes"
  }
  c:?r-> c:?S2l {}
}

¬?r == b
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  ?ConjR {
    sem = "and"
    slex = "and"
    pos = "CC"
    id = #randInt()#
    Set-> rc:?Zr {
      rc:<=> ?Zl
      member = "A1"
      n = "1.0"
    }
  }
  rc:+?Zr {
      rc:<=> ?Zl
  }
}
  ]
]

/*When a coordinating conjunction has to be added.*/
Sem<=>ASem attach_coord_top
[
  leftside = [
//c:?Sl {
  c:?Xl {
    ¬c:dpos = "CD"
    c:agg_trig = "yes"
    ?r-> c:?Zl {
      c:attach_coord = "yes"
    }
  }
//}
  ]
  mixed = [

  ]
  rightside = [
//rc:?Sr {
//  rc:<=> ?Sl
  rc:?Xr {
    rc:<=> ?Xl
    ?r-> rc:?ConjR {
      rc:Set-> rc:?Zr {
        rc:<=> ?Zl
        rc:member = "A1"
      }
    }
  }
//}
  ]
]

/*Transfers all dependency relations.*/
Sem<=>ASem rel_copy
[
  leftside = [
c:?Xl {
  ?r-> c: ?Yl {
    //¬c:attach_coord = "yes"
  }
}

// Try to remember why CD here
( ?Xl.dpos == "CD" | ¬?Xl.agg_trig == "yes" | c:?Yl { ¬c:attach_coord = "yes" } )


// In this case the Location will go on the coord conjunction
¬ ( ?Yl.agg_trig == "yes" & ¬?Xl.agg_trig == "yes" & ?r == Location )
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

/*Covers a case which is not covered by the main rule. I'm a bit scared to change the main rule for now.
200928_dev_3triples_en_utf8.conll structure51

Once the rule done I realised that it should not exist. Not erasing it yet just in case.*/
excluded Sem<=>ASem PATCH_rel_copy
[
  leftside = [
c:?S1l {
  c:?X1l {
    c:sem = ?sx1
    c:attach_coord = "yes"
    c:?ry1-> c:?Y1l { c:sem = ?sy1 }
    c:?rz1-> c:?Z1l {}
  }
  c:b-> c:?S2l {
    c:?X2l {
      c:sem = ?sx2
      // The combination of agg_trig and attach_coord for X2 and Z2 is what's not covered by the main transfer_rel rule
      c:agg_trig = "yes"
      c:?ry2-> c:?Y2l { c:sem = ?sy2 }
      c:?rz2-> c:?Z2l { c:attach_coord = "yes" }
    }
    c:noMergeCoord-> c:?S1l {}
    c:b-> c:?S3l {
      c:?X3l {
        c:sem = ?sx3
        c:blocked = "yes"
        c:?ry3-> c:?Y3l { c:sem = ?sy3 c:blocked = "yes" }
        c:?rz3-> c:?Z3l {}
      }
      c:noMergeCoord-> c:?S1l {}
      c:mergeRootSubjCoord-> c:?S2l {}
    }
  }
}

?sx1 == ?sx2
?sx1 == ?sx3
?sy1 == ?sy2
?sy1 == ?sy3
  ]
  mixed = [

  ]
  rightside = [
rc:?X2r {
  rc:<=> ?X2l
  ?rz2-> rc:?Z2r {
    rc:<=> ?Z2l
  }
}
  ]
]

Sem<=>ASem rel_Time_posteriority_merge
[
  leftside = [
c:?S2l {
  c:mergeHighestStartEnd-> c:?S1l {
    c:?Xl {
      c:sem = "posteriority_time"
      ¬c:blocked = "yes"
      A1-> c:?Bel {}
      A2-> c:?Timel {}
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Ber {
  rc:<=> ?Bel
  Time-> rc:?Timer {
    rc:<=> ?Timel
  }
}
  ]
]

/*Not tested.*/
Sem<=>ASem rel_Time_anteriority_merge
[
  leftside = [
c:?S2l {
  c:mergeHighestStartEnd-> c:?S1l {
    c:?Xl {
      c:sem = "anteriority_time"
      ¬c:blocked = "yes"
      A1-> c:?Bel {}
      A2-> c:?Timel {}
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Ber {
  rc:<=> ?Bel
  TimeEnd-> rc:?Timer {
    rc:<=> ?Timel
  }
}
  ]
]

/*Not tested.*/
Sem<=>ASem rel_Location_mergeLoc
[
  leftside = [
c:?S2l {
  ( c:blocked = "yes" & ¬c:cancel_block = "yes" )
  c:?X2l {
    Location-> c:?Y2l {
      c:sem = ?semY2
      ( c:blocked = "yes" & ¬c:cancel_block = "yes" )
    }
  }
  c:mergeLocCoord-> c:?S1l {
    c:?X1l {
      c:attach_coord = "yes"
      c:Location-> c:?Y1l {
        c:sem = ?semY1
      }
    }
  }
}

// the property and the subject are the same
?semY1 == ?semY2

// rule only applies once
¬ ( c:?S3l { c:id = ?idS3 c:mergeLocCoord-> c:?S1l {} } & c:?S2l { c:id = ?idS2 } & ?idS3 < ?idS2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?ConjR {
  rc:sem = "and"
  rc:Set-> rc:?X1r {
    rc:<=> ?X1l
  }
  Location-> rc:?Y1r {
    rc:<=> ?Y1l
  }
}
  ]
]

Sem<=>ASem add_rel_b_old
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:id = ?idS1
    ¬c:blocked = "yes"
    c:b-> c:?S4l {
      c:blocked = "yes"
      c:*b-> c:?S2l {
        c:id = ?idS2
        ¬c:blocked = "yes"
      }
    }
  }
}

¬ ( c:?Tl { c:?S3l { c:id = ?idS3 ¬c:blocked = "yes" } } & ?idS3 > ?idS1 & ?idS3 < ?idS2 )
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

Sem<=>ASem add_rel_b
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:id = ?idS1
    ( ¬c:blocked = "yes" | c:cancel_block = "yes" )
    c:b-> c:?S4l {
      ( c:blocked = "yes" & ¬c:cancel_block = "yes" )
      c:*b-> c:?S2l {
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

/*Not needed so far*/
Sem<=>DSynt bubble_expand_dep
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
Sem<=>DSynt bubble_expand_gov
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

Sem<=>ASem transfer_attribute
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>ASem merge
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>ASem markers
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

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

Sem<=>ASem attr_definiteness : transfer_attribute
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

Sem<=>ASem attr_definiteness_change : transfer_attribute
[
  leftside = [
c:?Xl {
  c:definiteness = ?def
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:definiteness = ?def
  rc:definiteness_change = ?dc
  definiteness = ?dc
}

¬ ?def == ?dc
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

excluded Sem<=>ASem attr_subcat_prep_change : transfer_attribute
[
  leftside = [
c:?Govl {
  c:id = ?iG
  c:?r-> c:?Xl {
    c:subcat_prep = ?tc
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?GovR {
  rc:id = ?iGR
  rc:?R-> rc:?Xr {
    rc:<=> ?Xl
    rc:subcat_prep = ?tc
    GovLex = "_new_"
  }
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

/*For cases in which the root of the two subtreees brought together point to one argument of the main predicate that triggered the aggregation.
E.g. in "please state your name" and "please state your surname", both 'name" and "surname" have as argument "you", which is the A1 of "state".

This rule may be too generic, we may want to restrict the cases of application (e.g. Y1l is a pronoun or a node without dependents).*/
Sem<=>ASem shared_dep_SameRootDep_sameOtherRel : merge
[
  leftside = [
c:?S2l {
  ( c:blocked = "yes" & ¬c:cancel_block = "yes" )
  c:?X2l {
    c:blocked = "yes"
    c:sem = ?semX2
    c:?r2-> c:?Y2l {
      c:sem = ?semY2
      c:blocked = "yes"
    }
    c:?s2-> c:?Z2l {
      ( ¬c:blocked = "yes" | c:cancel_block = "yes" )
      ?rZ2-> c:?Y2l {}
    }
  }
  c:?r-> c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:?r1-> c:?Y1l {
        c:sem = ?semY1
      }
      c:?s1-> c:?Z1l {
        c:attach_coord = "yes"
        c:?rZ1-> c:?Y1l {}
      }
    }
  }
}


?r1 == ?r2
// the property and the subject are the same
?semX1 == ?semX2
?semY1 == ?semY2

( ?r == mergeRootSubjCoord | ?r == mergeRootObjCoord )
  ]
  mixed = [

  ]
  rightside = [
rc:?Z2r {
  rc:<=> ?Z2l
  ?rZ2->   rc:?Y1r {
    rc:<=> ?Y1l
  }
}
  ]
]

/*For bubbles that have the same property but different objects (e.g. born + date; born + place )*/
Sem<=>ASem merge_SameRootSubj_differentObjRel : merge
[
  leftside = [
c:?S2l {
  ( blocked = "yes" & ¬c:cancel_block = "yes" )
  c:?X2l {
    blocked = "yes"
    c:sem = ?semX2
    c:?r2-> c:?Y2l {
      c:sem = ?semY2
      blocked = "yes"
    }
    c:?s2-> c:?Z2l {
      ( ¬c:blocked = "yes" | c:cancel_block = "yes" )
    }
  }
  mergeRootSubj-> c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:?r1-> c:?Y1l {
        c:sem = ?semY1
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

/*For bubbles that have the same property but different objects (e.g. born + date; born + place )*/
Sem<=>ASem merge_SameRootDep_sameOtherRel : merge
[
  leftside = [
c:?S2l {
  ( blocked = "yes" & ¬c:cancel_block = "yes" )
  c:?X2l {
    blocked = "yes"
    c:sem = ?semX2
    c:?r2-> c:?Y2l {
      c:sem = ?semY2
      blocked = "yes"
    }
    c:?s2-> c:?Z2l {
      ( ¬c:blocked = "yes" | c:cancel_block = "yes" )
    }
  }
  ?r-> c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:?r1-> c:?Y1l {
        c:sem = ?semY1
      }
      c:?s1-> c:?Z1l {
        c:attach_coord = "yes"
      }
    }
  }
}


?r1 == ?r2
// the property and the subject are the same
?semX1 == ?semX2
?semY1 == ?semY2

( ?r == mergeRootSubjCoord | ?r == mergeRootObjCoord )
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
  rc:?s2-> rc:?ConjR {
    rc:sem = "and"
    Set-> rc:?Z2r {
      rc:<=> ?Z2l
    }
  }
}
  ]
]

/*For bubbles that have the same property but different objects (e.g. born + date; born + place )*/
Sem<=>ASem merge_SameRootSubj_sameObjRel_Elab : merge
[
  leftside = [
c:?S2l {
  ( blocked = "yes" & ¬c:cancel_block = "yes" )
  c:?X2l {
    blocked = "yes"
    c:sem = ?semX2
    c:?r2-> c:?Y2l {
      c:sem = ?semY2
      blocked = "yes"
    }
    c:?s2-> c:?Z2l {
      ( ¬c:blocked = "yes" | c:cancel_block = "yes" )
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

/*For bubbles that have the same property but different objects (e.g. born + date; born + place )*/
Sem<=>ASem merge_SameRoot_sameUniqueArgRel : merge
[
  leftside = [
c:?S2l {
  // without c: gives overlap, not sure why
  ( blocked = "yes" & ¬c:cancel_block = "yes" )
  c:?X2l {
    // without c: gives overlap, not sure why
    ( blocked = "yes" & ¬c:cancel_block = "yes" )
    c:sem = ?semX2
    c:?r2-> c:?Y2l {
      c:sem = ?semY2
    }
  }
  mergeRootCoord-> c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:?r1-> c:?Y1l {
        c:sem = ?semY1
        c:attach_coord = "yes"
      }
    }
  }
}

?r1 == ?r2
// the property and the subject are the same
?semX1 == ?semX2
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  //rc:<=> ?S1l
  rc:?X1r {
    rc:<=> ?X1l
  }
  rc:+?Y2r {
    rc:<=> ?Y2l
  }
}

rc:?X1r {
  rc:<=> ?X1l
  rc:?s2-> rc:?ConjR {
    rc:sem = "and"
    Set-> rc:?Y2r {
      rc:<=> ?Y2l
    }
  }
}
  ]
]

/*For bubbles in which the roott share the same location.*/
Sem<=>ASem merge_SameLoc_sameUniqueRootRel : merge
[
  leftside = [
c:?S2l {
  // without c: gives overlap, not sure why
  ( blocked = "yes" & ¬c:cancel_block = "yes" )
  c:?X2l {
    c:Location-> c:?Y2l {
      c:sem = ?semY2
      ( blocked = "yes" & ¬c:cancel_block = "yes" )
    }
  }
  mergeLocCoord-> c:?S1l {
    c:?X1l {
      c:attach_coord = "yes"
      c:Location-> c:?Y1l {
        c:sem = ?semY1
      }
    }
  }
}

// the property and the subject are the same
?semY1 == ?semY2
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
  rc:Set-> rc:?X1r {
    rc:<=> ?X1l
  }
  Set-> rc:?X2r {
    rc:<=> ?X2l
  }
}
  ]
]

/*For bubbles that have the same property but different objects (e.g. born + date; born + place )*/
Sem<=>ASem noMerge_Coord : merge
[
  leftside = [
c:?S2l {
  ( blocked = "yes" & ¬c:cancel_block = "yes" )
  c:?X2l {
    c:sem = ?semX2
  }
  noMergeCoord-> c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:attach_coord = "yes"
    }
  }
  //¬c:?OtherMerge-> c:?S1l {}
}

// the property and the subject are the same
?semX1 == ?semX2

//Both Xs are roots
¬c:?Gov3l { c:?r3-> c:?X1l {} }
¬c:?Gov4l { c:?r4-> c:?X2l {} }

¬c:?S2l { c:mergeDateStartEnd-> c:?A1 {} }
¬c:?S2l { c:mergeDateStartEnd2-> c:?A2 {} }
¬c:?S2l { c:merge_eatType-> c:?A3 {} }
¬c:?S2l { c:mergeHighestStartEnd-> c:?A4 {} }
¬c:?S2l { c:mergeLocClass-> c:?A5 {} }
¬c:?S2l { c:mergeLocNE-> c:?A6 {} }
¬c:?S2l { c:merge_near_area-> c:?A7 {} }
¬c:?S2l { c:mergeObjProgress-> c:?A8 {} }
¬c:?S2l { c:mergeRootCoord-> c:?A9 {} }
¬c:?S2l { c:mergeRootObjCoord-> c:?A10 {} }
¬c:?S2l { c:mergeRootSubj-> c:?A11 {} }
¬c:?S2l { c:mergeRootSubjCoord-> c:?A12 {} }
¬c:?S2l { c:mergeRootSubjElab-> c:?A13 {} }
//¬c:?S2l { c:noMergeCoord-> c:?A14 {} }
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
  rc:Set-> rc:?X1r {
    rc:<=> ?X1l
  }
  Set-> rc:?X2r {
    rc:<=> ?X2l
  }
}
  ]
]

/*For bubbles that have the same property but different objects (e.g. born + date; born + place )*/
Sem<=>ASem noMerge_Coord_roomParameter : merge
[
  leftside = [
c:?S2l {
  ( blocked = "yes" & ¬c:cancel_block = "yes" )
  roomParameter = "yes"
  c:?X2l {
    ( c:sem = "light" | c:dpos = "JJ" )
  }
  noMergeCoord-> c:?S1l {
    roomParameter = "yes"
    c:?X1l {
      ( c:sem = "light" | c:dpos = "JJ" )
      c:attach_coord = "yes"
    }
  }
}

¬c:?S2l { c:mergeDateStartEnd-> c:?A1 {} }
¬c:?S2l { c:mergeDateStartEnd2-> c:?A2 {} }
¬c:?S2l { c:merge_eatType-> c:?A3 {} }
¬c:?S2l { c:mergeHighestStartEnd-> c:?A4 {} }
¬c:?S2l { c:mergeLocClass-> c:?A5 {} }
¬c:?S2l { c:mergeLocNE-> c:?A6 {} }
¬c:?S2l { c:merge_near_area-> c:?A7 {} }
¬c:?S2l { c:mergeObjProgress-> c:?A8 {} }
¬c:?S2l { c:mergeRootCoord-> c:?A9 {} }
¬c:?S2l { c:mergeRootObjCoord-> c:?A10 {} }
¬c:?S2l { c:mergeRootSubj-> c:?A11 {} }
¬c:?S2l { c:mergeRootSubjCoord-> c:?A12 {} }
¬c:?S2l { c:mergeRootSubjElab-> c:?A13 {} }
//¬c:?S2l { c:noMergeCoord-> c:?A14 {} }
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
  rc:Set-> rc:?X1r {
    rc:<=> ?X1l
  }
  Set-> rc:?X2r {
    rc:<=> ?X2l
  }
}
  ]
]

/*For bubbles that have the same property but different objects (e.g. born + date; born + place )*/
Sem<=>ASem noMerge_Coord_changeParameter : merge
[
  leftside = [
c:?S2l {
  ( blocked = "yes" & ¬c:cancel_block = "yes" )
  parameterChange = "yes"
  c:?X2l {
    c:tense = ?tc1
  }
  noMergeCoord-> c:?S1l {
    parameterChange = "yes"
    c:?X1l {
      c:attach_coord = "yes"
    }
  }
}

¬c:?S2l { c:mergeDateStartEnd-> c:?A1 {} }
¬c:?S2l { c:mergeDateStartEnd2-> c:?A2 {} }
¬c:?S2l { c:merge_eatType-> c:?A3 {} }
¬c:?S2l { c:mergeHighestStartEnd-> c:?A4 {} }
¬c:?S2l { c:mergeLocClass-> c:?A5 {} }
¬c:?S2l { c:mergeLocNE-> c:?A6 {} }
¬c:?S2l { c:merge_near_area-> c:?A7 {} }
¬c:?S2l { c:mergeObjProgress-> c:?A8 {} }
¬c:?S2l { c:mergeRootCoord-> c:?A9 {} }
¬c:?S2l { c:mergeRootObjCoord-> c:?A10 {} }
¬c:?S2l { c:mergeRootSubj-> c:?A11 {} }
¬c:?S2l { c:mergeRootSubjCoord-> c:?A12 {} }
¬c:?S2l { c:mergeRootSubjElab-> c:?A13 {} }
//¬c:?S2l { c:noMergeCoord-> c:?A14 {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  //rc:<=> ?S1l
  parameterChange = "yes"
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

/*For bubbles that have the same property but different objects (e.g. born + date; born + place )*/
Sem<=>ASem Merge_DateStartEnd : merge
[
  leftside = [
c:?S2l {
  ( blocked = "yes" & ¬c:cancel_block = "yes" )
  c:?X2l {
    c:sem = "complete"
    ( blocked = "yes" & ¬c:cancel_block = "yes" )
    c:A3-> c:?Y2l {
      c:variable_class = "DateEnd"
    }
    c:A2-> c:?Z2l {
      c:sem = ?semZ2
      ( blocked = "yes" & ¬c:cancel_block = "yes" )
     }
  }
  mergeDateStartEnd-> c:?S1l {
    c:?X1l {
      c:sem = "build"
      c:Time-> c:?Y1l {
        c:variable_class = "DateStart"
      }
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  //rc:<=> ?S1l
  rc:?X1r {
    rc:<=> ?X1l
    TimeEnd-> rc:?Y2r {
      rc:<=> ?Y2l
    }
  }
  rc:+?Y2r {
    rc:<=> ?Y2l
  }
}
  ]
]

/*For bubbles that have the same property but different objects (e.g. born + date; born + place )*/
Sem<=>ASem Merge_DateStartEnd2 : merge
[
  leftside = [
c:?S2l {
  ( blocked = "yes" & ¬c:cancel_block = "yes" )
  c:?X2l {
    c:sem = "complete"
    ( blocked = "yes" & ¬c:cancel_block = "yes" )
    c:A3-> c:?Y2l {
      c:variable_class = "DateEnd"
    }
    c:A2-> c:?Z2l {
      c:sem = ?semZ2
      ( blocked = "yes" & ¬c:cancel_block = "yes" )
     }
  }
  mergeDateStartEnd2-> c:?S1l {
    c:?X1l {
      c:sem = "begin"
      c:Time-> c:?Y1l {
        c:variable_class = "DateStart"
      }
      c:A1-> c:?B1l {
        c:sem = "construction"
        ( blocked = "yes" & ¬c:cancel_block = "yes" )
        c:A2-> c:?Z1l {
          c:sem = ?semZ1
        }
      }
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  //rc:<=> ?S1l
  rc:?X1r {
    rc:<=> ?X1l
    sem = "build"
    TimeEnd-> rc:?Y2r {
      rc:<=> ?Y2l
    }
    A2-> rc:?Z1r {
      rc:<=> ?Z1l
    }
  }
  rc:+?Y2r {
    rc:<=> ?Y2l
  }
}
  ]
]

/*For bubbles that have the same property but different objects (e.g. born + date; born + place )*/
Sem<=>ASem Merge_DateStartEndReview : merge
[
  leftside = [
c:?S2l {
  ( blocked = "yes" & ¬c:cancel_block = "yes" )
  c:?X2l {
    c:sem = "review"
    ( blocked = "yes" & ¬c:cancel_block = "yes" )
    c:Time-> c:?Y2l {
      c:variable_class = "DateEnd"
    }
  }
  mergeDateStartEnd-> c:?S1l {
    c:?X1l {
      c:sem = "review"
      c:Time-> c:?Y1l {
        c:variable_class = "DateStart"
      }
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  //rc:<=> ?S1l
  rc:?X1r {
    rc:<=> ?X1l
    TimeEnd-> rc:?Y2r {
      rc:<=> ?Y2l
    }
  }
  rc:+?Y2r {
    rc:<=> ?Y2l
  }
}
  ]
]

/*Keep sync with merge_ObjProg in Agg4 grammar.*/
Sem<=>ASem merge_HighestStartEnd1 : merge
[
  leftside = [
c:?Tl {
  c:?S2l {
     ( blocked = "yes" & ¬c:cancel_block = "yes" )
     c:?Be2l {
      c:slex = "be"
      ( blocked = "yes" & ¬c:cancel_block = "yes" )
      c:A1-> c:?Name2l {
        c:variable_class = "Name"
        ( blocked = "yes" & ¬c:cancel_block = "yes" )
        c:sem = ?semN2
      }
      c:A2-> c:?Building2l {
        ( blocked = "yes" & ¬c:cancel_block = "yes" )
      }
    }
    c:mergeHighestStartEnd-> c:?S1l {
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

c:?H1l { c:sem = "highest" c:A1-> c:?Building1l {} }
c:?H2l { c:sem = "highest" c:A1-> c:?Building2l {} }

c:?Time1l { c:sem = "posteriority_time" c:A1-> c:?Be1l {} }
c:?Time2l { c:blocked = "yes" c:sem = "anteriority_time" c:A1-> c:?Be2l {} c:A2-> c:?Date2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  //rc:<=> ?S1l
  rc:?Be1r {
    rc:<=> ?Be1l
    sem = "be"
    TimeEnd-> rc:?Date2r {
      rc:<=> ?Date2l
    }
  }
  rc:+?Date2r {
    rc:<=> ?Date2l
  }
}
  ]
]

/*Not tested.*/
Sem<=>ASem merge_HighestStartEnd2 : merge
[
  leftside = [
c:?Tl {
  c:?S2l {
     ( blocked = "yes" & ¬c:cancel_block = "yes" )
     c:?Be2l {
      c:slex = "be"
      ( blocked = "yes" & ¬c:cancel_block = "yes" )
      c:A1-> c:?Name2l {
        c:variable_class = "Name"
        ( blocked = "yes" & ¬c:cancel_block = "yes" )
        c:sem = ?semN2
      }
      c:A2-> c:?Building2l {
        ( blocked = "yes" & ¬c:cancel_block = "yes" )
      }
    }
    c:mergeHighestStartEnd-> c:?S1l {
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

c:?H1l { c:sem = "highest" c:A1-> c:?Building1l {} }
c:?H2l { c:sem = "highest" c:A1-> c:?Building2l {} }

c:?Time1l { c:blocked = "yes" c:sem = "anteriority_time" c:A1-> c:?Be1l {} }
c:?Time2l { c:sem = "posteriority_time" c:A1-> c:?Be2l {} c:A2-> c:?Date2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  //rc:<=> ?S1l
  rc:?Be1r {
    rc:<=> ?Be1l
    sem = "be"
    Time-> rc:?Date2r {
      rc:<=> ?Date2l
    }
  }
  rc:+?Date2r {
    rc:<=> ?Date2l
  }
}
  ]
]

/*MindSpaces*/
excluded Sem<=>ASem noMerge_Coord_changeParameter_emotion : merge
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

/*For bubbles that have the same property but different objects (e.g. born + date; born + place )*/
Sem<=>ASem merge_eatType_basic : merge
[
  leftside = [
c:?S2l {
  ( blocked = "yes" & ¬c:cancel_block = "yes" )
  ¬c:area = "yes"
  ¬c:near = "yes"
  ¬c:customerRating = "yes"
  c:?X2l {
    c:sem = ?semX2
    c:?r-> c:?Y2l {
      c:sem = ?semY2
      ( blocked = "yes" & ¬c:cancel_block = "yes" )
    }
  }
  merge_eatType-> c:?S1l {
    c:?X1l {
     eatType_anchor = "yes"
    }
  }
}
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

rc:?X1r {
  rc:<=> ?X1l
  NonCore-> rc:?X2r {
    rc:<=> ?X2l
  }
}
  ]
]

/*For bubbles that have the same property but different objects (e.g. born + date; born + place )*/
Sem<=>ASem merge_eatType_others : merge
[
  leftside = [
c:?S2l {
  ( blocked = "yes" & ¬c:cancel_block = "yes" )
  ( c:area = "yes" | c:near = "yes" | c:customerRating = "yes" )
  c:?X2l {
    c:sem = ?semX2
    c:?r-> c:?Y2l {
      c:sem = ?semY2
      ( blocked = "yes" & ¬c:cancel_block = "yes" )
    }
  }
  merge_eatType-> c:?S1l {
    c:?X1l {
     eatType_anchor = "yes"
    }
  }
}

¬c:?GovX2l { c:?rgovX2-> c:?X2l {} }
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

rc:?X2r {
  rc:<=> ?X2l
  ?r-> rc:?X1r {
    rc:<=> ?X1l
    definiteness_change = "DEF"
  }
}
  ]
]

/*For bubbles that have the same property but different objects (e.g. born + date; born + place )*/
Sem<=>ASem merge_near_area_IN : merge
[
  leftside = [
c:?S2l {
  ( blocked = "yes" & ¬c:cancel_block = "yes" )
  c:?X2l {
    ( c:sem = "near" | c:sem = "by" )
    c:?r-> c:?Y2l {
      c:sem = ?semY2
      ( blocked = "yes" & ¬c:cancel_block = "yes" )
    }
  }
  merge_near_area-> c:?S1l {
    c:?X1l {
     near_area_anchor = "yes"
    }
  }
}

¬c:?GovX2l { c:?rgovX2-> c:?X2l {} }
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

rc:?X1r {
  rc:<=> ?X1l
  Elaboration-> rc:?X2r {
    rc:<=> ?X2l
  }
}
  ]
]

/*For bubbles that have the same property but different objects (e.g. born + date; born + place )*/
Sem<=>ASem merge_near_area_VB : merge
[
  leftside = [
c:?S2l {
  ( blocked = "yes" & ¬c:cancel_block = "yes" )
  c:?X2l {
    ¬( c:sem = "near" | c:sem = "by" )
    c:?r-> c:?Y2l {
      c:sem = ?semY2
      ( blocked = "yes" & ¬c:cancel_block = "yes" )
    }
  }
  merge_near_area-> c:?S1l {
    c:?X1l {
     near_area_coord_anchor = "yes"
    }
  }
}

¬c:?GovX2l { c:?rgovX2-> c:?X2l {} }
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
  ?ConjR {
    sem = "and"
    slex = "and"
    pos = "CC"
    id = #randInt()#
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
  ?Y2r {
    <=> ?Y2l
    sem = ?semY2
  }
}
  ]
]

/*Keep sync with merge_ObjProg in Agg4 grammar.*/
Sem<=>ASem merge_ObjProg : merge
[
  leftside = [
c:?Tl {
  c:?S2l {
    c:?X2l {
      c:?t-> c:?Y2l {
        c:sem = ?semY2
        c:id = ?idY2
        ( blocked = "yes" & ¬c:cancel_block = "yes" )
      }
    }
    c:?s-> c:?S1l {
      c:?X1l {
        c:*?r-> c:?Y1l {
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
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  //rc:<=> ?S1l
  rc:?X1r {
    rc:<=> ?X1l
    //main_rheme = "yes"
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

/*Keep sync with merge_ObjProg in Agg4 grammar.*/
Sem<=>ASem merge_LocNE : merge
[
  leftside = [
c:?Tl {
  c:?S2l {
    c:?X2l {
      c:sem = ?semX2
      c:Location-> c:?Y2l {
      }
    }
    c:mergeLocNE-> c:?S1l {
      c:?X1l {
        c:sem = ?semX1
        c:Location-> c:?Y1l {
        }
      }
    }
  }
}

?semX1 == ?semX2
// Both Xs are roots
¬c:?N1l { c:?r1-> c:?X1l {} }
¬c:?N2l { c:?r2-> c:?X2l {} }

// see NE_Class rule
¬ ( c:?Y1l { c:class = ?c1 } & c:?Y2l { c:class = ?c2 } )
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  //rc:<=> ?S1l
  rc:?X1r {
    rc:<=> ?X1l
    //main_rheme = "yes"
    Location-> rc:?Y2r {
      rc:<=> ?Y2l
    }
  }
  rc:+?Y2r {
    rc:<=> ?Y2l
  }
}
  ]
]

/*Keep sync with merge_ObjProg in Agg4 grammar.*/
Sem<=>ASem merge_LocNEClass_Elab : merge
[
  leftside = [
c:?Tl {
  c:?S2l {
    c:?X2l {
      c:sem = ?semX2
      c:Location-> c:?Y2l {
        c:class = ?c2
      }
    }
    c:mergeLocClass-> c:?S1l {
      c:?X1l {
        c:sem = ?semX1
        c:Location-> c:?Y1l {
          c:class = ?c1
        }
      }
    }
  }
}

?semX1 == ?semX2
// Both Xs are roots
¬c:?N1l { c:?r1-> c:?X1l {} }
¬c:?N2l { c:?r2-> c:?X2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  //rc:<=> ?S1l
  rc:?Y1r {
    rc:<=> ?Y1l
    //main_rheme = "yes"
    Elaboration-> rc:?Y2r {
      rc:<=> ?Y2l
      type = "parenthetical"
    }
  }
  rc:+?Y2r {
    rc:<=> ?Y2l
  }
}
  ]
]

/*Keep sync with merge_ObjProg in Agg4 grammar.*/
Sem<=>ASem merge_stressLevel_Elab : merge
[
  leftside = [
c:?Tl {
 c:?S2l {
    c:?X2l {
      c:variable_class = "StressLevelConfidence"
      c:A1-> c:?Y2l {
        elab_anchor = "yes"
      }
    }
    MergeElab-> c:?S1l {
      c:?X1l {
        attach_elab = "yes"
      }
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  //rc:<=> ?S1l
  rc:?X1r {
    rc:<=> ?X1l
    //main_rheme = "yes"
    Elaboration-> rc:?Y2r {
      rc:<=> ?Y2l
      type = "parenthetical"
      definiteness = "no"
    }
  }
  rc:+?Y2r {
    rc:<=> ?Y2l
  }
}
  ]
]

/*If some ROOT predicates are quite deep in the graph structure, mark them to no use them for aggregation in the next step.*/
Sem<=>ASem mark_noAgg_embedded_pred : markers
[
  leftside = [
c:?X1l {
  //X has a dependent
 c:?r1-> c:?Yl {}
}
  //Y has another governor
  //c:?X2l {
   //c:?r2-> c:?Yl {}
  //}
//}

// to exclude sentences
¬ ?r1 == b
//X1 is a  root
¬c:?Gov3l { c:?r3-> c:?X1l {} }
//X2 is not a  root
//c:?Gov4l { c:?r4-> c:?X1l {} }
  ]
  mixed = [

  ]
  rightside = [
// ?X1r is still a root
rc:?X1r {
  rc:<=> ?X1l
  no_agg = "yes"
  rc:?R-> rc:?Yr {
    rc:<=> ?Yl
  }
}
¬rc:?Gov1R { rc:?R1-> rc:?X1r {} }
?R == ?r1

//X2 is not a  root; exclude pos = CC for Gov1? And if Gov1 is pos = CC, check that there is one other gov above.
rc:?Gov2R {
  // no need to say that X2 is not the same as X1, since it has a gov and X1 doesn't.
  rc:?R2-> rc:?X2r {
    rc:?R3-> rc:?Yr {}
  }
}

( ¬rc:?Gov2r { rc:pos = "CC" } | rc:?Gov4R { rc:?R4-> rc:?Gov2R {} } )
  ]
]

/*If there is a predicate number on a node, do not aggregate with subj and obj prog in the next grammar (where the aggregated predicate is the number or one of its siblings).
Is this a good rule?
201005_test_triples_en_en_utf8_0900-1349.conll structure 0*/
Sem<=>ASem mark_noAgg_number : markers
[
  leftside = [
c:?X1l {
  //X has a dependent
 c:?r1-> c:?Yl {}
}
  //Y has another governor
  //c:?X2l {
   //c:?r2-> c:?Yl {}
  //}
//}

// to exclude sentences
¬ ?r1 == b
// There is a number above ?Yl
( ?X1l.dpos == "CD" | ?X1l.sem > 0
  | ( c:?X2l { c:?r2-> c:?Yl {} } & ?X2l.dpos == "CD" | ?X2l.sem > 0 )
)
  ]
  mixed = [

  ]
  rightside = [
// ?X1r is still a root
rc:?X1r {
  rc:<=> ?X1l
  no_agg = "yes"
  rc:?R-> rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

/*If several arguments are grouped below a predicate, mark that the predicate has a cardinality > 1.
For now, this will transfer to number = PL on nouns. Not sure it will work for any case.*/
Sem<=>ASem mark_cardinality : markers
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:blocked = "yes"
    c:?X1l {
      c:sem = ?semX1
      c:blocked = "yes"
      c:?r1-> c:?Y1l {
        c:sem = ?semY1
      }
    }
    c:?AggRel-> c:?S2l {
      c:?X2l {
        c:sem = ?semX2
        c:?r2-> c:?Y2l {
          c:sem = ?semY2
        }
      }
    }
  }
}

( ?AggRel == mergeRootSubjCoord | ?AggRel == mergeRootObjCoord )

// restrict to subjects for now (see RS)
?r1 == ?r2
// the property is the same
?semX1 == ?semX2

//Both Xs are roots
¬c:?Gov6l { c:?r6-> c:?X1l {} }
¬c:?Gov7l { c:?r7-> c:?X2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?X2r {
  rc:<=> ?X2l
  cardinality = "PL"
  rc:?r-> rc:?And {
    rc:sem = "and"
    rc:?Conj1-> rc:?Y1r {
      rc:<=> ?Y1l
    }
    rc:?Conj2-> rc:?Y2r {
      rc:<=> ?Y2l
    }
  }
}

// Restrict to first argument
// Rightside lexicon calls are tricky, simplify condition for now
( ?r == A0 | ( ?r == A1 & ¬rc:?X2r { rc:A0-> rc:?A0R {} } ) | ( ?r == Elaboration & rc:?Y2r { rc:Elaboration = "A1" } ) )
//( ?r == A1 | ?r == A2 | ?r == A3 )
  ]
]

/*mergeRootSubj
mergeRootSubjCoord
mergeRootObjCoord
mergeRootSubjElab
mergeRootCoord
noMergeCoord*/
Sem<=>ASem mark_conj_numMore : markers
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
( ?r == mergeRootSubj | ?r == mergeRootSubjCoord | ?r == mergeRootObjCoord | ?r == mergeRootSubjElab
  | ?r == mergeRootCoord | ?r == noMergeCoord | ?r == mergeLocCoord )

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

Sem<=>ASem mark_member : markers
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

Sem<=>ASem attr_roomParameter : attr_MindSpaces
[
  leftside = [
c:?Xl {
  c:roomParameter = "yes"
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
  c:parameterChange = "yes"
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

Sem<=>ASem mark_member2_mergeRoot : mark_member
[
  leftside = [
c:?S2l {
  ( c:blocked = "yes" & ¬c:cancel_block = "yes" )
  c:?X2l {
    c:sem = ?semX2
    ( c:blocked = "yes" & ¬c:cancel_block = "yes" )
    c:?s2-> c:?Z2l {}
  }
  c:mergeRootCoord-> c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:agg_trig = "yes"
      c:?s1-> c:?Z1l {
        c:attach_coord = "yes"
      }
    }
  }
}

¬c:?N1l { c:?r1-> c:?X1l {} }
¬c:?N2l { c:?r2-> c:?X2l {} }

¬ ( c:?Tl { c:?S2l {c:id = ?id2 } c:?S3l { c:id = ?id3 c:mergeRootCoord-> c:?S1l {} } } & ?id3 < ?id2 )

// In case there are several nodes inthe graph that point to the blocked node
?semX1 == ?semX2
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

Sem<=>ASem mark_member2_mergeRootSubj : mark_member
[
  leftside = [
c:?S2l {
  ( c:blocked = "yes" & ¬c:cancel_block = "yes" )
  c:?X2l {
    c:sem = ?semX2
    ( c:blocked = "yes" & ¬c:cancel_block = "yes" )
    c:?s2-> c:?Z2l {}
  }
  c:?r-> c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:agg_trig = "yes"
      c:?s1-> c:?Z1l {
        c:attach_coord = "yes"
      }
    }
  }
}

¬c:?N1l { c:?r1-> c:?X1l {} }
¬c:?N2l { c:?r2-> c:?X2l {} }

¬ ( c:?T1l { c:?S2l {c:id = ?id2 } c:?S3l { c:id = ?id3 c:mergeRootSubjCoord-> c:?S1l {} } } & ?id3 < ?id2 )
¬ ( c:?T2l { c:?S2l {c:id = ?id4 } c:?S5l { c:id = ?id5 c:mergeRootObjCoord-> c:?S1l {} } } & ?id5 < ?id4 )

// In case there are several nodes inthe graph that point to the blocked node
?semX1 == ?semX2

( ?r == mergeRootSubjCoord | ?r == mergeRootObjCoord )
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

Sem<=>ASem mark_member2_noMerge : mark_member
[
  leftside = [
c:?S2l {
  ( c:blocked = "yes" & ¬c:cancel_block = "yes" )
  c:?X2l {
    c:sem = ?semX2
  
}
  c:noMergeCoord-> c:?S1l {
    c:?X1l {
      c:sem = ?semX1
      c:attach_coord = "yes"
    }
  }
}

¬c:?N1l { c:?r1-> c:?X1l {} }
¬c:?N2l { c:?r2-> c:?X2l {} }

¬ ( c:?Tl { c:?S2l {c:id = ?id2 } c:?S3l { c:id = ?id3 c:noMergeCoord-> c:?S1l {} } } & ?id3 < ?id2 )

// In case there are several nodes inthe graph that point to the blocked node
// second part covers MindSpaces, where nodes in parameterChange bubbles can have different names, but should have a tense, which should be the same
( ?semX1 == ?semX2 | ( ?S1l.parameterChange == ?S2l.parameterChange & ?X1l.tense == ?X2l.tense ) )
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

/*Same LS as rel_Location_mergeLoc*/
Sem<=>ASem mark_member2_mergeLoc : mark_member
[
  leftside = [
c:?S2l {
  ( c:blocked = "yes" & ¬c:cancel_block = "yes" )
  c:?X2l {
    c:Location-> c:?Y2l {
      c:sem = ?semY2
      ( c:blocked = "yes" & ¬c:cancel_block = "yes" )
    }
  }
  c:mergeLocCoord-> c:?S1l {
    c:?X1l {
      c:attach_coord = "yes"
      c:Location-> c:?Y1l {
        c:sem = ?semY1
      }
    }
  }
}

// the property and the subject are the same
?semY1 == ?semY2

// rule only applies to the closest sentence to be merged
¬ ( c:?S3l { c:id = ?idS3 c:mergeLocCoord-> c:?S1l {} } & c:?S2l { c:id = ?idS2 } & ?idS3 < ?idS2 )
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

Sem<=>ASem mark_member2_noMerge_roomParameter : mark_member
[
  leftside = [
c:?S2l {
  ( c:blocked = "yes" & ¬c:cancel_block = "yes" )
  ( c:roomParameter = "yes" | c:parameterChange = "yes" )
  c:?X2l {
    c:sem = ?semX2
  
}
  c:noMergeCoord-> c:?S1l {
    ( c:roomParameter = "yes" | c:subjectEmotion = "yes" )
    c:?X1l {
      c:sem = ?semX1
      c:attach_coord = "yes"
    }
  }
}

¬ ( c:?Tl { c:?S2l {c:id = ?id2 } c:?S3l { c:id = ?id3 c:noMergeCoord-> c:?S1l {} } } & ?id3 < ?id2 )
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

excluded Sem<=>ASem mark_n1_member1 : mark_member
[
  leftside = [
c:?X2l {}
  ]
  mixed = [
¬ ( rc:?Coord { rc:Set-> rc:?X2r { rc:<=> ?X2l rc:id = ?idX2 ¬rc:n = ?nX2 } rc:Set-> rc:?X3r { rc:id = ?idX3 ¬rc:n = ?nX3 } }
    & ?idX3 < ?idX2
)
  ]
  rightside = [
rc:?X2r {
    rc:<=> ?X2l
    ¬rc:n = ?nX2
    n = "1.0"
    member = "A1"
}

rc:?Coord {
  rc:Set-> rc:?X2r { rc:id = ?id1 }
  rc:Set-> rc:?X1r { rc:id = ?id2 }
}

¬?id1 == ?id2
  ]
]

excluded Sem<=>ASem mark_n_more : mark_member
[
  leftside = [
c:?X2l {}
  ]
  mixed = [
¬ ( rc:?Coord { rc:Set-> rc:?X1r { rc:id = ?idX1 rc:n = ?nX1 } rc:Set-> rc:?X2r { rc:<=> ?X2l rc:id = ?idX2 ¬rc:n = ?nX2 } rc:Set-> rc:?X3r { rc:id = ?idX3 ¬rc:n = ?nX3 } }
    & ?idX3 > ?idX1 & ?idX3 < ?idX2
)
  ]
  rightside = [
rc:?X2r {
    rc:<=> ?X2l
    ¬rc:n = ?nX2
    n = #?nX+1#
}

rc:?Coord {
  rc:Set-> rc:?X1r {
    rc:n = ?nX
  }
  rc:Set-> rc:?X2r {}
}
  ]
]

excluded Sem<=>ASem mark_member2 : mark_member
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:n = "2.0"
  member = "A2"
}
  ]
]

Sem<=>ASem mark_member3 : mark_member
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

Sem<=>ASem mark_member4 : mark_member
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

Sem<=>ASem mark_member5 : mark_member
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

Sem<=>ASem mark_member6 : mark_member
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

Sem<=>ASem mark_member7 : mark_member
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

Sem<=>ASem mark_member8 : mark_member
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

Sem<=>ASem mark_member9 : mark_member
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

Sem<=>ASem mark_member10 : mark_member
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

Sem<=>ASem mark_member11 : mark_member
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

Sem<=>ASem mark_member12 : mark_member
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:n = "12.0"
  member = "A12"
}
  ]
]

Sem<=>ASem mark_member13 : mark_member
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:n = "13.0"
  member = "A13"
}
  ]
]

Sem<=>ASem mark_member14 : mark_member
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:n = "14.0"
  member = "A14"
}
  ]
]

Sem<=>ASem mark_member15 : mark_member
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:n = "15.0"
  member = "A15"
}
  ]
]

Sem<=>ASem mark_member16 : mark_member
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:n = "16.0"
  member = "A16"
}
  ]
]

Sem<=>ASem mark_member17 : mark_member
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:n = "17.0"
  member = "A17"
}
  ]
]

Sem<=>ASem mark_member18 : mark_member
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:n = "18.0"
  member = "A18"
}
  ]
]

Sem<=>ASem mark_member19 : mark_member
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:n = "19.0"
  member = "A19"
}
  ]
]

Sem<=>ASem mark_member20 : mark_member
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:n = "20.0"
  member = "A20"
}
  ]
]

