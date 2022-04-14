Sem<=>ASem node_word
[
  leftside = [
c:?Bl  {
  ?Xl {
    //sem = ?sem
    word = ?w
    slex = ?slex
  }
}

// In Multisensor, shared argument nodes are duplicated, we bring them back together
// see node_MS_duplicated
¬ (
project_info.project.name.MULTISENSOR
?Xl {c:start_string = ?ss1 c:lineId = ?li1}
 & c:?Bl { c:?Yl  {c:start_string = ?ss2 c:lineId = ?li2} }
 & ?ss1 == ?ss2 & ?li2 < ?li1 
)

¬ ( ?w == "”" & ?Xl { ¬c:?rel2-> c:?Y2l {} } )
//¬ (?Xl.word == "purpose" & ?Xl.slex == "for")
// see word_be_contraction
¬ ( (  ?w == "’s" | ?w == "'re" | ?w == "’re" | ?w == "'s" ) & ?Xl { c:?r-> c:?Y3l {} } )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  //dpos = ?Xl.dpos
  //lex = ?Xl.lex
  //main = ?Xl.main
  //meaning = ?Xl.meaning
  //number = ?Xl.number
  //pbr = ?Xl.pbr
  //predicate = ?Xl.predicate
  //predName = ?Xl.predName
  //predValue = ?Xl.predValue
  //dlex = ?Xl.sem
  //dlex = ?Xl.slex
  sem = ?w
  fn = ?slex
  //tem_constituency = ?Xl.tem_constituency
  //tense = ?Xl.tense
  //type = ?Xl.type
  //vncls = ?Xl.vncls
}
  ]
]

Sem<=>ASem node_word_be_contraction
[
  leftside = [
c:?Bl  {
  ?Xl {
    //sem = ?sem
    (  word = "’s" | word = "'re" | word = "’re" | word = "'s" )
    slex = ?slex
    c:?r-> c:?Yl {}
  }
}
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  sem = "be"
  fn = ?slex
}
  ]
]

Sem<=>ASem node_MS_duplicated
[
  leftside = [
c:?Bl  {
  c:?Xl {
    c:start_string = ?ss1
    c:lineId = ?li1
  }
  ?Yl {
    c:start_string = ?ss2
    c:lineId = ?li2
  }
}

// In Multisensor, shared argument nodes are duplicated, we bring them back together

project_info.project.name.MULTISENSOR

?ss1 == ?ss2
?li1 < ?li2
  ]
  mixed = [
// this condition is supposed to ensure that the rule only to the next biggest lineId. NOT TESTED with more than two nodes to merge!!!
¬ (
c:?Bl { c:?Zl  {c:start_string = ?ss3 c:lineId = ?li3} }
 & ?ss1 == ?ss3 & ?li3 < ?li2
 & rc:?Xr { rc:<=> ?Xl rc:?li3 = "added" }
)
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  <=> ?Yl
  ?li2 = "added"
}
  ]
]

Sem<=>ASem node_NOword
[
  leftside = [
?Xl {
  //sem = ?sem
  ¬c:word = ?w 
  slex = ?slex
}

//?Xl { ( ¬c:word = ?w | (c:word = "purpose" & slex = "for" ) ) }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  //dpos = ?Xl.dpos
  //lex = ?Xl.lex
  //main = ?Xl.main
  //meaning = ?Xl.meaning
  //number = ?Xl.number
  //pbr = ?Xl.pbr
  //predicate = ?Xl.predicate
  //predName = ?Xl.predName
  //predValue = ?Xl.predValue
  //dlex = ?Xl.sem
  //dlex = ?Xl.slex
  sem = ?slex
  //tem_constituency = ?Xl.tem_constituency
  //tense = ?Xl.tense
  //type = ?Xl.type
  //vncls = ?Xl.vncls
}
  ]
]

