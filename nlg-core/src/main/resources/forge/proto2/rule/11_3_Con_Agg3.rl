/*BUG: gives an overlap with node_word if no c: !!*/
Sem<=>ASem node_word
[
  leftside = [
// DO not transfer leftover nodes from previous aggregation, which are not in any bubble.
?Xl {
  c:sem = ?s
}

// ?Xl is not a stranded node outside of a bubble
// BUG: some rules (block_nodes_obj) don't apply anymore if activated! Don't know why.
//( c:?Bub { c:?Xl {} } | c:?Xl { c:?Yl {} } )
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

/*BUG: gives an overlap with node_word if no c: !!*/
Sem<=>ASem filter_node_stranded
[
  leftside = [
// DO not transfer leftover nodes from previous aggregation, which are not in any bubble.
c:?Xl {
  c:sem = ?s
}

// ?Xl is not a stranded node outside of a bubble
¬ c:?Bub { c:?Xl {} }
¬ c:?Xl { c:?Yl {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  blocked = "yes"
}
  ]
]

/*BUG: gives an overlap with node_word if no c: !!*/
excluded Sem<=>ASem node_bubble
[
  leftside = [
// DO not transfer leftover nodes from previous aggregation, which are not in any bubble.
?Bub {
  c:sem = ?s
  c:?Xl {
  }
}
  ]
  mixed = [

  ]
  rightside = [
?Br {
  <=> ?Bub
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

¬ ?r == TimeEnd
¬ ( ?r == Time & c:?Xl { c:TimeEnd-> ?TE {} } )
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

/*Transfers all non-argumental relations.*/
Sem<=>ASem rel_between
[
  leftside = [
c:?Xl {
  Time-> c: ?Yl {}
  TimeEnd-> c: ?Zl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Sr {
  rc:?Xr {
    rc:<=> ?Xl
    Time-> ?Br{
      sem = "between"
      slex = "between"
      A2-> rc:?Yr {
        rc:<=> ?Yl
      }
      A3-> rc:?Zr {
        rc:<=> ?Zl
      }
    }
  }
  ?Br {}
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

Sem<=>ASem transfer_attribute
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>ASem mark_possible_aggs
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>ASem mark_merge
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>ASem choose_merge
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*If a blocked sentence points only to a sentence that is itself aggregated, cancel blocking!*/
excluded Sem<=>ASem cancel_block_sent1
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
  rc:blocked = "yes"
  cancel_block = "yes"
  rc:?X1r { rc:blocked = "yes" cancel_block = "yes" }
  rc:<=> ?S2l
  rc:?R-> rc:?S1r {
    rc:<=> ?S1l
    rc:?X2r {} // { rc:main_rheme = "yes" cancel_rheme = "yes" }
    rc:id = ?id1
    rc:?S-> rc:?S3l {}
  }
}

( ?R == mergeObjProgress |  ?R == mergeSubjProgress )
( ?S == mergeObjProgress |  ?S == mergeSubjProgress )

¬ ( rc:?S2r {rc:<=> ?S2l rc:?T-> rc:?S4r {rc:id = ?id4} }
    & ( ?T == mergeObjProgress |  ?T == mergeSubjProgress )
    & ¬ ?id1 == ?id4
)
  ]
]

/*If a blocked sentence points to another sentence, cancel blocking!
Rule never finished and even less tested.*/
excluded Sem<=>ASem cancel_block_sent2
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
  rc:blocked = "yes"
  cancel_block = "yes"
  rc:?X1r { rc:blocked = "yes" cancel_block = "yes" }
  rc:<=> ?S2l
  rc:?R-> rc:?S1r {
    rc:<=> ?S1l
    rc:?X2r {} // { rc:main_rheme = "yes" cancel_rheme = "yes" }
    rc:id = ?id1
  }
  rc:?S-> rc:?S3l {}
}

?R == mergeObjProgress
?S == mergeSubjProgress

¬ ( rc:?S2r {rc:<=> ?S2l rc:?T-> rc:?S4r {rc:id = ?id4} }
    & ( ?T == mergeObjProgress |  ?T == mergeSubjProgress )
    & ¬ ?id1 == ?id4
)
  ]
]

/*If a bubble can be aggregated with two (or more) other bubbles, cancel some, in particular:
- if one of the target bubbles is marked to be aggregated with another sentence (i.e. if it is blocked);
- if one of the target bubbles is the target of another bubble.*/
Sem<=>ASem cancel_block_sent3
[
  leftside = [
c:?Tl {
  c:?S1l {
//    c:*b-> c:?S2l {}
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  rc:<=> ?S1l
  rc:id = ?id1
  rc:?R-> rc:?S2r { rc:id = ?id2 }
  rc:?S-> rc:?S3r { rc:id = ?id3 }
  CANCEL_AGG-> rc:?S2r {}
}

 ¬ ?id2 == ?id3

( ?R == mergeObjProgress |  ?R == mergeSubjProgress )
( ?S == mergeObjProgress |  ?S == mergeSubjProgress )

( rc:?S2r { rc:blocked = "yes" }
 | ( rc:?S4r { rc:id = ?id4 rc:?T-> rc:?S2r {} }
    & ( ?T == mergeObjProgress |  ?T == mergeSubjProgress )
    & ¬ ?id1 == ?id4 )
)
  ]
]

/*If none of cases in 3 happens, just use IDs*/
Sem<=>ASem cancel_block_sent3bis
[
  leftside = [
c:?Tl {
  c:?S1l {
//    c:*b-> c:?S2l {}
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  rc:<=> ?S1l
  rc:id = ?id1
  rc:?R-> rc:?S2r { rc:id = ?id2 }
  rc:?S-> rc:?S3r { rc:id = ?id3 }
  CANCEL_AGG-> rc:?S2r {}
}

?id2 < ?id3

( ?R == mergeObjProgress |  ?R == mergeSubjProgress )
( ?S == mergeObjProgress |  ?S == mergeSubjProgress )

¬ rc:?S2r { rc:blocked = "yes" }
¬ ( rc:?S4r { rc:id = ?id4 rc:?T-> rc:?S2r {} }
    & ( ?T == mergeObjProgress |  ?T == mergeSubjProgress )
    & ¬ ?id1 == ?id4 )
  ]
]

/*If a blocked node is in a sentence that has an aggregation that's been cancelled, cancel its blocking.
It's quite tricky to do, for now doing it really simple, see where we get with that.
So the idea is simply to unblock nodes which are found in both sentences involved in the CANCEL_BLOCK.*/
Sem<=>ASem cancel_block_node
[
  leftside = [
c:?Tl {
  c:?S2l {
    c:*b-> c:?S1l {}
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  rc:<=> ?S1l
  rc:?X1r {
    rc: sem = ?sem1
    rc:blocked = "yes"
    cancel_block = "yes"
  }
  rc:CANCEL_AGG-> rc:?S2r {
    rc:<=> ?S2l
    rc:?X2r {
      rc: sem = ?sem2
    }
  }
}

?sem1 == ?sem2
  ]
]

excluded Sem<=>ASem cancel_block_percolate
[
  leftside = [
c:?Xl {
  ¬c:slex = "Sentence"
  c:?r-> c:?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:cancel_block = "yes"
  rc:?r-> rc:?Yr {
    rc:<=> ?Yl
    cancel_block = "yes"
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

Sem<=>ASem attr_MindSpaces : transfer_attribute
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*When the Object is a subject of a posterior sentence.
(Object progression)*/
excluded Sem<=>ASem mark_ObjProg : mark_possible_aggs
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      ¬c:A0-> c:?A0l {}
      // there is an A1, so A2 is the Object (in principle)
      c:A1-> c:?Subj {}
      c:A2-> c:?Y1l {
        c:sem = ?semY1
      }
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:?r-> c:?Y2l {
          c:sem = ?semY2
        }
      }
    }
  }
}

?semY1 == ?semY2
// Both Xs are roots
¬c:?N1l { c:?r1-> c:?X1l {} }
¬c:?N2l { c:?r2-> c:?X2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?X1r {
  rc:<=> ?X1l
  agg_objProg = "yes"
}
  ]
]

/*When the Subject is an argument of a posterior sentence.
(Object progression)*/
excluded Sem<=>ASem mark_SubjProg : mark_possible_aggs
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      ¬c:A0-> c:?A0l {}
      c:A1-> c:?Y1l {
        c:sem = ?semY1
      }
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:?r-> c:?Y2l {
          c:sem = ?semY2
        }
      }
    }
  }
}

?semY1 == ?semY2
// Both Xs are roots
¬c:?N1l { c:?r1-> c:?X1l {} }
¬c:?N2l { c:?r2-> c:?X2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?X1r {
  rc:<=> ?X1l
  agg_subjProg = "yes"
}
  ]
]

/*When the Object is a subject of a posterior sentence, aggregate!
(Object progression)
This is very simplistic and works for WebNLG; we should check the whole subtree below ?Yl. (Edit: started improvements in this direction, more cases to be covered).*/
Sem<=>ASem merge_ObjProg : mark_merge
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      // there is an A1, so A2 is the Object (in principle)
      // c:A1-> c:?Subj {}
      c:?rObj-> c:?Y1l {
        c:sem = ?semY1
        c:id = ?idY1
      }
    }
    c:*b-> c:?S2l {
      c:?X2l {
        // see markers in previous grammar; apply this condition to X1 too?
        ¬c:no_agg = "yes"
        c:?r-> c:?Y2l {
          c:sem = ?semY2
          c:id = ?idY2
        }
      }
    }
  }
}
¬ ?semY1 == "and"
( ?rObj == A2 | ?rObj == A3 )

