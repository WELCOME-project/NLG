Sem<=>ASem node
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*Transfers all non-argumental relations.*/
Sem<=>ASem rel_copy
[
  leftside = [
c:?Xl {
  ?r-> c:?Yl {}
}

// PATCH while the input file is being modified
¬ (?Xl.slex == "area" & ?r == Elaboration )
// map to NonCore
¬?r == nonCore
// PATCH E2E
¬ ( ?Xl.slex == "customer_rating" & ?r == A2 & ?Yl.dpos == "JJ" )

¬ ( language.id.iso.PT & ?r == Time & ?Yl.variable_class == "Date" )
¬ ( language.id.iso.PT & ?r == A2 & ?Xl.slex == "word" & ?Yl.slex == "escort" )
¬ ( language.id.iso.PT & ?r == A2 & ?Xl.slex == "word" & ?Yl.slex == "personal_characteristic" )
¬ ( language.id.iso.PT & ?r == A2 & ?Xl.slex == "word" & ?Yl.slex == "performance_characteristic" )
¬ ( language.id.iso.PT & ?r == A2 & ?Xl.slex == "word" & ?Yl.slex == "logistic" )
¬ ( language.id.iso.PT & ?r == A2 & ?Xl.slex == "word" & ?Yl.slex == "sex_act" )
¬ ( language.id.iso.PT & ?r == A2 & ?Xl.slex == "expression" & ?Yl.slex == "risky" )
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
Sem<=>ASem rel_copy_PATCH_area_Elab
[
  leftside = [
c:?Xl {
  c:slex = "area"
  Elaboration-> c: ?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  NonCore-> rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

/*Transfers all non-argumental relations.*/
Sem<=>ASem rel_copy_PATCH_nonCore
[
  leftside = [
c:?Xl {
  nonCore-> c: ?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  NonCore-> rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

/*Transfers all non-argumental relations.*/
Sem<=>ASem rel_copy_PATCH_E2E
[
  leftside = [
c:?Xl {
  c:slex = "customer_rating"
  A2-> c:?Yl {
    c:dpos = "JJ"
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  NonCore-> rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

/*BUG!
-1*/
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

/*BUG!
-1*/
Sem<=>ASem bubble_link
[
  leftside = [
c:?Bubble1 {
  ¬c:?X2l {}
  c:?X1l {
    ~ c:?X2l {}
  }
}

c:?Bubble2 {
  ¬c:?X1l {}
  c:?X2l {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Bubble1R {
  rc:<=> ?Bubble1
  rc:id = ?id
  b-> rc:?Bubble2R {
    rc:<=> ?Bubble2
    id = #?id+1#
  }
}
  ]
]

/*BUG!
-1*/
excluded Sem<=>ASem bubble_link_ID
[
  leftside = [
c:?Bubble1 {
  c:?Xl {
    c:id = ?i
    c:~ c:?Yl {}
  }
}

¬ ( c:?Bubble1 { c:?Yl { c:id = ?idY } } & ?idY > ?i )
  ]
  mixed = [

  ]
  rightside = [
rc:?Bubble1R {
  rc:<=> ?Bubble1
  rc:id = ?id
  rc:?Xr {
    rc:<=> ?Xl
  }
  b-> rc:?Bubble2R {
    //rc:<=> ?Bubble2
    rc:?Yr {
      rc:<=> ?Yl
    }
    id = #?id+1#
  }
}
  ]
]

Sem<=>ASem bubble_id_1st
[
  leftside = [
c:?Sl {
  c:?Xl {}
}

// ?Xl is the first node, hence ?Sl is the first sentence
¬c:?Yl { c:~ c:?Xl {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?Sr {
  rc:<=> ?Sl
  id = "1.0"
}
  ]
]

/*If an empty node happens to be there at the beginning (MATE randomly produces one sometimes)*/
Sem<=>ASem bubble_id_1st_emptyNode
[
  leftside = [
// ?Xl is the first node after Yl, hence ?Sl is the first real sentence
c:?Yl {
  c:slex = "_"
  c:~ c:?Xl {}
}

// ?Yl is the first node
¬c:?Zl { c:~ c:?Yl {} }

c:?Sl {
  c:?Xl {}
  ¬c:?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Sr {
  rc:<=> ?Sl
  id = "1.0"
}
  ]
]

/*BUG: this rule overlaps with bubble_link. Becasue same LS??*/
excluded Sem<=>ASem bubble_id_others
[
  leftside = [
c:?Bubble1 {
  ¬c:?X2l {}
  c:?X1l {
    ~ c:?X2l {}
  }
}

c:?Bubble2 {
  ¬c:?X1l {}
  c:?X2l {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Bubble1r {
  rc:<=> ?Bubble1
  rc:id = ?id
}

rc:?Bubble2r {
  rc:<=> ?Bubble2
  id = #?id+1#
}
  ]
]

Sem<=>DSynt bubble_expand_dep
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

Sem<=>ASem markers
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>ASem PATCHES
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>ASem node_word : node
[
  leftside = [
?Xl {
  slex = ?slex
}

//language.id.iso.EN

¬ ?slex == "familyFriendly[no]"
¬ ?slex == "familyFriendly[yes]"
¬ ?slex == "Fast_food"
¬ ?slex == "floorArea"
¬ ( ?slex == "river" & ?Xl.dpos == "NP" )
¬ ( language.id.iso.ES & ?slex == "Gallus_gallus_domesticus" )
¬ ( language.id.iso.ES & ?slex == "Mathematics" )
¬ ( language.id.iso.ES & ?slex == "Addiction" )
¬ ( language.id.iso.ES & ?slex == "HIV" )
¬ ( language.id.iso.ES & ?slex == "HIV/AIDS" )

//  see PATCH_CONNEXIONs_character
¬ ( project_info.project.name.CONNEXIONs & ?slex == "number" )
¬ ( project_info.project.name.CONNEXIONs & ( ?slex == "character" | ?slex == "risky" | ?slex == "state" ) )

// transfer underscore only if it is connected or it is the only node in a bubble
( ¬?slex == "_" | ?Xl { c:?r1-> c:?Yl {} } | c:?Zl { c:?r2-> ?Xl {} }
  | ( c:?Bub { ?Xl { c:id = ?i1 } } & ¬ ( c:?Bub { c:?Kl { c:id = ?i2 } } & ¬?i1 == ?i2 ) )
)

¬c:?Yl {
  ( c:slex = "position" | c:slex = "round" )
  c:definiteness = "no"
  c:A1-> c:?Xl {
    c:dpos = "CD"
  }
}
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  sem = ?slex
  slex = ?slex
}
  ]
]

Sem<=>ASem node_word_family_friendly : node
[
  leftside = [
?Xl {
  slex = ?slex
}

//language.id.iso.EN

( ?slex == "familyFriendly[no]" | ?slex == "familyFriendly[yes]" )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  sem = "family-friendly"
  slex = "family-friendly"
}
  ]
]

Sem<=>ASem node_word_fast_food : node
[
  leftside = [
c:?Xl {
  ( c:slex = "food" | c:slex = "cuisine" )
  c:NonCore-> ?Yl {
    slex = "Fast_food"
  }
}

//language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:sem = ?slex
  rc:slex = ?slex
  sem = "fast_food"
  slex = "fast_food"
}
  ]
]

/*If there is a date that mentions day (11 of April), introduce the word "day"*/
Sem<=>ASem PT_node_day_date : node
[
  leftside = [
c:?Xl {
  Time-> c:?Yl {
    c:variable_class = "Date"
  }
}

language.id.iso.PT
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  Time-> ?Day {
    slex = "dia"
    sem = "dia"
    definiteness = "DEF"
    include = bubble_of_dep
    NonCore-> rc:?Yr {
      rc:<=> ?Yl
    }
  }
}
  ]
]

excluded Sem<=>ASem PATCH_attr_dpos_NP : transfer_attribute
[
  leftside = [
c:?Xl{
  c:slex = "space"
}

language.id.iso.EN
project_info.project.name.KRISTINA
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  dpos = "NP"
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

Sem<=>ASem attr_class : transfer_attribute
[
  leftside = [
c:?Xl {
  class = ?u
}

¬ ( c:?Xl {  ( c:variable_class = "DateEnd" | c:variable_class = "DateStart" | c:variable_class = "DateUNESCO"
   | c:variable_class = "DateRenovate" | c:variable_class = "DateDemolish" | c:variable_class = "DateExtension"
   | c:variable_class = "HighestEnd" | c:variable_class = "HighestDStart"
  )
}
  & ( ?s == "0" | ?s > "0" )
)

// How we handle Locations has changed since E2E; patch to remove them when not appropriate anymore
¬ ( c:?Sl { c:?Xl {} c:name = "yes" } & ?u == "Location" )
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

Sem<=>ASem attr_coref_id_copy : transfer_attribute
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

//PATCH WebNLG
¬ ( c:?Xl { c:slex = "play" c:A1-> c:?A1 {} } )
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

/*In Spanish, the argument numbering in the templates takes into account the subcat frame of the governor.
So we mark the sentences in Spanish with a feat that indicates that there is no need to update the arg numbers later.

Bad rule, because sometimes the predarg templates are language-specific (webnlg), and sometimes they are generic (EU projects).
When the input is the same for every language, this marker should not be introduced. So it's better to have the marker in the input already.*/
excluded Sem<=>ASem ES_attr_extArg : transfer_attribute
[
  leftside = [
c:?Text {
  c:slex = "Text"
  c:?Xl {
    c:slex = "Sentence"
    ¬c:hasExtArg = ?h
  }
}

language.id.iso.ES
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  hasExtArg = "solved"
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

¬ ( ?lex == "serve_VB_02" & ?Xl.slex == "offer" )

¬ ( ?lex == "offer_VB_02" & language.id.iso.PT & project_info.project.name.CONNEXIONs )
¬ ( ?lex == "number_NN_02" & language.id.iso.PT & project_info.project.name.CONNEXIONs )
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
  c:class = ?c 
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

Sem<=>ASem attr_NE_NP : transfer_attribute
[
  leftside = [
c:?Xl {
  ( c:dpos = "NP" | c:class = "Location" | c:class = "Person" )
  // ( c:class = "Location" | c:class = "Person" )
}

¬ ?Xl.slex == "bridge"
¬ ?Xl.slex == "square"
¬ ?Xl.slex == "river"
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

¬ ( project_info.project.name.CONNEXIONs & ?num == "PL" & c:?Xl { c:slex = "language" } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:number = ?nuRS
  number = ?num
}
  ]
]

Sem<=>ASem attr_num_PL_cardinality : transfer_attribute
[
  leftside = [
c:?Xl {
  ¬c:number = ?num
  cardinality = "Plural"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  number = "PL"
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

//PATCH WebNLG
¬ ( language.id.iso.ES & c:?Yl {c:slex = "runway"  c:?r-> c:?Xl { c:dpos = "NP"}}
  & ( ?r == A1 | ?r == A2 ) )

// PATCHES for faulty inputs
¬ ( ?dpos == "NP" & ?Xl.slex == "river" )
¬ ( ?dpos == "CD" & ?Xl.slex == "Super_Capers" )
¬ ( ?dpos == "RB" & ?Xl.slex == "near" )

//PATCH CONNEXIONs
¬ ( c:?Xl { c:slex = "English" c:dpos = "NP"} & language.id.iso.PT & project_info.project.name.CONNEXIONs)
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

/*dpos should be VB, NN, RB, JJ (see pos rules below)*/
Sem<=>ASem attr_pos2 : transfer_attribute
[
  leftside = [
c:?Xl {
  ¬c:dpos = ?d
  pos = ?dpos
}

¬?dpos == "_"
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

Sem<=>ASem attr_subcat_prep : transfer_attribute
[
  leftside = [
c:?Xl {
  subcat_prep = ?tc
}

¬ ( ?tc == "in" & ?Xl.slex == "riverside" )
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

Sem<=>ASem attr_subcat_prep_new : transfer_attribute
[
  leftside = [
c:?Govl {
  c:?r-> c:?Xl {
    c:subcat_prep = ?tc
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Govr {
  rc:<=> ?Govl
  ?r = ?tc
}
  ]
]

/*Some aspects are only for certain languages. Filter here to avoid problems later.*/
Sem<=>ASem attr_tc : transfer_attribute
[
  leftside = [
c:?Xl {
  tem_constituency = ?tc
}

( ¬ ( ?tc == "IMP" | ?tc == "PERF-S" ) | language.id.iso.CA | language.id.iso.ES | language.id.iso.FR )

// PATCH_xR4DRAMA
¬ ( project_info.project.name.xR4DRAMA & language.id.iso.IT & ?tc == "PROGR" & ?Xl.slex == "stand" )
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

//PATCH WebNLG
¬ ( language.id.iso.ES & c:?Xl {c:slex = "publish" c:tense = "PAST"} )
¬ ( language.id.iso.ES & c:?Xl {c:slex = "operate" c:tense = "PRES" c:A0-> c:?Nl { c:slex = "NASA" } } )
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

¬ ( project_info.project.name.CONNEXIONs & ?t == "quoted" & c:?Xl { c:slex = "title" c:A1-> c:?Dep {} } )
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

Sem<=>ASem attr_beAWARE : transfer_attribute
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>ASem mark_has_main_rheme : markers
[
  leftside = [
c:?Sl {
  c:?Xl {
    c:main_rheme = "yes"
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Sr {
  rc:<=> ?Sl
  has_main_rheme = "yes"
}
  ]
]

/*For conjuncts that are not numbers, assign a random conj_id.*/
Sem<=>ASem mark_conjuncts_assign_conjID_num : markers
[
  leftside = [
c:?Conj {
  c:Set-> c:?Xl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:sem = ?sX
  conj_id = ?sX
}

( ?sX > 0 | ?sX == "0" )
  ]
]

/*For conjuncts that are not numbers, assign a random conj_id.*/
Sem<=>ASem mark_conjuncts_assign_conjID_NOnum : markers
[
  leftside = [
c:?Conj {
  c:Set-> c:?Xl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:sem = ?sX
  conj_id = #randInt()#
}

¬ ( ?sX > 0 | ?sX == "0" )
  ]
]

/*Looks for the first member of a coordination in case the conjuncts are numbers.*/
Sem<=>ASem mark_conjuncts_conj_num_1st : markers
[
  leftside = [
c:?Conj {
  c:Set-> c:?Xl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?ConjR {
  rc:<=> ?Conj
  rc:Set-> rc:?Xr {
    rc:<=> ?Xl
    rc:conj_id = ?sX
    ¬rc:conj_num = ?K
    conj_num = "1"
  }
}

¬ ( rc:?ConjR { rc:Set-> rc:?Yr { rc:conj_id = ?sY } } & ?sY < ?sX )
  ]
]

/*Looks for the first member of a coordination in case the conjuncts are numbers.*/
Sem<=>ASem mark_conjuncts_conj_num_others : markers
[
  leftside = [
c:?Conj {
  c:Set-> c:?Xl {}
  c:Set-> c:?Zl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?ConjR {
  rc:<=> ?Conj
  rc:Set-> rc:?Xr {
    rc:<=> ?Xl
    rc:conj_id = ?sX
    rc:conj_num = ?n
  }
  rc:Set-> rc:?Zr {
    rc:<=> ?Zl
    rc:conj_id = ?sZ
    ¬rc:conj_num = ?K
    conj_num = #?n+1#
  }
}


¬ ( rc:?ConjR { rc:Set-> rc:?Yr { rc:conj_id = ?sY } } & ?sY > ?sX  & ?sY < ?sZ )
  ]
]

/*now this introduces some values such as A1.0... not usable as relation name later.
see patches.*/
excluded Sem<=>ASem mark_conjuncts_member : markers
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:conj_num = ?c
  member = #A+?c#
}
  ]
]

/*now this introduces some values such as A1.0... not usable as relation name later.
see patches.*/
Sem<=>ASem mark_conjuncts_member_patch_A1 : markers
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:conj_num = "1"
  member = A1
}
  ]
]

/*now this introduces some values such as A1.0... not usable as relation name later.
see patches.*/
Sem<=>ASem mark_conjuncts_member_patch_A2 : markers
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:conj_num = "2.0"
  member = A2
}
  ]
]

/*now this introduces some values such as A1.0... not usable as relation name later.
see patches.*/
Sem<=>ASem mark_conjuncts_member_patch_A3 : markers
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:conj_num = "3.0"
  member = A3
}
  ]
]

/*now this introduces some values such as A1.0... not usable as relation name later.
see patches.*/
Sem<=>ASem mark_conjuncts_member_patch_A4 : markers
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:conj_num = "4.0"
  member = A4
}
  ]
]

/*now this introduces some values such as A1.0... not usable as relation name later.
see patches.*/
Sem<=>ASem mark_conjuncts_member_patch_A5 : markers
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:conj_num = "5.0"
  member = A5
}
  ]
]

/*This patch was added because clause_type = PHRAS was not supported at the time of beAWARE.*/
Sem<=>ASem PATCH_beAWARE_noVerb : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = "risk"
  c:A2-> c:?Dep {}
}

// ?X is the root
¬c:?Gov { c:?r-> c:?Xl {} }

// There is no other dependent
¬ ( c:?Xl { c:?s-> c:?Dep {} } & ¬?s == A2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  clause_type = "PHRAS"
}
  ]
]

Sem<=>ASem PATCH_CONNEXIONs_PT_aspect : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = "publish"
}

language.id.iso.PT

project_info.project.name.CONNEXIONs
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  tem_constituency = "PERF-S"
}
  ]
]

Sem<=>ASem PATCH_CONNEXIONs_PT_character_def : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = "character"
  c:Location-> c:?Yl {
    ( c:slex = "parenthesis" )
  }
}

language.id.iso.PT

project_info.project.name.CONNEXIONs
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  definiteness = "no"
}
  ]
]

Sem<=>ASem PATCH_CONNEXIONs_PT_escort_gender : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = "escort"
}

language.id.iso.PT

project_info.project.name.CONNEXIONs
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  gender = "FEM"
}
  ]
]

Sem<=>ASem PATCH_CONNEXIONs_PT_escortWord : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = "word"
  c:A2-> c:?Yl {
    ( c:slex = "escort" | c:slex = "personal_characteristic" | c:slex = "performance_characteristic" | c:slex = "logistic" | c:slex = "sex_act" )
  }
}

project_info.project.name.CONNEXIONs

language.id.iso.PT
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  NonCore-> ?Rr {
    slex = "refer"
    sem = "refer"
    lex = "referente_JJ_01"
    type = "RESTR"
    include = bubble_of_dep
    A2-> rc:?Yr {
      rc:<=> ?Yl
      definiteness = "no"
      type = "quoted"
    }
  }
}
  ]
]