/*"like to V" is usually realized as "gladly V". We need to block the "gefallen" node and create one for "gerne".
When both verbs point to the same argument.*/
Sem<=>ASem DE_node_like_gerne
[
  leftside = [
c:?Xl {
  c:sem = "gefallen"
  c:?r-> c:?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  blocked = "YES"
  rc:?r1-> rc:?DepR {}
  rc:A1-> rc:?Yr {
    rc:<=> ?Yl
    rc:pos = "VB"
    rc:?r2-> rc:?DepR {}
  }
}

?Gr {
  id = #randInt()#
  lex = "gerne_RB_01"
  sem = "gerne"
  pos = "RB"
  predValue = "01"
  include = bubble_of_dep
  A1-> rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

/*Test rule.
Remove the first argument of some standalone verbs than passivize easily if this argument is mentioned elsewhere.
Should be generalized to more cases?*/
Sem<=>ASem EN_welcome_passive
[
  leftside = [
c:?Vl {
  c:sem = "welcome"
  c:A1-> c:?A1l {
  c:class = "Location"
  // no dependent here
  ¬c:?r-> c:?Dep {}
  // A1 has been mentioned before. not a great condition.Does the trick for E2E
    // c:<-> c:?Ante {}
  }
  c:A2-> c:?A2l {}
}

// ?V is the main verb
¬ c:?Gov1 {
  c:?r1-> c:?Vl {}
}

// No other node points to A1
¬ c:?Gov2 {
  ¬c:sem = "welcome"
  c:?r2-> c:?A1l {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?A1r {
  rc:<=> ?A1l
  blocked = "YES"
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

/*Not needed so far*/
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

Sem<=>ASem transfer_rel
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

excluded Sem<=>ASem create_bubble
[
  leftside = [
c:?Xl {
  c:id = "1"
}
  ]
  mixed = [

  ]
  rightside = [
?Bubble {
  dlex = Sentence
  rc:+?Xr {
    rc:<=> ?Xl
  }
}
  ]
]

/*BUG!
-1*/
excluded Sem<=>ASem fill_bubble
[
  leftside = [
c:?Xl {}

((c:?Yl {c:?r-> c:?Xl {}} & ¬?r == b) | (c:?Xl {c:?s-> c:?Yl {}} & ¬?s == b))
  ]
  mixed = [

  ]
  rightside = [
rc:?Bubble {
  rc:?Yr {
    rc:<=> ?Yl
  }
  rc:+?Xr {
    rc:<=> ?Xl
  }
}
  ]
]

excluded Sem<=>ASem fill_bubble_up
[
  leftside = [
c:?Xl {
  c:?r-> c:?Yl {}
}

//¬?r == b
  ]
  mixed = [

  ]
  rightside = [
rc:?Bubble {
  rc:?Yr {
    rc:<=> ?Yl
  }
  rc:+?Xr {
    rc:<=> ?Xl
  }
}

¬(rc:?Bubble {rc:?Xr {rc:<=> ?Xl}})
  ]
]

excluded Sem<=>ASem fill_bubble_down
[
  leftside = [
c:?Yl {
  c:?r-> c:?Xl {}
}

//¬?r == b
  ]
  mixed = [

  ]
  rightside = [
rc:?Bubble {
  rc:?Yr {
    rc:<=> ?Yl
  }
  rc:+?Xr {
    rc:<=> ?Xl
  }
}

¬(rc:?Bubble {rc:?Xr {rc:<=> ?Xl}})
  ]
]

/*All these rules should apply at the same time; they do in the second cluster.*/
Sem<=>ASem mark_PoS_slex_concepticon
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*All these rules should apply at the same time; they do in the second cluster.
Apply if there is no mapping foreseen in the concepticon.*/
Sem<=>ASem mark_PoS_slex_lexicon
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>ASem choose_pos
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*These rules will have to be refined I guess... small scale test for now...*/
Sem<=>ASem change_pos
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>ASem other_markers
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*All these rules should apply at the same time; they do in the second cluster.*/
Sem<=>ASem mark_PoS_word
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*Rules to improve the fluency of the texts generated from the predicate argument structures.*/
Sem<=>ASem mark_block
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>ASem PATCH
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>ASem K_attr_gestures : transfer_attribute
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

Sem<=>ASem attr_conj_num : transfer_attribute
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

/*If the predName is different from the dlex, we use the predName*/
Sem<=>ASem attr_dlex_rewrite : transfer_attribute
[
  leftside = [
c:?Xl {
  c:slex = ?s
  c:pred_Name = ?pn
}

¬?s == ?pn
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  sem = ?pn
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

/*numbering of conjuncts in coordination*/
Sem<=>ASem attr_has_main_rheme_new : transfer_attribute
[
  leftside = [
c:?Xl {
  ¬c:has_main_rheme = ?m
  c:?Node {
    c:main_rheme = "yes"
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  has_main_rheme = "yes"
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

/*If a node is in the concepticon, use the mapping to the lexicon.*/
Sem<=>ASem attr_lex_new_concepticon : transfer_attribute
[
  leftside = [
c:?Xl {
  ¬c:lex = ?l
  c:sem = ?s
}

// see attr_lex_new_concepticon
language.id.iso.?lg
concepticon.?s.?lg.lex.?lexLG
lexicon.?lexLG.pos.?pos

// see EL_lex_thereIs
¬ ( language.id.iso.EL & c:?Xl { c:sem = "report" c:A2-> c:?Yl { c:sem = "heat_wave" } } )
  ]
  mixed = [
lexicon.?lexLG.pos.?pos
rc:?Xr { rc:<=> ?Xl rc:pos = ?pos2 }
?pos == ?pos2
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  // This should be the same as ?pos, but let's let is loose for now
  rc:pos = ?pos2
  lex = ?lexLG
}
  ]
]

/*If a node is in the concepticon, use the mapping to the lexicon.*/
Sem<=>ASem EL_attr_lex_thereIs : transfer_attribute
[
  leftside = [
c:?Xl {
  c:sem = "report"
  c:A2-> c:?Yl {
    c:sem = "heat_wave"
  }
}

language.id.iso.EL
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:pos = ?pos
  lex = "έχω_VB_02"
  type = "impersonal"
}
  ]
]

/*If a node is not in the concepticon (or if there is no concepticon), use the information in the lexicon, if any.

This rule comes from KRISTINA.*/
Sem<=>ASem attr_lex_new_lexicon_Eng_tr : transfer_attribute
[
  leftside = [
c:?Xl {
  ¬c:type = "temprel"
  ¬c:type = "role"
  ¬c:type = "speech_act"
  c:sem = ?s
}

¬?s == "_"
¬language.id.iso.EN
// see attr_lex_new_concepticon
¬ ( language.id.iso.?lg & concepticon.?s.?lg.lex.?lexLG & lexicon.?lexLG.pos.?pos )

// see attr_lex_new_lex_ENG
//¬ ( language.id.iso.?lg & lexicon.?wpOrig.lex_ENG.?s & lexicon.?wpOrig.lemma.?lemOrig )

lexicon.?wp.Eng_tr.?s
lexicon.?wp.lemma.?l

// Test: we take the second one by default
¬ ( lexicon.?wp.id.?id1 & lexicon.?wp2.Eng_tr.?s & lexicon.?wp2.id.?id2
 & ?id2 > ?id1
)
¬ ( lexicon.?wp.entryID.?id3 & lexicon.?wp4.Eng_tr.?s & lexicon.?wp4.entryID.?id4
 & ?id3 > ?id4
)
¬ ( lexicon.?wp.entryId.?id5 & lexicon.?wp6.Eng_tr.?s & lexicon.?wp6.entryId.?id6
 & ?id5 > ?id6
)
// we don't generate the temporal_ordering for the first prototype
¬ ( c:?A3l {c:slex = "Temporal_Ordering" c:second-> c:?Xl { c:slex = "go_to_sleep" } } )
¬ ( c:?A4l {c:slex = "Temporal_Ordering" c:first-> c:?Xl { c:slex = "watch" } c:second-> c:?B4l { ¬c:slex = "go_to_sleep" } } )
¬ ( c:?A5l {c:slex = "Temporal_Ordering"
      c:first-> c:?B5l { c:slex = "watch" c:?r5-> c:?Xl { c:slex = "t.v."} }
    c:second-> c:?C5l { ¬c:slex = "go_to_sleep" } }
)
// or the fourth argument of "assistance"
¬ ( c:?A6l { c:slex = "assistance" c:Argument4-> c:?Xl {} } )
¬ ( c:?A7l { c:slex = "assistance" c:Argument4-> c:?B7l { c:Argument4-> c:?Xl {} } } )

// see DE_node_assistance
¬ ( language.id.iso.DE & ?Xl { c:slex = "assistance" c:Argument1-> c:?Ul {} c:Argument2-> c:?Ll {} } )
¬ ( language.id.iso.DE & ?A8l { c:slex = "Duration" c:role1-> c:?Xl { c:slex = "go_to_sleep" } } )

¬ ( language.id.iso.PL & ?s == "you" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  lex = ?wp
}
  ]
]

/*If the node can have several PoS, no decision is taken so far.
Think of something for the next layer...*/
Sem<=>ASem attr_lex_new_no_lexicon : transfer_attribute
[
  leftside = [
c:?Xl {
  ¬c:lex = ?l
}

//language.id.iso.EN
// see attr_lex_new_concepticon

¬ ( language.id.iso.?lg & c:?Xl { c:sem = ?s1 } & concepticon.?s1.?lg.lex.?lexLG & lexicon.?lexLG.pos.?pos1 )

//( language.id.iso.EN | ¬ ( c:?Xl { c:sem = ?s2 } & lexicon.?wp.Eng_tr.?s2 & lexicon.?wp.lemma.?l ) )

( language.id.iso.EN
//  | ¬ ( c:?Xl { c:sem = ?s2 } & lexicon.?wp2.lex_ENG.?s2 & lexicon.?wp2.lemma.?l2 )
  | ¬ ( c:?Xl { c:sem = ?s3 } & lexicon.?wp3.Eng_tr.?s3 & lexicon.?wp3.lemma.?l3 )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:sem = ?d
  rc:pos = ?pos
  rc:predValue = ?pv
  lex = #?d+_+?pos+_+?pv#
}
  ]
]

excluded Sem<=>ASem attr_main : transfer_attribute
[
  leftside = [
c:?Xl {
  main = ?m
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  main = ?m
}
  ]
]

/*numbering of conjuncts in coordination*/
Sem<=>ASem attr_main_rheme : transfer_attribute
[
  leftside = [
c:?Xl {
// see rheme_META
  ¬c:type = META
  main_rheme = ?m
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:pos = ?pos
  main_rheme = ?m
}

// see rheme CC
¬?pos == "CC"
  ]
]

/*numbering of conjuncts in coordination*/
Sem<=>ASem attr_main_rheme_CC : transfer_attribute
[
  leftside = [
c:?Xl {
  main_rheme = ?m
  c:?r-> c:?Yl {}
}

( ?r == A1 | ( ?r == A2 & c:?Xl { ¬c:A1-> c:?Conj1 {} } )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:pos = "CC"
}

rc:?Yr {
  rc:<=> ?Yl
  main_rheme = ?m
}
  ]
]

/*moves the main to the first dependent of the meta node.*/
Sem<=>ASem attr_main_rheme_META_A1 : transfer_attribute
[
  leftside = [
c:?Xl {
  c:type = META
  main_rheme = ?m
  c:A1-> c:?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  rc:pos = ?pos
  main_rheme = ?m
}

// see rheme CC
//¬?pos == "CC"
  ]
]

/*moves the main to the first dependent of the meta node.*/
excluded Sem<=>ASem attr_main_rheme_META_A1_CC : transfer_attribute
[
  leftside = [
c:?Xl {
  c:type = META
  main_rheme = ?m
  c:A1-> c:?Yl {}
}

//( ?r == A1 | ( ?r == A2 & c:?Xl { ¬c:A1-> c:?Conj1 {} } )
//)
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  rc:pos = ?pos
  main_rheme = ?m
}

// see rheme CC
¬?pos == "CC"
  ]
]

/*moves the main to the second dependent of the meta node if there is no Arg1.*/
Sem<=>ASem attr_main_rheme_META_A2 : transfer_attribute
[
  leftside = [
c:?Xl {
  c:type = META
  main_rheme = ?m
  ¬c:A1-> c:?Zl {}
  c:A2-> c:?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  rc:pos = ?pos
  main_rheme = ?m
}

// see rheme CC
//¬?pos == "CC"
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
  ¬dpos = "TO"
  dpos = ?dpos
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  pos = ?dpos
}
  ]
]

/*dpos should be VB, NN, RB, JJ (see pos rules below)*/
Sem<=>ASem attr_pos_TO : transfer_attribute
[
  leftside = [
c:?Xl {
  dpos = "TO"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  pos = "IN"
}
  ]
]

excluded Sem<=>ASem attr_pbr : transfer_attribute
[
  leftside = [
c:?Xl {
  pbr = ?pbr
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  pbr = ?pbr
}
  ]
]

excluded Sem<=>ASem attr_pred : transfer_attribute
[
  leftside = [
c:?Xl {
  predicate = ?pred
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  predicate = ?pred
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

Sem<=>ASem attr_predV_default : transfer_attribute
[
  leftside = [
c:?Xl {
  ¬pred_Value = ?pv
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  predValue = "01"
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

/*If a node is in the concepticon, use the mapping to the lexicon.*/
Sem<=>ASem attr_type_new_concepticon : transfer_attribute
[
  leftside = [
c:?Xl {
  c:sem = ?s
}

language.id.iso.?lg
concepticon.?s.?lg.lex.?lexLG
concepticon.?s.?lg.type.?type
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:lex = ?lexLG
  type = ?type
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

/*Transfers all non-argumental relations.*/
Sem<=>ASem rel_copy : transfer_rel
[
  leftside = [
c:?Xl {
  ?r-> c: ?Yl {}
}

¬?r==Argument0
¬?r==Argument1
¬?r==Argument2
¬?r==Argument3
¬?r==Argument4
¬?r==Argument5
¬?r==Argument6
¬?r==Argument7
¬?r==Argument8
¬?r==Argument9
¬?r==Argument10
¬?r==A0
¬?r==A1
¬?r==A2
¬?r==A3
¬?r==A4
¬?r==A5
¬?r==A6
¬?r==A7
¬?r==A8
¬?r==A9
¬?r==A10
¬?r==Attribute

// to filter weird structures such as PTB_train_12115 (2 Location pointing to the same node)
// Problem seems to happen mostly with coordinated structures
// if one of the predicates has no id0, do not transfer relation
¬ ( c:?Zl { c:?s->  c:?Yl {} } & ?s == ?r & ¬?r  == Set & ?Xl.id0 == "none" )
// if both (or more) nodes have an id0, choose the smaller by default
¬ ( c:?Kl { c:?t->  c:?Yl {} } & ?t == ?r & ¬?r == Set & ?Kl.id < ?Xl.id )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //rc:lex = ?p1
  ?r-> rc:?Yr {
    rc:<=> ?Yl
    //rc:lex = ?p2
  }
}
  ]
]

/*If a structure already contains A0 /A1 relations.*/
Sem<=>ASem rel_copy_A : transfer_rel
[
  leftside = [
c:?Xl {
  ?r-> c: ?Yl {}
}

( ?r==A0 | ?r==A1 | ?r==A2 | ?r==A3 | ?r==A4 | ?r==A5 | ?r==A6 | ?r==A7 | ?r==A8 | ?r==A9 | ?r==A10 )

//don't copy relation if a cycle has been detected!
¬ ( c:?Xl { c:cycle = detected c:candidate_dep_cycle = ?id c:rel_cycle_name = ?cn } & c:?Yl { c:id = ?idY } & ?idY == ?id 
 & (
    ( ?r == A0 & ?cn == ARG0_of )
    | ( ?r == A1 & ?cn == ARG1_of )
    | ( ?r == A2 & ?cn == ARG2_of )
    | ( ?r == A3 & ?cn == ARG3_of )
    | ( ?r == A4 & ?cn == ARG4_of )
    | ( ?r == A5 & ?cn == ARG5_of )
    | ( ?r == A6 & ?cn == ARG6_of )
    | ( ?r == A7 & ?cn == ARG7_of )
    | ( ?r == A8 & ?cn == ARG8_of )
    | ( ?r == A9 & ?cn == ARG9_of )
    | ( ?r == A10 & ?cn == ARG10_of )
    | ( ?r == NonCore & ?cn == mod_of )
 )
)
  ]
  mixed = [
// don't copy relation if mapping is provided in concepticon
//¬ ( c:?Xl { c:sem = ?sem } & rc:?Xr { rc:<=> ?Xl rc:lex = ?lex2 } & concepticon.?sem.?lg.?lx2.gp.?r)
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //rc:lex = ?p1
  ?r-> rc:?Yr {
    rc:<=> ?Yl
    //rc:lex = ?p2
  }
}
  ]
]

/*Copy relation if mapping is provided in concepticon*/
excluded Sem<=>ASem rel_copy_A_concepticon : transfer_rel
[
  leftside = [
c:?Xl {
  c:sem = ?sem
  ?r-> c: ?Yl {}
}
  ]
  mixed = [
concepticon.?sem.?lg.?lp1.gp.?r.?R
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:lex = ?p1
  ?R-> rc:?Yr {
    rc:<=> ?Yl
    rc:lex = ?p2
  }
}
  ]
]

Sem<=>ASem rel_coref : transfer_rel
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

excluded Sem<=>ASem rel_coref_add_id_old : transfer_rel
[
  leftside = [
c:?Tl {
  c:*?X1l {
    c:id = ?idS1
  }
  c:*?X2l {
    c:coref_id = ?idS1
  }
}

( ?Tl.sem == "Text" | ( ?Tl.sem == "Sentence" & ¬c:?BigBub { c:?Tl {} } ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?X2r {
  rc:<=> ?X2l
  <-> rc:?X1r {
    rc:<=> ?X1l
  }
}
  ]
]

Sem<=>ASem rel_coref_add_id : transfer_rel
[
  leftside = [
c:?Tl {
  c:*?X1l {
    c:coref_id = ?idS1
    c:id = ?id1
  }
  c:*?X2l {
    c:coref_id = ?idS2
    c:id = ?id2
  }
}

( ?Tl.sem == "Text" | ( ?Tl.sem == "Sentence" & ¬c:?BigBub { c:?Tl {} } ) )

// nodes have the same ID
¬?idS1 == "-1"
?idS1 == ?idS2
?id1 < ?id2

// nodes point to the first one
¬ ( c:?Tl { c:*?X3l { c:id = ?id3 c:coref_id = ?idS3 } } & ?idS3 == ?idS1 & ?id3 < ?id2 & ?id3 < ?id1 )
  ]
  mixed = [

  ]
  rightside = [
rc:?X2r {
  rc:<=> ?X2l
  <-> rc:?X1r {
    rc:<=> ?X1l
  }
}
  ]
]

/*Same LeftSide as mark_sameLoc2.
KEEP SYNC!*/
Sem<=>ASem rel_coref_add_NP : transfer_rel
[
  leftside = [
c:?Tl {
  c:?S1r {
    c:id = ?idS1
    c:?X1l {
      c:dpos = "NP"
      c:sem = ?sX1
    }
    c:*b-> c:?S2r {
      c:id = ?idS2
      c:?X2l {
        c:dpos = "NP"
        c:sem = ?sX2
        ¬c:coref_id = ?idS1
      }
    }
  }
}

?sX1 == ?sX2

// so all corefs point to the NP form the same bubble
¬ ( c:?S3r { c:*b-> c:?S2r {} c:id = ?idS3 c:?X3l { c:dpos = "NP" c:sem = ?sX3 } }
    & ?sX3 == ?sX2 & ?idS3 < ?idS1 )
  ]
  mixed = [

  ]
  rightside = [
rc:?X2r {
  rc:<=> ?X2l
  <-> rc:?X1r {
    rc:<=> ?X1l
  }
}
  ]
]

Sem<=>ASem rel_precedence : transfer_rel
[
  leftside = [
c:?Xl {
  (c:sem = "Sentence" | c:slex = "Sentence")
  ~ c: ?Yl {
    (c:sem = "Sentence" | c:slex = "Sentence")
  }
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

Sem<=>ASem rel_A0 : transfer_rel
[
  leftside = [
c:?Xl {
  Argument0-> c: ?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //rc:lex = ?p1
  A0-> rc:?Yr {
    rc:<=> ?Yl
    //rc:lex = ?p2
  }
}
  ]
]

excluded Sem<=>ASem rel_A0_ext : transfer_rel
[
  leftside = [
c:?Xl {
  c:hasExtArg = "yes"
  Argument1-> c: ?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //rc:lex = ?p1
  A0-> rc:?Yr {
    rc:<=> ?Yl
    //rc:lex = ?p2
  }
}
  ]
]

Sem<=>ASem rel_A1 : transfer_rel
[
  leftside = [
c:?Xl {
  //¬c:hasExtArg = "yes"
  Argument1-> c: ?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //rc:lex = ?p1
  A1-> rc:?Yr {
    rc:<=> ?Yl
    //rc:lex = ?p2
  }
}
  ]
]

excluded Sem<=>ASem rel_A1_ext : transfer_rel
[
  leftside = [
c:?Xl {
  c:hasExtArg = "yes"
  Argument2-> c: ?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //rc:lex = ?p1
  A1-> rc:?Yr {
    rc:<=> ?Yl
    //rc:lex = ?p2
  }
}
  ]
]

Sem<=>ASem rel_A2 : transfer_rel
[
  leftside = [
c:?Xl {
  Argument2-> c: ?Yl {}
}

// ( (?r == Argument2 & ¬?Xl.hasExtArg == "yes" )  | ( ?r == Argument3 & ?Xl.hasExtArg == "yes") )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //rc:lex = ?p1
  A2-> rc:?Yr {
    rc:<=> ?Yl
    //rc:lex = ?p2
  }
}
  ]
]

Sem<=>ASem rel_A3 : transfer_rel
[
  leftside = [
c:?Xl {
  Argument3-> c: ?Yl {}
}

// ( (?r == Argument3 & ¬?Xl.hasExtArg == "yes" )  | ( ?r == Argument4 & ?Xl.hasExtArg == "yes") )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //rc:lex = ?p1
  A3-> rc:?Yr {
    rc:<=> ?Yl
    //rc:lex = ?p2
  }
}
  ]
]

Sem<=>ASem rel_A4 : transfer_rel
[
  leftside = [
c:?Xl {
  Argument4-> c: ?Yl {}
}

// ( (?r == Argument4 & ¬?Xl.hasExtArg == "yes" )  | ( ?r == Argument5 & ?Xl.hasExtArg == "yes") )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //rc:lex = ?p1
  A4-> rc:?Yr {
    rc:<=> ?Yl
    //rc:lex = ?p2
  }
}
  ]
]

Sem<=>ASem rel_A5 : transfer_rel
[
  leftside = [
c:?Xl {
  Argument5-> c: ?Yl {}
}

// ( (?r == Argument5 & ¬?Xl.hasExtArg == "yes" )  | ( ?r == Argument6 & ?Xl.hasExtArg == "yes") )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //rc:lex = ?p1
  A5-> rc:?Yr {
    rc:<=> ?Yl
    //rc:lex = ?p2
  }
}
  ]
]

Sem<=>ASem rel_A6 : transfer_rel
[
  leftside = [
c:?Xl {
  Argument6-> c: ?Yl {}
}

// ( (?r == Argument6 & ¬?Xl.hasExtArg == "yes" )  | ( ?r == Argument7 & ?Xl.hasExtArg == "yes") )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //rc:lex = ?p1
  A6-> rc:?Yr {
    rc:<=> ?Yl
    //rc:lex = ?p2
  }
}
  ]
]

Sem<=>ASem rel_A7 : transfer_rel
[
  leftside = [
c:?Xl {
  Argument7-> c: ?Yl {}
}

// ( (?r == Argument7 & ¬?Xl.hasExtArg == "yes" )  | ( ?r == Argument8 & ?Xl.hasExtArg == "yes") )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //rc:lex = ?p1
  A7-> rc:?Yr {
    rc:<=> ?Yl
    //rc:lex = ?p2
  }
}
  ]
]

Sem<=>ASem rel_A8 : transfer_rel
[
  leftside = [
c:?Xl {
  Argument8-> c: ?Yl {}
}

// ( (?r == Argument8 & ¬?Xl.hasExtArg == "yes" )  | ( ?r == Argument9 & ?Xl.hasExtArg == "yes") )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //rc:lex = ?p1
  A8-> rc:?Yr {
    rc:<=> ?Yl
    //rc:lex = ?p2
  }
}
  ]
]

Sem<=>ASem rel_A9 : transfer_rel
[
  leftside = [
c:?Xl {
  Argument9-> c: ?Yl {}
}

// ( (?r == Argument9 & ¬?Xl.hasExtArg == "yes" )  | ( ?r == Argument10 & ?Xl.hasExtArg == "yes") )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //rc:lex = ?p1
  A9-> rc:?Yr {
    rc:<=> ?Yl
    //rc:lex = ?p2
  }
}
  ]
]

Sem<=>ASem rel_attribute : transfer_rel
[
  leftside = [
c:?Xl {
  Attribute-> c: ?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //rc:lex = ?p1
  NonCore-> rc:?Yr {
    rc:<=> ?Yl
    //rc:lex = ?p2
  }
}
  ]
]

Sem<=>ASem rel_A10 : transfer_rel
[
  leftside = [
c:?Xl {
  Argument10-> c: ?Yl {}
}

// ( (?r == Argument10 & ¬?Xl.hasExtArg == "yes" )  | ( ?r == Argument11 & ?Xl.hasExtArg == "yes") )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  A10-> rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

Sem<=>ASem mark_VB_concepticon : mark_PoS_slex_concepticon
[
  leftside = [
c:?Xl {
  ¬c:?NodeIn {}
  ¬c:word = ?w
  c:slex = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}

language.id.iso.?lg
concepticon.?s.?lg.lex.?lexLG
lexicon.?lexLG.pos.?pos

//the vertex is not already a lexical unit that has a pos in the lexicon; see choose_pos_lexicon
¬ ( c:?Xl { c:lex = ?lex } & lexicon.?lex.pos.?posLex )

?pos == "VB"
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  //rc:dlex = ?s
  pos1 = "VB"
}
  ]
]

excluded Sem<=>ASem mark_VB_default : mark_PoS_slex_concepticon
[
  leftside = [
c:?Xl {
  c:slex = ?s
  ¬dpos = ?dpos
}

¬(lexicon.?entry.lemma.?s & lexicon.?entry.pos.?pos & ?pos == "VB")
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  pos = "VB"
}
  ]
]

Sem<=>ASem mark_NN_concepticon : mark_PoS_slex_concepticon
[
  leftside = [
c:?Xl {
  ¬c:?NodeIn {}
  ¬c:word = ?w
  c:slex = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}

language.id.iso.?lg
concepticon.?s.?lg.lex.?lexLG
lexicon.?lexLG.pos.?pos

//the vertex is not already a lexical unit that has a pos in the lexicon
¬ ( c:?Xl { c:lex = ?lex } & lexicon.?lex.pos.?posLex )

?pos == "NN"
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  //rc:dlex = ?s
  pos2 = "NN"
  //pos_lexicon= applied
}
  ]
]

Sem<=>ASem mark_JJ_concepticon : mark_PoS_slex_concepticon
[
  leftside = [
c:?Xl {
  ¬c:?NodeIn {}
  ¬c:word = ?w
  c:slex = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}

language.id.iso.?lg
concepticon.?s.?lg.lex.?lexLG
lexicon.?lexLG.spos.?pos

//the vertex is not already a lexical unit that has a pos in the lexicon
¬ ( c:?Xl { c:lex = ?lex } & lexicon.?lex.pos.?posLex )

( ?pos == adjective | ?pos == "adjective" )
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  //rc:dlex = ?s
  pos4 = "JJ"
}
  ]
]

Sem<=>ASem mark_CD : mark_PoS_slex_concepticon
[
  leftside = [
c:?Xl {
  ¬c:?NodeIn {}
  ¬c:word = ?w
  c:slex = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
}

(?s == 0 | ?s < 0 | ?s > 0)

//the vertex is not already a lexical unit that has a pos in the lexicon
¬ ( c:?Xl { c:lex = ?lex } & lexicon.?lex.pos.?posLex )
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  pos4 = "CD"
  //pos_default= applied
}
  ]
]

Sem<=>ASem mark_CC_concepticon : mark_PoS_slex_concepticon
[
  leftside = [
c:?Xl {
  ¬c:?NodeIn {}
  ¬c:word = ?w
  c:slex = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}

language.id.iso.?lg
concepticon.?s.?lg.lex.?lexLG
lexicon.?lexLG.pos.?pos

//the vertex is not already a lexical unit that has a pos in the lexicon
¬ ( c:?Xl { c:lex = ?lex } & lexicon.?lex.pos.?posLex )

?pos == "CC"
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  //rc:dlex = ?s
  pos5 = "CC"
}
  ]
]

Sem<=>ASem mark_RB_concepticon : mark_PoS_slex_concepticon
[
  leftside = [
c:?Xl {
  ¬c:?NodeIn {}
  ¬c:word = ?w
  c:slex = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}

language.id.iso.?lg
concepticon.?s.?lg.lex.?lexLG
lexicon.?lexLG.pos.?pos

//the vertex is not already a lexical unit that has a pos in the lexicon
¬ ( c:?Xl { c:lex = ?lex } & lexicon.?lex.pos.?posLex )

?pos == "RB"
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  //rc:dlex = ?s
  pos3 = "RB"
}
  ]
]

Sem<=>ASem mark_IN_concepticon : mark_PoS_slex_concepticon
[
  leftside = [
c:?Xl {
  ¬c:?NodeIn {}
  ¬c:word = ?w
  c:slex = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}

language.id.iso.?lg
concepticon.?s.?lg.lex.?lexLG
lexicon.?lexLG.pos.?pos

//the vertex is not already a lexical unit that has a pos in the lexicon
¬ ( c:?Xl { c:lex = ?lex } & lexicon.?lex.pos.?posLex )

?pos == "IN"
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  //rc:dlex = ?s
  pos6 = "IN"
}
  ]
]

/*This rule has not been finished nor tested*/
Sem<=>ASem mark_NP_NE_concepticon : mark_PoS_slex_concepticon
[
  leftside = [
c:?Xl {
  ¬c:?NodeIn {}
  ¬c:word = ?w
  c:slex = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
  (NE = "YES" | entityType = "person")
}

language.id.iso.?lg
concepticon.?s.?lg.lex.?lexLG
lexicon.?lexLG.pos.?pos

//the vertex is not already a lexical unit that has a pos in the lexicon
¬ ( c:?Xl { c:lex = ?lex } & lexicon.?lex.pos.?posLex )

?pos == "NP"
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  pos6 = "NP"
  pos = "NP"
  //pos_default= applied
}
  ]
]

Sem<=>ASem mark_PRP_concepticon : mark_PoS_slex_concepticon
[
  leftside = [
c:?Xl {
  ¬c:?NodeIn {}
  ¬c:word = ?w
  c:slex = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}

language.id.iso.?lg
concepticon.?s.?lg.lex.?lexLG
lexicon.?lexLG.pos.?pos

?pos == "PRP"

//the vertex is not already a lexical unit that has a pos in the lexicon
¬ ( c:?Xl { c:lex = ?lex } & lexicon.?lex.pos.?posLex )
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  pos6 = "PRP"
  pos = "PRP"
  //pos_default= applied
}
  ]
]

Sem<=>ASem mark_WP_concepticon : mark_PoS_slex_concepticon
[
  leftside = [
c:?Xl {
  ¬c:?NodeIn {}
  ¬c:word = ?w
  c:slex = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}

language.id.iso.?lg
concepticon.?s.?lg.lex.?lexLG
lexicon.?lexLG.pos.?pos

?pos == "WP"

//the vertex is not already a lexical unit that has a pos in the lexicon
¬ ( c:?Xl { c:lex = ?lex } & lexicon.?lex.pos.?posLex )
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  pos6 = "WP"
  pos = "WP"
}
  ]
]

Sem<=>ASem mark_DT_concepticon : mark_PoS_slex_concepticon
[
  leftside = [
c:?Xl {
  ¬c:?NodeIn {}
  ¬c:word = ?w
  c:slex = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}

language.id.iso.?lg
concepticon.?s.?lg.lex.?lexLG
lexicon.?lexLG.spos.?pos

//the vertex is not already a lexical unit that has a pos in the lexicon
¬ ( c:?Xl { c:lex = ?lex } & lexicon.?lex.pos.?posLex )

( ?pos == determiner | ?pos == "determiner" )
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  //rc:dlex = ?s
  pos5 = "DT"
}
  ]
]

Sem<=>ASem mark_VB_lexicon : mark_PoS_slex_lexicon
[
  leftside = [
c:?Xl {
  ¬c:?NodeIn {}
  ¬c:word = ?w
  c:slex = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬c:number = ?number
  ¬dpos = ?dpos
}

¬ (language.id.iso.?lg & concepticon.?s.?lg.lex.?lexLG & lexicon.?lexLG.pos.?posLG )

lexicon.?entry.lemma.?s
lexicon.?entry.pos.?pos

//the vertex is not already a lexical unit that has a pos in the lexicon
¬ ( c:?Xl { c:lex = ?lex } & lexicon.?lex.pos.?posLex )

?pos == "VB"
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  //rc:dlex = ?s
  pos1 = "VB"
}
  ]
]

excluded Sem<=>ASem mark_VB_default : mark_PoS_slex_lexicon
[
  leftside = [
c:?Xl {
  c:slex = ?s
  ¬dpos = ?dpos
}

¬(lexicon.?entry.lemma.?s & lexicon.?entry.pos.?pos & ?pos == "VB")
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  pos = "VB"
}
  ]
]