?semY1 == ?semY2
// If the roots are also the same, we need a different rule to apply 
¬?X1l.sem == ?X2l.sem
// Both Xs are roots
¬c:?N1l { c:?r1-> c:?X1l {} }
¬c:?N2l { c:?r2-> c:?X2l {} }
// Ys don't have other governors in common; add condition to complex conditions below? (191119_CONNEXIONs, 123)
¬ ( c:?N11l { c:id = ?id11 c:?r11-> c:?Y1l {} } & ¬?id11 == ?X1l.id & ?N11l.sem == ?X2l.sem )
¬ ( c:?N12l { c:id = ?id12 c:?r12-> c:?Y2l {} } & ¬?id12 == ?X2l.id & ?N12l.sem == ?X1l.sem )
¬ ( c:?N13l { c:id = ?id13 c:?r13-> c:?Y2l {} } & ¬?id13 == ?X2l.id & c:?N14l { c:id = ?id14 c:?r14-> c:?Y1l {} } & ¬?id14 == ?X1l.id & ?N13l.sem == ?N14l.sem )
// Ugly patch; think better how we handle arguments which are not nouns
¬ ?Y1l.dpos == "CD"
¬ ?Y2l.dpos == "CD"

// Avoid aggregating sentences that have already been aggregated in the previous level (uglu aggregations on Game summaries of Rotowire); let's start with two "and" below a predicate; add condition to complex conditions below?
¬ c:?X1l { c:?rAgg15-> c:?And15 { c:sem = "and" } c:?rAgg16-> c:?And16 { c:sem = "and" } }
¬ c:?X2l { c:?rAgg17-> c:?And17 { c:sem = "and" } c:?rAgg18-> c:?And18 { c:sem = "and" } } 
// And one "and" with one dependent  ("and" has minimum 2 dependents) that in its turn has at least 3 dependents; add condition to complex conditions below?
¬ c:?X1l { c:?rAgg19-> c:?And19 { c:sem = "and" c:Set-> c:?Dep19 { c:?r19a-> c:?GDep19a {} c:?r19b-> c:?GDep19b {} c:?r19c-> c:?GDep19c {} } } }
¬ c:?X2l { c:?rAgg20-> c:?And20 { c:sem = "and" c:Set-> c:?Dep20 { c:?r20a-> c:?GDep20a {} c:?r20b-> c:?GDep20b {} c:?r20c-> c:?GDep20c {} } } }