Sem<=>ASem PATCH_CONNEXIONs_PT_riskyExpression : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = "expression"
  c:A2-> c:?Yl {
    c:slex = "risky"
  }
}

project_info.project.name.CONNEXIONs

language.id.iso.PT
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  NonCore-> ?Rr {
    slex = "refer"
    sem = "refer"
    lex = "referente_JJ_01"
    type = "RESTR"
    include = bubble_of_dep
    A2-> rc:?Yr {
      rc:<=> ?Yl
      definiteness = "no"
      type = "quoted"
    }
  }
}
  ]
]

Sem<=>ASem PATCH_CONNEXIONs_PT_servicesTemplate : PATCHES
[
  leftside = [
c:?Contain {
  c:slex = "contain"
  c:A1-> c:?Ad {
    c:slex = "advert"
  }
  c:A2-> c:?Service {
    c:slex = "service"
  }
}

c:?risk {
  c:slex = "risk"
  c:A2-> c:?And {
    c:slex = "and"
    c:A1-> c:?Health {
      c:slex = "health"
    }
    c:A2-> c:?WellB {
      c:slex = "wellbeing"
    }
  }
  c:A1-> c:?Service {
    c:slex = "service"
  }
}

language.id.iso.PT

project_info.project.name.CONNEXIONs
  ]
  mixed = [

  ]
  rightside = [
rc:?ServiceR {
  rc:<=> ?Service
  definiteness = "no"
}

rc:?HealthR {
  rc:<=> ?Health
  definiteness = "DEF"
}

rc:?WellBR {
  rc:<=> ?WellB
  definiteness = "DEF"
}

rc:?ContainR {
  rc:<=> ?Contain
  rc:sem = ?Sem
  rc:slex = ?Slex
  sem = "offer"
  slex = "offer"
}
  ]
]