Sem<=>ASem mark_NN_lexicon : mark_PoS_slex_lexicon
[
  leftside = [
c:?Xl {
  ¬c:?NodeIn {}
  ¬c:word = ?w
  c:slex = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}

¬ (language.id.iso.?lg & concepticon.?s.?lg.lex.?lexLG & lexicon.?lexLG.pos.?posLG )

lexicon.?entry.lemma.?s
lexicon.?entry.pos.?pos

//the vertex is not already a lexical unit that has a pos in the lexicon
¬ ( c:?Xl { c:lex = ?lex } & lexicon.?lex.pos.?posLex )

?pos == "NN"
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  //rc:dlex = ?s
  pos2 = "NN"
  //pos_lexicon= applied
}
  ]
]

Sem<=>ASem mark_JJ_lexicon : mark_PoS_slex_lexicon
[
  leftside = [
c:?Xl {
  ¬c:?NodeIn {}
  ¬c:word = ?w
  c:slex = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}

¬ (language.id.iso.?lg & concepticon.?s.?lg.lex.?lexLG & lexicon.?lexLG.pos.?posLG )

lexicon.?entry.lemma.?s
lexicon.?entry.spos.?pos

//the vertex is not already a lexical unit that has a pos in the lexicon
¬ ( c:?Xl { c:lex = ?lex } & lexicon.?lex.pos.?posLex )

( ?pos == adjective | ?pos == "adjective" )
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  //rc:dlex = ?s
  pos4 = "JJ"
}
  ]
]