// There isn't a dependent on one of the arguments that is not on the dependent of the second sentence (to be improved)
¬ ( c:?Y1l { c:?r7-> c:?Dep7l { c:sem= ?semD7 } } & c:?Y2l { c:?r5-> c:?Dep8l { c:sem= ?semD8 } } & ¬?semD7 == ?semD8 )

// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:?X3l { c:?rObj2-> c:?Y3l { c:sem = ?semY3 } } } }
   & ( ?rObj2 == A2 | ?rObj2 == A3 )
   & ¬c:?N3l { c:?r3-> c:?X3l {} }
   & ?semY3 == ?semY2  & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
)
// only the first ?S2l is merged
¬ ( c:?Tl { c:?S1l { c:*b-> c:?S4l { c:id = ?id4 c:?X4l { c:?r4-> c:?Y4l { c:sem = ?semY4 } } } } }
   & ¬c:?N4l { c:?r4b-> c:?X4l {} }
   & ?semY4 == ?semY1  & c:?S2l { c:id = ?id42 } & ?id4 < ?id42
)
// there isn't another dependent with the same sem (it happens!)
¬ ( c:?X2l { c:?r5-> c:?Y5l {c:sem = ?semY5 c:id = ?idY5 } } & ?semY5 == ?semY2 & ?idY5 < ?idY2 )
¬ ( c:?X1l { c:?rObj3-> c:?Y6l {c:sem = ?semY6 c:id = ?idY6 } } & ?semY6 == ?semY1 & ?idY6 < ?idY1 & ( ?rObj3 == A2 | ?rObj3 == A3 ))

//PATCH beAWARE
¬ ( project_info.project.gen_type.D2T & ( ( ?X1l.sem == "report" & ?X2l.sem == "detect" ) | ( ?X2l.sem == "report" & ?X1l.sem == "detect" ) ) )

//PATCH CONNEXIONs
¬ ( project_info.project.gen_type.D2T & ?Y1l.sem == "word" )

// To avoid aggregation in WELCOME interrogatives - but think about interrogatives in general in the future
¬ ( project_info.project.name.WELCOME & ( ?X1l.clause_type == "INT" | ?X2l.clause_type == "INT" ))


//PATCH MindSpaces
¬ ( project_info.project.name.MindSpaces & ( ( ( ?X1l.sem == "contain" | ?X1l.sem == "occupy" | ?X1l.sem == "colourful" ) & ?X2l.sem == "element" ) | ( ( ?X2l.sem == "contain" | ?X2l.sem == "occupy" | ?X2l.sem == "colourful" )  & ?X1l.sem == "element" ) ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked_o_potential = "yes"
  mergeObjProgress-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?Y2r {
  rc:<=> ?Y2l
  blocked_o_potential = "yes"
}

//rc:?X1r {
//  rc:<=> ?X1l
  //rc:agg_objProg = "yes"
//  main_rheme = "yes"
//}
  ]
]

/*When the Subject is an argument of a posterior sentence, aggregate!
(Subject progression).
Object progression has the priority (random decision)
This is very simplistic and works for WebNLG; we should check the whole subtree below ?Yl. Also it doesn't apply to subjects that are A0. (Edit: started improvements in this direction, more cases to be covered).*/
Sem<=>ASem merge_SubjProg : mark_merge
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:A1-> c:?Y1l {
        c:sem = ?semY1
        c:id = ?idY1
      }
    }
    c:*b-> c:?S2l {
      c:?X2l {
        // see markers in previous grammar; apply this condition to X1 too?
        ¬c:no_agg = "yes"
        c:?r-> c:?Y2l {
          c:sem = ?semY2
          c:id = ?idY2
        }
      }
    }
  }
}
¬ ?semY1 == "and"

?semY1 == ?semY2
// If the roots are also the same, we need a different rule to apply 
¬?X1l.sem == ?X2l.sem
// Both Xs are roots
¬c:?N1l { c:?r1-> c:?X1l {} }
¬c:?N2l { c:?r2-> c:?X2l {} }
// Ys don't have other governors in common; add condition to complex conditions below? (191119_CONNEXIONs, 123)
¬ ( c:?N11l { c:id = ?id11 c:?r11-> c:?Y1l {} } & ¬?id11 == ?X1l.id & ?N11l.sem == ?X2l.sem )
¬ ( c:?N12l { c:id = ?id12 c:?r12-> c:?Y2l {} } & ¬?id12 == ?X2l.id & ?N12l.sem == ?X1l.sem )
¬ ( c:?N13l { c:id = ?id13 c:?r13-> c:?Y2l {} } & ¬?id13 == ?X2l.id & c:?N14l { c:id = ?id14 c:?r14-> c:?Y1l {} } & ¬?id14 == ?X1l.id & ?N13l.sem == ?N14l.sem )
// Ugly patch; think better how we handle arguments which are not nouns
¬ ?Y1l.dpos == "CD"
¬ ?Y2l.dpos == "CD"