Sem<=>ASem PATCH_CONNEXIONs_advert_coref_1 : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = "advert"
}

// ?Xl is the first "advert"
¬c:?Zl { c:slex = "advert" c:*~ c:?Xl {} }

project_info.project.name.CONNEXIONs
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  coref_id = ?Xl.id
}
  ]
]

Sem<=>ASem PATCH_CONNEXIONs_advert_coref_n : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = "advert"
  c:*~ c:?Yl {
    c:slex = "advert"
  }
}

// ?Xl is the first "advert"
¬c:?Zl { c:slex = "advert" c:*~ c:?Xl {} }

project_info.project.name.CONNEXIONs
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  coref_id = ?Xl.id
}
  ]
]

Sem<=>ASem PATCH_CONNEXIONs_ageRange_NP : PATCHES
[
  leftside = [
c:?Xl {
  ( c:slex = "18-25" | c:slex = "26-30" | c:slex = "31-40" )
}

language.id.iso.PT

project_info.project.name.CONNEXIONs
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  dpos = "NP"
}
  ]
]

Sem<=>ASem PATCH_CONNEXIONs_block_both : PATCHES
[
  leftside = [
c:?Yl {
  c:slex = "and"
  c:Elaboration-> c:?Xl {
    c:slex = "both"
  }
}

language.id.iso.PT
project_info.project.name.CONNEXIONs
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

Sem<=>ASem PATCH_CONNEXIONs_character : PATCHES
[
  leftside = [
?Xl {
  slex = "character"
}

project_info.project.name.CONNEXIONs
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  sem = "character_symbol"
  slex = "character_symbol"
}
  ]
]

Sem<=>ASem PATCH_CONNEXIONs_language : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = "language"
}