excluded Sem<=>ASem mark_CD : mark_PoS_slex_lexicon
[
  leftside = [
c:?Xl {
  ¬c:?NodeIn {}
  ¬c:word = ?w
  c:slex = ?s
  ¬c:type = "added"
  ¬c:type = META
}

(?s == 0 | ?s < 0 | ?s > 0)

//the vertex is not already a lexical unit that has a pos in the lexicon
¬ ( c:?Xl { c:lex = ?lex } & lexicon.?lex.pos.?posLex )
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  pos4 = "CD"
  //pos_default= applied
}
  ]
]

Sem<=>ASem mark_CC_lexicon : mark_PoS_slex_lexicon
[
  leftside = [
c:?Xl {
  ¬c:?NodeIn {}
  ¬c:word = ?w
  c:slex = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}

¬ (language.id.iso.?lg & concepticon.?s.?lg.lex.?lexLG & lexicon.?lexLG.pos.?posLG )

lexicon.?entry.lemma.?s
lexicon.?entry.pos.?pos

//the vertex is not already a lexical unit that has a pos in the lexicon
¬ ( c:?Xl { c:lex = ?lex } & lexicon.?lex.pos.?posLex )

?pos == "CC"
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  //rc:dlex = ?s
  pos5 = "CC"
}
  ]
]

Sem<=>ASem mark_RB_lexicon : mark_PoS_slex_lexicon
[
  leftside = [
c:?Xl {
  ¬c:?NodeIn {}
  ¬c:word = ?w
  c:slex = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}

¬ (language.id.iso.?lg & concepticon.?s.?lg.lex.?lexLG & lexicon.?lexLG.pos.?posLG )

lexicon.?entry.lemma.?s
lexicon.?entry.pos.?pos

//the vertex is not already a lexical unit that has a pos in the lexicon
¬ ( c:?Xl { c:lex = ?lex } & lexicon.?lex.pos.?posLex )

?pos == "RB"
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  //rc:dlex = ?s
  pos3 = "RB"
}
  ]
]

