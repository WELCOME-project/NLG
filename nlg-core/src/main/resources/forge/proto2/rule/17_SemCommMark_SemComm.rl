Sem<=>ASem transfer
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>ASem thematicity
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

Sem<=>ASem node_lexicon : transfer
[
  leftside = [
?Xl {
  ¬c:block = "yes"
  c:lex = ?lex
}

//¬ language.id.iso.EN
lexicon.?lex.lemma.?lem
  ]
  mixed = [

  ]
  rightside = [
?Xr{
  <=> ?Xl
  sem = ?lem
}
  ]
]

/*the generalizing noun takes the spot of the NP in the structure; the NP becomes an Elaboration, or a NonCore, see what works best.*/
Sem<=>ASem node_NP_generalization_substituted : transfer
[
  leftside = [
?Xl {
  c:block = "yes"
  add_NP_generalization = ?lexVC
  c:sem = ?lex
}

lexicon.?lexVC.lemma.?lem
lexicon.?lexVC.pos.?pos
  ]
  mixed = [

  ]
  rightside = [
?VCR {
  <=> ?Xl
  sem = ?lem
  pos = ?pos
  lex = ?lexVC
  added = "yes"
  id = #randInt()#
  NonCore-> ?Xr{
    <=> ?Xl
    sem = ?lex
    substituted = "yes"
    dsyntRel = ATTR
    type = "no_comma"
  }
}
  ]
]