// Avoid aggregating sentences that have already been aggregated in the previous level (uglu aggregations on Game summaries of Rotowire); let's start with two "and" below a predicate; add condition to complex conditions below?
¬ c:?X1l { c:?rAgg15-> c:?And15 { c:sem = "and" } c:?rAgg16-> c:?And16 { c:sem = "and" } }
¬ c:?X2l { c:?rAgg17-> c:?And17 { c:sem = "and" } c:?rAgg18-> c:?And18 { c:sem = "and" } }
// And one "and" with one dependent  ("and" has minimum 2 dependents) that in its turn has at least 3 dependents; add condition to complex conditions below?
¬ c:?X1l { c:?rAgg19-> c:?And19 { c:sem = "and" c:Set-> c:?Dep19 { c:?r19a-> c:?GDep19a {} c:?r19b-> c:?GDep19b {} c:?r19c-> c:?GDep19c {} } } }
¬ c:?X2l { c:?rAgg20-> c:?And20 { c:sem = "and" c:Set-> c:?Dep20 { c:?r20a-> c:?GDep20a {} c:?r20b-> c:?GDep20b {} c:?r20c-> c:?GDep20c {} } } }

// There isn't a dependent on one of the arguments that is not on the dependent of the second sentence (to be improved)
¬ ( c:?Y1l { c:?r7-> c:?D7l { c:sem= ?semD7 } } & c:?Y2l { c:?r5-> c:?D8l { c:sem= ?semD8 } } & ¬?semD7 == ?semD8 )
¬ ( c:?Y1l { c:?r21-> c:?D21l { c:?s21-> c:?DD21l { c:sem= ?semD21 } } } & c:?Y2l { c:?r22-> c:?D22l {  c:?s22-> c:?DD22l { c:sem= ?semD22 } } } & ¬?semD21 == ?semD22 )
¬ ( c:?Y1l { c:?r23-> c:?D23l { c:?s23-> c:?DD23l {  c:?t23-> c:?DDD23l { c:sem= ?semD23 } } } } & c:?Y2l { c:?r24-> c:?D24l {  c:?s24-> c:?DD24l { c:?t24-> c:?DDD24l { c:sem= ?semD24 } } } } & ¬?semD23 == ?semD24 )

// there isn't another dependent with the same sem (it happens!)
¬ ( c:?X2l { c:?r5-> c:?Y5l {c:sem = ?semY5 c:id = ?idY5 } } & ?semY5 == ?semY2 & ?idY5 < ?idY2 )
¬ ( c:?X1l { c:A1-> c:?Y6l {c:sem = ?semY6 c:id = ?idY6 } } & ?semY6 == ?semY1 & ?idY6 < ?idY1 )

// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:?X3l { c:A1-> c:?Y3l { c:sem = ?semY3 } } } }
   & ?semY3 == ?semY2 & ¬?X3l.sem == ?X2l.sem & ¬c:?N3l { c:?r3-> c:?X3l {} }
   & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
  // added the conditions below to see if they were solving a problem (they didn't), but not sure they're needed; didn't test them.
  // & ¬ ( c:?Y3l { c:?r11-> c:?Dep11l { c:sem= ?semD11 } } & c:?Y2l { c:?r12-> c:?Dep12l { c:sem= ?semD12 } } & ¬?semD11 == ?semD12 )
  // & ¬ ( c:?X3l { c:A1-> c:?Y13l {c:sem = ?semY13 c:id = ?idY13 } } & ?semY13 == ?semY1 & ?idY13 < ?idY1 )
  // missing condition about rc:agg_subjProg = "yes" ¬rc:agg_objProg = "yes"
)
// only the first ?S1l is merged
¬ ( c:?Tl { c:?S1l { c:*b-> c:?S4l { c:id = ?id4 c:?X4l { c:?r4-> c:?Y4l { c:sem = ?semY4 } } } } }
   & ¬c:?N4l { c:?r4b-> c:?X4l {} }
   & ?semY4 == ?semY1  & c:?S2l { c:id = ?id42 } & ?id4 < ?id42
)

// if ?r is A1, check that there isn't an A2 with which this rule could apply too
// this rule could prioritize A1 too, but it seems to give a bug during grammar 20 at this point
// 3triples_WrittenWork_train_challenge_v4.conll
¬ ( c:?Tl { c:?S5l { c:?X5l { c:A1-> c:?Y5l { c:sem = ?semY5 } } } }
   & ¬c:?N5l { c:?r5-> c:?X5l {} }
   & ¬ ?r == A2
   & c:?X2l { c:A2-> c:?Z5l { c:sem = ?semZ5 } }
   & ?semY5 == ?semZ5
)

// do not apply if the other argument is the same as well
// 5triples_Food_train_challenge_conll sent_129 or sent_131
// 4triples_Airport_dev_challenge_v4.conll sent_17
¬ ( c:?X1l { c:?r7-> c:?Y7l {} } & c:?X2l { c:?s7-> c:?Z7l {} } & ?Y7l.sem == ?Z7l.sem & ¬ ?Y7l.sem == ?semY1 )

// See merge HighestTimeRegion rules
¬ ( c:?X2l { c:?r9-> c:?Y9l { c:variable_class = ?vc9 } } & c:?X1l { c:?r10-> c:?Y10l { c:variable_class = ?vc10 } } 
    & ( ?vc9 == "HighestRegion" | ?vc9 == "HighestStart" )  & ( ?vc10 == "HighestRegion" | ?vc10 == "HighestStart" )
)