project_info.project.name.CONNEXIONs
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  definiteness = "no"
}
  ]
]

Sem<=>ASem PATCH_CONNEXIONs_number : PATCHES
[
  leftside = [
?Xl {
  slex = "number"
}

project_info.project.name.CONNEXIONs
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex = "number_count"
  sem = "number_count"
}
  ]
]

Sem<=>ASem PATCH_CONNEXIONs_date : PATCHES
[
  leftside = [
c:?Xl {
  c:variable_class = "Date"
}

project_info.project.name.CONNEXIONs
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  class = "Date"
}
  ]
]

Sem<=>ASem PATCH_CONNEXIONs_nouns_generic : PATCHES
[
  leftside = [
c:?Xl {
  ¬c:definiteness = "no"
  ( c:slex = "outcall" | c:slex = "incall" | c:slex = "word_length" )
}

language.id.iso.PT

project_info.project.name.CONNEXIONs
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  definiteness = "no"
}
  ]
]

Sem<=>ASem PATCH_CONNEXIONs_english_pos : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = "English"
  dpos = "NP"
}

language.id.iso.PT
project_info.project.name.CONNEXIONs
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  dpos = "NN"
}
  ]
]

Sem<=>ASem PATCH_CONNEXIONs_risky : PATCHES
[
  leftside = [
?Xl {
  slex = "risky"
}

project_info.project.name.CONNEXIONs
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  sem = "risk"
  slex = "risk"
}
  ]
]