Sem<=>ASem node_comparative : transfer
[
  leftside = [
c:?Xl{
  type = "comparative"
  A2-> c:?Yl{}
}

lexicon.miscellaneous.comparative.lex.?lex
lexicon.?lex.gp.A2.II
lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos
  ]
  mixed = [

  ]
  rightside = [
?More {
  sem = ?lem
  lex = ?lex
  pos = ?pos
  include = bubble_of_dep
  type = "comparative"
  A1-> rc:?Xr {
    rc:<=> ?Xl
  }
  A2-> rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

/*Transfers nodes not in the lexicon and bubbles.*/
Sem<=>ASem node_no_lexicon : transfer
[
  leftside = [
?Xl {
  ¬c:block = "yes"
}

( ( ?Xl { c:lex = ?lex } & ¬lexicon.?lex.lemma )
 | c:?Xl { c:?node {} } | ?Xl.pos == "CD" | ?Xl.type == META | ?Xl.type == "META" )
  ]
  mixed = [

  ]
  rightside = [
?Xr{
  <=> ?Xl
  sem = ?Xl.sem
}
  ]
]

Sem<=>ASem bubble_fill : transfer
[
  leftside = [
c:?Xl {
  c:?Yl{}
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr{
  rc: <=> ?Xl
  ¬rc:?Yr{
  rc:<=>?Yl
  }
  rc:+?Yr{
    rc:<=>?Yl
  }
}
  ]
]

Sem<=>ASem bubble_fill_semanteme : transfer
[
  leftside = [
c:?Xl {
  c:?Yl{}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Rr {
  rc:type = "added"
  rc:A1-> rc:?Yr {
    rc:<=> ?Yl
  }
}

rc:?Xr {
  rc: <=> ?Xl
  rc:?Yr {
    //rc:<=>?Yl
  }
  rc:+?Rr {
  }
}
  ]
]

Sem<=>DSynt bubble_expand_gov : transfer
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?bubble {
  rc:?Xr {
    rc:<=> ?Xl
    rc:?r-> rc:?Yr {
      rc:include = bubble_of_gov
    }
  }
  rc:+?Yr {}
}
  ]
]

/*Not needed so far*/
Sem<=>DSynt bubble_expand_dep : transfer
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

Sem<=>ASem transfer_rels : transfer
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*This is the generic rule for transferring attributes. We need to multiply it as much as attributes 
from the input nodes we want to transfer (and replace the values, of course).*/
Sem<=>ASem transfer_attributes : transfer
[
  leftside = [
c: ?Xl{
  attr = ?a
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr{
  rc: <=> ?Xl
  attr = ?a
}
  ]
]

/*The ?Br need to be opened again bc the comparison needs to be outside the node, but within  the scope of negation.
The OR in the rule aims at covering (the absence of) either nodes with more weight or nodes with the same weight but with a higher id -it could be lower, that decision is random).
For now, we can ignore the feature "type", given that we only find the main rheme and theme of the main sentence. However, if we decide
to also find the main rheme of the embedded propositions and */
excluded Sem<=>ASem mainest_rheme : thematicity
[
  leftside = [
c:?Bl {
  c:?Xl {
    c:verb_root = "possible"
    ¬isElaba2 = "yes"
    ¬bro = "2"
    c:id = ?i
 }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Br {
  rc:<=>?Bl
  rc:?Xr {
    rc:<=>?Xl
    rc:weight = ?w
    rc:id = ?m
    main_rheme = "yes"
    type = "main"
  }
}

¬(rc:?Br {rc:?Yr {rc:verb_root = "possible" ¬rc:isElaba2 = "yes"  rc:weight = ?y  rc:id = ?n
  }} & (?y > ?w | (?y == ?w & ?m > ?n)))
  ]
]

/*The ?Bl needs to be opened again bc the comparison needs to be outside the node, but within  the scope of negation.
The OR in the rule aims at covering (the absence of) either nodes with more weight or nodes with the same weight but with a higher id -it could be lower, that decision is random).
For now, we can ignore the feature "type", given that we only find the main rheme and theme of the main sentence. However, if we decide
to also find the main rheme of the embedded propositions and */
excluded Sem<=>ASem mainest_rheme_V_id0 : thematicity
[
  leftside = [
c:?Bl {
  c:?Xl {
    c:verb_root = "possible"
    c:weight = ?w
    //c:id = ?m
    ¬isElaba2 = "yes"
    ¬bro = "2"
 }
}

// if one node has a higher weight that others
¬(c:?Bl {c:?Yl {c:verb_root = "possible" ¬c:isElaba2 = "yes" c:weight = ?y }} & ?y > ?w )
   
// if two nodes have the same weight, do not apply rule to the smaller ID
// use first id0 if present
 (
¬(c:?Bl {c:?Z1l {c:verb_root = "possible" ¬c:isElaba2 = "yes"  c:weight = ?z1  c:id0 = ?n1 }}
   & c:?Xl { c:id0 = ?m1 } &  ?z1 == ?w
   // id0 is not always a numerical value!
   & ( ?m1 > ?n1 | ¬?m1 > 0 | ¬?n1 > 0 )
   )
 |   
// if no id0, use normal id
¬(c:?Bl {c:?Z2l {c:verb_root = "possible" ¬c:isElaba2 = "yes" c:weight = ?z2  c:id = ?n2 }}
   & c:?Xl { c:id = ?m2 } &  ( ?z2 == ?w & ?m2 > ?n2 )
   // one of the nodes has no id0, or one of the id0 is not a numerical value
   &  ( ¬c:?Z2l {c:id0 = ?id02z } | ¬c:?Xl {c:id0 = ?id02x } | ( c:?Z2l { c:id0 = ?id03 } & ¬?id03 > 0 ) | ( c:?Xl { c:id0 = ?id04 } & ¬?id04 > 0 ) )
   )
 )
  ]
  mixed = [

  ]
  rightside = [
//rc:?Br {
//  rc:<=>?Bl
  rc:?Xr {
    rc:<=>?Xl
//    rc:weight = ?w
//    rc:id = ?m
    main_rheme = "yes"
//    type = "main"
  }
//}
  ]
]

/*If both possible heads have an id0, but one of the id0 has no numerical value, use id.
ptb_train_9648*/
excluded Sem<=>ASem mainest_rheme_V_id0_NO_numerical : thematicity
[
  leftside = [
c:?Bl {
  c:?Xl {
    c:verb_root = "possible"
    c:weight = ?w
    c:id0 = ?id01
    c:id = ?m1
    //c:id = ?m
    ¬isElaba2 = "yes"
    ¬bro = "2"
 }
}

// if one node has a higher weight that others
¬(c:?Bl {c:?Yl {c:verb_root = "possible" ¬c:isElaba2 = "yes" c:weight = ?y }} & ?y > ?w )
   
// if two nodes have the same weight, do not apply rule to the smaller ID
( c:?Bl { ¬c:?Z1l { c:verb_root = "possible" } }
 |
  ( c:?Bl { c:?Z2l { c:verb_root = "possible" ¬c:isElaba2 = "yes" c:weight = ?z1 c:id0 = ?id02 c:id = ?n1 } }
   & ¬ ( ?id01 > 0 & ?id02 > 0 ) & ¬?id01 == ?id02 & ¬ (?z1 == ?w & ¬?m1 > ?n1 ) )
)
  ]
  mixed = [

  ]
  rightside = [
//rc:?Br {
//  rc:<=>?Bl
  rc:?Xr {
    rc:<=>?Xl
//    rc:weight = ?w
//    rc:id = ?m
    main_rheme = "yes"
//    type = "main"
  }
//}
  ]
]

/*If no id0 is available, use id.
ptb_train_9648*/
excluded Sem<=>ASem mainest_rheme_V_id : thematicity
[
  leftside = [
c:?Bl {
  c:?Xl {
    c:verb_root = "possible"
    c:weight = ?w
    ¬c:id0 = ?id0xl
    c:id = ?m1
    //c:id = ?m
    ¬isElaba2 = "yes"
    ¬bro = "2"
 }
}

// if one node has a higher weight that others
¬(c:?Bl {c:?Yl {c:verb_root = "possible" ¬c:isElaba2 = "yes" c:weight = ?y }} & ?y > ?w )
   
// if two nodes have the same weight, do not apply rule to the smaller ID

( c:?Bl { ¬c:?Z1l { c:verb_root = "possible" } }
 |
 ( c:?Bl { c:?Z2l { c:verb_root = "possible" ¬c:isElaba2 = "yes" c:weight = ?z1 c:id = ?n1 ¬c:id0 = ?id0zl } }
   & ¬ ( ?z1 == ?w & ?m1 > ?n1 ) )
)
  ]
  mixed = [

  ]
  rightside = [
//rc:?Br {
//  rc:<=>?Bl
  rc:?Xr {
    rc:<=>?Xl
//    rc:weight = ?w
//    rc:id = ?m
    main_rheme = "yes"
//    type = "main"
  }
//}
  ]
]

/*Replaces v_id0 rule, which does not work properly.
Interesting example with no numerical id0: ptb_train_9648
Rule only for cases in which no node has a higher or same weight in the structure.*/
Sem<=>ASem mainest_rheme_VA_highest_weight : thematicity
[
  leftside = [
c:?Bl {
  ¬c:has_main_rheme = "yes"
  c:?Xl {
    ( c:verb_root = "possible" | c:a_root = "possible" )
    c:weight = ?w
    //c:id0 = ?m1
    //c:id = ?m
    ¬isElaba2 = "yes"
    ¬isCoorda2 = "yes"
    ¬bro = "2"
 }
}

// see comments
¬ (c:?Bl {c:?Y1l { ( c:verb_root = "possible" | c:a_root = "possible" ) ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y1 } }
    & ?y1 > ?w )
¬ (c:?Bl {c:?Y2l { ( c:verb_root = "possible" | c:a_root = "possible" ) ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y2 } }
    & ?y2 == ?w & ¬ ?Y2l.id == ?Xl.id )
  ]
  mixed = [

  ]
  rightside = [
//rc:?Br {
//  rc:<=>?Bl
  rc:?Xr {
    rc:<=>?Xl
//    rc:weight = ?w
//    rc:id = ?m
    ¬rc:main_rheme = ?mrh
    main_rheme = "yes"
//    type = "main"
  }
//}
  ]
]

/*If there a v_root and an a_root have the same weight and no other root has a higher weight, choose, the verb.*/
Sem<=>ASem mainest_rheme_VA_same_weight_id0 : thematicity
[
  leftside = [
c:?Bl {
  ¬c:has_main_rheme = "yes"
  c:?Xl {
    c:verb_root = "possible"
    c:weight = ?w1
    c:id0 = ?id01
    ¬isElaba2 = "yes"
    ¬isCoorda2 = "yes"
    ¬bro = "2"
 }
  c:?Yl {
    c:a_root = "possible"
    c:weight = ?w2
    c:id0 = ?id02
    ¬isElaba2 = "yes"
    ¬isCoorda2 = "yes"
    ¬bro = "2"
 }
}

?w1 == ?w2

// there is no node with higher weight in the structure
¬(c:?Bl {c:?Z1l {( c:verb_root = "possible" | c:a_root = "possible" ) ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y1 }} & ?y1 > ?w1 )

// there is no other v_root with the same weight in the structure
¬(c:?Bl {c:?Z2l { c:verb_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y2 c:id0 = ?id0Z2 }} & ¬?id0Z2 == ?id01 & ?y2 == ?w1 )
  ]
  mixed = [

  ]
  rightside = [
//rc:?Br {
//  rc:<=>?Bl
  rc:?Xr {
    rc:<=>?Xl
//    rc:weight = ?w
//    rc:id = ?m
    ¬rc:main_rheme = ?mrh
    main_rheme = "yes"
//    type = "main"
  }
//}
  ]
]

/*If there a v_root and an a_root have the same weight and no other root has a higher weight, choose, the verb.*/
Sem<=>ASem mainest_rheme_VA_same_weight_id : thematicity
[
  leftside = [
c:?Bl {
  ¬c:has_main_rheme = "yes"
  c:?Xl {
    c:verb_root = "possible"
    c:weight = ?w1
    c:id = ?id01
    ¬isElaba2 = "yes"
    ¬isCoorda2 = "yes"
    ¬bro = "2"
 }
  c:?Yl {
    c:a_root = "possible"
    c:weight = ?w2
    c:id = ?id02
    ¬isElaba2 = "yes"
    ¬isCoorda2 = "yes"
    ¬bro = "2"
 }
}

?w1 == ?w2

// there is no node with higher weight in the structure
¬(c:?Bl {c:?Z1l {( c:verb_root = "possible" | c:a_root = "possible" ) ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y1 }} & ?y1 > ?w1 )

// there is no other v_root with the same weight in the structure
// 04/02/2021: added this condition quite quick, check it properly some day
¬(c:?Bl {c:?Z4l { c:verb_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y4 c:id = ?idZ4 }} & ¬?idZ4 == ?id01 & ?y4 == ?w1 )

// only applies if one of the other nodes with same weight has an id0 with no numerical value for id0
( c:?Xl { ¬c:id0 = ?id0x } | c:?Yl { ¬c:id0 = ?id0y }
 | (c:?Bl {c:?Z2l {c:verb_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y2 ¬c:id0 = ?id0z }} & ?y2 == ?w1 )
 | ( c:?Xl { c:id0 = ?id01 } & ¬?id01 > 0) | ( c:?Yl { c:id0 = ?id02 } & ¬?id02 > 0)
 | (c:?Bl {c:?Z3l {c:verb_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y3 c:id0 = ?id03 }} & ?y3 == ?w1 & ¬?id03 > 0 )
)
  ]
  mixed = [

  ]
  rightside = [
//rc:?Br {
//  rc:<=>?Bl
  rc:?Xr {
    rc:<=>?Xl
//    rc:weight = ?w
//    rc:id = ?m
    ¬rc:main_rheme = ?mrh
    main_rheme = "yes"
//    type = "main"
  }
//}
  ]
]

/*Replaces v_id0 rule, which does not work properly.
Interesting example with no numerical id0: ptb_train_9648
Rule for cases in which several nodes have the same weight.
If all nodes have a numerical value for id0.*/
Sem<=>ASem mainest_rheme_V_same_weight_id0 : thematicity
[
  leftside = [
c:?Bl {
  ¬c:has_main_rheme = "yes"
  c:?Xl {
    c:verb_root = "possible"
    c:weight = ?w1
    c:id0 = ?id01
    ¬isElaba2 = "yes"
    ¬isCoorda2 = "yes"
    ¬bro = "2"
 }
  c:?Yl {
    c:verb_root = "possible"
    c:weight = ?w2
    c:id0 = ?id02
    ¬isElaba2 = "yes"
    ¬isCoorda2 = "yes"
    ¬bro = "2"
 }
}

?w1 == ?w2
?id01 > 0
?id02 > 0
?id01 < ?id02

// there is no node with higher weight in the structure
¬(c:?Bl {c:?Z1l {( c:verb_root = "possible" | c:a_root = "possible" ) ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y1 }} & ?y1 > ?w1 )

// only applies if none of the other nodes with same weight has an id0 with no numerical value for id0
¬(c:?Bl {c:?Z2l {c:verb_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y2 c:id0 = ?id03 }}
  & ?y2 == ?w1 & ¬?id03 > 0
)

// only appliesto the node that has the smallest  id0
¬(c:?Bl {c:?Z3l {c:verb_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y3 c:id0 = ?id04 }}
  & ?y3 == ?w1 & ?id04 < ?id01
)
  ]
  mixed = [

  ]
  rightside = [
//rc:?Br {
//  rc:<=>?Bl
  rc:?Xr {
    rc:<=>?Xl
//    rc:weight = ?w
//    rc:id = ?m
    ¬rc:main_rheme = ?mrh
    main_rheme = "yes"
//    type = "main"
  }
//}
  ]
]

/*Replaces v_id0 rule, which does not work properly.
Interesting example with no numerical id0: ptb_train_9648
Rule for cases in which several nodes have the same weight.
If one of the nodes has a numerical value for id0.*/
Sem<=>ASem mainest_rheme_V_same_weight_id : thematicity
[
  leftside = [
c:?Bl {
  ¬c:has_main_rheme = "yes"
  c:?Xl {
    c:verb_root = "possible"
    c:weight = ?w1
    c:id = ?id1
    ¬isElaba2 = "yes"
    ¬isCoorda2 = "yes"
    ¬bro = "2"
 }
  c:?Yl {
    c:verb_root = "possible"
    c:weight = ?w2
    c:id = ?id2
    ¬isElaba2 = "yes"
    ¬isCoorda2 = "yes"
    ¬bro = "2"
 }
}

?w1 == ?w2

?id1 < ?id2

// there is no node with higher weight in the structure
¬(c:?Bl {c:?Z1l {( c:verb_root = "possible" | c:a_root = "possible" ) ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y1 }} & ?y1 > ?w1 )

// only applies if one of the other nodes with same weight has an id0 with no numerical value for id0
( c:?Xl { ¬c:id0 = ?id0x } | c:?Yl { ¬c:id0 = ?id0y }
 | (c:?Bl {c:?Z2l {c:verb_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y2 ¬c:id0 = ?id0z }} & ?y2 == ?w1 )
 | ( c:?Xl { c:id0 = ?id01 } & ¬?id01 > 0) | ( c:?Yl { c:id0 = ?id02 } & ¬?id02 > 0)
 | (c:?Bl {c:?Z3l {c:verb_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y3 c:id0 = ?id03 }} & ?y3 == ?w1 & ¬?id03 > 0 )
)

// only appliesto the node that has the smallest  id0
¬(c:?Bl {c:?Z4l {c:verb_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y4 c:id = ?id4 }}
  & ?y4 == ?w1 & ?id4 < ?id1
)
  ]
  mixed = [

  ]
  rightside = [
//rc:?Br {
//  rc:<=>?Bl
  rc:?Xr {
    rc:<=>?Xl
//    rc:weight = ?w
//    rc:id = ?m
    ¬rc:main_rheme = ?mrh
    main_rheme = "yes"
//    type = "main"
  }
//}
  ]
]

/*Replaces v_id0 rule, which does not work properly.
Interesting example with no numerical id0: ptb_train_9648
Rule only for cases in which no node has a higher or same weight in the structure.*/
excluded Sem<=>ASem mainest_rheme_A_highest_weight : thematicity
[
  leftside = [
c:?Bl {
  ¬c:has_main_rheme = "yes"
  ¬c:?Vl {
    ( c:verb_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" )
  }
  c:?Xl {
    c:a_root = "possible"
    c:weight = ?w
    //c:id0 = ?m1
    //c:id = ?m
    ¬isElaba2 = "yes"
    ¬isCoorda2 = "yes"
    ¬bro = "2"
 }
}

// see comments
¬ (c:?Bl {c:?Y1l {c:a_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y1 } } & ?y1 > ?w )
¬ (c:?Bl {c:?Y2l {c:a_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y2 } } & ?y2 == ?w & ¬ ?Y2l.id == ?Xl.id  )
  ]
  mixed = [

  ]
  rightside = [
//rc:?Br {
//  rc:<=>?Bl
  rc:?Xr {
    rc:<=>?Xl
//    rc:weight = ?w
//    rc:id = ?m
    ¬rc:main_rheme = ?mrh
    main_rheme = "yes"
//    type = "main"
  }
//}
  ]
]

/*Replaces v_id0 rule, which does not work properly.
Interesting example with no numerical id0: ptb_train_9648
Rule for cases in which several nodes have the same weight.
If all nodes have a numerical value for id0.*/
Sem<=>ASem mainest_rheme_A_same_weight_id0 : thematicity
[
  leftside = [
c:?Bl {
  ¬c:has_main_rheme = "yes"
//  ¬c:?Vl {
//    ( c:verb_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" )
//  }
  c:?Xl {
    c:a_root = "possible"
    c:weight = ?w1
    c:id0 = ?id01
    ¬isElaba2 = "yes"
    ¬isCoorda2 = "yes"
    ¬bro = "2"
 }
  c:?Yl {
    c:a_root = "possible"
    c:weight = ?w2
    c:id0 = ?id02
    ¬isElaba2 = "yes"
    ¬isCoorda2 = "yes"
    ¬bro = "2"
 }
}

?w1 == ?w2
?id01 > 0
?id02 > 0
?id01 < ?id02

// there is no node with higher weight in the structure
¬(c:?Bl {c:?Z1l { ( c:verb_root = "possible" | c:a_root = "possible" ) ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y1 }} & ?y1 > ?w1 )

// there is no  v_root with the same weight in the structure
¬(c:?Bl {c:?Z4l { c:verb_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y4 }} & ?y4 == ?w1 )

// only applies if none of the other nodes with same weight has an id0 with no numerical value for id0
¬(c:?Bl {c:?Z2l {c:a_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y2 c:id0 = ?id03 }}
  & ?y2 == ?w1 & ¬?id03 > 0
)

// only appliesto the node that has the smallest  id0
¬(c:?Bl {c:?Z3l {c:a_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y3 c:id0 = ?id04 }}
  & ?y3 == ?w1 & ?id04 < ?id01
)
  ]
  mixed = [

  ]
  rightside = [
//rc:?Br {
//  rc:<=>?Bl
  rc:?Xr {
    rc:<=>?Xl
//    rc:weight = ?w
//    rc:id = ?m
    ¬rc:main_rheme = ?mrh
    main_rheme = "yes"
//    type = "main"
  }
//}
  ]
]

/*Replaces v_id0 rule, which does not work properly.
Interesting example with no numerical id0: ptb_train_9648
Rule for cases in which several nodes have the same weight.
If one of the nodes has a numerical value for id0.*/
Sem<=>ASem mainest_rheme_A_same_weight_id : thematicity
[
  leftside = [
c:?Bl {
  ¬c:has_main_rheme = "yes"
//  ¬c:?Vl {
//    ( c:verb_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" )
//  }
  c:?Xl {
    c:a_root = "possible"
    c:weight = ?w1
    c:id = ?id1
    ¬isElaba2 = "yes"
    ¬isCoorda2 = "yes"
    ¬bro = "2"
 }
  c:?Yl {
    c:a_root = "possible"
    c:weight = ?w2
    c:id = ?id2
    ¬isElaba2 = "yes"
    ¬isCoorda2 = "yes"
    ¬bro = "2"
 }
}

?w1 == ?w2

?id1 < ?id2

// there is no node with higher weight in the structure
¬(c:?Bl {c:?Z1l { ( c:verb_root = "possible" | c:a_root = "possible" ) ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y1 }} & ?y1 > ?w1 )

// there is no  v_root with the same weight in the structure
¬(c:?Bl {c:?Z5l { c:verb_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y5 }} & ?y5 == ?w1 )

// only applies if one of the other nodes with same weight has an id0 with no numerical value for id0
( c:?Xl { ¬c:id0 = ?id0x } | c:?Yl { ¬c:id0 = ?id0y }
 | (c:?Bl {c:?Z2l {c:a_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y2 ¬c:id0 = ?id0z }} & ?y2 == ?w1 )
 | ( c:?Xl { c:id0 = ?id01 } & ¬?id01 > 0) | ( c:?Yl { c:id0 = ?id02 } & ¬?id02 > 0)
 | (c:?Bl {c:?Z3l {c:a_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y3 c:id0 = ?id03 }} & ?y3 == ?w1 & ¬?id03 > 0 )
)

// only appliesto the node that has the smallest  id0
¬(c:?Bl {c:?Z4l {c:a_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y4 c:id = ?id4 }}
  & ?y4 == ?w1 & ?id4 < ?id1
)
  ]
  mixed = [

  ]
  rightside = [
//rc:?Br {
//  rc:<=>?Bl
  rc:?Xr {
    rc:<=>?Xl
//    rc:weight = ?w
//    rc:id = ?m
    ¬rc:main_rheme = ?mrh
    main_rheme = "yes"
//    type = "main"
  }
//}
  ]
]

/*Replaces v_id0 rule, which does not work properly.
Interesting example with no numerical id0: ptb_train_9648
Rule only for cases in which no node has a higher or same weight in the structure.*/
Sem<=>ASem mainest_rheme_Loc_highest_weight : thematicity
[
  leftside = [
c:?Bl {
  ¬c:has_main_rheme = "yes"
  ¬c:?Vl {
    ( c:verb_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" )
  }
  ¬c:?Wl {
    ( c:a_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" )
  }
  c:?Xl {
    c:loc_root = "possible"
    c:weight = ?w
    //c:id0 = ?m1
    //c:id = ?m
    ¬isElaba2 = "yes"
    ¬isCoorda2 = "yes"
    ¬bro = "2"
 }
}

// see comments
¬ (c:?Bl {c:?Y1l {c:loc_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y1 } } & ?y1 > ?w )
¬ (c:?Bl {c:?Y2l {c:loc_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y2 } } & ?y2 == ?w & ¬ ?Y2l.id == ?Xl.id  )

// if there's an oper for the noun, allow for keeping the noun as the main rheme although there is a location root possible
// 190228_beAWARE_P2_IT, sentence 7
¬ ( c:?Xl { c:lex = ?lexX1 c:?r1-> c:?Dep1 {} } & lexicon.?lexX1.gp.?r1.I & lexicon.?lexX1.Oper1.?Oper1 & lexicon.?Oper1.lemma.?lem1 )
¬ ( c:?Xl { c:lex = ?lexX2 c:?r2-> c:?Dep2 {} } & lexicon.?lexX2.gp.?r2.II & lexicon.?lexX2.Oper2.?Oper2 & lexicon.?Oper2.lemma.?lem2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Semr {
  rc:sem = "locative_relation"
  rc:A1-> rc:?Xr {
    rc:<=>?Xl
  }
  ¬rc:main_rheme = ?mrh
  main_rheme = "yes"
}

// select only one locative_relation as main_rheme
¬ ( rc:?Semr {rc:id = ?idsr } & rc:?Sem2r { rc:id = ?ids2r rc:sem = "locative_relation" rc:A1-> rc:?Xr { rc:<=>?Xl }}
  & ?idsr < ?ids2r
)
  ]
]

/*Replaces v_id0 rule, which does not work properly.
Interesting example with no numerical id0: ptb_train_9648
Rule for cases in which several nodes have the same weight.
If all nodes have a numerical value for id0.*/
Sem<=>ASem mainest_rheme_Loc_same_weight_id0 : thematicity
[
  leftside = [
c:?Bl {
  ¬c:has_main_rheme = "yes"
  ¬c:?Vl {
   ( c:verb_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" )
  }
  ¬c:?Wl {
    ( c:a_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" )
  }
  c:?Xl {
    c:loc_root = "possible"
    c:weight = ?w1
    c:id0 = ?id01
    ¬isElaba2 = "yes"
    ¬isCoorda2 = "yes"
    ¬bro = "2"
 }
  c:?Yl {
    c:loc_root = "possible"
    c:weight = ?w2
    c:id0 = ?id02
    ¬isElaba2 = "yes"
    ¬isCoorda2 = "yes"
    ¬bro = "2"
 }
}

?w1 == ?w2
?id01 > 0
?id02 > 0
?id01 < ?id02

// there is no node with higher weight in the structure
¬(c:?Bl {c:?Z1l {c:loc_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y1 }} & ?y1 > ?w1 )

// only applies if none of the other nodes with same weight has an id0 with no numerical value for id0
¬(c:?Bl {c:?Z2l {c:loc_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y2 c:id0 = ?id03 }}
  & ?y2 == ?w1 & ¬?id03 > 0
)

// only appliesto the node that has the smallest  id0
¬(c:?Bl {c:?Z3l {c:loc_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y3 c:id0 = ?id04 }}
  & ?y3 == ?w1 & ?id04 < ?id01
)

// if there's an oper for the noun, allow for keeping the noun as the main rheme although there is a location root possible
// NOT TESTED
¬ ( c:?Xl { c:lex = ?lexX1 c:?r1-> c:?Dep1 {} } & lexicon.?lexX1.gp.?r1.I & lexicon.?lexX1.Oper1.?Oper1 & lexicon.?Oper1.lemma.?lem1 )
¬ ( c:?Xl { c:lex = ?lexX2 c:?r2-> c:?Dep2 {} } & lexicon.?lexX2.gp.?r2.II & lexicon.?lexX2.Oper2.?Oper2 & lexicon.?Oper2.lemma.?lem2 )

¬ ( c:?Yl { c:lex = ?lexY1 c:?r3-> c:?Dep3 {} } & lexicon.?lexY1.gp.?r3.I & lexicon.?lexY1.Oper1.?Oper3 & lexicon.?Oper3.lemma.?lem3 )
¬ ( c:?Yl { c:lex = ?lexY2 c:?r4-> c:?Dep4 {} } & lexicon.?lexY2.gp.?r4.II & lexicon.?lexY2.Oper2.?Oper4 & lexicon.?Oper4.lemma.?lem4 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Semr {
  rc:sem = "locative_relation"
  rc:A2-> rc:?Xr {
    rc:<=>?Xl
  }
  ¬rc:main_rheme = ?mrh
  main_rheme = "yes"
}

// select only one locative_relation as main_rheme
¬ ( rc:?Semr {rc:id = ?idsr } & rc:?Sem2r { rc:id = ?ids2r rc:sem = "locative_relation" rc:A2-> rc:?Xr { rc:<=>?Xl }}
  & ?idsr < ?ids2r
)
  ]
]

/*Replaces v_id0 rule, which does not work properly.
Interesting example with no numerical id0: ptb_train_9648
Rule for cases in which several nodes have the same weight.
If one of the nodes has a numerical value for id0.*/
Sem<=>ASem mainest_rheme_Loc_same_weight_id : thematicity
[
  leftside = [
c:?Bl {
  ¬c:has_main_rheme = "yes"
  ¬c:?Vl {
    ( c:verb_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" )
  }
  ¬c:?Wl {
    ( c:a_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" )
  }
  c:?Xl {
    c:loc_root = "possible"
    c:weight = ?w1
    c:id = ?id1
    ¬isElaba2 = "yes"
    ¬isCoorda2 = "yes"
    ¬bro = "2"
 }
  c:?Yl {
    c:loc_root = "possible"
    c:weight = ?w2
    c:id = ?id2
    ¬isElaba2 = "yes"
    ¬isCoorda2 = "yes"
    ¬bro = "2"
 }
}

?w1 == ?w2

?id1 < ?id2

// there is no node with higher weight in the structure
¬(c:?Bl {c:?Z1l {c:loc_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y1 }} & ?y1 > ?w1 )

// only applies if one of the other nodes with same weight has an id0 with no numerical value for id0
( c:?Xl { ¬c:id0 = ?id0x } | c:?Yl { ¬c:id0 = ?id0y }
 | (c:?Bl {c:?Z2l {c:loc_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y2 ¬c:id0 = ?id0z }} & ?y2 == ?w1 )
 | ( c:?Xl { c:id0 = ?id01 } & ¬?id01 > 0) | ( c:?Yl { c:id0 = ?id02 } & ¬?id02 > 0)
 | (c:?Bl {c:?Z3l {c:loc_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y3 c:id0 = ?id03 }} & ?y3 == ?w1 & ¬?id03 > 0 )
)

// only appliesto the node that has the smallest  id0
¬(c:?Bl {c:?Z4l {c:loc_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y4 c:id = ?id4 }}
  & ?y4 == ?w1 & ?id4 < ?id1
)

// if there's an oper for the noun, allow for keeping the noun as the main rheme although there is a location root possible
// NOT TESTED
¬ ( c:?Xl { c:lex = ?lexX1 c:?r1-> c:?Dep1 {} } & lexicon.?lexX1.gp.?r1.I & lexicon.?lexX1.Oper1.?Oper1 & lexicon.?Oper1.lemma.?lem1 )
¬ ( c:?Xl { c:lex = ?lexX2 c:?r2-> c:?Dep2 {} } & lexicon.?lexX2.gp.?r2.II & lexicon.?lexX2.Oper2.?Oper2 & lexicon.?Oper2.lemma.?lem2 )

¬ ( c:?Yl { c:lex = ?lexY1 c:?r3-> c:?Dep3 {} } & lexicon.?lexY1.gp.?r3.I & lexicon.?lexY1.Oper1.?Oper3 & lexicon.?Oper3.lemma.?lem3 )
¬ ( c:?Yl { c:lex = ?lexY2 c:?r4-> c:?Dep4 {} } & lexicon.?lexY2.gp.?r4.II & lexicon.?lexY2.Oper2.?Oper4 & lexicon.?Oper4.lemma.?lem4 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Semr {
  rc:sem = "locative_relation"
  rc:A2-> rc:?Xr {
    rc:<=>?Xl
  }
  ¬rc:main_rheme = ?mrh
  main_rheme = "yes"
}

// select only one locative_relation as main_rheme
¬ ( rc:?Semr {rc:id = ?idsr } & rc:?Sem2r { rc:id = ?ids2r rc:sem = "locative_relation" rc:A2-> rc:?Xr { rc:<=>?Xl }}
  & ?idsr < ?ids2r
)
  ]
]

/*Replaces v_id0 rule, which does not work properly.
Interesting example with no numerical id0: ptb_train_9648
Rule only for cases in which no node has a higher or same weight in the structure.*/
Sem<=>ASem mainest_rheme_N_highest_weight : thematicity
[
  leftside = [
c:?Bl {
  ¬c:has_main_rheme = "yes"
  ¬c:?Vl {
    ( c:verb_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" )
  }
  ¬c:?Wl {
    ( c:a_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" )
  }
  ¬c:?Zl {
    ( c:loc_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" )
  }
  c:?Xl {
    c:n_root = "possible"
    c:weight = ?w
    //c:id0 = ?m1
    //c:id = ?m
    ¬isElaba2 = "yes"
    ¬isCoorda2 = "yes"
    ¬bro = "2"
 }
}

// see comments
¬ (c:?Bl {c:?Y1l {c:n_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y1 } } & ?y1 > ?w )
¬ (c:?Bl {c:?Y2l {c:n_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y2 } } & ?y2 == ?w & ¬ ?Y2l.id == ?Xl.id  )

// if there's an oper for the noun, allow for keeping the noun as the main rheme although there is a location root possible
// 190228_beAWARE_P2_IT, sentence 7
( ¬ c:?Xl { c:loc_root = "possible" }
  |  ( c:?Xl { c:lex = ?lexX1 c:?r1-> c:?Dep1 {} } & lexicon.?lexX1.gp.?r1.I & lexicon.?lexX1.Oper1.?Oper1 & lexicon.?Oper1.lemma.?lem1 )
  |  ( c:?Xl { c:lex = ?lexX2 c:?r2-> c:?Dep2 {} } & lexicon.?lexX2.gp.?r2.II & lexicon.?lexX2.Oper2.?Oper2 & lexicon.?Oper2.lemma.?lem2 )
)
  ]
  mixed = [

  ]
  rightside = [
//rc:?Br {
//  rc:<=>?Bl
  rc:?Xr {
    rc:<=>?Xl
//    rc:weight = ?w
//    rc:id = ?m
    ¬rc:main_rheme = ?mrh
    main_rheme = "yes"
//    type = "main"
  }
//}
  ]
]

/*Replaces v_id0 rule, which does not work properly.
Interesting example with no numerical id0: ptb_train_9648
Rule for cases in which several nodes have the same weight.
If all nodes have a numerical value for id0.*/
Sem<=>ASem mainest_rheme_N_same_weight_id0 : thematicity
[
  leftside = [
c:?Bl {
  ¬c:has_main_rheme = "yes"
  ¬c:?Vl {
   ( c:verb_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" )
  }
  ¬c:?Wl {
    ( c:a_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" )
  }
  ¬c:?Zl {
    ( c:loc_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" )
  }
  c:?Xl {
    c:n_root = "possible"
    c:weight = ?w1
    c:id0 = ?id01
    ¬isElaba2 = "yes"
    ¬isCoorda2 = "yes"
    ¬bro = "2"
 }
  c:?Yl {
    c:n_root = "possible"
    c:weight = ?w2
    c:id0 = ?id02
    ¬isElaba2 = "yes"
    ¬isCoorda2 = "yes"
    ¬bro = "2"
 }
}

?w1 == ?w2
?id01 > 0
?id02 > 0
?id01 < ?id02

// there is no node with higher weight in the structure
¬(c:?Bl {c:?Z1l {c:n_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y1 }} & ?y1 > ?w1 )

// only applies if none of the other nodes with same weight has an id0 with no numerical value for id0
¬(c:?Bl {c:?Z2l {c:n_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y2 c:id0 = ?id03 }}
  & ?y2 == ?w1 & ¬?id03 > 0
)

// only appliesto the node that has the smallest  id0
¬(c:?Bl {c:?Z3l {c:n_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y3 c:id0 = ?id04 }}
  & ?y3 == ?w1 & ?id04 < ?id01
)

// if there's an oper for the noun, allow for keeping the noun as the main rheme although there is a location root possible
// NOT TESTED
( ¬ c:?Xl { c:loc_root = "possible" }
  |  ( c:?Xl { c:lex = ?lexX1 c:?r1-> c:?Dep1 {} } & lexicon.?lexX1.gp.?r1.I & lexicon.?lexX1.Oper1.?Oper1 & lexicon.?Oper1.lemma.?lem1 )
  |  ( c:?Xl { c:lex = ?lexX2 c:?r2-> c:?Dep2 {} } & lexicon.?lexX2.gp.?r2.II & lexicon.?lexX2.Oper2.?Oper2 & lexicon.?Oper2.lemma.?lem2 )
)

( ¬ c:?Yl { c:loc_root = "possible" }
  | ( c:?Yl { c:lex = ?lexY1 c:?r3-> c:?Dep3 {} } & lexicon.?lexY1.gp.?r3.I & lexicon.?lexY1.Oper1.?Oper3 & lexicon.?Oper3.lemma.?lem3 )
  | ( c:?Yl { c:lex = ?lexY2 c:?r4-> c:?Dep4 {} } & lexicon.?lexY2.gp.?r4.II & lexicon.?lexY2.Oper2.?Oper4 & lexicon.?Oper4.lemma.?lem4 )
)
  ]
  mixed = [

  ]
  rightside = [
//rc:?Br {
//  rc:<=>?Bl
  rc:?Xr {
    rc:<=>?Xl
//    rc:weight = ?w
//    rc:id = ?m
    ¬rc:main_rheme = ?mrh
    main_rheme = "yes"
//    type = "main"
  }
//}
  ]
]

/*Replaces v_id0 rule, which does not work properly.
Interesting example with no numerical id0: ptb_train_9648
Rule for cases in which several nodes have the same weight.
If one of the nodes has a numerical value for id0.*/
Sem<=>ASem mainest_rheme_N_same_weight_id : thematicity
[
  leftside = [
c:?Bl {
  ¬c:has_main_rheme = "yes"
  ¬c:?Vl {
    ( c:verb_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" )
  }
  ¬c:?Wl {
    ( c:a_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" )
  }
  ¬c:?Zl {
    ( c:loc_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" )
  }
  c:?Xl {
    c:n_root = "possible"
    c:weight = ?w1
    c:id = ?id1
    ¬isElaba2 = "yes"
    ¬isCoorda2 = "yes"
    ¬bro = "2"
 }
  c:?Yl {
    c:n_root = "possible"
    c:weight = ?w2
    c:id = ?id2
    ¬isElaba2 = "yes"
    ¬isCoorda2 = "yes"
    ¬bro = "2"
 }
}

?w1 == ?w2

?id1 < ?id2

// there is no node with higher weight in the structure
¬(c:?Bl {c:?Z1l {c:n_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y1 }} & ?y1 > ?w1 )

// only applies if one of the other nodes with same weight has an id0 with no numerical value for id0
( c:?Xl { ¬c:id0 = ?id0x } | c:?Yl { ¬c:id0 = ?id0y }
 | (c:?Bl {c:?Z2l {c:n_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y2 ¬c:id0 = ?id0z }} & ?y2 == ?w1 )
 | ( c:?Xl { c:id0 = ?id01 } & ¬?id01 > 0) | ( c:?Yl { c:id0 = ?id02 } & ¬?id02 > 0)
 | (c:?Bl {c:?Z3l {c:n_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y3 c:id0 = ?id03 }} & ?y3 == ?w1 & ¬?id03 > 0 )
)

// only appliesto the node that has the smallest  id0
¬(c:?Bl {c:?Z4l {c:n_root = "possible" ¬c:isElaba2 = "yes" ¬isCoorda2 = "yes" c:weight = ?y4 c:id = ?id4 }}
  & ?y4 == ?w1 & ?id4 < ?id1
)

// if there's an oper for the noun, allow for keeping the noun as the main rheme although there is a location root possible
// NOT TESTED
( ¬ c:?Xl { c:loc_root = "possible" }
  |  ( c:?Xl { c:lex = ?lexX1 c:?r1-> c:?Dep1 {} } & lexicon.?lexX1.gp.?r1.I & lexicon.?lexX1.Oper1.?Oper1 & lexicon.?Oper1.lemma.?lem1 )
  |  ( c:?Xl { c:lex = ?lexX2 c:?r2-> c:?Dep2 {} } & lexicon.?lexX2.gp.?r2.II & lexicon.?lexX2.Oper2.?Oper2 & lexicon.?Oper2.lemma.?lem2 )
)

( ¬ c:?Yl { c:loc_root = "possible" }
  | ( c:?Yl { c:lex = ?lexY1 c:?r3-> c:?Dep3 {} } & lexicon.?lexY1.gp.?r3.I & lexicon.?lexY1.Oper1.?Oper3 & lexicon.?Oper3.lemma.?lem3 )
  | ( c:?Yl { c:lex = ?lexY2 c:?r4-> c:?Dep4 {} } & lexicon.?lexY2.gp.?r4.II & lexicon.?lexY2.Oper2.?Oper4 & lexicon.?Oper4.lemma.?lem4 )
)
  ]
  mixed = [

  ]
  rightside = [
//rc:?Br {
//  rc:<=>?Bl
  rc:?Xr {
    rc:<=>?Xl
//    rc:weight = ?w
//    rc:id = ?m
    ¬rc:main_rheme = ?mrh
    main_rheme = "yes"
//    type = "main"
  }
//}
  ]
]

/*It's always necessary to "anchor" the RS. So, in order to locate the right proposition,
either we use correspondence or we establish that there is already a node inside.*/
Sem<=>ASem mainest_theme_V : thematicity
[
  leftside = [
c:?Xl {
  (c:dpos = "VB" | c:pos = "V" | c:pos = "VB" | c:dpos = "V")
  c:lex = ?L
  c:id = ?i
  c:?r-> c:?Yl {}
  // there isn't already a sibling marked as main theme
  ¬c:?s2-> c:?Y2l { c:main_theme = "yes" }
}

(?r == A0  | (?r == A1 & lexicon._predicate_._predicateNoExtArg_._verb_.?L))
  ]
  mixed = [

  ]
  rightside = [
rc:?P {
  rc:sem = "Sentence"
  rc:?Xr {
      rc:<=> ?Xl
      rc:main_rheme = "yes"
//      rc:type = "main"
    } 

  rc:?Yr {
    rc:<=> ?Yl
    main_theme = "yes"
  }
}
  ]
]

/*This rule looks for locating those embedded main rhemes.*/
excluded Sem<=>ASem embedded_main_rheme : thematicity
[
  leftside = [
c:?S {
  c:?Xl {
    (c:dpos = "VB" | c:pos = "V")
    c:weight = ?w
    c:id = ?i
    ¬c:bro = "2"
  }
}

(?w > 2 | ?w == 2)
  ]
  mixed = [

  ]
  rightside = [
rc:?Sr {
  rc:<=>?S
  rc:?Xr {
    rc:<=>?Xl
    rc:weight = ?w
    rc:id = ?m
    main_rheme = "yes"
    type = "embedded"
  }
}

(rc:?Sr {rc:?Yr {rc:verb_root = "possible" ¬rc:isElaba2 = "yes"  rc:weight = ?y  rc:id = ?n
  }} & (?y > ?w | (?y == ?w & ?m > ?n)))
  ]
]

/*This rule looks for locating those main secondary rhemes (rhemes that are brothers of the main rheme).*/
excluded Sem<=>ASem mainest_sec_rheme : thematicity
[
  leftside = [
c:?Xl {
  (c:dpos = "VB" | c:pos = "V")
  c:bro = "2"
  c:son_is = ?s
  c:?r->  c:?Yl {c:sem = ?s}
}

c:?Zl {
  (c:dpos = "VB" | c:pos = "V")
  c:bro = "1"
  c:son_is = ?s
  c:?t->  c:?Yl {c:sem = ?s}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=>?Zl
  rc:main_rheme = "yes"
  rc:type = "main"
    }
rc:?Xr {
  rc:<=>?Xl
  rc:bro = "2"
  rc:son_is = ?s
  main_rheme = "yes"
  type = "main_sec"
}
  ]
]

/*This rule looks for locating those embedded secondary rhemes (rhemes that are brothers of the embedded main rheme).*/
excluded Sem<=>ASem embedded_sec_rheme : thematicity
[
  leftside = [
c:?Xl {
  (c:dpos = "VB" | c:pos = "V")
  c:bro = "2"
  c:son_is = ?s
  c:?r->  c:?Yl {c:sem = ?s}
}

c:?Zl {
  (c:dpos = "VB" | c:pos = "V")
  c:bro = "1"
  c:son_is = ?s
  c:?t->  c:?Yl {c:sem = ?s}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=>?Zl
  rc:main_rheme = "yes"
  rc:type = "embedded"
    }
rc:?Xr {
  rc:<=>?Xl
  rc:bro = "2"
  rc:son_is = ?s
  main_rheme = "yes"
  type = "embedded_sec"
}
  ]
]

/*This rule looks for locating those embedded main themes.*/
excluded Sem<=>ASem embedded_main_theme : thematicity
[
  leftside = [
c:?Xl {
  (c:dpos = "VB" | c:pos = "V")
  c:lex = ?L
  c:id = ?i
  c:?r-> c:?Yl {}
}

(?r == A0  | (?r == A1 & lexicon._predicate_._predicateNoExtArg_._verb_.?L))
  ]
  mixed = [

  ]
  rightside = [
rc:?P {
  rc:sem = "Sentence"
  rc:?Xr {
      rc:<=> ?Xl
      rc:main_rheme = "yes"
      rc:type = "embedded"
    } 

  rc:?Yr {
    rc:<=> ?Yl
    main_theme = "yes"
    type = "embedded"
    }
}
  ]
]

/*This rule looks for locating those main secondary themes (themes corresponding to those brothers of the main rheme).*/
excluded Sem<=>ASem mainest_sec_theme : thematicity
[
  leftside = [
c:?Xl {
  (c:dpos = "VB" | c:pos = "V")
  c:lex = ?L
  c:id = ?i
  c:?r-> c:?Yl {}
}

(?r == A0  | (?r == A1 & lexicon._predicate_._predicateNoExtArg_._verb_.?L))
  ]
  mixed = [

  ]
  rightside = [
rc:?P {
  rc:sem = "Sentence"
  rc:?Xr {
      rc:<=> ?Xl
      rc:main_rheme = "yes"
      rc:type = "main_sec"
    } 

  rc:?Yr {
    rc:<=> ?Yl
    ¬rc:main_theme = "yes"
    main_theme = "yes"
    type = "main_sec"
    }
}
  ]
]

/*This rule looks for locating those embedded secondary themes (themes that correspond to those embedded secondary themes).*/
excluded Sem<=>ASem embedded_sec_theme : thematicity
[
  leftside = [
c:?Xl {
  (c:dpos = "VB" | c:pos = "V")
  c:lex = ?L
  c:id = ?i
  c:?r-> c:?Yl {}
}

(?r == A0  | (?r == A1 & lexicon._predicate_._predicateNoExtArg_._verb_.?L))
  ]
  mixed = [

  ]
  rightside = [
rc:?P {
  rc:sem = "Sentence"
  rc:?Xr {
      rc:<=> ?Xl
      rc:main_rheme = "yes"
      rc:type = "embedded_sec"
    } 

  rc:?Yr {
    rc:<=> ?Yl
    ¬rc:main_theme = "yes"
    main_theme = "yes"
    type = "embedded_sec"
    }
}
  ]
]

/*Marks if a semanteme is already realized as a word in the structure (e.g., if "purpose" already has an A2 that is "for").
If not, we'll introduce a new node in the Sem-DSynt mapping. I did not mamage to check this during this mapping.
(not possible to have a negative condition about the presence of a particular element in the semanticon)*/
Sem<=>ASem EN_mark_semanteme_realized : markers
[
  leftside = [
c:?Zl {}

language.id.iso.EN
  ]
  mixed = [
semanticon.?d1.gen.lex.?lex
lexicon.?lex.lemma.?lem

// the word corresponding to the semanteme is  already in the structure
?lem == ?d2
  ]
  rightside = [
rc:?Xr {
  semanteme = "realized"
  rc:sem = ?d1
  rc:A2-> rc:?Zr {
    rc:<=> ?Zl
    rc:sem = ?d2
  }
}
  ]
]

/*For MULTISENSOR, mark all semantemes as realized?
Exclude Purpose so far, since it seems like it's the reason why the mark_semantemes rules was done in the first place.*/
Sem<=>ASem EN_MS_mark_semanteme_realized : markers
[
  leftside = [
c:?Zl {}

language.id.iso.EN

project_info.project.name.MULTISENSOR
  ]
  mixed = [
?d2 == ?d1
semanticon.?d2.lex
¬?d2 == "purpose"
  ]
  rightside = [
rc:?Xr {
  semanteme = "realized"
  rc:sem = ?d1
  rc:A2-> rc:?Zr {
    rc:<=> ?Zl
  }
}
  ]
]

/*The presence of a third argument or not has an impact on the linerization.
E.g. if a verb has a second argument and no first, the subject is linearized after the passive verb unless there is a third argument.
This feat is added here because beacuse of some erroneous inputs, sometimes a Time or Location relation is actually a 3rd arg.
(Time and Location relations are lost after this transduction)*/
Sem<=>ASem CA_ES_mark_3rd_arg : markers
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  c:?r-> c:?Yl {}
}

( language.id.iso.ES | language.id.iso.CA )

( lexicon.?lex.gp.?r.III | ( lexicon.?lex.gp.?r.II & lexicon.?lex.reflexive.?yes ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  has3rdArg = "yes"
  ¬rc:substituted = "yes"
}
  ]
]

/*The presence of a third argument or not has an impact on the linerization.
E.g. if a verb has a second argument and no first, the subject is linearized after the passive verb unless there is a third argument.
This feat is added here because beacuse of some erroneous inputs, sometimes a Time or Location relation is actually a 3rd arg.
(Time and Location relations are lost after this transduction)*/
Sem<=>ASem ES_PATCH_mark_3rd_arg_Time : markers
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  c:Time-> c:?Yl {}
}

language.id.iso.ES

( ?lex == "acabar_VB_01" | ?lex == "construir_VB_01" | ?lex == "empezar_VB_01" | ?lex == "inaugurar_VB_01" | ?lex == "iniciar_VB_01"
 | ?lex == "retirar_VB_01" | ?lex == "terminar_VB_01" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  has3rdArg = "yes"
  ¬rc:substituted = "yes"
}
  ]
]

/*The presence of a third argument or not has an impact on the linerization.
E.g. if a verb has a second argument and no first, the subject is linearized after the passive verb unless there is a third argument.
This feat is added here because beacuse of some erroneous inputs, sometimes a Time or Location relation is actually a 3rd arg.
(Time and Location relations are lost after this transduction)*/
Sem<=>ASem ES_PATCH_mark_3rd_arg_Location : markers
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  c:Location-> c:?Yl {}
}

language.id.iso.ES

( ?lex == "encontrar_VB_01" | ?lex == "hablar_VB_01" | ?lex == "publicar_VB_01" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  has3rdArg = "yes"
  ¬rc:substituted = "yes"
}
  ]
]

Sem<=>ASem mark_SameLocation_percolate : markers
[
  leftside = [
c: ?Xl{
  c:Location-> c:?Yl{
    c:SameLocAsPrevious = "YES"
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?ELAB {
  rc:sem = "locative_relation"
  rc:type = "added"
  SameLocAsPrevious = "YES"
  rc:A2-> rc: ?Yr {
     rc:<=> ?Yl
  }
}
  ]
]

Sem<=>ASem mark_SameTime_percolate : markers
[
  leftside = [
c: ?Xl{
  c:Location-> c:?Yl{
    c:SameTimeAsPrevious = "YES"
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?ELAB {
  rc:sem = "locative_relation"
  rc:type = "added"
  SameTimeAsPrevious = "YES"
  rc:A2-> rc: ?Yr {
     rc:<=> ?Yl
  }
}
  ]
]

Sem<=>ASem mark_embedded_rheme_parataxis : markers
[
  leftside = [
c:?Xl {
  c:Parataxis-> c:?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:main_rheme = "yes"
  rc:Parataxis-> rc:?Yr {
    rc:<=> ?Yl
    main_rheme = "yes"
  }
}
  ]
]

/*Embedded verbs eV can be realised as relative clauses or participial clauses.
The (basic) hypotheses are the following:
- an eV with only an A2 will be realised as a participle (e.g. there are a lot of translated books).
- an eV with A1 and A2 will be realised as a relative if it is part of the rheme (Norton stars in Fight Club, which was directed by Fincher).
- an eV with A1 and A2 will be realised as a participle if it modifies the main theme  (Fight Club, directed by Fincher, is an american movie).

This rule marks verbs which are modifying a main theme.*/
Sem<=>ASem mark_VB_embedded : markers
[
  leftside = [
c:?V1l {
  c:?r-> c:?Th {}
}

c:?V2l {
  c:pos = "VB"
  c:?s-> c:?Th {}
}

¬?V1l.id == ?V2l.id
  ]
  mixed = [

  ]
  rightside = [
rc:?V1r {
  rc:<=> ?V1l
  rc:main_rheme = "yes"
}

rc:?V2r {
  rc:<=> ?V2l
  theme_modif = "yes"
}



( rc:?Thr { rc:<=> ?Th rc:main_theme = "yes" }
  | rc:?V1r { rc:A0-> rc:?Thr { rc:<=> ?Th } }
  | rc:?V1r { rc:A1-> rc:?Thr { rc:<=> ?Th } ¬rc:A0-> rc:?A0 {} }
  // In the following case A1 will be realised as a predicative complement usually
  | rc:?V1r { rc:A2-> rc:?Thr { rc:<=> ?Th } rc:A1-> rc:?Or { rc:pos = "CD" } }
)
  ]
]

/*NOT TESTED!*/
Sem<=>ASem mark_VB_embedded_COORD : markers
[
  leftside = [
c:?V1l {
  c:?r->  c:?And {
    c:Set-> c:?Th {
      c:member = ?M
    }
  }
}

c:?V2l {
  c:pos = "VB"
  c:?s-> c:?Th {}
}

¬?V1l.id == ?V2l.id
  ]
  mixed = [

  ]
  rightside = [
rc:?V1r {
  rc:<=> ?V1l
  rc:main_rheme = "yes"
}

rc:?V2r {
  rc:<=> ?V2l
  theme_modif = "yes"
}



( rc:?Thr { rc:<=> ?Th rc:main_theme = "yes" }
  | ( rc:?V1r { rc:A0-> rc:?AndR { rc:<=> ?And rc:?MR-> rc:?Thr { rc:<=> ?Th } } } & ?MR == ?M )
  | ( rc:?V1r { rc:A1-> rc:?And2R { rc:<=> ?And rc:?M2R-> rc:?Thr { rc:<=> ?Th } ¬rc:A0-> rc:?A0 {} } } & ?M2R == ?M )
  // In the following case A1 will be realised as a predicative complement usually
  | ( rc:?V1r { rc:A2-> rc:?And3R { rc:<=> ?And rc:?M3R-> rc:?Thr { rc:<=> ?Th } rc:A1-> rc:?Or { rc:pos = "CD" } } } & ?M3R == ?M )
)
  ]
]

/*Embedded verbs eV can be realised as relative clauses or participial clauses.
The (basic) hypotheses are the following:
- an eV with only an A2 will be realised as a participle (e.g. there are a lot of translated books).
- an eV with A1 and A2 will be realised as a relative if it is part of the rheme (Norton stars in Fight Club, which was directed by Fincher).
- an eV with A1 and A2 will be realised as a participle if it modifies the main theme  (Fight Club, directed by Fincher, is an american movie).

This rule marks verbs which are modifying a main theme.*/
Sem<=>ASem mark_VB_embedded2 : markers
[
  leftside = [
c:?V1l {
  c:?r-> c:?Interm {
    c:?t-> c:?Th {}
  }
}

c:?V2l {
  c:pos = "VB"
  c:?s-> c:?Th {}
}

¬?V1l.id == ?V2l.id

// To be safe for the moment...
¬c:?Gov { c:?govRel-> c:?V2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?V1r {
  rc:<=> ?V1l
  rc:main_rheme = "yes"
}

rc:?V2r {
  rc:<=> ?V2l
  theme_modif = "yes"
}



( rc:?Thr { rc:<=> ?Th rc:main_theme = "yes" }
  | rc:?V1r { rc:A0-> rc:?Thr { rc:<=> ?Th } }
  | rc:?V1r { rc:A1-> rc:?Thr { rc:<=> ?Th } ¬rc:A0-> rc:?A0 {} }
  | rc:?V1r { rc:A1-> rc:?IntermR { rc:<=> ?Interm rc:?t-> rc:?Thr { rc:<=> ?Th } } ¬rc:A0-> rc:?A0 {} }
  // In the following case A1 will be realised as a predicative complement usually
  | rc:?V1r { rc:A2-> rc:?Thr { rc:<=> ?Th } rc:A1-> rc:?Or { rc:pos = "CD" } }
)
  ]
]

/*Embedded verbs eV can be realised as relative clauses or participial clauses.
The (basic) hypotheses are the following:
- an eV with only an A2 will be realised as a participle (e.g. there are a lot of translated books).
- an eV with A1 and A2 will be realised as a relative if it is part of the rheme (Norton stars in Fight Club, which was directed by Fincher).
- an eV with A1 and A2 will be realised as a participle if it modifies the main theme  (Fight Club, directed by Fincher, is an american movie).

This rule marks verbs which are modifying a main theme.*/
Sem<=>ASem mark_VB_embedded2_COORD : markers
[
  leftside = [
c:?V1l {
  //c:id = ?idV1
  c:?r-> c:?And {
    c:Set-> c:?Interm {
      c:member = ?M
      c:?t-> c:?Th {}
    }
  }
}

c:?V2l {
  c:pos = "VB"
  //c:id = ?idV2
  c:?s-> c:?Th {}
}

¬?V1l.id == ?V2l.id

// To be safe for the moment...
¬c:?Gov { c:?govRel-> c:?V2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?V1r {
  rc:<=> ?V1l
  rc:main_rheme = "yes"
}

rc:?V2r {
  rc:<=> ?V2l
  theme_modif = "yes"
}



rc:?V1r { rc:A1-> rc:?AndR { rc:<=> ?And rc:?MR-> rc:?IntermR { rc:<=> ?Interm rc:?t-> rc:?Thr { rc:<=> ?Th } } ¬rc:A0-> rc:?A0 {} } }

?MR == ?M
  ]
]

/*If two (or more) subgraphs with a repeated circmustancial (for now limited to semantemes)
  have been aggregated together in the previous steps, and the main communicative node of the sentence is one of these circumstancials (or is linked to this circum.),
  then we only keep the circumstancial on the main node and block the others.
Example: 210929_xR4DRAM_P1 str 3 and 7.*/
Sem<=>ASem mark_block_shared_circumstancial : markers
[
  leftside = [
c:?Coord {
  c:sem = "and"
  c:Set-> c:?Conj1l {
    c:?r1-> c:?Circum1l {
      c:sem = ?sC1
    }
  }
  c:Set-> c:?Conj2l {
    c:?r2-> c:?Circum2l {
      c:sem = ?sC2
    }
  }
}

// Circumstancials are the same
?r1 == ?r2
?sC1 == ?sC2
// Need to check that both subtrees are identical; for now exclude cases with dependents.
¬ c:?Circum1l { c:?s1-> c:?D1 {} }
¬ c:?Circum2l { c:?s2-> c:?D2 {} }

// Consider extending to other relations
( ?r1 == Location | ?r1 == Time )
  ]
  mixed = [

  ]
  rightside = [
rc:?Sem1R {
  rc:type = "added"
  rc:main_rheme = "yes"
  rc:A1-> rc:?Conj1R {
    rc:<=> ?Conj1l
  }
  rc:A2-> rc:?Circum1r {
    rc:<=> ?Circum1l
  }
}

rc:?Sem2R {
  rc:type = "added"
  blocked = "YES"
  rc:A1-> rc:?Conj2R {
    rc:<=> ?Conj2l
  }
  rc:A2-> rc:?Circum2r {
    rc:<=> ?Circum2l
    blocked = "YES"
  }
}
  ]
]

/*If a node X2 has a coreference relation with a NE node of another bubble in which there is another NE, mark X2.*/
excluded Sem<=>ASem mark_ambiguous_antecedent_coref : markers
[
  leftside = [
c:?S1l {
  c:?X1l {
    c:id = ?id1
    c:NE = "YES"
  }
  c:?X3l {
    c:NE = "YES"
    c:id = ?id3
  }
  c:*b-> c:?S2l {
    c:?X2l {
      c:<-> c:?X1l {}
    } 
  }
}

¬ ?id1 == ?id3

( ( c:?X1l { ¬c:class = ?mX1 } & c:?X3l { ¬c:class = ?mX3 } ) | ?X1l.class == ?X3l.class )

c:?X1l { ¬ c:<-> c:?X3l {} }
c:?X3l { ¬ c:<-> c:?X1l {} }
¬ ( c:?X1l { c:<-> c:?Xante {} } & c:?X3l { c:<-> c:?Xante {} } )

¬ ( c:?X3l { c:sem = ?sx } & ( ?sx == 0 |  ?sx < 0 | ?sx > 0 | ?sx == "e-book" ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?X2r {
  rc:<=> ?X2l
  ambiguous_antecedent = "yes"
}
  ]
]

Sem<=>ASem rel_copy : transfer_rels
[
  leftside = [
c:?Xl{
  ?r-> c:?Yl{}
}

// See rels_wrong
¬ ( c:?Xl { c:?attr = "wrong" }  & ?attr == ?r )
// See corresponding rels
¬?r == Anteriority_Time
¬?r == Benefactive
¬?r == Direction
¬?r == Duration
¬?r == Elaboration
¬?r == End_Time
¬?r == Extent
¬?r == Frequency
¬?r == Location
¬?r == Manner
¬?r == NonCore
¬?r == Posteriority_Time
¬?r == Quantity
¬?r == Temporal_Overlap
¬?r == Purpose
¬?r == Set
¬?r == Start_Time
¬?r == Time

¬ ( ?Xl.type == "comparative" & ?r == A2 & lexicon.miscellaneous.comparative.lex.?lex & lexicon.?lex.gp.A2.II )
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  ¬rc:substituted = "yes"
  ?r-> rc: ?Yr {
     rc:<=> ?Yl
    ¬rc:substituted = "yes"
  }
}
  ]
]

Sem<=>ASem rel_wrong : transfer_rels
[
  leftside = [
c: ?Xl {
  c:?attr = "wrong"
  ?r-> c:?Yl{}
}

?attr == ?r

lexicon._predicateExtArg_.gp.?r.?DSyntR
lexicon._predicateNoExtArg_.gp.?rNew.?DSyntR
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  ¬rc:substituted = "yes"
  ?rNew-> rc: ?Yr {
     rc:<=> ?Yl
    ¬rc:substituted = "yes"
  }
}
  ]
]

Sem<=>ASem rel_precedence : transfer_rels
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
  ¬rc:substituted = "yes"
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:substituted = "yes"
  }
}
  ]
]

Sem<=>ASem rel_coref : transfer_rels
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
  ¬rc:substituted = "yes"
  <-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:substituted = "yes"
  }
}
  ]
]

Sem<=>ASem rel_elaboration : transfer_rels
[
  leftside = [
c: ?Xl{
  Elaboration-> c:?Yl{}
}
  ]
  mixed = [

  ]
  rightside = [
?ELAB {
  sem = "ELABORATION"
  type = "added"
  id = #randInt()#
  A1-> rc: ?Xr {
    rc:<=> ?Xl
    ¬rc:substituted = "yes"
  }
  A2-> rc: ?Yr {
     rc:<=> ?Yl
    ¬rc:substituted = "yes"
  }
}
  ]
]

Sem<=>ASem rel_Anteriority : transfer_rels
[
  leftside = [
c: ?Xl{
  Anteriority_Time-> c:?Yl{}
}
  ]
  mixed = [

  ]
  rightside = [
?ELAB {
  sem = "anteriority_time"
  type = "added"
  id = #randInt()#
  A1-> rc: ?Xr {
    rc:<=> ?Xl
    ¬rc:substituted = "yes"
  }
  A2-> rc: ?Yr {
     rc:<=> ?Yl
    ¬rc:substituted = "yes"
  }
}
  ]
]

Sem<=>ASem rel_Benefactive : transfer_rels
[
  leftside = [
c: ?Xl{
  Benefactive-> c:?Yl{}
}
  ]
  mixed = [

  ]
  rightside = [
?ELAB {
  sem = "benefactive"
  type = "added"
  id = #randInt()#
  A1-> rc: ?Xr {
    rc:<=> ?Xl
    ¬rc:substituted = "yes"
  }
  A2-> rc: ?Yr {
     rc:<=> ?Yl
    ¬rc:substituted = "yes"
  }
}
  ]
]

Sem<=>ASem rel_Direction : transfer_rels
[
  leftside = [
c: ?Xl{
  Direction-> c:?Yl{}
}
  ]
  mixed = [

  ]
  rightside = [
?ELAB {
  sem = "direction"
  type = "added"
  id = #randInt()#
  A1-> rc: ?Xr {
    rc:<=> ?Xl
    ¬rc:substituted = "yes"
  }
  A2-> rc: ?Yr {
     rc:<=> ?Yl
    ¬rc:substituted = "yes"
  }
}
  ]
]

/*mapped to point time by default for KRISTINA*/
Sem<=>ASem rel_Duration : transfer_rels
[
  leftside = [
c: ?Xl{
  Duration-> c:?Yl {
    ¬c:type = ?t
  }
}
  ]
  mixed = [

  ]
  rightside = [
?ELAB {
  sem = "duration"
  type = "added"
  id = #randInt()#
  A1-> rc: ?Xr {
    rc:<=> ?Xl
    ¬rc:substituted = "yes"
  }
  A2-> rc: ?Yr {
     rc:<=> ?Yl
    ¬rc:substituted = "yes"
  }
}
  ]
]

/*mapped to point time by default for KRISTINA*/
Sem<=>ASem rel_End_Time : transfer_rels
[
  leftside = [
c: ?Xl{
  ?r-> c:?Yl {}
}

( ?r == End_Time )
  ]
  mixed = [

  ]
  rightside = [
?ELAB {
  sem = "end_time"
  type = "added"
  id = #randInt()#
  A1-> rc: ?Xr {
    rc:<=> ?Xl
    ¬rc:substituted = "yes"
  }
  A2-> rc: ?Yr {
     rc:<=> ?Yl
    ¬rc:substituted = "yes"
  }
}
  ]
]

Sem<=>ASem rel_Extent : transfer_rels
[
  leftside = [
c: ?Xl{
  Extent-> c:?Yl{}
}
  ]
  mixed = [

  ]
  rightside = [
?ELAB {
  sem = "extent"
  type = "added"
  id = #randInt()#
  A1-> rc: ?Xr {
    rc:<=> ?Xl
    ¬rc:substituted = "yes"
  }
  A2-> rc: ?Yr {
     rc:<=> ?Yl
    ¬rc:substituted = "yes"
  }
}
  ]
]

/*mapped to point time by default for KRISTINA*/
Sem<=>ASem rel_Frequency : transfer_rels
[
  leftside = [
c: ?Xl{
  Frequency-> c:?Yl {
    ¬c:type = ?t
  }
}
  ]
  mixed = [

  ]
  rightside = [
?ELAB {
  sem = "frequency"
  type = "added"
  id = #randInt()#
  A1-> rc: ?Xr {
    rc:<=> ?Xl
    ¬rc:substituted = "yes"
  }
  A2-> rc: ?Yr {
     rc:<=> ?Yl
    ¬rc:substituted = "yes"
  }
}
  ]
]

Sem<=>ASem rel_Location : transfer_rels
[
  leftside = [
c: ?Xl{
  Location-> c:?Yl{}
}
  ]
  mixed = [

  ]
  rightside = [
?ELAB {
  sem = "locative_relation"
  type = "added"
  id = #randInt()#
  A1-> rc: ?Xr {
    rc:<=> ?Xl
    ¬rc:substituted = "yes"
  }
  A2-> rc: ?Yr {
     rc:<=> ?Yl
    ¬rc:substituted = "yes"
  }
}
  ]
]

Sem<=>ASem rel_Manner : transfer_rels
[
  leftside = [
c: ?Xl{
  Manner-> c:?Yl{}
}
  ]
  mixed = [

  ]
  rightside = [
?ELAB {
  sem = "manner"
  type = "added"
  id = #randInt()#
  A1-> rc: ?Xr {
    rc:<=> ?Xl
    ¬rc:substituted = "yes"
  }
  A2-> rc: ?Yr {
     rc:<=> ?Yl
    ¬rc:substituted = "yes"
  }
}
  ]
]

Sem<=>ASem rel_NonCore_A1 : transfer_rels
[
  leftside = [
c: ?Xl{
  NonCore-> c:?Yl{
    ¬c:pos = "CC"
    ¬c:pos = "NP"
  }
}

¬ ( c:?Yl { c:lex = ?lex } & lexicon.?lex.gp.A0 )
  ]
  mixed = [

  ]
  rightside = [
rc: ?Yr {
   rc:<=> ?Yl
   ¬rc:substituted = "yes"
    A1-> rc:?Xr {
      rc:<=> ?Xl
     ¬rc:substituted = "yes"
  }
}
  ]
]

Sem<=>ASem rel_NonCore_NAME : transfer_rels
[
  leftside = [
c: ?Xl{
  NonCore-> c:?Yl{
    c:pos = "NP"
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
   rc:<=> ?Xl
   ¬rc:substituted = "yes"
    NAME-> rc:?Yr {
      rc:<=> ?Yl
     ¬rc:substituted = "yes"
  }
}
  ]
]

Sem<=>ASem rel_NonCore_A1_coord : transfer_rels
[
  leftside = [
c: ?Xl{
  NonCore-> c:?Yl{
    c:pos = "CC"
  }
}

¬ ( c:?Yl { c:lex = ?lex } & lexicon.?lex.gp.A0 )
  ]
  mixed = [

  ]
  rightside = [
?ELAB {
  sem = "ELABORATION"
  type = "added"
  id = #randInt()#
  A1-> rc: ?Xr {
    rc:<=> ?Xl
    ¬rc:substituted = "yes"
  }
  A2-> rc: ?Yr {
    rc:<=> ?Yl
    ¬rc:substituted = "yes"
  }
}
  ]
]

Sem<=>ASem rel_NonCore_A0 : transfer_rels
[
  leftside = [
c: ?Xl{
  NonCore-> c:?Yl{}
}

( c:?Yl { c:lex = ?lex } & lexicon.?lex.gp.A0 )
  ]
  mixed = [

  ]
  rightside = [
rc: ?Yr {
   rc:<=> ?Yl
   ¬rc:substituted = "yes"
    A0-> rc:?Xr {
      rc:<=> ?Xl
     ¬rc:substituted = "yes"
  }
}
  ]
]

Sem<=>ASem rel_Overlap : transfer_rels
[
  leftside = [
c: ?Xl{
  Temporal_Overlap-> c:?Yl{}
}
  ]
  mixed = [

  ]
  rightside = [
?ELAB {
  sem = "extent_time"
  type = "added"
  id = #randInt()#
  A1-> rc: ?Xr {
    rc:<=> ?Xl
    ¬rc:substituted = "yes"
  }
  A2-> rc: ?Yr {
     rc:<=> ?Yl
    ¬rc:substituted = "yes"
  }
}
  ]
]

Sem<=>ASem rel_Posteriority : transfer_rels
[
  leftside = [
c: ?Xl{
  Posteriority_Time-> c:?Yl{}
}
  ]
  mixed = [

  ]
  rightside = [
?ELAB {
  sem = "posteriority_time"
  type = "added"
  id = #randInt()#
  A1-> rc: ?Xr {
    rc:<=> ?Xl
    ¬rc:substituted = "yes"
  }
  A2-> rc: ?Yr {
    rc:<=> ?Yl
    ¬rc:substituted = "yes"
  }
  }
  ]
]

Sem<=>ASem rel_Purpose : transfer_rels
[
  leftside = [
c: ?Xl{
  Purpose-> c:?Yl{}
}
  ]
  mixed = [

  ]
  rightside = [
?ELAB {
  sem = "purpose"
  type = "added"
  id = #randInt()#
  A1-> rc: ?Xr {
    rc:<=> ?Xl
    ¬rc:substituted = "yes"
  }
  A2-> rc: ?Yr {
    rc:<=> ?Yl
    ¬rc:substituted = "yes"
  }
}
  ]
]

Sem<=>ASem rel_Quantity : transfer_rels
[
  leftside = [
c: ?Xl{
  Quantity-> c:?Yl{}
}
  ]
  mixed = [

  ]
  rightside = [
?ELAB {
  sem = "quantity"
  type = "added"
  id = #randInt()#
  A1-> rc: ?Xr {
    rc:<=> ?Xl
    ¬rc:substituted = "yes"
  }
  A2-> rc: ?Yr {
    rc:<=> ?Yl
    ¬rc:substituted = "yes"
  }
}
  ]
]

Sem<=>ASem rel_Set : transfer_rels
[
  leftside = [
c:?Xl{
  Set-> c:?Yl{
    member = ?m
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  ¬rc:substituted = "yes"
  ?m-> rc: ?Yr {
    rc:<=> ?Yl
    ¬rc:substituted = "yes"
  }
}
  ]
]

/*mapped to point time by default for KRISTINA*/
Sem<=>ASem rel_Time : transfer_rels
[
  leftside = [
c: ?Xl{
  ?r-> c:?Yl {
    ¬c:class = "Year"
    ¬c:class = "Date"
    ¬c:NonCore-> c:?Zl {
    // Inportuguese, we introduce a node "dia " between the X and the date
      ( c:class = "Year" | c:class = "Date" )
    }
  }
}

( ?r == Time | ?r == Start_Time )
  ]
  mixed = [

  ]
  rightside = [
?ELAB {
  sem = "point_time"
  type = "added"
  id = #randInt()#
  A1-> rc: ?Xr {
    rc:<=> ?Xl
    ¬rc:substituted = "yes"
  }
  A2-> rc: ?Yr {
    rc:<=> ?Yl
    ¬rc:substituted = "yes"
  }
}
  ]
]

/*mapped to point time by default for KRISTINA*/
Sem<=>ASem rel_Time_year : transfer_rels
[
  leftside = [
c: ?Xl{
  ?r-> c:?Yl {
    //c:class = "Year"
  }
}

( ?r == Time | ?r == Start_Time )

// In Portuguese, we introduce a node "dia" between the X and the date
( ?Yl.class == "Year" | c:?Yl { c:NonCore->  c:?Zl { c:class = "Year" } } )
  ]
  mixed = [

  ]
  rightside = [
?ELAB {
  sem = "point_time_year"
  type = "added"
  id = #randInt()#
  A1-> rc: ?Xr {
    rc:<=> ?Xl
    ¬rc:substituted = "yes"
  }
  A2-> rc: ?Yr {
    rc:<=> ?Yl
    ¬rc:substituted = "yes"
  }
}
  ]
]

/*mapped to point time by default for KRISTINA*/
Sem<=>ASem rel_Time_date : transfer_rels
[
  leftside = [
c: ?Xl{
  ?r-> c:?Yl {
    //c:class = "Date"
  }
}

( ?r == Time | ?r == Start_Time )

// In Portuguese, we introduce a node "dia" between the X and the date
( ?Yl.class == "Date" | c:?Yl { c:NonCore->  c:?Zl { c:class = "Date" } } )
  ]
  mixed = [

  ]
  rightside = [
?ELAB {
  sem = "point_time_date"
  type = "added"
  id = #randInt()#
  A1-> rc: ?Xr {
    rc:<=> ?Xl
    ¬rc:substituted = "yes"
  }
  A2-> rc: ?Yr {
    rc:<=> ?Yl
    ¬rc:substituted = "yes"
  }
}
  ]
]

excluded Sem<=>ASem rel_Time_point : transfer_rels
[
  leftside = [
c: ?Xl{
  Start_Time-> c:?Yl {}
}

?r == "Start_Time"
  ]
  mixed = [

  ]
  rightside = [
?ELAB {
  sem = "point_time"
  type = "added"
  A1-> rc: ?Xr {
    rc:<=> ?Xl
  }
  A2-> rc: ?Yr {
     rc:<=> ?Yl
  }
}
  ]
]

Sem<=>ASem K_attr_gestures : transfer_attributes
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

excluded Sem<=>ASem attr_uri : transfer_attributes
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

Sem<=>ASem attr_bnId : transfer_attributes
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
  ¬rc:added = "yes"
}
  ]
]

Sem<=>ASem attr_cardinality : transfer_attributes
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

Sem<=>ASem attr_class : transfer_attributes
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
  ¬rc:added = "yes"
}
  ]
]

/*dpos should be VB, NN, RB, JJ (see pos rules below)*/
Sem<=>ASem attr_clause_type : transfer_attributes
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
  ¬rc:added = "yes"
}
  ]
]

/*dpos should be VB, NN, RB, JJ (see pos rules below)*/
Sem<=>ASem attr_conj_num : transfer_attributes
[
  leftside = [
c:?Xl {
  conj_num = ?ds
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  conj_num = ?ds
  ¬rc:added = "yes"
}
  ]
]

/*dpos should be VB, NN, RB, JJ (see pos rules below)*/
Sem<=>ASem attr_coord_type : transfer_attributes
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

/*dpos should be VB, NN, RB, JJ (see pos rules below)*/
Sem<=>ASem attr_date_type : transfer_attributes
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
  ¬rc:added = "yes"
}
  ]
]

/*dpos should be VB, NN, RB, JJ (see pos rules below)*/
Sem<=>ASem attr_dative_shift : transfer_attributes
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
  ¬rc:added = "yes"
}
  ]
]

Sem<=>ASem attr_definiteness : transfer_attributes
[
  leftside = [
c:?Xl{
  definiteness = ?u
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  definiteness = ?u
  ¬rc:added = "yes"
}
  ]
]

/*Nouns in Greek in this context seem to work better with a definite article, excepts "typos" when it is second argument of a "be".*/
Sem<=>ASem EL_attr_definiteness_generalization_DEF : transfer_attributes
[
  leftside = [
c:?Xl {
  c:block = "yes"
  c:add_NP_generalization = ?lexVC
}

¬ ( c:?Gov { c:sem = "be" c:A2-> c:?Xl {} } & ?lexVC== "τύπος_NN_01" )
  ]
  mixed = [

  ]
  rightside = [
rc:?VCR {
  rc:<=> ?Xl
  rc:lex = ?lexVC
  rc:added = "yes"
  definiteness = "DEF"
}
  ]
]

/*Nouns in Greek in this context seem to work better with a definite article, excepts "typos" when it is second argument of a "be".*/
Sem<=>ASem EL_attr_definiteness_generalization_no : transfer_attributes
[
  leftside = [
c:?Gov {
  c:sem = "be"
  c:A2-> c:?Xl {
    c:block = "yes"
    c:add_NP_generalization = ?lexVC
  }
}

?lexVC == "τύπος_NN_01"
  ]
  mixed = [

  ]
  rightside = [
rc:?VCR {
  rc:<=> ?Xl
  rc:lex = ?lexVC
  rc:added = "yes"
  definiteness = "no"
  case = "GEN"
}
  ]
]

Sem<=>ASem attr_dpos : transfer_attributes
[
  leftside = [
c: ?Xl{
  c:dpos = ?d
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr{
  rc: <=> ?Xl
  dpos = ?d
  ¬rc:added = "yes"
}
  ]
]

Sem<=>ASem attr_gender : transfer_attributes
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

Sem<=>ASem attr_GovLex : transfer_attributes
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
  ¬rc:added = "yes"
}
  ]
]