// to improve aggregation in CONNEXIONs
¬ ( c:?X2l { c:variable_class = ?vcX2 } & c:?X1l { c:variable_class = ?vcX1 }
    & ( ?vcX2 == "ThreeCharsWord" | ?vcX2 == "HighestStart" )  & ( ?vcX1 == "ThreeCharsWord" | ?vcX1 == "HighestStart" )
)

¬ ( project_info.project.name.CONNEXIONs & ?Y1l.sem == "service" )

// To avoid aggregation in WELCOME interrogatives - but think about interrogatives in general in the future
¬ ( project_info.project.name.WELCOME & ( ?X1l.clause_type == "INT" | ?X2l.clause_type == "INT" ))

//PATCH MindSpaces
¬ ( project_info.project.name.MindSpaces & ( ( ( ?X1l.sem == "contain" | ?X1l.sem == "occupy" | ?X1l.sem == "colourful" ) & ?X2l.sem == "element" ) | ( ( ?X2l.sem == "contain" | ?X2l.sem == "occupy" | ?X2l.sem == "colourful" )  & ?X1l.sem == "element" ) ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked_s_potential = "yes"
  mergeSubjProgress-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?Y2r {
  rc:<=> ?Y2l
  blocked_s_potential = "yes"
}

//rc:?X1r {
//  rc:<=> ?X1l
  //¬rc:agg_objProg = "yes"
  //rc:agg_subjProg = "yes"
//  main_rheme = "yes"
//}
  ]
]

/*When the Subject is an argument of a posterior sentence, aggregate!
(Subject progression).
Object progression has the priority (random decision)
This is very simplistic and works for WebNLG; we should check the whole subtree below ?Yl. Also it doesn't apply to subjects that are A0. (Edit: started improvements in this direction, more cases to be covered).*/
Sem<=>ASem merge_SubjProgA0 : mark_merge
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:A0-> c:?Y1l {
        c:sem = ?semY1
        c:id = ?idY1
      }
    }
    c:*b-> c:?S2l {
      c:?X2l {
        // see markers in previous grammar; apply this condition to X1 too?
        ¬c:no_agg = "yes"
        c:?r-> c:?Y2l {
          c:sem = ?semY2
          c:id = ?idY2
        }
      }
    }
  }
}
¬ ?semY1 == "and"

?semY1 == ?semY2
// If the roots are also the same, we need a different rule to apply 
¬?X1l.sem == ?X2l.sem
// Both Xs are roots
¬c:?N1l { c:?r1-> c:?X1l {} }
¬c:?N2l { c:?r2-> c:?X2l {} }

// There isn't a dependent on one of the arguments that is not on the dependent of the second sentence (to be improved)
¬ ( c:?Y1l { c:?r7-> c:?Dep7l { c:sem= ?semD7 } } & c:?Y2l { c:?r5-> c:?Dep8l { c:sem= ?semD8 } } & ¬?semD7 == ?semD8 )

// Avoid aggregating sentences that have already been aggregated in the previous level (uglu aggregations on Game summaries of Rotowire); let's start with two "and" below a predicate
¬ c:?X1l { c:?rAgg15-> c:?And15 { c:sem = "and" } c:?rAgg16-> c:?And16 { c:sem = "and" } }
¬ c:?X2l { c:?rAgg17-> c:?And17 { c:sem = "and" } c:?rAgg18-> c:?And18 { c:sem = "and" } } 

// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:?X3l { c:A0-> c:?Y3l { c:sem = ?semY3 } } } }
   & ¬c:?N3l { c:?r3-> c:?X3l {} }
   & ?semY3 == ?semY2  & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
 // missing condition about rc:agg_subjProg = "yes" ¬rc:agg_objProg = "yes"
)
// only the first ?S1l is merged
¬ ( c:?Tl { c:?S1l { c:*b-> c:?S4l { c:id = ?id4 c:?X4l { c:?r4-> c:?Y4l { c:sem = ?semY4 } } } } }
   & ¬c:?N4l { c:?r4b-> c:?X4l {} }
   & ?semY4 == ?semY1  & c:?S2l { c:id = ?id42 } & ?id4 < ?id42
)
// there isn't another dependent with the same sem (it happens!)
¬ ( c:?X2l { c:?r5-> c:?Y5l {c:sem = ?semY5 c:id = ?idY5 } } & ?semY5 == ?semY2 & ?idY5 < ?idY2 )
¬ ( c:?X1l { c:A0-> c:?Y6l {c:sem = ?semY6 c:id = ?idY6 } } & ?semY6 == ?semY1 & ?idY6 < ?idY1 )

// if ?r is A0, check that there isn't an a1 or an A2 with which this rule could apply too
// this rule could prioritize A1 too, but it seems to give a bug during grammar 20 at this point
// 3triples_WrittenWork_train_challenge_v4.conll
¬ ( c:?Tl { c:?S5l { c:?X5l { c:A0-> c:?Y5l { c:sem = ?semY5 } } } }
   & ¬c:?N5l { c:?r5-> c:?X5l {} }
   & ¬ ?r == A1
   & c:?X2l { c:A1-> c:?Z5l { c:sem = ?semZ5 } }
   & ?semY5 == ?semZ5
)
¬ ( c:?Tl { c:?S8l { c:?X8l { c:A0-> c:?Y8l { c:sem = ?semY8 } } } }
   & ¬c:?N8l { c:?r8-> c:?X8l {} }
   & ¬ ?r == A2
   & c:?X2l { c:A2-> c:?Z8l { c:sem = ?semZ8 } }
   & ?semY8 == ?semZ8
)