Sem<=>ASem PATCH_CONNEXIONs_statement : PATCHES
[
  leftside = [
?Xl {
  slex = "state"
}

project_info.project.name.CONNEXIONs
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  sem = "statement"
  slex = "statement"
}
  ]
]

Sem<=>ASem PATCH_CONNEXIONs_test_sentences : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = ?s
}

( ?s == "[title]" | ?s == "[thumb]" | ?s == "[date]" | ?s == "[riskLevel]" | ?s == "[riskScore]" | ?s == "[escortWordRatio]" | ?s == "[riskyExpressionRatio]"
  | ?s == "[personalCharRatio]" | ?s == "[performanceCharRatio]" | ?s == "[logisticsRatio]" | ?s == "[sexActRatio]" | ?s == "[riskyExpressionEWRatio]"
  | ?s == "[personalCharEWRatio]" | ?s == "[performanceCharEWRatio]" | ?s == "[logisticsEWRatio]" | ?s == "[sexActEWRatio]" | ?s == "[exclOpenRatio]"
  | ?s == "[exclCloseRatio]" | ?s == "[questOpenRatio]" | ?s == "[questCloseRatio]" | ?s == "[parenthOpenRatio]" | ?s == "[parenthCloseRatio]"
  | ?s == "[bracketOpenRatio]" | ?s == "[bracketCloseRatio]" | ?s == "[doubleQuoteRatio]" | ?s == "[singleQuoteRatio]" | ?s == "[commaRatio]"
  | ?s == "[dotRatio]" | ?s == "[hyphenRatio]" | ?s == "[colonRatio]" | ?s == "[semicolonRatio]" | ?s == "[upCaseRatio]" | ?s == "[digitRatio]"
  | ?s == "[charsParenthRatio]" | ?s == "[stopWordRatio]" | ?s == "[acronymRatio]" | ?s == "[wrongSpellRatio]" | ?s == "[negativeWordRatio]"
  | ?s == "[positiveWordRatio]" | ?s == "[vocabRichness]" | ?s == "[stdWordLength]" | ?s == "[rangeWordLength]" | ?s == "[charsPerWord]"
  | ?s == "[charsPerSent]" | ?s == "[threeCharsWord]" | ?s == "[[posTag]Freq]" | ?s == "[[depRel]Freq]" | ?s == "[meanMaxWidth]" | ?s == "[meanMaxDepth]"
  | ?s == "[meanRamFactor]" | ?s == "[hyphenRatioUTF8]" | ?s == "[apostropheRatio]" | ?s == "[doubleQuoteOpenRatio]" | ?s == "[doubleQuoteCloseRatio]"
  | ?s == "[twoCharsWord]" | ?s == "[nerRatio]" 
  | ?Xl.variable_class == "PosTagFreq"
)

project_info.project.name.CONNEXIONs
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  dpos = "JJ"
}
  ]
]

Sem<=>ASem PATCH_CONNEXIONs_type_quoted : PATCHES
[
  leftside = [
c:?Yl {
  type = "quoted"
  c:slex = "title"
  c:A1-> c:?Xl {}
}

project_info.project.name.CONNEXIONs
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  type = "quoted"
}
  ]
]

/*Old version of inputs with ugly shortcuts. Patching gov prep.*/
Sem<=>ASem PATCH_E2E_subcatPrep_riverside : PATCHES
[
  leftside = [
c:?Xl {
  subcat_prep = "in"
  c:slex = "riverside"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  subcat_prep = "on"
}
  ]
]

Sem<=>ASem PATCH_E2E_attr_lex_offer : PATCHES
[
  leftside = [
c:?Xl {
  lex =  "serve_VB_02"
  c:slex = "offer"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  lex = "offer_VB_02"
}
  ]
]

Sem<=>ASem PATCH_MindSpaces_image_coref_1 : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = "image"
}

// ?Xl is the first "image"
¬c:?Zl { c:slex = "image" c:*~ c:?Xl {} }

project_info.project.name.MindSpaces
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  coref_id = ?Xl.id
}
  ]
]

Sem<=>ASem PATCH_MindSpaces_image_coref_n : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = "image"
  c:*~ c:?Yl {
    c:slex = "image"
  }
}

// ?Xl is the first "image"
¬c:?Zl { c:slex = "image" c:*~ c:?Xl {} }

project_info.project.name.MindSpaces

( ( c:?Xl { ¬c:number = ?n1 } & c:?Yl { ¬c:number = ?n2 } )
  | ( c:?Xl { c:number = ?nn1 } & c:?Yl { c:number = ?nn2 } & ?nn1 == ?nn2 ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  coref_id = ?Xl.id
}
  ]
]

/*This patch was added because clause_type = PHRAS was not supported at the time of beAWARE.*/
Sem<=>ASem PATCH_Rotowire_numPL_team : PATCHES
[
  leftside = [
c:?Xl {
  c:variable_class = "TeamName"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  number = "PL"
  dpos = "NP"
}
  ]
]