Sem<=>ASem attr_id : transfer_attributes
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
  ¬rc:added = "yes"
}
  ]
]

Sem<=>ASem attr_id0 : transfer_attributes
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
  ¬rc:added = "yes"
}
  ]
]

/*numbering of conjuncts in coordination*/
Sem<=>ASem attr_juxpatos : transfer_attributes
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
  ¬rc:added = "yes"
}
  ]
]

Sem<=>ASem attr_lex_copy : transfer_attributes
[
  leftside = [
c: ?Xl{
  lex = ?l
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr{
  rc: <=> ?Xl
  lex = ?l
  ¬rc:added = "yes"
}
  ]
]

Sem<=>ASem attr_lex_real : transfer_attributes
[
  leftside = [
c: ?Xl{
  real_lex = ?l
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr{
  rc: <=> ?Xl
  real_lex = ?l
  ¬rc:added = "yes"
}
  ]
]

excluded Sem<=>ASem attr_lex_new : transfer_attributes
[
  leftside = [
c:?Xl {
  ¬c:lex = ?l
  c:pos = ?s
  c:predValue = ?pv
  c:predName = ?pn
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  lex = #?pn+_+?s+_+?pv#
}
  ]
]

/*numbering of conjuncts in coordination*/
Sem<=>ASem attr_main_rheme : transfer_attributes
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
  ¬rc:substituted = "yes"
}
  ]
]