Sem<=>ASem mark_IN_lexicon : mark_PoS_slex_lexicon
[
  leftside = [
c:?Xl {
  ¬c:?NodeIn {}
  ¬c:word = ?w
  c:slex = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}

¬ (language.id.iso.?lg & concepticon.?s.?lg.lex.?lexLG & lexicon.?lexLG.pos.?posLG )

lexicon.?entry.lemma.?s
lexicon.?entry.pos.?pos

//the vertex is not already a lexical unit that has a pos in the lexicon
¬ ( c:?Xl { c:lex = ?lex } & lexicon.?lex.pos.?posLex )

?pos == "IN"
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  //rc:dlex = ?s
  pos6 = "IN"
}
  ]
]

Sem<=>ASem mark_NP_NE_lexicon : mark_PoS_slex_lexicon
[
  leftside = [
c:?Xl {
  ¬c:?NodeIn {}
  ¬c:word = ?w
  c:slex = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
  ( NE = "YES" | entityType = "person" )
}

¬ (language.id.iso.?lg & concepticon.?s.?lg.lex.?lexLG & lexicon.?lexLG.pos.?posLG )

¬(lexicon.?entry.lemma.?s & lexicon.?entry.pos.?pos & ?pos == "VB")

//the vertex is not already a lexical unit that has a pos in the lexicon
¬ ( c:?Xl { c:lex = ?lex } & lexicon.?lex.pos.?posLex )
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  pos6 = "NP"
  pos = "NP"
  //pos_default= applied
}
  ]
]

Sem<=>ASem mark_PRP : mark_PoS_slex_lexicon
[
  leftside = [
c:?Xl {
  ¬c:?NodeIn {}
  ¬c:word = ?w
  c:slex = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}

¬ (language.id.iso.?lg & concepticon.?s.?lg.lex.?lexLG & lexicon.?lexLG.pos.?posLG )

lexicon.?entry.lemma.?s
lexicon.?entry.pos.?pos & ?pos == "PRP"

//the vertex is not already a lexical unit that has a pos in the lexicon
¬ ( c:?Xl { c:lex = ?lex } & lexicon.?lex.pos.?posLex )
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  pos6 = "PRP"
  pos = "PRP"
  //pos_default= applied
}
  ]
]

Sem<=>ASem mark_WP_lexicon : mark_PoS_slex_lexicon
[
  leftside = [
c:?Xl {
  ¬c:?NodeIn {}
  ¬c:word = ?w
  c:slex = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}

¬ (language.id.iso.?lg & concepticon.?s.?lg.lex.?lexLG & lexicon.?lexLG.pos.?posLG )

lexicon.?entry.lemma.?s
lexicon.?entry.pos.?pos & ?pos == "WP"

//the vertex is not already a lexical unit that has a pos in the lexicon
¬ ( c:?Xl { c:lex = ?lex } & lexicon.?lex.pos.?posLex )
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  pos6 = "WP"
  pos = "WP"
}
  ]
]

Sem<=>ASem mark_WRB_lexicon : mark_PoS_slex_lexicon
[
  leftside = [
c:?Xl {
  ¬c:?NodeIn {}
  ¬c:word = ?w
  c:slex = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}

¬ (language.id.iso.?lg & concepticon.?s.?lg.lex.?lexLG & lexicon.?lexLG.pos.?posLG )

lexicon.?entry.lemma.?s
lexicon.?entry.pos.?pos & ?pos == "WRB"

//the vertex is not already a lexical unit that has a pos in the lexicon
¬ ( c:?Xl { c:lex = ?lex } & lexicon.?lex.pos.?posLex )
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  pos6 = "WRB"
  pos = "WRB"
}
  ]
]

Sem<=>ASem choose_pos_lexicon : choose_pos
[
  leftside = [
c:?Xl {
  //c:lex = ?lex
}

//lexicon.?lex.pos.?posLex
  ]
  mixed = [
rc:?Xr { rc:<=> ?Xl rc:lex = ?lex }

lexicon.?lex.pos.?posLex
  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  ¬rc:pos = ?pos
  pos = ?posLex
}
  ]
]

Sem<=>ASem choose_pos_VB : choose_pos
[
  leftside = [
c:?Xl {
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  // ¬rc:pos = ?pR
  rc:pos1 = "VB"
  ¬rc:pos2 = ?p2
  ¬rc:pos3 = ?p3
  ¬rc:pos4 = ?p4
  ¬rc:pos5 = ?p5
  pos = "VB"
}
  ]
]

Sem<=>ASem choose_pos_VB_main : choose_pos
[
  leftside = [
c:?Xl {
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬c:definiteness = ?def
  ¬dpos = ?dpos
//  c:main = "sentence"
// if the node has a dependent, it can be realized by a verb
  c:?r-> c:?Yl {}
}
  ]
  mixed = [
// if the node is alone and can be an adverb, choose adverb; see choose_pos_RB_VB
// this condition gives problems; I added the condition about pos3 ="RB" and another rule VB_RB
//( rc:?Xr { rc:<=> ?Xl ¬rc:pos3 = "RB" } | c:?Govl { c:?r1-> c:?Xl {} } | ( c:?Xl { c:?s1-> c:?Y1l {} } & ¬?s1 == ?r ) | ¬?r == A1 )
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  // ¬rc:pos = ?pR
  rc:pos1 = "VB"
  (rc:pos2 = ?p2 | rc:pos3 = ?p3 | rc:pos4 = ?p4 | rc:pos5 = ?p5)
  pos = "VB"
}

// if there's a preposition above, the node is more probably a noun
//¬(rc:?Prep {rc:pos6 = "IN" rc:A2-> rc:?Xr {}})
// see pos_NN
( rc:?Xr { ( rc:A0-> rc:?Dep0R {} | rc:A1-> rc:?Dep1R {} | rc:A2-> rc:?Dep2R {} | rc:A3-> rc:?Dep3R {} ) }
 | rc:?Gov2R { rc:?R1-> rc:?Xr {} }
 | ( ¬ rc:?Gov3r { rc:?R3-> rc:?Xr { rc:pos2 = "NN" } } )
)

¬ rc:?Xr { rc:<=> ?Xl rc:pos3 = "RB" }
¬ rc:?Xr { rc:<=> ?Xl rc:NonCore-> rc:?CardR { ¬rc:pos3 = "RB" (rc:pos4 = "CD" | rc:pos4 ="JJ" ) } }

// BUG??? when instead of the condition just above, you activate the second part only (below), whether is is negated or not, the rule doesn't apply.
// textual_predArgs.conll, structure 8, EN setting
//¬ ( ¬ rc:?Gov2R { rc:?R1-> rc:?Xr {} } & rc:?Xr { ¬ rc:A0-> rc:?Dep0R {} ¬ rc:A1-> rc:?Dep1R {} ¬ rc:A2-> rc:?Dep2R {} ¬ rc:A3-> rc:?Dep3R {} } )
//¬ ( rc:?Gov3r { rc:?R3-> rc:?Xr { rc:<=> ?Xl } } & ?p2 == "NN" )
  ]
]

/*This rule covers the Mixed condition of VB_main.*/
Sem<=>ASem choose_pos_VB_RB : choose_pos
[
  leftside = [
c:?Xl {
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
//  c:main = "sentence"
}

( ¬ c:?Xl { c:A1-> c:?Yl {} } | ( c:?Govl { c:?r1-> c:?Xl {} } | c:?Xl { c:A1-> c:?Yl {} c:?s1-> c:?Y1l {} } ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  // ¬rc:pos = ?pR
  rc:pos1 = "VB"
  rc:pos3 = "RB"
  pos = "VB"
}
  ]
]

excluded Sem<=>ASem PATCH_choose_pos_VB_main : choose_pos
[
  leftside = [
c:?Xl {
  ¬c:type = "added"
  ¬c:type = META
  ¬dpos = ?dpos
//  c:main = "sentence"
// if the node has a dependent, it can be realized by a verb
  c:?r-> c:?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:pos1 = "VB"
  (rc:pos2 = ?p2 | rc:pos3 = ?p3 | rc:pos4 = ?p4 | rc:pos5 = ?p5)
  pos = "VB"
}
  ]
]

/*If one side of coord has pos and not the other side-> COPY*/
Sem<=>ASem choose_pos_COORDINATION : choose_pos
[
  leftside = [
c:?ConjCoord {
  c:?r-> c:?Conj1 {}
  c:?s-> c:?Conj2 {
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
  }
}

(?r == A1 | ?r == Argument1)
(?s == A2 | ?r == Argument2)
  ]
  mixed = [

  ]
  rightside = [
rc:?ConjCoordR {
  rc:<=> ?ConjCoord
  rc:pos = "CC"
}

rc:?Xr {
  rc:<=> ?Conj1
  rc:pos = ?pos
}

rc:?Yr {
  rc:<=> ?Conj2
  ¬rc:pos = ?o
  pos = ?pos
}
  ]
]

Sem<=>ASem choose_pos_NN : choose_pos
[
  leftside = [
c:?Xl {
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}
  ]
  mixed = [
// if the noun is alone and can be an adjective, choose the JJ postag
¬ (c:?Gov1l { c:NonCore-> c:?Xl { ¬c:?s1-> c:?Yl {} } }  & rc:?Xr { rc:<=> ?Xl rc:pos4 = "JJ" } )
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  // ¬rc:pos = ?pR
  rc:pos2 = "NN"
  //¬rc:pos3 = ?p3
  //¬rc:pos4 = ?p4
  //¬rc:pos5 = ?p5
  pos = "NN"
}

// node cannot be a verb
(rc:?Xr {¬rc:pos1 = ?p1}
// or it can be a verb but there is a preposition above
// | (rc:?Prep { () ( rc:pos6 = "IN" & ¬ rc:pos5 = "CC" ) rc:A2-> rc:?Xr {}})
// or if the node is an argument that has no dependents, it's most probably a noun
 | (rc:?Gov {rc:?arg-> rc:?Xr {rc:<=> ?Xl ¬rc:?rel-> rc:?DepR {}}}
  & (?arg == A0 | ?arg == A1 | ?arg == A2 | ?arg == A3 | ?arg == A4))
 | ( ¬ rc:?Gov2R { rc:?R1-> rc:?Xr {} } & rc:?Xr { ¬ rc:A0-> rc:?Dep0R {} ¬ rc:A1-> rc:?Dep1R {} ¬ rc:A2-> rc:?Dep2R {} ¬ rc:A3-> rc:?Dep3R {} })
 | rc:?Gov3R { rc:Location-> rc:?Xr {} }
 | rc:?Xr { rc:<=> ?Xl rc:NonCore-> rc:?CardR { ¬rc:pos3 ="RB" (rc:pos4 = "CD" | rc:pos4 ="JJ" ) } }
)
  ]
]