// do not apply if the other argument is the same as well
// 5triples_Food_train_challenge_conll sent_129 or sent_131
// 4triples_Airport_dev_challenge_v4.conll sent_17
¬ ( c:?X1l { c:?r7-> c:?Y7l {} } & c:?X2l { c:?s7-> c:?Z7l {} } & ?Y7l.sem == ?Z7l.sem & ¬ ?Y7l.sem == ?semY1 )
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked_s_potential = "yes"
  mergeSubjProgressA0-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?Y2r {
  rc:<=> ?Y2l
  blocked_s_potential = "yes"
}

//rc:?X1r {
//  rc:<=> ?X1l
  //¬rc:agg_objProg = "yes"
  //rc:agg_subjProg = "yes"
//  main_rheme = "yes"
//}
  ]
]

/*When Region comes first, and Time second.*/
Sem<=>ASem merge_HighestTimeRegion1 : mark_merge
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
rc:?S2r {
  rc:<=> ?S2l
  blockedHighest_potential = "yes"
  mergeHighestTimeRegion-> rc:?S1r {
    rc:<=> ?S1l
  }
}
  ]
]

/*When Time comes first, and Region second. NOT TESTED.*/
Sem<=>ASem merge_HighestTimeRegion2 : mark_merge
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
        c:Time-> c:?Time2l {}
      }
    }
  }
}

?semN1 == ?semN2

c:?H1l { c:sem = "highest" c:A1-> c:?Building1l {} }
c:?H2l { c:sem = "highest" c:A1-> c:?Building2l {} c:Location-> c:?Loc {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blockedHighest_potential = "yes"
  mergeHighestTimeRegion-> rc:?S1r {
    rc:<=> ?S1l
  }
}
  ]
]

/*beAWARE rule for aggregating report and detect facts.*/
Sem<=>ASem beAWARE_merge_ObjProg : mark_merge
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      // there is an A1, so A2 is the Object (in principle)
      // c:A1-> c:?Subj {}
      c:?rObj-> c:?Y1l {
        c:sem = ?semY1
        c:id = ?idY1
      }
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:?r-> c:?Y2l {
          c:sem = ?semY2
          c:id = ?idY2
        }
      }
    }
  }
}
¬ ?semY1 == "and"
( ?rObj == A2 | ?rObj == A3 )

?semY1 == ?semY2
// Both Xs are roots
¬c:?N1l { c:?r1-> c:?X1l {} }
¬c:?N2l { c:?r2-> c:?X2l {} }

// There isn't a dependent on one of the arguments that is not on the dependent of the second sentence (to be improved)
¬ ( c:?Y1l { c:?r7-> c:?Dep7l { c:sem= ?semD7 } } & c:?Y2l { c:?r5-> c:?Dep8l { c:sem= ?semD8 } } & ¬?semD7 == ?semD8 )

// ?S1l is the first sentence, to which all other sentences will point
¬ ( c:?Tl { c:?S3l { c:id = ?id3 c:?X3l { c:?rObj2-> c:?Y3l { c:sem = ?semY3 } } } }
   & ( ?rObj2 == A2 | ?rObj2 == A3 )
   & ¬c:?N3l { c:?r3-> c:?X3l {} }
   & ?semY3 == ?semY2  & c:?S1l { c:id = ?id1 } & ?id3 < ?id1
)
// only the first ?S2l is merged
¬ ( c:?Tl { c:?S1l { c:*b-> c:?S4l { c:id = ?id4 c:?X4l { c:?r4-> c:?Y4l { c:sem = ?semY4 } } } } }
   & ¬c:?N4l { c:?r4b-> c:?X4l {} }
   & ?semY4 == ?semY1  & c:?S2l { c:id = ?id42 } & ?id4 < ?id42
)
// there isn't another dependent with the same sem (it happens!)
¬ ( c:?X2l { c:?r5-> c:?Y5l {c:sem = ?semY5 c:id = ?idY5 } } & ?semY5 == ?semY2 & ?idY5 < ?idY2 )
¬ ( c:?X1l { c:?rObj3-> c:?Y6l {c:sem = ?semY6 c:id = ?idY6 } } & ?semY6 == ?semY1 & ?idY6 < ?idY1 & ( ?rObj3 == A2 | ?rObj3 == A3 ))

project_info.project.gen_type.D2T
( ( ?X1l.sem == "report" & ?X2l.sem == "detect" ) | ( ?X2l.sem == "report" & ?X1l.sem == "detect" ) )
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

//rc:?Y2r {
//  rc:<=> ?Y2l
//  blocked = "yes"
//}

rc:?X1r {
  rc:<=> ?X1l
  attach_coord = "yes"
}
  ]
]

/*If two sentences have the same topic in the Explanation domain, let's make one single sentence.*/
Sem<=>ASem EXPLANATIONS_merge_sameTopic : mark_merge
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?Root1l {
      c:*?r-> c:?X1l { c:id = ?id1 }
    }
    c:*b-> c:?S2l {
      c:?Root2l {
        c:*?s-> c:?X2l { c:coref_id = ?id1 }
      }
    }
  }
}

project_info.project.name.EXPLANATIONS

¬c:?N1l { c:?r1-> c:?Root1l {} }
¬c:?N2l { c:?r2-> c:?Root2l {} }

// ?S1l is the first sentence, to which all other sentences will point
// This condition should be covered by the fact that only one node has the id = ?id1
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  blocked_s_potential = "yes"
  mergeBubOnly-> rc:?S1r {
    rc:<=> ?S1l
  }
}
  ]
]