/*numbering of conjuncts in coordination*/
Sem<=>ASem attr_main_theme : transfer_attributes
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
  ¬rc:substituted = "yes"
}
  ]
]

Sem<=>ASem attr_modality : transfer_attributes
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
  ¬rc:added = "yes"
}
  ]
]

Sem<=>ASem attr_modality_type : transfer_attributes
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
  ¬rc:added = "yes"
}
  ]
]

Sem<=>ASem attr_NE : transfer_attributes
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
  ¬rc:added = "yes"
}
  ]
]

Sem<=>ASem attr_number : transfer_attributes
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
  ¬rc:added = "yes"
}
  ]
]

Sem<=>ASem attr_pos : transfer_attributes
[
  leftside = [
c: ?Xl{
  pos = ?d
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr{
  rc: <=> ?Xl
  pos = ?d
  ¬rc:added = "yes"
}
  ]
]

Sem<=>ASem attr_pos_real : transfer_attributes
[
  leftside = [
c:?Xl{
  real_pos = ?d
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr{
  rc: <=> ?Xl
  real_pos = ?d
  ¬rc:added = "yes"
}
  ]
]

Sem<=>ASem attr_predN : transfer_attributes
[
  leftside = [
c:?Xl {
  predName = ?pn
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  predName = ?pn
  ¬rc:added = "yes"
}
  ]
]

Sem<=>ASem attr_predV : transfer_attributes
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
  ¬rc:added = "yes"
}
  ]
]

