Sem<=>DSynt transfer_node
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*For nodes that have no LS correspondences but that must be included in the RS bubble anyway.*/
Sem<=>DSynt bubbles
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>DSynt transfer_attribute
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>DSynt transfer_relations
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

excluded Sem<=>DSynt disabled
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>DSynt mark
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*These rules transfer the root of the DSynt tree, from which the transduction starts at this level.
The other rules expand the tree downwards.*/
Sem<=>DSynt transfer_node_ROOT : transfer_node
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>DSynt transfer_node_arg : transfer_node
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>DSynt transfer_node_no_arg : transfer_node
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*These rules are supposed to apply for args and no args.
These rules are the same as transfer_arg rules, without the condition about the mapping of the relation.
ONLY TESTED WITH NO ARG! PTB_train_4092*/
Sem<=>DSynt transfer_node_APPEND_consumed : transfer_node
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

excluded Sem<=>DSynt node_disabled : transfer_node
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>DSynt bubble : bubbles
[
  leftside = [
?Bub {
  sem = ?s
  c:?Node {}
}
  ]
  mixed = [

  ]
  rightside = [
?BubR {
  <=> ?Bub
  dlex = ?s
}
  ]
]

Sem<=>DSynt bubble_fill : bubbles
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

Sem<=>DSynt bubble_expand_gov : bubbles
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
Sem<=>DSynt bubble_expand_dep : bubbles
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

/*Not needed so far*/
Sem<=>DSynt bubble_expand_sibling_II : bubbles
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?GovR {
  rc:?r-> rc:?Yr {
    rc:include = bubble_of_sibling_II
  }
  rc:II-> rc:?Xr {
    rc:<=> ?Xl
  }
}

rc:?bubble {
  rc:?Xr { rc:<=> ?Xl}
  rc:+?Yr {}
}
  ]
]

Sem<=>DSynt CA_transfer_attributes : transfer_attribute
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>DSynt K_attr_gestures : transfer_attribute
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>DSynt MS_transfer_attributes : transfer_attribute
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>DSynt EL_transfer_attributes : transfer_attribute
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>DSynt EN_transfer_attributes : transfer_attribute
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>DSynt ES_transfer_attributes : transfer_attribute
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>DSynt PL_transfer_attribute : transfer_attribute
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>DSynt DE_transfer_attributes : transfer_attribute
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>DSynt PT_transfer_attributes : transfer_attribute
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>DSynt attr_ambiguous_antecedent : transfer_attribute
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

Sem<=>DSynt attr_blocked : transfer_attribute
[
  leftside = [
c:?Xl{
  blocked = ?u
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  blocked = ?u
}
  ]
]

Sem<=>DSynt attr_bnId : transfer_attribute
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
  rc:<=> ?Xl
  bnId = ?u
}
  ]
]

/*This applies in the second cluster. If a bubble doesn't contain a node in the second cluster
it will remain empty-> fallback.*/
Sem<=>DSynt attr_bubble : transfer_attribute
[
  leftside = [
c:?Bub {
  c:?Node {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Bub
  bubble = "yes"
}
  ]
]

Sem<=>DSynt attr_case_copy : transfer_attribute
[
  leftside = [
c:?Yl {
  case = ?c
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
 ¬rc:case = ?c
 case = ?c
}
  ]
]

/*this rule is very slow with ENGLISH! maybe because RS check to lexicon! Still the case?

Go check the governor on the right side to avoid duplicating rule in case of coordinations, introductionof LFs or governed prepositions.*/
Sem<=>DSynt attr_case_lexicon_gov : transfer_attribute
[
  leftside = [
c:?Yl {
  ¬c:case = ?c
}

// NOT NEEDED FOR MULTISENSOR (since the rule is slow, avoid it...)
// it should be fixed now, with the variables declared in the mixed field.
//¬ project_info.project.name.MULTISENSOR
// the information is not present in the EN dictionary for the moment, no need to go get it
¬ language.id.iso.EN
  ]
  mixed = [
rc:?Xr { rc:lex = ?lex rc:?r-> rc:?Yr {rc:<=> ?Yl} }
( lexicon.?lex.gp.?r.case.?case | lexicon.?lex.gp.?r.?n.case.?case )

// in the following case, the noun below takes the case assigned to the verb
// see DE_attr_case_percolate
//¬ ( language.id.iso.DE & ?r == II & rc:?Xr { rc:pos = "VB" rc:case = ?cX } )
  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  // some node-building rules can assign cases already
 ¬rc:case = ?c
  case = ?case
}
  ]
]

/*BUG: this rule doesn't apply well on 170316_KRISTINA_P2 #5.*/
Sem<=>DSynt attr_case_COORD_copy : transfer_attribute
[
  leftside = [
c:?Coord {
  c: pos = "CC"
  c:?r1-> c:?Xl {}
  c:?r2-> c:?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:case = ?c
  rc:COORD-> rc:?CR {
    rc:<=> ?Coord
    rc:pos = "CC"
    rc:II-> rc:?Yr {
      rc:<=> ?Yl
      case = ?c
    }
  }
}
  ]
]

/*By default in English, the first nominal argument of a noun is assigned a GENitive.
Dunno if this is a very good rule.*/
Sem<=>DSynt attr_case_GEN_possessive_I : transfer_attribute
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  c:pos = "NN"
  c:?r-> c:?Yl {
    ( c:pos = "NN" | c:pos = "NP" )
  }
}

¬ ( lexicon.?lex.gp.?r.I & lexicon.?lex.gp.I.case.?case )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:pos = "VB"
  rc:I-> rc:?Yr {
    rc:<=> ?Yl
    case = "GEN"
  }
}
  ]
]

/*By default in English, the first nominal argument of a noun is assigned a GENitive.
Probably an even worse rule than the I rule above.*/
Sem<=>DSynt attr_case_GEN_possessive_II : transfer_attribute
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  c:pos = "NN"
  c:?r-> c:?Yl {
    ( c:pos = "NN" | c:pos = "NP" | c:pos = "PRP" )
  }
}

¬ ( lexicon.?lex.gp.?r.II & lexicon.?lex.gp.II.case.?case )

lexicon.?lex.gp.II.prep.?prep
// There is a governed preposition between X and Y and this preposition is marked as possibly indicating a Genitive cae in the lexicon.
lexicon.miscellaneous.case_prep.GEN.lex.?prep2
?prep == ?prep2
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:pos = "VB"
  rc:II-> rc:?NodeR {
    case = "GEN"
    rc:lex = ?lexNR
  }
}

rc:?Yr {
  rc:<=> ?Yl
  rc:lex = ?lexYR
}

?lexYR == ?lexNR
  ]
]

/*By default in English, the first nominal argument of a noun is assigned a GENitive.
Dunno if this is a very good rule.
Covers cases with antecedents too.*/
Sem<=>DSynt attr_case_GEN_possessive_antecedent : transfer_attribute
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  c:pos = "NN"
  c:?r-> c:?Yl {
    ( c:pos = "NN" | c:pos = "NP" )
  }
}

lexicon.?lex.gp.?r.I

¬(lexicon.?lex.gp.I.case.?case)
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:pos = "VB"
  rc:I-> rc:?Yr {
    case = "GEN"
  }
}
  ]
]

Sem<=>DSynt attr_class : transfer_attribute
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
  ¬rc:class = ?class
  class = ?u
}
  ]
]

/*dpos should be VB, NN, RB, JJ (see pos rules below)*/
Sem<=>DSynt attr_clause_type : transfer_attribute
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
  rc:main = yes
  clause_type = ?ds
}
  ]
]

/*dpos should be VB, NN, RB, JJ (see pos rules below)*/
Sem<=>DSynt attr_clause_type_default : transfer_attribute
[
  leftside = [
c:?Xl {
  ¬c:clause_type = ?ds
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:main = yes
  clause_type = "DECL"
}
  ]
]

/*dpos should be VB, NN, RB, JJ (see pos rules below)*/
Sem<=>DSynt attr_coord_type : transfer_attribute
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
Sem<=>DSynt attr_dative_shift : transfer_attribute
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

Sem<=>DSynt attr_def_copy : transfer_attribute
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
  ¬rc:finiteness = "FIN"
  definiteness = ?def
}
  ]
]

Sem<=>DSynt attr_def_lexicon : transfer_attribute
[
  leftside = [
c:?Xl {
  c:lex = ?lex
}

lexicon.?lex.definiteness.?def
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:finiteness = "FIN"
  definiteness = ?def
}
  ]
]

/*Go check the governor on the right side to avoid duplicating rule in case of coordinations, introductionof LFs or governed prepositions.*/
Sem<=>DSynt attr_def_lexicon_gov : transfer_attribute
[
  leftside = [
c:?Xl {
  ¬c:definiteness = ?def1
}
  ]
  mixed = [
rc:?Vr { rc:lex = ?lex rc:?r-> rc:?Xr { rc:<=> ?Xl } }
lexicon.?lex.gp.?r.definiteness.?def
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:finiteness = "FIN"
  definiteness = ?def
}
  ]
]

Sem<=>DSynt attr_def_COORD_copy : transfer_attribute
[
  leftside = [
c:?Coord {
  c: pos = "CC"
  c:?r1-> c:?Xl {}
  c:?r2-> c:?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:definiteness = ?c
  rc:COORD-> rc:?CR {
    rc:<=> ?Coord
    rc:pos = "CC"
    rc:II-> rc:?Yr {
      rc:<=> ?Yl
      // so the present rule applies when the definiteness transfer rule also already applied
      rc:id = ?id
      ¬rc:definiteness = ?f2
      definiteness = ?c
    }
  }
}
  ]
]

/*A quick guess is if there is an argument, maybe the noun is more prone to be definite...*/
Sem<=>DSynt attr_def_default_INDEF : transfer_attribute
[
  leftside = [
c:?Xl {
  ( c:pos = "NN" | c:real_pos = "NN" )
  ¬c:NE = "YES"
  ¬c:definiteness = ?def
  ¬c:date_type = ?dt
  // replaced by RS condition
  //¬c:?SemR-> c:?Yl {}
}

//?Xl is not the argument of a number
¬ c:?Node1L { c:pos = "CD" c:A1-> c:?Xl {} }
// There is no definiteness in the lexicon foreseen by the governor; now in mixed to check right side governor
//¬ (c:?Node2L {c:lex = ?lex c:?r2-> c:?Xl {}}
 //& lexicon.?lex.gp.?r2.?DSyntR & lexicon.?lex.gp.?DSyntR.definiteness)

//?Xl doesn't have a predefined definiteness (note that ?def can be "no")
¬ ( c:?Xl { c:lex = ?lexXl } & lexicon.?lexXl.definiteness.?def )

¬ (language.id.iso.EN &
 ( c:?Node3l { c:sem = "watch" c:?r3-> c:?Xl { c:sem = "tv" } }
 | c:?Node4l { c:sem = "go" c:?r4-> c:?Xl { c:sem = "toilet" } }
 | c:?Node5l { c:sem = "during" c:?r5-> c:?Xl { c:sem = "night" } }
 | c:?Xl { ( c:sem = "milk" | c:sem = "I" | c:sem = "i" | c:sem = "you" | c:sem = "he" | c:sem = "she" | c:sem = "we" | c:sem = "they" )  }
 )
 )

// Repeats condition above
//¬ ( c:?Xl { c:lex = ?lexX } & lexicon.?lexX.definiteness.?n & ( ?n == "no" | ?n == no )  )

// if Xl pos is a verb that has been marked as a noun, then it will be a gerund (no definiteness)
¬ (?Xl.pos == "VB" & ?Xl.real_pos == "NN")

¬project_info.project.gen_type.T2T
  ]
  mixed = [
// see attr_def_lexicon_gov
¬ ( rc:?Vr { rc:lex = ?lexRR rc:?RR-> rc:?Xr { rc:<=> ?Xl } } & lexicon.?lexRR.gp.?RR.definiteness.?defRR )
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  // so the rule applies after another rule that introduces definiteness during this level
  rc:id = ?i
  ¬rc:finiteness = "FIN"
  ¬rc:case = "GEN"
  definiteness = "INDEF"
}

// replaces LS condition
¬ ( rc:?Xr { rc:?R-> rc:?Yr {} } & ( ?R == I | ?R == II | ?R == III ) )

// so rules that copies from conjunct above applies first
¬ rc:?GovR {
  rc:definiteness = ?cR
  rc:COORD-> rc:?CoorR {
    rc:pos = "CC"
    rc:II-> rc:?Xr {}
  }
}
  ]
]

/*A quick guess is if there is an argument, maybe the noun is more prone to be definite...*/
Sem<=>DSynt attr_def_default_DEF : transfer_attribute
[
  leftside = [
c:?Xl {
  ( c:pos = "NN" | c:real_pos = "NN" )
  ¬c:NE = "YES"
  ¬c:definiteness = ?def
}

// There is no definiteness in the lexicon foreseen by the governor; now in mixed to check right side governor
//¬ (c:?Node2L {c:lex = ?lex c:?r-> c:?Xl {}}
// & lexicon.?lex.gp.?r.?DSyntR & lexicon.?lex.gp.?DSyntR.definiteness)
 
//?Xl doesn't have a predefined definiteness (note that ?def can be "no")
¬ ( c:?Xl { c:lex = ?lexXl } & lexicon.?lexXl.definiteness.?def )
 
¬project_info.project.gen_type.T2T
  ]
  mixed = [
// see DE_attr_def_INDEF
¬ ( language.id.iso.DE & rc:?Xr { rc:<=> ?Xl ( rc:dlex = "Allergie" | rc:dlex = "Problem" ) } )
// see attr_def_lexicon_gov
¬ ( rc:?Vr { rc:lex = ?lexRR rc:?RR-> rc:?Xr { rc:<=> ?Xl } } & lexicon.?lexRR.gp.?RR.definiteness.?defRR )
// do not apply to measurable nouns that have an arg1 and that are arg2 of a verb (190510_WebNLG2_ES, str 105
¬ ( c:?Xl  { c:lex = ?lexXl } & lexicon.?lexXl.measurable.?m & ?m == "yes" & rc:?GovR { rc:II-> rc:?Xr { rc:<=> ?Xl rc:I-> rc:?DepR {} } } )
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  // so the rule applies after another rule that introduces definiteness during this level
  rc:id = ?i
  ¬rc:finiteness = "FIN"
  definiteness = "DEF"
}

( ( rc:?Xr { rc:?R-> rc:?Yr {} } & ( ?R == I | ?R == II | ?R == III ) )
  | rc:?Xr { rc:case = "GEN" }
)

// so rules that copies from conjunct above applies first
¬ rc:?GovR {
  rc:definiteness = ?cR
  rc:COORD-> rc:?CoorR {
    rc:pos = "CC"
    rc:II-> rc:?Xr {}
  }
}
  ]
]

/*If a node has antecedent, change its definiteness to DEF.
Should add that there's a coref between ?Antecedent and Xr, but condition is not allowed.*/
Sem<=>DSynt attr_def_change_relative : transfer_attribute
[
  leftside = [
c:?Xl {
  ( c:pos = "NN" | c:pos = "NP" )
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Antecedent {
  rc:<=> ?Xl
  rc:dlex = ?d
  rc:*?r-> rc:?Xr {
    rc:<=> ?Xl
    // BUG: gives -1 exception
    //  rc:<-> rc:?Antecedent {}
    rc:dlex = ?e
    rc:definiteness = "INDEF"
    rc:include = bubble_of_gov
    definiteness = "DEF"
  }
}

?d == ?e
  ]
]

Sem<=>DSynt attr_finiteness : transfer_attribute
[
  leftside = [
c:?Xl {
  finiteness = ?pv
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  finiteness = ?pv
}
  ]
]

/*Go get the finiteness of a verbal dependent in the gp of its DSynt governor.
!CAREFUL: so far there is no way to check that the pos and the finiteness belong to the same GP*/
Sem<=>DSynt attr_finiteness_lexicon_gov : transfer_attribute
[
  leftside = [
c:?Xl {}

// NOT NEEDED FOR MULTISENSOR (since the rule is slow, avoid it...)
// it should be fixed now, with the variables declared in the mixed field.
//¬ project_info.project.name.MULTISENSOR
// the information is not present in the EN dictionary for the moment, no need to go get it
¬ language.id.iso.EN
  ]
  mixed = [
//?lex1 == ?lex
//?pos1 == ?pos
// BUG!! doesnt get variables right! E.G. 160630_K-p1-system_FN_simul_PL.conll sentence 7
rc:?Yr { rc:lex = ?lex rc:?r-> rc:?Xr { rc:<=> ?Xl } }
( lexicon.?lex.gp.?r.pos.?pos & ?pos == "VB" )
lexicon.?lex.gp.?r.finiteness.?fin
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:pos = "VB"
  ¬rc:finiteness = ?f
  finiteness = ?fin
}
  ]
]

/*If a coordinated verbs doesn't have finiteness, copy the finiteness of the first one onto the second one.*/
Sem<=>DSynt attr_finiteness_COORD_copy : transfer_attribute
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:finiteness = ?f1
  rc:COORD-> rc:?And {
    rc:II-> rc:?Yr {
      ¬rc:finiteness = ?f2
      finiteness = ?f1
    }
  }
}
  ]
]

/*If two coordinated verbs don't have the same finiteness, copy the finiteness of teh forst one onto the second one.*/
Sem<=>DSynt attr_finiteness_COORD_replace : transfer_attribute
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:finiteness = ?f1
  rc:COORD-> rc:?And {
    rc:II-> rc:?Yr {
      rc:finiteness = ?f2
      finiteness = ?f1
    }
  }
}

¬ ?f1 == ?f2
  ]
]

Sem<=>DSynt attr_gender : transfer_attribute
[
  leftside = [
c:?Xl {
  gender = ?pos
}

¬ ( c:?Xl { c:slex = ?lex } & lexicon.?lex.gender.?gen )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:gender = ?f
  gender = ?pos
}
  ]
]

Sem<=>DSynt attr_gender_lexicon : transfer_attribute
[
  leftside = [
c:?Yl {
  c:lex = ?lex
}

lexicon.?lex.gender.?gen
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  gender = ?gen
}
  ]
]

Sem<=>DSynt attr_GovLex : transfer_attribute
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
  // ?Xr is not a duplication of a Sem node (see node_dep_NOarg_rules)
  ¬rc:include = bubble_of_gov
  GovLex = ?tc
}
  ]
]

Sem<=>DSynt attr_has3rdArg : transfer_attribute
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
  // ?Xr is not a duplication of a Sem node (see node_dep_NOarg_rules)
  ¬rc:include = bubble_of_gov
}
  ]
]

Sem<=>DSynt attr_id : transfer_attribute
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
  ¬rc:id = ?l
  id = ?lex
}
  ]
]

Sem<=>DSynt attr_id0 : transfer_attribute
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
  ¬rc:id0 = ?l
  id0 = ?i
}
  ]
]

/*added lemmas 171720 because needed for some rules in DSynt-SSynt.
Find it weird that lemmas were not in the structure before.*/
Sem<=>DSynt attr_lemma : transfer_attribute
[
  leftside = [
c:?Xl{}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:dlex = ?d
  lemma = ?d
}
  ]
]

Sem<=>DSynt attr_lex : transfer_attribute
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
  ¬rc:lex = ?l
  lex = ?lex
}
  ]
]

Sem<=>DSynt attr_modality : transfer_attribute
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
  rc:pos = "VB"
  modality = ?t
}
  ]
]

Sem<=>DSynt attr_modality_type : transfer_attribute
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
  rc:pos = "VB"
  modality_type = ?t
}
  ]
]

Sem<=>DSynt attr_mood_default : transfer_attribute
[
  leftside = [
c:?Xl {
  c:pos = "VB"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:pos = "VB"
  rc:finiteness = "FIN"
  ¬rc:mood = ?t
  mood = "IND"
}
  ]
]

Sem<=>DSynt attr_NE : transfer_attribute
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
  ¬rc:NE = ?class
  NE = ?NE
}
  ]
]

/*Doesn't work*/
excluded Sem<=>DSynt attr_NE_coref : transfer_attribute
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
  rc:NE = ?NE
}

rc:?Br {
  rc:?Xr {}
  rc:?Yr {
    rc:<-> rc:?Xr { rc:<=> ?Xl }
    NE = ?NE
  }
}
  ]
]

Sem<=>DSynt attr_number : transfer_attribute
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
  ¬rc:pos = "VB"
  number = ?num
}
  ]
]

Sem<=>DSynt attr_number_lexicon : transfer_attribute
[
  leftside = [
c:?Yl {
  c:lex = ?lex
}

lexicon.?lex.number.?num
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:pos = "VB"
  number = ?num
}
  ]
]

/*If a determiner has a number specified in the lexicon, it imposes it to its governing noun.*/
Sem<=>DSynt attr_number_lexicon_dependent : transfer_attribute
[
  leftside = [
c:?Yl {}
  ]
  mixed = [
rc:?Yr { rc:<=> ?Yl rc:ATTR-> rc:?Det { rc:lex = ?lex } }

lexicon.?lex.number.?num
  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:pos = "VB"
  number = ?num
  rc:ATTR-> rc:?Det {}
}
  ]
]

Sem<=>DSynt attr_number_cardinality : transfer_attribute
[
  leftside = [
c:?Xl {
  c:pos = "NN"
   ¬c:number = ?n
  cardinality = ?c
}

¬ ( c:?Xl { c:lex = ?lex } & lexicon.?lex.number.?num )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:pos = "VB"
  number = ?c
}
  ]
]

Sem<=>DSynt attr_number_CD : transfer_attribute
[
  leftside = [
c:?Xl {
  // in some cases a noun arrives here tagged as ADV ("times" as frequency)
  ( c:pos = "NN" | c:pos = "RB" )
}

//see PL rule
¬ language.id.iso.PL
  ]
  mixed = [
¬ ( rc:?Xr { rc:<=> ?Xl rc:lex = ?lex } & lexicon.?lex.number.?num & ?num == "SG" )
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:pos = "VB"
  number = "PL"
  rc:ATTR-> rc:?CD {
    ( rc:number = "PL" | rc:dlex = "multiple" | rc:dlex = "various" | rc:dlex = "several"
      | rc:dlex = "many" | rc:dlex = "few"
      | ( rc:pos = "CD" & ( ¬ ( rc:dlex = "0" | rc:dlex = "1" ) | rc:COORD-> rc:?CO {} ) ) )
  }
}

¬ ( ?CD.pos == "CD" & rc:?Xr { rc:lex = "Mal_NN_01" } )
  ]
]

/*Changes the number of a noun that is the complement of a copula.
*/
SSynt<=>SSynt EN_attr_number_PRD : transfer_attribute
[
  leftside = [
//c:?Tl {
//  c:sem = "Sentence"
  c:?Xl {
    c:pos = "NN"
    ¬c:number = "PL"
  }
//}

language.id.iso.EN

//The next condition aims at reducing the amount of LS matches.
// It covers cases of copula present in the SemStr and of copula and introduced as a Lexical Function
( ( c:?Xl { c:lex = ?lex c:?r-> c:?Yl {} } & lexicon.?lex.gp.?r.I ) 
 | c:?Vl { c:sem = "be" c:A2-> c:?Xl {} }
)
  ]
  mixed = [

  ]
  rightside = [
//rc:?Tr {
//  rc:<=> ?Tl
//  rc:dlex = "Sentence"
  rc:?Xr {
    rc:<=> ?Xl
    //so only applies to the noun in case of support verb
    rc:pos = "NN"
    // so the rule applies after the other rules that introduce number; safer this way.
    rc:number = ?numberX
    ¬rc:top = "yes"
  }
  rc:?CopulaR {
    ( rc:dlex = "be" | rc:dlex = "become" | rc:dlex = "remain" | rc:dlex = "seem" )
    rc:I-> rc:?SubjR {
      ( rc:number = "PL" | rc:COORD-> rc:?ConjR { rc:dlex = "and" } )
    }
    rc:II-> rc:?Xr {
      //rc:<=> ?Xl
      ¬rc:number = "PL"
      number = "PL"
    }
  }
//}

// When the meaning of ?Xr contains the notion of plural, no need to pluralize
¬ ( rc:?Xr { ( rc:dlex = "group" | rc:dlex = "ethnic_group" ) } & rc:?SubjR { ¬rc:COORD-> rc:?DepR {} } )
  ]
]

Sem<=>DSynt PL_attr_number_CD : transfer_attribute
[
  leftside = [
c:?Xl {
  c:pos = "NN"
}

language.id.iso.PL
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  number = "PL"
  rc:?r-> rc:?CD {
    ( rc:number = "PL" | ( rc:pos = "CD" & ( ¬ ( rc:dlex = "0" | rc:dlex = "1" ) | rc:COORD-> rc:?CO {} ) ) )
  }
}

( ?r == ATTR | ?r == I | ?r == II )
  ]
]

Sem<=>DSynt attr_number_default : transfer_attribute
[
  leftside = [
c:?Xl {
  c:pos = "NN"
  c:lex = ?lex
  ¬c:number = ?num1
}

¬lexicon.?lex.number.?num
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  // spos so rule applies after EN_attr_number_PRD; changed back, now applying this rule before
  rc:pos = "NN"
  ¬rc:number = ?t
  number = "SG"
// see number_CD
  ¬ rc:ATTR-> rc:?CD {
    ( rc:number = "PL" | rc:dlex = "multiple" | rc:dlex = "various" | rc:dlex = "several"
      | rc:dlex = "many" | rc:dlex = "few"
      | ( rc:pos = "CD" & ( ¬ ( rc:dlex = "0" | rc:dlex = "1" ) | rc:COORD-> rc:?CO {} ) ) )
  }
}
  ]
]

Sem<=>DSynt attr_pos : transfer_attribute
[
  leftside = [
c:?Xl {
  pos = ?pos
}

// see transfer_node_dep_NOarg_possessive
¬(c:?Xl {
    ¬c:main_rheme = "yes"
    c:sem = "possess" 
    c:type = "added"
    c:A0-> c:?Node {}
    c:A1-> c:?OtherNode {}
  }
)

¬(c:?Xl {
    ¬c:main_rheme = "yes"
    c:sem = "possess" 
    c:type = "added"
    c:A1-> c:?Node2 {}
    c:A2-> c:?OtherNode2 {}
  }
)
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:pos = ?f
  pos = ?pos
}
  ]
]

Sem<=>DSynt attr_pos_default : transfer_attribute
[
  leftside = [
c:?Xl {
  ¬c:sem="Sentence"
  ¬c:pos = ?pos
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  // so rule applies after pos marking rules
  rc:lex = ?lex
  ¬rc:pos = ?f
  pos = "UNK"
}
  ]
]

Sem<=>DSynt attr_pos_real : transfer_attribute
[
  leftside = [
c:?Xl {
  real_pos = ?pos
}

// see transfer_node_dep_NOarg_possessive
¬(c:?Xl {
    ¬c:main_rheme = "yes"
    c:sem = "possess" 
    c:type = "added"
    c:A0-> c:?Node {}
    c:A1-> c:?OtherNode {}
  }
)
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:real_pos = ?f
  real_pos = ?pos
}
  ]
]

Sem<=>DSynt attr_predV : transfer_attribute
[
  leftside = [
c:?Xl {
  ¬c:sem="Sentence"
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

Sem<=>DSynt attr_sameLoc : transfer_attribute
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
}
  ]
]

Sem<=>DSynt attr_SameLoc_percolate : transfer_attribute
[
  leftside = [
c:?Locl {
  c:SameLocAsPrevious = "YES"
  c:A2-> c:?Xl {
    c:SameLocAsPrevious = "YES"
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?GovR {
  rc:meaning = "locative_relation"
  SameLocAsPrevious = "YES"
  rc:II-> rc:?Xr {
    rc:<=> ?Xl
    rc:SameLocAsPrevious = "YES"
  }
}
  ]
]

Sem<=>DSynt attr_sameTime : transfer_attribute
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
}
  ]
]

Sem<=>DSynt attr_SameTime_percolate : transfer_attribute
[
  leftside = [
c:?Locl {
  c:SameTimeAsPrevious = "YES"
  c:A2-> c:?Xl {
    c:SameTimeAsPrevious = "YES"
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?GovR {
  rc:meaning = "time_relation"
  SameTimeAsPrevious = "YES"
  rc:II-> rc:?Xr {
    rc:<=> ?Xl
    rc:SameTimeAsPrevious = "YES"
  }
}
  ]
]

Sem<=>DSynt attr_spos : transfer_attribute
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:pos = ?f
  spos = ?f
}

¬?f == "VB"
  ]
]

/*Doesn't seem to work.*/
excluded Sem<=>DSynt attr_spos_newNode : transfer_attribute
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?NewNode {
  rc:<-> rc:?Xr {
    rc:<=> ?Xl
  }
  rc:pos = ?f
  spos = ?f
}

¬?f == "VB"
  ]
]

/*PATCH: in order to math the training date for stat gen*/
Sem<=>DSynt EN_attr_spos_VV : transfer_attribute
[
  leftside = [
c:?Xl {}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:pos = "VB"
  spos = "VV"
}
  ]
]

Sem<=>DSynt attr_subcat_prep : transfer_attribute
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
  // ?Xr is not a duplication of a Sem node (see node_dep_NOarg_rules)
  ¬rc:include = bubble_of_gov
  subcat_prep = ?tc
}

// ?Xr is not a duplicated node in a relative clause
//¬ ( rc:?Antecedent {
//  rc:<=> ?Xl
//  rc:dlex = ?d
//  rc:*?r-> rc:?Xr {
//    rc:<=> ?Xl
//    rc:dlex = ?e
//    }
//  }
//  & ?d == ?e
//)
  ]
]

/*Copies info about subcat prep onto a new nodes on the RS ( the duplicated noun when a relative is created).
As in 190709_WebNLG_eval_ALL_en.conll, sentence 6 (english)*/
Sem<=>DSynt attr_subcat_prep_new1 : transfer_attribute
[
  leftside = [
c:?Govl {
  c:lex = ?lex
  c:?a = ?prep
  c:?r-> c:?Xl {}
}

// Used to mark ill-used arguments
¬?prep == "wrong"

?r == ?a

lexicon.?lex.gp.?r.?DSyntR

( c:?Xl { ¬c:subcat_prep = ?prep } | c:?Xl { c:subcat_prep = ?prep2 ¬c:govLex = ?lex } )

¬ ?Xl.lex == "riverside_NP_01"
  ]
  mixed = [

  ]
  rightside = [
rc:?GovR {
  rc:<=> ?Govl
  rc:?REL-> rc:?Xr {
    rc:lex = ?lexXr
    subcat_prep = ?prep
    GovLex = ?lex
  }
}

?REL == ?DSyntR

// so attribute is not copied on original correspondent to ?Xl in case of hypernode
¬ ?lexXr == ?lex
  ]
]

Sem<=>DSynt attr_tc : transfer_attribute
[
  leftside = [
c:?Xl {
  tem_constituency = ?tc
}

¬?tc == "IMM"
  ]
  mixed = [
¬ ( rc:?Yr { rc:lex = ?lex rc:?r-> rc:?Xr {rc:<=> ?Xl} } & lexicon.?lex.gp.?r.tem_constituency.?tclex )
//Do not transfer PERF if verb is participial modifier on the right.
//BUG: MATE doesn't identify the rc:<=> when both are activated, for some reason, so the rule doesn't apply.
//PATCH: use IDs instead of one of the LS correspondences
¬ ( c:?Xl { c:tem_constituency = "PERF" c:?r-> c:?Ax { c:id = ?idA } } & rc:?Ar { rc:id = ?idA rc:ATTR-> rc:?Xr { rc:<=> ?Xl rc:finiteness = "PART" } } )
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ( rc:pos = "VB" | rc:pos = "MD" )
  tem_constituency = ?tc
}
  ]
]

/*modality IMM is not implemented; quite different from the other temporal constituencies.
(is going to...)
Edit: change IMM by PROGR, since it seems like I leave the "go" in the semantic structure*/
Sem<=>DSynt attr_tc_modality : transfer_attribute
[
  leftside = [
c:?Xl {
  tem_constituency = "IMM"
  //¬c:modality = ?mod
}
  ]
  mixed = [
¬ ( rc:?Yr { rc:lex = ?lex rc:?r-> rc:?Xr {rc:<=> ?Xl} } & lexicon.?lex.gp.?r.tem_constituency.?tclex )
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ( rc:pos = "VB" | rc:pos = "MD" )
  //modality = "IMM"
  //modality_type = "??"
  tem_constituency = "PROGR"
}
  ]
]

/*this rule is very slow with ENGLISH! maybe because RS check to lexicon!*/
Sem<=>DSynt attr_tc_lexicon : transfer_attribute
[
  leftside = [
c:?Yl {}

// NOT NEEDED FOR MULTISENSOR (since the rule is slow, avoid it...)
// it should be fixed now, with the variables declared in the mixed field.
//¬ project_info.project.name.MULTISENSOR
// the information is not present in the EN dictionary for the moment, no need to go get it
¬ language.id.iso.EN
  ]
  mixed = [
rc:?Xr { rc:lex = ?lex rc:?r-> rc:?Yr {rc:<=> ?Yl} }
lexicon.?lex.gp.?r.tem_constituency.?tc
  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ( rc:pos = "VB" | rc:pos = "MD" )
  tem_constituency = ?tc
}
  ]
]

/*Remove PERF if verb is participial modifier on the right.
BUG: MATE doesn't identify the rc:<=> when both are activated, for some reason, so the rule doesn't apply.
PATCH: use IDs instead of one of the LS correspondences.*/
excluded Sem<=>DSynt attr_tc_PERF_block : transfer_attribute
[
  leftside = [
c:?Xl {
  c:tem_constituency = "PERF"
  c:?r-> c:?Ax {
    c:id = ?idA
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Ar {
  //rc:<=> ?Ax
  rc:id = ?idA
  rc:ATTR-> rc:?Xr {
    rc:<=> ?Xl
    rc:finiteness = "PART"
    rc:tem_constituency = ?t
    tem_constituency = "no"
  }
}
  ]
]

Sem<=>DSynt attr_tense : transfer_attribute
[
  leftside = [
c:?Xl {
  tense = ?t
}
  ]
  mixed = [
¬ ( rc:?Yr { rc:lex = ?lex rc:?r-> rc:?Xr {rc:<=> ?Xl} } & lexicon.?lex.gp.?r.tense.?tense )
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ( rc:pos = "VB" | rc:pos = "MD" )
  tense = ?t
}
  ]
]

Sem<=>DSynt attr_tense_default : transfer_attribute
[
  leftside = [
c:?Xl {
  ¬c:tense = ?t
  c:pos = "VB"
}
  ]
  mixed = [
¬ ( rc:?Yr { rc:lex = ?lex rc:?r-> rc:?Xr {rc:<=> ?Xl} } & lexicon.?lex.gp.?r.tense.?tense )
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ( rc:pos = "VB" | rc:pos = "MD" )
  rc:finiteness = "FIN"
  ¬rc:tense = ?t
  tense = "PRES"
}
  ]
]

/*this rule is very slow with ENGLISH! maybe because RS check to lexicon!*/
Sem<=>DSynt attr_tense_lexicon : transfer_attribute
[
  leftside = [
c:?Yl {}

// NOT NEEDED FOR MULTISENSOR (since the rule is slow, avoid it...)
// it should be fixed now, with the variables declared in the mixed field.
//¬ project_info.project.name.MULTISENSOR
// the information is not present in the EN dictionary for the moment, no need to go get it
¬ language.id.iso.EN
  ]
  mixed = [
rc:?Xr { rc:lex = ?lex rc:?r-> rc:?Yr {rc:<=> ?Yl} }
lexicon.?lex.gp.?r.tense.?tense
  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ( rc:pos = "VB" | rc:pos = "MD" )
  tense = ?tense
}
  ]
]

Sem<=>DSynt attr_type : transfer_attribute
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
  // ?Xr is not a duplication of a Sem node (see node_dep_NOarg_rules)
  ¬rc:include = bubble_of_gov
  type = ?t
}
  ]
]

Sem<=>DSynt attr_variable_class : transfer_attribute
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

Sem<=>DSynt attr_vncls : transfer_attribute
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

Sem<=>DSynt attr_voice : transfer_attribute
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
}
  ]
]

Sem<=>DSynt attr_voice_PASS_no_I : transfer_attribute
[
  leftside = [
c:?Xl {
  ¬c:voice = ?t
  ¬c:sem = "be"
  c:pos = "VB"
  c:lex = ?lex
  c:?r-> c:?Dep {}
}

¬?Xl.type == "impersonal"
  ]
  mixed = [
//the verb has its second argument but no first argument
( lexicon.?lex.gp.?r.II & ¬ (c:?Xl { c:?s-> c:?otherDep {} } & lexicon.?lex.gp.?s.I ) | ¬rc:?Xr { rc:<=> ?Xl rc:I-> rc:?DepXr {} } )
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:finiteness = "FIN"
  // in order to force the rule to apply after default rule
  rc:voice = "ACT"
  ( rc:I-> rc:?Dep1R {} | rc:II-> rc:?Dep2R {} )
  voice = "PASS"
}
  ]
]

/*If a verb is not in the lexicon, go for the passive anyway, seems like a better choice (?)
If a verb is not in the lexicon, it can only have A1 (no A0) for now.*/
Sem<=>DSynt attr_voice_PASS_no_I_NOlexicon : transfer_attribute
[
  leftside = [
c:?Xl {
  ¬c:voice = ?t
  ¬c:sem = "be"
  c:pos = "VB"
  c:lex = ?lex
  c:A2-> c:?Dep {}
  ¬c:A1-> c:?Dep2 {}
}

//the verb has no mapping in the lexicon
¬ ( c:?Xl { c:lex = ?lex2 } & lexicon.?lex2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:finiteness = "FIN"
  // in order to force the rule to apply after default rule
  rc:voice = "ACT"
  ( rc:I-> rc:?Dep1R {} | rc:II-> rc:?Dep2R {} )
  voice = "PASS"
}
  ]
]

/*If the second argument is marked as theme, introduce passive voice*/
Sem<=>DSynt attr_voice_PASS_theme : transfer_attribute
[
  leftside = [
c:?Xl {
  c:?r-> c:?Dep1 {}
  c:?s-> c:?Dep2 {
    main_theme = "yes"
  }
}

¬?Xl.type == "impersonal"

// If the verb is not transitive, do not create a passive.
¬ ( c:?Xl { c:lex = ?lex } & lexicon.?lex.transitive.no )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:finiteness = "FIN"
  // in order to force the rule to apply after default rule
  rc:voice = "ACT"
  voice = "PASS"
  rc:I-> rc:?Dep1R {
    rc:<=> ?Dep1
  }
  rc:II-> rc:?Dep2R {
    rc:<=> ?Dep2
  }
}
  ]
]

/*For greek; some verbs are only passive.
Looks like we were mixing voice and endings, disabled now.*/
excluded Sem<=>DSynt EL_attr_voice_PASS_lexicon : transfer_attribute
[
  leftside = [
c:?Yl {}

language.id.iso.EL
  ]
  mixed = [
rc:?Yr { rc:<=> ?Yl rc:lex = ?lex }
lexicon.?lex.voice.?v
  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ( rc:pos = "VB" | rc:pos = "MD" )
  voice = ?v
}
  ]
]

/*This rule must apply after cluster 2, when voice = PASS is inserted.
That's why bubble. Obviously doesn't work for embedded verbs -_-*/
Sem<=>DSynt attr_voice_default : transfer_attribute
[
  leftside = [
c:?Bubble{
  c:?Xl {
    //c:pos = "VB"
  }
}

//¬ ( c:?Xl {
//       c:lex = ?lex
//       c:?r-> c:?Dep { }
//       c:?s-> c:?otherDep { }
//     }
// & lexicon.?lex.gp.?r.II
// & ¬lexicon.?lex.gp.?s.I
//)
  ]
  mixed = [
¬ ( rc:?Xr { rc:<=> ?Xl rc:lex = ?lex } & lexicon.?lex.voice.?v )
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:pos = "VB"
  rc:finiteness = "FIN"
  ¬rc:voice = ?t
   voice = "ACT"
}

//rc:?BubbleR {
//  rc:<=> ?Bubble
//  rc:dlex = "Sentence"
//  rc:?Xr {}  
//}
  ]
]

Sem<=>DSynt attr_disabled : transfer_attribute
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>DSynt rel_parataxis : transfer_relations
[
  leftside = [
c:?Xl {
  Parataxis-> c: ?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:middle = "yes"
  ¬rc:bottom = "yes"
  Parataxis-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:middle = "yes"
    ¬rc:bottom = "yes"
  }
}
  ]
]

Sem<=>DSynt rel_bubbles : transfer_relations
[
  leftside = [
c:?Xl {
  c:sem = "Sentence"
  ?r-> c: ?Yl {
    c:sem = "Sentence"
  }
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

Sem<=>DSynt rel_precedence : transfer_relations
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

/*For the buggy conditions: see 190709_WebNLG_eval_ALL_en.conll Sentence 24*/
Sem<=>DSynt rel_coref : transfer_relations
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
// ?Xr doesn't already have a coref with another node
// BUG: gives -1 exception
//  ¬rc:<-> rc:?Ante {}
  // ?Xr is not a duplication of a Sem node (see node_dep_NOarg_rules)
  ¬rc:include = bubble_of_gov
  <-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:top = "yes"
    ¬rc:include = bubble_of_gov
  }
}


//BUG: Following conoditions don't work for some reason...
// Added a mark on the duplicatd nodes on the RS instead.
// ?Xr is not a duplicated node in a relative clause
//¬ ( rc:?Antecedent1 {
//  rc:<=> ?Xl
//  rc:dlex = ?d1
//  rc:*?r-> rc:?Xr {
//    rc:<=> ?Xl
//    rc:dlex = ?e1
//    }
//  }
//  & ?d1 == ?e1
//)

// ?Yr neither
//¬ ( rc:?Antecedent2 {
//  rc:<=> ?Yl
//  rc:dlex = ?d2
//  rc:*?s-> rc:?Yr {
//    rc:<=> ?Yl
//    rc:dlex = ?e2
//    }
//  }
//  & ?d2 == ?e2
//)
  ]
]

excluded Sem<=>DSynt PATCH_thematicity_propagate : disabled
[
  leftside = [
c:?Xl {}
  ]
  mixed = [
¬ (?Xl.main_rheme == "yes" & ?r == I )
  ]
  rightside = [
rc:?Yr {
  rc:thematicity = ?th
  rc:?r-> rc:?Xr {
    rc:<=> ?Xl
    thematicity = ?th
  }
}
  ]
]

/*For newly introduced nodes*/
excluded Sem<=>DSynt PATCH_thematicity_propagate_newNode : disabled
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:thematicity = ?th
  rc:?r-> rc:?Yr {
    rc:include = ?i
    thematicity = ?th
  }
}
  ]
]

excluded Sem<=>DSynt PATCH_mark_theme : disabled
[
  leftside = [
c:?Xl {
  c:main_rheme = "yes"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:I-> rc:?Yr {
    thematicity = "theme"
  }
}
  ]
]

/*We need to check if coreferring nodes have identical subtrees or not in order to perform pronominalization in the next step.
This rule marks marks the coreferring node if a difference is found between its children and those of the antecedent.

We check only dependents on the coreferring node, not on the antecedent, since these dependents are the ones that will allow for pronominalization or not.
If we pronomonalize a coreferring node with a subtree not found on the antecedent, this subtree would be lost through pronominalization.
The antecedent can have other dependents (thanks to the aggregation), but these will not be lost since the antecedent is not pronominalized.*/
Sem<=>DSynt mark_coref_nodes_dependents_child : mark
[
  leftside = [
c:?S1l {
  c:?Antel {}
  c:*?r-> c:?S2l {
    c:?Corefl {
      c:<-> c:?Antel {}
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?S1r {
  rc:<=> ?S1l
  rc:?Anter {
    rc:<=> ?Antel
    ¬rc:include = bubble_of_gov
  }
}

rc:?S2r {
  rc:<=> ?S2l
  rc:?Corefr {
    rc:<=> ?Corefl
    rc:?R2-> rc:?DepR2 {
      rc:dlex = ?dR2
    }
    subtree_coref = "different"
  }
}

¬ ( rc:?Anter { rc:<=> ?Antel rc:?R1-> rc:?DepR1 { rc:dlex = ?dR1} } & ?R1 == ?R2 & ?dR1 == ?dR2 )
  ]
]

/*We need to check if coreferring nodes have identical subtrees or not in order to perform pronominalization in the next step.
This rule marks marks the coreferring node if a difference is found between its grandchildren and those of the antecedent.

We check only dependents on the coreferring node, not on the antecedent, since these dependents are the ones that will allow for pronominalization or not.
If we pronomonalize a coreferring node with a subtree not found on the antecedent, this subtree would be lost through pronominalization.
The antecedent can have other dependents (thanks to the aggregation), but these will not be lost since the antecedent is not pronominalized.*/
Sem<=>DSynt mark_coref_nodes_dependents_grandchild : mark
[
  leftside = [
c:?S1l {
  c:?Antel {}
  c:*?r-> c:?S2l {
    c:?Corefl {
      c:<-> c:?Antel {}
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
// !!! RULE NOT TESTED!
rc:?S1r {
  rc:<=> ?S1l
  rc:?Anter {
    rc:<=> ?Antel
    ¬rc:include = bubble_of_gov
    rc:?R1-> rc:?DepR1 {
      rc:dlex = ?dR1
    }
  }
}

rc:?S2r {
  rc:<=> ?S2l
  rc:?Corefr {
    rc:<=> ?Corefl
    rc:?R2-> rc:?DepR2 {
      rc:dlex = ?dR2
        rc:?S2-> rc:?DepS2 {
          rc:dlex = ?dS2
        }
    }
    subtree_coref = "different"
  }
}

// It's a bit simplistic, since a node can have several dependents with the same dlex and dependency. Will work for now.
?R1 == ?R2
?dR1 == ?dR2

¬ ( rc:?DepR1 { rc:?S1-> rc:?DepS1 { rc:dlex = ?dS1} } & ?S1 == ?S2 & ?dS1 == ?dS2 )
  ]
]

/*Some nodes can be blocked during level 17, and because of lack of RS correspondence between some nodes in this level, the "blocked"
  attribute does not pass on to th enext leve. (it's expensive to not transfer a blocked node in this level due to the large amount of rules that build new nodes).*/
Sem<=>DSynt mark_blocked_percolate_from_previous : mark
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Semr {
  rc:meaning = ?m
  blocked = "YES"
  rc:II-> rc:?Xr {
    rc:<=> ?Xl
    rc:blocked = "YES"
  }
}
  ]
]

Sem<=>DSynt node_ROOT_fallback : transfer_node_ROOT
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr{
  rc: <=> ?Xl
  // so rule applies in third cluster. see tranfer_attr_bubble
  rc:bubble="yes"
  ¬rc:?Node{}
  ?NewNode {
    //dlex = "The_system_is_sorry_to_inform_you_that_it_was_unable_to_process_the_summary."
    dlex = "[.....]"
  }
}
  ]
]

Sem<=>DSynt node_ROOT_V : transfer_node_ROOT
[
  leftside = [
?Xl {
  sem = ?d
  c:predValue = ?pv
  main_rheme = "yes"
  pos = "VB"
}

// kind of patch, could be better not to apply SemComm to negations...
//( ?Xl.main_rheme = "yes"
// | ( c:?Yl { c:lex = ?lex c:A1-> ?Xl {} } & lexicon.?lex.negation.yes )
//)
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  main = yes
  pos = "VB"
  finiteness = "FIN"
  thematicity = "rheme"
  //lex = #?d+_VB_+?pv#
  //lex = ?Xl.lex
  //main = ?Xl.main
  //meaning = ?Xl.meaning
  //number = ?Xl.number
  //pbr = ?Xl.pbr
  //predicate = ?Xl.predicate
  //predName = ?Xl.predName
  //predValue = ?Xl.predValue
  dlex = ?d
  //tem_constituency = ?Xl.tem_constituency
  //tense = ?Xl.tense
  //type = ?Xl.type
  //vncls = ?Xl.vncls
}
  ]
]

Sem<=>DSynt node_ROOT_N : transfer_node_ROOT
[
  leftside = [
?Xl {
  sem = ?d
  c:predValue = ?pv
  main_rheme = "yes"
}

( ?Xl { ( pos = "NN" | pos = "NNP" ) }
// covers Root_Oper_IN with no argument
 | ?Xl {¬pos = "VB" ¬A1-> ?Yl {} }
)

// see rule Oper1 lexicon
( ¬ ( ?Xl { c:lex = ?lex1 c:?r1-> c:?Dep1 {} }
  &  lexicon.?lex1.gp.?r1.I
 // & lexicon.?lex.Oper1.?sv
)
 | ?Xl.clause_type == "PHRAS" ) 

// see rule Oper2 lexicon
( ¬ ( ?Xl { c:lex = ?lex2 c:?r2-> c:?Dep2 {} }
  &  lexicon.?lex2.gp.?r2.II
  & lexicon.?lex2.Oper2.?sv
)
 | ?Xl.clause_type == "PHRAS" ) 

// see rule Oper1noA1 lexicon; only if there is a prep for now (V4Design tests P3, 200410_V4Design-test_demo.conll first sentence)
 ( ¬ ( ?Xl { c:lex = ?lex3 c:?r3-> c:?Dep3 {} }
  &  lexicon.?lex3.gp.?r3.II
   & ( lexicon.?lex3.gp.II.prep.?p3 | lexicon.?lex3.gp.II.case.?c3 )
   & lexicon.?lex3.Oper1.?sv3
   & ¬ (c:?Xl { c:?r33-> c:?Dep33 {} } & lexicon.?lex3.gp.?r33.I )
) 
 | ?Xl.clause_type == "PHRAS" )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  main = yes
  pos = ?Xl.pos
  //definiteness = "INDEF"
  thematicity = "rheme"
  //lex = #?d+_VB_+?pv#
  //lex = ?Xl.lex
  //main = ?Xl.main
  //meaning = ?Xl.meaning
  //number = ?Xl.number
  //pbr = ?Xl.pbr
  //predicate = ?Xl.predicate
  //predName = ?Xl.predName
  //predValue = ?Xl.predValue
  dlex = ?d
  //tem_constituency = ?Xl.tem_constituency
  //tense = ?Xl.tense
  //type = ?Xl.type
  //vncls = ?Xl.vncls
}
  ]
]

Sem<=>DSynt node_ROOT_Oper1_lexicon : transfer_node_ROOT
[
  leftside = [
?Xl {
  sem = ?d1
  c:lex = ?lex
  main_rheme = "yes"
  ¬c:clause_type = "PHRAS"
  ?r-> ?Yl {
    sem = ?d2
  }
}

lexicon.?lex.gp.?r.I
lexicon.?lex.Oper1.?lexOper
lexicon.?lexOper.lemma.?lemma
lexicon.?lexOper.spos.?spos

// Priority of Oper2 over Oper1 (arbitrary)
//¬ ( c:?Xl { c:?s2-> c:?Y2l {} } & lexicon.?lex.gp.?s2.II & lexicon.?lex.Oper2.?lexOper2 )

// The dependent is not a cordinating conjunction
¬ ( ?Yl { c:pos = "CC" c:?a1-> c:?Conjunct {} } & (?a1 == "A1" | ?a1 == A1 ) )

// There is no other candidate A1 (PTB_28872)
¬ ( ?Yl { id = ?idyl } & ?Xl { ?s-> ?Zl {id = ?idzl } } & ?r == ?s & ?idzl < ?idyl )
  ]
  mixed = [

  ]
  rightside = [
?Oper1 {
  <=> ?Xl
  main = yes
  pos = "VB"
  spos = ?spos
  finiteness = "FIN"
  dlex = ?lemma
  lex = ?lexOper
  clause_type = ?Xl.clause_type
  include = bubble_of_dep
  top = "yes"
  id = #randInt()#
  type = "support_verb_noIN"
  II-> ?Xr {
    <=> ?Xl
    dlex = ?d1
    bottom = "yes"
  }
  I-> ?Yr {
    <=> ?Yl
    dlex = ?d2
  }
}
  ]
]

Sem<=>DSynt node_ROOT_Oper1_lexicon_COORD : transfer_node_ROOT
[
  leftside = [
?Xl {
  sem = ?d1
  c:lex = ?lex
  main_rheme = "yes"
  ¬c:clause_type = "PHRAS"
  ?r-> c:?Yl {}
}

lexicon.?lex.gp.?r.I
lexicon.?lex.Oper1.?lexOper
lexicon.?lexOper.lemma.?lemma
lexicon.?lexOper.spos.?spos

// Priority of Oper2 over Oper1 (arbitrary)
¬ ( c:?Xl { c:?s2-> c:?Y2l {} } & lexicon.?lex.gp.?s2.II & lexicon.?lex.Oper2.?lexOper2 )

// The dependent is  a cordinating conjunction
c:?Yl { c:pos = "CC" c:?a1-> ?Conjunct { c:sem = ?d2 } }
 ( ?a1 == "A1" | ?a1 == A1 )

// There is no other candidate A1
¬ ( ?Yl { id = ?idyl } & ?Xl { ?s-> ?Zl {id = ?idzl } } & ?r == ?s & ?idzl < ?idyl )
  ]
  mixed = [

  ]
  rightside = [
?Oper1 {
  <=> ?Xl
  main = yes
  pos = "VB"
  spos = ?spos
  finiteness = "FIN"
  dlex = ?lemma
  lex = ?lexOper
  clause_type = ?Xl.clause_type
  include = bubble_of_dep
  top = "yes"
  id = #randInt()#
  type = "support_verb_noIN"
  II-> ?Xr {
    <=> ?Xl
    dlex = ?d1
    bottom = "yes"
  }
  I-> ?Yr {
    <=> ?Conjunct
    dlex = ?d2
  }
}
  ]
]

Sem<=>DSynt node_ROOT_Oper1_default : transfer_node_ROOT
[
  leftside = [
?Xl {
  sem = ?d1
  c:lex = ?lex
  c:pos = "NN"
  main_rheme = "yes"
  ¬c:clause_type = "PHRAS"
  ?r-> ?Yl {
    sem = ?d2
  }
}

//language.id.iso.ES

lexicon.?lex.gp.?r.I
¬ lexicon.?lex.Oper1.?lexOper0
lexicon.miscellaneous.support_verb.Oper1.?lexOper
lexicon.?lexOper.lemma.?lemma

// Priority of Oper2 over Oper1 (arbitrary)
¬ ( c:?Xl { c:?s2-> c:?Y2l {} } & lexicon.?lex.gp.?s2.II & lexicon.?lex.Oper2.?lexOper2 )

// The dependent is not a cordinating conjunction
¬ ( ?Yl { c:pos = "CC" c:?a1-> c:?Conjunct {} } & (?a1 == "A1" | ?a1 == A1 ) )

// There is no other candidate A1 (PTB_28872)
¬ ( ?Yl { id = ?idyl } & ?Xl { ?s-> ?Zl {id = ?idzl } } & ?r == ?s & ?idzl < ?idyl )
  ]
  mixed = [

  ]
  rightside = [
?Oper1 {
  <=> ?Xl
  main = yes
  pos = "VB"
  spos = "VV"
  //spos = "copula"
  finiteness = "FIN"
  dlex = ?lemma
  lex = ?lexOper
  clause_type = ?Xl.clause_type
  include = bubble_of_dep
  top = "yes"
  id = #randInt()#
  type = "support_verb_noIN"
  II-> ?Xr {
    <=> ?Xl
    dlex = ?d1
    bottom = "yes"
  }
  I-> ?Yr {
    <=> ?Yl
    dlex = ?d2
  }
}
  ]
]

Sem<=>DSynt node_ROOT_Oper1_default_COORD : transfer_node_ROOT
[
  leftside = [
?Xl {
  sem = ?d1
  c:lex = ?lex
  c:pos = "NN"
  main_rheme = "yes"
  ¬c:clause_type = "PHRAS"
  ?r-> c:?Yl {}
}

//language.id.iso.ES

lexicon.?lex.gp.?r.I
¬ lexicon.?lex.Oper1.?lexOper0
lexicon.miscellaneous.support_verb.Oper1.?lexOper
lexicon.?lexOper.lemma.?lemma


¬ ( ?Xl { c:?s3-> c:?Dep3 { c:lex = ?lexd3 } } lexicon.?lex.gp.?s3.II &  lexicon.?lex.Oper2.?lexOper2 )

// The dependent is  a cordinating conjunction
c:?Yl { c:pos = "CC" c:?a1-> ?Conjunct { c:sem = ?d2 } }
 ( ?a1 == "A1" | ?a1 == A1 )

// There is no other candidate A1 (PTB_28872)
¬ ( ?Yl { id = ?idyl } & ?Xl { ?s-> ?Zl {id = ?idzl } } & ?r == ?s & ?idzl < ?idyl )
  ]
  mixed = [

  ]
  rightside = [
?Oper1 {
  <=> ?Xl
  main = yes
  pos = "VB"
  spos = "VV"
  //spos = "copula"
  finiteness = "FIN"
  dlex = ?lemma
  lex = ?lexOper
  clause_type = ?Xl.clause_type
  include = bubble_of_dep
  top = "yes"
  id = #randInt()#
  type = "support_verb_noIN"
  II-> ?Xr {
    <=> ?Xl
    dlex = ?d1
    bottom = "yes"
  }
  I-> ?Yr {
    <=> ?Conjunct
    dlex = ?d2
  }
}
  ]
]

Sem<=>DSynt node_ROOT_Oper1noA1_lexicon_prep : transfer_node_ROOT
[
  leftside = [
?Xl {
  sem = ?d1
  c:lex = ?lex
  main_rheme = "yes"
  ¬c:clause_type = "PHRAS"
  ?r-> ?Yl {
    sem = ?d2
  }
}

lexicon.?lex.gp.?r.II
lexicon.?lex.gp.II.prep.?prep
lexicon.?lex.Oper1.?lexOper
lexicon.?lexOper.lemma.?lemma
lexicon.?lexOper.spos.?spos

// Priority of Oper2 over Oper1 (arbitrary)
¬ ( c:?Xl { c:?s2-> c:?Y2l {} } & lexicon.?lex.gp.?s2.II & lexicon.?lex.Oper2.?lexOper2 )

// there is no argument mapping to A1, nor to ATTR, actually since if so there is no mapping to I
¬ ( c:?Xl { c:?s3-> c:?Y3l {} } & ( lexicon.?lex.gp.?s3.I | lexicon.?lex.gp.?s3.ATTR ) )

// The dependent is not a cordinating conjunction
¬ ( ?Yl { c:pos = "CC" c:?a1-> ?Conjunct {} } & (?a1 == "A1" | ?a1 == A1 ) )

// There is no other candidate A1 (PTB_28872)
¬ ( ?Yl { id = ?idyl } & ?Xl { ?s-> ?Zl {id = ?idzl } } & ?r == ?s & ?idzl < ?idyl )
  ]
  mixed = [

  ]
  rightside = [
?Oper1 {
  <=> ?Xl
  main = yes
  pos = "VB"
  spos = ?spos
  finiteness = "FIN"
  dlex = ?lemma
  lex = ?lexOper
  clause_type = ?Xl.clause_type
  include = bubble_of_dep
  top = "yes"
  id = #randInt()#
  type = "support_verb_noIN"
  I-> ?Xr {
    <=> ?Xl
    dlex = ?d1
    bottom = "yes"
  }
  II-> ?Yr {
    <=> ?Yl
    dlex = ?d2
    subcat_prep = ?prep
    GovLex = ?lexOper
  }
}
  ]
]

Sem<=>DSynt node_ROOT_Oper1noA1_lexicon_prep_COORD : transfer_node_ROOT
[
  leftside = [
?Xl {
  sem = ?d1
  c:lex = ?lex
  main_rheme = "yes"
  ¬c:clause_type = "PHRAS"
  ?r-> c:?Yl {}
}

lexicon.?lex.gp.?r.II
lexicon.?lex.gp.II.prep.?prep
lexicon.?lex.Oper1.?lexOper
lexicon.?lexOper.lemma.?lemma
lexicon.?lexOper.spos.?spos

// Priority of Oper2 over Oper1 (arbitrary)
¬ ( c:?Xl { c:?s2-> c:?Y2l {} } & lexicon.?lex.gp.?s2.II & lexicon.?lex.Oper2.?lexOper2 )

// there is no argument mapping to A1, nor to ATTR, actually since if so there is no mapping to I
¬ ( c:?Xl { c:?s3-> c:?Y3l {} } & ( lexicon.?lex.gp.?s3.I | lexicon.?lex.gp.?s3.ATTR ) )

// The dependent is not a cordinating conjunction
( c:?Yl { c:pos = "CC" c:?a1-> ?Conjunct { sem = ?d2 } } & (?a1 == "A1" | ?a1 == A1 ) )

// There is no other candidate A1 (PTB_28872)
¬ ( c:?Yl { c:id = ?idyl } & ?Xl { ?s-> ?Zl {id = ?idzl } } & ?r == ?s & ?idzl < ?idyl )
  ]
  mixed = [

  ]
  rightside = [
?Oper1 {
  <=> ?Xl
  main = yes
  pos = "VB"
  spos = ?spos
  finiteness = "FIN"
  dlex = ?lemma
  lex = ?lexOper
  clause_type = ?Xl.clause_type
  include = bubble_of_dep
  top = "yes"
  id = #randInt()#
  type = "support_verb_noIN"
  I-> ?Xr {
    <=> ?Xl
    dlex = ?d1
    bottom = "yes"
  }
  II-> ?Yr {
    <=> ?Conjunct
    dlex = ?d2
    subcat_prep = ?prep
    GovLex = ?lexOper
  }
}
  ]
]

Sem<=>DSynt node_ROOT_Oper1noA1_lexicon_case : transfer_node_ROOT
[
  leftside = [
?Xl {
  sem = ?d1
  c:lex = ?lex
  main_rheme = "yes"
  ¬c:clause_type = "PHRAS"
  ?r-> ?Yl {
    sem = ?d2
  }
}

lexicon.?lex.gp.?r.II
// BUG MATE: can't use the same variable in a negative condition apparently
¬ ( lexicon.?lex0.gp.II.prep.?prep & ?lex0 == ?lex )
lexicon.?lex.gp.II.case.?case
lexicon.?lex.Oper1.?lexOper
lexicon.?lexOper.lemma.?lemma
lexicon.?lexOper.spos.?spos

// Priority of Oper2 over Oper1 (arbitrary)
¬ ( c:?Xl { c:?s2-> c:?Y2l {} } & lexicon.?lex.gp.?s2.II & lexicon.?lex.Oper2.?lexOper2 )

// there is no argument mapping to A1, nor to ATTR, actually since if so there is no mapping to I
¬ ( c:?Xl { c:?s3-> c:?Y3l {} } & ( lexicon.?lex.gp.?s3.I | lexicon.?lex.gp.?s3.ATTR ) )

// The dependent is not a cordinating conjunction
¬ ( ?Yl { c:pos = "CC" c:?a1-> c:?Conjunct {} } & (?a1 == "A1" | ?a1 == A1 ) )

// There is no other candidate A1 (PTB_28872)
¬ ( ?Yl { id = ?idyl } & ?Xl { ?s-> ?Zl {id = ?idzl } } & ?r == ?s & ?idzl < ?idyl )
  ]
  mixed = [

  ]
  rightside = [
?Oper1 {
  <=> ?Xl
  main = yes
  pos = "VB"
  spos = ?spos
  finiteness = "FIN"
  dlex = ?lemma
  lex = ?lexOper
  clause_type = ?Xl.clause_type
  include = bubble_of_dep
  top = "yes"
  id = #randInt()#
  type = "support_verb_noIN"
  I-> ?Xr {
    <=> ?Xl
    dlex = ?d1
    bottom = "yes"
  }
  II-> ?Yr {
    <=> ?Yl
    dlex = ?d2
    case = ?case
  }
}
  ]
]

/*Originally only for Spanish. Unclear why separated from the other languages.*/
Sem<=>DSynt node_ROOT_Oper1_IN_lexicon : transfer_node_ROOT
[
  leftside = [
?Xl {
  sem = ?d1
  c:lex = ?lex
  main_rheme = "yes"
  ¬c:clause_type = "PHRAS"
  ?r-> ?Yl {
    sem = ?d2
  }
}

// For some adjective in Greek, it looks like the A2 is the one mapping to ATTR (A2 comes from an English predicate...)
( ?r == A1 | ?r == A2 )

//language.id.iso.ES

lexicon.?lex.gp.?r.ATTR
lexicon.?lex.Oper1.?lexOper
lexicon.?lexOper.lemma.?lemma

// The dependent is not a cordinating conjunction
¬ ( ?Yl { c:pos = "CC" c:?a1-> c:?Conjunct {} } & (?a1 == "A1" | ?a1 == A1 ) )

// There is no other candidate A1 (PTB_28872)
¬ ( ?Yl { id = ?idyl } & ?Xl { ?s-> ?Zl {id = ?idzl } } & ?r == ?s & ?idzl < ?idyl )
  ]
  mixed = [

  ]
  rightside = [
?Oper1 {
  <=> ?Xl
  main = yes
  pos = "VB"
  spos = "copula"
  finiteness = "FIN"
  dlex = ?lemma
  lex = ?lexOper
  clause_type = ?Xl.clause_type
  include = bubble_of_dep
  top = "yes"
  id = #randInt()#
  II-> ?Xr {
    <=> ?Xl
    dlex = ?d1
    bottom = "yes"
  }
  I-> ?Yr {
    <=> ?Yl
    dlex = ?d2
  }
}
  ]
]

/*Originally only for Spanish. Unclear why separated from the other languages.*/
Sem<=>DSynt node_ROOT_Oper1_IN_lexicon_COORD : transfer_node_ROOT
[
  leftside = [
?Xl {
  sem = ?d1
  c:lex = ?lex
  main_rheme = "yes"
  ¬c:clause_type = "PHRAS"
  ?r-> c:?Yl {}
}

( ?r == A1 | ?r == A2 )

//language.id.iso.ES

lexicon.?lex.gp.?r.ATTR
lexicon.?lex.Oper1.?lexOper
lexicon.?lexOper.lemma.?lemma

// The dependent is not a cordinating conjunction
c:?Yl { c:pos = "CC" c:?a1-> ?Conjunct { c:sem = ?d2 } }
 ( ?a1 == "A1" | ?a1 == A1 )

// There is no other candidate A1 (PTB_28872)
¬ ( ?Yl { id = ?idyl } & ?Xl { ?s-> ?Zl {id = ?idzl } } & ?r == ?s & ?idzl < ?idyl )
  ]
  mixed = [

  ]
  rightside = [
?Oper1 {
  <=> ?Xl
  main = yes
  pos = "VB"
  spos = "copula"
  finiteness = "FIN"
  dlex = ?lemma
  lex = ?lexOper
  clause_type = ?Xl.clause_type
  include = bubble_of_dep
  top = "yes"
  id = #randInt()#
  II-> ?Xr {
    <=> ?Xl
    dlex = ?d1
    bottom = "yes"
  }
  I-> ?Yr {
    <=> ?Conjunct
    dlex = ?d2
  }
}
  ]
]

/*Originally only for Spanish. Unclear why separated from the other languages.*/
Sem<=>DSynt node_ROOT_Oper1_IN_default : transfer_node_ROOT
[
  leftside = [
?Xl {
  sem = ?d1
  c:lex = ?lex
  c:pos = "IN"
  main_rheme = "yes"
  ¬c:clause_type = "PHRAS"
  ?r-> ?Yl {
    sem = ?d2
  }
}

( ?r == A1 | ?r == A2 )

//language.id.iso.ES

// see rule Oper lexicon
¬ ( ?Xl { c:lex = ?lex2 c:?r2-> c:?Dep2 {} }
 &  lexicon.?lex2.gp.?r2.I
 & lexicon.?lex2.Oper1.?sv2
)
// see rule Oper1_IN_lexicon
¬ ( ?Xl { c:lex = ?lex3 c:?r3-> c:?Dep3 {} }
 &  lexicon.?lex3.gp.?r3.ATTR
 & lexicon.?lex3.Oper1.?sv3
)
// so this rule applies only to one of the relations
¬ ( ?r == A2 & ?Xl { c:A1-> c:?Dep4 {} } )

¬ ( lexicon.?lex.gp.?r.ATTR
 & lexicon.?lex.Oper1.?lexOper0
 & lexicon.?lexOper0.lemma.?lemma0 )
 
¬ ( lexicon.?lex.gp.?r.I
 & lexicon.?lex.Oper1.?lexOper1
 & lexicon.?lexOper1.lemma.?lemma1 )
 
¬ ( lexicon.?lex.gp.?r.II
 & lexicon.?lex.Oper2.?lexOper2
 & lexicon.?lexOper2.lemma.?lemma2 )

// The dependent is not a cordinating conjunction
¬ ( ?Yl { c:pos = "CC" c:?a1-> c:?Conjunct {} } & (?a1 == "A1" | ?a1 == A1 ) )

// There is no other candidate A1 (PTB_28872)
¬ ( ?Yl { id = ?idyl } & ?Xl { ?s-> ?Zl {id = ?idzl } } & ?r == ?s & ?idzl < ?idyl )

lexicon._preposition_.Oper1.?lexOper
lexicon.?lexOper.lemma.?lemma
  ]
  mixed = [

  ]
  rightside = [
?Oper1 {
  <=> ?Xl
  main = yes
  pos = "VB"
  spos = "copula"
  finiteness = "FIN"
  dlex = ?lemma
  lex = ?lexOper
  clause_type = ?Xl.clause_type
  include = bubble_of_dep
  top = "yes"
  id = #randInt()#
  II-> ?Xr {
    <=> ?Xl
    dlex = ?d1
    bottom = "yes"
  }
  I-> ?Yr {
    <=> ?Yl
    dlex = ?d2
  }
}
  ]
]

/*Originally only for Spanish. Unclear why separated from the other languages.*/
Sem<=>DSynt node_ROOT_Oper1_JJ_RB_default : transfer_node_ROOT
[
  leftside = [
?Xl {
  sem = ?d1
  c:lex = ?lex
  ¬c:pos = "VB"
  ¬c:pos = "NN"
  ¬c:pos = "IN"
  main_rheme = "yes"
  ¬c:clause_type = "PHRAS"
  ?r-> ?Yl {
    sem = ?d2
  }
}

( ?r == A1 | ?r == A2 )

//language.id.iso.ES

// see rule Oper lexicon
¬ ( ?Xl { c:lex = ?lex2 c:?r2-> c:?Dep2 {} }
 &  lexicon.?lex2.gp.?r2.I
 & lexicon.?lex2.Oper1.?sv2
)
// see rule Oper1_IN_lexicon
¬ ( ?Xl { c:lex = ?lex3 c:?r3-> c:?Dep3 {} }
 &  lexicon.?lex3.gp.?r3.ATTR
 & lexicon.?lex3.Oper1.?sv3
)
// so this rule applies only to one of the relations
¬ ( ?r == A2 & ?Xl { c:A1-> c:?Dep4 {} } )

¬ ( lexicon.?lex.gp.?r.ATTR
 & lexicon.?lex.Oper1.?lexOper0
 & lexicon.?lexOper0.lemma.?lemma0 )
 
¬ ( lexicon.?lex.gp.?r.I
 & lexicon.?lex.Oper1.?lexOper1
 & lexicon.?lexOper1.lemma.?lemma1 )
 
¬ ( lexicon.?lex.gp.?r.II
 & lexicon.?lex.Oper2.?lexOper2
 & lexicon.?lexOper2.lemma.?lemma2 )

// The dependent is not a cordinating conjunction
¬ ( ?Yl { c:pos = "CC" c:?a1-> c:?Conjunct {} } & (?a1 == "A1" | ?a1 == A1 ) )

// There is no other candidate A1 (PTB_28872)
¬ ( ?Yl { id = ?idyl } & ?Xl { ?s-> ?Zl {id = ?idzl } } & ?r == ?s & ?idzl < ?idyl )

lexicon._adjective_.Oper1.?lexOper
lexicon.?lexOper.lemma.?lemma
  ]
  mixed = [

  ]
  rightside = [
?Oper1 {
  <=> ?Xl
  main = yes
  pos = "VB"
  spos = "copula"
  finiteness = "FIN"
  dlex = ?lemma
  lex = ?lexOper
  clause_type = ?Xl.clause_type
  include = bubble_of_dep
  top = "yes"
  id = #randInt()#
  II-> ?Xr {
    <=> ?Xl
    dlex = ?d1
    bottom = "yes"
  }
  I-> ?Yr {
    <=> ?Yl
    dlex = ?d2
  }
}
  ]
]

/*This rule should cover all languages instead of just Italian.*/
Sem<=>DSynt node_ROOT_Oper_IN_default_COORD : transfer_node_ROOT
[
  leftside = [
?Xl {
  sem = ?d1
  c:predValue = ?pv
  main_rheme = "yes"
  c:pos = "IN"
  ¬c:clause_type = "PHRAS"
  A1-> c:?Yl {}
}

//language.id.iso.IT

// The dependent is  a cordinating conjunction
( c:?Yl { c:pos = "CC" c:?a1-> ?Conjunct { c:sem = ?d2 } } & (?a1 == "A1" | ?a1 == A1 ) )

// see rule Oper lexicon
¬ ( ?Xl { c:lex = ?lex c:?r-> c:?Dep {} }
 &  lexicon.?lex.gp.?r.I
 & lexicon.?lex.Oper1.?sv
)

¬ ( ?Xl { c:lex = ?lex0 } lexicon.?lex0.gp.A1.ATTR
 & lexicon.?lex0.Oper1.?lexOper0
 & lexicon.?lexOper0.lemma.?lemma0 )
 
¬ ( ?Xl { c:lex = ?lex1 } lexicon.?lex1.gp.A1.I
 & lexicon.?lex1.Oper1.?lexOper1
 & lexicon.?lexOper1.lemma.?lemma1 )
 
¬ ( ?Xl { c:lex = ?lex2 } lexicon.?lex2.gp.A1.II
 & lexicon.?lex2.Oper2.?lexOper2
 & lexicon.?lexOper2.lemma.?lemma2 )

lexicon._preposition_.Oper1.?lexOper
lexicon.?lexOper.lemma.?lemma
  ]
  mixed = [

  ]
  rightside = [
?Oper1 {
  <=> ?Xl
  main = yes
  pos = "VB"
  spos = "VV"
  finiteness = "FIN"
  dlex = ?lemma
  lex = ?lexOper
  top = "yes"
  clause_type = ?Xl.clause_type
  include = bubble_of_dep
  id = #randInt()#
  II-> ?Xr {
    <=> ?Xl
    dlex = ?d1
    bottom = "yes"
  }
  I-> ?Yr {
    <=> ?Conjunct
    dlex = ?d2
  }
}
  ]
]

/*This rule should cover all languages instead of just Italian.*/
Sem<=>DSynt node_ROOT_Oper_JJ_RB_default_COORD : transfer_node_ROOT
[
  leftside = [
?Xl {
  sem = ?d1
  c:predValue = ?pv
  main_rheme = "yes"
  ¬c:pos = "VB"
  ¬c:pos = "NN"
  ¬c:pos = "IN"
  ¬c:clause_type = "PHRAS"
  A1-> c:?Yl {}
}

//language.id.iso.IT

// The dependent is  a cordinating conjunction
( c:?Yl { c:pos = "CC" c:?a1-> ?Conjunct { c:sem = ?d2 } } & (?a1 == "A1" | ?a1 == A1 ) )

// see rule Oper lexicon
¬ ( ?Xl { c:lex = ?lex c:?r-> c:?Dep {} }
 &  lexicon.?lex.gp.?r.I
 & lexicon.?lex.Oper1.?sv
)

¬ ( ?Xl { c:lex = ?lex0 } lexicon.?lex0.gp.A1.ATTR
 & lexicon.?lex0.Oper1.?lexOper0
 & lexicon.?lexOper0.lemma.?lemma0 )
 
¬ ( ?Xl { c:lex = ?lex1 } lexicon.?lex1.gp.A1.I
 & lexicon.?lex1.Oper1.?lexOper1
 & lexicon.?lexOper1.lemma.?lemma1 )
 
¬ ( ?Xl { c:lex = ?lex2 } lexicon.?lex2.gp.A1.II
 & lexicon.?lex2.Oper2.?lexOper2
 & lexicon.?lexOper2.lemma.?lemma2 )

lexicon._adjective_.Oper1.?lexOper
lexicon.?lexOper.lemma.?lemma
  ]
  mixed = [

  ]
  rightside = [
?Oper1 {
  <=> ?Xl
  main = yes
  pos = "VB"
  spos = "VV"
  finiteness = "FIN"
  dlex = ?lemma
  lex = ?lexOper
  top = "yes"
  clause_type = ?Xl.clause_type
  include = bubble_of_dep
  id = #randInt()#
  II-> ?Xr {
    <=> ?Xl
    dlex = ?d1
    bottom = "yes"
  }
  I-> ?Yr {
    <=> ?Conjunct
    dlex = ?d2
  }
}
  ]
]

Sem<=>DSynt node_ROOT_Oper2_lexicon : transfer_node_ROOT
[
  leftside = [
?Xl {
  sem = ?d1
  c:lex = ?lex
  main_rheme = "yes"
  ¬c:clause_type = "PHRAS"
  ?r-> ?Yl {
    sem = ?d2
  }
}

lexicon.?lex.gp.?r.II
lexicon.?lex.Oper2.?lexOper
lexicon.?lexOper.lemma.?lemma
lexicon.?lexOper.spos.?spos

// The dependent is not a cordinating conjunction
¬ ( ?Yl { c:pos = "CC" c:?a1-> c:?Conjunct {} } & (?a1 == "A1" | ?a1 == A1 ) )

// There is no other candidate A1 (PTB_28872)
¬ ( ?Yl { id = ?idyl } & ?Xl { ?s-> ?Zl {id = ?idzl } } & ?r == ?s & ?idzl < ?idyl )

// Priority of Oper1 over Oper2 (arbitrary)
¬ ( c:?Xl { c:?s2-> c:?Y2l {} } & lexicon.?lex.gp.?s2.I & lexicon.?lex.Oper1.?lexOper1 )
  ]
  mixed = [

  ]
  rightside = [
?Oper1 {
  <=> ?Xl
  main = yes
  pos = "VB"
  spos = ?spos
  finiteness = "FIN"
  dlex = ?lemma
  lex = ?lexOper
  clause_type = ?Xl.clause_type
  include = bubble_of_dep
  top = "yes"
  II-> ?Xr {
    <=> ?Xl
    dlex = ?d1
    bottom = "yes"
  }
  I-> ?Yr {
    <=> ?Yl
    dlex = ?d2
  }
}
  ]
]

Sem<=>DSynt node_ROOT_Oper2_lexicon_COORD : transfer_node_ROOT
[
  leftside = [
?Xl {
  sem = ?d1
  c:lex = ?lex
  main_rheme = "yes"
  ¬c:clause_type = "PHRAS"
  ?r-> c:?Yl {}
}

lexicon.?lex.gp.?r.II
lexicon.?lex.Oper2.?lexOper
lexicon.?lexOper.lemma.?lemma
lexicon.?lexOper.spos.?spos

// The dependent is  a cordinating conjunction
c:?Yl { c:pos = "CC" c:?a1-> ?Conjunct { c:sem = ?d2 } }
 ( ?a1 == "A1" | ?a1 == A1 )

// There is no other candidate A1
¬ ( ?Yl { id = ?idyl } & ?Xl { ?s-> ?Zl {id = ?idzl } } & ?r == ?s & ?idzl < ?idyl )
  ]
  mixed = [

  ]
  rightside = [
?Oper1 {
  <=> ?Xl
  main = yes
  pos = "VB"
  spos = ?spos
  finiteness = "FIN"
  dlex = ?lemma
  lex = ?lexOper
  clause_type = ?Xl.clause_type
  include = bubble_of_dep
  top = "yes"
  II-> ?Xr {
    <=> ?Xl
    dlex = ?d1
    bottom = "yes"
  }
  I-> ?Yr {
    <=> ?Conjunct
    dlex = ?d2
  }
}
  ]
]

/*PATCH: stat gen does not generate Oper yet!
So far we use oper only for preps, adverbs and adjectives, so value is always "be"
This rule should cover all languages instead of just Italian.*/
excluded Sem<=>DSynt ES_node_ROOT_Oper1_IN : transfer_node_ROOT
[
  leftside = [
?Xl {
  sem = ?d1
  c:predValue = ?pv
  main_rheme = "yes"
  ¬c:pos = "VB"
  ¬c:pos = "NN"
  A1-> ?Yl {
    sem = ?d2
  }
}

¬ language.id.iso.ES

// The dependent is not a cordinating conjunction
¬ ( ?Yl { c:pos = "CC" c:?a1-> c:?Conjunct {} } & (?a1 == "A1" | ?a1 == A1 ) )

// There is no other candidate A1 (PTB_28872)
¬ ( ?Yl { id = ?idyl } & ?Xl { A1-> ?Zl {id = ?idzl } } & ?idzl < ?idyl )

// see rule Oper lexicon
¬ ( ?Xl { c:lex = ?lex c:?r-> c:?Dep {} }
 &  lexicon.?lex.gp.?r.I
 & lexicon.?lex.Oper1.?sv
)

lexicon._preposition_.Oper1.?lexOper
lexicon.?lexOper.lemma.?lemma
  ]
  mixed = [

  ]
  rightside = [
?Oper1 {
  <=> ?Xl
  main = yes
  pos = "VB"
  spos = "VV"
  finiteness = "FIN"
  dlex = ?lemma
  lex = ?lexOper
  top = "yes"
  clause_type = ?Xl.clause_type
  //tense = ?Xl.tense
  include = bubble_of_dep
  id = #randInt()#
  II-> ?Xr {
    <=> ?Xl
    dlex = ?d1
    bottom = "yes"
  }
  I-> ?Yr {
    <=> ?Yl
    dlex = ?d2
  }
}
  ]
]

/*PATCH: stat gen does not generate Oper yet!
So far we use opoer only for preps, adverbs and adjectives, so value is always "be"*/
excluded Sem<=>DSynt EN_node_ROOT_Oper_IN_COORD : transfer_node_ROOT
[
  leftside = [
?Xl {
  sem = ?d1
  c:predValue = ?pv
  main_rheme = "yes"
  ¬c:pos = "VB"
  ¬c:pos = "NN"
  A1-> c:?Yl {}
}

language.id.iso.EN

// The dependent is  a cordinating conjunction
( c:?Yl { c:pos = "CC" c:?a1-> ?Conjunct { c:sem = ?d2 } } & (?a1 == "A1" | ?a1 == A1 ) )

// see rule Oper lexicon
¬ ( ?Xl { c:lex = ?lex c:?r-> c:?Dep {} }
 &  lexicon.?lex.gp.?r.I
 & lexicon.?lex.Oper1.?sv
)
  ]
  mixed = [

  ]
  rightside = [
?Oper1 {
  <=> ?Xl
  main = yes
  pos = "VB"
  spos = "VV"
  finiteness = "FIN"
  dlex = "be"
  lex = "be_VB_01"
  top = "yes"
  clause_type = ?Xl.clause_type
  include = bubble_of_dep
  id = #randInt()#
  II-> ?Xr {
    <=> ?Xl
    dlex = ?d1
    bottom = "yes"
  }
  I-> ?Yr {
    <=> ?Conjunct
    dlex = ?d2
  }
}
  ]
]

/*PATCH: stat gen does not generate Oper yet!
So far we use opoer only for preps, adverbs and adjectives, so value is always "be"*/
excluded Sem<=>DSynt ES_node_ROOT_Oper_IN_COORD : transfer_node_ROOT
[
  leftside = [
?Xl {
  sem = ?d1
  c:predValue = ?pv
  main_rheme = "yes"
  ¬c:pos = "VB"
  ¬c:pos = "NN"
  A1-> c:?Yl {}
}

language.id.iso.ES

// The dependent is  a cordinating conjunction
( c:?Yl { c:pos = "CC" c:?a1-> ?Conjunct { c:sem = ?d2 } } & (?a1 == "A1" | ?a1 == A1 ) )

// see rule Oper lexicon
¬ ( ?Xl { c:lex = ?lex c:?r-> c:?Dep {} }
 &  lexicon.?lex.gp.?r.I
 & lexicon.?lex.Oper1.?sv
)
  ]
  mixed = [

  ]
  rightside = [
?Oper1 {
  <=> ?Xl
  main = yes
  pos = "VB"
  spos = "copula"
  finiteness = "FIN"
  dlex = "ser"
  lex = "ser_VB_01"
  top = "yes"
  clause_type = ?Xl.clause_type
  include = bubble_of_dep
  id = #randInt()#
  II-> ?Xr {
    <=> ?Xl
    dlex = ?d1
    bottom = "yes"
  }
  I-> ?Yr {
    <=> ?Conjunct
    dlex = ?d2
  }
}
  ]
]

/*Test rule in English to generate cases like N1 Location-> N2 (when oly nodes, or main nodes of the sentence).
So far, only Location semantemes can be root, so this rule so far interacts only with EN_node_ROOT_Oper1_IN and node_dep_NOarg_sem_prep.
Probably many rules would need to be updated eventually, particular node_dep_NOarg_Locin.*/
Sem<=>DSynt node_ROOT_Oper1_semanteme : transfer_node_ROOT
[
  leftside = [
?Xl {
  sem = ?d1
  main_rheme = "yes"
  ¬c:pos = "VB"
  ¬c:pos = "NN"
  ¬c:clause_type = "PHRAS"
  A1-> ?Yl {
    sem = ?d2
  }
  A2-> ?Zl {
    sem = ?d3
    ¬c:pos = "IN"
    ¬c:pos = "RB"
    // see pointTime_AMR
    ¬c:date_type = ?dt
  }
}

//language.id.iso.?lang
//concepticon.?d1.?lang.lex.?lex
semanticon.?d1.gen.lex.?lex
lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos

lexicon.miscellaneous.support_verb.?d1.?lexOper
lexicon.?lexOper.lemma.?lemma

// The dependents are not a cordinating conjunction
¬ ( ?Yl { c:pos = "CC" c:?a1-> c:?Conjunct1 {} } & (?a1 == "A1" | ?a1 == A1 ) )
¬ ( ?Zl { c:pos = "CC" c:?a2-> c:?Conjunct2 {} } & (?a2 == "A1" | ?a2 == A1 ) )

// There is no other candidate A1 (PTB_28872)
¬ ( ?Yl { id = ?idyl } & ?Xl { A1-> ?Z1l {id = ?idzl } } & ?idzl < ?idyl )

// See node_ROOT_Oper1_semanteme_Locin
¬ ( ?d1 == "locative_relation" & c:?Zl { c:lex = ?zlex } & lexicon.?zlex.Locin.?loc )
  ]
  mixed = [

  ]
  rightside = [
?Oper1 {
  <=> ?Xl
  main = yes
  pos = "VB"
  spos = "VV"
  finiteness = "FIN"
  dlex = ?lemma
  lex = ?lexOper
  top = "yes"
  clause_type = ?Xl.clause_type
  //tense = ?Xl.tense
  include = bubble_of_dep
  id = #randInt()#
  I-> ?Yr {
    <=> ?Yl
    dlex = ?d2
  }
  II-> ?Wr {
    dlex = ?lem
    lex = ?lex
    pos = ?pos
    include = bubble_of_gov
    meaning = ?d1
    id = #randInt()#
    II-> ?Zr {
      <=> ?Zl
      dlex = ?d3
    }
  }
}
  ]
]

Sem<=>DSynt node_ROOT_Oper1_semanteme_Locin : transfer_node_ROOT
[
  leftside = [
?Xl {
  sem = ?d1
  main_rheme = "yes"
  ¬c:clause_type = "PHRAS"
  ¬c:pos = "VB"
  ¬c:pos = "NN"
  A1-> ?Yl {
    sem = ?d2
  }
  A2-> ?Zl {
    sem = ?d3
    ¬c:pos = "IN"
    ¬c:pos = "RB"
    // see pointTime_AMR
    ¬c:date_type = ?dt
    c:lex = ?zlex
  }
}

//language.id.iso.EN

( ?d1 == "locative_relation" & lexicon.?zlex.Locin.?loc )
lexicon.?loc.lemma.?lem
lexicon.?loc.pos.?pos

lexicon.miscellaneous.support_verb.?d1.?lexOper
lexicon.?lexOper.lemma.?lemma

// The dependents are not a cordinating conjunction
¬ ( ?Yl { c:pos = "CC" c:?a1-> c:?Conjunct1 {} } & (?a1 == "A1" | ?a1 == A1 ) )
¬ ( ?Zl { c:pos = "CC" c:?a2-> c:?Conjunct2 {} } & (?a2 == "A1" | ?a2 == A1 ) )

// There is no other candidate A1 (PTB_28872)
¬ ( ?Yl { id = ?idyl } & ?Xl { A1-> ?Z1l {id = ?idzl } } & ?idzl < ?idyl )
  ]
  mixed = [

  ]
  rightside = [
?Oper1 {
  <=> ?Xl
  main = yes
  pos = "VB"
  spos = "VV"
  finiteness = "FIN"
  dlex = ?lemma
  lex = ?lexOper
  top = "yes"
  clause_type = ?Xl.clause_type
  //tense = ?Xl.tense
  include = bubble_of_dep
  id = #randInt()#
  I-> ?Yr {
    <=> ?Yl
    dlex = ?d2
  }
  II-> ?Wr {
    dlex = ?lem
    lex = ?loc
    pos = ?pos
    include = bubble_of_gov
    meaning = ?d1
    id = #randInt()#
    II-> ?Zr {
      <=> ?Zl
      dlex = ?d3
    }
  }
}
  ]
]

Sem<=>DSynt node_ROOT_Oper1_semanteme_Locin_COORD1 : transfer_node_ROOT
[
  leftside = [
?Xl {
  sem = ?d1
  main_rheme = "yes"
  ¬c:clause_type = "PHRAS"
  ¬c:pos = "VB"
  ¬c:pos = "NN"
  A1-> c:?Yl {
    c:sem = ?d2
  }
  A2-> ?Zl {
    sem = ?d3
    ¬c:pos = "IN"
    ¬c:pos = "RB"
    // see pointTime_AMR
    ¬c:date_type = ?dt
    c:lex = ?zlex
  }
}

//language.id.iso.EN

( ?d1 == "locative_relation" & lexicon.?zlex.Locin.?loc )
lexicon.?loc.lemma.?lem
lexicon.?loc.pos.?pos

lexicon.miscellaneous.support_verb.?d1.?lexOper
lexicon.?lexOper.lemma.?lemma

// Zl is  not a cordinating conjunction but Yl is
( ?Yl { c:pos = "CC" c:?a1-> c:?Conjunct1 { sem = ?d2C } } & (?a1 == "A1" | ?a1 == A1 ) )
¬ ( ?Zl { c:pos = "CC" c:?a2-> c:?Conjunct2 {} } & (?a2 == "A1" | ?a2 == A1 ) )

// There is no other candidate A1 (PTB_28872)
¬ ( ?Yl { id = ?idyl } & ?Xl { A1-> ?Z1l {id = ?idzl } } & ?idzl < ?idyl )
  ]
  mixed = [

  ]
  rightside = [
?Oper1 {
  <=> ?Xl
  main = yes
  pos = "VB"
  spos = "VV"
  finiteness = "FIN"
  dlex = ?lemma
  lex = ?lexOper
  top = "yes"
  clause_type = ?Xl.clause_type
  //tense = ?Xl.tense
  include = bubble_of_dep
  id = #randInt()#
  I-> ?Yr {
    <=> ?Conjunct1
    dlex = ?d2C
  }
  II-> ?Wr {
    dlex = ?lem
    lex = ?loc
    pos = ?pos
    include = bubble_of_gov
    meaning = ?d1
    id = #randInt()#
    II-> ?Zr {
      <=> ?Zl
      dlex = ?d3
    }
  }
}
  ]
]

/*191111_beAWARE_P3-2.conll, sentence 37*/
Sem<=>DSynt node_ROOT_Oper1_semanteme_COORD1 : transfer_node_ROOT
[
  leftside = [
?Xl {
  sem = ?d1
  main_rheme = "yes"
  ¬c:clause_type = "PHRAS"
  ¬c:pos = "VB"
  ¬c:pos = "NN"
  A1-> c:?Yl {
    c:sem = ?d2
  }
  A2-> ?Zl {
    sem = ?d3
    ¬c:pos = "IN"
    ¬c:pos = "RB"
    // see pointTime_AMR
    ¬c:date_type = ?dt
  }
}

//language.id.iso.?lang
//concepticon.?d1.?lang.lex.?lex

semanticon.?d1.gen.lex.?lex
lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos

lexicon.miscellaneous.support_verb.?d1.?lexOper
lexicon.?lexOper.lemma.?lemma

?Yl { c:pos = "CC" c:?a1-> c:?Conjunct1 { sem = ?d2C } } & (?a1 == "A1" | ?a1 == A1 )
// Z is not a cordinating conjunction
¬ ( ?Zl { c:pos = "CC" c:?a2-> c:?Conjunct2 {} } & (?a2 == "A1" | ?a2 == A1 ) )

// There is no other candidate A1 (PTB_28872)
¬ ( ?Yl { id = ?idyl } & ?Xl { A1-> ?Z1l {id = ?idzl } } & ?idzl < ?idyl )

// Missing complementary rule to cover this configuration in which Z has a Locin
¬ ( ?d1 == "locative_relation" & c:?Zl { c:lex = ?zlex } & lexicon.?zlex.Locin.?loc )
  ]
  mixed = [

  ]
  rightside = [
?Oper1 {
  <=> ?Xl
  main = yes
  pos = "VB"
  spos = "VV"
  finiteness = "FIN"
  dlex = ?lemma
  lex = ?lexOper
  top = "yes"
  clause_type = ?Xl.clause_type
  //tense = ?Xl.tense
  include = bubble_of_dep
  id = #randInt()#
  I-> ?Yr {
    <=> ?Conjunct1
    dlex = ?d2C
  }
  II-> ?Wr {
    dlex = ?lem
    lex = ?lex
    pos = ?pos
    include = bubble_of_gov
    meaning = ?d1
    id = #randInt()#
    II-> ?Zr {
      <=> ?Zl
      dlex = ?d3
    }
  }
}
  ]
]

/*191111_beAWARE_P3-2.conll, sentence 37*/
Sem<=>DSynt node_ROOT_Oper1_semanteme_COORD2 : transfer_node_ROOT
[
  leftside = [
?Xl {
  sem = ?d1
  main_rheme = "yes"
  ¬c:clause_type = "PHRAS"
  ¬c:pos = "VB"
  ¬c:pos = "NN"
  A1-> ?Yl {
    sem = ?d2
  }
  A2-> c:?Zl {
    c:sem = ?d3
    ¬c:pos = "IN"
    ¬c:pos = "RB"
    // see pointTime_AMR
    ¬c:date_type = ?dt
  }
}

//language.id.iso.?lang
//concepticon.?d1.?lang.lex.?lex

semanticon.?d1.gen.lex.?lex
lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos

lexicon.miscellaneous.support_verb.?d1.?lexOper
lexicon.?lexOper.lemma.?lemma

// Y is not a cordinating conjunction
¬ ( ?Yl { c:pos = "CC" c:?a1-> c:?Conjunct1 {} } & (?a1 == "A1" | ?a1 == A1 ) )
?Zl { c:pos = "CC" c:?a2-> c:?Conjunct2 { sem = ?d2C} } & (?a2 == "A1" | ?a2 == A1 )

// There is no other candidate A1 (PTB_28872)
¬ ( ?Yl { id = ?idyl } & ?Xl { A1-> ?Z1l {id = ?idzl } } & ?idzl < ?idyl )

// Missing complementary rule to cover this configuration in which Z has a Locin
¬ ( ?d1 == "locative_relation" & c:?Zl { c:lex = ?zlex } & lexicon.?zlex.Locin.?loc )
  ]
  mixed = [

  ]
  rightside = [
?Oper1 {
  <=> ?Xl
  main = yes
  pos = "VB"
  spos = "VV"
  finiteness = "FIN"
  dlex = ?lemma
  lex = ?lexOper
  top = "yes"
  clause_type = ?Xl.clause_type
  //tense = ?Xl.tense
  include = bubble_of_dep
  id = #randInt()#
  I-> ?Yr {
    <=> ?Yl
    dlex = ?d2
  }
  II-> ?Wr {
    dlex = ?lem
    lex = ?lex
    pos = ?pos
    include = bubble_of_gov
    meaning = ?d1
    id = #randInt()#
    II-> ?Zr {
      <=> ?Conjunct2
      dlex = ?d2C
    }
  }
}
  ]
]

/*191111_beAWARE_P3-2.conll, sentence 37*/
Sem<=>DSynt node_ROOT_Oper1_semanteme_COORD1_2 : transfer_node_ROOT
[
  leftside = [
?Xl {
  sem = ?d1
  main_rheme = "yes"
  ¬c:clause_type = "PHRAS"
  ¬c:pos = "VB"
  ¬c:pos = "NN"
  A1-> ?Yl {
    sem = ?d2
  }
  A2-> c:?Zl {
    c:sem = ?d3
    ¬c:pos = "IN"
    ¬c:pos = "RB"
    // see pointTime_AMR
    ¬c:date_type = ?dt
  }
}

//language.id.iso.?lang
//concepticon.?d1.?lang.lex.?lex

semanticon.?d1.gen.lex.?lex
lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos

lexicon.miscellaneous.support_verb.?d1.?lexOper
lexicon.?lexOper.lemma.?lemma

?Yl { c:pos = "CC" c:?a1-> c:?Conjunct1 { sem = ?d1C } } & (?a1 == "A1" | ?a1 == A1 )
?Zl { c:pos = "CC" c:?a2-> c:?Conjunct2 { sem = ?d2C} } & (?a2 == "A1" | ?a2 == A1 )

// There is no other candidate A1 (PTB_28872)
¬ ( ?Yl { id = ?idyl } & ?Xl { A1-> ?Z1l {id = ?idzl } } & ?idzl < ?idyl )

// Missing complementary rule to cover this configuration in which Z has a Locin
¬ ( ?d1 == "locative_relation" & c:?Zl { c:lex = ?zlex } & lexicon.?zlex.Locin.?loc )
  ]
  mixed = [

  ]
  rightside = [
?Oper1 {
  <=> ?Xl
  main = yes
  pos = "VB"
  spos = "VV"
  finiteness = "FIN"
  dlex = ?lemma
  lex = ?lexOper
  top = "yes"
  clause_type = ?Xl.clause_type
  //tense = ?Xl.tense
  include = bubble_of_dep
  id = #randInt()#
  I-> ?Yr {
    <=> ?Conjunct1
    dlex = ?d1C
  }
  II-> ?Wr {
    dlex = ?lem
    lex = ?lex
    pos = ?pos
    include = bubble_of_gov
    meaning = ?d1
    id = #randInt()#
    II-> ?Zr {
      <=> ?Conjunct2
      dlex = ?d2C
    }
  }
}
  ]
]

/*If the dependent is in the lexicon. BUG INHERITANCE DICO*/
Sem<=>DSynt node_dep_arg_lexicon_lex : transfer_node_arg
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  //See IN rule below
  ¬ ( c:pos = "IN" | c:pos = "TO" )
  //¬c:main_rheme = "yes"
  ?r-> ?Yl {
    sem = ?d
  }
}

//In case the input contains DSynt Relations already
(?r == "A1" | ?r == "A2" | ?r == A0 | ?r == A1 | ?r == A2 | ?r == A3 | ?r == A4 | ?r == A5 | ?r == A6 | ?r == AM)
// ?r maps to an argumental relation
lexicon.?lex.gp.?r.?DSyntR
¬?DSyntR == ATTR
¬?DSyntR == APPEND
¬?DSyntR == COORD

// The dependent is not a cordinating conjunction
¬ ( ?Yl { c:pos = "CC" c:?a1-> c:?Conjunct {} } & (?a1 == "A1" | ?a1 == A1 ) )

// see transfer_node_dep_NOarg_possessive
//¬(?r == A0 & c:?Xl {¬c:main_rheme = "yes" c:sem = "possess" c:A1-> c:?OtherNode {}})
¬ ( ?Xl.sem == "possess" & ?Xl.type == "added" )

// do not transfer rel in case of ECM (2 conditions to cover the two relations to transfer)
¬ ( c:?Xl { c:sem = ?sem1 } & control_raise.ECM.lex.?sem1
 & ?DSyntR == II 
 & c:?Yl { c:lex = ?lex1 c:pos = "VB" c:?s1-> c:?Dep1 {} }
 & lexicon.?lex1.gp.?s1.I
 & ¬ ( c:?Xl {c:?r3-> c:?Dep1 {} } & (?r3 == "A1" | ?r3 == "A2" | ?r3 == A0 | ?r3 == A1 | ?r3 == A2 ) )
 )
 ¬ ( c:?Govl { c:lex = ?lexGov c:sem = ?semGov c:?relGov-> c:?Xl { c:pos = "VB" } }
 & control_raise.ECM.lex.?semGov
 & lexicon.?lexGov.gp.?relGov.II
 & lexicon.?lex.gp.?r.I
 )

// do not transfer rel in case of raising (2 conditions to cover the two relations to transfer)
¬ ( c:?Xl { c:sem = ?sem2 } & control_raise.raising.lex.?sem2
// 160720: this was 1, wrong? if I,  rule overlap in PTB_train_08165
 & ?DSyntR == II
 & c:?Yl { c:lex = ?lex2 c:pos = "VB" c:?s2-> c:?Dep2 {} }
 & lexicon.?lex2.gp.?s2.I
 & ¬ ( c:?Xl {c:?r4-> c:?Dep2 {} } & (?r4 == "A1" | ?r4 == "A2" | ?r4 == A0 | ?r4 == A1 | ?r4 == A2 ) )
 )
 ¬ ( c:?Gov2l { c:lex = ?lexGov2 c:sem = ?semGov2 c:?relGov2-> c:?Xl { c:pos = "VB" } }
 & control_raise.raising.lex.?semGov2
// 160720: this was 1, wrong? see comment in condition above
 & lexicon.?lexGov2.gp.?relGov2.II
 & lexicon.?lex.gp.?r.I
 )

 // exclude cases of adjectives that still have their first argument below; problem with this condition (160101_PTB_eval_fixed, sent 2)
 // see node Oper Adj
 ( ¬ ( c:?Yl { ( c:pos = "JJ" | c:pos = "RB" ) c:A1-> c:?Node5l {} } )
 // unless it's the A2+ of a coordination (PTB_train_178) that is not an argument of anyone else
  | ( c:?Xl { c:pos = "CC" } & ¬ ( ?r == "A1" | ?r == A1 ) & c:?Yl { ( c:pos = "JJ" | c:pos = "RB" ) c:A1-> c:?Node6l {} } & ¬?SurGov {c:?surRel-> c:?Xl {}} )
  // Or there is  a another element above ?Xl that has ?Yl as an argument (amr_semeval_gen_3)
  | ( c:?Pred4 {  c:id = ?idP4 c:*?r5-> c:?Xl {} c:?s5-> ?Yl {} } & ¬ ( c:?OPred4 { c:id = ?idOp4 c:*?or5-> c:?Xl {} c:?os5-> ?Yl {} } & ?idOp4 < ?idP4 ) )
 )

 // if there is a coordination between a verb (1)  and a non-verb (2), the second conjunct needs a support verb
¬ ( c:?Xl { c:?rConj1-> c:?Conj1l { c:pos = "VB" c:conj_num = "1" } } & ?Yl { c:conj_num = "2" ¬c:pos = "VB" } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top = "yes"
  ?DSyntR-> ?Yr {
    <=> ?Yl
    consumed_ARG = ?r
    gov_id = ?Xl.id
    dlex = ?d
    //pos = ?pos
    //lex = #?d+_+?pos+_+?pv#
  }
}

// ?Yl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Yl }
// ?Xl hasn't already been used by another rel  rule
¬ ( rc:?Xr {rc:consumed_ATTR=?s } & ?s == ?r )
  ]
]

/*New set of rules to substitute node_dep_arg_lexicon_lex_Oper_II_JJ and node_dep_arg_lexicon_lex_Oper_I_JJ (they only covered Oper1 = "be")*/
Sem<=>DSynt node_dep_arg_lexicon_lex_Oper1_default : transfer_node_arg
[
  leftside = [
c:?MainV {
  c:lex = ?MainVlex
  //See IN rule below
  ¬( c:pos = "IN" | c:pos = "TO" | c:pos = "CC"  )
  //¬c:main_rheme = "yes"
  ?r-> ?Yl {
    sem = ?dY
    ( c:pos = "JJ" | c:pos = "RB" )
    A1-> ?Xl {
      sem = ?dX
    }
  }
}

//Testing new set of rules on MindSpaces 
project_info.project.name.MindSpaces

//In case the input contains DSynt Relations already
(?r == "A1" | ?r == "A2" | ?r == A0 | ?r == A1 | ?r == A2 | ?r == A3 | ?r == A4 | ?r == A5 | ?r == A6 | ?r == AM)
// ?r maps to an argumental relation
lexicon.?MainVlex.gp.?r.?DSyntR
¬?DSyntR == ATTR
¬?DSyntR == APPEND
¬?DSyntR == COORD

// if there are several possible X, only take one (the one with the smallest id0?)
¬ ( ?Yl { c:A1-> c:?Xl2 { c:id0 = ?id2 } } & ?Xl { c:id0 = ?id } & ¬?id == ?id2 & ?id > ?id2 )

¬lexicon.?lexY.Oper1.?lexOper
lexicon.miscellaneous.support_verb.Oper1.?lexOper
lexicon.?lexOper.lemma.?lemma

// The dependent is not a cordinating conjunction
¬ ( ?Xl { c:pos = "CC" c:?a1-> c:?Conjunct {} } & (?a1 == "A1" | ?a1 == A1 ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?MainVr {
  rc:<=> ?MainV
  ¬rc:top = "yes"
  ?DSyntR-> ?Oper1 {
    <=> ?Yl
    pos = "VB"
    spos = "VV"
    finiteness = "FIN"
    dlex = ?lemma
    lex = ?lexOper
    include = bubble_of_dep
    id = #randInt()#
    type = "support_verb_noIN"
    top = "yes"
    II-> ?Yr {
      <=> ?Yl
      consumed_ARG = ?r
      gov_id = ?MainV.id
      dlex = ?dY
      bottom = "yes"
    }
    I-> ?Xr {
      <=> ?Xl
      consumed_ARG = "A1"
      gov_id = ?Yl.id
      dlex = ?dX
      include = bubble_of_sibling_II
    }
  }
}

// ?Yl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Yl }
// ?MainV hasn't already been used by another rel  rule
¬ ( rc:?MainVr {rc:consumed_ATTR=?r2 } & ?r2 == ?r )
  ]
]

/*New set of rules to substitute node_dep_arg_lexicon_lex_Oper_II_JJ and node_dep_arg_lexicon_lex_Oper_I_JJ (they only covered Oper1 = "be")*/
Sem<=>DSynt node_dep_arg_lexicon_lex_Oper1_default_COORD : transfer_node_arg
[
  leftside = [
c:?MainV {
  c:lex = ?MainVlex
  //See IN rule below
  ¬( c:pos = "IN" | c:pos = "TO" | c:pos = "CC"  )
  //¬c:main_rheme = "yes"
  ?r-> ?Yl {
    sem = ?dY
    ( c:pos = "JJ" | c:pos = "RB" )
    A1-> ?Xl {}
  }
}

//Testing new set of rules on MindSpaces 
project_info.project.name.MindSpaces

//In case the input contains DSynt Relations already
(?r == "A1" | ?r == "A2" | ?r == A0 | ?r == A1 | ?r == A2 | ?r == A3 | ?r == A4 | ?r == A5 | ?r == A6 | ?r == AM)
// ?r maps to an argumental relation
lexicon.?MainVlex.gp.?r.?DSyntR
¬?DSyntR == ATTR
¬?DSyntR == APPEND
¬?DSyntR == COORD

// if there are several possible X, only take one (the one with the smallest id0?)
¬ ( ?Yl { c:A1-> c:?Xl2 { c:id0 = ?id2 } } & ?Xl { c:id0 = ?id } & ¬?id == ?id2 & ?id > ?id2 )

¬lexicon.?lexY.Oper1.?lexOper
lexicon.miscellaneous.support_verb.Oper1.?lexOper
lexicon.?lexOper.lemma.?lemma

// The dependent is  a cordinating conjunction
c:?Xl { c:pos = "CC" c:?a1-> ?Conjunct { c:sem = ?d2 } }
 ( ?a1 == "A1" | ?a1 == A1 )
  ]
  mixed = [

  ]
  rightside = [
rc:?MainVr {
  rc:<=> ?MainV
  ¬rc:top = "yes"
  ?DSyntR-> ?Oper1 {
    <=> ?Yl
    pos = "VB"
    spos = "VV"
    finiteness = "FIN"
    dlex = ?lemma
    lex = ?lexOper
    include = bubble_of_dep
    id = #randInt()#
    type = "support_verb_noIN"
    top = "yes"
    II-> ?Yr {
      <=> ?Yl
      consumed_ARG = ?r
      gov_id = ?MainV.id
      dlex = ?dY
      bottom = "yes"
    }
    I-> ?Xr {
      <=> ?Xl
      consumed_ARG = "A1"
      gov_id = ?Yl.id
      dlex = ?dX
      include = bubble_of_sibling_II
    }
  }
}

// ?Yl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Yl }
// ?MainV hasn't already been used by another rel  rule
¬ ( rc:?MainVr {rc:consumed_ATTR=?r2 } & ?r2 == ?r )
  ]
]

/*New set of rules to substitute node_dep_arg_lexicon_lex_Oper_II_JJ and node_dep_arg_lexicon_lex_Oper_I_JJ (they only covered Oper1 = "be")
They are a combination of these two rules and the Oper rules in transfer_node_ROOT
Only Oper1_lexicon and Oper1_default for now, but more may be needed*/
Sem<=>DSynt node_dep_arg_lexicon_lex_Oper1_lexicon : transfer_node_arg
[
  leftside = [
c:?MainV {
  c:lex = ?MainVlex
  //See IN rule below
  ¬( c:pos = "IN" | c:pos = "TO" | c:pos = "CC"  )
  //¬c:main_rheme = "yes"
  ?r-> ?Yl {
    sem = ?dY
    c:lex = ?lexY
    ( c:pos = "JJ" | c:pos = "RB" )
    A1-> ?Xl {
      sem = ?dX
    }
  }
}

// Testing new set of rules on MindSpaces 
project_info.project.name.MindSpaces

// In case the input contains DSynt Relations already
(?r == "A1" | ?r == "A2" | ?r == A0 | ?r == A1 | ?r == A2 | ?r == A3 | ?r == A4 | ?r == A5 | ?r == A6 | ?r == AM)
// ?r maps to an argumental relation
lexicon.?MainVlex.gp.?r.?DSyntR
¬?DSyntR == ATTR
¬?DSyntR == APPEND
¬?DSyntR == COORD

// if there are several possible X, only take one (the one with the smallest id0?)
¬ ( ?Yl { c:A1-> c:?Xl2 { c:id0 = ?id2 } } & ?Xl { c:id0 = ?id } & ¬?id == ?id2 & ?id > ?id2 )

lexicon.?lexY.Oper1.?lexOper
lexicon.?lexOper.lemma.?lemma
lexicon.?lexOper.spos.?spos

// The dependent is not a cordinating conjunction
¬ ( ?Xl { c:pos = "CC" c:?a1-> c:?Conjunct {} } & (?a1 == "A1" | ?a1 == A1 ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?MainVr {
  rc:<=> ?MainV
  ¬rc:top = "yes"
  ?DSyntR-> ?Oper1 {
    <=> ?Yl
    pos = "VB"
    spos = "VV"
    finiteness = "FIN"
    dlex = ?lemma
    lex = ?lexOper
    include = bubble_of_dep
    id = #randInt()#
    type = "support_verb_noIN"
    top = "yes"
    II-> ?Yr {
      <=> ?Yl
      consumed_ARG = ?r
      gov_id = ?MainV.id
      dlex = ?dY
      bottom = "yes"
    }
    I-> ?Xr {
      <=> ?Xl
      consumed_ARG = "A1"
      gov_id = ?Yl.id
      dlex = ?dX
      include = bubble_of_sibling_II
    }
  }
}

// ?Yl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Yl }
// ?MainV hasn't already been used by another rel  rule
¬ ( rc:?MainVr {rc:consumed_ATTR=?r2 } & ?r2 == ?r )
  ]
]

/*New set of rules to substitute node_dep_arg_lexicon_lex_Oper_II_JJ and node_dep_arg_lexicon_lex_Oper_I_JJ (they only covered Oper1 = "be")
They are a combination of these two rules and the Oper rules in transfer_node_ROOT
Only Oper1_lexicon and Oper1_default for now, but more may be needed*/
Sem<=>DSynt node_dep_arg_lexicon_lex_Oper1_lexicon_COORD : transfer_node_arg
[
  leftside = [
c:?MainV {
  c:lex = ?MainVlex
  //See IN rule below
  ¬( c:pos = "IN" | c:pos = "TO" | c:pos = "CC"  )
  //¬c:main_rheme = "yes"
  ?r-> ?Yl {
    sem = ?dY
    c:lex = ?lexY
    ( c:pos = "JJ" | c:pos = "RB" )
    A1-> ?Xl {}
  }
}

// Testing new set of rules on MindSpaces 
project_info.project.name.MindSpaces

// In case the input contains DSynt Relations already
(?r == "A1" | ?r == "A2" | ?r == A0 | ?r == A1 | ?r == A2 | ?r == A3 | ?r == A4 | ?r == A5 | ?r == A6 | ?r == AM)
// ?r maps to an argumental relation
lexicon.?MainVlex.gp.?r.?DSyntR
¬?DSyntR == ATTR
¬?DSyntR == APPEND
¬?DSyntR == COORD

// if there are several possible X, only take one (the one with the smallest id0?)
¬ ( ?Yl { c:A1-> c:?Xl2 { c:id0 = ?id2 } } & ?Xl { c:id0 = ?id } & ¬?id == ?id2 & ?id > ?id2 )

lexicon.?lexY.Oper1.?lexOper
lexicon.?lexOper.lemma.?lemma
lexicon.?lexOper.spos.?spos

// The dependent is  a coordinating conjunction
c:?Xl { c:pos = "CC" c:?a1-> ?Conjunct { c:sem = ?d2 } }
 ( ?a1 == "A1" | ?a1 == A1 )
  ]
  mixed = [

  ]
  rightside = [
rc:?MainVr {
  rc:<=> ?MainV
  ¬rc:top = "yes"
  ?DSyntR-> ?Oper1 {
    <=> ?Yl
    pos = "VB"
    spos = "VV"
    finiteness = "FIN"
    dlex = ?lemma
    lex = ?lexOper
    include = bubble_of_dep
    id = #randInt()#
    type = "support_verb_noIN"
    top = "yes"
    II-> ?Yr {
      <=> ?Yl
      consumed_ARG = ?r
      gov_id = ?MainV.id
      dlex = ?dY
      bottom = "yes"
    }
    I-> ?Xr {
      <=> ?Xl
      consumed_ARG = "A1"
      gov_id = ?Yl.id
      dlex = ?dX
      include = bubble_of_sibling_II
    }
  }
}

// ?Yl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Yl }
// ?MainV hasn't already been used by another rel  rule
¬ ( rc:?MainVr {rc:consumed_ATTR=?r2 } & ?r2 == ?r )
  ]
]

/*RULES IN COMBINATION WITH COORD MISSING! e.g. PTB_train #13526
we consume the A1 and the Node5 although it is not excluded from dep_arg_lexicon_lex because no adjective has GP for now,
 so there is no risk of overlap.
Update: what about Node5? updated put a c: for now cos I saw the overlap 160929_MS_6eb17f8 #31
Update: what about A1? updated put a c: for now cos I saw the overlap PTB_train #11676
Separate II and I, cos sometimes I is built twice... (PTB_train_14395)*/
Sem<=>DSynt node_dep_arg_lexicon_lex_Oper_II_JJ : transfer_node_arg
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  //See IN rule below
  ¬( c:pos = "IN" | c:pos = "TO" | c:pos = "CC"  )
  //¬c:main_rheme = "yes"
  ?r-> ?Yl {
    sem = ?d
    ( c:pos = "JJ" | c:pos = "RB" )
    c:A1-> c:?Node5l {
      c:sem = ?dn5
    }
  }
}

//Testing new set of rules on MindSpaces 
¬project_info.project.name.MindSpaces

//In case the input contains DSynt Relations already
(?r == "A1" | ?r == "A2" | ?r == A0 | ?r == A1 | ?r == A2 | ?r == A3 | ?r == A4 | ?r == A5 | ?r == A6 | ?r == AM)
// ?r maps to an argumental relation
lexicon.?lex.gp.?r.?DSyntR
¬?DSyntR == ATTR
¬?DSyntR == APPEND
¬?DSyntR == COORD

// if there are several possible Node5, only take one (the one with the smallest id0?)
¬ ( ?Yl { c:A1-> c:?Node6 { c:id0 = ?id6 } } & c:?Node5l { c:id0 = ?id5 } & ¬?id5 == ?id6 & ?id5 > ?id6 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top = "yes"
  ?DSyntR-> ?Oper1 {
    pos = "VB"
    spos = "VV"
    finiteness = "FIN"
    dlex = "be"
    include = bubble_of_gov
    II-> ?Yr {
      <=> ?Yl
      consumed_ARG = ?r
      gov_id = ?Xl.id
      dlex = ?d
    //pos = ?pos
    //lex = #?d+_+?pos+_+?pv#
    }
    //I-> ?Node5r {
      //<=> ?Node5l
      //consumed_ARG = "A1"
      //gov_id = ?Yl.id
      //dlex = ?dn5
      //include = bubble_of_sibling_II
    //pos = ?pos
    //lex = #?d+_+?pos+_+?pv#
    //}
  }
}

// ?Yl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Yl }
// ?Xl hasn't already been used by another rel  rule
¬ ( rc:?Xr {rc:consumed_ATTR=?s } & ?s == ?r )
  ]
]

/*RULES IN COMBINATION WITH COORD MISSING! e.g. PTB_train #13526
we consume the A1 and the Node5 although it is not excluded from dep_arg_lexicon_lex because no adjective has GP for now,
 so there is no risk of overlap.
Update: what about Node5? updated put a c: for now cos I saw the overlap 160929_MS_6eb17f8 #31
Update: what about A1? updated put a c: for now cos I saw the overlap PTB_train #11676
Separate II and I, cos sometimes I is built twice... (PTB_train_14395)*/
Sem<=>DSynt node_dep_arg_lexicon_lex_Oper_I_JJ : transfer_node_arg
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  //See IN rule below
  ¬( c:pos = "IN" | c:pos = "TO" | c:pos = "CC"  )
  //¬c:main_rheme = "yes"
  c:?r-> ?Yl {
    c:sem = ?d
    ( c:pos = "JJ" | c:pos = "RB" )
    A1-> ?Node5l {
      sem = ?dn5
    }
  }
}

//Testing new set of rules on MindSpaces 
¬project_info.project.name.MindSpaces

//In case the input contains DSynt Relations already
(?r == "A1" | ?r == "A2" | ?r == A0 | ?r == A1 | ?r == A2 | ?r == A3 | ?r == A4 | ?r == A5 | ?r == A6 | ?r == AM)
// ?r maps to an argumental relation
lexicon.?lex.gp.?r.?DSyntR
¬?DSyntR == ATTR
¬?DSyntR == APPEND
¬?DSyntR == COORD

// if there are several possible Node5, only take one (the one with the smallest id0?)
¬ ( ?Yl { c:A1-> c:?Node6 { c:id0 = ?id6 } } & c:?Node5l { c:id0 = ?id5 } & ¬?id5 == ?id6 & ?id5 > ?id6 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top = "yes"
  rc:?DSyntR-> rc:?Oper1 {
    rc:II-> rc:?Yr {
    }
    I-> ?Node5r {
      <=> ?Node5l
      consumed_ARG = "A1"
      gov_id = ?Yl.id
      dlex = ?dn5
      include = bubble_of_sibling_II
    }
  }
}

// ?Yl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Node5l }
// ?Xl hasn't already been used by another rel  rule
¬ ( rc:?Xr {rc:consumed_ATTR=?s } & ?s == "A1" )
  ]
]

/*If the dependent is in the lexicon. BUG INHERITANCE DICO*/
Sem<=>DSynt node_dep_arg_lexicon_lex_ECM : transfer_node_arg
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  c:sem = ?sem
  //See IN rule below
  ¬( c:pos = "IN" | c:pos = "TO" )
  //¬c:main_rheme = "yes"
  ?r-> ?Yl {
    c:lex = ?lex1
    c:pos = "VB"
    sem = ?d
    ?q-> ?Dep {
      sem = ?semDep
    }
  }
}

//In case the input contains DSynt Relations already
(?r == "A1" | ?r == "A2" | ?r == A0 | ?r == A1 | ?r == A2 | ?r == A3 | ?r == A4 | ?r == A5 | ?r == A6 | ?r == AM)
// ?r maps to an argumental relation
lexicon.?lex.gp.?r.II

control_raise.ECM.lex.?sem
lexicon.?lex1.gp.?q.I

// The dependent is not a cordinating conjunction
¬ ( ?Dep { c:pos = "CC" c:?a1-> c:?Conjunct {} } & (?a1 == "A1" | ?a1 == A1 ) )

// to avoid overlaps with rasing verbs, limit application to predicates that have a first argument (only need can be ECM and raising now)
( ( c:?Xl { c:?r4-> c:?N4 {} } & lexicon.?lex.gp.?r4.I ) | ¬?Xl.sem == "need" )

// the governor cannot already have an argument 3
¬ ( c:?Xl {c:?r2-> c:?N2 {} } & lexicon.?lex.gp.?r2.III )

// there isn't already a semantic relation betweeen the ECM verb and the dep of the embedded verb
// enough until A2?
¬ ( c:?Xl {c:?r3-> c:?Dep {} } & 
 (?r3 == "A1" | ?r3 == "A2" | ?r3 == A0 | ?r3 == A1 | ?r3 == A2 ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top = "yes"
  II-> ?DepR {
  <=> ?Dep
  consumed_ARG = ?q
  gov_id = ?Yl.id
  dlex = ?semDep
  }
  III-> ?Yr {
    <=> ?Yl
    consumed_ARG = ?r
    gov_id = ?Xl.id
    dlex = ?d
    finiteness = "INF"
    //pos = ?pos
    //lex = #?d+_+?pos+_+?pv#
  }
}

// ?Yl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Yl }
// ?Xl hasn't already been used by another rel  rule
¬ ( rc:?Xr {rc:consumed_ATTR=?s } & ?s == ?r )
  ]
]

/*If the dependent is in the lexicon. BUG INHERITANCE DICO*/
Sem<=>DSynt node_dep_arg_lexicon_lex_ECM_COORD : transfer_node_arg
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  c:sem = ?sem
  //See IN rule below
  ¬( c:pos = "IN" | c:pos = "TO" )
  //¬c:main_rheme = "yes"
  ?r-> ?Yl {
    c:lex = ?lex1
    c:pos = "VB"
    sem = ?d
    ?q-> c:?Dep {
      c:pos = "CC"
      c:?a1-> ?Conjunct {
        sem = ?semDep
      }
    }
  }
}

//In case the input contains DSynt Relations already
(?r == "A1" | ?r == "A2" | ?r == A0 | ?r == A1 | ?r == A2 | ?r == A3 | ?r == A4 | ?r == A5 | ?r == A6 | ?r == AM)

(?a1 == "A1" | ?a1 == A1 )

// ?r maps to an argumental relation
lexicon.?lex.gp.?r.II

control_raise.ECM.lex.?sem
lexicon.?lex1.gp.?q.I

// to avoid overlaps with rasing verbs, limit application to predicates that have a first argument
( c:?Xl { c:?r4-> c:?N4 {} } & lexicon.?lex.gp.?r4.I )

//In case there are two first arguments, don't try to apply this rule
¬ ( c:?Xl { c:?r4-> c:?N5 { c:id = ?id5 } } & c:?N4l {c:id = ?id4 } & ¬?id5 == ?id4 )

// the governor cannot already have an argument 3
¬ ( c:?Xl {c:?r2-> c:?N2 {} } & lexicon.?lex.gp.?r2.III )

// there isn't already a semantic relation betweeen the ECM verb and the dep of the embedded verb
// enough until A2?
¬ ( c:?Xl {c:?r3-> c:?Dep {} } & 
 (?r3 == "A1" | ?r3 == "A2" | ?r3 == A0 | ?r3 == A1 | ?r3 == A2 ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top = "yes"
  II-> ?DepR {
  <=> ?Conjunct
  consumed_ARG = ?q
  gov_id = ?Yl.id
  dlex = ?semDep
  }
  III-> ?Yr {
    <=> ?Yl
    consumed_ARG = ?r
    gov_id = ?Xl.id
    dlex = ?d
    finiteness = "INF"
    //pos = ?pos
    //lex = #?d+_+?pos+_+?pv#
  }
}

// ?Yl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Yl }
// ?Xl hasn't already been used by another rel  rule
¬ ( rc:?Xr {rc:consumed_ATTR=?s } & ?s == ?r )
  ]
]

/*If the dependent is in the lexicon. BUG INHERITANCE DICO*/
Sem<=>DSynt node_dep_arg_lexicon_lex_raising : transfer_node_arg
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  c:sem = ?sem
  //See IN rule below
  ¬( c:pos = "IN" | c:pos = "TO" )
  //¬c:main_rheme = "yes"
  ?r-> ?Yl {
    c:lex = ?lex1
    c:pos = "VB"
    sem = ?d
    ?q-> ?Dep {
      sem = ?semDep
    }
  }
}

//In case the input contains DSynt Relations already
(?r == "A1" | ?r == "A2" | ?r == A0 | ?r == A1 | ?r == A2 | ?r == A3 | ?r == A4 | ?r == A5 | ?r == A6 | ?r == AM)
// ?r maps to an argumental relation
lexicon.?lex.gp.?r.II

control_raise.raising.lex.?sem
lexicon.?lex1.gp.?q.I

// The dependent is not a cordinating conjunction
¬ ( ?Dep { c:pos = "CC" c:?a1-> c:?Conjunct {} } & (?a1 == "A1" | ?a1 == A1 ) )

// the governor cannot already have an argument 1
¬ ( c:?Xl {c:?r2-> c:?N2 {} } & lexicon.?lex.gp.?r2.I )

// there isn't already a semantic relation betweeen the ECM verb and the dep of the embedded verb
// enough until A2?
¬ ( c:?Xl {c:?r3-> c:?Dep {} } & 
 (?r3 == "A1" | ?r3 == "A2" | ?r3 == A0 | ?r3 == A1 | ?r3 == A2 ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top = "yes"
  I-> ?DepR {
  <=> ?Dep
  consumed_ARG = ?q
  gov_id = ?Yl.id
  dlex = ?semDep
  }
  II-> ?Yr {
    <=> ?Yl
    consumed_ARG = ?r
    gov_id = ?Xl.id
    dlex = ?d
    finiteness = "INF"
    //pos = ?pos
    //lex = #?d+_+?pos+_+?pv#
  }
}

// ?Yl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Yl }
// ?Xl hasn't already been used by another rel  rule
¬ ( rc:?Xr {rc:consumed_ATTR=?s } & ?s == ?r )
  ]
]

/*If the dependent is in the lexicon. BUG INHERITANCE DICO*/
Sem<=>DSynt node_dep_arg_lexicon_lex_raising_COORD : transfer_node_arg
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  c:sem = ?sem
  //See IN rule below
  ¬( c:pos = "IN" | c:pos = "TO" )
  //¬c:main_rheme = "yes"
  ?r-> ?Yl {
    c:lex = ?lex1
    c:pos = "VB"
    sem = ?d
    ?q-> c:?Dep {
      c:pos = "CC"
      c:?a1-> ?Conjunct {
      sem = ?semDep
      }
    }
  }
}

//In case the input contains DSynt Relations already
(?r == "A1" | ?r == "A2" | ?r == A0 | ?r == A1 | ?r == A2 | ?r == A3 | ?r == A4 | ?r == A5 | ?r == A6 | ?r == AM)

(?a1 == "A1" | ?a1 == A1 )

// ?r maps to an argumental relation
lexicon.?lex.gp.?r.II

control_raise.raising.lex.?sem
lexicon.?lex1.gp.?q.I

// the governor cannot already have an argument 1
¬ ( c:?Xl {c:?r2-> c:?N2 {} } & lexicon.?lex.gp.?r2.I )

// there isn't already a semantic relation betweeen the ECM verb and the dep of the embedded verb
// enough until A2?
¬ ( c:?Xl {c:?r3-> c:?Dep {} } & 
 (?r3 == "A1" | ?r3 == "A2" | ?r3 == A0 | ?r3 == A1 | ?r3 == A2 ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top = "yes"
  I-> ?DepR {
  <=> ?Conjunct
  consumed_ARG = ?q
  gov_id = ?Yl.id
  dlex = ?semDep
  }
  II-> ?Yr {
    <=> ?Yl
    consumed_ARG = ?r
    gov_id = ?Xl.id
    dlex = ?d
    finiteness = "INF"
    //pos = ?pos
    //lex = #?d+_+?pos+_+?pv#
  }
}

// ?Yl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Yl }
// ?Xl hasn't already been used by another rel  rule
¬ ( rc:?Xr {rc:consumed_ATTR=?s } & ?s == ?r )
  ]
]

/*For prepositions that are not in the lexicon!
instead of editing manually the lexicon (which is built automatically), I prefer having a rule covering for this.

EDIT: the condition that checks in the lexicon if the preposition exists costs a lot of time (about 1/2 sec).
Hence, this rule is now applied to all prepositions.*/
Sem<=>DSynt node_dep_arg_lexicon_lex_IN : transfer_node_arg
[
  leftside = [
c:?Xl {
  //c:lex = ?lex
  ( c:pos = "IN" | c:pos = "TO" )
  ?r-> ?Yl {
    sem = ?d
  }
}

//In case the input contains DSynt Relations already
//(?r == A0 | ?r == A1 | ?r == A2 | ?r == A3 | ?r == A4 | ?r == A5 | ?r == A6 | ?r == AM)

// for some reason I have to use another variable here... VERY COSTLY CONDITION! see comments
//¬(lexicon.?lex2 & ?lex2 == ?lex)
//.gp.?r.?DSyntR0
lexicon._preposition_.gp.?r.?DSyntR

// Already covered by ROOT_oper
¬ ( c:?Xl { c:main_rheme = "yes" } & ?r == A1 )

// ?r maps to an argumental relation
¬?DSyntR == ATTR
¬?DSyntR == APPEND
¬?DSyntR == COORD

// The dependent is not a cordinating conjunction
¬ ( ?Yl { c:pos = "CC" c:?a1-> c:?Conjunct {} } & (?a1 == "A1" | ?a1 == A1 ) )

// exclude between in POL
¬ ( language.id.iso.PL & ?r == A3 )

// see mixed field and comments
¬ ( c:?Z2l { c:id = ?idZ c:lex = ?lex2 c:?s2-> ?Yl {} } & lexicon.?lex2.gp.?s2.?DR & ( ?DR == I | ?DR == II | ?DR == III | ?DR == IV )
    & c:?Xl { c:id = ?idX } & ¬?idX == ?idZ )
  ]
  mixed = [
// there isn't already an incoming relation on ?Yl from a node that is already built (limit to argumental relations for now for safety)
// see node_dep_arg_lexicon_lex_IN_duplicate
// CONDITION DOESN'T WORK; have to duplicate rule
//¬ ( c:?Z2l { c:lex = ?lex2 c:?s2-> ?Yl {} } & lexicon.?lex2.gp.?r.?DR & ( ?DR == I | ?DR == II | ?DR == III )  & rc:?Z2r { rc:<=> ?Z2l } )
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top = "yes"
  ?DSyntR-> ?Yr {
    <=> ?Yl
    consumed_ARG = ?r
    gov_id = ?Xl.id
    dlex = ?d
    //pos = ?pos
    //lex = #?d+_+?pos+_+?pv#
  }
}

// ?Yl hasn't already been transferred by another rule; condition is slow. REALLY USEFUL?
¬rc:?NOdeR { rc:<=> ?Yl }
// ?Xl hasn't already been used by another rel  rule
¬ ( rc:?Xr {rc:consumed_ATTR=?s } & ?s == ?r )
  ]
]

/*Duplicate of the mother rule in order to compensate for the condition that doesn't work in the mixed field.
The mother rule covers cases in which there is no other incoming relation on ?Yl.
This one covers cases in which there is an incoming relation but the governor of that relation is not built on the RS.*/
Sem<=>DSynt node_dep_arg_lexicon_lex_IN2 : transfer_node_arg
[
  leftside = [
c:?Xl {
  //c:lex = ?lex
  ( c:pos = "IN" | c:pos = "TO" )
  ?r-> ?Yl {
    sem = ?d
  }
}

//In case the input contains DSynt Relations already
//(?r == A0 | ?r == A1 | ?r == A2 | ?r == A3 | ?r == A4 | ?r == A5 | ?r == A6 | ?r == AM)

// for some reason I have to use another variable here... VERY COSTLY CONDITION! see comments
//¬(lexicon.?lex2 & ?lex2 == ?lex)
//.gp.?r.?DSyntR0
lexicon._preposition_.gp.?r.?DSyntR

// Already covered by ROOT_oper
¬ ( c:?Xl { c:main_rheme = "yes" } & ?r == A1 )

// ?r maps to an argumental relation
¬?DSyntR == ATTR
¬?DSyntR == APPEND
¬?DSyntR == COORD

// The dependent is not a cordinating conjunction
¬ ( ?Yl { c:pos = "CC" c:?a1-> c:?Conjunct {} } & (?a1 == "A1" | ?a1 == A1 ) )

// exclude between in POL
¬ ( language.id.iso.PL & ?r == A3 )

// see mixed field and comments
( c:?Z2l { c:id = ?idZ2 c:lex = ?lex2 c:?s2-> ?Yl {} } & lexicon.?lex2.gp.?s2.?DR & ( ?DR == I | ?DR == II | ?DR == III | ?DR == IV ) 
  & c:?Xl { c: id = ?idXl } & ¬ ?idZ2 == ?idXl )
¬ ( c:?Gov3l { c:id = ?idGov3 c:lex = ?lex3 c:?r3-> ?Yl {} }  & lexicon.?lex3.gp.?r3.?DR3 & ( ?DR3 == I | ?DR3 == II | ?DR3 == III | ?DR3 == IV )
    & ?idGov3 < ?idZ2 & ¬ ?idGov3 == ?idXl )
  ]
  mixed = [
// there isn't already an incoming relation on ?Yl from a node that is already built (limit to argumental relations for now for safety)
// see node_dep_arg_lexicon_lex_IN_duplicate
// CONDITION DOESN'T WORK; have to duplicate rule
//¬ ( c:?Z2l { c:lex = ?lex2 c:?s2-> ?Yl {} } & lexicon.?lex2.gp.?r.?DR & ( ?DR == I | ?DR == II | ?DR == III )  & rc:?Z2r { rc:<=> ?Z2l } )
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top = "yes"
  ?DSyntR-> ?Yr {
    <=> ?Yl
    consumed_ARG = ?r
    gov_id = ?Xl.id
    dlex = ?d
    //pos = ?pos
    //lex = #?d+_+?pos+_+?pv#
  }
}

// ?Yl hasn't already been transferred by another rule; condition is slow. REALLY USEFUL?
¬rc:?NOdeR { rc:<=> ?Yl }
// ?Xl hasn't already been used by another rel  rule
¬ ( rc:?Xr {rc:consumed_ATTR=?s } & ?s == ?r )

// see mixed field and comments.
// I don't think this is gonna work, since there could be more than one candidate ?Z2l
¬rc:?Z2r { rc:<=> ?Z2l }
  ]
]

/*If an argument has already been used, duplicate it!*/
Sem<=>DSynt node_dep_arg_lexicon_lex_IN_duplicate : transfer_node_arg
[
  leftside = [
c:?Xl {
  //c:lex = ?lex
  ( c:pos = "IN" | c:pos = "TO" )
  c:?r-> c:?Yl {
    c:sem = ?d
  }
}

//In case the input contains DSynt Relations already
//(?r == A0 | ?r == A1 | ?r == A2 | ?r == A3 | ?r == A4 | ?r == A5 | ?r == A6 | ?r == AM)

// for some reason I have to use another variable here... VERY COSTLY CONDITION! see comments
//¬(lexicon.?lex2 & ?lex2 == ?lex)
//.gp.?r.?DSyntR0
lexicon._preposition_.gp.?r.?DSyntR

// Already covered by ROOT_oper
¬ ( c:?Xl { c:main_rheme = "yes" } & ?r == A1 )

// ?r maps to an argumental relation
¬?DSyntR == ATTR
¬?DSyntR == APPEND
¬?DSyntR == COORD

// The dependent is not a cordinating conjunction
¬ ( ?Yl { c:pos = "CC" c:?a1-> c:?Conjunct {} } & (?a1 == "A1" | ?a1 == A1 ) )

// exclude between in POL
¬ ( language.id.iso.PL & ?r == A3 )

// there isn't already an incoming relation on ?Yl (limit to argumental relations for now for safety)
( c:?Zl { c:id = ?idZ c:lex = ?lex c:?s1-> ?Yl {} } & lexicon.?lex.gp.?s1.?DR & ( ?DR == I | ?DR == II | ?DR == III | ?DR == IV ) 
  & c:?Xl { c:id = ?idX } & ¬ ?idZ == ?idX )
¬ ( c:?Z2l { c:id = ?id2Z c:lex = ?lex2 c:?s2-> ?Yl {} } & lexicon.?lex2.gp.?s2.?DR2
    & ( ?DR2 == I | ?DR2 == II | ?DR2 == III ) & ?id2Z < ?idZ & ¬ ?id2Z == ?idX )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top = "yes"
  ¬rc:?existingRel-> rc:?ExistingYr { rc:<=> ?Yl }
  ?DSyntR-> ?Yr {
    consumed_ARG = ?r
    gov_id = ?Xl.id
    dlex = ?d
    lex = ?Yl.lex
    pos = ?Yl.pos
    spos = "UKN"
    class = ?Yl.class
    include = bubble_of_gov
    <-> rc:?NodeR { rc:<=> ?Yl }
    //pos = ?pos
    //lex = #?d+_+?pos+_+?pv#
  }
}

// ?Xl hasn't already been used by another rel  rule
¬ ( rc:?Xr {rc:consumed_ATTR=?s } & ?s == ?r )
  ]
]

/*If the dependent is in the lexicon.
The dependent is a conjunction that doesn't have another conjunction below.*/
Sem<=>DSynt node_dep_arg_lexicon_lex_COORD_A1 : transfer_node_arg
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  //See IN rule below
  ¬( c:pos = "IN" | c:pos = "TO" )
  ?r-> c:?Yl {
    c:pos = "CC"
    c:?a1-> ?Conjunct {
      sem = ?d
    }
  }
}

(?a1 == A1 | ?a1 == "A1")
//In case the input contains DSynt Relations already
(?r == A0 | ?r == A1 | ?r == A2 | ?r == A3 | ?r == A4 | ?r == A5 | ?r == A6 | ?r == AM)
// ?r maps to an argumental relation
lexicon.?lex.gp.?r.?DSyntR
¬?DSyntR == ATTR
¬?DSyntR == APPEND
¬?DSyntR == COORD

// The dependent is not a cordinating conjunction
¬ ( ?Conjunct { c:pos = "CC" c:?a2-> c:?Conjunct2 {} } & (?a2 == "A1" | ?a2 == A1 ) )
// without next condition, match overlap in semeval_eval_81
¬ ( ?Xl { c:pos = "CC" c:?a3-> c:?Conjunct3 {} } & (?a3 == "A1" | ?a3 == A1 ) )

// see transfer_node_dep_NOarg_possessive
//¬(?r == A0 & c:?Xl {¬c:main_rheme = "yes" c:sem = "possess" c:A1-> c:?OtherNode {}})
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top = "yes"
  ?DSyntR-> ?ConjunctR {
    <=> ?Conjunct
    consumed_ARG = ?r
    gov_id = ?Xl.id
    dlex = ?d
    //pos = ?pos
    //lex = #?d+_+?pos+_+?pv#
  }
}

// ?Yl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Conjunct }
// ?Xl hasn't already been used by another rel  rule
¬ ( rc:?Xr {rc:consumed_ATTR=?s } & ?s == ?r )
  ]
]

/*If double coord. Boom!
The dependent is a conjunction that has another conjunction below.*/
Sem<=>DSynt node_dep_arg_lexicon_lex_COORD_A1_COORD : transfer_node_arg
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  //See IN rule below
  ¬( c:pos = "IN" | c:pos = "TO" )
  ?r-> c:?Yl {
    c:pos = "CC"
    c:?a1-> c:?Conjunct {
    }
  }
}

(?a1 == A1 | ?a1 == "A1")
//In case the input contains DSynt Relations already
(?r == A0 | ?r == A1 | ?r == A2 | ?r == A3 | ?r == A4 | ?r == A5 | ?r == A6 | ?r == AM)
// ?r maps to an argumental relation
lexicon.?lex.gp.?r.?DSyntR
¬?DSyntR == ATTR
¬?DSyntR == APPEND
¬?DSyntR == COORD

// The dependent is  a cordinating conjunction
( c:?Conjunct { c:pos = "CC" c:?a2-> ?Conjunct2 { sem = ?d } } & (?a2 == "A1" | ?a2 == A1 ) )

// see transfer_node_dep_NOarg_possessive
//¬(?r == A0 & c:?Xl {¬c:main_rheme = "yes" c:sem = "possess" c:A1-> c:?OtherNode {}})
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top = "yes"
  ?DSyntR-> ?Conjunct2R {
    <=> ?Conjunct2
    consumed_ARG = ?r
    gov_id = ?Xl.id
    dlex = ?d
    //pos = ?pos
    //lex = #?d+_+?pos+_+?pv#
  }
}

// ?Yl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Conjunct2 }
// ?Xl hasn't already been used by another rel  rule
¬ ( rc:?Xr {rc:consumed_ATTR=?s } & ?s == ?r )
  ]
]

/*If the dependent is in the lexicon.*/
Sem<=>DSynt node_dep_arg_lexicon_lex_COORD_A2_COORD : transfer_node_arg
[
  leftside = [
c:?Yl {
  c:pos = "CC"
  ?r-> c:?Conjunct {}
}

// applies to all conjuncts except first one
¬(?r == A1 | ?r == "A1")

// ?r maps to an argumental relation
lexicon._coordination_.gp.?r.?DSyntR
¬?DSyntR == ATTR
¬?DSyntR == APPEND
¬?DSyntR == COORD

// The dependent is a cordinating conjunction
( c:?Conjunct { c:pos = "CC" c:?a2-> ?Conjunct2 {sem = ?d} } & (?a2 == "A1" | ?a2 == A1 ) )

// see transfer_node_dep_NOarg_possessive
//¬(?r == A0 & c:?Xl {¬c:main_rheme = "yes" c:sem = "possess" c:A1-> c:?OtherNode {}})
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ?DSyntR-> ?Conjunct2R {
    <=> ?Conjunct2
    consumed_ARG = ?r
    gov_id = ?Yl.id
    dlex = ?d
    //pos = ?pos
    //lex = #?d+_+?pos+_+?pv#
  }
}

// ?Yl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Conjunct2 }
// ?Xl hasn't already been used by another rel  rule
¬ ( rc:?Yr {rc:consumed_ATTR=?s } & ?s == ?r )
  ]
]

/*For prepositions that are not in the lexicon!
instead of editing manually the lexicon (which is built automatically), I prefer having a rule covering for this.

EDIT: the condition that checks in the lexicon if the preposition exists costs a lot of time (about 1/2 sec).
Hence, this rule is now applied to all prepositions.*/
Sem<=>DSynt node_dep_arg_lexicon_lex_IN_COORD : transfer_node_arg
[
  leftside = [
c:?Xl {
  //c:lex = ?lex
  ( c:pos = "IN" | c:pos = "TO" )
  ?r-> c:?Yl {
    c:pos = "CC"
    c:?a1-> ?Conjunct {
      sem = ?d
    }
  }
}

(?a1 == "A1" | ?a1 == A1)
//In case the input contains DSynt Relations already
//(?r == A0 | ?r == A1 | ?r == A2 | ?r == A3 | ?r == A4 | ?r == A5 | ?r == A6 | ?r == AM)

// for some reason I have to use another variable here... VERY COSTLY CONDITION! see comments
//¬(lexicon.?lex2 & ?lex2 == ?lex)
//.gp.?r.?DSyntR0
lexicon._preposition_.gp.?r.?DSyntR

// ?r maps to an argumental relation
¬?DSyntR == ATTR
¬?DSyntR == APPEND
¬?DSyntR == COORD
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top = "yes"
  ?DSyntR-> ?ConjunctR {
    <=> ?Conjunct
    consumed_ARG = ?r
    gov_id = ?Xl.id
    dlex = ?d
    //pos = ?pos
    //lex = #?d+_+?pos+_+?pv#
  }
}

// ?Yl hasn't already been transferred by another rule; condition is slow. REALLY USEFUL?
¬rc:?NOdeR { rc:<=> ?Conjunct }
// ?Xl hasn't already been used by another rel  rule
¬ ( rc:?Xr {rc:consumed_ATTR=?s } & ?s == ?r )
  ]
]

/*If the dependency is DSyntRel already (remains from parsing steps)*/
Sem<=>DSynt node_dep_arg_copy_rel_NAME : transfer_node_arg
[
  leftside = [
c:?Xl {
  NAME-> ?Yl {
    sem = ?d
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top = "yes"
  NAME-> ?Yr {
    <=> ?Yl
    dlex = ?d
  }
}
// ?Yl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Yl }
  ]
]

/*Introduces a new node and a coreference with the antecedent when two preds point to the same dep.

This rule kind of overlaps with the relative rule.*/
Sem<=>DSynt node_dep_arg_coref : transfer_node_arg
[
  leftside = [
c:?Gov1l {
  c:?r1-> c:?Xl {
    ¬c:sem = "amr-unknown"
  }
}

c:?Gov2l {
  c:lex = ?lex2
  c:?r2-> c:?Xl {}
}

(?r2 == "A1" | ?r2 == "A2" | ?r2 == A0 | ?r2 == A1 | ?r2 == A2 | ?r2 == A3 | ?r2 == A4 | ?r2 == A5 | ?r2 == A6 | ?r2 == AM)
// ?r maps to an argumental relation
lexicon.?lex2.gp.?r2.?DSyntR2
¬?DSyntR2 == ATTR
¬?DSyntR == APPEND
¬?DSyntR2 == COORD

// until we have unique IDs , use node name
¬ ?Gov1l.sem == ?Gov2l.sem

// the MULTISENSOR pipeline is not ready to receive coreferring nodes yet!
¬project_info.project.name.MULTISENSOR

¬ ( ?Xl { c:pos = "CC" c:?rel2-> c:?Conjunct3 {} } & (?rel2 == A1 | ?rel2 == "A1"))
  ]
  mixed = [

  ]
  rightside = [
rc:?Gov1r {
  ¬rc:top = "yes"
  rc:<=> ?Gov1l
  rc:?DSyntR1-> rc:?Xr {
    rc:<=> ?Xl
    rc:spos = ?spos
  }
}

rc:?Gov2r {
  rc:<=> ?Gov2l
  ( rc:pos = "NN" | rc:finiteness = "GER" )
  ¬rc:has_coreferring_arg = yes
  has_coreferring_arg = yes
  // see dep_NOarg_fromArg rules
  ¬rc:in_the_closet = "yes"
  ?DSyntR2-> ?X2r {
    dlex = ?Xl.sem
    lex = ?Xl.lex
    pos = ?Xl.pos
    spos = ?spos
    NE = ?Xl.NE
    class = ?Xl.class
    //case = "GEN"
    include = bubble_of_gov
    <-> rc:?Xr {
      rc:<=> ?Xl
    }
  }
}

¬ ( rc:?Gov2r { rc:<=> ?Gov2l rc:?DSyntR3-> rc:?OtherXr { } } & ?DSyntR3 == ?DSyntR2 )

//There isn't already a relation beween Gov2 and X on the RS
¬rc:?GovG2 { rc:<=> ?Gov2l rc:?relR2-> rc:?XX22r { rc:<=> ?Xl } }
  ]
]

/*Introduces a new node and a coreference with the antecedent when two preds point to the same dep.
Special rule for possess cos this node is not generated by other rules.*/
Sem<=>DSynt node_dep_arg_coref_possess : transfer_node_arg
[
  leftside = [
c:?Gov1l {
  c:?r1-> c:?Xl {}
}

c:?Gov2l {
  c:sem = "possess"
  c:A1-> c:?Xl {}
  c:A2-> c:?Yl {}
}

// until we have unique IDs , use node name
¬ ?Gov1l.sem == ?Gov2l.sem

// only apply rule to ONE  ?Gov1l
¬ ( c:?Gov1l { c:id0 = ?id1} & c:?Gov3l { c:?r3-> c:?Xl {} c:id0 = ?id3 } & ?id3 < ?id1 )

¬ ( ?Xl { c:pos = "CC" c:?rel2-> c:?Conjunct3 {} } & (?rel2 == A1 | ?rel2 == "A1"))
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top = "yes"
  rc:spos = ?spos
}
  
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:in_the_closet = "yes"
  ¬rc:has_coreferring_arg = yes
  has_coreferring_arg = yes
  ¬rc:?r-> rc:?Xr {}
  ATTR-> ?X2r {
    dlex = ?Xl.sem
    lex = ?Xl.lex
    pos = ?Xl.pos
    spos = ?spos
    case = "GEN"
    NE = ?Xl.NE
    class = ?Xl.class
    include = bubble_of_gov
    <-> rc:?Xr {
//      rc:<=> ?Xl
    }
  }
}
  ]
]

Sem<=>DSynt node_dep_arg_COORD_2_to_n : transfer_node_arg
[
  leftside = [
c:?Andl {
  c:pos = "CC"
  c:lex = ?lex
  c:?r1-> c:?C1l {
    c:conj_num = ?c1
  }
  ?r2-> ?C2l {
    conj_num = ?c2
    sem = ?d
    ¬c:pos = "VB"
  }
}

// the second conjunct is already transferred by node_dep_arg_lexicon_lex
¬?c1 == "1"

?c2 == #?c1+1#

lexicon.?lex.lemma.?lem
  ]
  mixed = [
// When there is a coordination on a node that triggered the introduction of a lexical function on the RS, we want to introduce a support verb on the conjunct as well.
// see EN_node_dep_NOarg_lexicon_COORD_LF_default
¬ ( rc:?NodeRR { rc:<=> ?C1l rc:pos = "VB" rc:?rRR-> rc:?Yr { rc:<=> ?C1l } } )
  ]
  rightside = [
rc:?C1r {
  rc:<=> ?C1l
  ¬rc:top = "yes"
  COORD-> ?NewAnd {
    dlex = ?lem
    lex = ?lex
    pos = "CC"
    id = #randInt()#
    id0 = #randInt()#
    spos = "CC"
    include = bubble_of_gov
    II-> ?C2r {
      <=> ?C2l
      //gov_id = ?Xl.id
      dlex = ?d
      consumed_ARG = ?r2
      gov_id = ?Andl.id
    }
  }
}

// ?C2l hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?C2l}
  ]
]

Sem<=>DSynt node_dep_arg_COORD_2_to_n_VB : transfer_node_arg
[
  leftside = [
c:?Andl {
  c:pos = "CC"
  c:lex = ?lex
  c:?r1-> c:?C1l {
    c:conj_num = ?c1
  }
  ?r2-> ?C2l {
    conj_num = ?c2
    sem = ?d
    c:pos = "VB"
  }
}

// the second conjunct is already transferred by node_dep_arg_lexicon_lex
¬?c1 == "1"

?c2 == #?c1+1#

lexicon.?lex.lemma.?lem
  ]
  mixed = [
// When there is a coordination on a node that triggered the introduction of a lexical function on the RS, we want to introduce a support verb on the conjunct as well.
// see EN_node_dep_NOarg_lexicon_COORD_LF_default
//( rc:?NodeRR { rc:<=> ?C1l rc:pos = "VB" rc:?rRR-> rc:?Yr { rc:<=> ?C1l } } )
  ]
  rightside = [
rc:?C1r {
  rc:<=> ?C1l
  rc:pos = "VB"
  COORD-> ?NewAnd {
    dlex = ?lem
    lex = ?lex
    pos = "CC"
    id = #randInt()#
    id0 = #randInt()#
    spos = "CC"
    include = bubble_of_gov
    II-> ?C2r {
      <=> ?C2l
      //gov_id = ?Xl.id
      dlex = ?d
      consumed_ARG = ?r2
      gov_id = ?Andl.id
    }
  }
}

// ?C2l hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?C2l}
  ]
]

/*Rule not fully tested!!
Seems to apply twice for some reason, creating two conjs on the right. This is cleaned by the next grammar...
IMPORTANT: I did this rule on the beer dataset of USC, not well thought at all!
190521-beerTests.conll #10,11,12,13,14*/
Sem<=>DSynt node_dep_arg_COORD_2_to_n_COORD_LF_default : transfer_node_arg
[
  leftside = [
c:?Andl {
  c:pos = "CC"
  c:lex = ?lex
  c:?r1-> c:?C1l {
    conj_num = ?c1
  }
  ?r2-> c:?C2l {
    conj_num = ?c2
    sem = ?d
    ¬c:pos = "CC"
    ¬c:pos = "VB"
    c:lex = ?lexConj1
    A1-> c:?DepConj1l {
      ¬c:pos = "CC"
    }
  }
}

lexicon.miscellaneous.support_verb.Oper1.?lexOp
lexicon.?lexOp.lemma.?lemOp
lexicon.?lexOp.spos.?sposOp

// the second conjunct is already transferred by node_dep_arg_lexicon_lex
¬?c1 == "1"

?c2 == #?c1+1#

lexicon.?lex.lemma.?lem
  ]
  mixed = [

  ]
  rightside = [
rc:?C1r {
  rc:<=> ?C1l
  rc:top = "yes"
  rc:pos = "VB"
  rc:?rRR-> rc:?Yr {
    rc:<=> ?C1l
    // may be the cause of the duplication; Yr and C1r are sometimes assigned to the same node
    ¬rc:top = "yes"
  }
  COORD-> ?NewAnd {
    dlex = ?lem
    lex = ?lex
    pos = "CC"
    id = #randInt()#
    id0 = #randInt()#
    spos = "CC"
    include = bubble_of_gov
    II-> ?Oper1 {
      <=> ?C2l
      top = "yes"
      consumed_ATTR = A1
      pos = "VB"
      spos = ?sposOp
      finiteness = "FIN"
      dlex = ?lemOp
      lex = ?lexOp
      //clause_type = ?Xl.clause_type
      include = bubble_of_gov
      id = #randInt()#
      II-> ?C2r {
        <=> ?C2l
        dlex = ?d
        consumed_ARG = ?r2
        lex = ?C2l.lex
        id = ?C2l.id
        bottom = "yes"
        //gov_id = ?Andl.id
      }
      I-> ?DepConjr {
        <=> ?DepConj1l
        in_the_closet = "yes"
        //dep_id = ?Yl.id
        pos = ?DepConj1l.pos
        // 190514: spos was commented, why?
        spos = ?DepConj1l.spos
        dlex = ?DepConj1l.sem
        lex = ?DepConj1l.lex
        consumed_ARG = A1
      }
    }
  }
}

// ?C2l hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?C2l}
  ]
]

/*Seems to apply twice for some reason, creating two conjs on the right. This is cleaned by the next grammar...
IMPORTANT: I did this rule on the beer dataset of USC, not well thought at all!
190521-beerTests.conll #10,11,12,13,14*/
Sem<=>DSynt node_dep_arg_COORD_2_to_n_COORD_LF_default_CCA1 : transfer_node_arg
[
  leftside = [
c:?Andl {
  c:pos = "CC"
  c:lex = ?lex
  c:?r1-> c:?C1l {
    conj_num = ?c1
  }
  ?r2-> c:?C2l {
    conj_num = ?c2
    sem = ?d
    ¬c:pos = "CC"
    ¬c:pos = "VB"
    c:lex = ?lexConj1
    A1-> c:?DepConj1l {
      c:pos = "CC"
      c:?rcc-> c:?DepDepConj1l {}
    }
  }
}

lexicon.miscellaneous.support_verb.Oper1.?lexOp
lexicon.?lexOp.lemma.?lemOp
lexicon.?lexOp.spos.?sposOp

// the second conjunct is already transferred by node_dep_arg_lexicon_lex
¬?c1 == "1"
( ?rcc == "A1" | ?rcc == A1 )

?c2 == #?c1+1#

lexicon.?lex.lemma.?lem
  ]
  mixed = [

  ]
  rightside = [
rc:?C1r {
  rc:<=> ?C1l
  rc:top = "yes"
  rc:pos = "VB"
  rc:?rRR-> rc:?Yr {
    rc:<=> ?C1l
    ¬rc:top = "yes"
  }
  COORD-> ?NewAnd {
    dlex = ?lem
    lex = ?lex
    pos = "CC"
    id = #randInt()#
    id0 = #randInt()#
    spos = "CC"
    include = bubble_of_gov
    II-> ?Oper1 {
      <=> ?C2l
      top = "yes"
      consumed_ATTR = A1
      pos = "VB"
      spos = ?sposOp
      finiteness = "FIN"
      dlex = ?lemOp
      lex = ?lexOp
      //clause_type = ?Xl.clause_type
      include = bubble_of_gov
      id = #randInt()#
      II-> ?C2r {
        <=> ?C2l
        dlex = ?d
        consumed_ARG = ?r2
        lex = ?C2l.lex
        id = ?C2l.id
        bottom = "yes"
        //gov_id = ?Andl.id
      }
      I-> ?DepConjr {
        <=> ?DepDepConj1l
        in_the_closet = "yes"
        //dep_id = ?Yl.id
        pos = ?DepDepConj1l.pos
        // 190514: spos was commented, why?
        spos = ?DepDepConj1l.spos
        dlex = ?DepDepConj1l.sem
        lex = ?DepDepConj1l.lex
        consumed_ARG = A1
      }
    }
  }
}

// ?C2l hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?C2l}
  ]
]

Sem<=>DSynt EN_node_dep_arg_between : transfer_node_arg
[
  leftside = [
c:?Xl {
  c:sem = "between"
  c:A2-> c:?Yl {}
  c:A3-> c:?Zl {}
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top = "yes"
  rc:II-> rc:?Yr {
    rc:<=> ?Yl
    COORD-> ?Conj {
      dlex = "and"
      lex = "and_CC_01"
      pos = "CC"
      spos = "coord_conjunction"
      include = bubble_of_gov
      II-> ?Zr {
        <=> ?Zl
        dlex = ?Zl.sem
      }
    }
  }
}
  ]
]

Sem<=>DSynt EN_node_expletive : transfer_node_arg
[
  leftside = [
c:?Xl {
  c:sem = "be"
  c:lex = ?lex
  c:pos = "VB"
  c:?r-> c:?Dep {}
}

//the verb has its second argument but no first argument
lexicon.?lex.gp.?r.II
¬ (c:?Xl { c:?s-> c:?otherDep {} }
 & lexicon.?lex.gp.?s.I )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top = "yes"
  I-> ?There {
    pos = "PP"
    spos = "pronoun"
    dlex = "there"
    include = bubble_of_gov
  }
}
  ]
]

Sem<=>DSynt PL_node_dep_arg_between : transfer_node_arg
[
  leftside = [
c:?Xl {
  c:sem = "między"
  c:A2-> c:?Yl {}
  c:A3-> c:?Zl {}
}

language.id.iso.PL
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top = "yes"
  rc:II-> rc:?Yr {
    rc:<=> ?Yl
    COORD-> ?Conj {
      dlex = "a"
      lex = "a_CC_01"
      pos = "CC"
      spos = "coord_conjunction"
      include = bubble_of_gov
      II-> ?Zr {
        <=> ?Zl
        dlex = ?Zl.sem
      }
    }
  }
}
  ]
]

Sem<=>DSynt PL_node_dep_arg_between_num : transfer_node_arg
[
  leftside = [
c:?Xl {
  c:sem = "między"
  c:A2-> c:?Yl {}
  c:A3-> c:?Zl {}
}

language.id.iso.PL

( ?Yl.sem == "0" | ?Yl.sem > "0" )
( ?Zl.sem == "0" | ?Zl.sem > "0" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  COORD-> ?Conj {
    dlex = "do"
    lex = "do_IN_01"
    pos = "IN"
    spos = "preposition"
    include = bubble_of_gov
    II-> ?Zr {
      <=> ?Zl
      dlex = ?Zl.sem
    }
  }
}

¬rc:?Xr {
  rc:<=> ?Xl
}
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node.
Exclude nodes which are in the semanticon; special rules for these cases.
RULE FOR THE DEMO.
RULES FOR COORDINATIONS ARE MISSING!!!*/
Sem<=>DSynt node_dep_NOarg_Locin : transfer_node_no_arg
[
  leftside = [
?Xl {
  sem = "locative_relation"
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
// if the node has a pos, in a T2T context it must have been a real word originally (purpose is an exception in some structures)
// UPDATE: creates overlaps, obviously... refine this "purpose" thing when the case is found again
  //( ¬c:pos = ?p | sem = "purpose" )
  ¬c:pos = ?p
  A1-> c:?Yl {}
  A2-> ?Zl {
    sem = ?d2
    ¬c:pos = "IN"
    ¬c:pos = "RB"
    // see pointTime_AMR
    ¬c:date_type = ?dt
    c:lex = ?zlex
  }
}

lexicon.?zlex.Locin.?loc

lexicon.?loc.lemma.?lem
lexicon.?loc.pos.?pos

//( language.id.iso.IT | language.id.iso.ES | language.id.iso.EN )

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
¬ ( ?Zl { c:pos = "CC" c:?rel-> c:?Conjunct2 {} } & (?rel == A1 | ?rel == "A1"))
¬ ( ?Yl { c:pos = "CC" c:?rel2-> c:?Conjunct3 {} } & (?rel2 == A1 | ?rel2 == "A1"))

// RULES FOR COORDINATIONS ARE MISSING!!!
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?Wr {
    dlex = ?lem
    lex = ?loc
    pos = ?pos
    include = bubble_of_gov
    meaning = "locative_relation"
    id = #randInt()#
    II-> ?Zr {
      <=> ?Zl
      dlex = ?d2
    }
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Zl }
  ]
]

/*The argumental relation maps to a non-argumental one according to the lexicon.*/
Sem<=>DSynt node_dep_NOarg_lexicon : transfer_node_no_arg
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*These rules transfer relations when there is:
 - a meta-node that is not contained in the semanticon;
 - an elaboration node
(These nodes usually have two arguments).*/
Sem<=>DSynt node_dep_NOarg_meta_elab : transfer_node_no_arg
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*These rules transfer relations when there is a meta-node that is contained in the semanticon.*/
Sem<=>DSynt node_dep_NOarg_semantemes : transfer_node_no_arg
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*These rules transfer relations that are argumental in Sem, and that usually map to argumental rels in DSynt as well.
If a dependent has already been built by another rule, the governor of the relation becomes the dependent as an ATTR.*/
Sem<=>DSynt node_dep_NOarg_fromArg : transfer_node_no_arg
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*These rules covers the cases in which we need information form the lexicon but don't have access to it.*/
Sem<=>DSynt node_dep_NOarg_NOlexicon : transfer_node_no_arg
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*Transfers the dependent.
If the relation has already been consumed by another rule for that governor, make the dependent an APPEND.*/
Sem<=>DSynt node_dep_consumed_ATTR : transfer_node_APPEND_consumed
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  //See IN rule below
  ¬c:pos = "IN"
  ¬c:pos = "TO"
  //¬c:main_rheme = "yes"
  c:?r-> c:?Yl {
    c:sem = ?d
  }
}

// The dependent is not a cordinating conjunction
¬ ( ?Yl { c:pos = "CC" c:?a1-> c:?Conjunct {} } & (?a1 == "A1" | ?a1 == A1 ) )

// see transfer_node_dep_NOarg_possessive
//¬(?r == A0 & c:?Xl {¬c:main_rheme = "yes" c:sem = "possess" c:A1-> c:?OtherNode {}})
¬ ( ?Xl.sem == "possess" & ?Xl.type == "added" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top = "yes"
  APPEND-> ?Yr {
    <=> ?Yl
    consumed_ARG = ?r
    gov_id = ?Xl.id
    dlex = ?d
    //pos = ?pos
    //lex = #?d+_+?pos+_+?pv#
  }
}

// ?Yl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Yl }
// ?Xl has already been used by another rel  rule
( rc:?Xr {rc:consumed_ATTR=?s } & ?s == ?r )
  ]
]

/*If the relation has already been consumed by another rule for that governor, make the dependent an APPEND.*/
Sem<=>DSynt node_dep_IN_consumed_ATTR : transfer_node_APPEND_consumed
[
  leftside = [
c:?Xl {
  //c:lex = ?lex
  ( c:pos = "IN" | c:pos = "TO" )
  ?r-> ?Yl {
    sem = ?d
  }
}

// Already covered by ROOT_oper
¬ ( c:?Xl { c:main_rheme = "yes" } & ?r == A1 )

// The dependent is not a cordinating conjunction
¬ ( ?Yl { c:pos = "CC" c:?a1-> c:?Conjunct {} } & (?a1 == "A1" | ?a1 == A1 ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top = "yes"
  APPEND-> ?Yr {
    <=> ?Yl
    consumed_ARG = ?r
    gov_id = ?Xl.id
    dlex = ?d
    //pos = ?pos
    //lex = #?d+_+?pos+_+?pv#
  }
}

// ?Yl hasn't already been transferred by another rule; condition is slow. REALLY USEFUL?
¬rc:?NOdeR { rc:<=> ?Yl }
// ?Xl has already been used by another rel  rule
( rc:?Xr {rc:consumed_ATTR=?s } & ?s == ?r )
  ]
]

/*If the relation has already been consumed by another rule for that governor, make the dependent an APPEND.*/
Sem<=>DSynt node_dep_CC_consumed_ATTR : transfer_node_APPEND_consumed
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  //See IN rule below
  ¬( c:pos = "IN" | c:pos = "TO" )
  ?r-> c:?Yl {
    c:pos = "CC"
    c:?a1-> ?Conjunct {
      sem = ?d
    }
  }
}

(?a1 == A1 | ?a1 == "A1")

// ?Xl is not a coordination
lexicon.?lex.gp.?r.?DSyntR
¬?DSyntR == COORD
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top = "yes"
  APPEND-> ?ConjunctR {
    <=> ?Conjunct
    consumed_ARG = ?r
    gov_id = ?Xl.id
    dlex = ?d
    //pos = ?pos
    //lex = #?d+_+?pos+_+?pv#
  }
}

// ?Yl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Conjunct }
// ?Xl has already been used by another rel  rule
( rc:?Xr {rc:consumed_ATTR=?s } & ?s == ?r )
  ]
]

/*If the relation has already been consumed by another rule for that governor, make the dependent an APPEND.*/
Sem<=>DSynt node_dep_IN_CC_consumed_ATTR : transfer_node_APPEND_consumed
[
  leftside = [
c:?Xl {
  //c:lex = ?lex
  ( c:pos = "IN" | c:pos = "TO" )
  ?r-> c:?Yl {
    c:pos = "CC"
    c:?a1-> ?Conjunct {
      sem = ?d
    }
  }
}

(?a1 == "A1" | ?a1 == A1)
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top = "yes"
  APPEND-> ?ConjunctR {
    <=> ?Conjunct
    consumed_ARG = ?r
    gov_id = ?Xl.id
    dlex = ?d
    //pos = ?pos
    //lex = #?d+_+?pos+_+?pv#
  }
}

// ?Yl hasn't already been transferred by another rule; condition is slow. REALLY USEFUL?
¬rc:?NOdeR { rc:<=> ?Conjunct }
// ?Xl has already been used by another rel  rule
( rc:?Xr {rc:consumed_ATTR=?s } & ?s == ?r )
  ]
]

/*Transfers the dependent.
If the relation has already been consumed by another rule for that governor, make the dependent an APPEND.*/
Sem<=>DSynt node_dep_JJ_consumed_ARG : transfer_node_APPEND_consumed
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  ( c:pos = "JJ" | c:pos = "RB" )
  c:A1-> c:?Yl {
    c:sem = ?d
  }
}

// The dependent is not a cordinating conjunction
¬ ( ?Yl { c:pos = "CC" c:?a1-> c:?Conjunct {} } & (?a1 == "A1" | ?a1 == A1 ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top = "yes"
  II-> ?Yr {
    <=> ?Yl
    consumed_ARG = "A1"
    gov_id = ?Xl.id
    dlex = ?d
    //pos = ?pos
    //lex = #?d+_+?pos+_+?pv#
  }
}

// ?Yl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Yl }
// ?Xl has already been used by another rel  rule
rc:?Xr {rc:consumed_ARG=?s }
  ]
]

/*Transfers the governor.
If the relation has already been consumed by another rule for that dependent, make the dependent an APPEND.
Test rule. NOT SURE ABOUT IT AT ALL!
MISSING COMPLEMENTARY RULES (IN, CC)*/
excluded Sem<=>DSynt node_gov_consumed : transfer_node_APPEND_consumed
[
  leftside = [
c:?Xl {
  c:sem = ?d
  c:pos = "VB"
  c:A1-> c:?Yl {
    ( c:pos = "NN" | c:pos = "VB" )
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  APPEND-> ?Xr {
    <=> ?Xl
    consumed_ATTR = A1
    gov_id = ?Yl.id
    dlex = ?d
    finiteness = "GER"
  }
}

¬rc:?Node {rc:<=> ?Xl}
  ]
]

/*If the dependent is in the lexicon. BUG INHERITANCE DICO*/
excluded Sem<=>DSynt transfer_node_dep_arg_AM : node_disabled
[
  leftside = [
c:?Xl {
  AM-> ?Yl {
  sem = ?d
  c:lex = ?lex
  c:pos = ?pos
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ATTR-> ?Yr {
    <=> ?Yl
    dlex = ?d
  }
}
  ]
]

/*If the dependent is in the lexicon. BUG INHERITANCE DICO*/
excluded Sem<=>DSynt transfer_node_dep_arg_lexicon_lex_PASS_II : node_disabled
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  c:voice = "PASS"
  ?r-> ?Yl {
    sem = ?d
    //c:lex = ?lex2
    //c:pos=?pos
  }
}

// ?r maps to an argumental relation
lexicon.?lex.gp.?r.II
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  I-> ?Yr {
    <=> ?Yl
    dlex = ?d
    //pos = ?pos
    //lex = #?d+_+?pos+_+?pv#
  }
}

// The dependency hasn't already been used for building a relative
¬(rc:?Xr {rc:consumed = ?s} & ?s == ?r)
  ]
]

/*If the dependent is in the lexicon. BUG INHERITANCE DICO*/
excluded Sem<=>DSynt transfer_node_dep_arg_lexicon_lex_PASS_I : node_disabled
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  c:voice = "PASS"
  ?r-> ?Yl {
    sem = ?d
    //c:lex = ?lex2
    //c:pos=?pos
  }
}

// ?r maps to an argumental relation
lexicon.?lex.gp.?r.I
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  II-> ?Yr {
    <=> ?Yl
    dlex = ?d
    //pos = ?pos
    //lex = #?d+_+?pos+_+?pv#
  }
}

// The dependency hasn't already been used for building a relative
¬(rc:?Xr {rc:consumed = ?s} & ?s == ?r)
  ]
]

/*If the dependency is DSyntRel already (remains from parsing steps)*/
excluded Sem<=>DSynt transfer_node_dep_arg_copy_rel_CC : node_disabled
[
  leftside = [
c:?Xl {
  ¬c:?Node {}
  ?r-> ?Yl {
    c:pos = "CC"
    c:A1-> ?Conjunct {
      c:sem = ?d
    }
  }
}

//In case the input contains DSynt Relations already
¬(?r == A0 | ?r == A1 | ?r == A2 | ?r == A3 | ?r == A4 | ?r == A5 | ?r == A6 | ?r == AM)
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ?r-> ?ConjunctR {
    <=> ?Conjunct
    dlex = ?d
  }
}
// ?Yl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Conjunct }
  ]
]

/*If the dependency is DSyntRel already (remains from parsing steps)*/
excluded Sem<=>DSynt transfer_node_dep_arg_copy_rel : node_disabled
[
  leftside = [
c:?Xl {
  ¬c:?Node {}
  ?r-> ?Yl {
    sem = ?d
  }
}

//In case the input contains DSynt Relations already
¬(?r == A0 | ?r == A1 | ?r == A2 | ?r == A3 | ?r == A4 | ?r == A5 | ?r == A6 | ?r == AM)

// The dependent is not a cordinating conjunction
¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct {} } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ?r-> ?Yr {
    <=> ?Yl
    dlex = ?d
  }
}
// ?Yl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Yl }
  ]
]

/*Transfers prepositions (i) with no governor and (ii) the first argument of which is already transferred.*/
excluded Sem<=>DSynt transfer_node_prep : node_disabled
[
  leftside = [
?Xl {
  ¬c:main_rheme = "yes"
  ( c:pos = "IN" | c:pos = "TO" )
  sem = ?d
  A1-> c:?Yl {}
}

¬ c:?Gov { c:?r-> ?Xl {}}
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ATTR-> ?Xr {
    <=> ?Xl
    dlex = ?d
  }
}
  ]
]

/*If the dependent is in the lexicon.
BUG INHERITANCE DICO: doesn't work for JJ and RB*/
excluded Sem<=>DSynt transfer_node_dep_NOarg_lexicon_CC : node_disabled
[
  leftside = [
?Xl {
  ¬c:main_rheme = "yes"
  sem = ?d
  c:lex = ?lex
  c:pos = ?pos
  ?r-> c:?Yl {
  }
}

lexicon.?lex.gp.?r.?DSyntR
(?DSyntR == ATTR | ?DSyntR == COORD)

// do not transfer this relation for an adjective that is A2+ from a coordination conjunction PTB_20016
¬ ( c:?Conjunction { c:pos = "CC" c:?rel-> ?Xl {} } & ¬?rel == A1)
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ?DSyntR-> ?Xr {
    <=> ?Xl
    dlex = ?d
    pos = ?pos
    consumed_ATTR = ?r
  }
}


¬ ( rc:?Yr {rc:consumed_ARG=?s} & ?s == ?r)
  ]
]

/*Pasted from ENGLISH: use same rule for all languages?*/
Sem<=>DSynt CA_attr_finiteness_FIN_VB_dep : CA_transfer_attributes
[
  leftside = [
c:?Xl {
  c:?r-> c:?Verbl {
    c:pos = "VB"
    c:lex = ?lex
    c:?arg1-> c:?Yl {}
  }
}

language.id.iso.CA

// generic rule?
// the bottom Verb has a first or a second argument
// ( lexicon.?lex.gp.?arg1.I | lexicon.?lex.gp.?arg1.II )
// changed to first arg only, see GER_VB_dep
lexicon.?lex.gp.?arg1.I 

//¬project_info.project.name.MULTISENSOR
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:pos = "VB"
  rc:?R-> rc:?Verbr {
    rc:<=> ?Verbl
    rc:pos = "VB"
    ¬rc:finiteness = ?fff
    finiteness = "FIN"
  }
}

//contrary of INF rule for now; need to do the id thing, otherwise looks like MATE can make the confusion...
¬ ( rc:?Xr { rc:?arg-> rc:?Yr { rc:<=> ?Yl } } & ¬?Xr.id == ?Verbr.id )

//contrary of INF rule for now.
//( ( ?posR == "VB" & rc:?Xr { ¬rc:?arg-> rc:?Yr { rc:<=> ?Yl } } )
// | ( ( ?posR == "IN" | ?posR == "RB" ) & ?R == II )
//)
  ]
]

Sem<=>DSynt K_attr_gest_fen : K_attr_gestures
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

Sem<=>DSynt K_attr_gest_fex : K_attr_gestures
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

Sem<=>DSynt K_attr_gest_fin : K_attr_gestures
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

Sem<=>DSynt K_attr_gest_att : K_attr_gestures
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

Sem<=>DSynt K_attr_gest_exp : K_attr_gestures
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

Sem<=>DSynt K_attr_gest_pro : K_attr_gestures
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

Sem<=>DSynt K_attr_gest_soc : K_attr_gestures
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

Sem<=>DSynt K_attr_gest_sty : K_attr_gestures
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

Sem<=>DSynt K_attr_gest_sa : K_attr_gestures
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

/*Go get the finiteness of a verbal dependent according to the structure of the sentence.
If a verb has a tense and no finiteness, put FIN; otherwise, INF.*/
Sem<=>DSynt MS_attr_finiteness_default_FIN : MS_transfer_attributes
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  ¬c:finiteness = ?finL
}

// ONLY FOR MULTISENSOR
project_info.project.name.MULTISENSOR
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:tense = ?ten
  rc:?r-> rc:?Yr {}
  ¬rc:finiteness = ?finR
  finiteness = "FIN"
}

( ?r == I | ?r == II )
  ]
]

/*Go get the finiteness of a verbal dependent according to the structure of the sentence.
If a verb has a tense and no finiteness, put FIN; otherwise, INF.*/
Sem<=>DSynt MS_attr_finiteness_default_INF : MS_transfer_attributes
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  ¬c:finiteness = ?finL
}

// ONLY FOR MULTISENSOR
project_info.project.name.MULTISENSOR
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //rc:pos = ?pos
  // spos is added when pos is already there, so this rule applies one cluster after (good for finiteness and tense)
  rc:spos = ?pos
  ¬rc:finiteness = ?finR
  finiteness = "INF"
   (¬rc:tense = ?ten | ( ¬rc:I-> rc:?Yr {} & ¬rc:II-> rc:?Zr {} ) )
}

// there is no preposition above (except if "to"); see finiteness_GER_prep
¬ ( rc:?Kr { ¬rc:dlex = "to" rc:pos = "IN" rc:II-> rc:?Xr {} } )
  ]
]

/*Names of persons and places are supposed to bear determiners. We may be missing the needed info in the input.*/
Sem<=>DSynt EL_attr_def_DEF_NE : EL_transfer_attributes
[
  leftside = [
c:?Xl {
  c:NE = "YES"
  ¬c:definiteness = ?def
}

language.id.iso.EL

// keep here PATCH conditions to make it up for the input
( ?Xl.class == "Building" | ?Xl.class == "Location" | ?Xl.class == "Person" | ?Xl.class == "URL" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  definiteness = "DEF"
}
  ]
]

/*Names of persons and places are supposed to bear determiners. We may be missing the needed info in the input.*/
Sem<=>DSynt EL_attr_def_DEF_Date_year : EL_transfer_attributes
[
  leftside = [
c:?Locl {
  c:sem = "point_time"
  c:A2-> c:?Xl {
    c:pos = "CD"
  }
}

language.id.iso.EL
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  definiteness = "DEF"
}
  ]
]

excluded Sem<=>DSynt EL_add_dlex_default_building : EL_transfer_attributes
[
  leftside = [
c:?Yl {
  c:class = "Building"
}

language.id.iso.EL

¬ ( c:?Yl { c:lex = ?lex } & lexicon.?lex.gender.?gen )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  add_dlex = "building_NN_01"
}
  ]
]

excluded Sem<=>DSynt EL_add_dlex_default_location : EL_transfer_attributes
[
  leftside = [
c:?Yl {
  c:class = "Location"
}

language.id.iso.EL

¬ ( c:?Yl { c:lex = ?lex } & lexicon.?lex.gender.?gen )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  add_dlex = "location_NN_01"
}
  ]
]

/*BUG: if in that rule there is no correspondence with ?Xl (?Xl was not originally on the leftside), the rule applies wrongly.
See PTB_eval_10 (generation tests of 170707)*/
Sem<=>DSynt EN_attr_finiteness_FIN_VB_dep : EN_transfer_attributes
[
  leftside = [
c:?Xl {
  c:?r-> c:?Verbl {
    c:pos = "VB"
    c:lex = ?lex
    c:?arg1-> c:?Yl {}
  }
}

language.id.iso.EN

// generic rule?
// the bottom Verb has a first or a second argument
// ( lexicon.?lex.gp.?arg1.I | lexicon.?lex.gp.?arg1.II )
// changed to first arg only, see GER_VB_dep
lexicon.?lex.gp.?arg1.I 

//¬project_info.project.name.MULTISENSOR
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:pos = "VB"
  rc:?R-> rc:?Verbr {
    rc:<=> ?Verbl
    rc:pos = "VB"
    ¬rc:finiteness = ?fff
    finiteness = "FIN"
  }
}

//contrary of INF rule for now; need to do the id thing, otherwise looks like MATE can make the confusion...
¬ ( rc:?Xr { rc:?arg-> rc:?Yr { rc:<=> ?Yl } } & ¬?Xr.id == ?Verbr.id )

//contrary of INF rule for now.
//( ( ?posR == "VB" & rc:?Xr { ¬rc:?arg-> rc:?Yr { rc:<=> ?Yl } } )
// | ( ( ?posR == "IN" | ?posR == "RB" ) & ?R == II )
//)
  ]
]

Sem<=>DSynt EN_attr_finiteness_FIN_IN_dep : EN_transfer_attributes
[
  leftside = [
c:?Verbl {
  c:pos = "VB"
  c:lex = ?lex
  c:?arg1-> c:?Yl {}
}

language.id.iso.EN

// generic rule?
// the bottom Verb has a first argument
lexicon.?lex.gp.?arg1.I
  ]
  mixed = [
// see MS_attr_finiteness_default_FIN
¬ ( project_info.project.name.MULTISENSOR & ¬ rc:?Verbr { rc:<=> ?Verbl rc:tense = ?t } )
  ]
  rightside = [
rc:?Xr {
  ( rc:pos = "IN" | rc:pos = "RB" )
  rc:II-> rc:?Verbr {
    rc:<=> ?Verbl
    rc:pos = "VB"
    ¬rc:finiteness = ?fff
    finiteness = "FIN"
  }
}
  ]
]

Sem<=>DSynt EN_attr_finiteness_GER_prep : EN_transfer_attributes
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  ¬c:finiteness = ?finL
}

// ONLY FOR MULTISENSOR
¬ project_info.project.gen_type.D2T
language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  ¬rc:dlex = "to"
  ¬rc:dlex = "if"
  ¬rc:dlex = "whether"
  ( rc:pos = "IN" | rc:pos = "TO" )
  rc:II-> rc:?Xr {
    rc:<=> ?Xl
    rc:pos = ?pos
    // BUG: dunno why, when activated the rule doesn't apply
    //¬rc:finiteness = ?finR
    finiteness = "GER"
  }
}
  ]
]

Sem<=>DSynt EN_attr_finiteness_GER_VB_dep : EN_transfer_attributes
[
  leftside = [
c:?Xl {
  c:?r-> c:?Verbl {
    c:pos = "VB"
    c:lex = ?lex
    c:?arg1-> c:?Yl {}
  }
}

language.id.iso.EN

// generic rule?
// the bottom Verb has a second argument but no first
lexicon.?lex.gp.?arg1.II
¬ ( c:?Xl { c:?r2-> c:?Verb2l {}} & lexicon.?lex.gp.?r2.I )

//¬project_info.project.name.MULTISENSOR
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:pos = "VB"
  rc:?R-> rc:?Verbr {
    rc:<=> ?Verbl
    rc:pos = "VB"
    ¬rc:finiteness = ?fff
    finiteness = "GER"
  }
}

//contrary of INF rule for now; need to do the id thing, otherwise looks like MATE can make the confusion...
¬ ( rc:?Xr { rc:?arg-> rc:?Yr { rc:<=> ?Yl } } & ¬?Xr.id == ?Verbr.id )

//contrary of INF rule for now.
//( ( ?posR == "VB" & rc:?Xr { ¬rc:?arg-> rc:?Yr { rc:<=> ?Yl } } )
// | ( ( ?posR == "IN" | ?posR == "RB" ) & ?R == II )
//)
  ]
]

Sem<=>DSynt EN_attr_finiteness_GER_realPoSN : EN_transfer_attributes
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:real_pos = "NN"
  real_lex = ?lex
}

language.id.iso.EN

//¬ ( lexicon.?lex.pos.?pos & ?pos == "NN" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:pos = ?pos
  finiteness = "GER"
}
  ]
]

/*Only put INF is the first argument of the dependent verb is argument of the governing verb.*/
Sem<=>DSynt EN_attr_finiteness_INF : EN_transfer_attributes
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:?arg-> c:?Yl {}
  c:?r-> c:?Verbl {
    c:pos = "VB"
    c:lex = ?lex
    c:?arg1-> c:?Yl {}
  }
}

language.id.iso.EN

//Yl is the first argument
lexicon.?lex.gp.?arg1.I
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:?R-> rc:?Verbr {
    rc:<=> ?Verbl
    ¬rc:finiteness = ?fff
    finiteness = "INF"
  }
}
  ]
]

/*A quick guess is if there is an argument, maybe the noun is more prone to be definite...*/
Sem<=>DSynt EN_attr_def_DEF : EN_transfer_attributes
[
  leftside = [
c:?Xl {
  ( c:pos = "NN" | c:real_pos = "NN" )
  ¬c:NE = "YES"
  ¬c:definiteness = ?def
}

language.id.iso.EN
( c:?Node1l { c:sem = "go" c:?r1-> c:?Xl { c:sem = "toilet" } }
 | c:?Node2l { c:sem = "extent_time" c:A2-> c:?Xl { c:sem = "night" } }
 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:finiteness = "FIN"
  definiteness = "DEF"
}
  ]
]

/*This rule looks really bad... where does it come from?*/
excluded Sem<=>DSynt EN_attr_fin_FIN : EN_transfer_attributes
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:?r-> c:?Verbl {
    c:pos = "VB"
    c:lex = ?lex
    c:?arg1-> c:?Yl {}
  }
}

language.id.iso.EN

// generic rule?
// the bottom Verb has a first argument
lexicon.?lex.gp.?arg1.I

//contrary of INF rule for now.
¬( c:?Xl { c:?arg-> c:?Yl {} } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:?R-> rc:?Verbr {
    rc:<=> ?Verbl
    ¬rc:finiteness = ?fff
    finiteness = "FIN"
  }
}
  ]
]

/*Pasted from ENGLISH: use same rule for all languages?*/
Sem<=>DSynt ES_attr_finiteness_FIN_VB_dep : ES_transfer_attributes
[
  leftside = [
c:?Xl {
  c:?r-> c:?Verbl {
    c:pos = "VB"
    c:lex = ?lex
    c:?arg1-> c:?Yl {}
  }
}

language.id.iso.ES

// generic rule?
// the bottom Verb has a first or a second argument
// ( lexicon.?lex.gp.?arg1.I | lexicon.?lex.gp.?arg1.II )
// changed to first arg only, see GER_VB_dep
lexicon.?lex.gp.?arg1.I 

//¬project_info.project.name.MULTISENSOR
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:pos = "VB"
  rc:?R-> rc:?Verbr {
    rc:<=> ?Verbl
    rc:pos = "VB"
    ¬rc:finiteness = ?fff
    finiteness = "FIN"
  }
}

//contrary of INF rule for now; need to do the id thing, otherwise looks like MATE can make the confusion...
¬ ( rc:?Xr { rc:?arg-> rc:?Yr { rc:<=> ?Yl } } & ¬?Xr.id == ?Verbr.id )

//contrary of INF rule for now.
//( ( ?posR == "VB" & rc:?Xr { ¬rc:?arg-> rc:?Yr { rc:<=> ?Yl } } )
// | ( ( ?posR == "IN" | ?posR == "RB" ) & ?R == II )
//)
  ]
]

/*Added 05/04/2017.
An embedded verb with his first two arguments and no coreference is assigned finiteness = "FIN"*/
Sem<=>DSynt PL_attr_finiteness_struct : PL_transfer_attribute
[
  leftside = [
c:?Xl {}

// not thought through for other languages so far

language.id.iso.PL
  ]
  mixed = [

  ]
  rightside = [
rc:?GovR {
  rc:?R-> rc:?Xr {
    rc:<=> ?Xl
    rc:pos = "VB"
    finiteness = "FIN"
    rc:I-> rc:?Subj {
      // next condition bugs
      //¬rc:<-> rc:?Node {}
    }
    rc:II-> rc:?Obj {}
  }
}
  ]
]

/*when "nie" (not) modifies a verb, the accusative imposed bu this verb is changed to genitive.
This phenomenon seems restricted to the presence of "nie" and to the accusative dependent.*/
Sem<=>DSynt PL_attr_gen_nie : PL_transfer_attribute
[
  leftside = [
c:?Yl {
  c:lex = "nie_RB_01"
  c:A1-> c:?Xl {
  // commented to allow application when Oper1
    //c:?r-> c:?Zl {}
  }
}

language.id.iso.PL
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
// dunno if I'm tired or what, but with this condition activated it doesn't work...
//  rc:ATTR-> rc:?Yr {
//    rc:<=> ?Yl
//  }
  ¬rc:bottom = "yes"
  rc:II-> rc:?Zr {
    //rc:<=> ?Zl
    rc:case = "acc"
    case = "gen"
  }
}
  ]
]

/*A quick guess is if there is an argument, maybe the noun is more prone to be definite...*/
Sem<=>DSynt DE_attr_def_DEF_patch : DE_transfer_attributes
[
  leftside = [
c:?Xl {
  c:pos = "NN"
  ¬c:definiteness = ?def
}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  definiteness = "DEF"
}


( rc:?Y1r { rc:lex = "während_IN_01" rc:II -> rc:?Xr { rc:lex = "Nacht_NN_01" } }
 | rc:?Xr { rc:lex = "Haar_NN_01" }
)
  ]
]

/*For infinitive verbs that mean "the action of Ving something"*/
Sem<=>DSynt DE_attr_def_DEF_patch_VB : DE_transfer_attributes
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  ¬c:definiteness = ?def
}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:case = ?c
  ¬rc:finiteness = "FIN"
  definiteness = "DEF"
}


( rc:?Y1r { rc:pos = "IN" rc:II -> rc:?Xr { } }

)
  ]
]

/*A quick guess is if there is an argument, maybe the noun is more prone to be definite...*/
Sem<=>DSynt DE_attr_def_INDEF_patch : DE_transfer_attributes
[
  leftside = [
c:?Xl {
  c:pos = "NN"
  ¬c:definiteness = ?def
}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:dlex = "Allergie"
  definiteness = "INDEF"
}
  ]
]

/*NO determiners on composita nouns.*/
Sem<=>DSynt DE_attr_block_def : DE_transfer_attributes
[
  leftside = [
c:?Xl {}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:pos = "NN"
  rc:?s1-> rc:?Xr {
    rc:<=> ?Xl
    rc:definiteness = ?def
    definiteness = "no"
  }
}

¬?def == "no" 
( ?s1== I | ?s1 == II | ?s1 == III | ?s1 == IV | ?s1 == V )
  ]
]

/*NO determiners on composita nouns.*/
Sem<=>DSynt DE_attr_block_def2 : DE_transfer_attributes
[
  leftside = [
c:?Xl {}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:definiteness = "no"
  rc:COORD-> rc:?Conjr {
    rc:II-> rc:?Yr {
      rc:definiteness = ?def
      definiteness = "no"
    }
  }
}

¬?def == "no"
  ]
]

/*A noun in the ATTR position is assigned NOM case.*/
Sem<=>DSynt DE_attr_case_NN_attr : DE_transfer_attributes
[
  leftside = [
c:?Yl {}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  rc:pos = "VB"
  rc:ATTR-> rc:?Xr {
    rc:pos = "NN"
    case = "nom"
  }
}
  ]
]

/*When there is an indefinite second argument of a negated verb, replace "nicht" by "kein"*/
Sem<=>DSynt DE_attr_kein : DE_transfer_attributes
[
  leftside = [
c:?Xl {}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Vr {
  rc:definiteness = "INDEF"
  definiteness = "NEG"
  rc:ATTR-> rc:?Neg {
    rc:dlex = "nicht"
    blocked = "YES"
  }
  rc:II-> rc:?Xr {
    rc:<=> ?Xl
  }
}
  ]
]

/*A quick guess is if there is an argument, maybe the noun is more prone to be definite...*/
Sem<=>DSynt DE_attr_num_PL_probleme : DE_transfer_attributes
[
  leftside = [
c:?Xl {
  c:pos = "NN"
  ¬c:number = ?n
}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:dlex = "haben"
  rc:II-> rc:?Xr {
    rc:<=> ?Xl
    rc:dlex = "Problem"
    number = "PL"
  }
}
  ]
]

Sem<=>DSynt DE_attr_fin_FIN_VB_dep : DE_transfer_attributes
[
  leftside = [
c:?Verbl {
  c:pos = "VB"
  c:lex = ?lex
  c:?arg1-> c:?Yl {}
}

language.id.iso.DE

// generic rule?
// the bottom Verb has a first or a second argument
( lexicon.?lex.gp.?arg1.I)
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:pos = "VB"
  rc:?R-> rc:?Verbr {
    rc:<=> ?Verbl
    rc:pos = "VB"
    ¬rc:finiteness = ?fff
    finiteness = "FIN"
  }
}

//contrary of INF rule for now; need to do the id thing, otherwise looks like MATE can make the confusion...
¬ ( rc:?Xr { rc:?arg-> rc:?Yr { rc:<=> ?Yl } } & ¬?Xr.id == ?Verbr.id )

//contrary of INF rule for now.
//( ( ?posR == "VB" & rc:?Xr { ¬rc:?arg-> rc:?Yr { rc:<=> ?Yl } } )
// | ( ( ?posR == "IN" | ?posR == "RB" ) & ?R == II )
//)
  ]
]

excluded Sem<=>DSynt DE_attr_case_percolate : DE_transfer_attributes
[
  leftside = [
c:?Yl {}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  ¬rc:finiteness = "FIN"
  rc:pos = "VB"
  rc:case = ?case
  rc:II-> rc:?Yr {
    rc:<=> ?Yl
    case = ?case
  }
}
  ]
]

/*Pasted from ENGLISH: use same rule for all languages?*/
Sem<=>DSynt PT_attr_finiteness_FIN_VB_dep : PT_transfer_attributes
[
  leftside = [
c:?Xl {
  c:?r-> c:?Verbl {
    c:pos = "VB"
    c:lex = ?lex
    c:?arg1-> c:?Yl {}
  }
}

language.id.iso.PT

// generic rule?
// the bottom Verb has a first or a second argument
// ( lexicon.?lex.gp.?arg1.I | lexicon.?lex.gp.?arg1.II )
// changed to first arg only, see GER_VB_dep
lexicon.?lex.gp.?arg1.I 

//¬project_info.project.name.MULTISENSOR
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:pos = "VB"
  rc:?R-> rc:?Verbr {
    rc:<=> ?Verbl
    rc:pos = "VB"
    ¬rc:finiteness = ?fff
    finiteness = "FIN"
  }
}

//contrary of INF rule for now; need to do the id thing, otherwise looks like MATE can make the confusion...
¬ ( rc:?Xr { rc:?arg-> rc:?Yr { rc:<=> ?Yl } } & ¬?Xr.id == ?Verbr.id )

//contrary of INF rule for now.
//( ( ?posR == "VB" & rc:?Xr { ¬rc:?arg-> rc:?Yr { rc:<=> ?Yl } } )
// | ( ( ?posR == "IN" | ?posR == "RB" ) & ?R == II )
//)
  ]
]

excluded Sem<=>DSynt attr_dpos : attr_disabled
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

excluded Sem<=>DSynt attr_pbr : attr_disabled
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

excluded Sem<=>DSynt attr_pred : attr_disabled
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

excluded Sem<=>DSynt attr_predN : attr_disabled
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
}
  ]
]

excluded Sem<=>DSynt attr_spos_lexicon : attr_disabled
[
  leftside = [
c:?Yl {
  c:lex = ?lex
}

lexicon.?lex.spos.?spos
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  spos = ?spos
}
  ]
]

excluded Sem<=>DSynt attr_spos_numbers : attr_disabled
[
  leftside = [
c:?Yl {
  c:pos = "CD"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  spos = "number"
}
  ]
]

/*The argumental relation maps to a non-argumental one according to the lexicon.
If a conjunction only has one conjunct below, it's an append

PTB_eval_6-> Problem when two conjunctions point to the same node.*/
Sem<=>DSynt node_dep_NOarg_lexicon_basic : node_dep_NOarg_lexicon
[
  leftside = [
?Xl {
  ¬c:main_rheme = "yes"
  sem = ?d
  c:lex = ?lex
  c:pos = ?pos
  ?r-> c:?Yl {
  }
}

lexicon.?lex.gp.?r.?DSyntR

(?DSyntR == ATTR | ?DSyntR == COORD
  | ( ?DSyntR == APPEND & ¬ ( lexicon.?lex.gp.?r.?DSyntRnext & ?DSyntRnext ==ATTR ) ) )

//Only apply for coordinations that have at least two conjuncts; otherwise APPEND
// see transfer_node_dep_NOarg_lexicon_CC_1arg
¬ ( ?Xl { c:pos ="CC" } & ?r == "A1" & ¬ (?Xl {c:?r2-> c:?Conj2 {} } & ?r2 == "A2" ) )

// don't apply if ?Yl is a conjunction
¬ ( c:?Yl { c:pos ="CC" c:?r3-> c:?Conj3 {} } & (?r3 == A1 | ?r3 == "A1") )

// do not transfer this relation for an A2+ from a coordination conjunction PTB_20016
// Updated 07/2020: 200126_MindSpaces-01.conll, Str 23
¬ ( c:?Conjunction { c:pos = "CC" c:?rel-> ?Xl {} } & ¬(?rel == A1 | ?rel == "A1" | ?rel == A2 | ?rel == "A2" ))
// check also if there is not an A1 above (possible double coord, as in PTB_34071)
¬ ( c:?ConjX { c:pos = "CC" c:?rel1-> ?ConjY { c:pos = "CC" c:?rel2-> ?Xl {} } }
     & (?rel2 == A1 | ?rel2 == "A1") & ¬(?rel1 == A1 | ?rel1 == "A1"))

// There is not another element above ?Xl that has ?Yl as an argument (amr_semeval_gen_3)
¬ ( c:?Pred4 { c:*?r4-> ?Xl {} c:?s4-> c:?Yl {} } )
// There is not a another element above ?Xl; see comments in dep_arg_lexicon_lex_IN
//¬c:?Pred4 { c:?r4-> ?Xl {} }

// in D2T, we generate a relative clause, to be safer (prep groups don't always work; in particular restrictive vs descriptive modifiers)
// see node_dep_NOarg_IN_Oper
¬ ( project_info.project.gen_type.D2T
    & ?Xl { ¬c:sem = "called" ( c:pos = "IN" | c:pos = "RB" ) c:A2-> c:?Z5l {} }
    & ?Yl { ( c:pos = "NN" | c:pos = "NP" ) }
)
// See transfer_node_dep_arg_lexicon_lex_INCC_PATCH (PTB_20127)
//¬ (?ZZl { pos = "IN" ?s-> ?Xl { pos = "CC" } } & ?r == A1 )

// Don't apply if the dependent is also the dependent of another conjunction? PTB_eval_6
  ]
  mixed = [
// don't apply rule if ?Xl is the first conjunct in an inverted coordination; see COORD_invert rule; see PTB_train_6774
// BUG!  this condition prevents the rule from applying in PTB_train_15816...
//¬ ( c:?CoordConjM1 { c:?rM1-> c:?Xl {} c:?rM2-> c:?Otherl {} } & (?rM1 == A1 | ?rM1 == "A1") & (?rM2 == A2 | ?rM2 == "A2") & rc:?OtherR { rc:<=> ?Otherl } )
// hence this patch:
¬ ( c:?CoordConjM1 { c:pos = "CC" c:?rM1-> c:?Xl {} c:?rM2-> c:?Otherl {c:main_rheme = "yes"} }
     & (?rM1 == A1 | ?rM1 == "A1") & (?rM2 == A2 | ?rM2 == "A2") )
// or if the node above the A2 of the coord is a main rheme (PTB_train_34566)
¬ ( c:?CoordConjM1 { c:pos = "CC" c:?rM1-> c:?Xl {} c:?rM2-> c:?Otherl {} }
     & ?Verb9l { c:main_rheme = "yes" c:?v9-> c:?Otherl {} }
     & (?rM1 == A1 | ?rM1 == "A1") & (?rM2 == A2 | ?rM2 == "A2") )
// do not apply of there is a coordination of a node that triggered to the introduction of a lexical function on the RS (not well thought conditions)
//190521-beerTests.conll, Sent 10,11,12,13,14
¬ ( ?DSyntR == COORD & rc:?NodeRR { rc:<=> ?Yl rc:pos = "VB" rc:?rRR-> rc:?Yr { rc:<=> ?Yl } } )
  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  //¬rc:top = "yes"
  //¬rc:consumed_ARG = ?r
  ?DSyntR-> ?Xr {
    <=> ?Xl
    consumed_ATTR = ?r
    //dep_id = ?Yl.id
    dlex = ?d
    pos = ?pos
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }

// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)

// Conditions substituted for those below (it doesn't make sense to add every possible adverb and for several languages!)
// When Oper is introduced, adverbs stay on the support verb, adjectives on the base noun
// ( rc:?Yr { rc:<=> ?Yl ¬rc:top = "yes"} | ( ?pos == "RB" & ¬ ( ?d == "very" | ?d == "slightly" | ?d == "somewhat" | ?d == "highest" ) ) )
//( ¬ ?pos == "JJ" | (?pos == "JJ" & rc:?Yr { rc:<=> ?Yl ¬ rc:top = "yes" } ) )
// ( ¬ ?pos == "RB" | ?d == "very" | ?d == "slightly" | ?d == "somewhat" | ?d == "highest" 
//   | ( ?pos == "RB" & rc:?Yr { rc:<=> ?Yl ¬ rc:bottom = "yes" } )
//)

// When Oper is introduced, adjectives stay on the base noun and adverbs on the support verb
// unless the adverb modifies an adjective  (for instance "score is slightly low")
// this case should be marked in the inputs as type=RESTR to avoid having to list all the possibilities for all lggs
 ( rc:?Yr { rc:<=> ?Yl ¬rc:top = "yes"} | ( ?pos == "RB" & ¬?Xl.type == "RESTR"  ) )
( ¬ ?pos == "JJ" | (?pos == "JJ" & rc:?Yr { rc:<=> ?Yl ¬ rc:top = "yes" } ) )
 ( ¬ ?pos == "RB" | ?Xl.type == "RESTR" 
   | ( ?pos == "RB" & rc:?Yr { rc:<=> ?Yl ¬ rc:bottom = "yes" } )
)
  ]
]

/*When there is a coordination on a node that triggered the introduction of a lexical function on the RS,
 we want to introduce a support verb on the conjunct as well.
IMPORTANT: I did this rule on the beer dataset of USC, not well thought at all!
190521-beerTests.conll #10,11,12,13,14*/
Sem<=>DSynt node_dep_NOarg_lexicon_COORD_LF_default : node_dep_NOarg_lexicon
[
  leftside = [
?Xl {
  ¬c:main_rheme = "yes"
  sem = ?d
  c:lex = ?lex
  c:pos = ?pos
  ?r-> c:?Yl {
  }
  ?coord-> c:?Conj1l {
    ¬c:pos = "CC"
    ¬c:pos = "VB"
    c:lex = ?lexConj1
    A1-> c:?DepConj1l {
      ¬c:pos = "CC"
    }
  } 
}

( ?coord == "A2" | ?coord == A2 )
lexicon.?lex.gp.?r.?DSyntR
?DSyntR == COORD

lexicon.miscellaneous.support_verb.Oper1.?lexOp
lexicon.?lexOp.lemma.?lemOp
lexicon.?lexOp.spos.?sposOp

//Only apply for coordinations that have at least two conjuncts; otherwise APPEND
// see transfer_node_dep_NOarg_lexicon_CC_1arg
¬ ( ?Xl { c:pos ="CC" } & ?r == "A1" & ¬ (?Xl {c:?r2-> c:?Conj2 {} } & ?r2 == "A2" ) )

// don't apply if ?Yl is a conjunction
¬ ( c:?Yl { c:pos ="CC" c:?r3-> c:?Conj3 {} } & (?r3 == A1 | ?r3 == "A1") )

// do not transfer this relation for an A2+ from a coordination conjunction PTB_20016
¬ ( c:?Conjunction { c:pos = "CC" c:?rel-> ?Xl {} } & ¬(?rel == A1 | ?rel == "A1"))
// check also if there is not an A1 above (possible double coord, as in PTB_34071)
¬ ( c:?ConjX { c:pos = "CC" c:?rel1-> ?ConjY { c:pos = "CC" c:?rel2-> ?Xl {} } }
     & (?rel2 == A1 | ?rel2 == "A1") & ¬(?rel1 == A1 | ?rel1 == "A1"))

// There is not another element above ?Xl that has ?Yl as an argument (amr_semeval_gen_3)
¬ ( c:?Pred4 { c:*?r4-> ?Xl {} c:?s4-> c:?Yl {} } )
// There is not a another element above ?Xl; see comments in dep_arg_lexicon_lex_IN
//¬c:?Pred4 { c:?r4-> ?Xl {} }

// in D2T, we generate a relative clause, to be safer (prep groups don't always work; in particular restrictive vs descriptive modifiers)
// see node_dep_NOarg_IN_Oper
¬ ( project_info.project.gen_type.D2T
    & ?Xl { ¬c:sem = "called" ( c:pos = "IN" | c:pos = "RB" ) c:A2-> c:?Z5l {} }
    & ?Yl { ( c:pos = "NN" | c:pos = "NP" ) }
)
// See transfer_node_dep_arg_lexicon_lex_INCC_PATCH (PTB_20127)
//¬ (?ZZl { pos = "IN" ?s-> ?Xl { pos = "CC" } } & ?r == A1 )

// Don't apply if the dependent is also the dependent of another conjunction? PTB_eval_6
  ]
  mixed = [
// don't apply rule if ?Xl is the first conjunct in an inverted coordination; see COORD_invert rule; see PTB_train_6774
// BUG!  this condition prevents the rule from applying in PTB_train_15816...
//¬ ( c:?CoordConjM1 { c:?rM1-> c:?Xl {} c:?rM2-> c:?Otherl {} } & (?rM1 == A1 | ?rM1 == "A1") & (?rM2 == A2 | ?rM2 == "A2") & rc:?OtherR { rc:<=> ?Otherl } )
// hence this patch:
¬ ( c:?CoordConjM1 { c:pos = "CC" c:?rM1-> c:?Xl {} c:?rM2-> c:?Otherl {c:main_rheme = "yes"} }
     & (?rM1 == A1 | ?rM1 == "A1") & (?rM2 == A2 | ?rM2 == "A2") )
// or if the node above the A2 of the coord is a main rheme (PTB_train_34566)
¬ ( c:?CoordConjM1 { c:pos = "CC" c:?rM1-> c:?Xl {} c:?rM2-> c:?Otherl {} }
     & ?Verb9l { c:main_rheme = "yes" c:?v9-> c:?Otherl {} }
     & (?rM1 == A1 | ?rM1 == "A1") & (?rM2 == A2 | ?rM2 == "A2") )
// see beer examples    
( rc:?Yr { rc:<=> ?Yl rc:top = "yes" } | c:?Yl { c:pos = "VB" } )
  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  rc:pos = "VB"
  //rc:top = "yes"
  //¬rc:consumed_ARG = ?r
  ?DSyntR-> ?Xr {
    <=> ?Xl
    consumed_ATTR = ?r
    //dep_id = ?Yl.id
    dlex = ?d
    pos = ?pos
    lex = ?lex
    id = ?Xl.id
    II-> ?Oper1 {
      <=> ?Conj1l
      top = "yes"
      consumed_ATTR = A1
      pos = "VB"
      spos = ?sposOp
      finiteness = "FIN"
      dlex = ?lemOp
      lex = ?lexOp
      //clause_type = ?Xl.clause_type
      include = bubble_of_gov
      id = #randInt()#
      II-> ?Conjr {
        <=> ?Conj1l
        in_the_closet = "yes"
        //dep_id = ?Yl.id
        pos = ?Conj1l.pos
        // 190514: spos was commented, why?
        spos = ?Conj1l.spos
        dlex = ?Conj1l.sem
        lex = ?Conj1l.lex
        bottom = "yes"
        consumed_ARG = A1
      }
      I-> ?DepConjr {
        <=> ?DepConj1l
        in_the_closet = "yes"
        //dep_id = ?Yl.id
        pos = ?DepConj1l.pos
        // 190514: spos was commented, why?
        spos = ?DepConj1l.spos
        dlex = ?DepConj1l.sem
        lex = ?DepConj1l.lex
        //bottom = "yes"
        consumed_ARG = A1
      }
    }
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }

// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
]

/*When there is a coordination on a node that triggered the introduction of a lexical function on the RS,
 we want to introduce a support verb on the conjunct as well.
IMPORTANT: I did this rule on the beer dataset of USC, not well thought at all!
190521-beerTests.conll #10,11,12,13,14*/
Sem<=>DSynt node_dep_NOarg_lexicon_COORD_LF_default_CCA1 : node_dep_NOarg_lexicon
[
  leftside = [
// Xl should not be c:, right?
c:?Xl {
  ¬c:main_rheme = "yes"
  // sem should not be c:, right?
  c:sem = ?d
  c:lex = ?lex
  c:pos = ?pos
  // ?r should not be c:, right?
  c:?r-> c:?Yl {
  }
  ?coord-> c:?Conj1l {
    ¬c:pos = "CC"
    ¬c:pos = "VB"
    c:lex = ?lexConj1
    A1-> c:?DepConj1l {
      c:pos = "CC"
      c:?rcc-> c:?DepDepConj1l {}
    }
  } 
}

( ?rcc == "A1" | ?rcc == A1 )
( ?coord == "A2" | ?coord == A2 )
lexicon.?lex.gp.?r.?DSyntR
?DSyntR == COORD

lexicon.miscellaneous.support_verb.Oper1.?lexOp
lexicon.?lexOp.lemma.?lemOp
lexicon.?lexOp.spos.?sposOp

//Only apply for coordinations that have at least two conjuncts; otherwise APPEND
// see transfer_node_dep_NOarg_lexicon_CC_1arg
¬ ( ?Xl { c:pos ="CC" } & ?r == "A1" & ¬ (?Xl {c:?r2-> c:?Conj2 {} } & ?r2 == "A2" ) )

// don't apply if ?Yl is a conjunction
¬ ( c:?Yl { c:pos ="CC" c:?r3-> c:?Conj3 {} } & (?r3 == A1 | ?r3 == "A1") )

// do not transfer this relation for an A2+ from a coordination conjunction PTB_20016
¬ ( c:?Conjunction { c:pos = "CC" c:?rel-> ?Xl {} } & ¬(?rel == A1 | ?rel == "A1"))
// check also if there is not an A1 above (possible double coord, as in PTB_34071)
¬ ( c:?ConjX { c:pos = "CC" c:?rel1-> ?ConjY { c:pos = "CC" c:?rel2-> ?Xl {} } }
     & (?rel2 == A1 | ?rel2 == "A1") & ¬(?rel1 == A1 | ?rel1 == "A1"))

// There is not another element above ?Xl that has ?Yl as an argument (amr_semeval_gen_3)
¬ ( c:?Pred4 { c:*?r4-> ?Xl {} c:?s4-> c:?Yl {} } )
// There is not a another element above ?Xl; see comments in dep_arg_lexicon_lex_IN
//¬c:?Pred4 { c:?r4-> ?Xl {} }

// in D2T, we generate a relative clause, to be safer (prep groups don't always work; in particular restrictive vs descriptive modifiers)
// see node_dep_NOarg_IN_Oper
¬ ( project_info.project.gen_type.D2T
    & ?Xl { ¬c:sem = "called" ( c:pos = "IN" | c:pos = "RB" ) c:A2-> c:?Z5l {} }
    & ?Yl { ( c:pos = "NN" | c:pos = "NP" ) }
)
// See transfer_node_dep_arg_lexicon_lex_INCC_PATCH (PTB_20127)
//¬ (?ZZl { pos = "IN" ?s-> ?Xl { pos = "CC" } } & ?r == A1 )

// Don't apply if the dependent is also the dependent of another conjunction? PTB_eval_6
  ]
  mixed = [
// don't apply rule if ?Xl is the first conjunct in an inverted coordination; see COORD_invert rule; see PTB_train_6774
// BUG!  this condition prevents the rule from applying in PTB_train_15816...
//¬ ( c:?CoordConjM1 { c:?rM1-> c:?Xl {} c:?rM2-> c:?Otherl {} } & (?rM1 == A1 | ?rM1 == "A1") & (?rM2 == A2 | ?rM2 == "A2") & rc:?OtherR { rc:<=> ?Otherl } )
// hence this patch:
¬ ( c:?CoordConjM1 { c:pos = "CC" c:?rM1-> c:?Xl {} c:?rM2-> c:?Otherl {c:main_rheme = "yes"} }
     & (?rM1 == A1 | ?rM1 == "A1") & (?rM2 == A2 | ?rM2 == "A2") )
// or if the node above the A2 of the coord is a main rheme (PTB_train_34566)
¬ ( c:?CoordConjM1 { c:pos = "CC" c:?rM1-> c:?Xl {} c:?rM2-> c:?Otherl {} }
     & ?Verb9l { c:main_rheme = "yes" c:?v9-> c:?Otherl {} }
     & (?rM1 == A1 | ?rM1 == "A1") & (?rM2 == A2 | ?rM2 == "A2") )
// see beer examples    
( rc:?Yr { rc:<=> ?Yl rc:top = "yes" } | c:?Yl { c:pos = "VB" } )
  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  rc:pos = "VB"
  //rc:top = "yes"
  //¬rc:consumed_ARG = ?r
  ?DSyntR-> ?Xr {
    <=> ?Xl
    consumed_ATTR = ?r
    //dep_id = ?Yl.id
    dlex = ?d
    lex = ?lex
    id = ?Xl.id
    pos = ?pos
    II-> ?Oper1 {
      <=> ?Conj1l
      top = "yes"
      consumed_ATTR = A1
      pos = "VB"
      spos = ?sposOp
      finiteness = "FIN"
      dlex = ?lemOp
      lex = ?lexOp
      //clause_type = ?Xl.clause_type
      include = bubble_of_gov
      id = #randInt()#
      II-> ?Conjr {
        <=> ?Conj1l
        in_the_closet = "yes"
        //dep_id = ?Yl.id
        pos = ?Conj1l.pos
        // 190514: spos was commented, why?
        spos = ?Conj1l.spos
        dlex = ?Conj1l.sem
        lex = ?Conj1l.lex
        bottom = "yes"
        consumed_ARG = A1
      }
      I-> ?DepDepConj1r {
        <=> ?DepDepConj1l
        in_the_closet = "yes"
        //dep_id = ?Yl.id
        pos = ?DepDepConj1l.pos
        // 190514: spos was commented, why?
        spos = ?DepDepConj1l.spos
        dlex = ?DepDepConj1l.sem
        lex = ?DepDepConj1l.lex
        //bottom = "yes"
        consumed_ARG = A1
      }
    }
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }

// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
]

/*Duplicate of the mother rule in order to compensate for the condition that doesn't work in the mixed field.
The mother rule covers cases in which there is no other incoming relation on ?Yl.
This one covers cases in which there is an incoming relation but the governor of that relation is not built on the RS.
See comments in dep_arg_lexicon_lex_IN.*/
excluded Sem<=>DSynt node_dep_NOarg_lexicon_basic2 : node_dep_NOarg_lexicon
[
  leftside = [
?Xl {
  ¬c:main_rheme = "yes"
  sem = ?d
  c:lex = ?lex
  c:pos = ?pos
  ?r-> c:?Yl {
  }
}

lexicon.?lex.gp.?r.?DSyntR
(?DSyntR == ATTR | ?DSyntR == COORD)

//Only apply for coordinations that have at least two conjuncts; otherwise APPEND
// see transfer_node_dep_NOarg_lexicon_CC_1arg
¬ ( ?Xl { c:pos ="CC" } & ?r == "A1" & ¬ (?Xl {c:?r2-> c:?Conj2 {} } & ?r2 == "A2" ) )

// don't apply if ?Yl is a conjunction
¬ ( c:?Yl { c:pos ="CC" c:?r3-> c:?Conj3 {} } & (?r3 == A1 | ?r3 == "A1") )

// do not transfer this relation for an A2+ from a coordination conjunction PTB_20016
¬ ( c:?Conjunction { c:pos = "CC" c:?rel-> ?Xl {} } & ¬(?rel == A1 | ?rel == "A1"))
// check also if there is not an A1 above (possible double coord, as in PTB_34071)
¬ ( c:?ConjX { c:pos = "CC" c:?rel1-> ?ConjY { c:pos = "CC" c:?rel2-> ?Xl {} } }
     & (?rel2 == A1 | ?rel2 == "A1") & ¬(?rel1 == A1 | ?rel1 == "A1"))

// There is another element above ?Xl; see comments in dep_arg_lexicon_lex_IN
c:?Pred4 { c:?r4-> ?Xl {} }
// There is not a another element above ?Xl that has ?Yl as an argument (amr_semeval_gen_3)
¬ ( c:?Pred5 { c:*?r5-> ?Xl {} c:?s5-> c:?Yl {} } )

// See transfer_node_dep_arg_lexicon_lex_INCC_PATCH (PTB_20127)
//¬ (?ZZl { pos = "IN" ?s-> ?Xl { pos = "CC" } } & ?r == A1 )
  ]
  mixed = [
// don't apply rule if ?Xl is the first conjunct in an inverted coordination; see COORD_invert rule; see PTB_train_6774
// BUG!  this condition prevents the rule from applying in PTB_train_15816...
//¬ ( c:?CoordConjM1 { c:?rM1-> c:?Xl {} c:?rM2-> c:?Otherl {} } & (?rM1 == A1 | ?rM1 == "A1") & (?rM2 == A2 | ?rM2 == "A2") & rc:?OtherR { rc:<=> ?Otherl } )
// hence this patch:
¬ ( c:?CoordConjM1 { c:pos = "CC" c:?rM1-> c:?Xl {} c:?rM2-> c:?Otherl {c:main_rheme = "yes"} }
     & (?rM1 == A1 | ?rM1 == "A1") & (?rM2 == A2 | ?rM2 == "A2") )
// or if the node above the A2 of the coord is a main rheme (PTB_train_34566)
¬ ( c:?CoordConjM1 { c:pos = "CC" c:?rM1-> c:?Xl {} c:?rM2-> c:?Otherl {} }
     & ?Verb9l { c:main_rheme = "yes" c:?v9-> c:?Otherl {} }
     & (?rM1 == A1 | ?rM1 == "A1") & (?rM2 == A2 | ?rM2 == "A2") )
  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  //¬rc:consumed_ARG = ?r
  ?DSyntR-> ?Xr {
    <=> ?Xl
    consumed_ATTR = ?r
    //dep_id = ?Yl.id
    dlex = ?d
    pos = ?pos
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }

// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)

// ?Pred4 l hasn't already been transferred by another rule; see comments in dep_arg_lexicon_lex_IN
¬rc:?NOdeR4 { rc:<=> ?Pred4 }
  ]
]

/*The argumental relation maps to a non-argumental one according to the lexicon.
If a conjunction only has one conjunct below, it's an append*/
Sem<=>DSynt node_dep_NOarg_lexicon_COORD_A1 : node_dep_NOarg_lexicon
[
  leftside = [
?Xl {
  ¬c:main_rheme = "yes"
  sem = ?d
  c:lex = ?lex
  c:pos = ?pos
  ?r-> c:?Yl {
  }
}

lexicon.?lex.gp.?r.?DSyntR

(?DSyntR == ATTR | ?DSyntR == COORD
  | ( ?DSyntR == APPEND & ¬ ( lexicon.?lex.gp.?r.?DSyntRnext & ?DSyntRnext ==ATTR ) ) )

//Only apply for coordinations that have at least two conjuncts; otherwise APPEND
// see transfer_node_dep_NOarg_lexicon_CC_1arg
¬ ( ?Xl { c:pos ="CC" } & ?r == "A1" & ¬ (?Xl {c:?r2-> c:?Conj2 {} } & ?r2 == "A2" ) )

//apply if ?Yl is a conjunction
( c:?Yl { c:pos ="CC" c:?r3-> c:?Conj3 {} } & (?r3 == A1 | ?r3 == "A1") )

// do not transfer this relation for an A2+ from a coordination conjunction PTB_20016
¬ ( c:?Conjunction { c:pos = "CC" c:?rel-> ?Xl {} } & ¬(?rel == A1 | ?rel == "A1"))

// See transfer_node_dep_arg_lexicon_lex_INCC_PATCH (PTB_20127)
//¬ (?ZZl { pos = "IN" ?s-> ?Xl { pos = "CC" } } & ?r == A1 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Conj3R{
  rc:<=> ?Conj3
  ¬rc:top = "yes"
  //¬rc:consumed_ARG = ?r
  ?DSyntR-> ?Xr {
    <=> ?Xl
    consumed_ATTR = ?r
    //dep_id = ?Yl.id
    dlex = ?d
    pos = ?pos
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }

// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
]

/*If the second conjunct of a coord has been generated before the first one.
#PTB_train_22141
Test this rule on a larger scale. problem on PTB_22478*/
Sem<=>DSynt node_dep_NOarg_lexicon_COORD_invert : node_dep_NOarg_lexicon
[
  leftside = [
?Xl {
  ¬c:main_rheme = "yes"
  sem = ?d
  c:pos = "CC"
  ?r-> ?Yl { sem = ?sem c:pos = ?pos}
  ?s-> c:?Zl {}
}

(?r == A1 | ?r == "A1")
(?s == A2 | ?s == "A2")
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr{
  rc:<=> ?Zl
  ¬rc:top = "yes"
  COORD-> ?Xr {
    <=> ?Xl
    dlex = ?d
    pos = "CC"
    II-> ?Yr {
      <=> ?Yl
      dlex = ?sem
      pos = ?pos
      // not sure about the next line, it's a guess...
      consumed_ATTR = ?r
      }
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR1 { rc:<=> ?Xl }
¬rc:?NOdeR2 { rc:<=> ?Yl }
  ]
]

/*The argumental relation maps to a non-argumental one according to the lexicon.
If the dependent is in the lexicon.
BUG INHERITANCE DICO: doesn't work for JJ and RB*/
Sem<=>DSynt node_dep_NOarg_lexicon_CC_1arg : node_dep_NOarg_lexicon
[
  leftside = [
?Xl {
  ¬c:main_rheme = "yes"
  sem = ?d
  c:lex = ?lex
  c:pos = "CC"
  ?r-> c:?Yl {
  }
}

lexicon.?lex.gp.?r.?DSyntR

(?DSyntR == ATTR | ?DSyntR == COORD
  | ( ?DSyntR == APPEND & ¬ ( lexicon.?lex.gp.?r.?DSyntRnext & ?DSyntRnext ==ATTR ) ) )

?r == "A1"
//Only apply for coordinations that have only 1 conjunct
¬ (?Xl {c:?r2-> c:?Conj2 {} } & ?r2 == "A2" )

// don't apply if ?Yl is a conjunction
¬ ( c:?Yl { c:pos ="CC" c:?r3-> c:?Conj3 {} } & (?r3 == A1 | ?r3 == "A1") )


// There is no other candidate A1 (PTB_28872)
¬ ( ?Yl { id = ?idyl } & ?Xl { ?r4-> ?Zl {id = ?idzl } } & ?r4 =="A1" & ?idzl < ?idyl  )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  //¬rc:consumed_ARG = ?r
  APPEND-> ?Xr {
    <=> ?Xl
    consumed_ATTR = ?r
    //dep_id = ?Yl.id
    dlex = ?d
    pos = "CC"
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }

// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
]

/*The argumental relation maps to a non-argumental one according to the lexicon.
If the dependent is in the lexicon.
BUG INHERITANCE DICO: doesn't work for JJ and RB*/
Sem<=>DSynt node_dep_NOarg_lexicon_CC_1arg_COORD : node_dep_NOarg_lexicon
[
  leftside = [
?Xl {
  ¬c:main_rheme = "yes"
  sem = ?d
  c:lex = ?lex
  c:pos = "CC"
  ?r-> c:?Yl {
  }
}

lexicon.?lex.gp.?r.?DSyntR

(?DSyntR == ATTR | ?DSyntR == COORD
  | ( ?DSyntR == APPEND & ¬ ( lexicon.?lex.gp.?r.?DSyntRnext & ?DSyntRnext ==ATTR ) ) )

?r == "A1"
//Only apply for coordinations that have only 1 conjunct
¬ (?Xl {c:?r2-> c:?Conj2 {} } & ?r2 == "A2" )

// apply only if ?Yl is a conjunction
( c:?Yl { c:pos ="CC" c:?r3-> c:?Conj3 {} } & (?r3 == A1 | ?r3 == "A1") )
  ]
  mixed = [

  ]
  rightside = [
rc:?Conj3r {
  rc:<=> ?Conj3
  ¬rc:top = "yes"
  //¬rc:consumed_ARG = ?r
  APPEND-> ?Xr {
    <=> ?Xl
    consumed_ATTR = ?r
    //dep_id = ?Yl.id
    dlex = ?d
    pos = "CC"
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }

// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
]

/*The argumental relation maps to a non-argumental one according to the lexicon.
For prepositions that are not in the lexicon!
instead of editing manually the lexicon (which is built automatically), I prefer having a rule covering for this.*/
Sem<=>DSynt node_dep_NOarg_lexicon_PATCH : node_dep_NOarg_lexicon
[
  leftside = [
?Xl {
  sem = ?d
  ¬c:main_rheme = "yes"
  c:lex = ?lex
  c:pos = ?pos
  ?r-> c:?Yl {
  }
}

?pos == "IN"

// BUG order of assignment of variables (dico first, graph second)
// This one doesn't work:
//¬ lexicon.?lex.gp.?r.?DSyntR0
// This one works but is slow
//¬ ( ?lex1 == ?lex & lexicon.?lex1 ) //.gp.?r.?DSyntR0
// THIS ONE SEEMS TO WORK!
¬ ( ?Xl { c:lex = ?lex2 } & lexicon.?lex2.gp.?r.?DSyntR0 )


lexicon._preposition_.gp.?r.?DSyntR
//?lex2 == "after_IN_01"

(?DSyntR == ATTR | ?DSyntR == COORD
  | ( ?DSyntR == APPEND & ¬ ( lexicon._preposition_.gp.?r.?DSyntRnext & ?DSyntRnext ==ATTR ) ) )

// do not transfer this relation for an A2+ from a coordination conjunction (copied from below)
¬ ( c:?Conjunction { c:pos = "CC" c:?rel-> ?Xl {} } & ¬(?rel == A1 | ?rel == "A1"))
  ]
  mixed = [
// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr { rc:<=> ?Yl rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ?DSyntR-> ?Xr {
    <=> ?Xl
    consumed_ATTR = ?r
    //dep_id = ?Yl.id
    dlex = ?d
    pos = ?pos
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }
  ]
]

/*Numbers are not in the lexicon, but it is the same mechanism as the other rules of this group.*/
Sem<=>DSynt node_dep_NOarg_CD : node_dep_NOarg_lexicon
[
  leftside = [
?Xl {
  sem = ?d
  ¬c:main_rheme = "yes"
  c:pos = "CD"
  A1-> c:?Yl {
  }
}

// do not transfer this relation for A2+ from a coordination conjunction (copied from below)
¬ ( c:?Conjunction { c:pos = "CC" c:?rel-> ?Xl {} } & ¬(?rel == A1 | ?rel == "A1"))
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?Xr {
    <=> ?Xl
    consumed_ATTR = A1
    //dep_id = ?Yl.id
    dlex = ?d
    pos = "CD"
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }
// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=A1 rc:gov_id=?gid} & ?gid == ?Xl.id)
  ]
]

/*Completes the rule below (EN_node_dep_NOarg_IN_Oper_default).*/
Sem<=>DSynt node_dep_NOarg_IN_RESTR : node_dep_NOarg_lexicon
[
  leftside = [
?Xl {
  sem = ?d
  ( c:pos = "IN" | c:pos = "RB" )
  c:lex = ?lex
  c:type = "RESTR"
  ¬c:main_rheme = "yes"
  A1-> c:?Yl {
    ( c:pos = "NN" | c:pos = "NP" )
    // see node_dep_NOarg_IN_noSupportVerb
    ¬c:class = "Quantity"
  }
  A2-> ?Zl {
    sem = ?d2
  }
}

// language.id.iso.EN

// in text to text, we assume we want to regenerate the same way
project_info.project.gen_type.D2T
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR->  ?Xr {
    <=> ?Xl
    dlex = ?d
    pos = "IN"
    II-> ?Zr {
      <=> ?Zl
      dlex = ?d2
    }
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }
// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
]

/*Creates a relative clause when a prepositional group modifies a noun.
It avoids having some of the issues with descriptive VS restrictive clauses:
- The chair in the garden is blue. -> necessarily restrictive
- The chair which is in the garden is blue. -> necessarily restrictive 
- The chair, which is in the garden, is blue. -> descriptive

By choosing the third option (descriptive), we aim at lowering the amount of cases in which the generation is incorrect.
Update: we now have an attribute for controlling this in the input (type=RESTR vs type=DESCR)*/
Sem<=>DSynt EN_node_dep_NOarg_IN_Oper_default : node_dep_NOarg_lexicon
[
  leftside = [
?Xl {
  sem = ?d
  ( c:pos = "IN" | c:pos = "RB" )
  c:lex = ?lex
  ¬c:type = "RESTR"
  ¬c:main_rheme = "yes"
  A1-> c:?Yl {
    ( c:pos = "NN" | c:pos = "NP" )
    // see node_dep_NOarg_IN_noSupportVerb
    ¬c:class = "Quantity"
  }
  A2-> ?Zl {
    sem = ?d2
  }
}

¬?d == "called"

language.id.iso.EN

// in text to text, we assume we want to regenerate the same way
project_info.project.gen_type.D2T
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR->  ?Oper1 {
    <=> ?Xl
    top = "yes"
    consumed_ATTR = A1
    pos = "VB"
    spos = "VV"
    finiteness = "FIN"
    dlex = "be"
    lex = "be_VB_01"
    //clause_type = ?Xl.clause_type
    include = bubble_of_dep
    id = #randInt()#
    II-> ?Xr {
      <=> ?Xl
      in_the_closet = "yes"
      //dep_id = ?Yl.id
      dlex = ?d
      pos = "IN"
      bottom = "yes"
      II-> ?Zr {
        <=> ?Zl
        dlex = ?d2
      }
    }
    I-> ?NewYr {
        pos = ?Yl.pos
        // 190514: spos was commented, why?
        spos = ?Yl.spos
        dlex = ?Yl.sem
        lex = ?Yl.lex
        include = bubble_of_gov
        id = #randInt()#
        <-> rc:?Yr {}
    } 
  }
}
// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }
// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
]

/*Creates a relative clause when a prepositional group modifies a noun.
It avoids having some of the issues with descriptive VS restrictive clauses:
- The chair in the garden is blue. -> necessarily restrictive
- The chair which is in the garden is blue. -> necessarily restrictive 
- The chair, which is in the garden, is blue. -> descriptive

By choosing the third option (descriptive), we aim at lowering the amount of cases in which the generation is incorrect.*/
Sem<=>DSynt CA_ES_node_dep_NOarg_IN_Oper_default : node_dep_NOarg_lexicon
[
  leftside = [
?Xl {
  sem = ?d
  ( c:pos = "IN" | c:pos = "RB" )
  c:lex = ?lex
  ¬c:main_rheme = "yes"
  A1-> c:?Yl {
    ( c:pos = "NN" | c:pos = "NP" )
    // see node_dep_NOarg_IN_noSupportVerb
    ¬c:class = "Quantity"
  }
  A2-> ?Zl {
    sem = ?d2
  }
}

¬?d == "llamado"
¬?d == "anomenado"

( language.id.iso.ES | language.id.iso.CA )

// in text to text, we assume we want to regenerate the same way
project_info.project.gen_type.D2T

//missing info in the input to generate correctly; patch for WebNLG
// see node_dep_NOarg_IN_noSupportVerb
¬ ?Xl.lex == "de_IN_04"
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR->  ?Oper1 {
    <=> ?Xl
    top = "yes"
    consumed_ATTR = A1
    pos = "VB"
    spos = "copula"
    finiteness = "FIN"
    dlex = "ser"
    lex = "ser_VB_01"
    //clause_type = ?Xl.clause_type
    include = bubble_of_dep
    id = #randInt()#
    II-> ?Xr {
      <=> ?Xl
      in_the_closet = "yes"
      //dep_id = ?Yl.id
      dlex = ?d
      pos = "IN"
      bottom = "yes"
      II-> ?Zr {
        <=> ?Zl
        dlex = ?d2
      }
    }
    I-> ?NewYr {
        pos = ?Yl.pos
        // 190514: spos was commented, why?
        spos = ?Yl.spos
        dlex = ?Yl.sem
        lex = ?Yl.lex
        include = bubble_of_gov
        id = #randInt()#
        <-> rc:?Yr {}
    } 
  }
}
// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }
// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
]

/*missing info in the input to generate correctly; patch for WebNLG*/
Sem<=>DSynt node_dep_NOarg_IN_noSupportVerb : node_dep_NOarg_lexicon
[
  leftside = [
?Xl {
  sem = ?d
  ( c:pos = "IN" | c:pos = "RB" )
  c:lex = ?lex
  ¬c:main_rheme = "yes"
  A1-> c:?Yl {
    ( c:pos = "NN" | c:pos = "NP" )
  }
  A2-> ?Zl {
    sem = ?d2
  }
}

¬ ( language.id.iso.ES &?d == "llamado" )

// in text to text, we assume we want to regenerate the same way
project_info.project.gen_type.D2T

( ( language.id.iso.ES & ?Xl.lex == "de_IN_04" ) | ?Yl.class == "Quantity" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR->   ?Xr {
    <=> ?Xl
    dlex = ?d
    pos = "IN"
    bottom = "yes"
    II-> ?Zr {
      <=> ?Zl
      dlex = ?d2
    }
  }
}
// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }
// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node.

It is more probable that the A2 is a coord, so only this rule done so far.*/
Sem<=>DSynt node_dep_NOarg_meta : node_dep_NOarg_meta_elab
[
  leftside = [
?Xl {
  sem = ?d1
  A1-> c:?Yl {
  }
  A2-> ?Zl {
    sem = ?d2
  }
}
(?Xl.type == META | ?Xl.type == "added")

//See NOarg_ELAb
¬?d1 == "ELABORATION"
¬?d1 == "possess"

// For MULTISENSOR we do the same for added nodes in the semanticon
( ¬ semanticon.?d1 | ?Xl.semanteme == "realized"
  | ( language.id.iso.EN & ?Xl.sem == "frequency" & ?Zl.sem == "sometimes" )
//  | ( ?Xl.sem == "duration" & ?Zl.sem == "6 godzin"  )
  | ( language.id.iso.PL &?Xl.sem == "frequency" & ?Zl.sem == "czasami" )
  | ( language.id.iso.DE &?Xl.sem == "frequency" & ?Zl.sem == "oft" )
  | ( semanticon.?d1 & ( ( ?Zl.pos == "IN" & ¬ ( ?Zl.sem == "między" | ?Zl.sem == "zwischen" ) )
    | ?Zl.pos == "RB" ) )
)

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
¬ ( ?Zl { c:pos = "CC" c:?rel-> c:?Conjunct2 {} } & (?rel == A1 | ?rel == "A1"))
¬ ( ?Yl { c:pos = "CC" c:?rel2-> c:?Conjunct3 {} } & (?rel2 == A1 | ?rel2 == "A1"))

// NOarg_usually
¬ ( language.id.iso.PL & ?Xl.sem == "manner" & ?Zl.sem == "routine" )
// See NOarg_meta_between_PL
¬ ( language.id.iso.PL & ?Zl { sem = "między" A2-> ?ZA2l {}  A3-> ?ZA3l {} }
 & ( ?ZA2l.sem == "0" | ?ZA2l.sem > "0" ) & ( ?ZA3l.sem == "0" | ?ZA3l.sem > "0" )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?Zr {
    <=> ?Zl
    dlex = ?d2
    meaning = ?d1
  }
}

// ?Zl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Zl }
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node, and the first argument is a coordination.
#PTB_train_17717*/
Sem<=>DSynt node_dep_NOarg_meta_COORD_A1 : node_dep_NOarg_meta_elab
[
  leftside = [
?Xl {
  sem = ?d1
  A1-> c:?Yl {
    c:pos = "CC"
    c:?rel-> c:?Conjunct {}
  }
  A2-> ?Zl {
    sem = ?d2
  }
}

(?Xl.type == META | ?Xl.type == "added")
(?rel == A1 | ?rel == "A1")
//See NOarg_ELAb
¬?d1 == "ELABORATION"
// For MULTISENSOR we do the same for added nodes in the semanticon
( ¬semanticon.?d1 | ( project_info.project.name.MULTISENSOR & language.id.iso.EN & ( ?Zl.pos == "IN" | ?Zl.pos == "RB" ) ) )

// The other  dependent is not a cordinating conjunction
¬ ( ?Zl { c:pos = "CC" c:?rel2-> c:?Conjunct2 {} } & (?rel2 == A1 | ?rel2 == "A1"))
  ]
  mixed = [

  ]
  rightside = [
rc:?ConjunctR {
  rc:<=> ?Conjunct
  ¬rc:top = "yes"
  ATTR-> ?Zr {
    <=> ?Zl
    dlex = ?d2
    meaning = ?d1
  }
}
// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Zl }
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node, and the second argument is a coordination.

PTB_train_20018*/
Sem<=>DSynt node_dep_NOarg_meta_COORD_A2 : node_dep_NOarg_meta_elab
[
  leftside = [
?Xl {
  sem = ?d1
  A1-> c:?Yl {}
  A2-> c:?Zl {
    c:pos = "CC"
    c:?rel-> ?Conjunct {
      sem = ?d2
    }
  }
}

(?Xl.type == META | ?Xl.type == "added")
(?rel == A1 | ?rel == "A1")
//See NOarg_ELAb
¬?d1 == "ELABORATION"
// For MULTISENSOR we do the same for added nodes in the semanticon
( ¬semanticon.?d1
  |  ( project_info.project.name.MULTISENSOR & language.id.iso.EN & ( ?Conjunct.pos == "IN" | ?Conjunct.pos == "RB" ) ) )

// The dependent is not a cordinating conjunction
¬ ( ?Yl { c:pos = "CC" c:?rel2-> c:?Conjunct2 {} } & (?rel2 == A1 | ?rel2 == "A1"))
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?ConjunctR {
    <=> ?Conjunct
    dlex = ?d2
    meaning = ?d1
  }
}
// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Conjunct }
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node, and both arguments are a  coordination.
EXAMPLE NOT FOUND YET. NOT TESTED
*/
Sem<=>DSynt node_dep_NOarg_meta_COORD_A1A2 : node_dep_NOarg_meta_elab
[
  leftside = [
?Xl {
  sem = ?d1
  A1-> c:?Yl {
    c:pos = "CC"
    c:?rel2-> c:?Conjunct2 {}
  }
  A2-> c:?Zl {
    c:pos = "CC"
    c:?rel3-> ?Conjunct3 {
      sem = ?d3
    }
  }
}

(?Xl.type == META | ?Xl.type == "added")
(?rel2 == A1 | ?rel2 == "A1")
(?rel3 == A1 | ?rel3 == "A1")
//See NOarg_ELAb
¬?d1 == "ELABORATION"
// For MULTISENSOR we do the same for added nodes in the semanticon
( ¬semanticon.?d1 | ( project_info.project.name.MULTISENSOR & language.id.iso.EN) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Conjunct2
  ¬rc:top = "yes"
  ATTR-> ?Conjunct3R {
    <=> ?Conjunct3
    dlex = ?d3
    meaning = ?d1
  }
}
// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Conjunct3 }
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node.
Exclude nodes which are in the semanticon; special rules for these cases.
// kind of patch to not attach APPEND to verb in case of "25m above the sea level" in WebNLG*/
Sem<=>DSynt node_dep_NOarg_ELAB : node_dep_NOarg_meta_elab
[
  leftside = [
?Xl {
  sem = "ELABORATION"
  A1-> c:?Yl {
  }
  // don't undesrtand why this gives an overlap PTB_20018
  A2-> c:?Zl {
    sem = ?d2
  }
}

// don't apply if  ?Yl or ?Zl is a conjunction
¬ ( c:?Yl { c:pos ="CC" c:?r1-> c:?Conj1 {} } & (?r1 == A1 | ?r1 == "A1") )
¬ ( c:?Zl { c:pos ="CC" c:?r2-> c:?Conj2 {} } & (?r2 == A1 | ?r2 == "A1") )

// based on PTB_train_7947: only generate ELAB if A2 is not already connected to the A1 by another way
// instead, generate a relative (the double connection probably comes from there in the first place)
// See node_dep_NOarg_ELAB_newRelat
¬ ( c:?Yl { c:?r3-> c:?Z3l { c:*?s3-> c:?Zl {} } } )

// list here configurations that map to ATTR instead of APPEND
// If the dependent is an NP alone, this will probably be a simple apposition
( c:?Zl { ( ¬c:pos = "NP" | c:type = "parenthetical" | c:?dep-> c:?depZ {} ) }
  | c:?Yl { ( c:pos = "IN" | c:sem = "fat" | c:sem = "gemstone" | c:sem = "youthclub" ) } )
  ]
  mixed = [
//¬ ( project_info.project.gen_type.D2T & rc:?Yr { rc:<=> ?Yl rc:top = "yes" } )
  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  APPEND-> ?Zr {
    <=> ?Zl
    dlex = ?d2
    meaning = "ELABORATION"
  }
}
// ?Zl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Zl }

// sometimes LS nodes are built twice on RS; chose only one of them as gov
// PTB_train_22210
¬ (rc:?Tr {rc:<=> ?Yl rc:gov_id = ?gid1 }
    &rc:?Yr { rc:gov_id = ?gid2 } & ?gid1 < ?gid2 )
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node.
Exclude nodes which are in the semanticon; special rules for these cases.*/
Sem<=>DSynt node_dep_NOarg_ELAB_ATTR : node_dep_NOarg_meta_elab
[
  leftside = [
?Xl {
  sem = "ELABORATION"
  A1-> c:?Yl {
    ¬ ( c:pos = "IN" | c:sem = "fat" | c:sem = "gemstone" | c:sem = "youthclub" )
  }
  // don't undesrtand why this gives an overlap PTB_20018
  A2-> c:?Zl {
    sem = ?d2
    // If the dependent is an NP alone, this will probably be a simple apposition
    c:pos = "NP"
    ¬c:type = "parenthetical"
    ¬c:?dep-> c:?depZ {}
  }
}

// don't apply if  ?Yl or ?Zl is a conjunction
¬ ( c:?Yl { c:pos ="CC" c:?r1-> c:?Conj1 {} } & (?r1 == A1 | ?r1 == "A1") )
¬ ( c:?Zl { c:pos ="CC" c:?r2-> c:?Conj2 {} } & (?r2 == A1 | ?r2 == "A1") )

// based on PTB_train_7947: only generate ELAB if A2 is not already connected to the A1 by another way
// instead, generate a relative (the double connection probably comes from there in the first place)
// See node_dep_NOarg_ELAB_newRelat
¬ ( c:?Yl { c:?r3-> c:?Z3l { c:*?s3-> c:?Zl {} } })
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?Zr {
    <=> ?Zl
    dlex = ?d2
    meaning = "ELABORATION"
  }
}
// ?Zl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Zl }

// sometimes LS nodes are built twice on RS; chose only one of them as gov
// PTB_train_22210
¬ (rc:?Tr {rc:<=> ?Yl rc:gov_id = ?gid1 }
    &rc:?Yr { rc:gov_id = ?gid2 } & ?gid1 < ?gid2 )
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node, but the A2 already has an indirect link with the A1.
In this case, build a new node that will give rise to a relative.
PTB_train_7947*/
Sem<=>DSynt node_dep_NOarg_ELAB_newRelat : node_dep_NOarg_meta_elab
[
  leftside = [
?Xl {
  sem = "ELABORATION"
  c:A1-> c:?Yl {
  }
  // don't undesrtand why this gives an overlap PTB_20018
  c:A2-> c:?Zl {
    c:sem = ?d2
  }
}

// don't apply if  ?Yl or ?Zl is a conjunction
¬ ( c:?Yl { c:pos ="CC" c:?r1-> c:?Conj1 {} } & (?r1 == A1 | ?r1 == "A1") )
¬ ( c:?Zl { c:pos ="CC" c:?r2-> c:?Conj2 {} } & (?r2 == A1 | ?r2 == "A1") )

// there is another connection between A1 and A2
( c:?Yl { c:?r3-> c:?Z3l { c:*?s3-> c:?Zl {} } })
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:top = "yes"
  definiteness = "DEF"
  APPEND-> ?NewNode {
    <=> ?Yl
    dlex = ?dr
    pos = ?pr
    // spos = ?pr
    case = "GEN"
    id = #randInt()#
    include = bubble_of_gov
    <-> rc:?Yr {
      rc:<=> ?Yl
      rc:dlex = ?dr
      rc:pos = ?pr
    }
  }
}
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node.
The second argument of the ELAB is a coordination.
EXAMPLE NOT FOUND YET.*/
Sem<=>DSynt node_dep_NOarg_ELAB_COORD_A1 : node_dep_NOarg_meta_elab
[
  leftside = [
?Xl {
  sem = "ELABORATION"
  A1-> c:?Yl {
    c:pos = "CC"
    c:?rel-> c:?Conjunct {
    }
  }
  // don't undesrtand why this gives an overlap PTB_20018
  A2-> ?Zl {
    sem = ?d2
  }
}

// don't apply if ?Zl is a conjunction
¬ ( c:?Zl { c:pos ="CC" c:?r1-> c:?Conj1 {} } & (?r1 == A1 | ?r1 == "A1") )

(?rel == A1 | ?rel == "A1")
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Conjunct
  ¬rc:top = "yes"
  APPEND-> ?Zr {
    <=> ?Zl
    dlex = ?d2
    meaning = "ELABORATION"
  }
}
// ?Zl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Zl }
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node.
The second argument of the ELAB is a coordination.
PTB_train_13526*/
Sem<=>DSynt node_dep_NOarg_ELAB_COORD_A2 : node_dep_NOarg_meta_elab
[
  leftside = [
?Xl {
  sem = "ELABORATION"
  A1-> c:?Yl {
  }
  // don't undesrtand why this gives an overlap PTB_20018
  A2-> c:?Zl {
    c:pos = "CC"
    c:?rel-> ?Conjunct {
      sem = ?d2
    }
  }
}

// don't apply if ?Zl is a conjunction
¬ ( c:?Yl { c:pos ="CC" c:?r1-> c:?Conj1 {} } & (?r1 == A1 | ?r1 == "A1") )

(?rel == A1 | ?rel == "A1")
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  APPEND-> ?ConjunctR {
    <=> ?Conjunct
    dlex = ?d2
    meaning = "ELABORATION"
  }
}
// ?Zl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Conjunct }
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node.
Both the first and the second argument of the ELAB are a coordination.
EXAMPLE NOT FOUND YET.*/
Sem<=>DSynt node_dep_NOarg_ELAB_COORD_A1A2 : node_dep_NOarg_meta_elab
[
  leftside = [
?Xl {
  sem = "ELABORATION"
  A1-> c:?Yl {
    c:pos = "CC"
    c:?rel1-> c:?Conjunct1 {}
  }
  // don't undesrtand why this gives an overlap PTB_20018
  A2-> c:?Zl {
    c:pos = "CC"
    c:?rel2-> ?Conjunct2 {
      sem = ?d2
    }
  }
}

(?rel1 == A1 | ?rel1 == "A1")
(?rel2 == A1 | ?rel2 == "A1")
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Conjunct1
  ¬rc:top = "yes"
  APPEND-> ?ConjunctR {
    <=> ?Conjunct2
    dlex = ?d2
    meaning = "ELABORATION"
  }
}
// ?Zl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Conjunct2 }
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node.
Exclude nodes which are in the semanticon; special rules for these cases.
RULE FOR THE DEMO.
RULES FOR COORDINATIONS ARE MISSING!!!*/
Sem<=>DSynt node_dep_NOarg_sem_prep : node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = ?d1
  ¬c:main_rheme = "yes"
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
// if the node has a pos, in a T2T context it must have been a real word originally (purpose is an exception in some structures)
// UPDATE: creates overlaps, obviously... refine this "purpose" thing when the case is found again
  //( ¬c:pos = ?p | sem = "purpose" )
  ¬c:pos = ?p
  A1-> c:?Yl {}
  A2-> ?Zl {
    sem = ?d2
    ¬c:pos = "IN"
    ¬c:pos = "RB"
    // see pointTime_AMR
    ¬c:date_type = ?dt
  }
}

semanticon.?d1.gen.lex.?lex
lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos

¬( language.id.iso.EN & ?d1 == "manner" & ?d2 == "routine")
¬(language.id.iso.EN & ?d1 == "frequency" & ?d2 == "sometimes")
// In Spanish, no preposition in this case, but definiteness
¬( language.id.iso.ES & ?d1 == "point_time_date")

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
¬ ( ?Zl { c:pos = "CC" c:?rel-> c:?Conjunct2 {} } & (?rel == A1 | ?rel == "A1"))
¬ ( ?Yl { c:pos = "CC" c:?rel2-> c:?Conjunct3 {} } & (?rel2 == A1 | ?rel2 == "A1"))

// RULES FOR COORDINATIONS ARE MISSING!!!

¬ ( ?Zl.pos == "VB" & ?d1 == "point_time" )

// See dep_NOarg_Locin
¬ ( ?d1 == "locative_relation" & ?Zl.lex == ?zlex & lexicon.?zlex.Locin.?loc )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?Wr {
    dlex = ?lem
    lex = ?lex
    pos = ?pos
    include = bubble_of_gov
    meaning = ?d1
    id = #randInt()#
    II-> ?Zr {
      <=> ?Zl
      dlex = ?d2
    }
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Zl }
  ]
]

/*For the moment, restricted to Spanish*/
Sem<=>DSynt node_dep_NOarg_sem_definiteness : node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = ?d1
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
// if the node has a pos, in a T2T context it must have been a real word originally (purpose is an exception in some structures)
// UPDATE: creates overlaps, obviously... refine this "purpose" thing when the case is found again
  //( ¬c:pos = ?p | sem = "purpose" )
  ¬c:pos = ?p
  A1-> c:?Yl {}
  A2-> ?Zl {
    sem = ?d2
    ¬c:pos = "IN"
    ¬c:pos = "RB"
    // see pointTime_AMR
    ¬c:date_type = ?dt
  }
}

//?d1 == "point_time_date"

semanticon.?d1.gen.def.?def

( language.id.iso.ES | language.id.iso.PT )

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
¬ ( ?Zl { c:pos = "CC" c:?rel-> c:?Conjunct2 {} } & (?rel == A1 | ?rel == "A1"))
¬ ( ?Yl { c:pos = "CC" c:?rel2-> c:?Conjunct3 {} } & (?rel2 == A1 | ?rel2 == "A1"))

// RULES FOR COORDINATIONS ARE MISSING!!!
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?Zr {
     <=> ?Zl
     dlex = ?d2
     definiteness = ?def
     meaning = ?d1
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Zl }
  ]
]

/*For the moment, restricted to Greek.*/
Sem<=>DSynt node_dep_NOarg_sem_case : node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = ?d1
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
// if the node has a pos, in a T2T context it must have been a real word originally (purpose is an exception in some structures)
// UPDATE: creates overlaps, obviously... refine this "purpose" thing when the case is found again
  //( ¬c:pos = ?p | sem = "purpose" )
  ¬c:pos = ?p
  A1-> c:?Yl {}
  A2-> ?Zl {
    sem = ?d2
    ¬c:pos = "IN"
    ¬c:pos = "RB"
    // see pointTime_AMR
    ¬c:date_type = ?dt
  }
}

//?d1 == "point_time"

semanticon.?d1.gen.case.?def

language.id.iso.EL

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
¬ ( ?Zl { c:pos = "CC" c:?rel-> c:?Conjunct2 {} } & (?rel == A1 | ?rel == "A1"))
¬ ( ?Yl { c:pos = "CC" c:?rel2-> c:?Conjunct3 {} } & (?rel2 == A1 | ?rel2 == "A1"))

// RULES FOR COORDINATIONS ARE MISSING!!!
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?Zr {
     <=> ?Zl
     dlex = ?d2
     case = ?def
     meaning = ?d1
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Zl }
  ]
]

/*there should be a good entry in the semanticon.*/
Sem<=>DSynt node_dep_NOarg_possessive : node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  //sem = ?b
  //c:pos = "VB"
  //c:lex = ?lex
  ¬c:main_rheme = "yes"
  c:sem = "possess"
  c:type = "added"
  A2-> c:?OtherNode {}
  A1-> ?Yl {sem = ?d}
}

// ?r maps to an argumental relation
//lexicon.?lex.gp.?r.?DSyntR
//¬?DSyntR == ATTR
//¬?DSyntR == COORD

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
¬ ( ?OtherNode { c:pos = "CC" c:?rel-> c:?Conjunct2 {} } & (?rel == A1 | ?rel == "A1"))
¬ ( ?Yl { c:pos = "CC" c:?rel2-> c:?Conjunct3 {} } & (?rel2 == A1 | ?rel2 == "A1"))
  ]
  mixed = [

  ]
  rightside = [
rc:?Or {
  rc:<=> ?OtherNode
  ¬rc:top = "yes"
  ATTR-> ?Yr {
    <=> ?Yl
    <=> ?Xl
    consumed_ATTR = A0
    //dep_id = ?OtehrNode.id
    dlex = ?d
    case = "GEN"
  }
}
// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }
¬rc:?NOdeR2 { rc:<=> ?Yl }
  ]
]

/*Complements NOarg_sem.
Cases in which the A2 has been built before the A1.*/
Sem<=>DSynt node_dep_NOarg_sem_inv_locative : node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = ?d1
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
// if the node has a pos, in a T2T context it must have been a real word originally (purpose is an exception in some structures)
// UPDATE: creates overlaps, obviously... refine this "purpose" thing when the case is found again
  //( ¬c:pos = ?p | sem = "purpose" )
  ¬c:pos = ?p
  A2-> c:?Yl {
    c:sem = ?semY
  }
  A1-> ?Zl {
    sem = ?d2
    ( c:pos = "NN" | c:pos = "NP" )
  }
}

?d1 == "locative_relation"

semanticon.?d1.gen.lex.?lex
lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos

lexicon.miscellaneous.support_verb.?d1.?lexOper
lexicon.?lexOper.lemma.?lemma

// The dependent is not a cordinating conjunction
// Gives an error in MATE: Automaton building: no inc state found.
//¬ ( c:?Zl { c:pos = "CC" c:?rel-> c:?Conjunct2 {} } & (?rel == A1 | ?rel == "A1"))
//¬ ( c:?Yl { c:pos = "CC" c:?rel2-> c:?Conjunct3 {} } & (?rel2 == A1 | ?rel2 == "A1"))

// RULES FOR COORDINATIONS ARE MISSING!!
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ATTR-> ?Oper1 {
    <=> ?Xl
    main = yes
    pos = "VB"
    spos = "VV"
    finiteness = "FIN"
    dlex = ?lemma
    lex = ?lexOper
    top = "yes"
    clause_type = ?Xl.clause_type
    include = bubble_of_dep
    id = #randInt()#
    I-> ?Zr {
      <=> ?Zl
      dlex = ?d2
    }
    II-> ?Wr {
      <=> ?Xl
      dlex = ?lem
      lex = ?lex
      pos = ?pos
      include = bubble_of_gov
      meaning = ?d1
      id = #randInt()#
      bottom = "yes"
      II-> ?NewYr {
        dlex = ?semY
        pos = ?Yl.pos
        spos = ?Yl.spos
        lex = ?Yl.lex
        <-> rc:?Yr {}
        include = bubble_of_gov
      }
    }
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Zl }
  ]
]

/*Complements NOarg_sem.
Cases in which the A2 has been built before the A1.*/
Sem<=>DSynt node_dep_NOarg_sem_inv : node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = ?d1
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
// if the node has a pos, in a T2T context it must have been a real word originally (purpose is an exception in some structures)
// UPDATE: creates overlaps, obviously... refine this "purpose" thing when the case is found again
  //( ¬c:pos = ?p | sem = "purpose" )
  ¬c:pos = ?p
  A2-> c:?Yl {
  }
  A1-> ?Zl {
    sem = ?d2
    ¬c:pos = "IN"
    ¬c:pos = "RB"
    // see pointTime_AMR
    ¬c:date_type = ?dt
  }
}

semanticon.?d1.gen.lex.?lex
lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos

//language.id.iso.EN

¬(?d1 == "manner" & ?d2 == "routine")
¬(?d1 == "frequency" & ?d2 == "sometimes")
¬(?d1 == "locative_relation" & ( ?Zl.pos == "NN" | ?Zl.pos == "NP" ) )

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
¬ ( ?Zl { c:pos = "CC" c:?rel-> c:?Conjunct2 {} } & (?rel == A1 | ?rel == "A1"))
¬ ( ?Yl { c:pos = "CC" c:?rel2-> c:?Conjunct3 {} } & (?rel2 == A1 | ?rel2 == "A1"))

// RULES FOR COORDINATIONS ARE MISSING!!!

¬ ( ?Zl.pos == "VB" & ?d1 == "point_time" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?Zr {
      <=> ?Zl
      dlex = ?d2
      meaning = ?d1
      inverted_sem = "yes"
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Zl }
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node.
Exclude nodes which are in the semanticon; special rules for these cases.
RULE FOR THE DEMO.
RULES FOR COORDINATIONS ARE MISSING!!!*/
Sem<=>DSynt node_dep_NOarg_sem_COORD_A1 : node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = ?d1
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
// if the node has a pos, in a T2T context it must have been a real word originally (purpose is an exception in some structures)
// UPDATE: creates overlaps, obviously... refine this "purpose" thing when the case is found again
  //( ¬c:pos = ?p | sem = "purpose" )
  ¬c:pos = ?p
  A1-> c:?Yl {}
  A2-> ?Zl {
    sem = ?d2
    ¬c:pos = "IN"
    ¬c:pos = "RB"
    // see pointTime_AMR
    ¬c:date_type = ?dt
  }
}

semanticon.?d1.gen.lex.?lex
lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos

//language.id.iso.EN

¬(?d1 == "manner" & ?d2 == "routine")
¬(?d1 == "frequency" & ?d2 == "sometimes")

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
¬ ( c:?Zl { c:pos = "CC" c:?rel-> c:?Conjunct2 {} } & (?rel == A1 | ?rel == "A1"))
( c:?Yl { c:pos = "CC" c:?rel2-> c:?Conjunct3 {} } & (?rel2 == A1 | ?rel2 == "A1"))

¬ ( ?Zl.pos == "VB" & ?d1 == "point_time" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Conjunct3
  ¬rc:top = "yes"
  ATTR-> ?Wr {
    dlex = ?lem
    lex = ?lex
    pos = ?pos
    include = bubble_of_gov
    meaning = ?d1
    id = #randInt()#
    II-> ?Zr {
      <=> ?Zl
      dlex = ?d2
    }
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Zl }
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node.
Exclude nodes which are in the semanticon; special rules for these cases.
RULE FOR THE DEMO.
RULES FOR COORDINATIONS ARE MISSING!!!*/
Sem<=>DSynt node_dep_NOarg_sem_COORD_A2 : node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = ?d1
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
// if the node has a pos, in a T2T context it must have been a real word originally (purpose is an exception in some structures)
// UPDATE: creates overlaps, obviously... refine this "purpose" thing when the case is found again
  //( ¬c:pos = ?p | sem = "purpose" )
  ¬c:pos = ?p
  A1-> c:?Yl {}
  A2-> c:?Zl {
    // see pointTime_AMR
    ¬c:date_type = ?dt
  }
}

semanticon.?d1.gen.lex.?lex
lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos

//language.id.iso.EN

¬(?d1 == "manner" & ?d2 == "routine")
¬(?d1 == "frequency" & ?d2 == "sometimes")

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
//( c:?Zl { c:pos = "CC" c:?rel-> ?Conjunct2 {sem = ?d2 ¬c:pos = "IN" ¬c:pos = "RB" } } & (?rel == A1 | ?rel == "A1") )
( c:?Zl { c:pos = "CC" c:?rel-> ?Conjunct2 {sem = ?d2 } } & (?rel == A1 | ?rel == "A1") )
¬(?Yl {c:pos = "CC" c:?rel2-> c:?Conjunct3 {}} & (?rel2 == A1 | ?rel2 == "A1"))
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?Wr {
    dlex = ?lem
    lex = ?lex
    pos = ?pos
    include = bubble_of_gov
    meaning = ?d1
    id = #randInt()#
    II-> ?ConjunctR {
      <=> ?Conjunct2
      dlex = ?d2
    }
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Conjunct2 }
  ]
]

Sem<=>DSynt DE_transfer_node_dep_NOarg_semantemes : node_dep_NOarg_semantemes
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>DSynt EN_transfer_node_dep_NOarg_semantemes : node_dep_NOarg_semantemes
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>DSynt ES_transfer_node_dep_NOarg_semantemes : node_dep_NOarg_semantemes
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>DSynt IT_transfer_node_dep_NOarg_semantemes : node_dep_NOarg_semantemes
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>DSynt PL_transfer_node_dep_NOarg_semantemes : node_dep_NOarg_semantemes
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*Builds a relative clause when the dependent of a verb has already been built, and not the verb.
Applies when the noun is a direct dependent of the verb.*/
Sem<=>DSynt node_dep_NOarg_VB_relative_lex : node_dep_NOarg_fromArg
[
  leftside = [
?Xl {
  sem = ?d
  c:pos = "VB"
  c:lex = ?lex
  ¬c:main_rheme = "yes"
  ?r-> c:?Yl {
    ¬c:sem = "amr-unknown"}
}

// ?r maps to an argumental relation
lexicon.?lex.gp.?r.?DSyntR
¬?DSyntR == ATTR
¬?DSyntR == APPEND
¬?DSyntR == COORD

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 

// see node_dep_NOarg_VB_relative_lex_COORD
¬ ( ?Yl { c:pos = "CC" c:?rel0-> c:?Conjunct0 {} } & (?rel0 == A1 | ?rel0 == "A1"))
// see transfer_node_dep_NOarg_possessive
¬(?r == A1 & c:?Xl {c:sem = "possess" c:A0-> c:?OtherNode {}})
// see node_dep_NOarg_semanticon
¬ ( c:?NodeL { c:sem = ?sem c:A2-> c:?Xl {} } & ( semanticon.?sem | ?sem == "ELABORATION" | ?NodeL.type == META ) )
// do not transfer this relation for an  A2+ from a coordination conjunction (shared dep) PTB_21832
¬ ( c:?Conjunction { c:pos = "CC" c:?rel-> ?Xl {} } & ¬(?rel == A1 | ?rel == "A1"))

//Update: not sure the below condition is ok... It's one of these cases we'd need to check that ?Z4 has no RS counterpart, instead of using ID.
// If there are more than one candidates, only apply rule once; would need an example sentence here! Blocker on PTB_eval_36.
//¬ ( c:?Yl { c:id = ?idY } & ?Xl { c:?s4-> c:?Z4l { c:id = ?idZ4 } } & lexicon.?lex.gp.?s4.?DSyntR4 & ?idZ4 < ?idY )
//18/05/2020: updated this condition, gave problems on 200410_V4Design-P2 sent 16 in Greek; I think the previous condition was wrong.
¬ ( c:?Yl { c:id = ?idY } & ?Xl { c:?s4-> c:?Z4l { c:id = ?idZ4 } } & ?s4 == ?r & ?idZ4 < ?idY )
  ]
  mixed = [
// the verb is not alone with ?Yl; if it is, let's make it a gerund or a participle, depending on ?DSyntR
// see VB_part, see VB_gerund
( ( c:?Gov1l { c:id = ?idGov1 c:?r1-> ?Xl {} }
   & ¬ ( c:?Gov2l { c:id = ?idGov2 c:?r2-> ?Xl {} } & ?idGov2 < ?idGov1 )
// if the only governor(s) is(are) an added node(s), it's alright, this rule can apply
   & ¬ ( c:?Gov1l { ( c:type = "added" | c:pos = "IN" | c:pos = "RB" ) }
     & ¬c:?Gov4l { ¬( c:type = "added" | c:pos = "IN" | c:pos = "RB" ) c:?r4-> ?Xl {} } & ?DSyntR == II )
  )
  | ( c:?Xl { c:?s1-> c:?Zk1l { c:id = ?idZ1 } } & ¬?s1 == ?r & ¬ ( ?Xl { c:?s2-> ?Z2l { c:id = ?idZ2 } } & ¬?s2 == ?r & ?idZ2 < ?idZ1 ) & ¬ ( ?DSyntR == II & ( c:?Xl { theme_modif = "yes" } & ¬lexicon.?lex.gp.II.prep.?prep ) ) )
  // If there's already a finite verb, do not make a particple/gerund out of ?Xl
  | rc:?Yr { rc:<=> ?Yl   ¬rc:top = "yes" ¬rc:include = bubble_of_gov rc:ATTR-> rc: ?relatR {  rc:pos = "VB" rc:finiteness = "FIN" } }
  // If the verb has a modality, no not make a particple/gerund out of ?Xl
  | c:?Xl { c:modality = ?modalityXl }
)

// the argument can also be an A1 of a coord for which the A2 has been built by another rule already (PTB_22141); 170707: looks like the problem doesn't exist anymore.
// PTB_8 has to be taken into account when doing this condition; and also PTB_eval_22.
//¬ ( c:?Conjunction2 { c:pos = "CC" c:?rel2-> ?Xl {} c:?rel3-> ?Zl {} } & (?rel2 == A1 | ?rel2 == "A1") & (?rel3 == A2 | ?rel3 == "A2")
//   & rc:?Zr { rc:<=> ?Zl } )
  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ¬rc:include = bubble_of_gov
  ( rc:pos = "NN" | rc:pos = "NP" | rc:pos = "DT" | ( rc:pos = "VB" & ¬rc:finiteness = ?finit ) )
  ATTR-> ?Xr {
    <=> ?Xl
    consumed_ATTR = ?r
    //dep_id = ?Yl.id
    dlex = ?d
    pos = "VB"
    finiteness = "FIN"
    ?DSyntR-> ?Ar {
      // TEST 200519
      <=> ?Yl
      dlex = ?Yl.sem
      lex = ?Yl.lex
      pos = ?Yl.pos
      id = #randInt()#
      // add spos here cos the rule that adds spos only applies to node that have a LS correspondence.
      // spos = ?Yl.pos
      NE = ?Yl.NE
      class = ?Yl.class
      include = bubble_of_gov
      <-> rc:?Yr {}
    }
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }
// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
]

/*Builds a relative clause when the dependent of a verb has already been built, and not the verb.
Applies when the noun is a direct dependent of the verb.*/
excluded Sem<=>DSynt node_dep_NOarg_VB_relative_lex_PATCH : node_dep_NOarg_fromArg
[
  leftside = [
?Xl {
  sem = ?d
  c:pos = "VB"
  c:lex = ?lex
  ¬c:main_rheme = "yes"
  ?r-> c:?Yl {
    ¬c:sem = "amr-unknown"
  }
  c:?s1-> c:?Z1l {
    c:id = ?idZ1
  }
}

// ?r maps to an argumental relation
lexicon.?lex.gp.?r.?DSyntR
¬?DSyntR == ATTR
¬?DSyntR == COORD

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 

// see node_dep_NOarg_VB_relative_lex_COORD
¬ ( ?Yl { c:pos = "CC" c:?rel0-> c:?Conjunct0 {} } & (?rel0 == A1 | ?rel0 == "A1"))
// see transfer_node_dep_NOarg_possessive
¬(?r == A1 & c:?Xl {c:sem = "possess" c:A0-> c:?OtherNode {}})
// see node_dep_NOarg_semanticon
¬ ( c:?NodeL { c:sem = ?sem c:A2-> c:?Xl {} } & ( semanticon.?sem | ?sem == "ELABORATION" | ?NodeL.type == META ) )
// do not transfer this relation for an  A2+ from a coordination conjunction (shared dep) PTB_21832
¬ ( c:?Conjunction { c:pos = "CC" c:?rel-> ?Xl {} } & ¬(?rel == A1 | ?rel == "A1"))
// the verb is not alone with ?Yl; if it is, let's make it a gerund or a participle, depending on ?DSyntR
// see VB_part, see VB_gerund
//¬ ( ?Xl { c:?s2-> ?Z2l { c:id = ?idZ2 } } & ¬?s2 == ?r & ?idZ2 < ?idZ1 )
//Update: not sure the below condition is ok... It's one of these cases we'd need to check that ?Z4 has no RS counterpart, instead of using ID.
// If there are more than one candidates, only apply rule once; would need an example sentence here! Blocker on PTB_eval_36.
¬ ( c:?Yl { c:id = ?idY } & ?Xl { c:?s4-> c:?Z4l { c:id = ?idZ4 } } & lexicon.?lex.gp.?s4.?DSyntR4 & ?idZ4 < ?idY )
  ]
  mixed = [
// the argument can also be an A1 of a coord for which the A2 has been built by another rule already (PTB_22141); 170707: looks like the problem doesn't exist anymore.
// PTB_8 has to be taken into account when doing this condition; and also PTB_eval_22.
//¬ ( c:?Conjunction2 { c:pos = "CC" c:?rel2-> ?Xl {} c:?rel3-> ?Zl {} } & (?rel2 == A1 | ?rel2 == "A1") & (?rel3 == A2 | ?rel3 == "A2")
//   & rc:?Zr { rc:<=> ?Zl } )
  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ( rc:pos = "NN" | rc:pos = "NP" | rc:pos = "DT" | ( rc:pos = "VB" & ¬rc:finiteness = ?finit ) )
  ATTR-> ?Xr {
    <=> ?Xl
    consumed_ATTR = ?r
    //dep_id = ?Yl.id
    dlex = ?d
    pos = "VB"
    finiteness = "FIN"
    ?DSyntR-> ?Ar {
      dlex = ?Yl.sem
      lex = ?Yl.lex
      pos = ?Yl.pos
      NE = ?Yl.NE
      class = ?Yl.class
      include = bubble_of_gov
      <-> rc:?Yr {}
    }
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }
// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
]

/*PTB_eval_31*/
Sem<=>DSynt node_dep_NOarg_VB_relative_lex_COORD : node_dep_NOarg_fromArg
[
  leftside = [
?Xl {
  sem = ?d
  c:pos = "VB"
  c:lex = ?lex
  ¬c:main_rheme = "yes"
  ?r-> c:?Yl {
    ¬c:sem = "amr-unknown"
    c:pos = "CC"
    c:?sss-> c:?Cl {}
  }
}

// ?r maps to an argumental relation
lexicon.?lex.gp.?r.?DSyntR
¬?DSyntR == ATTR
¬?DSyntR == APPEND
¬?DSyntR == COORD

(?sss == A1 | ?sss == "A1")

// see transfer_node_dep_NOarg_possessive
¬(?r == A1 & c:?Xl {c:sem = "possess" c:A0-> c:?OtherNode {}})
// see node_dep_NOarg_semanticon
¬ ( c:?NodeL { c:sem = ?sem c:A2-> c:?Xl {} } & ( semanticon.?sem | ?sem == "ELABORATION" | ?NodeL.type == META ) )
// do not transfer this relation for an  A2+ from a coordination conjunction (shared dep) PTB_21832
¬ ( c:?Conjunction { c:pos = "CC" c:?rel-> ?Xl {} } & ¬(?rel == A1 | ?rel == "A1"))

// If there are more than one candidates, only apply rule once; update: not sure that this condition is ok...
¬ ( c:?Yl { c:id = ?idY } & ?Xl { c:?s4-> c:?Z4l { c:id = ?idZ4 } } & lexicon.?lex.gp.?s4.?DSyntR4 & ?idZ4 < ?idY )

// see VB_part; integrated in above condition (now moved to Mixed)
//¬ ( c:?Gov3l { ( c:type = "added" | c:pos = "IN" | c:pos = "RB" ) c:?r3-> ?Xl {} }
//     & ¬c:?Gov4l { ¬( c:type = "added" | c:pos = "IN" | c:pos = "RB" ) c:?r4-> ?Xl {} } & ?DSyntR == II )
  ]
  mixed = [
// the verb is not alone with ?Yl; if it is, let's make it a gerund or a participle, depending on ?DSyntR
// see VB_part, see VB_gerund
( ( c:?Gov1l { c:id = ?idGov1 c:?r1-> ?Xl {} }
   & ¬ ( c:?Gov2l { c:id = ?idGov2 c:?r2-> ?Xl {} } & ?idGov2 < ?idGov1 )
// if the only governor(s) is(are) an added node(s), it's alright, this rule can apply
   & ¬ ( c:?Gov1l { ( c:type = "added" | c:pos = "IN" | c:pos = "RB" ) }
     & ¬c:?Gov4l { ¬( c:type = "added" | c:pos = "IN" | c:pos = "RB" ) c:?r4-> ?Xl {} } & ?DSyntR == II )
  )
  | ( c:?Xl { c:?s1-> c:?Zk1l { c:id = ?idZ1 } } & ¬?s1 == ?r & ¬ ( ?Xl { c:?s2-> ?Z2l { c:id = ?idZ2 } } & ¬?s2 == ?r & ?idZ2 < ?idZ1 ) & ¬ ( ?DSyntR == II & c:?Xl { c:theme_modif = "yes" } ) )
  // If there's already a finite verb, do not make a particple/gerund out of ?Xl
  | rc:?Cr { rc:<=> ?Cl   ¬rc:top = "yes" ¬rc:include = bubble_of_gov rc:ATTR-> rc: ?relatR {  rc:pos = "VB" rc:finiteness = "FIN" } }
  // If the verb has a modality, no not make a particple/gerund out of ?Xl
  | c:?Xl { c:modality = ?modalityXl }
)

// the argument can also be an A1 of a coord for which the A2 has been built by another rule already (PTB_22141)
// PTB_8 has to be taken into account when doing this condition.
//¬ ( c:?Conjunction2 { c:pos = "CC" c:?rel2-> ?Xl {} c:?rel3-> ?Zl {} } & (?rel2 == A1 | ?rel2 == "A1") & (?rel3 == A2 | ?rel3 == "A2")
//   & rc:?Zr { rc:<=> ?Zl } )
  ]
  rightside = [
rc:?Cr {
  rc:<=> ?Cl
  ¬rc:top = "yes"
  ¬rc:include = bubble_of_gov
  ( rc:pos = "NN" | rc:pos = "NP" | rc:pos = "DT" | ( rc:pos = "VB" & ¬rc:finiteness = ?finit ) )
  ATTR-> ?Xr {
    <=> ?Xl
    consumed_ATTR = ?r
    //dep_id = ?Yl.id
    dlex = ?d
    pos = "VB"
    finiteness = "FIN"
    ?DSyntR-> ?Ar {
      // TEST 200519
      <=> ?Yl
      dlex = ?Yl.sem
      lex = ?Yl.lex
      pos = ?Yl.pos
      id = #randInt()#
      // add spos here cos the rule that adds spos only applies to node that have a LS correspondence.
      // spos = ?Yl.pos
      NE = ?Yl.NE
      class = ?Yl.class
      include = bubble_of_gov
      <-> rc:?Cr {}
    }
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }
// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Cr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
]

/*Builds a relative clause when the dependent of a verb has already been built, and not the verb.
Applies when the noun is the grandchild of the verb.
(e.g., N1, the N2 of which has been implemented, works well.)
There should be a rule that covers cases in which ?X2l is not in the lexicon.
But there seems to be a bug with ¬lexicon.?lex2.gp.?r2.?DSyntR2 or with ¬rc:?NOde1R { rc:<=> ?X1l }.
See amrs-cctv_7.*/
Sem<=>DSynt node_dep_NOarg_VB_relative_lex_2storeys : node_dep_NOarg_fromArg
[
  leftside = [
?X1l {
  sem = ?d1
  c:pos = "VB"
  c:lex = ?lex1
  ¬c:main_rheme = "yes"
  ?r1-> ?X2l {
    c:pos = "NN"
    c:lex = ?lex2
    ?r2-> c:?Yl {
      ¬c:sem = "amr-unknown"
    }
  }
}

// ?r1 maps to an argumental relation
lexicon.?lex1.gp.?r1.?DSyntR1
¬?DSyntR1 == ATTR
¬?DSyntR == APPEND
¬?DSyntR1 == COORD
// ?r2 maps to an argumental relation
//lexicon.?lex2.gp.?r2.?DSyntR2
//¬?DSyntR2 == ATTR
//¬?DSyntR2 == COORD

// see transfer_node_dep_NOarg_possessive
¬(?r1 == A1 & c:?X1l {c:sem = "possess" c:A0-> c:?OtherNode {}})

// see node_dep_NOarg_semanticon
¬ ( c:?NodeL { c:sem = ?sem c:A2-> c:?X1l {} } & ( semanticon.?sem | ?sem == "ELABORATION" | ?NodeL.type == META ) )

// do not transfer this relation for an  A2+ from a coordination conjunction (shared dep) PTB_21832
¬ ( c:?Conjunction { c:pos = "CC" c:?rel-> ?X1l {} } & ¬(?rel == A1 | ?rel == "A1"))

// the verb is not alone with ?Yl; if it is, let's make it a gerund or a participle, depending on ?DSyntR; frop it for now
//( ( c:?Gov1l { c:id = ?idGov1 c:?r1-> ?Xl {} } & ¬ ( c:?Gov2l { c:id = ?idGov2 c:?r2-> ?Xl {} } & ?idGov2 < ?idGov1 ) )
//  | ( ?Xl { c:?s1-> c:?Z1l { c:id = ?idZ1 } } & ¬ ?s1 == ?r & ¬ ( c:?Xl { c:?s2-> ?Z2l { c:id = ?idZ2 } } & ?idZ2 < ?idZ1 ) )
//)
  ]
  mixed = [
// the argument can also be an A1 of a coord for which the A2 has been built by another rule already (PTB_22141)
// PTB_8 has to be taken into account when doing this condition.
//¬ ( c:?Conjunction2 { c:pos = "CC" c:?rel2-> ?X1l {} c:?rel3-> ?Zl {} } & (?rel2 == A1 | ?rel2 == "A1") & (?rel3 == A2 | ?rel3 == "A2")
//   & rc:?Zr { rc:<=> ?Zl } )
  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ¬rc:include = bubble_of_gov
  ( rc:pos = "NN" | rc:pos = "NP" | rc:pos = "DT" | ( rc:pos = "VB" & ¬rc:finiteness = ?finit ) )
  ATTR-> ?X1r {
    <=> ?X1l
    consumed_ATTR = ?r2
    //dep_id = ?Yl.id
    dlex = ?d1
    pos = "VB"
    finiteness = "FIN"
    ?DSyntR1-> ?X2r {
      <=> ?X2l
      dlex = ?X2l.sem
      lex = ?X2l.lex
      pos = ?X2l.pos
      NE = ?X2l.NE
      class = ?X2l.class
      ATTR-> ?Ar {
        // TEST 200519
        <=> ?Yl
        dlex = ?Yl.sem
        lex = ?Yl.lex
        pos = ?Yl.pos
        id = #randInt()#
        // add spos here cos the rule that adds spos only applies to node that have a LS correspondence.
        // spos = ?Yl.pos
        NE = ?Yl.NE
        class = ?Yl.class
        include = bubble_of_gov
        //add_of = yes
        <-> rc:?Yr {}
      }
    }
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOde1R { rc:<=> ?X1l }
¬rc:?NOde2R { rc:<=> ?X2l }
// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r2 & ?gid == ?X2l.id)
  ]
]

/*Builds a relative clause when the dependent of a verb has already been built, and not the verb.
Applies when the noun is the grandchild of the verb.
(e.g., N1, the N2 of which has been implemented, works well.)
The previous grammars create nouns that are not in the lexicon; this rule covers these cases.*/
excluded Sem<=>DSynt node_dep_NOarg_VB_relative_lex_2storeys2 : node_dep_NOarg_fromArg
[
  leftside = [
?X1l {
  sem = ?d1
  c:pos = "VB"
  c:lex = ?lex1
  ¬c:main_rheme = "yes"
  ?r1-> ?X2l {
    c:pos = "NN"
    c:lex = ?lex2
    ?r2-> c:?Yl {
      ¬c:sem = "amr-unknown"
    }
  }
}

// ?r1 maps to an argumental relation
lexicon.?lex1.gp.?r1.?DSyntR1
¬?DSyntR1 == ATTR
¬?DSyntR1 == COORD
// ?r2 maps to an argumental relation
¬lexicon.?lex2.gp.?r2.?DSyntR2

// see transfer_node_dep_NOarg_possessive
¬ (?r1 == A1 & c:?X1l {c:sem = "possess" c:A0-> c:?OtherNode {}} )

// see node_dep_NOarg_semanticon
¬ ( c:?NodeL { c:sem = ?sem c:A2-> c:?X1l {} } & ( semanticon.?sem | ?sem == "ELABORATION" | ?NodeL.type == META ) )

// do not transfer this relation for an  A2+ from a coordination conjunction (shared dep) PTB_21832
¬ ( c:?Conjunction { c:pos = "CC" c:?rel-> ?X1l {} } & ¬(?rel == A1 | ?rel == "A1"))

// the verb is not alone with ?Yl; if it is, let's make it a gerund or a participle, depending on ?DSyntR; frop it for now
//( ( c:?Gov1l { c:id = ?idGov1 c:?r1-> ?Xl {} } & ¬ ( c:?Gov2l { c:id = ?idGov2 c:?r2-> ?Xl {} } & ?idGov2 < ?idGov1 ) )
//  | ( ?Xl { c:?s1-> c:?Z1l { c:id = ?idZ1 } } & ¬ ?s1 == ?r & ¬ ( c:?Xl { c:?s2-> ?Z2l { c:id = ?idZ2 } } & ?idZ2 < ?idZ1 ) )
//)
  ]
  mixed = [
// the argument can also be an A1 of a coord for which the A2 has been built by another rule already (PTB_22141)
// PTB_8 has to be taken into account when doing this condition.
¬ ( c:?Conjunction2 { c:pos = "CC" c:?rel2-> ?X1l {} c:?rel3-> ?Zl {} } & (?rel2 == A1 | ?rel2 == "A1") & (?rel3 == A2 | ?rel3 == "A2")
   & rc:?Zr { rc:<=> ?Zl } )
  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ( rc:pos = "NN" | rc:pos = "NP" | ( rc:pos = "VB" & ¬rc:finiteness = ?finit ) )
  ATTR-> ?X1r {
    <=> ?X1l
    consumed_ATTR = ?r2
    //dep_id = ?Yl.id
    dlex = ?d1
    pos = "VB"
    finiteness = "FIN"
    ?DSyntR1-> ?X2r {
      <=> ?X2l
      dlex = ?X2l.sem
      lex = ?X2l.lex
      pos = ?X2l.pos
      NE = ?X2l.NE
      ATTR-> ?Ar {
        dlex = ?Yl.sem
        lex = ?Yl.lex
        pos = ?Yl.pos
        NE = ?Yl.NE
        include = bubble_of_gov
        <-> rc:?Yr {}
      }
    }
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?Node1R { rc:<=> ?X1l }
¬rc:?NOde2R { rc:<=> ?X2l }
// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r2 & ?gid == ?X2l.id)
  ]
]

/*Complements NOarg_relative; for cases in which the verb has only an arg II, and no other dependent in DSynt.*/
Sem<=>DSynt node_dep_NOarg_VB_pastParticiple : node_dep_NOarg_fromArg
[
  leftside = [
?Xl {
  sem = ?d
  c:pos = "VB"
  c:lex = ?lex
  ¬c:main_rheme = "yes"
  ¬c:modality = ?modality
  ?r-> c:?Yl {
    ¬c:sem = "amr-unknown"}
}

// ?r maps to an argumental relation
lexicon.?lex.gp.?r.?DSyntR
?DSyntR == II

// see node_dep_NOarg_VB_pastParticiple_COORD
¬ ( ?Yl { c:pos = "CC" c:?rel0-> c:?Conjunct0 {} } & (?rel0 == A1 | ?rel0 == "A1"))

// see transfer_node_dep_NOarg_possessive
¬(?r == A1 & c:?Xl {c:sem = "possess" c:A0-> c:?OtherNode {}})

// see node_dep_NOarg_semanticon
¬ ( c:?NodeL {c:A2-> c:?Xl {} c:sem = ?sem } & ( semanticon.?sem | ?sem == "ELABORATION" | ?NodeL.type == META ) )

// do not transfer this relation for an  A2+ from a coordination conjunction (shared dep) PTB_21832
¬ ( c:?Conjunction { c:pos = "CC" c:?rel-> ?Xl {} } & ¬(?rel == A1 | ?rel == "A1"))

// the verb is alone with ?Yl, or the verb (?Xl) has a governor that only has circumstancials
( ¬ c:?Gov1l { c:?r1-> ?Xl {} }
  | ( c:?Gov2l {( c:type = "added" | c:pos = "IN" | c:pos = "RB" ) c:?r2-> ?Xl {} }
     & ¬c:?Gov3l { ¬( c:type = "added" | c:pos = "IN" | c:pos = "RB" ) c:?r3-> ?Xl {} }
   )
)

// Build a participial clause if there is no other argument, or if the verb has been marked as modifying a main theme
 // and the second argument doesn't exepct  a preposition.
( ¬ ( ?Xl { c:?s1-> c:?Z1l {} } & ¬ ?s1 == ?r ) | ( c:?Xl { theme_modif = "yes" } & ¬ ( lexicon.?lex2.gp.II.prep.?prep & ?lex2 == ?lex ) ) )
  ]
  mixed = [
// the argument can also be an A1 of a coord for which the A2 has been built by another rule already (PTB_22141)
// PTB_8 has to be taken into account when doing this condition.
//¬ ( c:?Conjunction2 { c:pos = "CC" c:?rel2-> ?Xl {} c:?rel3-> ?Zl {} } & (?rel2 == A1 | ?rel2 == "A1") & (?rel3 == A2 | ?rel3 == "A2")
//   & rc:?Zr { rc:<=> ?Zl } )
  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ¬rc:include = bubble_of_gov
  ( rc:pos = "NN" | rc:pos = "NP" | rc:pos = "DT" | ( rc:pos = "VB" & ¬rc:finiteness = ?finit ) )
  ¬rc:ATTR-> rc: ?relatR {
    rc:pos = "VB"
    rc:finiteness = "FIN"
  }
  ATTR-> ?Xr {
    <=> ?Xl
    consumed_ATTR = ?r
    in_the_closet = "yes"
    //dep_id = ?Yl.id
    dlex = ?d
    pos = "VB"
    finiteness = "PART"
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }
// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
]

/*Complements NOarg_relative; for cases in which the verb has only an arg II, and no other dependent in DSynt.*/
Sem<=>DSynt node_dep_NOarg_VB_pastParticiple_COORD : node_dep_NOarg_fromArg
[
  leftside = [
?Xl {
  sem = ?d
  c:pos = "VB"
  c:lex = ?lex
  ¬c:main_rheme = "yes"
  ¬c:modality = ?modality
  ?r-> c:?Yl {
    ¬c:sem = "amr-unknown"
    c:pos = "CC"
    c:?rel0-> c:?Cl {}
  }
}

(?rel0 == A1 | ?rel0 == "A1")

// ?r maps to an argumental relation
lexicon.?lex.gp.?r.?DSyntR
?DSyntR == II

// see transfer_node_dep_NOarg_possessive
¬(?r == A1 & c:?Xl {c:sem = "possess" c:A0-> c:?OtherNode {}})

// see node_dep_NOarg_semanticon
¬ ( c:?NodeL {c:A2-> c:?Xl {} c:sem = ?sem } & ( semanticon.?sem | ?sem == "ELABORATION" | ?NodeL.type == META ) )

// do not transfer this relation for an  A2+ from a coordination conjunction (shared dep) PTB_21832
¬ ( c:?Conjunction { c:pos = "CC" c:?rel-> ?Xl {} } & ¬(?rel == A1 | ?rel == "A1"))

// the verb is alone with ?Yl, or the verb (?Xl) has a governor that only has circumstancials
( ¬ c:?Gov1l { c:?r1-> ?Xl {} }
  | ( c:?Gov2l {( c:type = "added" | c:pos = "IN" | c:pos = "RB" ) c:?r2-> ?Xl {} }
     & ¬c:?Gov3l { ¬( c:type = "added" | c:pos = "IN" | c:pos = "RB" ) c:?r3-> ?Xl {} }
   )
)

( ¬ ( ?Xl { c:?s1-> c:?Z1l {} } & ¬ ?s1 == ?r ) | ( c:?Xl { theme_modif = "yes" } & ¬ ( lexicon.?lex2.gp.II.prep.?prep & ?lex2 == ?lex ) ) )
  ]
  mixed = [
// the argument can also be an A1 of a coord for which the A2 has been built by another rule already (PTB_22141)
// PTB_8 has to be taken into account when doing this condition.
//¬ ( c:?Conjunction2 { c:pos = "CC" c:?rel2-> ?Xl {} c:?rel3-> ?Zl {} } & (?rel2 == A1 | ?rel2 == "A1") & (?rel3 == A2 | ?rel3 == "A2")
//   & rc:?Zr { rc:<=> ?Zl } )
  ]
  rightside = [
rc:?Cr {
  rc:<=> ?Cl
  ¬rc:top = "yes"
  ¬rc:include = bubble_of_gov
  ( rc:pos = "NN" | rc:pos = "NP" | rc:pos = "DT" | ( rc:pos = "VB" & ¬rc:finiteness = ?finit ) )
  ¬rc:ATTR-> rc: ?relatR {
    rc:pos = "VB"
    rc:finiteness = "FIN"
  }
  ATTR-> ?Xr {
    <=> ?Xl
    consumed_ATTR = ?r
    in_the_closet = "yes"
    //dep_id = ?Yl.id
    dlex = ?d
    pos = "VB"
    finiteness = "PART"
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }
// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Cr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
]

/*Complements NOarg_relative; for cases in which the verb has only an arg II, and no other dependent in DSynt.*/
Sem<=>DSynt node_dep_NOarg_VB_gerund : node_dep_NOarg_fromArg
[
  leftside = [
?Xl {
  sem = ?d
  c:pos = "VB"
  c:lex = ?lex
  ¬c:main_rheme = "yes"
  ¬c:modality = ?modality
  ?r-> c:?Yl {
    ¬c:sem = "amr-unknown"}
}

// ?r maps to an argumental relation
lexicon.?lex.gp.?r.?DSyntR
?DSyntR == I

// see transfer_node_dep_NOarg_possessive
¬(?r == A1 & c:?Xl {c:sem = "possess" c:A0-> c:?OtherNode {}})

// see node_dep_NOarg_semanticon
¬ ( c:?NodeL {c:A2-> c:?Xl {} c:sem = ?sem } & ( semanticon.?sem | ?sem == "ELABORATION" | ?NodeL.type == META ) )

// do not transfer this relation for an  A2+ from a coordination conjunction (shared dep) PTB_21832
¬ ( c:?Conjunction { c:pos = "CC" c:?rel-> ?Xl {} } & ¬(?rel == A1 | ?rel == "A1"))

// the verb is alone with ?Yl
¬ c:?Gov1l { c:?r1-> ?Xl {} }
¬ ( ?Xl { c:?s1-> c:?Z1l {} } & ¬ ?s1 == ?r )
  ]
  mixed = [
// the argument can also be an A1 of a coord for which the A2 has been built by another rule already (PTB_22141)
// PTB_8 has to be taken into account when doing this condition.
//¬ ( c:?Conjunction2 { c:pos = "CC" c:?rel2-> ?Xl {} c:?rel3-> ?Zl {} } & (?rel2 == A1 | ?rel2 == "A1") & (?rel3 == A2 | ?rel3 == "A2")
//   & rc:?Zr { rc:<=> ?Zl } )
  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ¬rc:include = bubble_of_gov
  ( rc:pos = "NN" | rc:pos = "NP" | rc:pos = "DT" | ( rc:pos = "VB" & ¬rc:finiteness = ?finit ) )
  ¬rc:ATTR-> rc: ?relatR {
    rc:pos = "VB"
    rc:finiteness = "FIN"
  }
  ATTR-> ?Xr {
    <=> ?Xl
    consumed_ATTR = ?r
    in_the_closet = "yes"
    //dep_id = ?Yl.id
    dlex = ?d
    pos = "VB"
    finiteness = "GER"
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }
// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
]

/*The kind of modifier created here should be as independent as possible.
For instance, don't let the dep_arg_coref rule apply in this case.
That's why we need to mark this type of ATTR for now.*/
Sem<=>DSynt node_dep_NOarg_NN : node_dep_NOarg_fromArg
[
  leftside = [
?Xl {
  sem = ?d
  c:pos = "NN"
  c:lex = ?lex
  ¬c:main_rheme = "yes"
  ?r-> c:?Yl {}
}

// ?r maps to an argumental relation
lexicon.?lex.gp.?r.?DSyntR
¬?DSyntR == ATTR
¬?DSyntR == APPEND
¬?DSyntR == COORD

// there is no governor above the node, or only an adj/adverb or a circumstancial semanteme
( ¬c:?Gov1l { c:?r1-> ?Xl {} }
 | ( c:?OGov1l { ( c:pos = "CD" |  c:pos = "JJ" |  c:type = "added" ) c:?s1-> ?Xl {} }  & ¬ ( c:?PGov1l { c:?t1-> ?Xl {} } & ¬ ?t1 == ?s1 ) )
)
// if there is another argument that is the first one, we need a support verb for a relative, since the apposition won't work
// see node_dep_NOarg_NN_Oper
¬ ( ?Xl { c:?r2-> c:?Y2l {} } & lexicon.?lex.gp.?r2.I )

// If there is an Oper for the node in the lexicon, do not apply the rule
¬ ( ?DSyntR == I & lexicon.?lex.Oper1.?lexOper1 )
¬ ( ?DSyntR == II & lexicon.?lex.Oper2.?lexOper2 )
// see node_ROOT_Oper1noA1_lexicon and node_dep_NOarg_NN_Oper_I_NOA1_NOsibling_lexicon; if there's an Oper1 but no A1, we try to do something anyway
( ¬ ( ?DSyntR == II & lexicon.?lex.Oper1.?lexOper1bis ) | ( c:?Xl { c:?r3-> c:?Dep3 {} } & lexicon.?lex.gp.?r3.?DSyntR3 & ?DSyntR3 == I ) )

¬ ?d == "duration"
¬ ?d == "manner"
¬ ?d == "routine"
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ¬rc:include = bubble_of_gov
  ATTR-> ?Xr {
    <=> ?Xl
    consumed_ATTR = ?r
    in_the_closet = "yes"
    //dep_id = ?Yl.id
    dlex = ?d
    pos = "NN"
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }
// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
]

Sem<=>DSynt node_dep_NOarg_NN_Oper_I_NOsibling_lexicon : node_dep_NOarg_fromArg
[
  leftside = [
?Xl {
  sem = ?d
  c:pos = "NN"
  c:lex = ?lex
  ¬c:main_rheme = "yes"
  c:?r-> c:?Yl {}
  ¬c:?t-> c:?Zl {}
}

// ?t maps to an argumental relation
lexicon.?lex.gp.?r.?DSyntR
?DSyntR == I
lexicon.?lex.Oper1.?lexOper
lexicon.?lexOper.lemma.?lemma

// there is no governor above the node, or only an adj/adverb
( ¬c:?Gov1l { c:?r1-> ?Xl {} }
 | ( c:?OGov1l { ( c:pos = "CD" |  c:pos = "JJ" |  c:type = "added"  ) c:?s1-> ?Xl {} } & ¬ ( c:?PGov1l { c:?t1-> ?Xl {} } & ¬ ?t1 == ?s1 )
     // used only one incase there are more than 1 candidates
     & ¬ ( c:?OGov2l { c:id = ?idOG2 ( c:pos = "CD" |  c:pos = "JJ" |  c:type = "added"  ) c:?sOG2-> ?Xl {} } & ?idOG2 < ?OGov1l.id ) 
   )
)

// see COORD1 rule
¬ ( c:?Zl { c:pos ="CC" c:?r3-> c:?Conj3 {} } & (?r3 == A1 | ?r3 == "A1") )

¬ ?d == "duration"
¬ ?d == "manner"
¬ ?d == "routine"
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ¬rc:include = bubble_of_gov
  ATTR->  ?Oper1 {
    <=> ?Xl
    top = "yes"
    consumed_ATTR = ?r
    pos = "VB"
    spos = "VV"
    finiteness = "FIN"
    dlex = ?lemma
    lex = ?lexOper
    type = "support_verb_noIN"
    //clause_type = ?Xl.clause_type
    include = bubble_of_dep
    id = #randInt()#
    II-> ?Xr {
      <=> ?Xl
      in_the_closet = "yes"
      //dep_id = ?Yl.id
      dlex = ?d
      pos = "NN"
      bottom = "yes"
    }
    I-> ?NewYr {
        // TEST 200519
        <=> ?Yl
        pos = ?Yl.pos
        //spos = ?Yl.spos
        dlex = ?Yl.sem
        lex = ?Yl.lex
        include = bubble_of_gov
        id = #randInt()#
        <-> rc:?Yr {}
    }
  }
}
// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }
// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
]

Sem<=>DSynt node_dep_NOarg_NN_Oper_II_NOsibling_lexicon : node_dep_NOarg_fromArg
[
  leftside = [
?Xl {
  sem = ?d
  c:pos = "NN"
  c:lex = ?lex
  ¬c:main_rheme = "yes"
  c:?r-> c:?Yl {}
  ¬c:?t-> c:?Zl {}
}

// ?t maps to an argumental relation
lexicon.?lex.gp.?r.?DSyntR
?DSyntR == II
lexicon.?lex.Oper2.?lexOper
lexicon.?lexOper.lemma.?lemma

// there is no governor above the node, or only an adj/adverb
( ¬c:?Gov1l { c:?r1-> ?Xl {} }
 | ( c:?OGov1l { ( c:pos = "CD" |  c:pos = "JJ" |  c:type = "added"  ) c:?s1-> ?Xl {} } & ¬ ( c:?PGov1l { c:?t1-> ?Xl {} } & ¬ ?t1 == ?s1 )
     // used only one incase there are more than 1 candidates
     & ¬ ( c:?OGov2l { c:id = ?idOG2 ( c:pos = "CD" |  c:pos = "JJ" |  c:type = "added"  ) c:?sOG2-> ?Xl {} } & ?idOG2 < ?OGov1l.id ) 
  )
)

// see COORD1 rule
¬ ( c:?Zl { c:pos ="CC" c:?r3-> c:?Conj3 {} } & (?r3 == A1 | ?r3 == "A1") )

¬ ?d == "duration"
¬ ?d == "manner"
¬ ?d == "routine"
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ¬rc:include = bubble_of_gov
  ATTR->  ?Oper1 {
    <=> ?Xl
    top = "yes"
    consumed_ATTR = ?r
    pos = "VB"
    spos = "VV"
    finiteness = "FIN"
    dlex = ?lemma
    lex = ?lexOper
    type = "support_verb_noIN"
    //clause_type = ?Xl.clause_type
    include = bubble_of_dep
    id = #randInt()#
    II-> ?Xr {
      <=> ?Xl
      in_the_closet = "yes"
      //dep_id = ?Yl.id
      dlex = ?d
      pos = "NN"
      bottom = "yes"
    }
    I-> ?NewYr {
        // TEST 200519
        <=> ?Yl
        pos = ?Yl.pos
        //spos = ?Yl.spos
        dlex = ?Yl.sem
        lex = ?Yl.lex
        include = bubble_of_gov
        id = #randInt()#
        <-> rc:?Yr {}
    }
  }
}
// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }
// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
]

Sem<=>DSynt node_dep_NOarg_NN_Oper_I_sibling_lexicon : node_dep_NOarg_fromArg
[
  leftside = [
?Xl {
  sem = ?d
  c:pos = "NN"
  c:lex = ?lex
  ¬c:main_rheme = "yes"
  ?r-> c:?Yl {}
  ?t-> ?Zl {
    sem = ?d2
  }
}

// ?r maps to I
lexicon.?lex.gp.?r.?DSyntR2
?DSyntR2 == I
// ?t maps to an argumental relation
lexicon.?lex.gp.?t.?DSyntR
¬?DSyntR == ATTR
¬?DSyntR == APPEND
¬?DSyntR == COORD

lexicon.?lex.Oper1.?lexOper
lexicon.?lexOper.lemma.?lemma

// there is no governor above the node, or only an adj/adverb
( ¬c:?Gov1l { c:?r1-> ?Xl {} }
 | ( c:?OGov1l { ( c:pos = "CD" |  c:pos = "JJ" |  c:type = "added"  ) c:?s1-> ?Xl {} }  & ¬ ( c:?PGov1l { c:?t1-> ?Xl {} } & ¬ ?t1 == ?s1 )
     // used only one incase there are more than 1 candidates
     & ¬ ( c:?OGov2l { c:id = ?idOG2 ( c:pos = "CD" |  c:pos = "JJ" |  c:type = "added"  ) c:?sOG2-> ?Xl {} } & ?idOG2 < ?OGov1l.id ) 
   )
)

// see COORD1 rule
¬ ( c:?Zl { c:pos ="CC" c:?r3-> c:?Conj3 {} } & (?r3 == A1 | ?r3 == "A1") )

¬ ?d == "duration"
¬ ?d == "manner"
¬ ?d == "routine"
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ¬rc:include = bubble_of_gov
  ATTR->  ?Oper1 {
    <=> ?Xl
    top = "yes"
    consumed_ATTR = ?r
    pos = "VB"
    spos = "VV"
    finiteness = "FIN"
    dlex = ?lemma
    lex = ?lexOper
    type = "support_verb_noIN"
    //clause_type = ?Xl.clause_type
    include = bubble_of_dep
    id = #randInt()#
    II-> ?Xr {
      <=> ?Xl
      in_the_closet = "yes"
      //dep_id = ?Yl.id
      dlex = ?d
      pos = "NN"
      bottom = "yes"
      ?DSyntR-> ?Zr {
        <=> ?Zl
        dlex = ?d2
      }
    }
    I-> ?NewYr {
        // TEST 200519
        <=> ?Yl
        pos = ?Yl.pos
        //spos = ?Yl.spos
        dlex = ?Yl.sem
        lex = ?Yl.lex
        include = bubble_of_gov
        id = #randInt()#
        <-> rc:?Yr {}
    }
  }
}
// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }
// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
]

Sem<=>DSynt node_dep_NOarg_NN_Oper_I_sibling_lexicon_COORD1 : node_dep_NOarg_fromArg
[
  leftside = [
?Xl {
  sem = ?d
  c:pos = "NN"
  c:lex = ?lex
  ¬c:main_rheme = "yes"
  ?r-> c:?Yl {}
  ?t-> c:?Zl {
    c:pos = "CC"
    c:?r3-> ?Conj3 {
      sem = ?d2
    }
  }
}

(?r3 == A1 | ?r3 == "A1")

// ?r maps to I
lexicon.?lex.gp.?r.?DSyntR2
?DSyntR2 == I
// ?t maps to an argumental relation
lexicon.?lex.gp.?t.?DSyntR
¬?DSyntR == ATTR
¬?DSyntR == APPEND
¬?DSyntR == COORD

lexicon.?lex.Oper1.?lexOper
lexicon.?lexOper.lemma.?lemma

// there is no governor above the node, or only an adj/adverb
( ¬c:?Gov1l { c:?r1-> ?Xl {} }
 | ( c:?OGov1l { ( c:pos = "CD" |  c:pos = "JJ" |  c:type = "added"  ) c:?s1-> ?Xl {} }  & ¬ ( c:?PGov1l { c:?t1-> ?Xl {} } & ¬ ?t1 == ?s1 )
     // used only one incase there are more than 1 candidates
     & ¬ ( c:?OGov2l { c:id = ?idOG2 ( c:pos = "CD" |  c:pos = "JJ" |  c:type = "added"  ) c:?sOG2-> ?Xl {} } & ?idOG2 < ?OGov1l.id ) 
   )
)

¬ ?d == "duration"
¬ ?d == "manner"
¬ ?d == "routine"
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ¬rc:include = bubble_of_gov
  ATTR->  ?Oper1 {
    <=> ?Xl
    top = "yes"
    consumed_ATTR = ?r
    pos = "VB"
    spos = "VV"
    finiteness = "FIN"
    dlex = ?lemma
    lex = ?lexOper
    type = "support_verb_noIN"
    //clause_type = ?Xl.clause_type
    include = bubble_of_dep
    id = #randInt()#
    II-> ?Xr {
      <=> ?Xl
      in_the_closet = "yes"
      //dep_id = ?Yl.id
      dlex = ?d
      pos = "NN"
      bottom = "yes"
      ?DSyntR-> ?Conj3R {
        <=> ?Conj3
        dlex = ?d2
      }
    }
    I-> ?NewYr {
        // TEST 200519
        <=> ?Yl
        pos = ?Yl.pos
        //spos = ?Yl.spos
        dlex = ?Yl.sem
        lex = ?Yl.lex
        include = bubble_of_gov
        id = #randInt()#
        <-> rc:?Yr {}
    }
  }
}
// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }
// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
]

Sem<=>DSynt node_dep_NOarg_NN_Oper_not_I_sibling_lexicon : node_dep_NOarg_fromArg
[
  leftside = [
?Xl {
  sem = ?d
  c:pos = "NN"
  c:lex = ?lex
  ¬c:main_rheme = "yes"
  ?r-> c:?Yl {}
  ?t-> ?Zl {
    sem = ?d2
  }
}

// ?r maps to an argumental relation
lexicon.?lex.gp.?r.?DSyntR
¬?DSyntR == ATTR
¬?DSyntR == APPEND
¬?DSyntR == COORD
¬?DSyntR == I
// there is an argument 1 below ?Xl
lexicon.?lex.gp.?t.I
lexicon.?lex.Oper1.?lexOper
lexicon.?lexOper.lemma.?lemma

// there is no governor above the node, or only an adj/adverb
( ¬c:?Gov1l { c:?r1-> ?Xl {} }
 | ( c:?OGov1l { ( c:pos = "CD" |  c:pos = "JJ" |  c:type = "added"  ) c:?s1-> ?Xl {} }  & ¬ ( c:?PGov1l { c:?t1-> ?Xl {} } & ¬ ?t1 == ?s1 )
     // used only one incase there are more than 1 candidates
     & ¬ ( c:?OGov2l { c:id = ?idOG2 ( c:pos = "CD" |  c:pos = "JJ" |  c:type = "added"  ) c:?sOG2-> ?Xl {} } & ?idOG2 < ?OGov1l.id ) 
   )
)

// see COORD1 rule
¬ ( c:?Zl { c:pos ="CC" c:?r3-> c:?Conj3 {} } & (?r3 == A1 | ?r3 == "A1") )

¬ ?d == "duration"
¬ ?d == "manner"
¬ ?d == "routine"
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ¬rc:include = bubble_of_gov
  ATTR->  ?Oper1 {
    <=> ?Xl
    top = "yes"
    consumed_ATTR = ?r
    pos = "VB"
    spos = "VV"
    finiteness = "FIN"
    dlex = ?lemma
    lex = ?lexOper
    type = "support_verb_noIN"
    //clause_type = ?Xl.clause_type
    include = bubble_of_dep
    id = #randInt()#
    II-> ?Xr {
      <=> ?Xl
      in_the_closet = "yes"
      //dep_id = ?Yl.id
      dlex = ?d
      pos = "NN"
      bottom = "yes"
      ?DSyntR-> ?NewYr {
        // TEST 200519
        <=> ?Yl
        pos = ?Yl.pos
        //spos = ?Yl.spos
        // add spos here cos the rule that adds spos only applies to node that have a LS correspondence.
        spos = ?Yl.pos
        dlex = ?Yl.sem
        lex = ?Yl.lex
        include = bubble_of_gov
        id = #randInt()#
        <-> rc:?Yr {}
      }
    }
    I-> ?Zr {
      <=> ?Zl
      dlex = ?d2
    }
  }
}
// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }
// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
]

Sem<=>DSynt node_dep_NOarg_NN_Oper_not_I_sibling_lexicon_COORD1 : node_dep_NOarg_fromArg
[
  leftside = [
?Xl {
  sem = ?d
  c:pos = "NN"
  c:lex = ?lex
  ¬c:main_rheme = "yes"
  ?r-> c:?Yl {}
  ?t-> c:?Zl {
    c:pos = "CC"
    c:?r3-> ?Conj3 {
      sem = ?d2
    }
  }
}

(?r3 == A1 | ?r3 == "A1")

// ?r maps to an argumental relation
lexicon.?lex.gp.?r.?DSyntR
¬?DSyntR == ATTR
¬?DSyntR == APPEND
¬?DSyntR == COORD
¬?DSyntR == I
// there is an argument 1 below ?Xl
lexicon.?lex.gp.?t.I
lexicon.?lex.Oper1.?lexOper
lexicon.?lexOper.lemma.?lemma

// there is no governor above the node, or only an adj/adverb
( ¬c:?Gov1l { c:?r1-> ?Xl {} }
 | ( c:?OGov1l { ( c:pos = "CD" |  c:pos = "JJ" |  c:type = "added"  ) c:?s1-> ?Xl {} }  & ¬ ( c:?PGov1l { c:?t1-> ?Xl {} } & ¬ ?t1 == ?s1 )
     // used only one incase there are more than 1 candidates
     & ¬ ( c:?OGov2l { c:id = ?idOG2 ( c:pos = "CD" |  c:pos = "JJ" |  c:type = "added"  ) c:?sOG2-> ?Xl {} } & ?idOG2 < ?OGov1l.id ) 
   )
)

¬ ?d == "duration"
¬ ?d == "manner"
¬ ?d == "routine"
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ¬rc:include = bubble_of_gov
  ATTR->  ?Oper1 {
    <=> ?Xl
    top = "yes"
    consumed_ATTR = ?r
    pos = "VB"
    spos = "VV"
    finiteness = "FIN"
    dlex = ?lemma
    lex = ?lexOper
    type = "support_verb_noIN"
    //clause_type = ?Xl.clause_type
    include = bubble_of_dep
    id = #randInt()#
    II-> ?Xr {
      <=> ?Xl
      in_the_closet = "yes"
      //dep_id = ?Yl.id
      dlex = ?d
      pos = "NN"
      bottom = "yes"
      ?DSyntR-> ?NewYr {
        // TEST 200519
        <=> ?Yl
        pos = ?Yl.pos
        //spos = ?Yl.spos
        // add spos here cos the rule that adds spos only applies to node that have a LS correspondence.
        //spos = ?Yl.pos
        dlex = ?Yl.sem
        lex = ?Yl.lex
        include = bubble_of_gov
        id = #randInt()#
        <-> rc:?Yr {}
      }
    }
    I-> ?Conj3R {
      <=> ?Conj3
      dlex = ?d2
    }
  }
}
// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }
// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
]

Sem<=>DSynt node_dep_NOarg_NN_Oper_I_sibling_default : node_dep_NOarg_fromArg
[
  leftside = [
?Xl {
  sem = ?d
  c:pos = "NN"
  c:lex = ?lex
  ¬c:main_rheme = "yes"
  ?r-> c:?Yl {}
  ?t-> ?Zl {
    sem = ?d2
  }
}

//language.id.iso.EN

// ?r maps to I
lexicon.?lex.gp.?r.?DSyntR2
lexicon.miscellaneous.support_verb.Oper1.?lexOp
lexicon.?lexOp.lemma.?lemOp
lexicon.?lexOp.spos.?sposOp
?DSyntR2 == I
// ?t maps to an argumental relation
lexicon.?lex.gp.?t.?DSyntR
¬?DSyntR == ATTR
¬?DSyntR == APPEND
¬?DSyntR == COORD

¬ ( lexicon.?lex2.Oper1.?lexOper & ?lex2 == ?lex )

// there is no governor above the node, or only an adj/adverb
( ¬c:?Gov1l { c:?r1-> ?Xl {} }
 | ( c:?OGov1l { ( c:pos = "CD" |  c:pos = "JJ" |  c:type = "added"  ) c:?s1-> ?Xl {} }  & ¬ ( c:?PGov1l { c:?t1-> ?Xl {} } & ¬ ?t1 == ?s1 )
     // used only one incase there are more than 1 candidates
     & ¬ ( c:?OGov2l { c:id = ?idOG2 ( c:pos = "CD" |  c:pos = "JJ" |  c:type = "added"  ) c:?sOG2-> ?Xl {} } & ?idOG2 < ?OGov1l.id ) 
   )
)

// see COORD1 rule
¬ ( c:?Zl { c:pos ="CC" c:?r3-> c:?Conj3 {} } & (?r3 == A1 | ?r3 == "A1") )

¬ ?d == "duration"
¬ ?d == "manner"
¬ ?d == "routine"
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ¬rc:include = bubble_of_gov
  ATTR->  ?Oper1 {
    <=> ?Xl
    top = "yes"
    consumed_ATTR = ?r
    pos = "VB"
    spos = ?sposOp
    finiteness = "FIN"
    dlex = ?lemOp
    lex = ?lexOp
    type = "support_verb_noIN"
    //clause_type = ?Xl.clause_type
    include = bubble_of_dep
    id = #randInt()#
    II-> ?Xr {
      <=> ?Xl
      in_the_closet = "yes"
      //dep_id = ?Yl.id
      dlex = ?d
      pos = "NN"
      bottom = "yes"
      ?DSyntR-> ?Zr {
        <=> ?Zl
        dlex = ?d2
      }
    }
    I-> ?NewYr {
        // TEST 200519
        <=> ?Yl
        pos = ?Yl.pos
        //spos = ?Yl.spos
        dlex = ?Yl.sem
        lex = ?Yl.lex
        include = bubble_of_gov
        id = #randInt()#
        <-> rc:?Yr {}
    }
  }
}
// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }
// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
]

/*BUG: can't have the same variable name in positive and negative condition with lexicons??*/
Sem<=>DSynt node_dep_NOarg_NN_Oper_not_I_sibling_default : node_dep_NOarg_fromArg
[
  leftside = [
?Xl {
  sem = ?d
  c:pos = "NN"
  c:lex = ?lex
  ¬c:main_rheme = "yes"
  ?r-> c:?Yl {}
  ?t-> ?Zl {
    sem = ?d2
  }
}

//language.id.iso.EN

// ?r maps to an argumental relation
lexicon.?lex.gp.?r.?DSyntR
¬?DSyntR == ATTR
¬?DSyntR == APPEND
¬?DSyntR == COORD
¬?DSyntR == I
// there is an argument 1 below ?Xl
lexicon.?lex.gp.?t.I
lexicon.miscellaneous.support_verb.Oper1.?lexOp
lexicon.?lexOp.lemma.?lemOp
lexicon.?lexOp.spos.?sposOp
// see Comments above
¬ ( lexicon.?lex1.Oper1 & ?lex1 == ?lex )

// there is no governor above the node, or only an adj/adverb
( ¬c:?Gov1l { c:?r1-> ?Xl {} }
 | ( c:?OGov1l { ( c:pos = "CD" |  c:pos = "JJ" |  c:type = "added"  ) c:?s1-> ?Xl {} }  & ¬ ( c:?PGov1l { c:?t1-> ?Xl {} } & ¬ ?t1 == ?s1 )
     // used only one incase there are more than 1 candidates
     & ¬ ( c:?OGov2l { c:id = ?idOG2 ( c:pos = "CD" |  c:pos = "JJ" |  c:type = "added"  ) c:?sOG2-> ?Xl {} } & ?idOG2 < ?OGov1l.id ) 
   )
)
// see COORD1 rule
¬ ( c:?Zl { c:pos ="CC" c:?r3-> c:?Conj3 {} } & (?r3 == A1 | ?r3 == "A1") )

¬ ?d == "duration"
¬ ?d == "manner"
¬ ?d == "routine"
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ¬rc:include = bubble_of_gov
  ATTR->  ?Oper1 {
    <=> ?Xl
    top = "yes"
    consumed_ATTR = ?r
    pos = "VB"
    spos = ?sposOp
    finiteness = "FIN"
    dlex = ?lemOp
    lex = ?lexOp
    type = "support_verb_noIN"
    //clause_type = ?Xl.clause_type
    include = bubble_of_dep
    id = #randInt()#
    II-> ?Xr {
      <=> ?Xl
      in_the_closet = "yes"
      //dep_id = ?Yl.id
      dlex = ?d
      pos = "NN"
      bottom = "yes"
      ?DSyntR-> ?NewYr {
        // TEST 200519
        <=> ?Yl
        pos = ?Yl.pos
        // add spos here cos the rule that adds spos only applies to node that have a LS correspondence.
        //spos = ?Yl.pos
        dlex = ?Yl.sem
        lex = ?Yl.lex
        include = bubble_of_gov
        id = #randInt()#
        <-> rc:?Yr {}
      }
    }
    I-> ?Zr {
      <=> ?Zl
      dlex = ?d2
    }
  }
}
// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }
// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
]

/*BUG: can't have the same variable name in positive and negative condition with lexicons??
Rules of this type missing for ?Yl of this rule and other rules in the same group.*/
Sem<=>DSynt node_dep_NOarg_NN_Oper_not_I_sibling_default_COORD1 : node_dep_NOarg_fromArg
[
  leftside = [
?Xl {
  sem = ?d
  c:pos = "NN"
  c:lex = ?lex
  ¬c:main_rheme = "yes"
  ?r-> c:?Yl {}
  ?t-> c:?Zl {
    c:pos = "CC"
    c:?r3-> ?Conj3 {
      sem = ?d2
    }
  }
}

language.id.iso.EN

(?r3 == A1 | ?r3 == "A1")

// ?r maps to an argumental relation
lexicon.?lex.gp.?r.?DSyntR
¬?DSyntR == ATTR
¬?DSyntR == APPEND
¬?DSyntR == COORD
¬?DSyntR == I
// there is an argument 1 below ?Xl
lexicon.?lex.gp.?t.I
lexicon.miscellaneous.support_verb.Oper1.?lexOp
lexicon.?lexOp.lemma.?lemOp
lexicon.?lexOp.spos.?sposOp
// see Comments above
¬ ( lexicon.?lex1.Oper1 & ?lex1 == ?lex )

// there is no governor above the node, or only an adj/adverb
( ¬c:?Gov1l { c:?r1-> ?Xl {} }
 | ( c:?OGov1l { ( c:pos = "CD" |  c:pos = "JJ" |  c:type = "added"  ) c:?s1-> ?Xl {} }  & ¬ ( c:?PGov1l { c:?t1-> ?Xl {} } & ¬ ?t1 == ?s1 )
     // used only one incase there are more than 1 candidates
     & ¬ ( c:?OGov2l { c:id = ?idOG2 ( c:pos = "CD" |  c:pos = "JJ" |  c:type = "added"  ) c:?sOG2-> ?Xl {} } & ?idOG2 < ?OGov1l.id ) 
   )
)

¬ ?d == "duration"
¬ ?d == "manner"
¬ ?d == "routine"
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ¬rc:include = bubble_of_gov
  ATTR->  ?Oper1 {
    <=> ?Xl
    top = "yes"
    consumed_ATTR = ?r
    pos = "VB"
    spos = ?sposOp
    finiteness = "FIN"
    dlex = ?lemOp
    lex = ?lexOp
    type = "support_verb_noIN"
    //clause_type = ?Xl.clause_type
    include = bubble_of_dep
    id = #randInt()#
    II-> ?Xr {
      <=> ?Xl
      in_the_closet = "yes"
      //dep_id = ?Yl.id
      dlex = ?d
      pos = "NN"
      bottom = "yes"
      ?DSyntR-> ?NewYr {
        // TEST 200519
        <=> ?Yl
        pos = ?Yl.pos
        // add spos here cos the rule that adds spos only applies to node that have a LS correspondence.
        // spos = ?Yl.pos
        dlex = ?Yl.sem
        lex = ?Yl.lex
        include = bubble_of_gov
        id = #randInt()#
        <-> rc:?Yr {}
      }
    }
    I-> ?Conj3R {
      <=> ?Conj3
      dlex = ?d2
    }
  }
}
// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }
// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
]

Sem<=>DSynt node_dep_NOarg_NN_Oper_I_NOA1_NOsibling_lexicon : node_dep_NOarg_fromArg
[
  leftside = [
?Xl {
  sem = ?d
  c:pos = "NN"
  c:lex = ?lex
  ¬c:main_rheme = "yes"
  c:?r-> c:?Yl {}
  ¬c:?t-> c:?Zl {}
}

// ?t maps to an argumental relation
lexicon.?lex.gp.?r.?DSyntR
?DSyntR == II
lexicon.?lex.Oper1.?lexOper
lexicon.?lexOper.lemma.?lemma
lexicon.?lex.gp.II.prep.?prep

// there is no governor above the node, or only an adj/adverb
( ¬c:?Gov1l { c:?r1-> ?Xl {} }
 | ( c:?OGov1l { ( c:pos = "CD" |  c:pos = "JJ" |  c:type = "added"  ) c:?s1-> ?Xl {} }  & ¬ ( c:?PGov1l { c:?t1-> ?Xl {} } & ¬ ?t1 == ?s1 )
     // used only one incase there are more than 1 candidates
     & ¬ ( c:?OGov2l { c:id = ?idOG2 ( c:pos = "CD" |  c:pos = "JJ" |  c:type = "added"  ) c:?sOG2-> ?Xl {} } & ?idOG2 < ?OGov1l.id ) 
   )
)

// see COORD1 rule
¬ ( c:?Zl { c:pos ="CC" c:?r3-> c:?Conj3 {} } & (?r3 == A1 | ?r3 == "A1") )

¬ ?d == "duration"
¬ ?d == "manner"
¬ ?d == "routine"
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ¬rc:include = bubble_of_gov
  ATTR->  ?Oper1 {
    <=> ?Xl
    top = "yes"
    consumed_ATTR = ?r
    pos = "VB"
    spos = "VV"
    finiteness = "FIN"
    dlex = ?lemma
    lex = ?lexOper
    type = "support_verb_noIN"
    //clause_type = ?Xl.clause_type
    include = bubble_of_dep
    id = #randInt()#
    I-> ?Xr {
      <=> ?Xl
      in_the_closet = "yes"
      //dep_id = ?Yl.id
      dlex = ?d
      pos = "NN"
      bottom = "yes"
    }
    II-> ?NewYr {
        // TEST 200519
        <=> ?Yl
        pos = ?Yl.pos
        //spos = ?Yl.spos
        dlex = ?Yl.sem
        lex = ?Yl.lex
        include = bubble_of_gov
        id = #randInt()#
        subcat_prep = ?prep
        GovLex = ?lexOper
        <-> rc:?Yr {}
    }
  }
}
// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }
// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
]

/*The kind of modifier created here should be as independent as possible.
For instance, don't  le the dep_arg_coref rule apply in this case.
That's why we need to mark this type of ATTR for now.*/
Sem<=>DSynt EN_node_dep_NOarg_NN_country : node_dep_NOarg_fromArg
[
  leftside = [
?Xl {
  sem = ?d
  c:pos = "NP"
  c:class = "country"
  ¬c:main_rheme = "yes"
  A1-> c:?Yl {}
}

// ?r maps to an argumental relation

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ¬rc:include = bubble_of_gov
  ATTR-> ?of {
    dlex = "of"
    lex = "of_IN_01"
    pos = "IN"
    include = bubble_of_gov
    in_the_closet = "yes"
    II-> ?Xr {
      <=> ?Xl
      consumed_ATTR = A1
      in_the_closet = "yes"
      //dep_id = ?Yl.id
      dlex = ?d
      pos = "NN"
    }
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }
// ?Yl hasn't already been used by another rel  rule with the same node
¬ ( rc:?Yr {rc:consumed_ARG=?s rc:gov_id=?gid} & ?s == ?r & ?gid == ?Xl.id)
  ]
]

Sem<=>DSynt node_dep_NOarg_CC : node_dep_NOarg_fromArg
[
  leftside = [
?Xl {
  c:pos = "CC"
  ¬c:A1-> c:?A1l {}
  c:A2-> c:?B1l {}
  ¬c:A3-> c:?C1l {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?B1r {
  rc:<=> ?B1l
  ¬rc:top = "yes"
  ¬rc:include = bubble_of_gov
  APPEND-> ?Xr {
    <=> ?Xl
    dlex = ?Xl.sem
    lex = ?Xl.lex
    pos = ?Xl.pos
    include = bubble_of_gov
    type = "parenthetical"
  }
}

¬rc:?Noder { rc:<=> ?Xl }
  ]
]

/*Cases in which the A2 has been built before the A1.*/
Sem<=>DSynt node_dep_NOarg_prep_inv : node_dep_NOarg_fromArg
[
  leftside = [
?Xl {
  sem = ?d1
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
// if the node has a pos, in a T2T context it must have been a real word originally (purpose is an exception in some structures)
// UPDATE: creates overlaps, obviously... refine this "purpose" thing when the case is found again
  //( ¬c:pos = ?p | sem = "purpose" )
  c:pos = "IN"
  A2-> c:?Yl {
  }
  A1-> ?Zl {
    sem = ?d2
    ¬c:pos = "IN"
    ¬c:pos = "RB"
    // see pointTime_AMR
    ¬c:date_type = ?dt
  }
}

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
¬ ( ?Zl { c:pos = "CC" c:?rel-> c:?Conjunct2 {} } & (?rel == A1 | ?rel == "A1"))
¬ ( ?Yl { c:pos = "CC" c:?rel2-> c:?Conjunct3 {} } & (?rel2 == A1 | ?rel2 == "A1"))

// RULES FOR COORDINATIONS ARE MISSING!!!
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?Zr {
    <=> ?Zl
    // I never remember why I use these... Commented bc seems to affect the generation (Canton Tower V4Design examples)
    //consumed_ATTR = A2
    dlex = ?d2
    //inverted_sem = "yes"
    ATTR-> ?Xr {
      <=> ?Xl
      dlex = ?d1
    }
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Zl }
  ]
]

/*If a node is not in the lexicon, we have no information wrt the argument mapping.
In this case we introduce an APPEND.
Verbs are excluded (see NOlexicon_VB).*/
Sem<=>DSynt node_dep_NOarg_NOlexicon_basic : node_dep_NOarg_NOlexicon
[
  leftside = [
c:?Gov {
  ?r-> ?Dep {
    sem = ?d
    ¬c:dsyntRel = ATTR
  }
}

//see dep_arg rules
¬ ( c:?Gov { c:lex = ?lex } & lexicon.?lex.gp.?r.?DSyntR1 )
// see COORD rules
¬ ( ?Dep.pos == "CC" )
¬ ( ?Gov.pos == "CC" )
// see dep_NOarg_CD
¬ ( ?Gov.pos == "CD" )
// see dep_NOarg_PATCH_JJ_RB/DT_PRP
¬ ( ?Gov.pos == "JJ" | ?Gov.pos == "RB" | ?Gov.pos == "DT" | ?Gov.pos == "PRP$" )
//see dep_arg_lexicon_lex_IN
¬ ( ( ?Gov.pos == "IN" | ?Gov.pos == "TO" ) & lexicon._preposition_.gp.?r.?DSyntR2 )
//see dep_arg_lexicon_lex_NN
¬ ( ?Gov.pos == "NN" & ?Dep.pos == "JJ" )
//see dep_arg_copy_rel_NAME
¬ ?r == NAME
//see dep_NOarg_possessive + NOarg_meta +NOarg_ELAB
¬ (?Gov.type == META | ?Gov.type == "added"| ?Gov.sem == "ELABORATION")
//see dep_NOarg_sem_prp
¬ ( c:?Gov { c:sem = ?d1 } & semanticon.?d1.gen.lex.?lex1 )
//see dep_NOarg_pointTime
¬ ?Gov.sem == "point_time"

// see dep_NOarg_NOlexicon_I; if a verb is not in the lexicon, it cannot have an external argument, but I leave it just in case
¬ ( c:?Gov { c:pos = "VB" } & (?r == A0 | ?r == A1 | ?r == A2 | ?r == A3 | ?r == A4 | ?r == A5 ) )

¬ ( ?r == A3 & ?Gov.sem == "between" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Gov
  ¬rc:top = "yes"
  APPEND-> ?Yr {
    <=> ?Dep
    consumed_ARG = ?r
    gov_id = ?Xl.id
    dlex = ?d
    //pos = ?pos
    //lex = #?d+_+?pos+_+?pv#
  }
}

// ?Yl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Dep }
// ?Xl hasn't already been used by another rel  rule
¬ ( rc:?Xr {rc:consumed_ATTR=?s } & ?s == ?r )
  ]
]

/*see dep_NOarg_NOlexicon.
If a verb is not in the lexicon, it cannot have an external argument, so for now we use predicate w/o exte arg as reference mapping.*/
Sem<=>DSynt node_dep_NOarg_NOlexicon_VB : node_dep_NOarg_NOlexicon
[
  leftside = [
c:?Gov {
  c:pos = "VB"
  ?r-> ?Dep {
    sem = ?d
  }
}

(?r == A0 | ?r == A1 | ?r == A2 | ?r == A3 | ?r == A4 | ?r == A5 )
lexicon._predicateNoExtArg_.gp.?r.?DSyntR

//see dep_arg rules
¬ ( c:?Gov { c:lex = ?lex } & lexicon.?lex.gp.?r.?DSyntR1 )
// see COORD rules
¬ ( ?Dep.pos == "CC" )
¬ ( ?Gov.pos == "CC" )
// see dep_NOarg_CD
¬ ( ?Gov.pos == "CD" )
// see dep_NOarg_PATCH_JJ_RB/DT_PRP
¬ ( ?Gov.pos == "JJ" | ?Gov.pos == "RB" | ?Gov.pos == "DT" | ?Gov.pos == "PRP$" )
//see dep_arg_lexicon_lex_IN
¬ ( ( ?Gov.pos == "IN" | ?Gov.pos == "TO" ) & lexicon._preposition_.gp.?r.?DSyntR2 )
//see dep_arg_copy_rel_NAME
¬ ?r == NAME
//see dep_NOarg_possessive + NOarg_meta +NOarg_ELAB
¬ (?Gov.type == META | ?Gov.type == "added"| ?Gov.sem == "ELABORATION")
//see dep_NOarg_sem_prp
¬ ( c:?Gov { c:sem = ?d1 } & semanticon.?d1.gen.lex.?lex1 )
//see dep_NOarg_pointTime
¬ ?Gov.sem == "point_time"
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Gov
  ¬rc:top = "yes"
  ?DSyntR-> ?Yr {
    <=> ?Dep
    consumed_ARG = ?r
    gov_id = ?Xl.id
    dlex = ?d
    //pos = ?pos
    //lex = #?d+_+?pos+_+?pv#
  }
}

// ?Yl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Dep }
// ?Xl hasn't already been used by another rel  rule
¬ ( rc:?Xr {rc:consumed_ATTR=?s } & ?s == ?r )
  ]
]

/*If the dependent is NOT in the lexicon.
BUG INHERITANCE DICO: this rule is for JJ and RB*/
Sem<=>DSynt node_dep_NOarg_PATCH_JJ_RB : node_dep_NOarg_NOlexicon
[
  leftside = [
c:?Xl {
  ¬c:main_rheme = "yes"
  c:sem = ?d
  c:lex = ?lex
  c:pos = ?pos
  ?r-> c:?Yl {
  }
}

// See comments in rule node_dep_NOarg_lexicon_PATCH
//¬ ( lexicon.?lex1.gp.?r.?DSyntR  & ?lex1 == ?lex )
¬ ( c:?Xl { c:lex = ?lex2 } & lexicon.?lex2.gp.?r.?DSyntR )
¬ ( c:?Xl { c:sem = ?d2 } & semanticon.?d2 )

( ?pos == "JJ" | ?pos == "RB" )


// do not transfer this relation for an adjective that is A2+ from a coordination conjunction (copied from below)
¬ ( c:?Conjunction { c:pos = "CC" c:?rel-> ?Xl {} } & ¬(?rel == A1 | ?rel == "A1"))
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?Xr {
    <=> ?Xl
    dlex = ?d
    pos = ?pos
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Xl }
  ]
]

/*THE PATCH FOR JJ doesn't work!
DT example: PTB_eval_1*/
Sem<=>DSynt node_dep_NOarg_PATCH_DT_PRP : node_dep_NOarg_NOlexicon
[
  leftside = [
c:?Xl {
  ¬c:main_rheme = "yes"
  c:sem = ?d
  c:lex = ?lex
  c:pos = ?pos
  ?r-> c:?Yl {
  }
}

¬lexicon.?lex.gp.?r.?DSyntR
¬semanticon.?d
( ?pos == "DT" | ?pos == "PRP$" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?Xr {
    <=> ?Xl
    dlex = ?d
    pos = ?pos
  }
}

// ?Xl hasn't already been transferred by another rule
//¬rc:?NOdeR { rc:<=> ?Xl }
  ]
]

/*see dep_NOarg_NOlexicon.
If a verb is not in the lexicon, it cannot have an external argument, so for now we use predicate w/o exte arg as reference mapping.*/
Sem<=>DSynt node_dep_NOarg_NOlexicon_NN : node_dep_NOarg_NOlexicon
[
  leftside = [
c:?Gov {
  c:pos = "NN"
  ?r-> ?Dep {
    sem = ?d
    ( c:pos = "JJ" | c:dsyntRel = ATTR )
  }
}

¬?r == NAME
¬ ( c:?Gov { c:lex = ?lex } & lexicon.?lex.gp.?r.?DSyntR1 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Gov
  ¬rc:top = "yes"
  ATTR-> ?Yr {
    <=> ?Dep
    consumed_ARG = ?r
    gov_id = ?Xl.id
    dlex = ?d
    //pos = ?pos
    //lex = #?d+_+?pos+_+?pv#
  }
}

// ?Yl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Dep }
// ?Xl hasn't already been used by another rel  rule
¬ ( rc:?Xr {rc:consumed_ATTR=?s } & ?s == ?r )
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node.
Exclude nodes which are in the semanticon; special rules for these cases.
RULE FOR THE DEMO.*/
Sem<=>DSynt DE_node_dep_NOarg_sem : DE_transfer_node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = ?d1
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
  A1-> c:?Yl {
  }
  A2-> ?Zl {
    sem = ?d2
    ¬c:pos = "RB"
  }
}

// see node_dep_NOarg_sem_usually
¬(?d1 == "manner" & ?d2 == "routine")
  
semanticon.?d1.gen.lex.?lex
lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos

language.id.iso.DE

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
¬ ( ?Zl { c:pos = "CC" c:?rel-> c:?Conjunct2 {} } & (?rel == A1 | ?rel == "A1"))
¬ ( ?Yl { c:pos = "CC" c:?rel2-> c:?Conjunct3 {} } & (?rel2 == A1 | ?rel2 == "A1"))
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?Wr {
    dlex = ?lem
    lex = ?lex
    pos = ?pos
    include = bubble_of_dep
    meaning = ?d1
    id = #randInt()#
    II-> ?Zr {
      <=> ?Zl
      dlex = ?d2
    }
  }
}
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node.
Exclude nodes which are in the semanticon; special rules for these cases.
RULE FOR THE DEMO.*/
Sem<=>DSynt DE_node_dep_NOarg_sem_COORD_A2 : DE_transfer_node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = ?d1
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
  A1-> c:?Yl {
  }
  A2-> c:?Zl {
    ¬c:pos = "RB"
  }
}

// see node_dep_NOarg_sem_usually
¬(?d1 == "manner" & ?d2 == "routine")
  
semanticon.?d1.gen.lex.?lex
lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos

language.id.iso.DE

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
( ?Zl { c:pos = "CC" c:?rel-> c:?Conjunct2 { c:sem = ?d2 } } & (?rel == A1 | ?rel == "A1"))
¬ ( ?Yl { c:pos = "CC" c:?rel2-> c:?Conjunct3 {} } & (?rel2 == A1 | ?rel2 == "A1"))
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?Wr {
    dlex = ?lem
    lex = ?lex
    pos = ?pos
    include = bubble_of_gov
    meaning = ?d1
    id = #randInt()#
    II-> ?Zr {
      <=> ?Conjunct2
      dlex = ?d2
    }
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Conjunct2 }
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node.
Exclude nodes which are in the semanticon; special rules for these cases.
RULE FOR THE DEMO.*/
Sem<=>DSynt DE_node_dep_NOarg_sem_duration_hours : DE_transfer_node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = ?d1
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
  A1-> c:?Yl {
  }
  A2-> ?Zl {
    sem = ?d2
  }
}

semanticon.?d1.gen.lex.?lex

language.id.iso.DE

(?d1 == "duration" & ?d2 == "6 Stunden")
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR->  ?Zr {
    <=> ?Zl
    dlex = "6 Stunden"
    dpos = "NP"
    spos = "proper_noun"
  }
}
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node.
Exclude nodes which are in the semanticon; special rules for these cases.
RULE FOR THE DEMO.
RULES FOR COORDINATIONS ARE MISSING!!!*/
Sem<=>DSynt EN_node_dep_NOarg_sem_usually : EN_transfer_node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = ?d1
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
  A1-> c:?Yl {
  }
  A2-> ?Zl {
    sem = ?d2
  }
}

semanticon.?d1.gen.lex.?lex

language.id.iso.EN

(?d1 == "manner" & ?d2 == "routine")

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
¬ ( ?Yl { c:pos = "CC" c:?rel1-> c:?Conjunct1 {} } & (?rel1 == A1 | ?rel1 == "A1"))

// RULES FOR COORDINATIONS ARE MISSING!!!
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR->  ?Zr {
    <=> ?Zl
    dlex = "usually"
    dpos = "RB"
    pos = "RB"
    spos = "adverb"
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Zl }
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node.
Exclude nodes which are in the semanticon; special rules for these cases.
RULE FOR THE DEMO.
RULES FOR COORDINATIONS ARE MISSING!!!*/
Sem<=>DSynt EN_node_dep_NOarg_pointTime_VB : EN_transfer_node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = "point_time"
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
  A1-> c:?Yl {
  }
  A2-> ?Zl {
    sem = ?d2
    c:pos = "VB"
  }
}

language.id.iso.EN


// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
¬ ( ?Zl { c:pos = "CC" c:?rel-> c:?Conjunct2 {} } & (?rel == A1 | ?rel == "A1"))
¬ ( ?Yl { c:pos = "CC" c:?rel2-> c:?Conjunct3 {} } & (?rel2 == A1 | ?rel2 == "A1"))
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?Wr {
    dlex = "when"
    lex = "when_RB_01"
    pos = "RB"
    include = bubble_of_gov
    meaning = "point_time"
    id = #randInt()#
    II-> ?Zr {
      <=> ?Zl
      dlex = ?d2
    }
  }
}
// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Zl }
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node.
Exclude nodes which are in the semanticon; special rules for these cases.
RULE FOR THE DEMO.
RULES FOR COORDINATIONS ARE MISSING!!!*/
Sem<=>DSynt EN_node_dep_NOarg_pointTime_AMR : EN_transfer_node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = "point_time"
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
  A1-> c:?Yl {
  }
  A2-> ?Zl {
    sem = ?d2
    c:date_type = ?dt
  }
}

language.id.iso.EN

lexicon.miscellaneous.AMR_date.?dt.prep.?prep

lexicon.?prep.lemma.?lem
lexicon.?prep.pos.?pos

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
¬ ( ?Zl { c:pos = "CC" c:?rel-> c:?Conjunct2 {} } & (?rel == A1 | ?rel == "A1"))
¬ ( ?Yl { c:pos = "CC" c:?rel2-> c:?Conjunct3 {} } & (?rel2 == A1 | ?rel2 == "A1"))
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?Wr {
    dlex = ?lem
    lex = ?prep
    pos = ?pos
    include = bubble_of_gov
    meaning = "point_time"
    id = #randInt()#
    II-> ?Zr {
      <=> ?Zl
      dlex = ?d2
    }
  }
}
// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Zl }
  ]
]

/*Not sure it is a great rule.
If a duration node which is not a metanode points to a node that's not a noun, realize it as an attributive relation.*/
Sem<=>DSynt EN_node_dep_NOarg_sem_duration : EN_transfer_node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = ?d1
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
  ¬c:type = META
  A1-> c:?Yl {}
  A2-> ?Zl {}
}

semanticon.?d1.gen.lex.?lex
lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos
lexicon.?lex.pos.?spos

language.id.iso.EN

?d1 == "duration"

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
¬ ( ?Yl { c:pos = "CC" c:?rel1-> c:?Conjunct1 {} } & (?rel1 == A1 | ?rel1 == "A1"))

// RULES FOR COORDINATIONS ARE MISSING!!!
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR->   ?Wr {
    dlex = ?lem
    dpos = ?pos
    pos = ?pos
    spos = ?spos
    include = bubble_of_gov
    meaning = "point_time"
    id = #randInt()#
    II-> ?Zr {
      <=> ?Zl
      dlex = ?Zl.sem
    }
  }
}
// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Zl }
  ]
]

Sem<=>DSynt EN_node_add_relative_inverted_sem_Loc : EN_transfer_node_dep_NOarg_semantemes
[
  leftside = [
c:?Xl {
  ¬c:pos = ?p
  c:A2-> c:?Yl {
  }
  c:A1-> c:?Zl {
  }
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  rc:ATTR-> rc:?Zr {
    rc:<=> ?Zl
    rc:pos = "VB"
    rc:meaning = "locative_relation"
    rc:inverted_sem = "yes"
    rc:?R-> rc:?DepR {}
    finiteness = "FIN"
    ATTR-> ?PrepR {
      pos = "IN"
      spos = "preposition"
      dlex = "in"
      lex = "in_IN_01"
      include = bubble_of_gov
      id = #randInt()#
      II-> ?RelPro {
        pos = "WDT"
        spos = relative_pronoun
        dlex = "which"
        lex = "which_WDT_01"
        id = #randInt()#
        <-> rc:?Yr {}
      }
    }
  }
}

( ?R == I | ( ?R == II & rc:?Zr { ¬rc:I-> rc:?depZr {} } ) )

rc:?Bubble { rc:?Yr { rc:<=> ?Yl } ?RelPro {} }
  ]
]

excluded Sem<=>DSynt EN_node_dep_NOarg_semanteme_others : EN_transfer_node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = ?sem
  c:type = META
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
  A1-> c:?Yl {
  }
  A2-> ?Zl {
    sem = ?d2
    ¬c:date_type = ?dt
  }
}

language.id.iso.EN

//lexicon.miscellaneous.AMR_date.?dt.prep.?prep
semanticon.sem.gen.lex.?lex

lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos

// see NOarg_meta
¬ ( ?Zl.pos == "IN" | ?Zl.pos == "RB" )

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
¬ ( ?Zl { c:pos = "CC" c:?rel-> c:?Conjunct2 {} } & (?rel == A1 | ?rel == "A1"))
¬ ( ?Yl { c:pos = "CC" c:?rel2-> c:?Conjunct3 {} } & (?rel2 == A1 | ?rel2 == "A1"))
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ATTR-> ?Wr {
    dlex = ?lem
    lex = ?prep
    pos = ?pos
    include = bubble_of_dep
    meaning = ?sem
    II-> ?Zr {
      <=> ?Zl
      dlex = ?d2
    }
  }
}
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node.
Exclude nodes which are in the semanticon; special rules for these cases.
RULE FOR THE DEMO.
RULES FOR COORDINATIONS ARE MISSING!!!*/
excluded Sem<=>DSynt EN_node_dep_NOarg_Locin : EN_transfer_node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = "locative_relation"
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
// if the node has a pos, in a T2T context it must have been a real word originally (purpose is an exception in some structures)
// UPDATE: creates overlaps, obviously... refine this "purpose" thing when the case is found again
  //( ¬c:pos = ?p | sem = "purpose" )
  ¬c:pos = ?p
  A1-> c:?Yl {}
  A2-> ?Zl {
    sem = ?d2
    ¬c:pos = "IN"
    ¬c:pos = "RB"
    // see pointTime_AMR
    ¬c:date_type = ?dt
    c:lex = ?zlex
  }
}

lexicon.?zlex.Locin.?loc

lexicon.?loc.lemma.?lem
lexicon.?loc.pos.?pos

language.id.iso.EN

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
¬ ( ?Zl { c:pos = "CC" c:?rel-> c:?Conjunct2 {} } & (?rel == A1 | ?rel == "A1"))
¬ ( ?Yl { c:pos = "CC" c:?rel2-> c:?Conjunct3 {} } & (?rel2 == A1 | ?rel2 == "A1"))

// RULES FOR COORDINATIONS ARE MISSING!!!
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?Wr {
    dlex = ?lem
    lex = ?loc
    pos = ?pos
    include = bubble_of_gov
    meaning = "locative_relation"
    id = #randInt()#
    II-> ?Zr {
      <=> ?Zl
      dlex = ?d2
    }
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Zl }
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node.
Exclude nodes which are in the semanticon; special rules for these cases.
RULE FOR THE DEMO.*/
Sem<=>DSynt ES_node_dep_NOarg_sem_prp : ES_transfer_node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = ?d1
  A1-> c:?Yl {
  }
  A2-> ?Zl {
    sem = ?d2
    ¬c:pos = "IN"
    ¬c:pos = "RB"
  }
}

semanticon.?d1
?d1 == "purpose"

language.id.iso.ES
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?Wr {
    dlex = "para"
    lex = "para_IN_01"
    pos = "IN"
    include = bubble_of_dep
    meaning = ?d1
    II-> ?Zr {
      <=> ?Zl
      dlex = ?d2
    }
  }
}
  ]
]

Sem<=>DSynt ES_node_add_relative_inverted_sem_Loc : ES_transfer_node_dep_NOarg_semantemes
[
  leftside = [
c:?Xl {
  ¬c:pos = ?p
  c:A2-> c:?Yl {
  }
  c:A1-> c:?Zl {
  }
}

language.id.iso.ES
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  rc:ATTR-> rc:?Zr {
    rc:<=> ?Zl
    rc:pos = "VB"
    rc:meaning = "locative_relation"
    rc:inverted_sem = "yes"
    rc:?R-> rc:?DepR {}
    finiteness = "FIN"
    ATTR-> ?PrepR {
      pos = "WRB"
      spos = "relative_pronoun"
      dlex = "donde"
      lex = "donde_WRB_01"
      include = bubble_of_gov
      id = #randInt()#
      <-> rc:?Yr {}
    }
  }
}

( ?R == I | ?R == II )

//rc:?Bubble { rc:?Yr { rc:<=> ?Yl } ?RelPro {} }
  ]
]

/*Exactly same rule as EN counterpart. Now covered by language-independent rule node_dep_NOarg_sem_prep*/
excluded Sem<=>DSynt IT_node_dep_NOarg_sem : IT_transfer_node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = ?d1
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
// if the node has a pos, in a T2T context it must have been a real word originally (purpose is an exception in some structures)
// UPDATE: creates overlaps, obviously... refine this "purpose" thing when the case is found again
  //( ¬c:pos = ?p | sem = "purpose" )
  ¬c:pos = ?p
  A1-> c:?Yl {}
  A2-> ?Zl {
    sem = ?d2
    ¬c:pos = "IN"
    ¬c:pos = "RB"
    // see pointTime_AMR
    ¬c:date_type = ?dt
  }
}

semanticon.?d1.gen.lex.?lex
lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos

language.id.iso.IT

¬(?d1 == "manner" & ?d2 == "routine")
¬(?d1 == "frequency" & ?d2 == "sometimes")

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
¬ ( ?Zl { c:pos = "CC" c:?rel-> c:?Conjunct2 {} } & (?rel == A1 | ?rel == "A1"))
¬ ( ?Yl { c:pos = "CC" c:?rel2-> c:?Conjunct3 {} } & (?rel2 == A1 | ?rel2 == "A1"))

// RULES FOR COORDINATIONS ARE MISSING!!!

¬ ( ?Zl.pos == "VB" & ?d1 == "point_time" )

// See dep_NOarg_Locin
¬ ( ?d1 == "locative_relation" & ?Zl.lex == ?zlex & lexicon.?zlex.Locin.?loc )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?Wr {
    dlex = ?lem
    lex = ?lex
    pos = ?pos
    include = bubble_of_gov
    meaning = ?d1
    id = #randInt()#
    II-> ?Zr {
      <=> ?Zl
      dlex = ?d2
    }
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Zl }
  ]
]

/*Exactly same rule as EN counterpart.
NOT TESTED!*/
Sem<=>DSynt IT_node_dep_NOarg_sem_inv : IT_transfer_node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = ?d1
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
// if the node has a pos, in a T2T context it must have been a real word originally (purpose is an exception in some structures)
// UPDATE: creates overlaps, obviously... refine this "purpose" thing when the case is found again
  //( ¬c:pos = ?p | sem = "purpose" )
  ¬c:pos = ?p
  A2-> c:?Yl {
  }
  A1-> ?Zl {
    sem = ?d2
    ¬c:pos = "IN"
    ¬c:pos = "RB"
    // see pointTime_AMR
    ¬c:date_type = ?dt
  }
}

semanticon.?d1.gen.lex.?lex
lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos

language.id.iso.IT

¬(?d1 == "manner" & ?d2 == "routine")
¬(?d1 == "frequency" & ?d2 == "sometimes")

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
¬ ( ?Zl { c:pos = "CC" c:?rel-> c:?Conjunct2 {} } & (?rel == A1 | ?rel == "A1"))
¬ ( ?Yl { c:pos = "CC" c:?rel2-> c:?Conjunct3 {} } & (?rel2 == A1 | ?rel2 == "A1"))

// RULES FOR COORDINATIONS ARE MISSING!!!

¬ ( ?Zl.pos == "VB" & ?d1 == "point_time" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?Zr {
      <=> ?Zl
      dlex = ?d2
      meaning = ?d1
      inverted_sem = "yes"
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Zl }
  ]
]

/*Exactly same rule as EN counterpart.
NOT TESTED!*/
Sem<=>DSynt IT_node_dep_NOarg_sem_COORD_A1 : IT_transfer_node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = ?d1
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
// if the node has a pos, in a T2T context it must have been a real word originally (purpose is an exception in some structures)
// UPDATE: creates overlaps, obviously... refine this "purpose" thing when the case is found again
  //( ¬c:pos = ?p | sem = "purpose" )
  ¬c:pos = ?p
  A1-> c:?Yl {}
  A2-> ?Zl {
    sem = ?d2
    ¬c:pos = "IN"
    ¬c:pos = "RB"
    // see pointTime_AMR
    ¬c:date_type = ?dt
  }
}

semanticon.?d1.gen.lex.?lex
lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos

language.id.iso.IT

¬(?d1 == "manner" & ?d2 == "routine")
¬(?d1 == "frequency" & ?d2 == "sometimes")

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
¬ ( c:?Zl { c:pos = "CC" c:?rel-> c:?Conjunct2 {} } & (?rel == A1 | ?rel == "A1"))
( c:?Yl { c:pos = "CC" c:?rel2-> c:?Conjunct3 {} } & (?rel2 == A1 | ?rel2 == "A1"))

¬ ( ?Zl.pos == "VB" & ?d1 == "point_time" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Conjunct3
  ¬rc:top = "yes"
  ATTR-> ?Wr {
    dlex = ?lem
    lex = ?lex
    pos = ?pos
    include = bubble_of_gov
    meaning = ?d1
    id = #randInt()#
    II-> ?Zr {
      <=> ?Zl
      dlex = ?d2
    }
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Zl }
  ]
]

/*Exactly same rule as EN counterpart.
NOT TESTED!*/
Sem<=>DSynt IT_node_dep_NOarg_sem_COORD_A2 : IT_transfer_node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = ?d1
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
// if the node has a pos, in a T2T context it must have been a real word originally (purpose is an exception in some structures)
// UPDATE: creates overlaps, obviously... refine this "purpose" thing when the case is found again
  //( ¬c:pos = ?p | sem = "purpose" )
  ¬c:pos = ?p
  A1-> c:?Yl {}
  A2-> c:?Zl {
    // see pointTime_AMR
    ¬c:date_type = ?dt
  }
}

semanticon.?d1.gen.lex.?lex
lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos

language.id.iso.IT

¬(?d1 == "manner" & ?d2 == "routine")
¬(?d1 == "frequency" & ?d2 == "sometimes")

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
( c:?Zl { c:pos = "CC" c:?rel-> ?Conjunct2 {sem = ?d2 ¬c:pos = "IN" ¬c:pos = "RB" } } & (?rel == A1 | ?rel == "A1") )
¬(?Yl {c:pos = "CC" c:?rel2-> c:?Conjunct3 {}} & (?rel2 == A1 | ?rel2 == "A1"))
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?Wr {
    dlex = ?lem
    lex = ?lex
    pos = ?pos
    include = bubble_of_gov
    meaning = ?d1
    id = #randInt()#
    II-> ?ConjunctR {
      <=> ?Conjunct2
      dlex = ?d2
    }
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Conjunct2 }
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node.
Exclude nodes which are in the semanticon; special rules for these cases.
RULE FOR THE DEMO.
RULES FOR COORDINATIONS ARE MISSING!!!*/
excluded Sem<=>DSynt IT_node_dep_NOarg_sem_usually : IT_transfer_node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = ?d1
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
  A1-> c:?Yl {
  }
  A2-> ?Zl {
    sem = ?d2
  }
}

semanticon.?d1.gen.lex.?lex

language.id.iso.IT

(?d1 == "manner" & ?d2 == "routine")

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
¬ ( ?Yl { c:pos = "CC" c:?rel1-> c:?Conjunct1 {} } & (?rel1 == A1 | ?rel1 == "A1"))

// RULES FOR COORDINATIONS ARE MISSING!!!
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR->  ?Zr {
    <=> ?Zl
    dlex = "usually"
    dpos = "RB"
    pos = "RB"
    spos = "adverb"
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Zl }
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node.
Exclude nodes which are in the semanticon; special rules for these cases.
RULE FOR THE DEMO.
RULES FOR COORDINATIONS ARE MISSING!!!*/
excluded Sem<=>DSynt IT_node_dep_NOarg_pointTime_VB : IT_transfer_node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = "point_time"
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
  A1-> c:?Yl {
  }
  A2-> ?Zl {
    sem = ?d2
    c:pos = "VB"
  }
}

language.id.iso.IT


// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
¬ ( ?Zl { c:pos = "CC" c:?rel-> c:?Conjunct2 {} } & (?rel == A1 | ?rel == "A1"))
¬ ( ?Yl { c:pos = "CC" c:?rel2-> c:?Conjunct3 {} } & (?rel2 == A1 | ?rel2 == "A1"))
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?Wr {
    dlex = "when"
    lex = "when_RB_01"
    pos = "RB"
    include = bubble_of_gov
    meaning = "point_time"
    id = #randInt()#
    II-> ?Zr {
      <=> ?Zl
      dlex = ?d2
    }
  }
}
// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Zl }
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node.
Exclude nodes which are in the semanticon; special rules for these cases.
RULE FOR THE DEMO.
RULES FOR COORDINATIONS ARE MISSING!!!*/
excluded Sem<=>DSynt IT_node_dep_NOarg_pointTime_AMR : IT_transfer_node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = "point_time"
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
  A1-> c:?Yl {
  }
  A2-> ?Zl {
    sem = ?d2
    c:date_type = ?dt
  }
}

language.id.iso.IT

lexicon.miscellaneous.AMR_date.?dt.prep.?prep

lexicon.?prep.lemma.?lem
lexicon.?prep.pos.?pos

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
¬ ( ?Zl { c:pos = "CC" c:?rel-> c:?Conjunct2 {} } & (?rel == A1 | ?rel == "A1"))
¬ ( ?Yl { c:pos = "CC" c:?rel2-> c:?Conjunct3 {} } & (?rel2 == A1 | ?rel2 == "A1"))
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?Wr {
    dlex = ?lem
    lex = ?prep
    pos = ?pos
    include = bubble_of_gov
    meaning = "point_time"
    id = #randInt()#
    II-> ?Zr {
      <=> ?Zl
      dlex = ?d2
    }
  }
}
// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Zl }
  ]
]

/*Exactly same rule as EN counterpart.
NOT TESTED!*/
Sem<=>DSynt IT_node_dep_NOarg_sem_duration : IT_transfer_node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = ?d1
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
  ¬c:type = META
  A1-> c:?Yl {}
  A2-> ?Zl {}
}

semanticon.?d1.gen.lex.?lex
lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos
lexicon.?lex.pos.?spos

language.id.iso.IT

?d1 == "duration"

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
¬ ( ?Yl { c:pos = "CC" c:?rel1-> c:?Conjunct1 {} } & (?rel1 == A1 | ?rel1 == "A1"))

// RULES FOR COORDINATIONS ARE MISSING!!!
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR->   ?Wr {
    dlex = ?lem
    dpos = ?pos
    pos = ?pos
    spos = ?spos
    include = bubble_of_gov
    meaning = "point_time"
    id = #randInt()#
    II-> ?Zr {
      <=> ?Zl
      dlex = ?Zl.sem
    }
  }
}
// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Zl }
  ]
]

/*Exactly same rule as EN counterpart.
NOT TESTED!*/
Sem<=>DSynt IT_node_dep_NOarg_semanteme_others : IT_transfer_node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = ?sem
  c:type = META
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
  A1-> c:?Yl {
  }
  A2-> ?Zl {
    sem = ?d2
    ¬c:date_type = ?dt
  }
}

language.id.iso.IT

//lexicon.miscellaneous.AMR_date.?dt.prep.?prep
semanticon.sem.gen.lex.?lex

lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos

// see NOarg_meta
¬ ( ?Zl.pos == "IN" | ?Zl.pos == "RB" )

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
¬ ( ?Zl { c:pos = "CC" c:?rel-> c:?Conjunct2 {} } & (?rel == A1 | ?rel == "A1"))
¬ ( ?Yl { c:pos = "CC" c:?rel2-> c:?Conjunct3 {} } & (?rel2 == A1 | ?rel2 == "A1"))
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ATTR-> ?Wr {
    dlex = ?lem
    lex = ?prep
    pos = ?pos
    include = bubble_of_dep
    meaning = ?sem
    II-> ?Zr {
      <=> ?Zl
      dlex = ?d2
    }
  }
}
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node.
Exclude nodes which are in the semanticon; special rules for these cases.
RULE FOR THE DEMO.*/
Sem<=>DSynt PL_node_dep_NOarg_sem : PL_transfer_node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = ?d1
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
  A1-> c:?Yl {
  }
  A2-> ?Zl {
    sem = ?d2
    ¬c:pos = "RB"
  }
}

// see node_dep_NOarg_sem_usually
¬(?d1 == "manner" & ?d2 == "routine")
//¬ ( ?Xl.sem == "duration" & ?Zl.sem == "6 godzin"  )
¬ ( ?Xl.sem == "frequency" & ( ?Zl.sem == "czasami" | ?Zl.sem == "1" ) )
  
semanticon.?d1.gen.lex.?lex
lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos

language.id.iso.PL

// see sem_raz_miedzy
( ¬?Zl.pos == "IN"
  | ( ?Zl { sem = "między" c:A2-> c:?ZA2l {} c:A3-> c:?ZA3l {} }
  & ¬ ( ?ZA2l.sem == "0" | ?ZA2l.sem > "0" ) & ¬ ( ?ZA3l.sem == "0" | ?ZA3l.sem > "0" ) )
)

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
¬ ( ?Zl { c:pos = "CC" c:?rel-> c:?Conjunct2 {} } & (?rel == A1 | ?rel == "A1"))
¬ ( ?Yl { c:pos = "CC" c:?rel2-> c:?Conjunct3 {} } & (?rel2 == A1 | ?rel2 == "A1"))
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?Wr {
    dlex = ?lem
    lex = ?lex
    pos = ?pos
    include = bubble_of_dep
    meaning = ?d1
    id = #randInt()#
    II-> ?Zr {
      <=> ?Zl
      dlex = ?d2
    }
  }
}
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node.
Exclude nodes which are in the semanticon; special rules for these cases.
RULE FOR THE DEMO.*/
Sem<=>DSynt PL_node_dep_NOarg_sem_COORD_A2 : PL_transfer_node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = ?d1
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
  A1-> c:?Yl {
  }
  A2-> c:?Zl {
    ¬c:pos = "RB"
  }
}

// see node_dep_NOarg_sem_usually
¬(?d1 == "manner" & ?d2 == "routine")
//¬ ( ?Xl.sem == "duration" & ?Zl.sem == "6 godzin"  )
¬ ( ?Xl.sem == "frequency" & ( ?Zl.sem == "czasami" | ?Zl.sem == "1" ) )
  
semanticon.?d1.gen.lex.?lex
lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos

language.id.iso.PL

// see sem_raz_miedzy
( ¬?Zl.pos == "IN"
  | ( ?Zl { sem = "między" c:A2-> c:?ZA2l {} c:A3-> c:?ZA3l {} }
  & ¬ ( ?ZA2l.sem == "0" | ?ZA2l.sem > "0" ) & ¬ ( ?ZA3l.sem == "0" | ?ZA3l.sem > "0" ) )
)

// The dependent is not a cordinating conjunction
//¬ ( ?Yl { c:pos = "CC" c:A1-> c:?Conjunct1 {} } ) 
( ?Zl { c:pos = "CC" c:?rel-> c:?Conjunct2 { c:sem = ?d2 } } & (?rel == A1 | ?rel == "A1"))
¬ ( ?Yl { c:pos = "CC" c:?rel2-> c:?Conjunct3 {} } & (?rel2 == A1 | ?rel2 == "A1"))
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?Wr {
    dlex = ?lem
    lex = ?lex
    pos = ?pos
    include = bubble_of_gov
    meaning = ?d1
    id = #randInt()#
    II-> ?Zr {
      <=> ?Conjunct2
      dlex = ?d2
    }
  }
}

// ?Xl hasn't already been transferred by another rule
¬rc:?NOdeR { rc:<=> ?Conjunct2 }
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node.
Exclude nodes which are in the semanticon; special rules for these cases.
RULE FOR THE DEMO.*/
Sem<=>DSynt PL_node_dep_NOarg_sem_raz_miedzy : PL_transfer_node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = ?d1
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
  A1-> c:?Yl {
  }
  A2-> ?Zl {
    ¬c:pos = "RB"
  }
}

// see node_dep_NOarg_sem_usually
¬(?d1 == "manner" & ?d2 == "routine")
//¬ ( ?Xl.sem == "duration" & ?Zl.sem == "6 godzin"  )
¬ ( ?Xl.sem == "frequency" & ( ?Zl.sem == "czasami" | ?Zl.sem == "1" ) )
  
semanticon.?d1.gen.lex.?lex
lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos

language.id.iso.PL

( ?Zl { sem = "między" c:A2-> c:?ZA2l { sem = ?d2 } c:A3-> c:?ZA3l {} }
  & ( ?ZA2l.sem == "0" | ?ZA2l.sem > "0" ) & ( ?ZA3l.sem == "0" | ?ZA3l.sem > "0" ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?Wr {
    dlex = ?lem
    lex = ?lex
    pos = ?pos
    include = bubble_of_gov
    meaning = ?d1
    case = "gen"
    ATTR-> ?Zr {
      <=> ?ZA2l
      dlex = ?d2
    }
  }
}
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node.
Exclude nodes which are in the semanticon; special rules for these cases.
RULE FOR THE DEMO.*/
Sem<=>DSynt PL_node_dep_NOarg_sem_freq_usually : PL_transfer_node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = ?d1
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
  A1-> c:?Yl {
  }
  A2-> ?Zl {
    sem = ?d2
  }
}

semanticon.?d1.gen.lex.?lex

language.id.iso.PL

(?d1 == "manner" & ?d2 == "routine")
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR->  ?Zr {
    <=> ?Zl
    dlex = "zwykle"
    dpos = "RB"
    spos = "adverb"
  }
}
  ]
]

/*If the governor is a "real" semanteme or an ELABORATION node.
Exclude nodes which are in the semanticon; special rules for these cases.
RULE FOR THE DEMO.*/
Sem<=>DSynt PL_node_dep_NOarg_sem_freq_once : PL_transfer_node_dep_NOarg_semantemes
[
  leftside = [
?Xl {
  sem = ?d1
// the word corresponding to the semanteme is not already in the structure
  ¬c:semanteme = "realized"
  A1-> c:?Yl {
  }
  A2-> ?Zl {
    sem = "1"
    ¬c:pos = "IN"
    ¬c:pos = "RB"
  }
}

?d1 == "frequency"
semanticon.?d1.gen.lex.?lex
lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos

language.id.iso.PL
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:top = "yes"
  ATTR-> ?Wr {
    dlex = ?lem
    lex = ?lex
    pos = ?pos
    include = bubble_of_gov
    meaning = ?d1
  }
}
  ]
]