Sem<=>ASem PATCH_Rotowire_winLoss : PATCHES
[
  leftside = [
c:?Gl {
  c:slex = "host"
  c:A1-> c:?Xl {
    //c:slex = ?sX
    c:variable_class = "TeamName"
    c:Elaboration-> c:?Dep1 {
      c:variable_class = "NumberStatCat"
      c:slex = ?sD1
    }
  }
  c:A2-> c:?Yl {
    //c:slex = ?sY
    c:variable_class = "TeamName"
    c:Elaboration-> c:?Dep2 {
      c:variable_class = "NumberStatCat"
      c:slex = ?sD2
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:sem = ?sX
  // bugs if we put slex here
  flex = #?sX+" ("+?sD1+")"#
}

rc:?Yr {
  rc:sem = ?sY
  rc:<=> ?Yl
  flex = #?sY+" ("+?sD2+")"#
}

rc:?Dep1r {
  rc:<=> ?Dep1
  blocked = "yes"
}

rc:?Dep2r {
  rc:<=> ?Dep2
  blocked = "yes"
}
  ]
]

/*Some prepositional groups need to be marked as not relativizable. Ok for Rotowire it's a cheat, because it's to cover "win quarter X by Y points", where I made "by" depend on "quarter"
  instead of "win" to make aggregations easier. But I've been thinking that this phenomenon should be investigated because thre are some preps that can be put in a relative.*/
Sem<=>ASem PATCH_Rotowire_mark_no_relative1 : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = "win"
  c:A2-> c:?Yl {
    ( c:slex = "quarter" | c:slex = "half" )
    c:NonCore-> c:?Prep {
      c:slex = "by"
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?PrepR {
  rc:<=> ?Prep
  type = "RESTR"
}
  ]
]

/*Some prepositional groups need to be marked as not relativizable. Ok for Rotowire it's a cheat, because it's to cover "win quarter X by Y points", where I made "by" depend on "quarter"
  instead of "win" to make aggregations easier. But I've been thinking that this phenomenon should be investigated because thre are some preps that can be put in a relative.*/
Sem<=>ASem PATCH_Rotowire_mark_no_relative2 : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = "draw"
  c:A2-> c:?Yl {
    ( c:slex = "quarter" | c:slex = "half" )
    c:NonCore-> c:?Prep {
      c:slex = "at"
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?PrepR {
  rc:<=> ?Prep
  type = "RESTR"
}
  ]
]

/*Some prepositional groups need to be marked as not relativizable. Ok for Rotowire it's a cheat, because it's to cover "win quarter X by Y points", where I made "by" depend on "quarter"
  instead of "win" to make aggregations easier. But I've been thinking that this phenomenon should be investigated because thre are some preps that can be put in a relative.*/
Sem<=>ASem PATCH_Rotowire_mark_no_relative3 : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = "lead"
  c:Location-> c:?Yl {
    c:slex = "halftime"
    c:NonCore-> c:?Prep {
      c:slex = "by"
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?PrepR {
  rc:<=> ?Prep
  type = "RESTR"
}
  ]
]

/*Some prepositional groups need to be marked as not relativizable. Ok for Rotowire it's a cheat, because it's to cover "win quarter X by Y points", where I made "by" depend on "quarter"
  instead of "win" to make aggregations easier. But I've been thinking that this phenomenon should be investigated because thre are some preps that can be put in a relative.*/
Sem<=>ASem PATCH_Rotowire_mark_no_relative4 : PATCHES
[
  leftside = [
c:?Xl {
  ( c:slex = "shooting_percentage" | c:slex = "%" | c:slex = "amount" | c:slex = "better" )
  c:NonCore-> c:?Prep {
    ( c:slex = "in" | c:slex = "beyond" | c:slex = "from" )
    c:A2-> c:?Yl {
      ( c:slex = "general" | c:slex = "arc" | c:slex = "line" | c:slex = "field" | c:slex = "paint" | c:slex = "beyond" | c:slex = "[area]" )
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?PrepR {
  rc:<=> ?Prep
  type = "RESTR"
}
  ]
]

/*Some prepositional groups need to be marked as not relativizable. Ok for Rotowire it's a cheat, because it's to cover "win quarter X by Y points", where I made "by" depend on "quarter"
  instead of "win" to make aggregations easier. But I've been thinking that this phenomenon should be investigated because thre are some preps that can be put in a relative.*/
Sem<=>ASem PATCH_Rotowire_mark_no_relative5 : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = "point"
  c:NonCore-> c:?Prep {
    c:slex = "on"
    c:A2-> c:?Yl {
      c:slex = "shooting"
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?PrepR {
  rc:<=> ?Prep
  type = "RESTR"
}
  ]
]

/*in the last inputs this value was erroneously not processed*/
Sem<=>ASem PATCH_V4Design_floorArea : PATCHES
[
  leftside = [
?Xl {
  slex = "floorArea"
}
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  sem = "floor_area"
  slex = "floor_area"
}
  ]
]

/*in the last inputs this value was erroneously not processed*/
Sem<=>ASem PATCH_V4Design_classYear : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = ?s
  ( c:variable_class = "DateEnd" | c:variable_class = "DateStart" | c:variable_class = "DateUNESCO"
   | c:variable_class = "DateRenovate" | c:variable_class = "DateDemolish" | c:variable_class = "DateExtension"
   | c:variable_class = "HighestEnd" | c:variable_class = "HighestDStart"
  )
}

( ?s == 0 | ?s > 0 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  class = "Year"
}
  ]
]

/*in the last inputs this value was erroneously not processed*/
Sem<=>ASem PATCH_V4Design_dpos_river : PATCHES
[
  leftside = [
?Xl {
  slex = "river"
  dpos = "NP"
}
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  sem = "river"
  slex = "river"
  dpos = "NN"
}
  ]
]

/*in the last inputs this value was erroneously not processed*/
Sem<=>ASem PATCH_V4Design_unit_cost : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = ?s
  c:variable_class = "Cost"
}