Sem<=>ASem attr_sameLoc : transfer_attributes
[
  leftside = [
c:?Xl {
  SameLocAsPrevious = ?tc
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  SameLocAsPrevious = ?tc
  ¬rc:substituted = "yes"
}
  ]
]

Sem<=>ASem attr_sameTime : transfer_attributes
[
  leftside = [
c:?Xl {
  SameTimeAsPrevious = ?tc
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  SameTimeAsPrevious = ?tc
  ¬rc:substituted = "yes"
}
  ]
]

Sem<=>ASem attr_sent_type : transfer_attributes
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
  ¬rc:substituted = "yes"
}
  ]
]

Sem<=>ASem attr_subcat_prep : transfer_attributes
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
  ¬rc:added = "yes"
}
  ]
]

Sem<=>ASem subcat_prep_new : transfer_attributes
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>ASem attr_tc : transfer_attributes
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
  ¬rc:added = "yes"
}
  ]
]

Sem<=>ASem attr_tense : transfer_attributes
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
  ¬rc:added = "yes"
}
  ]
]

Sem<=>ASem attr_type : transfer_attributes
[
  leftside = [
c:?Xl {
  type = ?t
}

¬?t == "comparative"
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  type = ?t
  ¬rc:added = "yes"
}
  ]
]