Sem<=>ASem choose_pos_NN_number_def : choose_pos
[
  leftside = [
c:?Xl {
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
  ( c:number = ?n | c:definiteness = ?def )
}

¬?n == "-"
¬?def == "-"
¬?def == "no"
  ]
  mixed = [
// if the noun is alone and can be an adjective, choose the JJ postag
¬ (c:?Gov1l { c:NonCore-> c:?Xl { ¬c:?s1-> c:?Yl {} } }  & rc:?Xr { rc:<=> ?Xl rc:pos4 = "JJ" } )
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:pos = ?pR
  pos = "NN"
}
  ]
]

/*If a node is not tagged, consider it's an NN.
In the second cluster, all mark_PoS rules have applied, and relations have been transferred.
If a node has no Pos attribute, it won't have one later, so we tag it as NN.*/
Sem<=>ASem choose_pos_NN_default : choose_pos
[
  leftside = [
c:?Xl {
  ¬c:?NodeIn {}
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos

}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  ¬rc:lex = ?lex
  ¬rc:pos1 = ?p1
  ¬rc:pos2 = ?p2
  ¬rc:pos3 = ?p3
  ¬rc:pos4 = ?p4
  ¬rc:pos5 = ?p5
  ¬rc:pos6 = ?p6
  ¬rc:pos = ?possss
  pos = "NN"
}

// The node receives a relation or governs one
(rc:?Node {rc:?r-> rc:?Xr {}} | rc:?Xr {rc:?s-> rc:?Node {}})
  ]
]

Sem<=>ASem choose_pos_RB : choose_pos
[
  leftside = [
c:?Xl {
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}
  ]
  mixed = [
// if it has two arguments and can be a prep, it's probably a prep
¬ ( c:?Xl { c:A1-> c:?Dep1 {} c:A2-> c:?Dep2 {} } & rc:?Xr { rc:<=> ?Xl rc:pos6 = "IN" } )
  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  // ¬rc:pos = ?pR
  ¬rc:pos1 = ?p1
  ¬rc:pos2 = ?p2
  rc:pos3 = "RB"
  //¬rc:pos4 = ?p4
  //¬rc:pos5 = ?p5
  pos = "RB"
}
  ]
]

/*A word such as "long" that can be a verb or an adverb (or an adj) should be realixed as an adverb if it is a stranded predicate with only one argument A1.*/
Sem<=>ASem choose_pos_RB_VB : choose_pos
[
  leftside = [
c:?Xl {
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
//  c:main = "sentence"
  c:A1-> c:?Yl {}
}

¬ c:?Govl { c:?r1-> c:?Xl {} }
¬ c:?Xl { c:A1-> c:?Yl {} c:?s1-> c:?Y1l {} }
  ]
  mixed = [
// if the node is alone and can be an adverb, choose adverb
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  // ¬rc:pos = ?pR
  rc:pos1 = "VB"
  rc:pos3 = "RB"
  pos = "RB"
}
  ]
]

/*If the node is the only node of the sentence, choose RB.*/
Sem<=>ASem choose_pos_RB_alone : choose_pos
[
  leftside = [
c:?Xl {
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}

¬c:?Yl { c:?r-> c:?Xl {} }
¬c:?Xl { c:?s-> c:?Zl {} }
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  // ¬rc:pos = ?pR
  rc:pos3 = "RB"
  pos = "RB"
}
  ]
]

Sem<=>ASem choose_pos_JJ : choose_pos
[
  leftside = [
c:?Xl {
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  // ¬rc:pos = ?pR
  ¬rc:pos1 = ?p1
  ¬rc:pos2 = ?p2
  ¬rc:pos3 = ?p3
  rc:pos4 = "JJ"
  //¬rc:pos5 = ?p5
  pos = "JJ"
}
  ]
]

/*if the noun is alone and can be an adjective, choose the JJ postag*/
Sem<=>ASem choose_pos_JJ_NN : choose_pos
[
  leftside = [
c:?Xl {
  ¬c:?NodeIn {}
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}

c:?Gov1l { c:NonCore-> c:?Xl { ¬c:?s1-> c:?Yl {} } }
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  // ¬rc:pos = ?pR
  rc:pos2 = "NN"
  rc:pos4 = "JJ"
  //¬rc:pos3 = ?p3
  //¬rc:pos4 = ?p4
  //¬rc:pos5 = ?p5
  pos = "JJ"
}

// node cannot be a verb
rc:?Xr {¬rc:pos1 = ?p1}
  ]
]

Sem<=>ASem choose_pos_CD : choose_pos
[
  leftside = [
c:?Xl {
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  // ¬rc:pos = ?pR
  ¬rc:pos1 = ?p1
  ¬rc:pos2 = ?p2
  ¬rc:pos3 = ?p3
  rc:pos4 = "CD"
  //¬rc:pos5 = ?p5
  pos = "CD"
}
  ]
]

Sem<=>ASem choose_pos_DT : choose_pos
[
  leftside = [
c:?Xl {
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  // ¬rc:pos = ?pR
  ¬rc:pos1 = ?p1
  ¬rc:pos2 = ?p2
  ¬rc:pos3 = ?p3
  ¬rc:pos4 = ?p4
  rc:pos5 = "DT"
  pos = "DT"
}
  ]
]

Sem<=>ASem choose_pos_CC : choose_pos
[
  leftside = [
c:?Xl {
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  // ¬rc:pos = ?pR
  rc:pos5 = "CC"
  pos = "CC"
}
  ]
]

Sem<=>ASem choose_pos_IN : choose_pos
[
  leftside = [
c:?Xl {
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  // ¬rc:pos = ?pR
  ¬rc:pos5 = "CC"
  rc:pos6 = "IN"
  pos = "IN"
}
  ]
]

Sem<=>ASem choose_pos_NP_kristina : choose_pos
[
  leftside = [
c:?Xl {
  c:sem = ?s
}

language.id.iso.PL

( ?s == "Chińczyka" | ?s == "Młynek" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  pos2 = "NP"
  pos = "NP"
}
  ]
]

excluded Sem<=>ASem tag_specific_words_NN : choose_pos
[
  leftside = [
c:?Xl {
  (c:slex = "apple")
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  pos = "NN"
}
  ]
]

excluded Sem<=>ASem tag_specific_words_Adv : choose_pos
[
  leftside = [
c:?Xl {
  (c:slex = "now" | c:slex = "today")
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  pos = "NN"
}
  ]
]

/*If a node is tagged as a verb but looks like it should be a noun given the context of the semantic structure, change it!
There are equivalences between verbal and non-verbal counterparts in the lexicon.*/
Sem<=>ASem PoS_VB_to_NN_lexicon_corresp : change_pos
[
  leftside = [
c:?Xl {}
  ]
  mixed = [
// the verb is an argument of another predicate
( rc:?Gov { rc:lex = ?lex1 rc:?R1-> rc:?Xr { rc:<=> ?Xl rc:sem = ?sem} }
 & lexicon.?lex1.gp.?R1.?DSyntR & ¬ ( ?DSyntR == ATTR | ?DSyntR == APPEND | ?DSyntR == COORD ) )
// there is a noun corresponding to the verb in the lexicon
( lexicon.miscellaneous.verb_correspondences.?sem.NN.lex.?lexNN & ¬?lexNN == "" )
// The verb has no first argument
¬ ( rc:?Xr { rc:<=> ?Xl rc:lex = ?lex2 rc:?R2-> rc:?Yr {} }
 & lexicon.?lex2.gp.?R2.I )
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:pos = "VB"
  pos = "NN"
  sem = ?lexNN
  // I chose the same name in the VB_to_NN rules to have only one attribute  to transfer
  real_pos = "VB"
  lex = #?lexNN+_NN_01#
  //real_lex = #?lexNN+_NN_01#
}
  ]
]

/*If a node is tagged as a verb but looks like it should be a noun given the context of the semantic structure, change it!*/
Sem<=>ASem PoS_VB_to_NN_gerund : change_pos
[
  leftside = [
c:?Xl {}
  ]
  mixed = [
// the verb is an argument of another predicate
( rc:?Gov { rc:lex = ?lex1 rc:?R1-> rc:?Xr { rc:<=> ?Xl rc:sem = ?sem rc:lex = ?lexX} }
 & lexicon.?lex1.gp.?R1.?DSyntR & ¬ ( ?DSyntR == ATTR | ?DSyntR == APPEND | ?DSyntR == COORD ) )
// there isn't a noun corresponding to the verb in the lexicon
¬ ( lexicon.miscellaneous.verb_correspondences.?sem.NN.lex.?lexNN & ¬?lexNN == "" )
// there isn't a noun with the same lex in the lexicon
//¬ ( lexicon.?lexX.pos.?posX & ?posX == "NN" )
// The verb has no first argument
¬ ( rc:?Xr { rc:<=> ?Xl rc:lex = ?lex2 rc:?R2-> rc:?Yr {} }
 & lexicon.?lex2.gp.?R2.I )
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:sem = ?sem
  rc:pos = "VB"
  ¬rc:real_pos = ?rp
  real_pos = "NN"
  real_lex = #?sem+_NN_01#
  // don't apply if there is a "what" below, for instance.
  ¬rc:?RWP-> ?WP {
    rc:pos = "WP"
  }
}
  ]
]

/*If a node is tagged as a verb but looks like it should be a noun given the context of the semantic structure, change it!
This rule appleis if there is no correspondence between the verb and the noun, but there is a noun with the same lex.*/
Sem<=>ASem PoS_VB_to_NN_lexicon_lex : change_pos
[
  leftside = [
c:?Xl {}
  ]
  mixed = [
rc:?Xr { rc:<=> ?Xl rc:real_lex = ?rlex }
( lexicon.?rlex.pos.?pos & ?pos == "NN" & lexicon.?rlex.lemma.?lemX )
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:real_pos = "NN"
  rc:real_lex = ?rlex
  pos = "NN"
  lex = ?rlex
  sem = ?lemX
}
  ]
]