//( ?s == 0 | ?s > 0 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:sem = ?s
  rc:slex = ?sl
  ¬rc:added_unit = "yes"
  //unit = "$"
  sem = #?s+$#
  slex = #?sl+$#
  added_unit = "yes"
}
  ]
]

/*in the last inputs this value was erroneously not processed*/
Sem<=>ASem PATCH_V4Design_unit_sqm : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = ?s
  c:variable_class = "FloorArea"
}

//( ?s == 0 | ?s > 0 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:sem = ?s
  rc:slex = ?sl
  ¬rc:added_unit = "yes"
  //unit = "$"
  sem = #?s+m2#
  slex = #?sl+m2#
  added_unit = "yes"
}
  ]
]

/*in the last inputs this value was erroneously not processed*/
Sem<=>ASem PATCH_V4Design_unit_elevation : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = ?s
  c:variable_class = "Elevation"
}

//( ?s == 0 | ?s > 0 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:sem = ?s
  rc:slex = ?sl
  ¬rc:added_unit = "yes"
  //unit = "$"
  sem = #?s+m#
  slex = #?sl+m#
  added_unit = "yes"
}
  ]
]

Sem<=>ASem PATCH_WebNLG_tense_publish : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = "publish"
  tense = "PAST"
}

language.id.iso.ES
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  tense = "PRES"
}
  ]
]

Sem<=>ASem PATCH_WebNLG_tense_operar : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = "operate"
  tense = "PRES"
  c:A0-> c:?Nasa {
    c:slex = "NASA"
  }
}

language.id.iso.ES
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  tense = "PAST"
}
  ]
]

/*to correct an erroneous template*/
Sem<=>ASem PATCH_WebNLG_tense_costar : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = "cost"
}

language.id.iso.ES
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  tense = "PAST"
  tem_constituency = "PERF-S"
}
  ]
]

Sem<=>ASem PATCH_WebNLG_def_runway : PATCHES
[
  leftside = [
c:?Yl {
  c:slex = "runway"
  c:?r-> c:?Xl {
    dpos = "NP"
  }
}

( ?r == A1 | ?r == A2 )

language.id.iso.ES
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  dpos = "NN"
}
  ]
]

/*in the last inputs this value was erroneously not processed*/
Sem<=>ASem PATCH_WebNLG_pos_NP : PATCHES
[
  leftside = [
c:?Xl {
  ¬c:dpos = "NP"
  ( c:slex = "Aarhus_University,_School_of_Business_and_Social_Sciences"
    | c:slex = "Accademia_di_Architettura_di_Mendrisio"
    | c:slex = "Acharya_Institute_of_Technology"
    | c:slex = "Alderney_Airport"
    | c:slex = "Addis_Ababa_City_Hall"
    | c:slex = "Alpena_County_Regional_Airport"
    | c:slex = "Bhaji"
  )
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  dpos = "NP"
}
  ]
]

/*in the last inputs this value was erroneously not processed*/
Sem<=>ASem PATCH_WebNLG_gallus : PATCHES
[
  leftside = [
?Xl {
  slex = "Gallus_gallus_domesticus"
}

language.id.iso.ES
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  sem = "pollo"
  slex = "pollo"
  number = "SG"
}
  ]
]

/*in the last inputs this value was erroneously not processed*/
Sem<=>ASem PATCH_WebNLG_mathematics : PATCHES
[
  leftside = [
?Xl {
  slex = "Mathematics"
}

language.id.iso.ES
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  sem = "matemáticas"
  slex = "matemáticas"
  number = "SG"
}
  ]
]

/*in the last inputs this value was erroneously not processed*/
Sem<=>ASem PATCH_WebNLG_addiction : PATCHES
[
  leftside = [
?Xl {
  slex = "Addiction"
}

language.id.iso.ES
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  sem = "adicción"
  slex = "adicción"
  number = "SG"
}
  ]
]

/*in the last inputs this value was erroneously not processed*/
Sem<=>ASem PATCH_WebNLG_HIV : PATCHES
[
  leftside = [
?Xl {
  slex = "HIV"
}

language.id.iso.ES
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  sem = "VIH"
  slex = "VIH"
  number = "SG"
}
  ]
]

/*in the last inputs this value was erroneously not processed*/
Sem<=>ASem PATCH_WebNLG_HIVAIDS : PATCHES
[
  leftside = [
?Xl {
  slex = "HIV/AIDS"
}

language.id.iso.ES
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  sem = "Virus_de_la_inmunodeficiencia_humana"
  slex = "Virus_de_la_inmunodeficiencia_humana"
  number = "SG"
}
  ]
]

Sem<=>ASem PATCH_WebNLG_position : PATCHES
[
  leftside = [
c:?Yl {
  ( c:slex = "position" | c:slex = "round" )
  c:definiteness = "no"
  c:A1-> c:?Xl {
    dpos = "CD"
    slex = ?s2
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:position = "added"
  position = "added"
  rc:sem = ?se
  rc:slex = ?sl
  sem = #?se+" "+?s2#
  slex = #?sl+" "+?s2#
}
  ]
]

Sem<=>ASem PATCH_WELCOME_address_coref_1 : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = "address"
}

// ?Xl is the first "address"
¬c:?Zl { c:slex = "address" c:*~ c:?Xl {} }

project_info.project.name.WELCOME
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  coref_id = ?Xl.id
}
  ]
]

Sem<=>ASem PATCH_WELCOME_address_coref_n : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = "address"
  c:*~ c:?Yl {
    c:slex = "address"
  }
}

// ?Xl is the first "address"
¬c:?Zl { c:slex = "address" c:*~ c:?Xl {} }

project_info.project.name.WELCOME
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  coref_id = ?Xl.id
}
  ]
]

Sem<=>ASem PATCH_WELCOME_company_coref_1 : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = "company"
}