Sem<=>ASem attr_variable_class : transfer_attributes
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
  ¬rc:added = "yes"
}
  ]
]

/*In case the voice is specified in the input*/
Sem<=>ASem attr_voice : transfer_attributes
[
  leftside = [
c:?Xl {
  voice = ?t
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  voice = ?t
  ¬rc:added = "yes"
}
  ]
]

Sem<=>ASem attr_weight : transfer_attributes
[
  leftside = [
c: ?Xl{
  weight = ?w
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr{
  rc: <=> ?Xl
  weight = ?w
  ¬rc:added = "yes"
}
  ]
]

excluded Sem<=>ASem transfer_mentioned : transfer_attributes
[
  leftside = [
c: ?Xl{
  mentioned = ?m
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr{
  rc: <=> ?Xl
  mentioned = ?m
}
  ]
]

excluded Sem<=>ASem transfer_elaba2 : transfer_attributes
[
  leftside = [
c: ?Xl {
  c:isElaba2 = ?i
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc: <=> ?Xl
  isElaba2 = ?i
}
  ]
]

excluded Sem<=>ASem transfer_vroot : transfer_attributes
[
  leftside = [
c:?Xl {
  verb_root = ?a
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc: <=> ?Xl
  verb_root = ?a
}
  ]
]

/*This attribute should be trespassed only if we decide to consider secondary theme/rheme (those having the same weight
as the main, and share one element). For now, we keep it because we still don't know if we'll also find out the secondary/
embedded rhemes/themes (excluded rules for now).*/
excluded Sem<=>ASem transfer_bro : transfer_attributes
[
  leftside = [
c: ?Xl{
  bro = ?d
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr{
  rc: <=> ?Xl
  bro = ?d
}
  ]
]

excluded Sem<=>ASem transfer_son : transfer_attributes
[
  leftside = [
c: ?Xl{
  son_is = ?d
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr{
  rc: <=> ?Xl
  son_is = ?d
}
  ]
]

Sem<=>ASem K_attr_gest_fen : K_attr_gestures
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

Sem<=>ASem K_attr_gest_fex : K_attr_gestures
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

Sem<=>ASem K_attr_gest_fin : K_attr_gestures
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

Sem<=>ASem K_attr_gest_att : K_attr_gestures
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

Sem<=>ASem K_attr_gest_exp : K_attr_gestures
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

Sem<=>ASem K_attr_gest_pro : K_attr_gestures
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

Sem<=>ASem K_attr_gest_soc : K_attr_gestures
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

Sem<=>ASem K_attr_gest_sty : K_attr_gestures
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

Sem<=>ASem K_attr_gest_sa : K_attr_gestures
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
  ¬rc:added = "yes"
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
  ¬rc:added = "yes"
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
  ¬rc:added = "yes"
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
  ¬rc:added = "yes"
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
  ¬rc:added = "yes"
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
  ¬rc:added = "yes"
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
  ¬rc:added = "yes"
}
  ]
]