/*An adjective that has no first argument is more likely a noun, unless it is NonCore.*/
Sem<=>ASem PoS_JJ_to_NN : change_pos
[
  leftside = [
c:?Xl {
  ¬c:A1-> c:?Yl {}
}

// In V4Design, these are really adjectives
¬ ?Xl.variable_class == "PositiveValue"
¬ ?Xl.variable_class == "NegativeValue"
¬ ?Xl.variable_class == "MixedValue"
¬ ?Xl.variable_class == "OtherValue"

¬c:?Gov1l {
  c:NonCore-> c:?Xl {}
}

¬c:?Gov2l {
  c:NonCore-> c:?Conj { c:Set-> c:?Xl {} }
}
¬c:?Gov3l {
  c:Elaboration-> c:?Xl {}
}
  ]
  mixed = [
//¬ ( c:?Xl { c:A2-> c:?A2l {} } & rc:?Xr { rc:<=> ?Xl rc:lex = ?lex2 } & lexicon.?lex2.origin.link.?pp & ?pp == "ppart" )
// If one of the other arguments map to ATTR, it's OK
¬ ( rc:?Xr { rc:<=> ?Xl rc:lex = ?lex } & lexicon.?lex.gp.A2.ATTR )
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:A1-> rc:?Yr {}
  // don't apply if PoS was chosen from the lexicon (xR4DRAMA str. 11)
  ¬rc:pos4 = "JJ"
  rc:pos = "JJ"
  //rc:lex = ?lex
  pos = "NN"
}

¬ rc:?Gov1R { ( rc:pos = "NN" | rc:pos2 = "NN" | rc:pos = "NP" ) rc:NonCore-> rc:?Xr {} }
  ]
]

/*An adjective that has no first argument is more likely a noun. Except if one other argument maps to ATTR.*/
Sem<=>ASem PoS_NN_to_JJ : change_pos
[
  leftside = [
c:?Xl {
  ¬c:A1-> c:?Yl {}
}
  ]
  mixed = [
// If one of the other arguments map to ATTR, it's OK
( rc:?Xr { rc:<=> ?Xl rc:lex = ?lex } & ( lexicon.?lex.gp.A2.ATTR | lexicon.?lex.gp.A3.ATTR ) )
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:A1-> rc:?Yr {}
  rc:pos = "NN"
  rc:lex = ?lex
  pos = "JJ"
}
  ]
]

/*Why for English only?
Answer: it was because before, the input structures in other languages took into account if an input predicate was going to map onto a predicate with ext arg.
E.g. the A1 of "inaugurate" in Spanish referred to the second argument even though there was no info about the lex in the input.
Added a new attribute to the sentences in which the ext arg are already taken in to account in the argument numbering (hasExtArg="solved"),
 so the arg numbers are not updated during the execution of the next grammar.*/
Sem<=>ASem mark_ext_arg : other_markers
[
  leftside = [
c:?Xl {
// the node doesn't already have a PB/NB disambiguation
  ¬c:lex = ?l
  ¬c:hasExtArg = ?h
  
}

// The following is very slow, since we have to scan the whole lexicon
//lexicon.?entry.lemma.?l
//lexicon.?entry.pbsenseID.?id
//lexicon.?entry.gp.A0

//?id == "01"

//language.id.iso.EN

¬c:?Sl { c:slex="Sentence" c:hasExtArg="solved" c:?Xl{} }
  ]
  mixed = [
rc:?Xr { rc:<=> ?Xl  rc:lex = ?lex }
lexicon.?lex.gp.A0
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //rc:lex = ?lex
  ¬rc:hasExtArg = "yes"
  hasExtArg = "yes"
}
  ]
]

/*this rule assigns a number to conjuncts in a coordination in order to help building the syntactic structure later on.
(we will attach each conjunct "num=n" to the conjunct "num = n-1s"*/
Sem<=>ASem mark_conjunct_number_1 : other_markers
[
  leftside = [
c:?Xl {
  c:member = "A1"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  conj_num = "1"
}
  ]
]

/*this rule assigns a number to conjuncts in a coordination in order to help building the syntactic structure later on.
(we will attach each conjunct "num=n" to the conjunct "num = n-1s"*/
Sem<=>ASem mark_conjunct_number_2 : other_markers
[
  leftside = [
c:?Xl {
  c:member = "A2"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  conj_num = "2"
}
  ]
]

/*this rule assigns a number to conjuncts in a coordination in order to help building the syntactic structure later on.
(we will attach each conjunct "num=n" to the conjunct "num = n-1s"*/
Sem<=>ASem mark_conjunct_number_3 : other_markers
[
  leftside = [
c:?Xl {
  c:member = "A3"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  conj_num = "3"
}
  ]
]

/*this rule assigns a number to conjuncts in a coordination in order to help building the syntactic structure later on.
(we will attach each conjunct "num=n" to the conjunct "num = n-1s"*/
Sem<=>ASem mark_conjunct_number_4 : other_markers
[
  leftside = [
c:?Xl {
  c:member = "A4"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  conj_num = "4"
}
  ]
]

/*this rule assigns a number to conjuncts in a coordination in order to help building the syntactic structure later on.
(we will attach each conjunct "num=n" to the conjunct "num = n-1s"*/
Sem<=>ASem mark_conjunct_number_5 : other_markers
[
  leftside = [
c:?Xl {
  c:member = "A5"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  conj_num = "5"
}
  ]
]

/*this rule assigns a number to conjuncts in a coordination in order to help building the syntactic structure later on.
(we will attach each conjunct "num=n" to the conjunct "num = n-1s"*/
Sem<=>ASem mark_conjunct_number_6 : other_markers
[
  leftside = [
c:?Xl {
  c:member = "A6"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  conj_num = "6"
}
  ]
]

/*this rule assigns a number to conjuncts in a coordination in order to help building the syntactic structure later on.
(we will attach each conjunct "num=n" to the conjunct "num = n-1s"*/
Sem<=>ASem mark_conjunct_number_7 : other_markers
[
  leftside = [
c:?Xl {
  c:member = "A7"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  conj_num = "7"
}
  ]
]

/*this rule assigns a number to conjuncts in a coordination in order to help building the syntactic structure later on.
(we will attach each conjunct "num=n" to the conjunct "num = n-1s"*/
Sem<=>ASem mark_conjunct_number_8 : other_markers
[
  leftside = [
c:?Xl {
  c:member = "A8"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  conj_num = "8"
}
  ]
]

/*this rule assigns a number to conjuncts in a coordination in order to help building the syntactic structure later on.
(we will attach each conjunct "num=n" to the conjunct "num = n-1s"*/
Sem<=>ASem mark_conjunct_number_9 : other_markers
[
  leftside = [
c:?Xl {
  c:member = "A9"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  conj_num = "9"
}
  ]
]

/*this rule assigns a number to conjuncts in a coordination in order to help building the syntactic structure later on.
(we will attach each conjunct "num=n" to the conjunct "num = n-1s"*/
Sem<=>ASem mark_conjunct_number_10 : other_markers
[
  leftside = [
c:?Xl {
  c:member = "A10"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  conj_num = "10"
}
  ]
]

/*this rule assigns a number to conjuncts in a coordination in order to help building the syntactic structure later on.
(we will attach each conjunct "num=n" to the conjunct "num = n-1s"*/
Sem<=>ASem mark_conjunct_number_11 : other_markers
[
  leftside = [
c:?Xl {
  c:member = "A11"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  conj_num = "11"
}
  ]
]

/*this rule assigns a number to conjuncts in a coordination in order to help building the syntactic structure later on.
(we will attach each conjunct "num=n" to the conjunct "num = n-1s"*/
Sem<=>ASem mark_conjunct_number_12 : other_markers
[
  leftside = [
c:?Xl {
  c:member = "A12"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  conj_num = "12"
}
  ]
]

/*this rule assigns a number to conjuncts in a coordination in order to help building the syntactic structure later on.
(we will attach each conjunct "num=n" to the conjunct "num = n-1s"*/
Sem<=>ASem mark_conjunct_number_13 : other_markers
[
  leftside = [
c:?Xl {
  c:member = "A13"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  conj_num = "13"
}
  ]
]

/*this rule assigns a number to conjuncts in a coordination in order to help building the syntactic structure later on.
(we will attach each conjunct "num=n" to the conjunct "num = n-1s"*/
Sem<=>ASem mark_conjunct_number_14 : other_markers
[
  leftside = [
c:?Xl {
  c:member = "A14"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  conj_num = "14"
}
  ]
]

/*this rule assigns a number to conjuncts in a coordination in order to help building the syntactic structure later on.
(we will attach each conjunct "num=n" to the conjunct "num = n-1"*/
Sem<=>ASem mark_conjunct_number_15 : other_markers
[
  leftside = [
c:?Xl {
  c:member = "A15"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  conj_num = "15"
}
  ]
]

/*this rule assigns a number to conjuncts in a coordination in order to help building the syntactic structure later on.
(we will attach each conjunct "num=n" to the conjunct "num = n-1s"*/
Sem<=>ASem mark_conjunct_number_16 : other_markers
[
  leftside = [
c:?Xl {
  c:member = "A16"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  conj_num = "16"
}
  ]
]

/*this rule assigns a number to conjuncts in a coordination in order to help building the syntactic structure later on.
(we will attach each conjunct "num=n" to the conjunct "num = n-1s"*/
Sem<=>ASem mark_conjunct_number_17 : other_markers
[
  leftside = [
c:?Xl {
  c:member = "A17"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  conj_num = "17"
}
  ]
]

/*this rule assigns a number to conjuncts in a coordination in order to help building the syntactic structure later on.
(we will attach each conjunct "num=n" to the conjunct "num = n-1s"*/
Sem<=>ASem mark_conjunct_number_18 : other_markers
[
  leftside = [
c:?Xl {
  c:member = "A18"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  conj_num = "18"
}
  ]
]

/*this rule assigns a number to conjuncts in a coordination in order to help building the syntactic structure later on.
(we will attach each conjunct "num=n" to the conjunct "num = n-1s"*/
Sem<=>ASem mark_conjunct_number_19 : other_markers
[
  leftside = [
c:?Xl {
  c:member = "A19"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  conj_num = "19"
}
  ]
]