/*MindSpaces*/
Sem<=>ASem MINDSPACES_merge_emotion_changeParameter : mark_merge
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
  blocked_MS_potential = "yes"
  noMergeCoord-> rc:?S1r {
    rc:<=> ?S1l
  }
}

//rc:?X1r {
//  rc:<=> ?X1l
//  attach_coord = "yes"
//}
  ]
]

/*MindSpaces*/
Sem<=>ASem merge_emotion_changeParameter_MindSpaces : choose_merge
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
  rc:blocked_MS_potential = "yes"
  blocked = "yes"
  rc:noMergeCoord-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?X1r {
  rc:<=> ?X1l
  attach_coord = "yes"
}
  ]
]

/*If a sentence points to a sentence that isn't merged with any other sentence, block the nodes.
We explicitly describe the LS configuration including ?Y nodes so the rule applies to the correct bubbles in case
 of multiple possible merges. (170822a_known_input_multiple2.conll, #39)*/
Sem<=>ASem block_nodes_obj : choose_merge
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      // there is an A1, so A2 is the Object (in principle)
      // c:A1-> c:?Subj {}
      c:?s-> c:?Y1l {
        c:sem = ?semY1
        //c:id = ?idY1
      }
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:?r-> c:?Y2l {
          c:sem = ?semY2
          //c:id = ?idY2
        }
      }
    }
  }
}

?semY1 == ?semY2
// Both Xs are roots
¬c:?N1l { c:?r1-> c:?X1l {} }
¬c:?N2l { c:?r2-> c:?X2l {} }

( ?s == A2 | ?s == A3 )
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  rc:blocked_o_potential = "yes"
  blocked = "yes"
  rc:?Y2r {
    rc:<=> ?Y2l
    rc:blocked_o_potential = "yes"
    blocked = "yes"
  }
  rc:mergeObjProgress-> rc:?S1r {
    rc:<=> ?S1l
    //rc:?X2r {}
    //rc:id = ?id1
    //¬rc:mergeObjProgress-> rc:?S3r {}
    //¬rc:mergeSubjProgress-> rc:?S4r {}
  }
}

¬rc:?S2r { rc:<=> ?S2l rc:noMergeCoord-> rc:?Hr {} }
¬rc:?S1r { rc:mergeObjProgress-> rc:?Br {} }
¬rc:?S1r { rc:mergeSubjProgress-> rc:?Cr {} }
¬rc:?S1r { rc:mergeSubjProgressA0-> rc:?Dr {} }
¬rc:?S1r { rc:mergeBubOnly-> rc:?Fr {} }
¬rc:?S1r { rc:noMergeCoord-> rc:?Gr {} }
¬rc:?S4r { rc:noMergeCoord-> rc:?S2r { rc:<=> ?S2l } }

// So the rule only applies once in case of multiple possible merges.
¬rc:?Tr { rc:?S2r { rc:mergeObjProgress-> rc:?S3r { rc:*b-> rc:?S1r {} } } }

// If ?S1R already reaceives a subj_progress, do not overload the sentence; Edit: we should instead avoid adding mergeObjProgress when the graph to aggregate is big.
//¬rc:?S5r { rc:mergeSubjProgress-> rc:?S1r { rc:<=> ?S1l } }
  ]
]

/*If a sentence points to a sentence that isn't merged with any other sentence, block the nodes.
We explicitly describe the LS configuration including ?Y nodes so the rule applies to the correct bubbles in case
 of multiple possible merges. (170822a_known_input_multiple2.conll, #39)*/
Sem<=>ASem block_nodes_subj : choose_merge
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:A1-> c:?Y1l {
        c:sem = ?semY1
        c:id = ?idY1
      }
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:?r-> c:?Y2l {
          c:sem = ?semY2
          c:id = ?idY2
        }
      }
    }
  }
}

?semY1 == ?semY2
// Both Xs are roots
¬c:?N1l { c:?r1-> c:?X1l {} }
¬c:?N2l { c:?r2-> c:?X2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  rc:blocked_s_potential = "yes"
  blocked = "yes"
  rc:?Y2r {
    rc:<=> ?Y2l
    rc:blocked_s_potential = "yes"
    blocked = "yes"
  }
//  ¬rc:mergeObjProgress-> rc:?S5r {}
  rc:mergeSubjProgress-> rc:?S1r {
    rc:<=> ?S1l
    //¬rc:mergeObjProgress-> rc:?S3r {}
    //¬rc:mergeSubjProgress-> rc:?S4r {}
  }
}

¬rc:?S2r { rc:<=> ?S2l rc:mergeObjProgress-> rc:?Ar {} }
¬rc:?S2r { rc:<=> ?S2l rc:noMergeCoord-> rc:?Hr {} }
¬rc:?S1r { rc:<=> ?S1l rc:mergeObjProgress-> rc:?Br {} }
¬rc:?S1r { rc:<=> ?S1l rc:mergeSubjProgress-> rc:?Cr {} }
¬rc:?S1r { rc:<=> ?S1l rc:mergeSubjProgressA0-> rc:?Dr {} }
¬rc:?S1r { rc:<=> ?S1l rc:mergeBubOnly-> rc:?Fr {} }
¬rc:?S1r { rc:<=> ?S1l rc:noMergeCoord-> rc:?Gr {} }
¬rc:?S4r { rc:noMergeCoord-> rc:?S2r { rc:<=> ?S2l } }

// So the rule only applies once in case of multiple possible merges.
¬rc:?Tr { rc:?S2r { rc:<=> ?S2l rc:mergeSubjProgress-> rc:?S3r { rc:*b-> rc:?S1r { rc:<=> ?S1l } } } }
  ]
]