// ?Xl is the first node
¬c:?Zl { c:slex = "company" c:*~ c:?Xl {} }

project_info.project.name.WELCOME
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  coref_id = ?Xl.id
}
  ]
]

Sem<=>ASem PATCH_WELCOME_company_coref_n : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = "company"
  c:*~ c:?Yl {
    c:slex = "company"
  }
}

// ?Xl is the first "address"
¬c:?Zl { c:slex = "company" c:*~ c:?Xl {} }

project_info.project.name.WELCOME
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  coref_id = ?Xl.id
}
  ]
]

Sem<=>ASem PATCH_WELCOME_degree_coref_1 : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = "degree"
}

// ?Xl is the first node
¬c:?Zl { c:slex = "degree" c:*~ c:?Xl {} }

project_info.project.name.WELCOME
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  coref_id = ?Xl.id
}
  ]
]

Sem<=>ASem PATCH_WELCOME_degree_coref_n : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = "degree"
  c:*~ c:?Yl {
    c:slex = "degree"
  }
}

// ?Xl is the first "address"
¬c:?Zl { c:slex = "degree" c:*~ c:?Xl {} }

project_info.project.name.WELCOME
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  coref_id = ?Xl.id
}
  ]
]

Sem<=>ASem PATCH_WELCOME_EllideSameRelativeClause : PATCHES
[
  leftside = [
c:?RCRoot1l {
  c:deprel = "ROOT"
  ¬c:main_rheme = "yes"
  c:slex = ?RCRoot1lex
  c:?r1-> c:?X1l {
    c:slex = ?X1lex
  }
  c:?s1-> c:?Y1l {
    c:slex = ?Y1lex
  }
  c:*~ c:?RCRoot2l {
    c:deprel = "ROOT"
    ¬c:main_rheme = "yes"
    c:slex = ?RCRoot2lex
    c:?r2-> c:?X2l {
      c:slex = ?X2lex
    }
    c:?s2-> c:?Y2l {
      c:slex = ?Y2lex
    }
  }
}

c:?MCRoot1 {
  c:deprel = "ROOT"
  c:main_rheme = "yes"
  c:?MCr1-> c:?X1l {}
  c:?MCs1-> c:?Z1l {
    c:slex = ?Z1lex
  }
}

c:?MCRoot2 {
  c:deprel = "ROOT"
  c:main_rheme = "yes"
  c:?MCr2-> c:?X2l {}
  c:?MCs2-> c:?Z2l {
    c:slex = ?Z2lex
  }
}

// ?Xl is the first "address"
//¬c:?Zl { c:slex = "company" c:*~ c:?Xl {} }

project_info.project.name.WELCOME

?RCRoot1lex == ?RCRoot2lex
?X1lex == ?X2lex
?Y1lex == ?Y2lex
?r1 == ?r2
?s1 == ?s2


?Z1lex == ?Z2lex
?MCr1 == ?MCr2
?MCs1 == ?MCs2
  ]
  mixed = [

  ]
  rightside = [
rc:?RCRoot1R {
  rc:<=> ?RCRoot1l 
  blocked = "yes"
}

rc:?X1R {
  rc:<=> ?X1l 
  blocked = "yes"
}

rc:?Y1R {
  rc:<=> ?Y1l 
  blocked = "yes"
}
  ]
]

/*In xR4DRAMA's templates, we put the A1 of source (in noise and light source templates) as Elaboration to force the introduction of parentheses.
The problem is that we lose the info that this Elaboration is actually an A1, which ca be useful for some rules (e.g. mark_cardinality in 11.2_Con_Agg2).*/
Sem<=>ASem PATCH_xR4DRAMA_A1_NoiseSource : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = "source"
  c:Elaboration-> c:?Yl {
    ( c:variable_class = "NoiseSource" | c:variable_class = "LightSource" )
  }
  ¬c:A1-> c:?Arg1 {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  Elaboration = "A1"
}
  ]
]

Sem<=>ASem PATCH_xR4DRAMA_site_coref_1 : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = ?s
}

// ?Xl is the first "advert"
¬c:?Zl { c:slex = ?s c:*~ c:?Xl {} }

( ?s == "site" | ?s == "surrounding" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  coref_id = ?Xl.id
}
  ]
]

Sem<=>ASem PATCH_xR4DRAMA_site_coref_n : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = ?s
  c:*~ c:?Yl {
    c:slex = ?s
  }
}

// ?Xl is the first "advert"
¬c:?Zl { c:slex = ?s c:*~ c:?Xl {} }

( ?s == "site" | ?s == "surrounding" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  coref_id = ?Xl.id
}
  ]
]

/*in the last inputs this value was erroneously not processed*/
Sem<=>ASem PATCH_xR4DRAMA_unit_percent : PATCHES
[
  leftside = [
c:?Xl {
  c:slex = ?s
  c:variable_class = "StressLevelConfidence"
}

//( ?s == 0 | ?s > 0 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:sem = ?s
  rc:slex = ?sl
  ¬rc:added_unit = "yes"
  //unit = "$"
  sem = #?s+%#
  slex = #?sl+%#
  added_unit = "yes"
}
  ]
]

/*If two nodes are exactly the same under the same predicate, mark one as "-1" so weirf stuff doesn't happen later.*/
excluded Sem<=>ASem PATCH_mark_same_nodes_coref_id : PATCHES
[
  leftside = [
c:?Xl {
  c:A1-> c:?A1l {
    c:slex = ?s1
    ¬c:?r1-> ?Dep1 {}
  }
  c:A2-> c:?A2l {
    c:slex = ?s2
    ¬c:?r2-> ?Dep2 {}
  }
}

?s1 == ?s2
  ]
  mixed = [

  ]
  rightside = [
rc:?A2r {
  rc:<=> ?A2l
  coref_id = "-1"
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