/*Marks a Location or a Time node if they are the same under a root node in two consecutive sentences.
Used for pronominalization later on.*/
Sem<=>ASem mark_sameLoc : other_markers
[
  leftside = [
c:?S1l {
  c:?X1l {
    c:Location-> c:?Y1l {
      // Both Ys are single nodes (more complicated to check multiple nodes)
      ¬c:?s1-> c:?Dep1 {}
    }
  }
  c:b-> c:?S2l {
    c:?X2l {
      c:Location-> c:?Y2l {
        // Both Ys are single nodes (more complicated to check multiple nodes)
        ¬c:?s2-> c:?Dep2 {}
      }
    }
  }
}

?Y1l.sem == ?Y2l.sem

// Both Xs are roots
( ¬c:?Gov1 { c:?r1-> c:?X1l {} } | ( c:?And5 { c:Set-> c:?X1l {} } & ¬c:?Gov5 { c:?r5-> c:?And5 {} } ) )
( ¬c:?Gov2 { c:?r2-> c:?X2l {} } | ( c:?And6 { c:Set-> c:?X2l {} } & ¬c:?Gov6 { c:?r6-> c:?And6 {} } ) )

// The locations are not involved in another subgraph (which may contain another location and make the pronominal  reference ambiguous)
¬ ( c:?Gov3 { c:id = ?idG3 c:?r3-> c:?Y1l {} } & c:?X1l { c:id = ?idX1 } & ¬ ?idG3 == ?idX1 )
¬ ( c:?Gov4 { c:id = ?idG4 c:?r3-> c:?Y2l {} } & c:?X2l { c:id = ?idX2 } & ¬ ?idG4 == ?idX2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Y2r {
  rc:<=> ?Y2l 
  SameLocAsPrevious = "YES"
}
  ]
]

/*Same LeftSide as rel_coref_add_NP.
KEEP SYNC!*/
Sem<=>ASem mark_sameLoc2 : other_markers
[
  leftside = [
c:?Tl {
  c:?S1r {
    c:id = ?idS1
    c:?X1l {
      c:dpos = "NP"
      c:sem = ?sX1
    }
    // why was there a star on b?
    c:*b-> c:?S2r {
      c:id = ?idS2
      c:?X2l {
        c:dpos = "NP"
        c:sem = ?sX2
      }
    }
  }
}

?sX1 == ?sX2

// so all corefs point to the NP from the same bubble
¬ ( c:?S3r { c:*b-> c:?S2r {} c:id = ?idS3 c:?X3l { c:dpos = "NP" c:sem = ?sX3 } }
    & ?sX3 == ?sX2 & ?idS3 < ?idS1 )

( ?X1l.class == "Location" | ?X2l.class == "Location" )

// The locations are not involved in two subgraphs (which may contain another location and make the pronominal  reference ambiguous)
¬ ( c:?Gov4 { c:id = ?idG4 c:?r4-> c:?X1l {} } & c:?Gov5 { c:id = ?idG5 c:?r5-> c:?X1l {} } & ¬?idG4 == ?idG5 )
¬ ( c:?Gov6 { c:id = ?idG6 c:?r6-> c:?X2l {} } & c:?Gov7 { c:id = ?idG7 c:?r7-> c:?X2l {} } & ¬?idG6 == ?idG7 )
  ]
  mixed = [

  ]
  rightside = [
rc:?X2r {
  rc:<=> ?X2l
  SameLocAsPrevious = "YES"
}
  ]
]

/*Marks a Location or a Time node if they are the same under a root node in two consecutive sentences.
Used for pronominalization later on.*/
Sem<=>ASem mark_sameTime : other_markers
[
  leftside = [
c:?S1l {
  c:?X1l {
    c:Time-> c:?Y1l {
      // Both Ys are single nodes (more complicated to check multiple nodes)
      ¬c:?s1-> c:?Dep1 {}
    }
  }
  c:b-> c:?S2l {
    c:?X2l {
      c:Time-> c:?Y2l {
        // Both Ys are single nodes (more complicated to check multiple nodes)
        ¬c:?s2-> c:?Dep2 {}
      }
    }
  }
}

?Y1l.sem == ?Y2l.sem

// Both Xs are roots
( ¬c:?Gov1 { c:?r1-> c:?X1l {} } | ( c:?And5 { c:Set-> c:?X1l {} } & ¬c:?Gov5 { c:?r5-> c:?And5 {} } ) )
( ¬c:?Gov2 { c:?r2-> c:?X2l {} } | ( c:?And6 { c:Set-> c:?X2l {} } & ¬c:?Gov6 { c:?r6-> c:?And6 {} } ) )

// The times are not involved in another subgraph (which may contain another location and make the pronominal  reference ambiguous)
¬ ( c:?Gov3 { c:id = ?idG3 c:?r3-> c:?Y1l {} } & c:?X1l { c:id = ?idX1 } & ¬ ?idG3 == ?idX1 )
¬ ( c:?Gov4 { c:id = ?idG4 c:?r3-> c:?Y2l {} } & c:?X2l { c:id = ?idX2 } & ¬ ?idG4 == ?idX2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Y2r {
  rc:<=> ?Y2l 
  SameTimeAsPrevious = "YES"
}
  ]
]

Sem<=>ASem mark_classLocation : other_markers
[
  leftside = [
c:?Tl {
  c:?S1r {
    c:id = ?idS1
    c:?X1l {
      c:dpos = "NP"
      c:sem = ?sX1
    }
    // why was there a star on b?
    c:*b-> c:?S2r {
      c:id = ?idS2
      c:?X2l {
        c:dpos = "NP"
        c:sem = ?sX2
      }
    }
  }
}

?sX1 == ?sX2
  ]
  mixed = [

  ]
  rightside = [
rc:?X2r {
  rc:<=> ?X2l
  rc:SameLocAsPrevious = "YES"
  rc:class = "Location"
}

rc:?X1r {
  rc:<=> ?X1l
  class = "Location"
}
  ]
]

Sem<=>ASem mark_VB_lexicon : mark_PoS_word
[
  leftside = [
c:?Xl {
  c:word = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}

lexicon.?entry.lemma.?s
lexicon.?entry.pos.?pos

?pos == "VB"
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  //rc:dlex = ?s
  pos1 = "VB"
}
  ]
]

excluded Sem<=>ASem mark_VB_default : mark_PoS_word
[
  leftside = [
c:?Xl {
  c:slex = ?s
  ¬dpos = ?dpos
}

¬(lexicon.?entry.lemma.?s & lexicon.?entry.pos.?pos & ?pos == "VB")
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  pos = "VB"
}
  ]
]

Sem<=>ASem mark_NN_lexicon : mark_PoS_word
[
  leftside = [
c:?Xl {
  c:word = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}

lexicon.?entry.lemma.?s
lexicon.?entry.pos.?pos

?pos == "NN"
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  //rc:dlex = ?s
  pos2 = "NN"
  //pos_lexicon= applied
}
  ]
]

Sem<=>ASem mark_RB_lexicon : mark_PoS_word
[
  leftside = [
c:?Xl {
  c:word = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}

lexicon.?entry.lemma.?s
lexicon.?entry.pos.?pos

?pos == "RB"
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  //rc:dlex = ?s
  pos3 = "RB"
}
  ]
]

Sem<=>ASem mark_JJ_lexicon : mark_PoS_word
[
  leftside = [
c:?Xl {
  c:word = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}

lexicon.?entry.lemma.?s
lexicon.?entry.spos.?pos

?pos == adjective
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  //rc:dlex = ?s
  pos4 = "JJ"
}
  ]
]

Sem<=>ASem mark_CD : mark_PoS_word
[
  leftside = [
c:?Xl {
  c:word = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
}

(?s == 0 | ?s < 0 | ?s > 0)
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  pos4 = "CD"
  //pos_default= applied
}
  ]
]

Sem<=>ASem mark_CC_lexicon : mark_PoS_word
[
  leftside = [
c:?Xl {
  c:word = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬c:dpos = ?dpos
}

lexicon.?entry.lemma.?s
lexicon.?entry.pos.?pos

?pos == "CC"
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  //rc:dlex = ?s
  pos5 = "CC"
}
  ]
]

Sem<=>ASem mark_IN_lexicon : mark_PoS_word
[
  leftside = [
c:?Xl {
  c:word = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}

lexicon.?entry.lemma.?s
lexicon.?entry.pos.?pos

?pos == "IN"
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  //rc:dlex = ?s
  pos6 = "IN"
}
  ]
]

Sem<=>ASem mark_NP_NE : mark_PoS_word
[
  leftside = [
c:?Xl {
  c:word = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
  (NE = "YES" | entityType = "person")
}

¬(lexicon.?entry.lemma.?s & lexicon.?entry.pos.?pos & ?pos == "VB")
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  pos6 = "NP"
  pos = "NP"
  //pos_default= applied
}
  ]
]

Sem<=>ASem mark_PRP_lexicon : mark_PoS_word
[
  leftside = [
c:?Xl {
  c:word = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}

lexicon.?entry.lemma.?s
lexicon.?entry.pos.?pos & ?pos == "PRP"
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  pos6 = "PRP"
  pos = "PRP"
}
  ]
]

Sem<=>ASem mark_WP_lexicon : mark_PoS_word
[
  leftside = [
c:?Xl {
  c:word = ?s
  ¬c:type = "added"
  ¬c:type = META
  ¬c:type = "META"
  ¬dpos = ?dpos
}

lexicon.?entry.lemma.?s
lexicon.?entry.pos.?pos & ?pos == "WP"
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr {
  rc:<=> ?Xl
  pos6 = "WP"
  pos = "WP"
}
  ]
]

/*If a "welcome" has not been aggregated in E2E (identified by the presence of "familyFriendly" feature), remove restaurant name so it generates a passive.*/
Sem<=>ASem E2E_block_name_family_friendly : mark_block
[
  leftside = [
c:?Sl {
  familyFriendly = "yes"
  c:?Xl {
    c:sem = "welcome"
    c:A1-> c:?D1 {
      ¬c:?r1-> c:?N1 {}
      c:dpos = "NP"
    }
    c:A2-> c:?D2 {
      ¬c:?r2-> c:?N2 {}
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Dr1 {
  rc:<=> ?D1
  blocked = "YES"
}
  ]
]

Sem<=>ASem DE_remove_dich : PATCH
[
  leftside = [
c:?Xl {
  c:Argument1-> c:?Yl {
    c:sem = "du"
  }
  c:Argument1-> c:?Zl {
    c:sem = "dich"
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  blocked = "YES"
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