/*If a sentence points to a sentence that isn't merged with any other sentence, block the nodes.
We explicitly describe the LS configuration including ?Y nodes so the rule applies to the correct bubbles in case
 of multiple possible merges. (170822a_known_input_multiple2.conll, #39)*/
Sem<=>ASem block_nodes_subjA0 : choose_merge
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?X1l {
      c:A0-> c:?Y1l {
        c:sem = ?semY1
        c:id = ?idY1
      }
    }
    c:*b-> c:?S2l {
      c:?X2l {
        c:?r-> c:?Y2l {
          c:sem = ?semY2
          c:id = ?idY2
        }
      }
    }
  }
}

?semY1 == ?semY2
// Both Xs are roots
¬c:?N1l { c:?r1-> c:?X1l {} }
¬c:?N2l { c:?r2-> c:?X2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  rc:blocked_s_potential = "yes"
  blocked = "yes"
  rc:?Y2r {
    rc:<=> ?Y2l
    rc:blocked_s_potential = "yes"
    blocked = "yes"
  }
//  ¬rc:mergeObjProgress-> rc:?S5r {}
  rc:mergeSubjProgressA0-> rc:?S1r {
    rc:<=> ?S1l
    //¬rc:mergeObjProgress-> rc:?S3r {}
    //¬rc:mergeSubjProgress-> rc:?S4r {}
  }
}

¬rc:?S2r { rc:mergeObjProgress-> rc:?Ar {} }
¬rc:?S2r { rc:mergeSubjProgress-> rc:?A2r {} }
¬rc:?S2r { rc:noMergeCoord-> rc:?Hr {} }
¬rc:?S1r { rc:mergeObjProgress-> rc:?Br {} }
¬rc:?S1r { rc:mergeSubjProgress-> rc:?Cr {} }
¬rc:?S1r { rc:mergeSubjProgressA0-> rc:?C2r {} }
¬rc:?S1r { rc:mergeBubOnly-> rc:?Fr {} }
¬rc:?S1r { rc:noMergeCoord-> rc:?Gr {} }
¬rc:?S4r { rc:noMergeCoord-> rc:?S2r { rc:<=> ?S2l } }

// So the rule only applies once in case of multiple possible merges.
¬rc:?Tr { rc:?S2r { rc:mergeSubjProgressA0-> rc:?S3r { rc:*b-> rc:?S1r {} } } }
  ]
]

/*In case of Merge Full, all nodes remain.*/
Sem<=>ASem block_sentenceBub_only : choose_merge
[
  leftside = [
c:?Tl {
  c:?S1l {
    c:?Root1l {
      c:*?r-> c:?X1l { c:id = ?id1 }
    }
    c:*b-> c:?S2l {
      c:?Root2l {
        c:*?s-> c:?X2l { c:coref_id = ?id1 }
      }
    }
  }
}

project_info.project.name.EXPLANATIONS

¬c:?N1l { c:?r1-> c:?Root1l {} }
¬c:?N2l { c:?r2-> c:?Root2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  rc:blocked_s_potential = "yes"
  blocked = "yes"
  rc:mergeBubOnly-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?Root1r {
  rc:<=> ?Root1l
  attach_coord = "yes"
}

¬rc:?S2r { rc:mergeObjProgress-> rc:?Ar {} }
¬rc:?S2r { rc:mergeSubjProgress-> rc:?Dr {} }
¬rc:?S2r { rc:mergeSubjProgressA0-> rc:?Gr {} }
¬rc:?S2r { rc:noMergeCoord-> rc:?Hr {} }
¬rc:?S1r { rc:mergeObjProgress-> rc:?Br {} }
¬rc:?S1r { rc:mergeSubjProgress-> rc:?Cr {} }
¬rc:?S1r { rc:mergeSubjProgressA0-> rc:?Er {} }
¬rc:?S1r { rc:mergeBubOnly-> rc:?Fr {} }
¬rc:?S1r { rc:noMergeCoord-> rc:?Gr {} }
¬rc:?S4r { rc:noMergeCoord-> rc:?S2r { rc:<=> ?S2l } }
  ]
]

Sem<=>ASem block_percolate : choose_merge
[
  leftside = [
c:?Xl {
  ¬c:slex = "Sentence"
  c:?r-> c:?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:blocked = "yes"
  rc:?r-> rc:?Yr {
    rc:<=> ?Yl
    blocked = "yes"
  }
}
  ]
]

/*When Region comes first, and Time second.

I didn't make the conditions for the other rules, to ensure that they don't apply in case this one does.*/
Sem<=>ASem merge_HighestTimeRegion1 : choose_merge
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
rc:?S2r {
  rc:<=> ?S2l
  rc:blockedHighest_potential = "yes"
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
  rc:mergeHighestTimeRegion-> rc:?S1r {
    rc:<=> ?S1l
  }
}
  ]
]

/*When Time comes first, and Region second. NOT TESTED.

I didn't make the conditions for the other rules, to ensure that they don't apply in case this one does.*/
Sem<=>ASem merge_HighestTimeRegion2 : choose_merge
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
        c:Time-> c:?Time2l {}
      }
    }
  }
}

?semN1 == ?semN2

c:?H1l { c:sem = "highest" c:A1-> c:?Building1l {} }
c:?H2l { c:sem = "highest" c:A1-> c:?Building2l {} c:Location-> c:?Loc {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?S2r {
  rc:<=> ?S2l
  rc:blockedHighest_potential = "yes"
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
  rc:mergeHighestTimeRegion-> rc:?S1r {
    rc:<=> ?S1l
  }
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

