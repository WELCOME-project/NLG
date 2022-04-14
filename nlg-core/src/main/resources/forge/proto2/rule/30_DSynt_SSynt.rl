DSynt<=>SSynt transfer_nodes
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*For nodes that have no LS correspondences but that must be included in the RS bubble anyway.*/
DSynt<=>SSynt expand_bubbles
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DSynt<=>SSynt transfer_relations
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DSynt<=>SSynt transfer_attributes
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DSynt<=>SSynt anaphora_resolution
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DSynt<=>SSynt weight
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DSynt<=>SSynt markers
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DSynt<=>SSynt transfer_node_basic : transfer_nodes
[
  leftside = [
?Xl {
  ¬c:?ContainedNode {}
  ¬c:blocked = "YES"
  //¬tem_constituency=?tc
  //¬voice="PASS"
  ¬modality=?m
  ¬slex="ROOT"
  //c:lex = ?lex1
}

( ¬?Xl { c:tem_constituency = ?tc } | language.syntax.verbform.synthetic
  | ( language.id.iso.DE & ?Xl { c:tem_constituency = "PROGR" } )
  | ( language.id.iso.ES & ?Xl { ( c:tem_constituency = "IMP" | c:tem_constituency = "PERF-S" ) } )
  | ( language.id.iso.CA & ?Xl { c:tem_constituency = "IMP" } ) 
)
  
( ¬?Xl { c:voice = "PASS" } | language.syntax.verbform.synthetic | language.syntax.voice.synthetic )

// why was that? ¬ (language.id.iso.EN & c:?Yl {¬c:pos="IN" c:II-> ?Xl {finiteness="FIN"}} )
 ( ¬ ( language.id.iso.EN & ?Xl.finiteness == "INF" ) | c:?Y0l {c:lex = "to_IN_01" c:?r0-> c:?Xl {} } )

// Generalize this to all languages? Testing now on catalan. If generalized, should be merged with first part of gov prep condition below
// Problem is: it may be an overkill. Maybe handle complex prepositions differently, with a dedicated rule or with a "cheat" lemma in the lexicon
// (e.g. "next to" instead of "next" subcategorizing "to")
¬ ( language.id.iso.CA
    & c:?Gov10 { c:pos = "IN" c:lex=?lex10 c:?r10-> ?Xl {}} & lexicon.?lex10.gp.?r10.prep )

// do not generate elements which have governed prepositions
(
¬( c:?Gov {c:lex=?lex2 c:?r-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB"  | c:pos = "CD" | c:pos = "PRP" | c:pos = "JJ" | c:pos = "WP") }} & lexicon.?lex2.gp.?r.prep )
 //exclude control and raise verbs when introducing a preposition "to" on a non verbal element
 | ( c:?GovA { c:lex = ?lexa c:dlex = ?lema c:?ra-> ?Xl { ¬c:pos = "VB" } } & control_raise.?type.lex.?lema & lexicon.?lexa.gp.?ra.prep.?preplex & ?preplex == "to" & ¬ ( lexicon.?lexa.gp.?ra.prep.?preplex2 & ¬?preplex2 == "to" ) )
 // we ignore "by" in the lexicon since it is introduced in rel_I_OBJ
 | (c:?GovX {c:lex=?lex3 c:I-> ?Xl {}} & lexicon.?lex3.gp.I.prep.?prep & ?prep == "by")
 // also for verbs and their first argument, don't introduce preps (see comment in EN_transfer_node_IN_governed)
 | ( c:?GovKK { c:pos = "VB" c:I-> ?Xl {} } )
 // we generate a normal node when a second argument will be mapped to a subject
 //update: desactivated; see IN_governed_II_pass
  | ( ( c:?GovZ {c:?s-> ?Xl {} c:voice = "PASS"} & ?s == II ) & ¬language.id.iso.EN )
 // we ignore cases of prepositions associated to a dative shift
 | (c:?GovY {c:?tY-> ?Xl {} c:dative_shift = "DO"} & ?tY== III)
// if the noun is genitive and has a coreference, it will be pronominalized
 |  ( ( language.id.iso.EN | language.id.iso.PT ) & c:?Xl { c:case = "GEN" c:<-> c:?Antecedent {} ¬c:ambiguous_antecedent = "yes" ¬c:?r13-> c:?D13 {} } & ¬c:?Gov12 { c:definiteness = "INDEF" c:?r12-> c:?Xl {} } )
 |  (language.id.iso.EN &  ?Xl.case == "GEN" & ?Xl.pos == "PRP")
)
// don't transfer arg1 of a verb that is already an argument of the verb above
¬ ( c:?GGov1l {c:pos = "VB" c:?r1-> c:?Gov1l { c:pos = "VB" c:I-> c:?Xl {} } c:?r2-> c:?Dep1l {} }
   & ( c:?Xl {<-> c:?Dep1l {} } | c:?Dep1l {<-> c:?Xl {} } )
)

//see transfer_node_that
( ¬ ( language.id.iso.EN & c:?Gov3 {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  ) c:?r3-> ?Xl { c:finiteness = "FIN" ¬ c:?rWP-> c:?WP { c:pos = "WP" } } } & (?r3 == II | ?r3 == III | ?r3 == IV ) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } } )
( ¬ ( language.id.iso.FR & c:?Gov4 {¬ ( c:pos = "IN" | c:dlex = "quand" | c:dlex = "que") c:?r4-> ?Xl { c:finiteness = "FIN" } } & (?r4 == II | ?r4 == III ) )
 | c:?ConjN4l { c:finiteness = "FIN" c:COORD-> c:?CoordN4 { c:II-> ?Xl {} } } )
( ¬ ( language.id.iso.ES & c:?Gov5 {¬ ( c:pos = "IN" | c:dlex = "cuando" | c:dlex = "que") c:?r5-> ?Xl { c:finiteness = "FIN" } } & (?r5 == II | ?r5== III ) )
 | c:?ConjN5l { c:finiteness = "FIN" c:COORD-> c:?CoordN5 { c:II-> ?Xl {} } } )
( ¬ ( language.id.iso.IT & c:?Gov6 {¬ ( c:pos = "IN" | c:dlex = "quando" | c:dlex = "che") c:?r6-> ?Xl { c:finiteness = "FIN" } } & (?r6 == II | ?r6== III ) )
 | c:?ConjN6l { c:finiteness = "FIN" c:COORD-> c:?CoordN6 { c:II-> ?Xl {} } } )
¬ ( language.id.iso.PL & c:?Gov2 {¬c:pos = "IN" c:II-> ?Xl { c:finiteness = "FIN" } } )
( ¬ ( language.id.iso.DE & c:?Gov7 {¬ ( c:pos = "IN" | c:dlex = "wenn" | c:dlex = "dass") c:?r7-> ?Xl { c:finiteness = "FIN" } } & (?r7 == I | ?r7 == II | ?r7 == III ) )
 | c:?ConjN7l { c:finiteness = "FIN" c:COORD-> c:?CoordN7 { c:II-> ?Xl {} } } )
( ¬ ( language.id.iso.CA & c:?Gov8 {¬ ( c:pos = "IN" | c:dlex = "quan" | c:dlex = "que") c:?r8-> ?Xl { c:finiteness = "FIN" } } & (?r8 == II | ?r8== III ) )
 | c:?ConjN8l { c:finiteness = "FIN" c:COORD-> c:?CoordN8 { c:II-> ?Xl {} } } )
( ¬ ( language.id.iso.EL & c:?Gov9 {¬ ( c:pos = "IN" | c:dlex = "όταν" | c:dlex = "ότι" | c:dlex = "ώστε" | c:dlex = "πως") c:?r9-> ?Xl { c:finiteness = "FIN" } } & (?r9 == II | ?r9== III ) )
 | c:?ConjN9l { c:finiteness = "FIN" c:COORD-> c:?CoordN9 { c:II-> ?Xl {} } } )
( ¬ ( language.id.iso.PT & c:?Gov11 {¬ ( c:pos = "IN" | c:dlex = "quando" | c:dlex = "que") c:?r11-> ?Xl { c:finiteness = "FIN" } } & (?r11 == II | ?r11== III ) )
 | c:?ConjN11l { c:finiteness = "FIN" c:COORD-> c:?CoordN11 { c:II-> ?Xl {} } } )

// see transfer_node_DO_neg
¬ ( ?Xl { c:pos = "VB" c:finiteness = "FIN" ¬c:dlex = "be" c:ATTR-> c:?Neg3 { c:dlex = "not" } } )
//see transfer_node_IN_governed_inStr
( ¬ ( c:?Gov7l { c:lex = ?lex7 c:?rg7-> c:?Xl { c:subcat_prep = ?spx7 c:GovLex = ?glx7 } } & ?lex7 == ?glx7 )
// if the noun is genitive and has a coreference, it will be pronominalized
 |  ( ( language.id.iso.EN | language.id.iso.PT ) & c:?Xl { c:case = "GEN" c:<-> c:?Antecedent2 {} ¬c:ambiguous_antecedent = "yes" ¬c:?r13-> c:?D13 {} } & ¬c:?Gov13 { c:definiteness = "INDEF" c:?r13-> c:?Xl {} } )
 |  (language.id.iso.EN &  ?Xl.case == "GEN" & ?Xl.pos == "PRP")
)
// see transfer_node_DO_interrogative
¬ ( ?Xl { c:pos = "VB" c:finiteness = "FIN" ¬c:dlex = "be" c:clause_type="INT" } )


¬ ( c:?Grandma8 { c:lex = ?lex8 c:?rg8-> c:?Gov8l { c:APPEND-> c:?Xl { c:subcat_prep = ?spx8 c:GovLex = ?glx8 } } } & ?lex8 == ?glx8 )
¬ ( c:?Grandma9 { c:lex = ?lex9 c:?rg9-> c:?Gov9l { c:?rg92-> c:?Xl { c:meaning = "ELABORATION" c:subcat_prep = ?spx9 c:GovLex = ?glx9 } } } & ?lex9 == ?glx9 )
// see node Locin
// ¬( c:?Gov6 {c:lex=?lex6 c:?r6-> ?Xl {} } & lexicon.?lex6.gp.?r6.prep.Locin )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex=?Xl.dlex
//  lemma=?Xl.lemma
  pos=?Xl.pos
//  spos=?Xl.spos
//  id=?Xl.id
//  number=?Xl.number
//  tense=?Xl.tense
//  finiteness=?Xl.finiteness
}
  ]
]

DSynt<=>SSynt transfer_node_oper : transfer_nodes
[
  leftside = [
?Xl {
  dlex = "Oper1"
  c:II-> c:?Yl {
    c:lex = ?lex
  }
}

lexicon.?lex.Oper1.?value
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex=?value
  pos=?Xl.pos
}
  ]
]

DSynt<=>SSynt transfer_node_reflexive : transfer_nodes
[
  leftside = [
c:?Xl {
  c:lex = ?lex
}

lexicon.?lex.reflexive.yes
lexicon._reflexive_pronoun_.lemma.?l
lexicon._reflexive_pronoun_.rel.?r
//lexicon.reflexive_pronoun.dpos.?d
lexicon._reflexive_pronoun_.spos.?s
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ( ¬rc:top = yes
 | rc:spos = auxiliary | rc:spos = "auxiliary" )
  ¬rc:middle = yes
  ?r-> ?Refl {
    slex = ?l
    //dpos = ?d
    pos = ?s
    spos = ?s
    include = bubble_of_gov
    }
}

( rc:?Xr { ¬rc:bottom = yes } | ¬rc:?GovR { ( rc:spos = auxiliary | rc:spos = "auxiliary" ) rc:?R-> rc:?Xr {} } )

// There isn't already a relflexive
¬ ( rc:?Xr { rc:?s1-> rc:?Refl1 { rc:slex = ?l1 } } & ?s1 == ?r & ?l1 == ?l )
  ]
]

DSynt<=>SSynt transfer_node_new_lemma : transfer_nodes
[
  leftside = [
c:?Xl {
  c:lex = ?lex1
  c:pos = ?pos
}
lexicon.?lex1.form.?form
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:pos = ?pos2
  slex=?form
}

?pos2 == ?pos
  ]
]

DSynt<=>SSynt transfer_node_bubble : transfer_nodes
[
  leftside = [
?Bub {
  dlex = ?d
  c:?Xl {}
}
  ]
  mixed = [

  ]
  rightside = [
?BubR {
  <=> ?Bub
  slex = ?d
  rc:+?Xr {
    rc:<=> ?Xl
  }
}
  ]
]

DSynt<=>SSynt CA_transfer_node_multi_corresp : transfer_nodes
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DSynt<=>SSynt DE_transfer_node_multi_corresp : transfer_nodes
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DSynt<=>SSynt EL_transfer_node_multi_corresp : transfer_nodes
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*Rules with aux and modal do not need to exclude negation dependent, since no "do" needs to be introduced.*/
DSynt<=>SSynt EN_transfer_node_multi_corresp : transfer_nodes
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DSynt<=>SSynt ES_transfer_node_multi_corresp : transfer_nodes
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DSynt<=>SSynt IT_transfer_node_multi_corresp : transfer_nodes
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DSynt<=>SSynt FR_transfer_node_multi_corresp : transfer_nodes
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DSynt<=>SSynt PL_transfer_node_multi_corresp : transfer_nodes
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DSynt<=>SSynt PT_transfer_node_multi_corresp : transfer_nodes
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DSynt<=>SSynt EN_transfer_node_caseGEN : transfer_nodes
[
  leftside = [
c:?Xl {
  c:case = "GEN"
  ¬c:pos = "PRP"
  ¬c:pos = "PRP$"
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:pronominalized = yes
  ¬rc:slex = "its"
  ¬rc:slex = "whose"
  ¬rc:pos = "IN"
  // so the rule applies later
  rc:depth = ?sp
  ¬rc:suffix = introduced
  suffix = introduced
  SUFFIX-> ?Pos {
    slex = "'s"
    lex = "'s_POS_01"
    pos = "POS"
    spos = "genitive"
    include = bubble_of_gov
  }
}

¬rc:?OfR {
  ( rc:slex = "of" | rc:slex = "at" )
  rc:PMOD-> rc:?Xr {
    rc:<=> ?Xl
  }
}
  ]
]

DSynt<=>SSynt EN_transfer_node_ordinal_1 : transfer_nodes
[
  leftside = [
c:?Xl {
  ( c:dlex = "1" | c:dlex = "11" | c:dlex = "21" | c:dlex = "31" | c:dlex = "41" | c:dlex = "51"
   | c:dlex = "61" | c:dlex = "71" | c:dlex = "81" | c:dlex = "91" | c:dlex = "101" )
  c:type = "ordinal"
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:slex = ?s
  ¬rc:ordinal = done
  ordinal = done
  slex = #?s+st#
}
  ]
]

DSynt<=>SSynt EN_transfer_node_ordinal_2 : transfer_nodes
[
  leftside = [
c:?Xl {
  ( c:dlex = "2" | c:dlex = "22" | c:dlex = "32" | c:dlex = "42" | c:dlex = "52" | c:dlex = "62"
   | c:dlex = "72" | c:dlex = "82" | c:dlex = "92" | c:dlex = "102" )
  c:type = "ordinal"
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:slex = ?s
  ¬rc:ordinal = done
  ordinal = done
  slex = #?s+nd#
}
  ]
]

DSynt<=>SSynt EN_transfer_node_ordinal_more : transfer_nodes
[
  leftside = [
c:?Xl {
 ¬ ( c:dlex = "1" | c:dlex = "11" | c:dlex = "21" | c:dlex = "31" | c:dlex = "41" | c:dlex = "51"
   | c:dlex = "61" | c:dlex = "71" | c:dlex = "81" | c:dlex = "91" | c:dlex = "101"
   | c:dlex = "2" | c:dlex = "22" | c:dlex = "32" | c:dlex = "42" | c:dlex = "52" | c:dlex = "62"
   | c:dlex = "72" | c:dlex = "82" | c:dlex = "92" | c:dlex = "102" )
  c:type = "ordinal"
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:slex = ?s
  ¬rc:ordinal = done
  ordinal = done
  slex = #?s+th#
}
  ]
]

DSynt<=>SSynt CA_transfer_node_DET : transfer_nodes
[
  leftside = [
c:?Xl {
  ¬c:pos = "IN"
  ¬c:pos = "PP"
  ¬c:pos = "RB"
  definiteness=?def
}

lexicon.miscellaneous.determiners.?def.?det
lexicon.?det.lemma.?lem
lexicon.?det.pos.?pos
lexicon.?det.spos.?spos

language.id.iso.CA

¬ ( ?def == "INDEF" & ?Xl.number == "PL" )
// ¬ ( c:?Xl { c:ATTR-> c:?Possl { ( c:dlex = "mi" | c:dlex = "tu" | c:dlex = "su" | c:dlex = "nuestro" | c:dlex = "vuestro" ) } } )
( c:?Xl { ¬c:pos = "NP" }
 | ( c:?Xl { c:pos = "NP" c:lex = ?lex } & ( lexicon.?lex.definiteness.?art  | lexicon.?lex.article.?art ) & ¬ ?art == "no" )
 | class == "Date"
)

// ?xl is not a number
¬ ( ?Xl.pos == "CD" | ( c:?Xl { c:lemma = ?lem1 } & ( ?lem1 == "0" | ?lem1 > "0" ) ) )

// there isn't already a determiner on ?Xl
¬ ( c:?Xl { c:?r-> c:?Det2 { c:lex = ?lex2 } } & lexicon.?lex2.pos.?dt & ?dt == "DT" )

// ?Xl isn't defined as a indefinite noun that has a number at the same time
¬ ( ?def == "INDEF" & c:?Xl { c:ATTR-> c:?Num3l { c:pos = "CD" } } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //to exclude governed prepositions
  ¬rc:top = yes
  ¬rc:pos = IN
  det-> ?Yr {
    slex = ?lem
  //  lemma = "the"
    pos = ?pos 
    spos = ?spos
    include = bubble_of_gov
    thematicity = ?Xl.thematicity
  }
}
  ]
]

DSynt<=>SSynt DE_transfer_node_DET : transfer_nodes
[
  leftside = [
c:?Xl {
// yeah, that happens...
  ¬c:pos = "IN"
  ¬c:pos = "PP"
  ¬c:pos = "JJ"
  ¬c:pos = "VB"
  definiteness=?def
}

lexicon.miscellaneous.determiners.?def.?det
lexicon.?det.lemma.?lem
lexicon.?det.pos.?pos
lexicon.?det.spos.?spos

language.id.iso.DE

( c:?Xl { ¬c:pos = "NP"}
 | ( c:?Xl { c:pos = "NP" c:lex = ?lex } & lexicon.?lex.article.?art & ¬ ?art == "no" )
)

// ?Xl is not defined as not countable in the lexicon; allow negation determiner "KEIN"
¬ ( ( ?def == "DEF" | ?def == "INDEF" ) & c:?Xl {c:lex = ?lex } & lexicon.?lex.countable.?c & ?c == "no" )

// ?xl is not a number
¬ ( ?Xl.pos == "CD" | ( c:?Xl { c:lemma = ?lem1 } & ( ?lem1 == "0" | ?lem1 > "0" ) ) )

// there isn't already a determiner on ?Xl
¬ ( c:?Xl { c:?r-> c:?Det2 { c:lex = ?lex2 } } & lexicon.?lex2.pos.?dt & ?dt == "DT" )

// there isn't already a possessive on ?Xl
¬ ( c:?Xl { c:ATTR-> c:?Poss { c:lemma = ?lex3 } } & ?lex3 == "nous")

// ?Xl isn't defined as a indefinite noun that has a number at the same time
¬ ( ?def == "INDEF" & c:?Xl { c:ATTR-> c:?Num3l { c:pos = "CD" } } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //to exclude governed prepositions
  ¬rc:top = yes
  ¬rc:pos = IN
  NK-> ?Yr {
    slex = ?lem
  //  lemma = "the"
    pos = ?pos 
    spos = ?spos
    include = bubble_of_gov
    thematicity = ?Xl.thematicity
  }
}
  ]
]

/*You need determiners on proper nouns.
Determiners combime with possessives.*/
DSynt<=>SSynt EL_transfer_node_DET : transfer_nodes
[
  leftside = [
c:?Xl {
// yeah, that happens...
  ¬c:pos = "IN"
  ¬c:pos = "PP"
  ¬c:pos = "JJ"
  ¬c:pos = "VB"
  definiteness=?def
}

lexicon.miscellaneous.determiners.?def.?det
lexicon.?det.lemma.?lem
lexicon.?det.pos.?pos
lexicon.?det.spos.?spos

language.id.iso.EL

// ?Xl is not defined as not countable in the lexicon
¬ ( c:?Xl {c:lex = ?lex } & lexicon.?lex.countable.?c & ?c == "no" )

// ?xl is not a number
( ¬ ( ?Xl.pos == "CD" | ( c:?Xl { c:lemma = ?lem1 } & ( ?lem1 == "0" | ?lem1 > "0" ) ) ) | ?Xl.meaning == "point_time" )

// there isn't already a determiner on ?Xl
¬ ( c:?Xl { c:?r-> c:?Det2 { c:lex = ?lex2 } } & lexicon.?lex2.pos.?dt & ?dt == "DT" )

// ?Xl isn't defined as a indefinite noun that has a number at the same time
¬ ( ?def == "INDEF" & c:?Xl { c:ATTR-> c:?Num3l { c:pos = "CD" } } )

// no idea if this rule is OK; to cover cases like "traffic jam is reported" (may be limited to the verb and a few similar ones with the meaning of "there is"
¬ ( ?def == "INDEF" & c:?Gov4l { c:voice = "PASS" c:II-> c:?Xl {} ¬c:I-> ?Dep4l {} } )
  ]
  mixed = [
// There isn't a governor that prevents the appearance of a determiner according to the lexicon and the particular dependency
¬ ( rc:?Gov1r { rc:lex = ?lex1 rc:?r1-> rc:?Xr { rc:<=> ?Xl } } & lexicon.?lex1.gp.?r1.definiteness.?d1 & ?d1 == "no" )
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //to exclude governed prepositions
  ¬rc:top = yes
  ¬rc:pos = IN
  // so the rule appleis in the third cluster, when the dependencies are there (see mixed)
  // all nodes are supposed to have a lex, so it shouldn't be a problem
  rc:lex = ?lexXr
  ¬rc:det-> rc:?DetAlreadyThere { rc:slex = ?lem }
  det-> ?Yr {
    slex = ?lem
  //  lemma = "the"
    pos = ?pos 
    spos = ?spos
    include = bubble_of_gov
    thematicity = ?Xl.thematicity
  }
}
  ]
]

/*You need determiners on some relative pronouns (marked in the lexicon).*/
DSynt<=>SSynt EL_transfer_node_DET_relPro : transfer_nodes
[
  leftside = [
c:?Xl {
  ( c:pos = "NN" | c:pos = "NP" )
}

language.id.iso.EL
  ]
  mixed = [
// There isn't a governor that prevents the appearance of a determiner according to the lexicon and the particular dependency
rc:?Xr { rc:<=> ?Xl rc:lex = ?lex }
lexicon.?lex.definiteness.?def

lexicon.miscellaneous.determiners.?def.?det
lexicon.miscellaneous.determiners.?def.?det
lexicon.?det.lemma.?lem
lexicon.?det.pos.?pos
lexicon.?det.spos.?spos
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:relativized = yes
  rc:pos = "WDT"
  ¬rc:det-> rc:?DetAlreadyThere { rc:slex = ?lem }
  det-> ?Yr {
    slex = ?lem
  //  lemma = "the"
    pos = ?pos 
    spos = ?spos
    include = bubble_of_gov
    thematicity = ?Xl.thematicity
  }
}
  ]
]

DSynt<=>SSynt EN_transfer_node_DET : transfer_nodes
[
  leftside = [
c:?Xl {
// yeah, that happens...
  ¬c:pos = "IN"
  ¬c:pos = "DT"
  ¬c:pos = "CD"
  ¬c:pos = "PRP"
  ¬c:pos = "RB"
  // should be generalized to more countries
  //¬c:dlex = "United_States"
  ¬c:dlex = "California"
  definiteness=?def
  // there isn't already a determiner
  ¬c:ATTR-> c:?Detl {
    ( c:pos = "DT" | c:pos = "CD" | c:pos = "WDT" | c:dlex  = "my" | c:dlex  = "your" | c:dlex  = "his" | c:dlex  = "her" | c:dlex  = "their"
     | c:dlex  = "this" | c:dlex  = "that"  | c:dlex  = "no" | c:dlex  = "such" | c:dlex  = "another" | c:case = "GEN"
     | c:dlex  = "some"| c:dlex  = "any" | c:dlex  = "enough" | c:dlex  = "each" | c:dlex  = "every"
     | c:dlex  = "multiple" | c:dlex  = "several" | c:dlex  = "many" | c:dlex  = "few" | c:dlex  = "much" | c:dlex  = "no"
     | c:dlex  = "not"
     )
  }
}

( ¬ ( c:?Xl { c:pos = ?posXl } & ?posXl == "NP" ) | ( c:?Xl { c:lex = ?lexXl } & lexicon.?lexXl.definiteness.?def )
  | c:?Xl { c:variable_class = "TeamName" } | c:?Xl { c:dlex = "city_centre" } | c:?Xl { c:dlex = "riverside" } )

lexicon.miscellaneous.determiners.?def.?det
lexicon.?det.lemma.?lem
lexicon.?det.pos.?pos
lexicon.?det.spos.?spos

language.id.iso.EN

¬ ( c:?Xl {c:lex = ?lex } & lexicon.?lex.countable.?no & ?no == "no" )
¬ ( c:?Xl { c:ATTR-> c:?det2l { c:dlex = "both " } ¬c:COORD-> c:?Coord {} } )

//¬ (c:?Xl { c:?r-> c:?Yl {c:case = "GEN" } } )
// No determiners in case of indefinite plural
¬ (?def == "INDEF" & ?Xl.number == "PL")

// ?Xl is not part of a phraseme
¬c:?PropName { c:NAME-> c:?Xl {} }

( ¬c:?Xl { c:ATTR-> c:?Det3l { c:dlex  = "most" } } | ( c:?Xl { c:ATTR-> c:?Det4l { c:dlex  = "most" c:lex = ?lex4 } } & lexicon.?lex4.superlative.?sup4 & ?sup4 == "yes" ) )

¬?Xl.dlex == "something"
¬?Xl.dlex == "nothing"
¬?Xl.dlex == "everyhing"
¬?Xl.dlex == "anyhing"
  ]
  mixed = [
//In noun compounds, no determiner on the modifier/argument
// if there is a preposition on ?x, the determinere should be introduced!
// ... except if the governor is a word like "source" and indefinite (210928_xR4DRAMA_templates, str. 11
( ¬(c:?Gov1 {c:pos = "NN" c:?s1-> c:?Xl {}}) | ( rc:?Xr { rc:<=> ?Xl rc:bottom = yes } & ¬c:?Gov2 { c:lemma = "source" c:definiteness = "INDEF" c:?s2-> c:?Xl {} } ) )

¬ ( c:?Xl { c:lex = ?lexX } & lexicon.?lexX.LocinSubcat.definiteness.?no & ?no == "no"  & rc:?Xr { rc:<=> ?Xl rc:Locin = "yes" } )
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //to exclude governed prepositions
  ¬rc:top = yes
  ¬rc:pos = IN
  ¬rc:determiner_introduced = "yes"
  determiner_introduced = "yes"
  NMOD-> ?Yr {
    slex = ?lem
  //  lemma = "the"
    pos = ?pos 
    spos = ?spos
    include = bubble_of_gov
  }
}
  ]
]

DSynt<=>SSynt ES_transfer_node_DET : transfer_nodes
[
  leftside = [
c:?Xl {
  ¬c:pos = "IN"
  ¬c:pos = "PP"
  ¬c:pos = "RB"
  definiteness=?def
}

lexicon.miscellaneous.determiners.?def.?det
lexicon.?det.lemma.?lem
lexicon.?det.pos.?pos
lexicon.?det.spos.?spos

language.id.iso.ES

¬ ( ?def == "INDEF" & ?Xl.number == "PL" )
¬ ( c:?Xl { c:ATTR-> c:?Possl { ( c:dlex = "mi" | c:dlex = "tu" | c:dlex = "su" | c:dlex = "nuestro" | c:dlex = "vuestro" ) } } )
( c:?Xl { ¬c:pos = "NP" }
 | ( c:?Xl { c:pos = "NP" c:lex = ?lex } & ( lexicon.?lex.definiteness.?art  | lexicon.?lex.article.?art ) & ¬ ?art == "no" )
 | ( language.id.iso.ES & ?Xl.class == "Date" )
)

// ?xl is not a number
¬ ( ?Xl.pos == "CD" | ( c:?Xl { c:lemma = ?lem1 } & ( ?lem1 == "0" | ?lem1 > "0" ) ) )

// there isn't already a determiner on ?Xl
¬ ( c:?Xl { c:?r-> c:?Det2 { c:lex = ?lex2 } } & lexicon.?lex2.pos.?dt & ?dt == "DT" )

// ?Xl isn't defined as a indefinite noun that has a number at the same time
¬ ( ?def == "INDEF" & c:?Xl { c:ATTR-> c:?Num3l { c:pos = "CD" } } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //to exclude governed prepositions
  ¬rc:top = yes
  ¬rc:pos = IN
  det-> ?Yr {
    slex = ?lem
  //  lemma = "the"
    pos = ?pos 
    spos = ?spos
    include = bubble_of_gov
    thematicity = ?Xl.thematicity
  }
}
  ]
]

DSynt<=>SSynt ES_transfer_node_DET_cual : transfer_nodes
[
  leftside = [
c:?Xl {
  ( c:pos = "NN" | c:pos = "NP" )
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:relativized = yes
  rc:slex = "cual"
  ¬rc:det-> rc:?DetR {}
  det-> ?Yr {
    slex = "el"
    pos = "DT" 
    spos = "determiner"
    include = bubble_of_gov
    number = ?Xr.number
    gender = ?Xr.gender
  }
}
  ]
]

DSynt<=>SSynt FR_transfer_node_DET : transfer_nodes
[
  leftside = [
c:?Xl {
// yeah, that happens...
  ¬c:pos = "IN"
  ¬c:pos = "PP"
  ¬c:pos = "JJ"
  ¬c:pos = "VB"
  definiteness=?def
}

lexicon.miscellaneous.determiners.?def.?det
lexicon.?det.lemma.?lem
lexicon.?det.pos.?pos
lexicon.?det.spos.?spos

language.id.iso.FR

( c:?Xl { ¬c:pos = "NP"}
 | ( c:?Xl { c:pos = "NP" c:lex = ?lex } & lexicon.?lex.article.?art & ¬ ?art == "no" )
)

// ?Xl is not defined as not countable in the lexicon
¬ ( c:?Xl {c:lex = ?lex } & lexicon.?lex.countable.?c & ?c == "no" )

// ?xl is not a number
¬ ( ?Xl.pos == "CD" | ( c:?Xl { c:lemma = ?lem1 } & ( ?lem1 == "0" | ?lem1 > "0" ) ) )

¬?Xl.lemma == "million"
¬?Xl.lemma == "cent"
¬?Xl.lemma == "mille"

// there isn't already a determiner on ?Xl
¬ ( c:?Xl { c:?r-> c:?Det2 { c:lex = ?lex2 } } & lexicon.?lex2.pos.?dt & ?dt == "DT" )

// there isn't already a possessive on ?Xl
¬ ( c:?Xl { c:ATTR-> c:?Poss { c:lemma = ?lex3 } } & ?lex3 == "nous")

// ?Xl isn't defined as a indefinite noun that has a number at the same time
¬ ( ?def == "INDEF" & c:?Xl { c:ATTR-> c:?Num3l { c:pos = "CD" } } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //to exclude governed prepositions
  ¬rc:top = yes
  ¬rc:pos = IN
  det-> ?Yr {
    slex = ?lem
  //  lemma = "the"
    pos = ?pos 
    spos = ?spos
    include = bubble_of_gov
    thematicity = ?Xl.thematicity
  }
}
  ]
]

DSynt<=>SSynt IT_transfer_node_DET : transfer_nodes
[
  leftside = [
c:?Xl {
  ¬c:pos = "IN"
  ¬c:pos = "PP"
  definiteness=?def
  // there isn't already a determiner
  ¬c:ATTR-> c:?Detl {
    ( c:pos = "DT" | c:pos = "CD" | c:dlex  = "questo" | c:dlex  = "quello"  | c:dlex  = "nessun" | c:dlex  = "alcun" 
     | c:dlex  = "vario"| c:dlex  = "qualsiasi" | c:dlex  = "abbastanza" | c:dlex  = "ogni" | c:dlex  = "tanto" | c:dlex  = "poco" 
     )
  }

}

lexicon.miscellaneous.determiners.?def.?det
lexicon.?det.lemma.?lem
lexicon.?det.pos.?pos
lexicon.?det.spos.?spos

language.id.iso.IT

// It is possible to have indefinite determiners in plural: a partitive is used (done within the morphologicon) - no need for this:
//¬ ( ?def == "INDEF" & ?Xl.number == "PL" )
// In Italian possessives are usually accompanied by determiners (except family members), so no need for this:
//¬ ( c:?Xl { c:ATTR-> c:?Possl { ( c:dlex = "mio" | c:dlex = "tuo" | c:dlex = "suo" | c:dlex = "nostro" | c:dlex = "vostro" ) } } )
( c:?Xl { ¬c:pos = "NP"}
 | ( c:?Xl { c:pos = "NP" c:lex = ?lex } & lexicon.?lex.article.?art & ¬ ?art == "nessun" )
 | ( c:?Xl { c:pos = "NP" c:lex = ?lex2 } & lexicon.?lex2.definiteness.?def )
)


// ?Xl is not defined as not countable in the lexicon
¬ ( c:?Xl {c:lex = ?lex } & lexicon.?lex.countable.?c & ?c == "nessun" )

// ?xl is not a number
¬ ( ?Xl.pos == "CD" | ( c:?Xl { c:lemma = ?lem1 } & ( ?lem1 == "0" | ?lem1 > "0" ) ) )

// there isn't already a determiner on ?Xl
¬ ( c:?Xl { c:?r-> c:?Det2 { c:lex = ?lex2 } } & ( ( lexicon.?lex2.pos.?dt & ?dt == "DT" ) | ?lex2 == "molto_JJ_01" )  )

// ?Xl isn't defined as a indefinite noun that has a number at the same time
¬ ( ?def == "INDEF" & c:?Xl { c:ATTR-> c:?Num3l { c:pos = "CD" } } )

// ?Xl is an adjective modifying a noun (xR4DRAMA str. 11)
¬ ( ?Xl.pos == "JJ" & c:?Noun { c:pos = "NN" c:?r4-> c:?Xl {}} )
  ]
  mixed = [
//In noun compounds, no determiner on the modifier/argument
// if there is a preposition on ?x, the determiner should be introduced!
// ... except if the governor is a word like "source" and indefinite (210928_xR4DRAMA_templates, str. 11
( ¬(c:?Gov1 {c:pos = "NN" c:?s1-> c:?Xl {}}) | ( rc:?Xr { rc:<=> ?Xl rc:bottom = yes } & ¬c:?Gov2 { c:lemma = "fonte" c:definiteness = "INDEF" c:?s2-> c:?Xl {} } ) )


¬ ( c:?Xl { c:lex = ?lexX } & lexicon.?lexX.LocinSubcat.definiteness.?no & ?no == "no"  & rc:?Xr { rc:<=> ?Xl rc:Locin = "yes" } )
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //to exclude governed prepositions
  ¬rc:top = yes
  ¬rc:pos = IN
  det-> ?Yr {
    slex = ?lem
  //  lemma = "the"
    pos = ?pos 
    spos = ?spos
    include = bubble_of_gov
    thematicity = ?Xl.thematicity
  }
}
  ]
]

DSynt<=>SSynt PT_transfer_node_DET : transfer_nodes
[
  leftside = [
c:?Xl {
  ¬c:pos = "IN"
  ¬c:pos = "PP"
  ¬c:pos = "RB"
  definiteness=?def
  ¬c:ATTR-> c:?Detl {
    ( c:pos = "DT" | c:pos = "CD" | c:dlex  = "múltiplo" | c:dlex  = "nenhum" | c:case = "GEN" )
  }
}

lexicon.miscellaneous.determiners.?def.?det
lexicon.?det.lemma.?lem
lexicon.?det.pos.?pos
lexicon.?det.spos.?spos

language.id.iso.PT

¬ ( c:?Xl { c:ATTR-> c:?Possl { ( c:dlex = "mi" | c:dlex = "tu" | c:dlex = "su" | c:dlex = "nuestro" | c:dlex = "vuestro" ) } } )
( c:?Xl { ¬c:pos = "NP" }
 | ( c:?Xl { c:pos = "NP" c:lex = ?lex } & ( lexicon.?lex.definiteness.?art  | lexicon.?lex.article.?art ) & ¬ ?art == "no" )
 | ( language.id.iso.PT & ?Xl.class == "Date" )
)

// ?xl is not a number
¬ ( ?Xl.pos == "CD" | ( c:?Xl { c:lemma = ?lem1 } & ( ?lem1 == "0" | ?lem1 > "0" ) ) )

// there isn't already a determiner on ?Xl
¬ ( c:?Xl { c:?r-> c:?Det2 { c:lex = ?lex2 } } & lexicon.?lex2.pos.?dt & ?dt == "DT" )

// there isn't a possessive pronoun that will be pronominalised; i don't think that's a great rule since not necessarily all dependents with case= GEN and a coref will be pronominalised
¬ ( c:?Xl { c:?r3-> c:?det3l { c:case = "GEN" c:<-> c:?Ante3 {} } } & ( ?r3 == I | ?r3 == II | ?r3 == III ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //to exclude governed prepositions
  ¬rc:top = yes
  ¬rc:pos = IN
  ¬rc:determiner_introduced = "yes"
  determiner_introduced = "yes"
  det-> ?Yr {
    slex = ?lem
  //  lemma = "the"
    pos = ?pos 
    spos = ?spos
    include = bubble_of_gov
    thematicity = ?Xl.thematicity
  }
}
  ]
]

DSynt<=>SSynt DE_transfer_node_par_LGS : transfer_nodes
[
  leftside = [
c:?Xl {
//  spos="VV"
  ¬c:pos = "NN"
  c:voice="PASS"
  I-> c:?Yl {}
}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  SBP-> ?PrepR {
    slex = "von"
    pos = "IN"
    spos = preposition
    include = bubble_of_gov
    NK-> rc:?Yr {
      rc:<=> ?Yl
      ¬rc:bottom=yes
      ¬rc:middle=yes
      case = "DAT"
    }
  }
}
  ]
]

/*By should not be used as anchor for coordinations (e.g. PTB_train_78/138/172).s*/
DSynt<=>SSynt EN_transfer_node_by_LGS : transfer_nodes
[
  leftside = [
c:?Xl {
//  spos="VV"
  c:voice="PASS"
  I-> c:?Yl {}
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  LGS-> ?PrepR {
    <=> ?Yl
    slex = "by"
    pos = "IN"
    spos = preposition
    //include = bubble_of_gov
    top = yes
    lgs = yes
    PMOD-> rc:?Yr {
      rc:<=> ?Yl
      bottom=yes
      ¬rc:slex = "by"
      ¬rc:slex = "_PRO_"
      ¬rc:bottom=yes
      ¬rc:middle=yes
    }
  }
}
  ]
]

DSynt<=>SSynt ES_transfer_node_por_LGS : transfer_nodes
[
  leftside = [
c:?Xl {
//  spos="VV"
  c:voice="PASS"
  I-> c:?Yl {}
}

language.id.iso.ES
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  agent-> ?PrepR {
    slex = "por"
    pos = "IN"
    spos = preposition
    include = bubble_of_gov
    prepos-> rc:?Yr {
      rc:<=> ?Yl
      ¬rc:bottom=yes
      ¬rc:middle=yes
    }
  }
}
  ]
]

DSynt<=>SSynt FR_transfer_node_par_LGS : transfer_nodes
[
  leftside = [
c:?Xl {
//  spos="VV"
  c:voice="PASS"
  I-> c:?Yl {}
}

language.id.iso.FR
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  agent-> ?PrepR {
    slex = "par"
    pos = "IN"
    spos = preposition
    include = bubble_of_gov
    prepos-> rc:?Yr {
      rc:<=> ?Yl
      ¬rc:bottom=yes
      ¬rc:middle=yes
    }
  }
}
  ]
]

DSynt<=>SSynt IT_transfer_node_por_LGS : transfer_nodes
[
  leftside = [
c:?Xl {
//  spos="VV"
  c:voice="PASS"
  I-> c:?Yl {}
}

language.id.iso.IT
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  agent-> ?PrepR {
    slex = "de"
    pos = "IN"
    spos = preposition
    include = bubble_of_gov
    prepos-> rc:?Yr {
      rc:<=> ?Yl
      ¬rc:bottom=yes
      ¬rc:middle=yes
    }
  }
}
  ]
]

DSynt<=>SSynt PT_transfer_node_por_LGS : transfer_nodes
[
  leftside = [
c:?Xl {
//  spos="VV"
  c:voice="PASS"
  I-> c:?Yl {}
}

language.id.iso.PT
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  agent-> ?PrepR {
    slex = "por"
    pos = "IN"
    spos = preposition
    include = bubble_of_gov
    prepos-> rc:?Yr {
      rc:<=> ?Yl
      ¬rc:bottom=yes
      ¬rc:middle=yes
    }
  }
}
  ]
]

/*If a coordination conjunction is required according to the lexicon.
(e.g. between X and Y)*/
DSynt<=>SSynt DE_transfer_node_coord_governed : transfer_nodes
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  c:?r-> c:?Yl {}
  ?s-> c:?Zl {}
}

lexicon.?lex.gp.?s.coordination.?CLex
lexicon.?lex.gp.?s.conjunct.?r
lexicon.?CLex.lemma.?lem
lexicon.?CLex.pos.?pos
lexicon.?CLex.spos.?spos
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bottom=yes
  ¬rc:middle=yes
  CD-> ?Coordr {
  <=> ?Zl
  top = yes
  slex = ?lem
  lemma = ?lem
  lex = ?CLex
  pos = ?pos
  spos = ?spos
  include = bubble_of_gov
    CJ-> rc:?Zr {
      rc:<=> ?Zl
      bottom = yes
    }
  }
}
  ]
]

/*WAS DISABLED*/
excluded DSynt<=>SSynt transfer_node_DET_INDEF : transfer_nodes
[
  leftside = [
c:?Xl {
  definiteness="INDEF"
  ¬c:I-> c:?Yl {c:case = "GEN"}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //to exclude governed prepositions
  ¬rc:top = yes
  NMOD-> ?Yr {
    slex="a"
  //  lemma = "a"
    pos="DT"
    spos=determiner
  }
}
  ]
]

DSynt<=>SSynt expand_bubble_gov : expand_bubbles
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
excluded DSynt<=>SSynt expand_bubble_dep : expand_bubbles
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

DSynt<=>SSynt transfer_rel_parataxis : transfer_relations
[
  leftside = [
c:?Xl {
  Parataxis-> c:?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:middle = yes
  ¬rc:bottom = yes
  Parataxis-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:middle = yes
    ¬rc:bottom = yes
  }
}
  ]
]

DSynt<=>SSynt transfer_rel_precedence : transfer_relations
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
// to exclude governed prepositions
  ¬rc:top = yes
  ~ rc:?Yr {
    rc:<=> ?Yl
// to exclude governed prepositions
    ¬rc:top = yes
  }
}
  ]
]

DSynt<=>SSynt transfer_rel_coref : transfer_relations
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
// to exclude governed prepositions
  ¬rc:top = yes
  <-> rc:?Yr {
    rc:<=> ?Yl
// to exclude governed prepositions
    ¬rc:top = yes
  }
}
  ]
]

Sem<=>DSynt transfer_rel_bubbles : transfer_relations
[
  leftside = [
c:?Xl {
  c:dlex = "Sentence"
  b-> c: ?Yl {
    c:dlex = "Sentence"
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

excluded DSynt<=>SSynt transfer_relations_lexicon : transfer_relations
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  ?r-> c:?Yl {}
}

lexicon.?lex.gp.?r.rel.?R
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ?R-> rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

DSynt<=>SSynt DE_transfer_relations : transfer_relations
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DSynt<=>SSynt EN_transfer_relations : transfer_relations
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DSynt<=>SSynt CA_EL_ES_FR_IT_PT_transfer_relations : transfer_relations
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DSynt<=>SSynt PL_transfer_relations : transfer_relations
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DSynt<=>SSynt K_attr_gestures : transfer_attributes
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DSynt<=>SSynt PL_attributes : transfer_attributes
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DSynt<=>SSynt anaphora : transfer_attributes
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DSynt<=>SSynt attr_case : transfer_attributes
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
  ¬rc:pos = "IN"
  ¬rc:case=?g
  case=?n
}
  ]
]

DSynt<=>SSynt attr_case_default : transfer_attributes
[
  leftside = [
c:?Xl {
  pos = "NN"
  ¬c:case = ?n
}

language.syntax.casesystem.yes
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:pos = "IN"
  ¬rc:case=?g
  case="NOM"
}
  ]
]

DSynt<=>SSynt attr_class : transfer_attributes
[
  leftside = [
c:?Xl {
  class = ?u
}

¬ ( c:?Xl { c:lex = ?lex } & lexicon.?lex.semType.?class )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  ¬ ( rc:pos = "IN" rc:top = yes )
  class = ?u
}
  ]
]

DSynt<=>SSynt attr_class_lexicon : transfer_attributes
[
  leftside = [
c:?Xl {
  c:lex = ?lex
}

lexicon.?lex.semType.?class
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  class = ?class
}
  ]
]

DSynt<=>SSynt attr_clause_type : transfer_attributes
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
  ¬rc:case=?g
  clause_type=?n
}
  ]
]

DSynt<=>SSynt attr_clause_type_default : transfer_attributes
[
  leftside = [
c:?Xl {
  ( ¬c:clause_type = ?m | c:clause_type = "-" )
}

// ?Xl is the root
¬c:?Gov { c:?r-> ?Xl {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  clause_type = "DECL"
}
  ]
]

/*dpos should be VB, NN, RB, JJ (see pos rules below)*/
DSynt<=>SSynt attr_coord_type : transfer_attributes
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
  ¬rc:top = yes
  ¬rc:middle = yes
  coord_type = ?ds
}
  ]
]

/*Needed for generation of prosody.*/
DSynt<=>SSynt attr_dsyntRel : transfer_attributes
[
  leftside = [
c:?Xl {
  c:?r-> c:?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bottom=yes
  ¬rc:middle=yes
  dsyntRel = ?r
}
  ]
]

DSynt<=>SSynt attr_finiteness : transfer_attributes
[
  leftside = [
c:?Xl {
  finiteness = ?n
}

( ¬?Xl.voice == "PASS" | language.syntax.voice.synthetic
  | ( ( language.id.iso.CA | language.id.iso.ES ) & c:?Xl { c:voice = "PASS" ¬c:I-> c:?Arg1l {} } )
)

( c:?Xl { ¬c:tem_constituency = ?tc } | language.syntax.verbform.synthetic | language.syntax.aspect.synthetic 
  | ( ( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR ) & c:?Xl { ( c:tem_constituency = "IMP" | c:tem_constituency = "PERF-S" ) } ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:pos = "VB"
  // incorrect condition; changed by better one below
  //¬rc:bottom = yes
  ¬rc:finiteness = ?f
  finiteness=?n
}


¬rc:?Mr {rc:VC-> rc:?Xr {}}
  ]
]

/*if an infinitive verb is left alone, change it to gerund in certain conditions
I found examples of use of zero-infinitive: (http://www.ef.com/english-resources/english-grammar/infinitive/)
She can't speak to you. We heard them close the door.
Let's go to the cinema tonight. You made me come with you.
We had better take some warm clothing. Why wait until tomorrow?
*/
DSynt<=>SSynt EN_transfer_attribute_finiteness_change : transfer_attributes
[
  leftside = [
c:?Xl {
  c:pos = "VB"
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:pos = "VB"
  rc:finiteness= "INF"
  ¬rc:add_to = yes
  finiteness = "GER"
}

¬rc:?Y1r { rc:slex = "to" rc:?r1-> rc:?Xr {} }
¬rc:?Y2r { rc:VC-> rc:?Xr {} }
¬rc:?Y3r { (rc:slex = "make" | rc:slex = "let" ) rc:?r3-> rc:?Xr {} }
¬rc:?Y4r { rc:slex = "have" rc:?r4a-> rc:?Xr {} rc:?r4b-> rc:?Z4r { rc:slex = "better" } }
¬ rc:?Xr { rc:?r5-> rc:?Y5r { rc:slex = "why" } }
  ]
]

/*if a verb with no finiteness and no first arg is a first arg of a finite verb, make it gerund.
*/
DSynt<=>SSynt EN_transfer_attribute_finiteness_GER_I : transfer_attributes
[
  leftside = [
c:?Vl {
  c:pos = "VB"
  c:finiteness = "FIN"
  c:I-> c:?Xl {
    c:pos = "VB"
    ¬c:finiteness = ?f
    ¬c:I-> c:?Arg1 {}
  }
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:pos = "VB"
  ¬rc:finiteness= ?fR
  finiteness = "GER"
}
  ]
]

DSynt<=>SSynt attr_gender : transfer_attributes
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
  ¬rc:gender=?g
  ¬rc:pos = "IN"
  gender=?n
}
  ]
]

DSynt<=>SSynt attr_gender_default : transfer_attributes
[
  leftside = [
c:?Yl {
  ( c:pos = "NN" | c:pos = "NP" )
  ¬c:gender = ?num
}

¬ ( language.id.iso.EL & ?Yl.pos == "NN" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:gender=?g
  ¬rc:pos = "IN"
  gender = "MASC"
}
  ]
]

DSynt<=>SSynt EL_transfer_attribute_gender_default : transfer_attributes
[
  leftside = [
c:?Yl {
  c:pos = "NN"
  ¬c:gender = ?num
}

language.id.iso.EL
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:gender=?g
  gender = "NEU"
}
  ]
]

DSynt<=>SSynt EL_transfer_attribute_gender_date_year : transfer_attributes
[
  leftside = [
c:?Yl {
  c:pos = "CD"
  c:meaning = "point_time"
  ¬c:gender = ?num
}

language.id.iso.EL
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:gender=?g
  gender = "NEU"
}
  ]
]

DSynt<=>SSynt attr_has3rdArg : transfer_attributes
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

DSynt<=>SSynt attr_id : transfer_attributes
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
  ¬rc:top = yes
  ¬rc:middle = yes
  id = ?lex
}
  ]
]

DSynt<=>SSynt attr_id0 : transfer_attributes
[
  leftside = [
c:?Xl {
  id0 = ?lex
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top = yes
  ¬rc:middle = yes
  id0 = ?lex
}
  ]
]

DSynt<=>SSynt attr_lex : transfer_attributes
[
  leftside = [
c:?Xl {
  // PATCH: added context because it gives weird overlap with EN_transfer_node_IN_governed_inStr
  // (V4Design tests P3, 200410_V4Design-test_demo.conll first sentence)
  c:lex = ?lex
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top = yes
  ¬rc:middle = yes
  lex = ?lex
}
  ]
]

DSynt<=>SSynt attr_meaning : transfer_attributes
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

DSynt<=>SSynt attr_mood : transfer_attributes
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:mood = ?m
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:finiteness = "FIN"
  mood = ?m
}
  ]
]

DSynt<=>SSynt attr_mood_default : transfer_attributes
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

DSynt<=>SSynt attr_NE : transfer_attributes
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
  ¬ ( rc:pos = "IN" rc:top = yes )
  NE = ?NE
}
  ]
]

DSynt<=>SSynt attr_number : transfer_attributes
[
  leftside = [
c:?Xl {
  number = ?n
}

// see transfer_attribute_number_PL
//¬ ( c:?Xl {
//    c:?r-> c:?Al{
//    (c:dlex = "multiple" | c:dlex = "various" | c:dlex = "several" | c:dlex = "many" | c:dlex = "few"
//      | ( c:pos = "CD" & ( ¬ ( c:dlex = "0" | c:dlex = "1" ) | c:COORD-> c:?CO {} ) ) )
//    }
//  }
//&
//  ( ?r == ATTR | (language.id.iso.PL & ( ?r == I | ?r == II ) ) )
//)
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:pos = "IN"
  number=?n
}
  ]
]

DSynt<=>SSynt attr_number_default : transfer_attributes
[
  leftside = [
c:?Yl {
  ( c:pos = "NN" | c:pos = "NP" | c:pos = "CD" )
  ¬c:number = ?num
}

// see transfer_attribute_number_PL
//¬ ( c:?Xl {
//    c:?r-> c:?Al{
//    (c:dlex = "multiple" | c:dlex = "various" | c:dlex = "several" | c:dlex = "many" | c:dlex = "few"
//      | ( c:pos = "CD" & ( ¬ ( c:dlex = "0" | c:dlex = "1" ) | c:COORD-> c:?CO {} ) ) )
//    }
//  }
//&
//  ( ?r == ATTR | ( language.id.iso.PL & ( ?r == I | ?r == II ) ) )
//)
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

/*Moved to previous grammar*/
excluded DSynt<=>SSynt attr_number_PL : transfer_attributes
[
  leftside = [
c:?Xl{
  c:?r-> c:?Al{
  ( c:number = "PL" | c:dlex = "multiple" | c:dlex = "various" | c:dlex = "several" | c:dlex = "many" | c:dlex = "few"
    | ( c:pos = "CD" & ( ¬ ( c:dlex = "0" | c:dlex = "1" ) | c:COORD-> c:?CO {} ) ) )
  }
}

(?r == ATTR | ( language.id.iso.PL & ( ?r == I | ?r == II ) ) )

¬ ( language.id.iso.DE & ?Al.pos == "CD" & ?Xl.lex == "Mal_NN_01" )
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

DSynt<=>SSynt attr_predV : transfer_attributes
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

DSynt<=>SSynt attr_person : transfer_attributes
[
  leftside = [
c:?Yl {
  ( c:pos = "NN" | c:pos = "PRP" )
  c:person = ?num
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:pos = "IN"
  person = ?num
}
  ]
]

DSynt<=>SSynt attr_person_default : transfer_attributes
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

DSynt<=>SSynt attr_spos_copy : transfer_attributes
[
  leftside = [
c:?Xl {
  c:spos = ?spos
}

¬ ( ?spos == "VV" &  c:?Xl { c:lex = ?lex } & lexicon.?lex.spos.?s & ?s == "copula" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:spos = ?p
  spos = ?spos
}
  ]
]

DSynt<=>SSynt attr_spos_lexicon : transfer_attributes
[
  leftside = [
c:?Xl {
  ¬c:spos = ?s
  c:lex = ?lex
}

lexicon.?lex.spos.?spos
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:spos = ?p
  spos = ?spos
}
  ]
]

DSynt<=>SSynt attr_spos_copula_replace : transfer_attributes
[
  leftside = [
c:?Xl {
  c:spos = "VV"
  c:lex = ?lex
}

lexicon.?lex.spos.?s
?s == "copula"
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  spos = "copula"
}
  ]
]

DSynt<=>SSynt attr_spos_numbers : transfer_attributes
[
  leftside = [
c:?Yl {
  ¬c:spos = ?s
  c:pos = "CD"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  spos = number
}
  ]
]

DSynt<=>SSynt attr_spos_default_NN : transfer_attributes
[
  leftside = [
c:?Xl {
  ¬c:spos = ?s
  c:lex = ?lex
  ¬c:NE = "YES" |
  (c:dpos = "N" | c:pos = "NN" )
}

¬lexicon.?lex.spos.?spos
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:spos = ?p
  spos = noun
}
  ]
]

DSynt<=>SSynt attr_spos_default_NP : transfer_attributes
[
  leftside = [
c:?Xl {
  ¬c:spos = ?s
  c:lex = ?lex
  c:NE = "YES"
}

¬lexicon.?lex.spos.?spos
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:spos = ?p
  spos = "NP"
}
  ]
]

DSynt<=>SSynt attr_spos_default_A : transfer_attributes
[
  leftside = [
c:?Xl {
  ¬c:spos = ?s
  c:lex = ?lex
  ( c:dpos = "A" | c:pos = "JJ" )
}

¬lexicon.?lex.spos.?spos
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:spos = ?p
  spos = adjective
}
  ]
]

DSynt<=>SSynt attr_spos_default_Adv : transfer_attributes
[
  leftside = [
c:?Xl {
  ¬c:spos = ?s
  c:lex = ?lex
  ( c:dpos = "Adv" | c:pos = "RB" )
}

¬lexicon.?lex.spos.?spos
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:spos = ?p
  spos = adverb
}
  ]
]

DSynt<=>SSynt attr_tc : transfer_attributes
[
  leftside = [
c:?Xl {
  tem_constituency = ?tc
}

( language.syntax.aspect.synthetic
  | ( ( language.id.iso.ES | language.id.iso.FR | language.id.iso.PT ) & c:?Xl { ( tem_constituency = "IMP" | tem_constituency = "PERF-S" ) } )
  | ( language.id.iso.CA & c:?Xl { tem_constituency = "IMP" } )

)
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

DSynt<=>SSynt attr_tc_default : transfer_attributes
[
  leftside = [
c:?Xl {
  ¬c:tem_constituency = ?tc
}

language.syntax.aspect.synthetic
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  // it was PROGR, any idea why?
  tem_constituency = "PERF-S"
}
  ]
]

DSynt<=>SSynt attr_tense : transfer_attributes
[
  leftside = [
c:?Xl {
  tense = ?n
}

¬ ?n == "-"
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:finiteness = "FIN"
  ¬rc:tense = ?ten
  tense=?n
}
  ]
]

DSynt<=>SSynt attr_tense_default : transfer_attributes
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  ( ¬c:tense = ?m | c:tense = "-" )
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

DSynt<=>SSynt attr_thematicity : transfer_attributes
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

DSynt<=>SSynt attr_type : transfer_attributes
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

DSynt<=>SSynt attr_uri : transfer_attributes
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
  ¬rc:spos = auxiliary
  ¬rc:spos = determiner
  ¬rc:spos = preposition
  uri = ?u
}
  ]
]

DSynt<=>SSynt attr_variable_class : transfer_attributes
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
  ¬rc:top = yes
  ¬rc:middle = yes
  variable_class = ?u
}
  ]
]

DSynt<=>SSynt attr_vncls : transfer_attributes
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

DSynt<=>SSynt attr_spos_default_V : transfer_attributes
[
  leftside = [
c:?Xl {
  ¬c:spos = ?s
  c:lex = ?lex
  ( c:dpos = "V"  | c:pos = "VB" )
}

¬lexicon.?lex.spos.?spos
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:spos = ?p
  spos = verb
}
  ]
]

DSynt<=>SSynt attr_voice : transfer_attributes
[
  leftside = [
c:?Xl {
  //voice = "PASS"
  voice = ?v
}

( language.id.iso.EL | ( ?v == "PASS" & language.syntax.verbform.synthetic ) )
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

DSynt<=>SSynt attr_weight_lexicon : transfer_attributes
[
  leftside = [
c:?Xl {
  c:lex = ?lex
}

lexicon.?lex.weight.?w
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  weight = ?w
}
  ]
]

/*A weight of 4 per default is assigned to dates. This should of course be refined by language*/
DSynt<=>SSynt attr_weight_class_4 : transfer_attributes
[
  leftside = [
c:?Xl {
  c:class = ?c
}

// list here values
?c == "Date"
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  weight = "4.0"
}
  ]
]

/*Rule to fix agreement problems in interrogative sentences of the type "what is x?"
Not sure about it, It seems like cheating - maybe change the way Oper is introduced for wh-interrogatives?*/
DSynt<=>SSynt attr_phifeat_wh : transfer_attributes
[
  leftside = [
c:?Oper{
  c:clause_type = "INT"
  c:pos = "VB"
  c:type = "support_verb_noIN"
  c:I-> c:?WH{
    c:pos = "WP"
  }
  c:II-> c:?Xl{}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  rc:person = ?person
  rc:number = ?number
}

rc:?WHr{
  rc:<=>?WH
  person = ?person
  number = ?number
}
  ]
]

/*Fuse this rule with anaphora_personal rules.*/
excluded DSynt<=>SSynt anaphora_possessives_mark_human_NE : anaphora_resolution
[
  leftside = [
c:?Node1 {
  c:case = "GEN"
   ¬c:ambiguous_antecedent = "yes" 
  c:<-> c:?Node2 {
    ( c:NE = "YES" & c:class = "person" )
  }
}

?case == "GEN_3_NEU_SG"
lexicon.miscellaneous.determiners.human.?case.?det

// only if governor is a noun or a gerund
c:?Govl {
  c:?r-> c:?Node1 {}
  ( c:pos = "NN" | c:finiteness = "GER" )  
}

// exclude cases of relative clause
¬ ( c:?Node2 { c:?t1-> c:?Verb1 {c:finiteness = "FIN" c:?r1-> c:?Node1 {}}} & ( ?t1 == ATTR | ?t1 == APPEND) )
¬ ( c:?Node2 { c:?t2-> c:?Verb2 {c:finiteness = "FIN" c:?r2-> c:?MNode { c:?s2-> c:?Node1 {}}}} & ( ?t2 == ATTR | ?t2 == APPEND) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Node1R {
  rc:<=> ?Node1
  ( rc:pos = "NN" | rc:pos = "NP" | rc:pos = "PRP" )
  rc:spos = ?spos
  case = ?case
  ¬rc:pronominalized = yes
  pos = "DT"
  spos = determiner
  slex = ?det
  pronominalized = yes
}
  ]
]

/*Fuse this rule with anaphora_personal rules.*/
excluded DSynt<=>SSynt anaphora_possessives_mark_human_PRO : anaphora_resolution
[
  leftside = [
c:?Node1 {
  c:case = "GEN"
   ¬c:ambiguous_antecedent = "yes" 
  c:dlex = ?dN1
  c:<-> c:?Node2 {
    ( c:pos = "PRP" & c:class = "person" )
  }
}

lexicon.miscellaneous.personal_pronouns.correspondences.?dN1.GEN.?det

// only if governor is a noun or a gerund
c:?Govl {
  c:?r-> c:?Node1 {}
  ( c:pos = "NN" | c:finiteness = "GER" )  
}

// exclude cases of relative clause
¬ ( c:?Node2 { c:?t1-> c:?Verb1 {c:finiteness = "FIN" c:?r1-> c:?Node1 {}}} & ( ?t1 == ATTR | ?t1 == APPEND) )
¬ ( c:?Node2 { c:?t2-> c:?Verb2 {c:finiteness = "FIN" c:?r2-> c:?MNode { c:?s2-> c:?Node1 {}}}} & ( ?t2 == ATTR | ?t2 == APPEND) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Node1R {
  rc:<=> ?Node1
  ( rc:pos = "NN" | rc:pos = "NP" | rc:pos = "PRP" )
  rc:spos = ?spos
  //case = ?case
  ¬rc:pronominalized = yes
  pos = "DT"
  spos = determiner
  slex = ?det
  pronominalized = yes
}
  ]
]

/*Fuse this rule with anaphora_personal rules.*/
excluded DSynt<=>SSynt anaphora_possessives_mark_non_human : anaphora_resolution
[
  leftside = [
c:?Node1 {
  c:case = "GEN"
   ¬c:ambiguous_antecedent = "yes" 
  c:<-> c:?Node2 {
    ¬( c:NE = "YES" & c:class = "person" )
  }
}

?case == "GEN_3_NEU_SG"
lexicon.miscellaneous.determiners.non_human.?case.?det

// only if governor is a noun or a gerund
c:?Govl {
  c:?r-> c:?Node1 {}
  ( c:pos = "NN" | c:finiteness = "GER" )  
}

// exclude cases of relative clause
¬ ( c:?Node2 { c:?t1-> c:?Verb1 {c:finiteness = "FIN" c:?r1-> c:?Node1 {}}} & ( ?t1 == ATTR | ?t1 == APPEND) )
¬ ( c:?Node2 { c:?t2-> c:?Verb2 {c:finiteness = "FIN" c:?r2-> c:?MNode { c:?s2-> c:?Node1 {}}}} & ( ?t2 == ATTR | ?t2 == APPEND) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Node1R {
  rc:<=> ?Node1
  ( rc:pos = "NN" | rc:pos = "NP" )
  rc:spos = ?spos
  case = ?case
  ¬rc:pronominalized = yes
  pos = "DT"
  spos = determiner
  slex = ?det
  pronominalized = yes
}

// the node above is not a preposition
¬rc:?Gov1R {
  rc:pos = "IN"
  rc:?R1-> rc:?Node1R {}
}
  ]
]

excluded DSynt<=>SSynt EN_anaphora_attr_gender : anaphora_resolution
[
  leftside = [
c:?Node1 {
  c:<-> c:?Node2 {
    c:gender = ?gen
  }
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Node1R {
  rc:<=> ?Node1
  rc:pronominalized = yes
  gender = ?gen
}
  ]
]

excluded DSynt<=>SSynt EN_anaphora_attr_gender_default : anaphora_resolution
[
  leftside = [
c:?Node1 {
  c:<-> c:?Node2 {
    ¬c:gender = ?gen
  }
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Node1R {
  rc:<=> ?Node1
  rc:pronominalized = yes
  gender = "NEU"
}
  ]
]

/*Covers PL and SG + ¬COORD*/
excluded DSynt<=>SSynt EN_anaphora_attr_number : anaphora_resolution
[
  leftside = [
c:?Node1 {
  c:<-> c:?Node2 {
    c:number = ?gen
  }
}

language.id.iso.EN

¬c:?Node2 {
  c:number = "SG"
  c:COORD-> c:?Yl {
    ( c:dlex = "and" | c:lex = "and_CC_01" )
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Node1R {
  rc:<=> ?Node1
  rc:pronominalized = yes
  number = ?gen
}
  ]
]

/*Covers no number.*/
excluded DSynt<=>SSynt EN_anaphora_attr_number_default : anaphora_resolution
[
  leftside = [
c:?Node1 {
  c:<-> c:?Node2 {
    ¬c:number = ?num
  }
}

language.id.iso.EN

¬c:?Node2 {
  c:COORD-> c:?Yl {
    ( c:dlex = "and" | c:lex = "and_CC_01" )
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Node1R {
  rc:<=> ?Node1
  rc:pronominalized = yes
  number = "SG"
}
  ]
]

excluded DSynt<=>SSynt anaphora_attr_number_COORD : anaphora_resolution
[
  leftside = [
c:?Root1 {
  c:?r-> c:?Xl {
    c:<-> c:?Ante {
      ¬c:number = "PL"
      c:COORD-> c:?Yl {
        ( c:dlex = "and" | c:lex = "and_CC_01" )
      }
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:pronominalized = yes
  ( rc:slex = "_PRO-HUM_" | rc:slex = "_PRO_" )
  rc:pos = "PP"
  number = "PL"
}
  ]
]

excluded DSynt<=>SSynt anaphora_attr_person : anaphora_resolution
[
  leftside = [
c:?Node1 {
  c:<-> c:?Node2 {
    c:person = ?gen
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Node1R {
  rc:<=> ?Node1
  rc:pronominalized = yes
  person = ?gen
}
  ]
]

excluded DSynt<=>SSynt anaphora_attr_person_default : anaphora_resolution
[
  leftside = [
c:?Node1 {
  c:<-> c:?Node2 {
    ¬c:person = ?gen
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Node1R {
  rc:<=> ?Node1
  rc:pronominalized = yes
  person = "3"
}
  ]
]

/*!!! EXCLUDE CASES OF "POSSESS"!*/
DSynt<=>SSynt anaphora_relative_non_human_noPrep : anaphora_resolution
[
  leftside = [
c:?Ante {
  c:?t-> c:?Verb {
    c:finiteness = "FIN"
    c:?r-> c:?Noun {
      //¬( c:NE = "YES" & c:class = "Person" )
      c:<-> c:?Ante {}
    }
  }
}

¬c:?Ante {c:NE = "YES" c:class = "Person" }
¬c:?Noun {c:NE = "YES" c:class = "Person" }

( ?t == ATTR | ?t == APPEND)
  ]
  mixed = [
rc:?SSyntGov { rc:?R-> rc:?NounR {rc:<=> ?Noun} }
lexicon.miscellaneous.relative_pronouns.non_human.?R.?relpro
lexicon.?relpro.lemma.?lem
lexicon.?relpro.pos.?pos
lexicon.?relpro.spos.?spos
// doesn't work without the following condition:
//(?R == SBJ | ?R == OBJ)
  ]
  rightside = [
rc:?SSyntGov {
  rc:?R-> rc:?NounR {
    rc:<=> ?Noun
    ¬rc:relativized = yes
    // if there is a governed preposition
    ¬ ( rc:top = yes & rc:pos = "IN" )
    rc:slex = ?s
    rc:pos = ?p
    rc:spos = ?sp
    slex = ?lem
    pos = ?pos
    spos = ?spos
    lex = ?relpro
    relativized = yes
  }
}
  ]
]

/*NOT TESTED!*/
DSynt<=>SSynt anaphora_relative_non_human_noPrep_poss : anaphora_resolution
[
  leftside = [
c:?Ante {
  c:?t-> c:?Verb {
    c:finiteness = "FIN"
    c:?r1-> c:?Noun1 {
      ( c:pos = "NN" | c:pos = "NP" )
      c:?r2-> c:?Noun {
        ( c:pos = "NN" | c:pos = "NP" )
        //¬( c:NE = "YES" & c:class = "Person" )
        c:<-> c:?Ante {}
      }
    }
  }
}

¬c:?Ante {c:NE = "YES" c:class = "Person" }
¬c:?Noun {c:NE = "YES" c:class = "Person" }

( ?t == ATTR | ?t == APPEND)
  ]
  mixed = [
rc:?SSyntGov { rc:?R-> rc:?NounR {rc:<=> ?Noun} }
lexicon.miscellaneous.relative_pronouns.non_human.?R.?relpro
lexicon.?relpro.lemma.?lem
lexicon.?relpro.pos.?pos
lexicon.?relpro.spos.?spos
//¬ ( language.id.iso.ES & ?relpro == "cuyo_WP_01" )
// doesn't work without the following condition:
//(?R == SBJ | ?R == OBJ)
  ]
  rightside = [
rc:?SSyntGov {
  rc:?R-> rc:?NounR {
    rc:<=> ?Noun
    ¬rc:relativized = yes
    // if there is a governed preposition
    ¬ ( rc:top = yes & rc:pos = "IN" )
    rc:slex = ?s
    rc:pos = ?p
    rc:spos = ?sp
    slex = ?lem
    pos = ?pos
    spos = ?spos
    lex = ?relpro
    relativized = yes
  }
}
  ]
]

/*!!! EXCLUDE CASES OF "POSSESS"!*/
DSynt<=>SSynt anaphora_relative_non_human_Prep : anaphora_resolution
[
  leftside = [
c:?Ante {
  c:?t-> c:?Verb {
    c:finiteness = "FIN"
    c:?r-> c:?Noun {
      //¬( c:NE = "YES" & c:class = "Person" )
      c:<-> c:?Ante {}
    }
  }
}

¬c:?Ante {c:NE = "YES" c:class = "Person" }
¬c:?Noun {c:NE = "YES" c:class = "Person" }

( ?t == ATTR | ?t == APPEND)
  ]
  mixed = [
rc:?SSyntGov { rc:?R-> rc:?PrepR {rc:<=> ?Noun} }
lexicon.miscellaneous.relative_pronouns.non_human.?R.?relpro
lexicon.?relpro.lemma.?lem
lexicon.?relpro.pos.?pos
lexicon.?relpro.spos.?spos
// doesn't work without the following condition:
//(?R == SBJ | ?R == OBJ)
  ]
  rightside = [
rc:?SSyntGov {
  rc:?R-> rc:?PrepR {
    rc:<=> ?Noun
    // if there is a governed preposition
    rc:top = yes
    rc:pos = "IN"
    rc:?R2-> rc:?NounR {
      rc:<=> ?Noun
      ¬rc:relativized = yes
      ¬rc:top = yes
      rc:slex = ?s
      rc:pos = ?p
      rc:spos = ?sp
      slex = ?lem
      pos = ?pos
      spos = ?spos
      lex = ?relpro
      relativized = yes
    }
  }
}
  ]
]

DSynt<=>SSynt anaphora_relative_non_human_Prep_poss : anaphora_resolution
[
  leftside = [
c:?Ante {
  c:?t-> c:?Verb {
    c:finiteness = "FIN"
    c:?r1-> c:?Noun1 {
      ( c:pos = "NN" | c:pos = "NP" )
      c:?r2-> c:?Noun {
        ( c:pos = "NN" | c:pos = "NP" )
        //¬( c:NE = "YES" & c:class = "Person" )
        c:<-> c:?Ante {}
      }
    }
  }
}

¬c:?Ante {c:NE = "YES" c:class = "Person" }
¬c:?Noun {c:NE = "YES" c:class = "Person" }

( ?t == ATTR | ?t == APPEND)
  ]
  mixed = [
rc:?SSyntGov { rc:?R-> rc:?PrepR {rc:<=> ?Noun rc:?R2-> rc:?NounR {rc:<=> ?Noun } } }
lexicon.miscellaneous.relative_pronouns.non_human.?R2.?relpro
lexicon.?relpro.lemma.?lem
lexicon.?relpro.pos.?pos
lexicon.?relpro.spos.?spos
¬ ( language.id.iso.ES & ?relpro == "cuyo_WP_01" )
// doesn't work without the following condition:
//(?R == SBJ | ?R == OBJ)
  ]
  rightside = [
rc:?SSyntGov {
  rc:?R-> rc:?PrepR {
    rc:<=> ?Noun
    // if there is a governed preposition
    rc:top = yes
    rc:pos = "IN"
    rc:?R2-> rc:?NounR {
      rc:<=> ?Noun
      ¬rc:relativized = yes
      ¬rc:top = yes
      rc:slex = ?s
      rc:pos = ?p
      rc:spos = ?sp
      slex = ?lem
      pos = ?pos
      spos = ?spos
      lex = ?relpro
      relativized = yes
    }
  }
}
  ]
]

/*For semantic prepositions, which are here in DSynt already.
Pilot rule, if it works do the other ones too.*/
DSynt<=>SSynt anaphora_relative_non_human_PrepSem_MISSING : anaphora_resolution
[
  leftside = [
c:?Ante {
  c:?t-> c:?Verb {
    c:finiteness = "FIN"
    c:?r-> c:?Prep {
      c:pos = "IN"
      //¬( c:NE = "YES" & c:class = "Person" )
      c:II-> c:?Noun {
        c:<-> c:?Ante {}
      }
    }
  }
}

¬c:?Ante {c:NE = "YES" c:class = "Person" }
¬c:?Noun {c:NE = "YES" c:class = "Person" }

( ?t == ATTR | ?t == APPEND)
  ]
  mixed = [
rc:?SSyntGov { rc:?R-> rc:?PrepR {rc:<=> ?Prep} }
lexicon.miscellaneous.relative_pronouns.non_human.?R.?relpro
lexicon.?relpro.lemma.?lem
lexicon.?relpro.pos.?pos
lexicon.?relpro.spos.?spos
// doesn't work without the following condition:
//(?R == SBJ | ?R == OBJ)
  ]
  rightside = [
rc:?SSyntGov {
  rc:?R-> rc:?PrepR {
    rc:<=> ?Prep
    rc:pos = "IN"
    rc:?R2-> rc:?NounR {
      rc:<=> ?Noun
      ¬rc:relativized = yes
      ¬rc:top = yes
      rc:slex = ?s
      rc:pos = ?p
      rc:spos = ?sp
      slex = ?lem
      pos = ?pos
      spos = ?spos
      lex = ?relpro
      relativized = yes
    }
  }
}
  ]
]

/*This rule overlaps with the one above... No match overlap though, since there is no LS consumption.*/
DSynt<=>SSynt ES_anaphora_relative_non_human_Prep_poss_cuyo : anaphora_resolution
[
  leftside = [
c:?Ante {
  c:?t-> c:?Verb {
    c:finiteness = "FIN"
    c:?r1-> c:?Noun1 {
      ( c:pos = "NN" | c:pos = "NP" )
      // cuyo only goes with definite nouns (right?)
      ¬c:definiteness = "INDEF"
     // see WebNLG test_triples3_es, str 52; not sure this is the right condition
      ¬c:definiteness = "no"
      c:?r2-> c:?Noun {
        ( c:pos = "NN" | c:pos = "NP" )
        //¬( c:NE = "YES" & c:class = "Person" )
        c:<-> c:?Ante {}
      }
    }
  }
}

¬c:?Ante {c:NE = "YES" c:class = "Person" }
¬c:?Noun {c:NE = "YES" c:class = "Person" }

language.id.iso.ES

( ?t == ATTR | ?t == APPEND)
  ]
  mixed = [
rc:?SSyntGov { rc:?R-> rc:?PrepR {rc:<=> ?Noun} }
lexicon.miscellaneous.relative_pronouns.non_human.?R.?relpro
lexicon.?relpro.lemma.?lem
lexicon.?relpro.pos.?pos
lexicon.?relpro.spos.?spos
?relpro == "cuyo_WP_01"
// doesn't work without the following condition:
//(?R == SBJ | ?R == OBJ)
  ]
  rightside = [
rc:?SSyntGov {
  rc:?R-> rc:?PrepR {
    rc:<=> ?Noun
    // if there is a governed preposition
    rc:top = yes
    rc:pos = "IN"
    ¬rc:relativized = yes
    rc:slex = ?slexR
    rc:spos = ?sp
    slex = "_PRO_"
    pos = ?pos
    spos = ?spos
    lex = ?relpro
    relativized = yes
    person = "3"
  }
}
  ]
]

/*!!! EXCLUDE CASES OF "POSSESS"!*/
DSynt<=>SSynt anaphora_relative_human_noPrep : anaphora_resolution
[
  leftside = [
c:?Ante {
  c:?t-> c:?Verb {
    c:finiteness = "FIN"
    c:?r-> c:?Noun {
      //( c:NE = "YES" & c:class = "Person" )
      c:<-> c:?Ante {}
    }
  }
}

( c:?Ante {c:NE = "YES" c:class = "Person" }
 | c:?Noun {c:NE = "YES" c:class = "Person" } )
 
( ?t == ATTR | ?t == APPEND)
  ]
  mixed = [
rc:?SSyntGov { rc:?R-> rc:?NounR {rc:<=> ?Noun} }
lexicon.miscellaneous.relative_pronouns.human.?R.?relpro
lexicon.?relpro.lemma.?lem
lexicon.?relpro.pos.?pos
lexicon.?relpro.spos.?spos
// doesn't work without the following condition:
//(?R == SBJ | ?R == OBJ)
  ]
  rightside = [
rc:?SSyntGov {
  rc:?R-> rc:?NounR {
    rc:<=> ?Noun
    ¬rc:relativized = yes
    // if there is a governed preposition
    ¬ ( rc:top = yes & rc:pos = "IN" )
    rc:slex = ?s
    rc:pos = ?p
    rc:spos = ?sp
    slex = ?lem
    pos = ?pos
    spos = ?spos
    lex = ?relpro
    relativized = yes
  }
}
  ]
]

/*Not tested!*/
DSynt<=>SSynt anaphora_relative_human_noPrep_poss : anaphora_resolution
[
  leftside = [
c:?Ante {
  c:?t-> c:?Verb {
    c:finiteness = "FIN"
    c:?r1-> c:?Noun1 {
      ( c:pos = "NN" | c:pos = "NP" )
      c:?r2-> c:?Noun {
        ( c:pos = "NN" | c:pos = "NP" )
        //( c:NE = "YES" & c:class = "Person" )
        c:<-> c:?Ante {}
      }
    }
  }
}

( c:?Ante {c:NE = "YES" c:class = "Person" }
 | c:?Noun {c:NE = "YES" c:class = "Person" } )

( ?t == ATTR | ?t == APPEND)
  ]
  mixed = [
rc:?SSyntGov { rc:?R-> rc:?NounR {rc:<=> ?Noun } }
lexicon.miscellaneous.relative_pronouns.human.?R.?relpro
lexicon.?relpro.lemma.?lem
lexicon.?relpro.pos.?pos
lexicon.?relpro.spos.?spos
//¬ ( language.id.iso.ES & ?relpro == "cuyo_WP_01" )
// doesn't work without the following condition:
//(?R == SBJ | ?R == OBJ)
  ]
  rightside = [
rc:?SSyntGov {
  rc:?R-> rc:?NounR {
    rc:<=> ?Noun
    ¬rc:relativized = yes
    // if there is a governed preposition
    ¬ ( rc:top = yes & rc:pos = "IN" )
    rc:slex = ?s
    rc:pos = ?p
    rc:spos = ?sp
    slex = ?lem
    pos = ?pos
    spos = ?spos
    lex = ?relpro
    relativized = yes
  }
}
  ]
]

/*!!! EXCLUDE CASES OF "POSSESS"!*/
DSynt<=>SSynt anaphora_relative_human_Prep : anaphora_resolution
[
  leftside = [
c:?Ante {
  c:?t-> c:?Verb {
    c:finiteness = "FIN"
    c:?r-> c:?Noun {
      //( c:NE = "YES" & c:class = "Person" )
      c:<-> c:?Ante {}
    }
  }
}

( c:?Ante {c:NE = "YES" c:class = "Person" }
 | c:?Noun {c:NE = "YES" c:class = "Person" } )

( ?t == ATTR | ?t == APPEND)
  ]
  mixed = [
rc:?SSyntGov { rc:?R-> rc:?PrepR {rc:<=> ?Noun} }
lexicon.miscellaneous.relative_pronouns.human.?R.?relpro
lexicon.?relpro.lemma.?lem
lexicon.?relpro.pos.?pos
lexicon.?relpro.spos.?spos
// doesn't work without the following condition:
//(?R == SBJ | ?R == OBJ)
  ]
  rightside = [
rc:?SSyntGov {
  rc:?R-> rc:?PrepR {
    rc:<=> ?Noun
    // if there is a governed preposition
    rc:top = yes
    rc:pos = "IN"
    rc:?R2-> rc:?NounR {
      rc:<=> ?Noun
      ¬rc:relativized = yes
      ¬rc:top = yes
      rc:slex = ?s
      rc:pos = ?p
      rc:spos = ?sp
      slex = ?lem
      pos = ?pos
      spos = ?spos
      lex = ?relpro
      relativized = yes
    }
  }
}
  ]
]

/*Not tested!*/
DSynt<=>SSynt anaphora_relative_human_Prep_poss : anaphora_resolution
[
  leftside = [
c:?Ante {
  c:?t-> c:?Verb {
    c:finiteness = "FIN"
    c:?r1-> c:?Noun1 {
      ( c:pos = "NN" | c:pos = "NP" )
      c:?r2-> c:?Noun {
        ( c:pos = "NN" | c:pos = "NP" )
        //( c:NE = "YES" & c:class = "Person" )
        c:<-> c:?Ante {}
      }
    }
  }
}

( c:?Ante {c:NE = "YES" c:class = "Person" }
 | c:?Noun {c:NE = "YES" c:class = "Person" } )
 
( ?t == ATTR | ?t == APPEND)
  ]
  mixed = [
rc:?SSyntGov { rc:?R-> rc:?PrepR {rc:<=> ?Noun} }
lexicon.miscellaneous.relative_pronouns.human.?R.?relpro
lexicon.?relpro.lemma.?lem
lexicon.?relpro.pos.?pos
lexicon.?relpro.spos.?spos
¬ ( language.id.iso.ES & ?relpro == "cuyo_WP_01" )
// doesn't work without the following condition:
//(?R == SBJ | ?R == OBJ)
  ]
  rightside = [
rc:?SSyntGov {
  rc:?R-> rc:?PrepR {
    rc:<=> ?Noun
    // if there is a governed preposition
    rc:top = yes
    rc:pos = "IN"
    rc:?R2-> rc:?NounR {
      rc:<=> ?Noun
      ¬rc:relativized = yes
      ¬rc:top = yes
      rc:slex = ?s
      rc:pos = ?p
      rc:spos = ?sp
      slex = ?lem
      pos = ?pos
      spos = ?spos
      lex = ?relpro
      relativized = yes
    }
  }
}
  ]
]

DSynt<=>SSynt anaphora_relative_possess : anaphora_resolution
[
  leftside = [
c:?Ante {
  ( c:pos = "NN" | c:finiteness = "GER" )
  c:?r1-> c:?Verb {
    c:finiteness = "FIN"
    c:?r2-> c:?node {
      c:?r3-> c:?Noun {
        c:<-> c:?Ante {}
      }
    }
  }
}

( ?r1 == ATTR | ?r1 == APPEND )
  ]
  mixed = [
lexicon.miscellaneous.relative_pronouns.human.NMOD.?relpro
lexicon.?relpro.lemma.?lem
lexicon.?relpro.pos.?pos
lexicon.?relpro.spos.?spos
  ]
  rightside = [
rc:?GovR {
  rc:NMOD-> rc:?NounR {
    rc:<=> ?Noun
    ¬rc:relativized = yes
    rc:slex = ?s
    rc:pos = ?p
    rc:spos = ?sp
    slex = ?lem
    pos = ?pos
    spos = ?spos
    lex = ?relpro
    relativized = yes
  }
}

¬?p == "IN"
// seems to be a BUG here, so I add this condition
¬rc:?NodeR { rc:pos = "IN" rc:?RRR-> rc:?NounR {} }
  ]
]

/*If the governor is a verb and the antecedent is just above, the dependent should be a relative pronoun.
This rule applies if the antecedent is the subject of the main verb in the previous sentence.
This rule should be completed by the Prep counterpart, and the block_dep_pronoun_gen rules in level 35 be changed accordingly.
WebNLG_test_triples5_es.conll Sent6, 170822a_known_input_multiple2.conll Sent251*/
excluded DSynt<=>SSynt anaphora_personal_non_human_direct : anaphora_resolution
[
  leftside = [
c:?Sent1 {
  c:dlex = "Sentence"
  c:?Root1 {
    c:?r-> c:?Ante {}
  }
  c:b-> c:?Sent2 {
    c:dlex = "Sentence"
    c:?Gov {
      ¬c:definiteness = "INDEF"
      ¬c:pos = "JJ"
      c:?a-> c:?Dep {
        //¬( c:NE = "YES" & c:class = "Person" )
        // only pronominalize if there is no dependent, or if subtree is the same
         ( ¬c:?dep-> c:?Depl {} | ¬c:subtree_coref = "different" )
        ¬c:pos = "WDT"
        c:<-> c:?Ante {}
      }
    }
  }
}

¬language.id.iso.EL
// Seems to be a BUG when this condition is here!!! See en_genInputs str 136
//¬project_info.project.pronominalize.no

¬c:?Ante {c:NE = "YES" c:class = "Person" }
¬c:?Dep {c:NE = "YES" c:class = "Person" }

//If the governor is a finite verb and the antecedent is just above, the dependent should be a relative pronoun.
¬(c:?Ante {c:ATTR-> c:?Gov {c:finiteness = "FIN"}})

//if the relative pronoun is already inserted, it's not necessary the lemma transformation. TEST this with KRISTINA
¬?Dep.lemma == "that"

// ?Root1 is a root
¬c:?Grandma1 { c:?rel1-> c:?Root1 {} }

¬ c:?Dep { c:COORD-> c:?Conj2 {} }
¬ c:?Ante { c:COORD-> c:?Conj3 {} }

// See anaphoraSameLoc; this condition may be very simplistic
¬ ( ?Dep.class == "Location" )
¬ ( ?Dep.SameLocAsPrevious == "YES" )
  ]
  mixed = [
rc:?DepR { rc:<=>?Dep }

( ¬ ( ?DepR.top == yes & ?DepR.pos == "IN" )
  | ( language.id.iso.EN & ?DepR.slex == "of" )
  | ( language.id.iso.ES & ?DepR.slex == "de" )
)

¬project_info.project.pronominalize.no

//NOT IN LEXICON YET
//lexicon.?ppro.lemma.?lem
//lexicon.?ppro.pos.?pos
//lexicon.?ppro.spos.?spos
// doesn't work without the following condition:
//(?R == SBJ | ?R == OBJ)
  ]
  rightside = [
rc:?GovR {
  rc:<=> ?Gov
  rc:?R-> rc:?DepR {
    rc:<=> ?Dep
    //( ¬ ( rc:top = yes & rc:pos = "IN" ) | rc:slex = "of" )
    ¬rc:pronominalized = yes
    rc:slex = ?slex
    slex = "_PRO_"
    pos = "PP"
    spos = personal_pronoun
    pronominalized = yes
  }
}

( rc:?Root1R {
  rc:<=> ?Root1
  rc:?SBJ-> rc:?AnteR {
    rc:<=> ?Ante
  }
}
// & ( ?SBJ == SBJ | ?SBJ == subj )
 & ( ( ( ?SBJ == SBJ | ?SBJ == subj ) & ¬?R == PRD & ¬?R == copul & ¬?R == LGS & ¬?R == agent )
        | ( ( ?SBJ == PRD | ?SBJ == OBJ | ?SBJ == dobj | ?SBJ == copul )
        // removed copul & PRD
             & ( ?R == OBJ | ?R == dobj ) )
     )
)
  ]
]

/*If the governor is a verb and the antecedent is just above, the dependent should be a relative pronoun.
This rule applies if the antecedent is the subject of the main verb in the previous sentence.
Problem with when the prep is "of" for instance, where we don't want to keep the "of". 

EG: 250_Delaware_Avenue , the architectural style of which is Postmodern_architecture , is in Buffalo_(New_York) . the construction of it began in January,_2014 . 250_Delaware_Avenue has a floor area of 30843.8_square_meters and 12 floors .
Bhaji , found in Karnataka , comes from India . a Bhaji is also called bhaji_and_bajji . Bhaji contains gram_flour . the main ingredients in Bhaji are gram_flour_and_vegetables .*/
excluded DSynt<=>SSynt anaphora_personal_non_human_direct_prep : anaphora_resolution
[
  leftside = [
c:?Sent1 {
  c:dlex = "Sentence"
  c:?Root1 {
    c:?r-> c:?Ante {}
  }
  c:b-> c:?Sent2 {
    c:dlex = "Sentence"
    c:?Gov {
      ¬c:definiteness = "INDEF"
      ¬c:pos = "JJ"
      c:?a-> c:?Dep {
        //¬( c:NE = "YES" & c:class = "Person" )
        // only pronominalize if there is no dependent, or if subtree is the same
         ( ¬c:?dep-> c:?Depl {} | ¬c:subtree_coref = "different" )
        ¬c:pos = "WDT"
        c:<-> c:?Ante {}
      }
    }
  }
}

¬language.id.iso.EL
¬project_info.project.pronominalize.no

¬c:?Ante {c:NE = "YES" c:class = "Person" }
¬c:?Dep {c:NE = "YES" c:class = "Person" }

//If the governor is a finite verb and the antecedent is just above, the dependent should be a relative pronoun.
¬(c:?Ante {c:ATTR-> c:?Gov {c:finiteness = "FIN"}})

//if the relative pronoun is already inserted, it's not necessary the lemma transformation. TEST this with KRISTINA
¬?Dep.lemma == "that"

// ?Root1 is a root
¬c:?Grandma1 { c:?rel1-> c:?Root1 {} }

¬ c:?Dep { c:COORD-> c:?Conj2 {} }
¬ c:?Ante { c:COORD-> c:?Conj3 {} }

// See anaphoraSameLoc; this condition may be very simplistic
¬ ( ?Dep.class == "Location" )
¬ ( ?Dep.SameLocAsPrevious == "YES" )
  ]
  mixed = [
¬ ( rc:?DepR {rc:<=>?Dep rc:slex = ?sD }
  & ( ( language.id.iso.EN & ?sD == "of" ) | ( language.id.iso.ES & ?sD == "de" ) )
)

//NOT IN LEXICON YET
//lexicon.?ppro.lemma.?lem
//lexicon.?ppro.pos.?pos
//lexicon.?ppro.spos.?spos
// doesn't work without the following condition:
//(?R == SBJ | ?R == OBJ)
  ]
  rightside = [
rc:?GovR {
  rc:<=> ?Gov
  rc:?R-> rc:?DepR {
    rc:<=> ?Dep
    rc:top = yes
    rc:pos = "IN"
    //¬rc:slex = "of"
    rc:?R2-> rc:?prepDep {
      ¬rc:pronominalized = yes
      rc:slex = ?slex
      slex = "_PRO_"
      pos = "PP"
      spos = personal_pronoun
      pronominalized = yes
    }
  }
}

( rc:?Root1R {
  rc:<=> ?Root1
  rc:?SBJ-> rc:?AnteR {
    rc:<=> ?Ante
  }
}
// & ( ?SBJ == SBJ | ?SBJ == subj )
 & ( ( ( ?SBJ == SBJ | ?SBJ == subj ) & ¬?R == PRD & ¬?R == copul & ¬?R == LGS & ¬?R == agent )
        | ( ( ?SBJ == PRD | ?SBJ == OBJ | ?SBJ == dobj | ?SBJ == copul )
        // removed copul & PRD
             & ( ?R == OBJ | ?R == dobj ) )
     )
)
  ]
]

/*In Greek, it looks better if we maintain the ambiguity rather than repeating a subject/object.*/
excluded DSynt<=>SSynt EL_anaphora_personal_non_human_direct : anaphora_resolution
[
  leftside = [
c:?Sent1 {
  c:dlex = "Sentence"
  c:?Root1 {
    c:?r-> c:?Ante {}
  }
  c:b-> c:?Sent2 {
    c:dlex = "Sentence"
    c:?Gov {
      ¬c:definiteness = "INDEF"
      ¬c:pos = "JJ"
      c:?a-> c:?Dep {
        //¬( c:NE = "YES" & c:class = "Person" )
        // only pronominalize if there is no dependent, or if subtree is the same
         ( ¬c:?dep-> c:?Depl {} | ¬c:subtree_coref = "different" )
        ¬c:pos = "WDT"
        c:<-> c:?Ante {}
      }
    }
  }
}

language.id.iso.EL
¬project_info.project.pronominalize.no

¬c:?Ante {c:NE = "YES" c:class = "Person" }
¬c:?Dep {c:NE = "YES" c:class = "Person" }

//If the governor is a finite verb and the antecedent is just above, the dependent should be a relative pronoun.
¬(c:?Ante {c:ATTR-> c:?Gov {c:finiteness = "FIN"}})

// ?Root1 is a root
¬c:?Grandma1 { c:?rel1-> c:?Root1 {} }

¬ c:?Dep { c:COORD-> c:?Conj2 {} }
¬ c:?Ante { c:COORD-> c:?Conj3 {} }

// See anaphoraSameLoc; this condition may be very simplistic
¬ ( ?Dep.class == "Location" )
¬ ( ?Dep.SameLocAsPrevious == "YES" )
  ]
  mixed = [
//rc:?GovR {rc:<=> ?Gov rc:?R-> rc:?DepR {rc:<=>?Dep} }
//lexicon.miscellaneous.personal_pronouns.non_human.SG.MASC.?R.?ppro

//NOT IN LEXICON YET
//lexicon.?ppro.lemma.?lem
//lexicon.?ppro.pos.?pos
//lexicon.?ppro.spos.?spos
// doesn't work without the following condition:
//(?R == SBJ | ?R == OBJ)
  ]
  rightside = [
rc:?GovR {
  rc:<=> ?Gov
  rc:?R-> rc:?DepR {
    rc:<=> ?Dep
    ¬rc:pronominalized = yes
    rc:slex = ?slex
    slex = "_PRO_"
    pos = "PP"
    spos = personal_pronoun
    pronominalized = yes
  }
}

( rc:?Root1R {
  rc:<=> ?Root1
  rc:?SBJ-> rc:?AnteR {
    rc:<=> ?Ante
  }
}
 & ( ?SBJ == subj | ?SBJ == dobj | ?SBJ == copul )
 & ( ?R == subj | ?R == dobj | ?R == copul )
)
  ]
]

/*When the anetcedent and the node referring to it are in the same sentence.
MindSpaces 200126 sent.12
These rules should apply after the other pronominalization rules (relatives and personal have priority): smol HACK: we use depth.*/
DSynt<=>SSynt anaphora_personal_non_human_direct_sameSent : anaphora_resolution
[
  leftside = [
c:?Sent2 {
  c:dlex = "Sentence"
  c:?Root1 {
    c:*?r-> c:?Ante {}
    c:*?s->  c:?Gov {
      ¬c:definiteness = "INDEF"
      ¬c:pos = "JJ"
      c:?a-> c:?Dep {
        //¬( c:NE = "YES" & c:class = "Person" )
        // only pronominalize if there is no dependent, or if subtree is the same
         ( ¬c:?dep-> c:?Depl {} | ¬c:subtree_coref = "different" )
        ¬c:pos = "WDT"
        c:<-> c:?Ante {}
      }
    }
  }

}

¬project_info.project.pronominalize.no

¬c:?Ante {c:NE = "YES" c:class = "Person" }
¬c:?Dep {c:NE = "YES" c:class = "Person" }

//If the governor is a finite verb and the antecedent is just above, the dependent should be a relative pronoun.
¬(c:?Ante {c:ATTR-> c:?Gov {c:finiteness = "FIN"}})

//if the relative pronoun is already inserted, it's not necessary the lemma transformation. TEST this with KRISTINA
¬?Dep.lemma == "that"

// ?Root1 is a root
¬c:?Grandma1 { c:?rel1-> c:?Root1 {} }

¬ c:?Dep { c:COORD-> c:?Conj2 {} }
¬ c:?Ante { c:COORD-> c:?Conj3 {} }

// See anaphoraSameLoc; this condition may be very simplistic
¬ ( ?Dep.class == "Location" )
¬ ( ?Dep.SameLocAsPrevious == "YES" )
  ]
  mixed = [
//rc:?GovR {rc:<=> ?Gov rc:?R-> rc:?DepR {rc:<=>?Dep} }
//lexicon.miscellaneous.personal_pronouns.non_human.SG.MASC.?R.?ppro

//NOT IN LEXICON YET
//lexicon.?ppro.lemma.?lem
//lexicon.?ppro.pos.?pos
//lexicon.?ppro.spos.?spos
// doesn't work without the following condition:
//(?R == SBJ | ?R == OBJ)
  ]
  rightside = [
rc:?GovR {
  rc:<=> ?Gov
  rc:?R-> rc:?DepR {
    rc:<=> ?Dep
    rc:depth = ?swD
    ¬rc:pronominalized = yes
    ( rc:pos = "NN" | rc:pos = "NP" )
    rc:slex = ?slex
    slex = "_PRO_"
    pos = "PP"
    spos = personal_pronoun
    pronominalized = yes
  }
}

( rc:?Root1R {
  //rc:<=> ?Root1
  rc:?SBJ-> rc:?AnteR {
    rc:<=> ?Ante
  }
}
// & ( ?SBJ == SBJ | ?SBJ == subj )
 & ( ( ( ?SBJ == SBJ | ?SBJ == subj ) & ¬?R == PRD & ¬?R == copul & ¬?R == LGS & ¬?R == agent )
        | ( ( ?SBJ == PRD | ?SBJ == OBJ | ?SBJ == dobj | ?SBJ == copul )
        // removed copul & PRD
             & ( ?R == OBJ | ?R == dobj ) )
     )
)
  ]
]

/*If the governor is a verb and the antecedent is just above, the dependent should be a relative pronoun.
This rule applies if the subject of the preceding sentence points to the same node as ?Dep.
This rule should be completed by the Prep counterpart, and the block_dep_pronoun_gen rules in level 35 be changed accordingly.
WebNLG_test_triples5_es.conll Sent6, 170822a_known_input_multiple2.conll Sent251*/
excluded DSynt<=>SSynt anaphora_personal_non_human_indirect : anaphora_resolution
[
  leftside = [
c:?Sent1 {
  c:dlex = "Sentence"
  c:?Root1 {
    c:?r-> c:?OtherNode {
      c:<-> c:?Ante {}
    }
  }
  c:b-> c:?Sent2 {
    c:dlex = "Sentence"
    c:?Gov {
      ¬c:definiteness = "INDEF"
      c:?a-> c:?Dep {
        //¬( c:NE = "YES" & c:class = "Person" )
        // only pronominalize if there is no dependent, or if subtree is the same
         ( ¬c:?dep-> c:?Depl {} | ¬c:subtree_coref = "different" )
        ¬c:pos = "WDT"
        c:<-> c:?Ante {}
      }
    }
  }
}

¬language.id.iso.EL

¬c:?Ante {c:NE = "YES" c:class = "Person" }
¬c:?Dep {c:NE = "YES" c:class = "Person" }

//If the governor is a finite verb and the antecedent is just above, the dependent should be a relative pronoun.
¬(c:?Ante {c:ATTR-> c:?Gov {c:finiteness = "FIN"}})

//if the relative pronoun is already inserted, it's not necessary the lemma transformation. TEST this with KRISTINA
¬?Dep.lemma == "that"

// ?Root1 is a root
¬c:?Grandma1 { c:?rel1-> c:?Root1 {} }

¬ c:?Dep { c:COORD-> c:?Conj2 {} }
¬ c:?Ante { c:COORD-> c:?Conj3 {} }
  ]
  mixed = [
rc:?DepR { rc:<=>?Dep }

( ¬ ( ?DepR.top == yes & ?DepR.pos == "IN" )
  | ( language.id.iso.EN & ?DepR.slex == "of" )
  | ( language.id.iso.ES & ?DepR.slex == "de" )
)

¬project_info.project.pronominalize.no

//NOT IN LEXICON YET
//lexicon.?ppro.lemma.?lem
//lexicon.?ppro.pos.?pos
//lexicon.?ppro.spos.?spos
// doesn't work without the following condition:
//(?R == SBJ | ?R == OBJ)
  ]
  rightside = [
rc:?GovR {
  rc:<=> ?Gov
  rc:?R-> rc:?DepR {
    rc:<=> ?Dep
    // ( ¬ ( rc:top = yes & rc:pos = "IN" ) | rc:slex = "of" )
    ¬rc:pronominalized = yes
    rc:slex = ?slex
    slex = "_PRO_"
    pos = "PP"
    spos = personal_pronoun
    pronominalized = yes
  }
}

( rc:?Root1R {
  rc:<=> ?Root1
  rc:?SBJ-> rc:?OtherNodeR {
    rc:<=> ?OtherNode
  }
}
// & ( ?SBJ == SBJ | ?SBJ == subj )
  & ( ( ( ?SBJ == SBJ | ?SBJ == subj ) & ¬?R == PRD & ¬?R == copul & ¬?R == LGS & ¬?R == agent )
        | ( ( ?SBJ == PRD | ?SBJ == OBJ | ?SBJ == dobj | ?SBJ == copul )
        // removed copul & PRD
             & ( ?R == OBJ | ?R == dobj ) )
     )
)
  ]
]

/*If the governor is a verb and the antecedent is just above, the dependent should be a relative pronoun.
This rule applies if the subject of the preceding sentence points to the same node as ?Dep.
Problem with when the prep is "of" for instance, where we don't want to keep the "of". 

EG: 250_Delaware_Avenue , the architectural style of which is Postmodern_architecture , is in Buffalo_(New_York) . the construction of it began in January,_2014 . 250_Delaware_Avenue has a floor area of 30843.8_square_meters and 12 floors .
Bhaji , found in Karnataka , comes from India . a Bhaji is also called bhaji_and_bajji . Bhaji contains gram_flour . the main ingredients in Bhaji are gram_flour_and_vegetables .*/
excluded DSynt<=>SSynt anaphora_personal_non_human_indirect_prep : anaphora_resolution
[
  leftside = [
c:?Sent1 {
  c:dlex = "Sentence"
  c:?Root1 {
    c:?r-> c:?OtherNode {
      c:<-> c:?Ante {}
    }
  }
  c:b-> c:?Sent2 {
    c:dlex = "Sentence"
    c:?Gov {
      ¬c:definiteness = "INDEF"
      c:?a-> c:?Dep {
        //¬( c:NE = "YES" & c:class = "Person" )
        // only pronominalize if there is no dependent, or if subtree is the same
         ( ¬c:?dep-> c:?Depl {} | ¬c:subtree_coref = "different" )
        ¬c:pos = "WDT"
        c:<-> c:?Ante {}
      }
    }
  }
}

¬language.id.iso.EL
¬project_info.project.pronominalize.no

¬c:?Ante {c:NE = "YES" c:class = "Person" }
¬c:?Dep {c:NE = "YES" c:class = "Person" }

//If the governor is a finite verb and the antecedent is just above, the dependent should be a relative pronoun.
¬(c:?Ante {c:ATTR-> c:?Gov {c:finiteness = "FIN"}})

//if the relative pronoun is already inserted, it's not necessary the lemma transformation. TEST this with KRISTINA
¬?Dep.lemma == "that"

// ?Root1 is a root
¬c:?Grandma1 { c:?rel1-> c:?Root1 {} }

¬ c:?Dep { c:COORD-> c:?Conj2 {} }
¬ c:?Ante { c:COORD-> c:?Conj3 {} }
  ]
  mixed = [
¬ ( rc:?DepR {rc:<=>?Dep rc:slex = ?sD }
  & ( ( language.id.iso.EN & ?sD == "of" ) | ( language.id.iso.ES & ?sD == "de" ) )
)

//NOT IN LEXICON YET
//lexicon.?ppro.lemma.?lem
//lexicon.?ppro.pos.?pos
//lexicon.?ppro.spos.?spos
// doesn't work without the following condition:
//(?R == SBJ | ?R == OBJ)
  ]
  rightside = [
rc:?GovR {
  rc:<=> ?Gov
  rc:?R-> rc:?DepR {
    rc:<=> ?Dep
    rc:top = yes
    rc:pos = "IN"
    //¬rc:slex = "of"
    rc:?R2-> ?prepDep {
      ¬rc:pronominalized = yes
      rc:slex = ?slex
      slex = "_PRO_"
      pos = "PP"
      spos = personal_pronoun
      pronominalized = yes
    }
  }
}

( rc:?Root1R {
  rc:<=> ?Root1
  rc:?SBJ-> rc:?OtherNodeR {
    rc:<=> ?OtherNode
  }
}
// & ( ?SBJ == SBJ | ?SBJ == subj )
  & ( ( ( ?SBJ == SBJ | ?SBJ == subj ) & ¬?R == PRD & ¬?R == copul & ¬?R == LGS & ¬?R == agent )
        | ( ( ?SBJ == PRD | ?SBJ == OBJ | ?SBJ == dobj | ?SBJ == copul )
        // removed copul & PRD
             & ( ?R == OBJ | ?R == dobj ) )
     )
)
  ]
]

/*This rule applies if the antecedent is the subect of the main verb in the previous sentence.
Applies if there is only one node to pronominalize.
This rule should be completed by the Prep counterpart, and the block_dep_pronoun_gen rules in level 35 be changed accordingly.
WebNLG_test_triples5_es.conll Sent6, 170822a_known_input_multiple2.conll Sent251*/
excluded DSynt<=>SSynt anaphora_personal_human_direct : anaphora_resolution
[
  leftside = [
c:?Sent1 {
  c:dlex = "Sentence"
  c:?Root1 {
    c:?r-> c:?Ante {}
  }
  c:b-> c:?Sent2 {
    c:dlex = "Sentence"
    c:?Gov {
      c:?a-> c:?Dep {
        //( c:NE = "YES" & c:class = "Person" )
        // only pronominalize if there is no dependent, or if subtree is the same
         ( ¬c:?dep-> c:?Depl {} | ¬c:subtree_coref = "different" )
        ¬c:pos = "WDT"
        c:<-> c:?Ante {}
      }
    }
  }
}

¬language.id.iso.EL
¬project_info.project.pronominalize.no

( c:?Ante {c:NE = "YES" c:class = "Person" }
 | c:?Dep {c:NE = "YES" c:class = "Person" } )

//If the governor is a finite verb and the antecedent is just above, the dependent should be a relative pronoun.
¬(c:?Ante {c:ATTR-> c:?Gov {c:finiteness = "FIN"}})

// see anaphora possessive
¬ ( c:?Gov { ( c:pos = "NN" | c:finiteness = "GER" ) }  & c:?Dep { c:case = "GEN" } )

// ?Root1 is a root
¬c:?Grandma1 { c:?rel1-> c:?Root1 {} }

¬ c:?Dep { c:COORD-> c:?Conj2 {} }
¬ c:?Ante { c:COORD-> c:?Conj3 {} }
  ]
  mixed = [
//rc:?GovR {rc:<=> ?Gov rc:?R-> rc:?DepR {rc:<=>?Dep} }
//lexicon.miscellaneous.personal_pronouns.human.SG.MASC.?R.?ppro

//NOT IN LEXICON YET
//lexicon.?ppro.lemma.?lem
//lexicon.?ppro.pos.?pos
//lexicon.?ppro.spos.?spos
// doesn't work without the following condition:
//(?R == SBJ | ?R == OBJ)
  ]
  rightside = [
rc:?GovR {
  rc:<=> ?Gov
  rc:?R-> rc:?DepR {
    rc:<=> ?Dep
    ( ¬ ( rc:top = yes & rc:pos = "IN" ) | rc:slex = "of" )
    ¬rc:pronominalized = yes
    rc:slex = ?slex
    slex = "_PRO-HUM_"
    pos = "PP"
    spos = personal_pronoun
    //gender = ?Ante.gender
    //number = ?Ante.number
    pronominalized = yes
  }
}

( rc:?Root1R {
  rc:<=> ?Root1
  rc:?SBJ-> rc:?AnteR {
    rc:<=> ?Ante
  }
}
// & ( ?SBJ == SBJ | ?SBJ == subj )
  & ( ( ( ?SBJ == SBJ | ?SBJ == subj ) & ¬?R == PRD & ¬?R == copul & ¬?R == LGS & ¬?R == agent )
        | ( ( ?SBJ == PRD | ?SBJ == OBJ | ?SBJ == dobj | ?SBJ == copul )
        // removed copul & PRD
             & ( ?R == OBJ | ?R == dobj ) )
     )
)
  ]
]

/*If the governor is a verb and the antecedent is just above, the dependent should be a relative pronoun.
This rule applies if the subject of the preceding sentence points to the same node as ?Dep.
This rule should be completed by the Prep counterpart, and the block_dep_pronoun_gen rules in level 35 be changed accordingly.
WebNLG_test_triples5_es.conll Sent6, 170822a_known_input_multiple2.conll Sent251*/
excluded DSynt<=>SSynt EL_anaphora_personal_non_human_indirect : anaphora_resolution
[
  leftside = [
c:?Sent1 {
  c:dlex = "Sentence"
  c:?Root1 {
    c:?r-> c:?OtherNode {
      c:<-> c:?Ante {}
    }
  }
  c:b-> c:?Sent2 {
    c:dlex = "Sentence"
    c:?Gov {
      ¬c:definiteness = "INDEF"
      c:?a-> c:?Dep {
        //¬( c:NE = "YES" & c:class = "Person" )
        // only pronominalize if there is no dependent, or if subtree is the same
         ( ¬c:?dep-> c:?Depl {} | ¬c:subtree_coref = "different" )
        ¬c:pos = "WDT"
        c:<-> c:?Ante {}
      }
    }
  }
}

language.id.iso.EL
¬project_info.project.pronominalize.no

¬c:?Ante {c:NE = "YES" c:class = "Person" }
¬c:?Dep {c:NE = "YES" c:class = "Person" }

//If the governor is a finite verb and the antecedent is just above, the dependent should be a relative pronoun.
¬(c:?Ante {c:ATTR-> c:?Gov {c:finiteness = "FIN"}})

//if the relative pronoun is already inserted, it's not necessary the lemma transformation. TEST this with KRISTINA
¬?Dep.lemma == "that"

// ?Root1 is a root
¬c:?Grandma1 { c:?rel1-> c:?Root1 {} }

¬ c:?Dep { c:COORD-> c:?Conj2 {} }
¬ c:?Ante { c:COORD-> c:?Conj3 {} }
  ]
  mixed = [
//rc:?GovR {rc:<=> ?Gov rc:?R-> rc:?DepR {rc:<=>?Dep} }
//lexicon.miscellaneous.personal_pronouns.non_human.SG.MASC.?R.?ppro

//NOT IN LEXICON YET
//lexicon.?ppro.lemma.?lem
//lexicon.?ppro.pos.?pos
//lexicon.?ppro.spos.?spos
// doesn't work without the following condition:
//(?R == SBJ | ?R == OBJ)
  ]
  rightside = [
rc:?GovR {
  rc:<=> ?Gov
  rc:?R-> rc:?DepR {
    rc:<=> ?Dep
    ¬rc:pronominalized = yes
    rc:slex = ?slex
    slex = "_PRO_"
    pos = "PP"
    spos = personal_pronoun
    pronominalized = yes
  }
}

( rc:?Root1R {
  rc:<=> ?Root1
  rc:?SBJ-> rc:?OtherNodeR {
    rc:<=> ?OtherNode
  }
}
 & ( ?SBJ == subj | ?SBJ == dobj | ?SBJ == copul )
 & ( ?R == subj | ?R == dobj | ?R == copul )
)
  ]
]

/*When the antecedent and the node referring to it are in the same sentence.
MindSpaces 200126 sent.11*/
DSynt<=>SSynt anaphora_personal_non_human_indirect_sameSent : anaphora_resolution
[
  leftside = [
c:?Sent2 {
  c:dlex = "Sentence"
  c:?Root1 {
    c:*?r-> c:?OtherNode {
      c:<-> c:?Ante {}
    }
    c:*?s-> c:?Gov {
      ¬c:definiteness = "INDEF"
      c:?a-> c:?Dep {
        //¬( c:NE = "YES" & c:class = "Person" )
        // only pronominalize if there is no dependent, or if subtree is the same
         ( ¬c:?dep-> c:?Depl {} | ¬c:subtree_coref = "different" )
        ¬c:pos = "WDT"
        c:<-> c:?Ante {}
      }
    }
  }
}

¬project_info.project.pronominalize.no

¬ ?OtherNode.id == ?Dep.id

¬c:?Ante {c:NE = "YES" c:class = "Person" }
¬c:?Dep {c:NE = "YES" c:class = "Person" }

//If the governor is a finite verb and the antecedent is just above, the dependent should be a relative pronoun.
¬(c:?Ante {c:ATTR-> c:?Gov {c:finiteness = "FIN"}})

//if the relative pronoun is already inserted, it's not necessary the lemma transformation. TEST this with KRISTINA
¬?Dep.lemma == "that"

// ?Root1 is a root
¬c:?Grandma1 { c:?rel1-> c:?Root1 {} }

¬ c:?Dep { c:COORD-> c:?Conj2 {} }
¬ c:?Ante { c:COORD-> c:?Conj3 {} }
  ]
  mixed = [
//rc:?GovR {rc:<=> ?Gov rc:?R-> rc:?DepR {rc:<=>?Dep} }
//lexicon.miscellaneous.personal_pronouns.non_human.SG.MASC.?R.?ppro

//NOT IN LEXICON YET
//lexicon.?ppro.lemma.?lem
//lexicon.?ppro.pos.?pos
//lexicon.?ppro.spos.?spos
// doesn't work without the following condition:
//(?R == SBJ | ?R == OBJ)
  ]
  rightside = [
rc:?GovR {
  rc:<=> ?Gov
  rc:?R-> rc:?DepR {
    rc:<=> ?Dep
    rc:depth = ?swD
    ¬rc:pronominalized = yes
    ( rc:pos = "NN" | rc:pos = "NP" )
    rc:slex = ?slex
    slex = "_PRO_"
    pos = "PP"
    spos = personal_pronoun
    pronominalized = yes
  }
}

( rc:?Root1R {
  //rc:<=> ?Root1
  rc:?SBJ-> rc:?OtherNodeR {
    rc:<=> ?OtherNode
  }
}
// & ( ?SBJ == SBJ | ?SBJ == subj )
  & ( ( ( ?SBJ == SBJ | ?SBJ == subj ) & ¬?R == PRD & ¬?R == copul & ¬?R == LGS & ¬?R == agent )
        | ( ( ?SBJ == PRD | ?SBJ == OBJ | ?SBJ == dobj | ?SBJ == copul )
        // removed copul & PRD
             & ( ?R == OBJ | ?R == dobj ) )
     )
)
  ]
]

/*This rule applies if the antecedent is the subect of the main verb in the previous sentence.
Applies if there is only one node to pronominalize.
This rule should be completed by the Prep counterpart, and the block_dep_pronoun_gen rules in level 35 be changed accordingly.
WebNLG_test_triples5_es.conll Sent6, 170822a_known_input_multiple2.conll Sent251*/
excluded DSynt<=>SSynt EL_anaphora_personal_human_direct : anaphora_resolution
[
  leftside = [
c:?Sent1 {
  c:dlex = "Sentence"
  c:?Root1 {
    c:?r-> c:?Ante {}
  }
  c:b-> c:?Sent2 {
    c:dlex = "Sentence"
    c:?Gov {
      c:?a-> c:?Dep {
        //( c:NE = "YES" & c:class = "Person" )
        // only pronominalize if there is no dependent, or if subtree is the same
         ( ¬c:?dep-> c:?Depl {} | ¬c:subtree_coref = "different" )
        ¬c:pos = "WDT"
        c:<-> c:?Ante {}
      }
    }
  }
}

language.id.iso.EL
¬project_info.project.pronominalize.no

( c:?Ante {c:NE = "YES" c:class = "Person" }
 | c:?Dep {c:NE = "YES" c:class = "Person" } )

//If the governor is a finite verb and the antecedent is just above, the dependent should be a relative pronoun.
¬(c:?Ante {c:ATTR-> c:?Gov {c:finiteness = "FIN"}})

// see anaphora possessive
¬ ( c:?Gov { ( c:pos = "NN" | c:finiteness = "GER" ) }  & c:?Dep { c:case = "GEN" } )

// ?Root1 is a root
¬c:?Grandma1 { c:?rel1-> c:?Root1 {} }

¬ c:?Dep { c:COORD-> c:?Conj2 {} }
¬ c:?Ante { c:COORD-> c:?Conj3 {} }
  ]
  mixed = [
//rc:?GovR {rc:<=> ?Gov rc:?R-> rc:?DepR {rc:<=>?Dep} }
//lexicon.miscellaneous.personal_pronouns.human.SG.MASC.?R.?ppro

//NOT IN LEXICON YET
//lexicon.?ppro.lemma.?lem
//lexicon.?ppro.pos.?pos
//lexicon.?ppro.spos.?spos
// doesn't work without the following condition:
//(?R == SBJ | ?R == OBJ)
  ]
  rightside = [
rc:?GovR {
  rc:<=> ?Gov
  rc:?R-> rc:?DepR {
    rc:<=> ?Dep
    ¬rc:pronominalized = yes
    rc:slex = ?slex
    slex = "_PRO-HUM_"
    pos = "PP"
    spos = personal_pronoun
    //gender = ?Ante.gender
    //number = ?Ante.number
    pronominalized = yes
  }
}

( rc:?Root1R {
  rc:<=> ?Root1
  rc:?SBJ-> rc:?AnteR {
    rc:<=> ?Ante
  }
}
 & ( ?SBJ == subj | ?SBJ == dobj | ?SBJ == copul )
 & ( ?R == subj | ?R == dobj | ?R == copul )
)
  ]
]

/*When the anetcedent and the node referring to it are in the same sentence.
!!! NOT TESTED !!!*/
DSynt<=>SSynt anaphora_personal_human_direct_sameSent : anaphora_resolution
[
  leftside = [
c:?Sent2 {
  c:dlex = "Sentence"
  c:?Root1 {
    c:*?r-> c:?Ante {}
    c:*?s->  c:?Gov {
      c:?a-> c:?Dep {
        //( c:NE = "YES" & c:class = "Person" )
        // only pronominalize if there is no dependent, or if subtree is the same
         ( ¬c:?dep-> c:?Depl {} | ¬c:subtree_coref = "different" )
        ¬c:pos = "WDT"
        c:<-> c:?Ante {}
      }
    }
  }
}

¬project_info.project.pronominalize.no

( c:?Ante {c:NE = "YES" c:class = "Person" }
 | c:?Dep {c:NE = "YES" c:class = "Person" } )

//If the governor is a finite verb and the antecedent is just above, the dependent should be a relative pronoun.
¬(c:?Ante {c:ATTR-> c:?Gov {c:finiteness = "FIN"}})

// see anaphora possessive
¬ ( c:?Gov { ( c:pos = "NN" | c:finiteness = "GER" ) }  & c:?Dep { c:case = "GEN" } )

// ?Root1 is a root
¬c:?Grandma1 { c:?rel1-> c:?Root1 {} }

¬ c:?Dep { c:COORD-> c:?Conj2 {} }
¬ c:?Ante { c:COORD-> c:?Conj3 {} }
  ]
  mixed = [
//rc:?GovR {rc:<=> ?Gov rc:?R-> rc:?DepR {rc:<=>?Dep} }
//lexicon.miscellaneous.personal_pronouns.human.SG.MASC.?R.?ppro

//NOT IN LEXICON YET
//lexicon.?ppro.lemma.?lem
//lexicon.?ppro.pos.?pos
//lexicon.?ppro.spos.?spos
// doesn't work without the following condition:
//(?R == SBJ | ?R == OBJ)
  ]
  rightside = [
rc:?GovR {
  rc:<=> ?Gov
  rc:?R-> rc:?DepR {
    rc:<=> ?Dep
    rc:depth = ?swD
    ¬rc:pronominalized = yes
    ( rc:pos = "NN" | rc:pos = "NP" )
    rc:slex = ?slex
    slex = "_PRO-HUM_"
    pos = "PP"
    spos = personal_pronoun
    //gender = ?Ante.gender
    //number = ?Ante.number
    pronominalized = yes
  }
}

( rc:?Root1R {
  //rc:<=> ?Root1
  rc:?SBJ-> rc:?AnteR {
    rc:<=> ?Ante
  }
}
// & ( ?SBJ == SBJ | ?SBJ == subj )
  & ( ( ( ?SBJ == SBJ | ?SBJ == subj ) & ¬?R == PRD & ¬?R == copul & ¬?R == LGS & ¬?R == agent )
        | ( ( ?SBJ == PRD | ?SBJ == OBJ | ?SBJ == dobj | ?SBJ == copul )
        // removed copul & PRD
             & ( ?R == OBJ | ?R == dobj ) )
     )
)
  ]
]

/*This rule applies if the subject of the preceding sentence points to the same node as ?Dep.
This rule should be completed by the Prep counterpart, and the block_dep_pronoun_gen rules in level 35 be changed accordingly.
WebNLG_test_triples5_es.conll Sent6, 170822a_known_input_multiple2.conll Sent251*/
excluded DSynt<=>SSynt anaphora_personal_human_indirect : anaphora_resolution
[
  leftside = [
c:?Sent1 {
  c:dlex = "Sentence"
  c:?Root1 {
    c:?r-> c:?OtherNode {
      c:<-> c:?Ante {}
    }
  }
  c:b-> c:?Sent2 {
    c:dlex = "Sentence"
    c:?Gov {
      c:?a-> c:?Dep {
        //( c:NE = "YES" & c:class = "Person" )
        // only pronominalize if there is no dependent, or if subtree is the same
         ( ¬c:?dep-> c:?Depl {} | ¬c:subtree_coref = "different" )
        ¬c:pos = "WDT"
        c:<-> c:?Ante {}
      }
    }
  }
}

¬language.id.iso.EL
¬project_info.project.pronominalize.no

( c:?Ante {c:NE = "YES" c:class = "Person" }
 | c:?Dep {c:NE = "YES" c:class = "Person" } )

//If the governor is a finite verb and the antecedent is just above, the dependent should be a relative pronoun.
¬(c:?Ante {c:ATTR-> c:?Gov {c:finiteness = "FIN"}})

// see anaphora possessive
¬ ( c:?Gov { ( c:pos = "NN" | c:finiteness = "GER" ) }  & c:?Dep { c:case = "GEN" } )

// ?Root1 is a root
¬c:?Grandma1 { c:?rel1-> c:?Root1 {} }

¬ c:?Dep { c:COORD-> c:?Conj2 {} }
¬ c:?Ante { c:COORD-> c:?Conj3 {} }
  ]
  mixed = [
//rc:?GovR {rc:<=> ?Gov rc:?R-> rc:?DepR {rc:<=>?Dep} }
//lexicon.miscellaneous.personal_pronouns.human.SG.MASC.?R.?ppro

//NOT IN LEXICON YET
//lexicon.?ppro.lemma.?lem
//lexicon.?ppro.pos.?pos
//lexicon.?ppro.spos.?spos
// doesn't work without the following condition:
//(?R == SBJ | ?R == OBJ)
  ]
  rightside = [
rc:?GovR {
  rc:<=> ?Gov
  rc:?R-> rc:?DepR {
    rc:<=> ?Dep
    ( ¬ ( rc:top = yes & rc:pos = "IN" ) | rc:slex = "of" )
    ¬rc:pronominalized = yes
    rc:slex = ?slex
    slex = "_PRO-HUM_"
    pos = "PP"
    spos = personal_pronoun
    //gender = ?Ante.gender
    //number = ?Ante.number
    pronominalized = yes
  }
}

( rc:?Root1R {
  rc:<=> ?Root1
  rc:?SBJ-> rc:?OtherNodeR {
    rc:<=> ?OtherNode
  }
}
// & ( ?SBJ == SBJ | ?SBJ == subj )
  & ( ( ( ?SBJ == SBJ | ?SBJ == subj ) & ¬?R == PRD & ¬?R == copul & ¬?R == LGS & ¬?R == agent )
        | ( ( ?SBJ == PRD | ?SBJ == OBJ | ?SBJ == dobj | ?SBJ == copul )
        // removed copul & PRD
             & ( ?R == OBJ | ?R == dobj ) )

     )
)
  ]
]

/*This rule applies if the subject of the preceding sentence points to the same node as ?Dep.
This rule should be completed by the Prep counterpart, and the block_dep_pronoun_gen rules in level 35 be changed accordingly.
WebNLG_test_triples5_es.conll Sent6, 170822a_known_input_multiple2.conll Sent251*/
excluded DSynt<=>SSynt EL_anaphora_personal_human_indirect : anaphora_resolution
[
  leftside = [
c:?Sent1 {
  c:dlex = "Sentence"
  c:?Root1 {
    c:?r-> c:?OtherNode {
      c:<-> c:?Ante {}
    }
  }
  c:b-> c:?Sent2 {
    c:dlex = "Sentence"
    c:?Gov {
      c:?a-> c:?Dep {
        //( c:NE = "YES" & c:class = "Person" )
        // only pronominalize if there is no dependent, or if subtree is the same
         ( ¬c:?dep-> c:?Depl {} | ¬c:subtree_coref = "different" )
        ¬c:pos = "WDT"
        c:<-> c:?Ante {}
      }
    }
  }
}

language.id.iso.EL
¬project_info.project.pronominalize.no

( c:?Ante {c:NE = "YES" c:class = "Person" }
 | c:?Dep {c:NE = "YES" c:class = "Person" } )

//If the governor is a finite verb and the antecedent is just above, the dependent should be a relative pronoun.
¬(c:?Ante {c:ATTR-> c:?Gov {c:finiteness = "FIN"}})

// see anaphora possessive
¬ ( c:?Gov { ( c:pos = "NN" | c:finiteness = "GER" ) }  & c:?Dep { c:case = "GEN" } )

// ?Root1 is a root
¬c:?Grandma1 { c:?rel1-> c:?Root1 {} }

¬ c:?Dep { c:COORD-> c:?Conj2 {} }
¬ c:?Ante { c:COORD-> c:?Conj3 {} }
  ]
  mixed = [
//rc:?GovR {rc:<=> ?Gov rc:?R-> rc:?DepR {rc:<=>?Dep} }
//lexicon.miscellaneous.personal_pronouns.human.SG.MASC.?R.?ppro

//NOT IN LEXICON YET
//lexicon.?ppro.lemma.?lem
//lexicon.?ppro.pos.?pos
//lexicon.?ppro.spos.?spos
// doesn't work without the following condition:
//(?R == SBJ | ?R == OBJ)
  ]
  rightside = [
rc:?GovR {
  rc:<=> ?Gov
  rc:?R-> rc:?DepR {
    rc:<=> ?Dep
    ¬rc:pronominalized = yes
    rc:slex = ?slex
    slex = "_PRO-HUM_"
    pos = "PP"
    spos = personal_pronoun
    //gender = ?Ante.gender
    //number = ?Ante.number
    pronominalized = yes
  }
}

( rc:?Root1R {
  rc:<=> ?Root1
  rc:?SBJ-> rc:?OtherNodeR {
    rc:<=> ?OtherNode
  }
}
 & ( ?SBJ == subj | ?SBJ == dobj | ?SBJ == copul )
 & ( ?R == subj | ?R == dobj | ?R == copul )
)
  ]
]

/*When the anetcedent and the node referring to it are in the same sentence.
!!! NOT TESTED !!!*/
DSynt<=>SSynt anaphora_personal_human_indirect_sameSent : anaphora_resolution
[
  leftside = [
c:?Sent2 {
  c:dlex = "Sentence"
  c:?Root1 {
    c:*?r-> c:?OtherNode {
      c:<-> c:?Ante {}
    }
    c:*?s-> c:?Gov {
      c:?a-> c:?Dep {
        //( c:NE = "YES" & c:class = "Person" )
        // only pronominalize if there is no dependent, or if subtree is the same
         ( ¬c:?dep-> c:?Depl {} | ¬c:subtree_coref = "different" )
        ¬c:pos = "WDT"
        c:<-> c:?Ante {}
      }
    }
  }
}

¬project_info.project.pronominalize.no

¬ ?OtherNode.id == ?Dep.id

( c:?Ante {c:NE = "YES" c:class = "Person" }
 | c:?Dep {c:NE = "YES" c:class = "Person" } )

//If the governor is a finite verb and the antecedent is just above, the dependent should be a relative pronoun.
¬(c:?Ante {c:ATTR-> c:?Gov {c:finiteness = "FIN"}})

// see anaphora possessive
¬ ( c:?Gov { ( c:pos = "NN" | c:finiteness = "GER" ) }  & c:?Dep { c:case = "GEN" } )

// ?Root1 is a root
¬c:?Grandma1 { c:?rel1-> c:?Root1 {} }

¬ c:?Dep { c:COORD-> c:?Conj2 {} }
¬ c:?Ante { c:COORD-> c:?Conj3 {} }
  ]
  mixed = [
//rc:?GovR {rc:<=> ?Gov rc:?R-> rc:?DepR {rc:<=>?Dep} }
//lexicon.miscellaneous.personal_pronouns.human.SG.MASC.?R.?ppro

//NOT IN LEXICON YET
//lexicon.?ppro.lemma.?lem
//lexicon.?ppro.pos.?pos
//lexicon.?ppro.spos.?spos
// doesn't work without the following condition:
//(?R == SBJ | ?R == OBJ)
  ]
  rightside = [
rc:?GovR {
  rc:<=> ?Gov
  rc:?R-> rc:?DepR {
    rc:<=> ?Dep
    rc:depth = ?swD
    ¬rc:pronominalized = yes
    ( rc:pos = "NN" | rc:pos = "NP" )
    rc:slex = ?slex
    slex = "_PRO-HUM_"
    pos = "PP"
    spos = personal_pronoun
    //gender = ?Ante.gender
    //number = ?Ante.number
    pronominalized = yes
  }
}

( rc:?Root1R {
  //rc:<=> ?Root1
  rc:?SBJ-> rc:?OtherNodeR {
    rc:<=> ?OtherNode
  }
}
// & ( ?SBJ == SBJ | ?SBJ == subj )
  & ( ( ( ?SBJ == SBJ | ?SBJ == subj ) & ¬?R == PRD & ¬?R == copul & ¬?R == LGS & ¬?R == agent )
        | ( ( ?SBJ == PRD | ?SBJ == OBJ | ?SBJ == dobj | ?SBJ == copul )
        // removed copul & PRD
             & ( ?R == OBJ | ?R == dobj ) )
     )
)
  ]
]

excluded DSynt<=>SSynt anaphora_sameLoc : anaphora_resolution
[
  leftside = [
c:?S1l {
  c:?Gov1 {
    c:?r1-> c:?Dep1 {}
  }
  c:b-> c:?S2l {
    c:?Gov2 {
      c:?r2-> c:?Dep2 {
        SameLocAsPrevious = "YES"
        //Doesn't always work to pronominalize with a coord
        ¬c:COORD-> c:?Conj {}
      }
    }
  }
}

¬project_info.project.pronominalize.no

( ?r2 == ATTR | ?r2 == II )

// The precendent Locative is on the root, and can be pronominalized with reduced risk of ambiguitiy, or there's only one Location in S1l
// this rule won't work until we have all locations marked with "class=Location" so far; simplified as on the following lines for now.
// ( ¬c:?Gov3 { c:?r3-> c:?Gov1 {} } | ¬ ( c:?S1l { c:?Dep7 { c:class = "Location" } } & ¬?Dep7.id == ?Dep1.id ) )
( ¬ c:?Gov3 { c:?r3-> c:?Gov1 {} } | ( c:?Gov4 { c:?r4-> c:?Gov1 { c:pos ="IN" } } & ?r1 == II & ¬c:?Gov5 { c:?r5-> c:?Gov4 {} } ) )
¬ ( c:?S1l { c:?Dep7 { c:class = "Location" } } & ¬?Dep7.id == ?Dep1.id )

// the first occurrence is in the previous sentence or both locs point to the same
( c:?Dep2 { c:<-> c:?Dep1 {} } | c:?Dep2 { c:?r5-> c:?Dep2Bis { c:<-> c:?Dep1 {} } }
 | ( ( c:?Dep2 { c:<-> c:?Dep0 {} }  | c:?Dep2 { c:?r6-> c:?Dep2Ter { c:<-> c:?Dep0 {} } } ) & c:?Dep1 { c:<-> c:?Dep0 {} } ) )

// pronominalize if the sentences are consecutive or if there is no other location in between the two sentences
// this rule won't work until we have all locations marked with "class=Location" so far; removed star on "b" above for now.
//( c:?S1l { c:b-> c:?S2l {} } | ¬ c:?S1l { c:*b-> c:?S4l { c:?X4l { c:class = "Location" } c:*b-> c:?S2l {} } } )
  ]
  mixed = [
rc:?GovR {rc:<=> ?Gov2 rc:?R-> rc:?DepR {rc:<=>?Dep2} }
lexicon.miscellaneous.locative_pronoun.?R.?ppro
  ]
  rightside = [
rc:?GovR {
  rc:<=> ?Gov2
  rc:?R-> rc:?DepR {
    rc:<=> ?Dep2
    ¬rc:pronominalizedLoc = yes
    rc:slex = ?slex
    slex = ?ppro
    pos = "RB"
    spos = adverb
    pronominalized = yes
    pronominalizedLoc = yes
  }
}
  ]
]

excluded DSynt<=>SSynt anaphora_sameTime : anaphora_resolution
[
  leftside = [
c:?Gov {
  c:ATTR-> c:?Dep {
    SameTimeAsPrevious = "YES"
    //Doesn't always work to pronominalize witha coord
    ¬c:COORD-> c:?Conj {}
  }
}

¬project_info.project.pronominalize.no
  ]
  mixed = [
rc:?GovR {rc:<=> ?Gov rc:?R-> rc:?DepR {rc:<=>?Dep} }
lexicon.miscellaneous.time_pronoun.?R.?ppro
  ]
  rightside = [
rc:?GovR {
  rc:<=> ?Gov
  rc:?R-> rc:?DepR {
    rc:<=> ?Dep
    ¬rc:pronominalized = yes
    rc:slex = ?slex
    slex = ?ppro
    pos = "RB"
    spos = adverb
    pronominalized = yes
  }
}
  ]
]

excluded DSynt<=>SSynt anaphora_sameLocTime_block : anaphora_resolution
[
  leftside = [
c:?Gov {
  c:?r-> c:?Dep {
    ( c:SameLocAsPrevious = "YES" | c:SameTimeAsPrevious = "YES" )
    c:II-> c:?Xl {
      ( SameLocAsPrevious = "YES" | SameTimeAsPrevious = "YES" )
    }
  }
}

¬project_info.project.pronominalize.no

// generally adverbials or complements of copulas
(?r == ATTR | ?r == II )
  ]
  mixed = [

  ]
  rightside = [
rc:?Depr {
  rc:<=> ?Dep
  rc:pronominalized = yes
}

rc:?Xr {
  rc:<=> ?Xl
  block = "yes"
}
  ]
]

/*The depth rules will work if enough relations are created before the 3rd cluster, which is usually the case.
It weirdly done, and probably can be done better. The idea is to get at the leaves when the whole tree is built, not before,
 which is why we start from the root (the ssynt tree is built from the root).*/
DSynt<=>SSynt depth_root : weight
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
DSynt<=>SSynt depth_down : weight
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
DSynt<=>SSynt weight_up_leaf_1 : weight
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
DSynt<=>SSynt weight_up_1 : weight
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:weight = ?ow
  straight_weight = # ?w + 1 #
  rc:?r-> rc:?Yr {
    rc:straight_weight = ?w
  }
}
  ]
]

/*Some units have their own weight in the lexicon, in this case we sum up this weight instead of 1.*/
DSynt<=>SSynt weight_up_lexicon : weight
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:weight = ?ow
  straight_weight = # ?w + ?ow #
  rc:?r-> rc:?Yr {
    rc:straight_weight = ?w
  }
}
  ]
]

DSynt<=>SSynt EN_mark_add_of_gerund : markers
[
  leftside = [
c:?Xl {
  c:finiteness = "GER"
  real_pos = "NN"
  c:II-> c:?Yl {
    ( c:pos = "NN" | c:pos = "NP" )
  }
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  rc:slex = ?s
  add_of = yes
}
  ]
]

DSynt<=>SSynt EN_mark_add_to_JJ_VB : markers
[
  leftside = [
c:?Xl {
  ( c:pos = "JJ" | c:pos = "RB" )
  ¬c:dlex = "called"
  ¬c:dlex = "above"
  ¬c:dlex = "near"
  c:?r-> c:?Yl {
    ( c:pos = "NN" | c:pos = "NP" | c:pos = "VB" )
  }
}

¬?r == COORD

¬ ( ?r == APPEND & c:?Yl { c:type = "parenthetical" } )

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  rc:slex = ?s
  rc:pos = ?pos
  add_to = yes
}

// a preposition has not already been introduced
¬?pos == "IN"

// there isn't a preposition above yet
¬rc:?NodeR {
  rc:pos = "IN"
  rc:?Rel-> rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

DSynt<=>SSynt EN_mark_add_INF_JJ_VB : markers
[
  leftside = [
c:?Yl {
  c:pos = "VB"
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  rc:add_to = yes
  finiteness = "INF"
}
  ]
]

DSynt<=>SSynt mark_two_relatives : markers
[
  leftside = [
c:?Xl {
  ( c:pos = "NN" | c:pos = "NP" )
  c:ATTR-> c:?Yl {
    c:pos = "VB"
    c:finiteness = "FIN"
    c:id = ?idY
    }
  c:ATTR-> c:?Zl {
    c:pos = "VB"
    c:finiteness = "FIN"
    c:id = ?idZ
  }
}

?idY < ?idZ

// only apply to pairs of relative clauses with the closest IDs
¬ ( c:?Xl { c:ATTR-> c:?K1l { c:pos = "VB" c:finiteness = "FIN" c:id = ?id1 } }
    & ?id1 > ?idY & ?id1 < ?idZ )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bottom=yes
  ¬rc:middle=yes
  coord_anchor = ?idZ
}

rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bottom=yes
  ¬rc:middle=yes
  introduce_conj= "coordination"
}
  ]
]

DSynt<=>SSynt mark_relative_participial : markers
[
  leftside = [
c:?Xl {
  ( c:pos = "NN" | c:pos = "NP" )
  c:ATTR-> c:?Yl {
    c:pos = "VB"
    c:finiteness = "FIN"
    c:id = ?idY
    }
  c:ATTR-> c:?Zl {
    c:pos = "VB"
    ( c:finiteness = "PART" | c:finiteness = "GER" )
    // The paticiple has dependents, so will probably be linearized after the noun
    c:?r-> c:?Dep {}
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bottom=yes
  ¬rc:middle=yes
  coord_anchor = ?idY
}

rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bottom=yes
  ¬rc:middle=yes
  introduce_conj= "coordination"
}
  ]
]

/*A verb that has two arguments in the lexicon but has no second argument is not good, Add an extra "something" node.
This rule sorts of over-applicates; restrict it to root verbs?
EDIT: it gives a lot of weird sentences; just filter verbs that have nothing else than their arg 1.
DISABLED FOR SEMEVAL!!!!*/
excluded DSynt<=>SSynt mark_block_no_ArgII : markers
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:lex = ?lex
  c:I-> c:?Subjl {}
  ¬c:?s-> c:?Kl {}
  //¬c:II-> c:?Yl {}
  //¬c:III-> c:?Zl {}
  ¬c:voice = "PASS"
}

lexicon.?lex.gp.II

// ?x is the root
¬c:?Govl { c:?r-> c:?Xl {} }

// if the verb below is finite,  don't percolate the "block"
// this condition is a little simplistic; we should check if the verb group look well built
¬ ( c:?Subjl { c:finiteness = "FIN" } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //¬rc:top=yes
  //¬rc:middle=yes
  //add_deprel = OBJ
  //add_dep = "something_NN_01"
  block = "yes"
  block_no_argII = applied
}
  ]
]

/*see PTB_train_8092*/
DSynt<=>SSynt mark_block_no_ArgII_Arg1Fin : markers
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:lex = ?lex
  c:I-> c:?Subjl {}
  ¬c:?s-> c:?Kl {}
  //¬c:II-> c:?Yl {}
  //¬c:III-> c:?Zl {}
  ¬c:voice = "PASS"
}

lexicon.?lex.gp.II

// ?x is the root
¬c:?Govl { c:?r-> c:?Xl {} }

// if the verb below is finite,  don't percolate the "block"
// this condition is a little simplistic; we should check if the verb group look well built
( c:?Subjl { c:finiteness = "FIN" } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //¬rc:top=yes
  //¬rc:middle=yes
  //add_deprel = OBJ
  //add_dep = "something_NN_01"
  block = "yes"
  percolate = "no"
  block_no_argII_Arg1 = applied
}
  ]
]

/*keep adding node names*/
DSynt<=>SSynt mark_block_garbage : markers
[
  leftside = [
c:?Xl {
  ( c:dlex = "[" | c:dlex = "]"  | ( c:dlex = "“" & ¬c:?r-> c:?Yl {} ) )
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  block = "yes"
  percolate = "no"
  block_garbage = applied
}
  ]
]

DSynt<=>SSynt mark_block_and : markers
[
  leftside = [
c:?Xl {
  c:pos = "CC"
  ¬c:?r-> c:?Yl {}
}

¬ ( ?Xl.type == "parenthetical" & ¬c:?GranGov { c:?r1-> c:?Gov { c:?r2-> c:?Xl {} } } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  block = "yes"
  block_and = applied
}
  ]
]

DSynt<=>SSynt mark_block_and2 : markers
[
  leftside = [
c:?Xl {
  c:pos = "CC"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  block = "yes"
  block_and2 = applied
  rc:CONJ-> rc:?Yr {
    rc:block = "yes"
  }
  ¬rc:?r-> rc:?Zr {} 
}
  ]
]

DSynt<=>SSynt EN_mark_block_also : markers
[
  leftside = [
c:?Xl {
  c:dlex = "also"
  c:COORD-> c:?Andl {
    c:II-> c:?Yl {
      c:dlex = "also"
      ¬c:?r-> c:?Depl {}
    }
  }
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  block = "yes"
  block_also = applied
}

rc:?Ar {
  rc:<=> ?Andl
  block = "yes"
  block_also = applied
}

rc:?Xr {
  rc:<=> ?Xl
  slex = "alternatively"
}
  ]
]

DSynt<=>SSynt ES_mark_block_also : markers
[
  leftside = [
c:?Xl {
  c:dlex = "también"
  c:COORD-> c:?Andl {
    c:II-> c:?Yl {
      c:dlex = "también"
      ¬c:?r-> c:?Depl {}
    }
  }
}

language.id.iso.ES
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  block = "yes"
  block_also = applied
}

rc:?Ar {
  rc:<=> ?Andl
  block = "yes"
  block_also = applied
}
  ]
]

DSynt<=>SSynt mark_block_sameNPCoordinated : markers
[
  leftside = [
c:?Xl {
  c:pos = "NP"
  ¬c:?r2-> c:?Dep2l {}
  c:COORD-> c:?Andl {
    c:II-> c:?Yl {
      c:pos = "NP"
      ¬c:COORD-> c:?OtherAnd {}
      ¬c:?r1-> c:?Dep1l {}
    }
  }
}

?Xl.dlex == ?Yl.dlex
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  block = "yes"
}

rc:?Ar {
  rc:<=> ?Andl
  block = "yes"
}
  ]
]

DSynt<=>SSynt mark_block_coord_subject : markers
[
  leftside = [
c:?V1l {
  c:?r1-> c:?S1l {
    c:<-> c:?Coref {}
  }
  c:COORD-> c:?Andl {
    c:II-> c:?V2l {
      c:?r2-> c:?S2l {
        c:<-> c:?Coref {}
      }
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?V1r {
  rc:<=> ?V1l
  rc:SBJ-> rc:?S1r {
    rc:<=> ?S1l
  }
}

rc:?V2r {
  rc:<=> ?V2l
  rc:SBJ-> rc:?S2r {
    rc:<=> ?S2l
    block = "yes"
    block_coord_subj = applied
  }
}
  ]
]

DSynt<=>SSynt mark_block_relative : markers
[
  leftside = [
c:?Xl {
  c:ATTR-> c:?Yl {
    c:pos = "VB"
    c:?r1-> c:?RelPro {
      c:pos = "WDT"
    }
    c:?r2-> c:?Nl {
      c:<-> c:?Xl {}
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Nr {
  rc:<=> ?Nl
  block = "yes"
  block_relative = applied
}
  ]
]

/*If a determiner has been introduced on a word that is pronominalized, remove it.*/
DSynt<=>SSynt EN_mark_block_det_pronoun : markers
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
  ( rc:pronominalized = yes | rc:relativized = yes )
  rc:NMOD-> rc:?DetR {
    rc:pos = "DT"
    block = "yes"
    block_det_pronoun = applied
  }
}
  ]
]

/*If a determiner has been introduced on a word that is pronominalized, remove it.*/
DSynt<=>SSynt EN_mark_block_det_poss : markers
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
  rc:NMOD-> rc:?DetR1 {
   ( ( rc:pos = "DT" & rc:pronominalized = yes )
   // fill up list some day
   | rc:slex = "many" | rc:lex = "most_DT_01" | rc:slex = "few" | rc:slex = "whose"
   | ( rc:pos = "NP" rc:SUFFIX-> rc:?Gen { rc:spos = "genitive" } )
 )
  }
  rc:NMOD-> rc:?DetR2 {
    rc:pos = "DT"
    block = "yes"
    block_det_poss = applied
  }
}
  ]
]

DSynt<=>SSynt EN_mark_block_of_whose : markers
[
  leftside = [
c:?Xl {
  c:?r-> c:?Yl {}
}

// restrict to arguments?
( ?r == I | ?r == II | ?r == III | ?r == IV )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:NMOD-> rc:?Of {
    rc:slex = "of"
    ¬rc:block = "yes"
    block = "yes"
    percolate = "no"
    rc:PMOD-> rc:?Yr {
      rc:slex = "whose"
    }
  }
  rc:NMOD-> rc:?The {
    rc:slex = "the"
    ¬rc:block = "yes"
    block = "yes"
  }
}
  ]
]

excluded DSynt<=>SSynt mark_elide_verb_coord : markers
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:COORD-> c:?Andl {
    c:II-> c:?Yl {
      c:pos = "VB"
    }
  }
}

?Xl.dlex == ?Yl.dlex
?Xl.finiteness == ?Yl.finiteness
( ?Xl.mood == ?Yl.mood
 | ( c:?Xl { ¬c:mood = ?mX } & c:?Yl { ¬c:mood = ?mY } ) )
( ?Xl.tem_constituency == ?Yl.tem_constituency
 | ( c:?Xl { ¬c:tem_constituency = ?tcX } & c:?Yl { ¬c:tem_constituency = ?tcY } ) )
( ?Xl.tense == ?Yl.tense
  | ( c:?Xl { ¬c:tense = ?tX } & c:?Yl { ¬c:tense = ?tY } ) )
( ?Xl.voice == ?Yl.voice  | ( c:?Xl { ¬c:voice = ?vX } & c:?Yl { ¬c:voice = ?vY } ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  elide = "yes"
}
  ]
]

DSynt<=>SSynt mark_block_percolate : markers
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:block = "yes"
  ¬rc:percolate = "no"
  rc:?r-> rc:?Yr {
    ¬rc:block = "yes"
    block = "yes"
  }
}

//some preps are introduced twice above a node, one of them is not blocked
¬rc:?NodeR {
  ¬rc:block = "yes"
  rc:?s-> rc:?Yr {}
}
  ]
]

/*to percolate below newly introduced nodes*/
DSynt<=>SSynt mark_block_percolate2 : markers
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:block = "yes"
}

rc:?Yr {
  rc:block = "yes"
  ¬rc:percolate = "no"
  ( rc:slex = "by" | rc:slex = "for" )
  ¬rc:id = ?i
  rc:?r-> rc:?Xr {
    block = "yes"
  }
}

//some preps are introduced twice above a node, one of them is not blocked
¬rc:?NodeR {
  ¬rc:block = "yes"
  rc:?s-> rc:?Xr {}
}
  ]
]

/*This rule blocks in general elements that point to the same node as other in the LS, based on ID.
Some Relations are not transferred during this transduction (see ATTR rules).
So we can't base this rule on LS only.*/
DSynt<=>SSynt mark_duplicate_node_LS : markers
[
  leftside = [
c:?X1l {
  c:id = ?i1
  c:?r1-> c:?Yl {}
}
c:?X2l {
  c:id = ?i2
  c:?r2-> c:?Yl {}
}

( ?i1 >?i2 | ( ?i1 == ?i2 & ?X1l.gov_id >?X2l.gov_id ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?X2r {
  rc:<=> ?X2l
  block = "yes"
  percolate = "no"
  rc:?R2-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:block = "yes"
  }
}

rc:?X1r {
  rc:<=> ?X1l
  rc:?R1-> rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

/*Block prepositions if more than one has been introduced by the IN rules (transfer_nodes).
These prepositions have no ID, so we use teh random feature to choose which to block.*/
DSynt<=>SSynt mark_duplicate_prep : markers
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?X1r {
  rc:<=> ?Xl
  rc:random = ?rand1
  rc:?r1-> rc:?Y1r {}
}
rc:?X2r {
  rc:<=> ?Xl
  rc:random = ?rand2
  block = "yes"
  percolate = "no"
  rc:?r2-> rc:?Y2r {}
}

?rand1 < ?rand2
  ]
]

DSynt<=>SSynt mark_duplicate_particle : markers
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:PRT-> rc:?Y1r {
    rc:random = ?rand1
  }
  rc:PRT-> rc:?Y2r {
    rc:random = ?rand2
    block = "yes"}
}

?rand1 < ?rand2
  ]
]

/*Rule for Spanish and French so far...*/
DSynt<=>SSynt mark_duplicate_subj : markers
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:I-> c:?Subj1l {
    c:pos = "PP"
  }
  c:I-> c:?Subj2l {
    ¬c:pos = "PP"
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Subj1R {
  rc:<=> ?Subj1l
  block = "yes"
}
  ]
]

/*To use it to reattach stranded nodes during postprocesssing.*/
DSynt<=>SSynt mark_gov_id0 : markers
[
  leftside = [
c:?Xl {
  c:id0 = ?id0
  c:?r-> c:?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  gov_id0 = ?id0
}
  ]
]

/*To use it to reattach stranded nodes during postprocesssing.*/
DSynt<=>SSynt mark_gov_id : markers
[
  leftside = [
c:?Xl {
  c:id = ?id
  c:?r-> c:?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  gov_id = ?id
}
  ]
]

/*Assign a random number to nodes in ordert to distinguish identical nodes later on.*/
DSynt<=>SSynt mark_random : markers
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  random_id = #randInt()#
}
  ]
]

DSynt<=>SSynt mark_replace_conjunction : markers
[
  leftside = [
c:?X1l {
  c:COORD-> c:?And1l {
    c:II-> c:?X2l {
      c:COORD-> c:?And2l {}
    }
  }
}

?And1l.dlex == ?And2l.dlex
  ]
  mixed = [

  ]
  rightside = [
rc:?And1r {
  rc:<=> ?And1l
  comma_substitute = "yes"
}
  ]
]

DSynt<=>SSynt EN_mark_change_definiteness : markers
[
  leftside = [
c:?Vl {
  c:type = "support_verb_noIN"
  c:II-> c:?Xl {
    ¬c:lemma = "ethnic_group"
    ¬c:lemma = "variation"
    c:definiteness = "INDEF"
    c:?r-> c:?Yl {
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:NMOD-> rc:?Det {
    rc:slex = "a"
    slex = "the"
  }
  rc:NMOD-> rc:?IN {
    rc:pos = "IN"
    rc:PMOD-> rc:?relPro {
        rc:spos = relative_pronoun
    }
  }
}
  ]
]

/*To cover an unfortunate duplication in the beer cases 190521 #13 (could happen anywhere)*/
DSynt<=>SSynt mark_cancel_block : markers
[
  leftside = [
c:?Top {
  c:?Conj1a {
    c:pos = "CC"
    c:?r1-> c:?Be1 {
      c:?r2-> c:?Conj1b {
        c:pos = "CC"
        c:?r3-> c:?Bottom {}
      }
    }
  }
  c:?Conj2a {
    c:pos = "CC"
    c:?r4-> c:?Be2 {
      c:?r5-> c:?Conj2b {
        c:pos = "CC"
        c:?r6-> c:?Bottom {}
      }
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Conj1ar {
  rc:<=> ?Conj1a
  rc:block = "yes"
}

rc:?Be1r {
  rc:<=> ?Be1
  rc:block = "yes"
}

rc:?Conj1br {
  rc:<=> ?Conj1b
  ¬rc:block = "yes"
  block = "yes"
  percolate = ?Conj2br.percolate
}

rc:?Conj2ar {
  rc:<=> ?Conj2a
  ¬rc:block = "yes"
}

rc:?Be2r {
  rc:<=> ?Be2
  ¬rc:block = "yes"
}

rc:?Conj2br {
  rc:<=> ?Conj2b
  rc:block = "yes"
  block = "no"
}
  ]
]

/*To cover an unfortunate duplication in the beer cases 190521 #13 (could happen anywhere)*/
DSynt<=>SSynt mark_cancel_replace_conjunction : markers
[
  leftside = [
c:?X1l {
  c:COORD-> c:?And1l {
    c:II-> c:?X2l {
      c:COORD-> c:?And2l {}
    }
  }
}

?And1l.dlex == ?And2l.dlex
  ]
  mixed = [
// do not cancel if there's another non-blocked conjunction below
¬ ( c:?X2l { c:COORD-> c:?And3l {} } & ?And3l.dlex == ?And1l.dlex & rc:?And3r { rc:<=> ?And3l ¬rc:block = "yes" } )
  ]
  rightside = [
rc:?And1r {
  rc:<=> ?And1l
  rc:comma_substitute = "yes"
  comma_substitute = "no"
}

rc:?And2r {
  rc:<=> ?And2l
  rc:block = "yes"
}
  ]
]

excluded DSynt<=>SSynt PATCH_MS_block_that_sent2 : markers
[
  leftside = [
c:?Xl {
  c:lex = "release_VB_01"
  c:I-> c:?Vl {
    c:lex = "employers_group_NN_01"
  }
  c:II-> c:?Yl {
    c:lex = "support_VB_01"
    c:I-> c:?Subjl {
      c:lex = "opinion_poll_NN_01"
    }
    c:II-> c:?Objl {
      c:lex = "action_NN_01"
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Thatr {
  rc:<=> ?Yl
  block = "yes"
  percolate = "no"
  rc:SUB-> rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

excluded DSynt<=>SSynt PATCH_MS_block_to_sent2 : markers
[
  leftside = [
c:?Xl {
  c:lex = "release_VB_01"
  c:I-> c:?Vl {
    c:lex = "employers_group_NN_01"
  }
  c:II-> c:?Yl {
    c:lex = "support_VB_01"
    c:I-> c:?Subjl {
      c:lex = "opinion_poll_NN_01"
    }
    c:II-> c:?Objl {
      c:lex = "action_NN_01"
      c:ATTR-> c:?Al {
        c:lex = "counter_VB_01"
        c:II-> c:?Bl {
          c:lex = "climate_change_NN_01"
        }
      }
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Thatr {
  rc:<=> ?Bl
  rc:slex = "to"
  block = "yes"
  percolate = "no"
  rc:PMOD-> rc:?Br {
    rc:<=> ?Bl
  }
}
  ]
]

excluded DSynt<=>SSynt PATCH_MS_block_climateChange_sent3 : markers
[
  leftside = [
c:?Al {
  c:lex = "climate_change_NN_01"
   c:ATTR-> c:?Bl {
     c:lex = "push_NN_01"
     c:ATTR-> c:?Cl {
       c:lex = "for_IN_01"
       c:COORD-> c:?Dl {
         c:lex = "and_CC_01"
         c:II-> c:?El {
           c:lex = "for_IN_01"
           c:II-> c:?Fl {
             c:lex = "back_VB_01"
          }
        }
      }
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Dr {
  rc:<=> ?Dl
  block = "yes"
}
  ]
]

excluded DSynt<=>SSynt PATCH_MS_block_sent4 : markers
[
  leftside = [
c:?Al {
  c:lex = "add_VB_01"
   c:II-> c:?Bl {
     c:lex = "subsidise_VB_01"
     c:APPEND-> c:?Cl {
       c:lex = "_SYM_01"
     }
     c:I-> c:?Dl {
       c:lex = "government_NN_01"
    }
     c:II-> c:?El {
       c:lex = "plant_NN_01"
    }
  }
}

¬c:?Xl { c:?r-> c:?Al {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?Ar {
  rc:<=> ?Al
  block = "yes"
}
  ]
]

excluded DSynt<=>SSynt PATCH_MS_block_sent5 : markers
[
  leftside = [
c:?Al {
  c:lex = "take_VB_01"
  c:I-> c:?Cl {
    c:lex = "promoter_NN_01"
  }
  c:III-> c:?Dl {
    c:lex = "investment_decision_NN_01"
  }
  c:COORD-> c:?El {
    c:lex = "but_CC_01"
    c:II-> c:?Bl {
      c:lex = "believe_VB_01"
    }
  }
}

¬c:?Xl { c:?r-> c:?Al {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?Ar {
  rc:<=> ?Al
  block = "yes"
}

rc:?Er {
  rc:<=> ?El
  percolate = "no"
}
  ]
]

excluded DSynt<=>SSynt PATCH_MS_block_sent7 : markers
[
  leftside = [
c:?Al {
  c:lex = "say_VB_01"
  c:II-> c:?Xl {
    c:lex = "back_VB_01"
    c:I-> c:?Cl {
      c:lex = "iod"
    }
    c:ATTR-> c:?Dl {
      c:lex = "nuclear_JJ_01"
    }
    c:COORD-> c:?El {
      c:lex = "but_CC_01"
      c:II-> c:?Bl {
        c:lex = "be_VB_01"
      }
    }
    c:COORD-> c:?Fl {
      c:lex = "but_CC_01"
      c:II-> c:?Gl {
        c:lex = "have_VB_01"
      }
    }
  }
}

¬c:?Nl { c:?r-> c:?Al {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?Fr {
  rc:<=> ?Fl
  block = "yes"
}

rc:?Er {
  rc:<=> ?El
  block = "yes"
}
  ]
]

excluded DSynt<=>SSynt PATCH_MS_block_sent8 : markers
[
  leftside = [
c:?Al {
  c:lex = "show_VB_01"
  c:I-> c:?Xl {
    c:lex = "survey_NN_01"
    c:ATTR-> c:?Cl {
      c:lex = "iod"
    }
  }
  c:II-> c:?Fl {
    c:lex = "split_VB_01"
    c:II-> c:?Gl {
      c:lex = "member_NN_01"
    }
    c:ATTR-> c:?Hl {
      c:lex = "with_IN_01"
      c:II-> c:?Il {
        c:lex = "%_NN_01"
      }
    }
  }
}

¬c:?Nl { c:?r-> c:?Al {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?Hr {
  rc:<=> ?Hl
  block = "yes"
}
  ]
]

excluded DSynt<=>SSynt PATCH_MS_block_sent9 : markers
[
  leftside = [
c:?Al {
  c:lex = "attack_VB_01"
  c:I-> c:?Cl {
    c:lex = "lewis"
  }
  c:ATTR-> c:?Dl {
    c:lex = "uk_IN_01"
    c:II-> c:?Fl {
      c:lex = "need_NN_01"
    }
  }
  c:ATTR-> c:?Bl {
    c:lex = "for_IN_01"
    c:II-> c:?El {
      c:lex = "focus_VB_01"
    }
  }
}

¬c:?Xl { c:?r-> c:?Al {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?Dr {
  rc:<=> ?Dl
  block = "yes"
}

rc:?Br {
  rc:<=> ?Bl
  block = "yes"
}
  ]
]

DSynt<=>SSynt CA_transfer_node_IN_governed : CA_transfer_node_multi_corresp
[
  leftside = [
c:?Gov {
  c:lex=?lex
  c:?r-> ?Xl {
    ¬voice="PASS"
    ( ¬c:tem_constituency=?tc | c:tem_constituency = "IMP" )
    ¬modality=?m
  }
}


// Generalize the "IN" part to all languages? Testing now on catalan.
// Problem is: it may be an overkill. Maybe handle complex prepositions differently, with a dedicated rule or with a "cheat" lemma in the lexicon
// (e.g. "next to" instead of "next" subcategorizing "to")
( ?Gov.pos == "IN" | ?Xl.pos == "NN" | ?Xl.pos == "NP"  | ?Xl.pos == "VB" | ?Xl.pos == "CD" | ?Xl.pos == "JJ" )

// In abstractive summarization, sometimes we keep the prepositions
¬ ( ?Xl { c:subcat_prep = ?spx c:GovLex = ?glx } & ?glx == ?lex )

lexicon.?lex.gp.?r.prep.?prep
¬(?r == I & ?prep == "por" & ¬?Gov.voice == "PASS")

// II will be mapped to a subject
¬(?r == II & ?Gov.voice == "PASS")

language.id.iso.CA
  ]
  mixed = [

  ]
  rightside = [
?PrepR {
  <=> ?Xl
  slex = ?prep
  //  added_prep = ?prep
//  lemma = ?prep
  pos = "IN"
  spos = preposition
//  id=?Xl.id
  top = yes
  prepos-> ?Xr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma=?Xl.lemma
    pos=?Xl.pos
//    spos=?Xl.spos
//    id=?Xl.id
//    number=?Xl.number
    bottom = yes
  }
}
  ]
]

DSynt<=>SSynt CA_transfer_node_IN_governed_inStr : CA_transfer_node_multi_corresp
[
  leftside = [
c:?Gov {
  c:lex=?lex
  c:?r-> ?Xl {
    ¬voice="PASS"
    ( ¬c:tem_constituency=?tc | c:tem_constituency = "IMP" )
    ¬modality=?m
    ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" | c:pos = "RB" | c:pos = "JJ" )
    subcat_prep = ?spx
    GovLex = ?glx
  }
}

language.id.iso.CA

// In abstractive summarization, sometimes we keep the prepositions
//( ?glx == ?lex | ( c:?Grandma { c:lex = ?lexGrandma c:?rg1-> c:?Gov {} } & ?lexGrandma == ?glx & ?r == APPEND ) )
( ?glx == ?lex
  | ( ¬ ?glx == ?lex & ( c:?Grandma { c:lex = ?lexGrandma c:?rg1-> c:?Gov {} } & ?lexGrandma == ?glx & ( ?r == APPEND | ?Xl.meaning == "ELABORATION"  ) ) )
)

// no "by" unless in a passive contruction (actually BY have been removed from latest version of lexicon)
¬ (?r == I & ?prep == "por" & ¬?Gov.voice == "PASS" )

// II will be mapped to a subject
¬(?r == II & ?Gov.voice == "PASS")
  ]
  mixed = [

  ]
  rightside = [
?PrepR {
  <=> ?Xl
  slex = ?spx
  lex = #?spx+_IN_01#
  //  added_prep = ?spx
//  lemma = ?prep
  pos = "IN"
  spos = preposition
//  id=?Xl.id
  top = yes
  random = #randInt()#
  id = #randInt()#
  prepos-> ?Xr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma=?Xl.lemma
    pos=?Xl.pos
//    spos=?Xl.spos
//    id=?Xl.id
//    number=?Xl.number
    bottom = yes
  }
}
  ]
]

/* that [he] eats */
DSynt<=>SSynt CA_transfer_node_THAT : CA_transfer_node_multi_corresp
[
  leftside = [
c:?Yl {
  ¬ ( c:pos = "IN" | c:dlex = "quan" | c:dlex = "que" )
  c:?r-> ?Xl {
    ¬voice="PASS"
    ( ¬c:tem_constituency=?tc | c:tem_constituency = "IMP" )
    ¬modality=?m
    c:finiteness="FIN"
  }
}

language.id.iso.CA

( ?r == II | ?r == III )

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="que"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
  //  lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    tense=?Xl.tense
    finiteness="FIN"
    bottom=yes
  }
}
  ]
]

/*should eat*/
DSynt<=>SSynt CA_transfer_node_MODAL : CA_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  ¬c:voice="PASS"
  ( ¬c:tem_constituency=?tc | c:tem_constituency = "IMP" )
  ¬c:finiteness = "INF"
  modality = ?mod
  modality_type = ?mt
}

language.id.iso.CA
lexicon.modality.?mod.?mt.?lex
lexicon.?lex.lemma.?lem

( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quan" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?GovR {
  <=> ?Xl
  slex = ?lem
  lex = ?lex
//  lemma = "to"
  pos = "MD"
  spos = modal
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top = yes
  modal-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness = "INF"
    bottom = yes
  }
}
  ]
]

/* that [he] should eat */
DSynt<=>SSynt CA_transfer_node_THAT_MODAL : CA_transfer_node_multi_corresp
[
  leftside = [
c:?Yl {
  ¬ ( c:pos = "IN" | c:dlex = "quan" | c:dlex = "que" )
  c:?r-> ?Xl {
    ¬voice="PASS"
    ( ¬c:tem_constituency=?tc | c:tem_constituency = "IMP" )
    modality = ?mod
    modality_type = ?mt
    c:finiteness="FIN"
  }
}

language.id.iso.CA
lexicon.modality.?mod.?mt.?lexM
lexicon.?lexM.lemma.?lem

( ?r == II | ?r == III )

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="que"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?ModalR {
    <=> ?Xl
    slex = ?lem
    lex = ?lexM
  //  lemma = "to"
    pos = "MD"
    spos = modal
    tense=?Xl.tense
    finiteness=?Xl.finiteness
    middle = yes
    modal-> ?Yr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
  //    spos=?Xl.spos
  //    id=?Xl.id
      finiteness="INF"
      bottom=yes
    }
  }
}
  ]
]

/*is eaten */
DSynt<=>SSynt CA_transfer_node_PASS_aux : CA_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  voice="PASS"
  // Introduce auxiliary if there is a first argument; if not, use "se"; see ES_transfer_node_PASS_se
  // There seems to be a rule that applies to specific verbs that take auxiliary even though they have no first argument.
  // Find list of such verbs and make a more generic rule.
  ( c:I-> c:?Arg1l {} | c:lex = "afectar_VB_01" | c:lex = "conocer_VB_02" | c:lex = "condecorar_VB_01" )
  ( ¬c:tem_constituency=?tc | c:tem_constituency = "IMP" )
  ¬finiteness="INF"
  ¬modality=?m
  c:lex = ?lex
}

( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quan" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.CA

lexicon.?lex.aux_pass.?aux
lexicon.?aux.lemma.?lem

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex = ?lem
//  lemma = "be"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  analyt_pass-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
  //  lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness="PART"
    bottom=yes
  }
}
  ]
]

DSynt<=>SSynt CA_transfer_node_PASS_se : CA_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  voice="PASS"
  // See ES_transfer_node_PASS_aux
  ¬c:I-> c:?Arg1l {}
  ( ¬c:tem_constituency=?tc | c:tem_constituency = "IMP" )
  ¬finiteness="INF"
  ¬modality=?m
  // See ES_transfer_node_PASS_aux
  ¬ c:lex = "afectar_VB_01"
  ¬ c:lex = "conocer_VB_02"
  ¬ c:lex = "condecorar_VB_01"
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quan" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.CA

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex = ?Xl.dlex
  pos = "VB"
  aux_refl-> ?se {
    slex = "es"
    pos = "PRP"
    spos = "passive_marker"
    include = bubble_of_gov
  }
}
  ]
]

/*should be eaten */
DSynt<=>SSynt CA_transfer_node_PASS_MODAL_se : CA_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  voice="PASS"
  ¬tem_constituency=?t
  ¬finiteness="INF"
  modality = ?mod
  modality_type = ?mt
}

( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quan" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.CA
lexicon.modality.?mod.?mt.?lexM
lexicon.?lexM.lemma.?lem

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?ModalR {
  <=> ?Xl
  slex = ?lem
  lex = ?lexM
  pos = "MD"
  spos = modal
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top = yes
  modal-> ?Xr {
    <=> ?Xl
    slex=?Xl.lemma
    pos = ?Xl.pos
    finiteness="INF"
    bottom=yes
  }
  aux_refl-> ?se {
    slex = "es"
    pos = "PRP"
    spos = "passive_marker"
    include = bubble_of_gov
  }
}
  ]
]

/* that [he] should be eaten 

THIS RULE should go check in the lexicon which is the correct auxiliary for passive.*/
DSynt<=>SSynt CA_transfer_node_PASS_THAT_MODAL : CA_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  finiteness="FIN"
  voice="PASS"
  ( ¬c:tem_constituency=?tc | c:tem_constituency = "IMP" )
  ¬finiteness="INF"
  modality = ?mod
  modality_type = ?mt
  c:lex = ?lex
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quan" | c:dlex = "que" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.CA
lexicon.modality.?mod.?mt.?lexM
lexicon.?lexM.lemma.?lem

lexicon.?lex.aux_pass.?aux
lexicon.?aux.lemma.?lem2

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="que"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj->  ?ModalR {
    <=> ?Xl
    slex = ?lem
    lex = ?lexM
  //  lemma = "to"
    pos = "MD"
    spos = modal
    tense=?Xl.tense
    finiteness=?Xl.finiteness
    middle = yes
    modal-> ?Yr {
      <=> ?Xl
      slex = ?lem2
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
  //    id=?Xl.id
      finiteness="INF"
      middle=yes
      analyt_pass-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
  //      spos=?Xl.spos
  //      id=?Xl.id
        finiteness="PART"
        bottom=yes
      }
    }
  }
}
  ]
]

/* has eaten*/
DSynt<=>SSynt CA_transfer_node_PERFC : CA_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  ( tem_constituency="PERF-C" | tem_constituency="PERF" )
  ¬voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quan" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.CA

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex = "haber"
//  lemma="have"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  analyt_perf-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma=?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness="PART"
    bottom=yes
  }
}
  ]
]

/* that [he] is eating */
DSynt<=>SSynt CA_transfer_node_PERFC_THAT : CA_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  ( tem_constituency="PERF-C" | tem_constituency="PERF" )
  finiteness="FIN"
  //¬voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quan" | c:dlex = "que" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.CA

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }

( ¬?Xl.voice == "PASS" | ( c:?Xl { c:lex = ?lex3 } & lexicon.?lex3.transitive.no ) )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="que"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?Yr {
    <=> ?Xl
    slex =  "haber"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense=?Xl.tense
    middle=yes
    analyt_perf-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="PART"
      bottom=yes
    }
  }
}
  ]
]

/* has been eaten 

THIS RULE should go check in the lexicon which is the correct auxiliary for passive.*/
DSynt<=>SSynt CA_transfer_node_PERFC_PASS_aux : CA_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  // if prefprogr, simplify to perf, no? PTB_train_14564
  ( c:I-> c:?Arg1l {} | c:lex = "afectar_VB_01" | c:lex = "conocer_VB_02" | c:lex = "condecorar_VB_01" )
  ( tem_constituency="PERF-C" | tem_constituency="PERF" | tem_constituency="PERFPROGR" )
  voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
  c:lex = ?lex
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quan" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.CA

lexicon.?lex.aux_pass.?aux
lexicon.?aux.lemma.?lem

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )

//¬ ( c:?Xl { c:lex = ?lex3 } & lexicon.?lex3.transitive.no )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="haber"
//  lemma = "have"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  analyt_perf-> ?Yr {
    <=> ?Xl
    slex =  ?lem
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="PART"
    middle=yes
    analyt_pass-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="PART"
      bottom=yes
    }
  }
}
  ]
]

/* has been eaten 

THIS RULE should go check in the lexicon which is the correct auxiliary for passive.*/
DSynt<=>SSynt CA_transfer_node_PERFC_PASS_se : CA_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  // if prefprogr, simplify to perf, no? PTB_train_14564
  ¬c:I-> c:?Arg1l {}
  ( tem_constituency="PERF-C" | tem_constituency="PERF" | tem_constituency="PERFPROGR" )
  voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
  // See ES_transfer_node_PASS_aux
  ¬ c:lex = "afectar_VB_01"
  ¬ c:lex = "conocer_VB_02"
  ¬ c:lex = "condecorar_VB_01"
  c:lex = ?lex
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quan" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.CA

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )

//¬ ( c:?Xl { c:lex = ?lex3 } & lexicon.?lex3.transitive.no )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="haber"
//  lemma = "have"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  analyt_perf-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="PART"
    bottom=yes
  }
  aux_refl-> ?se {
    slex = "es"
    pos = "PRP"
    spos = "passive_marker"
    include = bubble_of_gov
  }
}
  ]
]

/* that [he] has been eaten */
DSynt<=>SSynt CA_transfer_node_PERFC_PASS_THAT : CA_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  // if prefprogr, simplify to perf, no? PTB_train_14564
  ( tem_constituency="PERF-C" | tem_constituency="PERF" | tem_constituency="PERFPROGR" )
  finiteness="FIN"
  voice="PASS"
  ¬finiteness="INF"
  ¬modality = ?m
  c:lex = ?lex
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quan" | c:dlex = "que" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.CA

lexicon.?lex.aux_pass.?aux
lexicon.?aux.lemma.?lem

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }

¬ ( c:?Xl { c:lex = ?lex3 } & lexicon.?lex3.transitive.no )
  ]
  mixed = [

  ]
  rightside = [
?Wr {
    <=> ?Xl 
  slex="que"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?Xr {
    <=> ?Xl
    slex = "haber"
  //  lemma = "have"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense=?Xl.tense
    middle=yes
    analyt_perf-> ?Yr {
      <=> ?Xl
      slex =  ?lem
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
//      id=?Xl.id
      finiteness="PART"
      middle=yes
      analyt_pass-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
//        spos=?Xl.spos
//        id=?Xl.id
        finiteness="PART"
        bottom=yes
      }
    }
  }
}
  ]
]

/* has eaten*/
DSynt<=>SSynt CA_transfer_node_PERFS : CA_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PERF-S"
  ¬voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quan" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.CA

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex = "ir"
//  lemma="have"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense="PRES"
  finiteness=?Xl.finiteness
  top=yes
  analyt_perf-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma=?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness="INF"
    bottom=yes
  }
}
  ]
]

/* that [he] is eating */
DSynt<=>SSynt CA_transfer_node_PERFS_THAT : CA_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PERF-S"
  finiteness="FIN"
  //¬voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quan" | c:dlex = "que" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.CA

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }

( ¬?Xl.voice == "PASS" | ( c:?Xl { c:lex = ?lex3 } & lexicon.?lex3.transitive.no ) )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="que"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?Yr {
    <=> ?Xl
    slex =  "ir"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense="PRES"
    middle=yes
    analyt_perf-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="INF"
      bottom=yes
    }
  }
}
  ]
]

/* has been eaten 

THIS RULE should go check in the lexicon which is the correct auxiliary for passive.*/
DSynt<=>SSynt CA_transfer_node_PERFS_PASS_aux : CA_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  ( c:I-> c:?Arg1l {} | c:lex = "afectar_VB_01" | c:lex = "conocer_VB_02" | c:lex = "condecorar_VB_01" )
  tem_constituency="PERF-S"
  voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
  c:lex = ?lex
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quan" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.CA

lexicon.?lex.aux_pass.?aux
lexicon.?aux.lemma.?lem

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )

//¬ ( c:?Xl { c:lex = ?lex3 } & lexicon.?lex3.transitive.no )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="ir"
//  lemma = "have"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense="PRES"
  finiteness=?Xl.finiteness
  top=yes
  analyt_perf-> ?Yr {
    <=> ?Xl
    slex =  ?lem
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="INF"
    middle=yes
    analyt_pass-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="PART"
      bottom=yes
    }
  }
}
  ]
]

/* has been eaten 

THIS RULE should go check in the lexicon which is the correct auxiliary for passive.*/
DSynt<=>SSynt CA_transfer_node_PERFS_PASS_se : CA_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  ¬c:I-> c:?Arg1l {}
  tem_constituency="PERF-S"
  voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
  // See ES_transfer_node_PASS_aux
  ¬ c:lex = "afectar_VB_01"
  ¬ c:lex = "conocer_VB_02"
  ¬ c:lex = "condecorar_VB_01"
  c:lex = ?lex
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quan" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.CA

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )

//¬ ( c:?Xl { c:lex = ?lex3 } & lexicon.?lex3.transitive.no )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="anar"
  lex="anar_VB_01"
//  lemma = "have"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense="PRES"
  finiteness=?Xl.finiteness
  top=yes
  analyt_perf-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="INF"
    bottom=yes
  }
  aux_refl-> ?se {
    slex = "es"
    pos = "PRP"
    spos = "passive_marker"
    include = bubble_of_gov
  }
}
  ]
]

/* that [he] has been eaten */
DSynt<=>SSynt CA_transfer_node_PERFS_PASS_THAT : CA_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PERF-S"
  finiteness="FIN"
  voice="PASS"
  ¬finiteness="INF"
  ¬modality = ?m
  c:lex = ?lex
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quan" | c:dlex = "que" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.CA

lexicon.?lex.aux_pass.?aux
lexicon.?aux.lemma.?lem

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }

¬ ( c:?Xl { c:lex = ?lex3 } & lexicon.?lex3.transitive.no )
  ]
  mixed = [

  ]
  rightside = [
?Wr {
    <=> ?Xl 
  slex="que"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?Xr {
    <=> ?Xl
    slex = "ir"
  //  lemma = "have"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense="PRES"
    middle=yes
    analyt_perf-> ?Yr {
      <=> ?Xl
      slex =  ?lem
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
//      id=?Xl.id
      finiteness="INF"
      middle=yes
      analyt_pass-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
//        spos=?Xl.spos
//        id=?Xl.id
        finiteness="PART"
        bottom=yes
      }
    }
  }
}
  ]
]

/* is eating */
DSynt<=>SSynt CA_transfer_node_PROGR : CA_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  ¬voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quan" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.CA

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="estar"
  lex="estar_VB_01"
//  lemma = "be"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  analyt_progr-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
  //  lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness="GER"
    bottom=yes
  }
}
  ]
]

/* that [he] is eating */
DSynt<=>SSynt CA_transfer_node_PROGR_THAT : CA_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  finiteness="FIN"
  ¬voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quan" | c:dlex = "que" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.CA

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="que"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?Yr {
    <=> ?Xl
    slex="estar"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense=?Xl.tense
    middle=yes
    analyt_progr-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="GER"
      bottom=yes
    }
  }
}
  ]
]

/* is being eaten 

THIS RULE should go check in the lexicon which is the correct auxiliary for passive.*/
DSynt<=>SSynt CA_transfer_node_PROGR_PASS : CA_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
  c:lex = ?lex
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quan" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.CA

lexicon.?lex.aux_pass.?aux
lexicon.?aux.lemma.?lem

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="estar"
//  lemma = "be"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  analyt_progr-> ?Yr {
    <=> ?Xl
    slex = ?lem
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="GER"
    middle=yes
    analyt_pass-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="PART"
      bottom=yes
    }
  }
}
  ]
]

/* that [he] is being eaten 

THIS RULE should go check in the lexicon which is the correct auxiliary for passive.*/
DSynt<=>SSynt CA_transfer_node_PROGR_PASS_THAT : CA_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  finiteness="FIN"
  voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
  c:lex = ?lex
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quan" | c:dlex = "que" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.CA

lexicon.?lex.aux_pass.?aux
lexicon.?aux.lemma.?lem

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Wr {
    <=> ?Xl 
  slex="que"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?Xr {
    <=> ?Xl
    slex="estar"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense=?Xl.tense
    middle=yes
    analyt_progr-> ?Yr {
      <=> ?Xl
      slex = ?lex
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
//      id=?Xl.id
      finiteness="GER"
      middle=yes
      analyt_pass-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
//        spos=?Xl.spos
//        id=?Xl.id
        finiteness="PART"
        bottom=yes
      }
    }
  }
}
  ]
]

/* should be eating */
DSynt<=>SSynt CA_transfer_node_PROGR_MODAL : CA_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  ¬voice="PASS"
  ¬finiteness="INF"
  modality = ?mod
  modality_type = ?mt
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quan" | c:dlex = "que" )
                 c:?rds-> ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.CA
lexicon.modality.?mod.?mt.?lex
lexicon.?lex.lemma.?lem


// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?ModalR {
  <=> ?Xl
  slex = ?lem
  lex = ?lex
  pos = "MD"
  spos = auxiliary
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top = yes
  modal-> ?Xr {
    <=> ?Xl
    slex="estar"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
  //  id=?Xl.id
    finiteness="INF"
    middle=yes
    analyt_progr-> ?Yr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
  //    spos=?Xl.spos
  //    id=?Xl.id
      finiteness="GER"
      bottom=yes
    }
  }
}
  ]
]

DSynt<=>SSynt DE_transfer_node_IN_governed : DE_transfer_node_multi_corresp
[
  leftside = [
c:?Gov {
  c:lex=?lex
  c:?r-> ?Xl {
    ¬voice="PASS"
    //¬tem_constituency=?tc
    ¬modality=?m
    ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" )
  }
}

( ¬?Xl { tem_constituency = ?tc } | ( ?Xl { tem_constituency = ?tcg } & ?tcg == "PROGR" ) )

lexicon.?lex.gp.?r.prep.?prep
¬?prep == Locin

¬(?r == I & ?prep == "par" & ¬?Gov.voice == "PASS")

language.id.iso.DE

( ¬ (?Gov.pos == "VB" & ?r == I ) | ?Xl.finiteness == "INF" )

// if Xl is a finite verb, don't introduce the preposition (see THAT rules)
¬ ( c:?Gov {¬( c:pos = "IN" | c:dlex = "wenn" | c:dlex = "dass" )} & ( ?r == II | ?r == III ) & ?Xl {finiteness="FIN"} )
  ]
  mixed = [

  ]
  rightside = [
?PrepR {
  <=> ?Xl
  slex = ?prep
  //  added_prep = ?prep
//  lemma = ?prep
  pos = "IN"
  spos = preposition
//  id=?Xl.id
  top = yes
  PMOD-> ?Xr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma=?Xl.lemma
    pos=?Xl.pos
//    spos=?Xl.spos
//    id=?Xl.id
//    number=?Xl.number
    bottom = yes
  }
}
  ]
]

DSynt<=>SSynt DE_transfer_node_IN_governed_Locin : DE_transfer_node_multi_corresp
[
  leftside = [
c:?Gov {
  c:lex=?lex
  c:?r-> ?Xl {
    ¬voice="PASS"
    //¬tem_constituency=?tc
    ¬modality=?m
    ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" )
  }
}

( ¬?Xl { tem_constituency = ?tc } | ( ?Xl { tem_constituency = ?tcg } & ?tcg == "PROGR" ) )

lexicon.?lex.gp.?r.prep.Locin
lexicon.?lex2.Locin.?lexLoc
lexicon.?lexLoc.lemma.?lem
lexicon.?lexLoc.pos.?pos
lexicon.?lexLoc.spos.?spos

¬(?r == I & ?prep == "par" & ¬?Gov.voice == "PASS")

language.id.iso.DE

( ¬ (?Gov.pos == "VB" & ?r == I ) | ?Xl.finiteness == "INF" )

// if Xl is a finite verb, don't introduce the preposition (see THAT rules)
¬ ( c:?Gov {¬( c:pos = "IN" | c:dlex = "wenn" | c:dlex = "dass" )} & ( ?r == II | ?r == III ) & ?Xl {finiteness="FIN"} )
  ]
  mixed = [

  ]
  rightside = [
?PrepR {
  <=> ?Xl
  slex = ?lem
  //  added_prep = ?lem
  pos = ?pos
  spos = ?spos
  top = yes
  PMOD-> ?Xr {
    <=> ?Xl
    slex=?Xl.dlex
    pos=?Xl.pos
    bottom = yes
  }
}
  ]
]

/* that [he] eats */
DSynt<=>SSynt DE_transfer_node_THAT : DE_transfer_node_multi_corresp
[
  leftside = [
c:?Yl {
  ¬ ( c:pos = "IN" | c:dlex = "wenn" | c:dlex = "dass" )
  c:?r-> ?Xl {
    ¬voice="PASS"
    //¬tem_constituency=?t
    ¬modality=?m
    c:finiteness="FIN"
  }
}

language.id.iso.DE

( ¬?Xl { tem_constituency = ?tc } | ( ?Xl { tem_constituency = ?tcg } & ?tcg == "PROGR" ) )

(?r == I | ?r == II | ?r == III )

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="dass"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  CP-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
  //  lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    tense=?Xl.tense
    finiteness="FIN"
    bottom=yes
  }
}
  ]
]

/*should eat*/
DSynt<=>SSynt DE_transfer_node_MODAL : DE_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  ¬c:voice="PASS"
  //¬c:tem_constituency=?t
  ¬c:finiteness = "INF"
  modality = ?mod
  modality_type = ?mt
}

language.id.iso.DE
lexicon.modality.?mod.?mt.?lex
lexicon.?lex.lemma.?lemma

( ¬?Xl { tem_constituency = ?tc } | ( ?Xl { tem_constituency = ?tcg } & ?tcg == "PROGR" ) )

( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "wenn" | c:dlex = "dass" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP" | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?GovR {
  <=> ?Xl
  slex = ?lemma
//  lemma = "to"
  pos = "MD"
  spos = auxiliary
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top = yes
  OC-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness = "INF"
    bottom = yes
  }
}
  ]
]

/* that [he] should eat */
DSynt<=>SSynt DE_transfer_node_THAT_MODAL : DE_transfer_node_multi_corresp
[
  leftside = [
c:?Yl {
  ¬ ( c:pos = "IN" | c:dlex = "wenn" | c:dlex = "dass" )
  c:?r-> ?Xl {
    ¬voice="PASS"
    //¬tem_constituency=?t
    modality = ?mod
    modality_type = ?mt
    c:finiteness="FIN"
  }
}

language.id.iso.DE
lexicon.modality.?mod.?mt.?lexM

( ¬?Xl { tem_constituency = ?tc } | ( ?Xl { tem_constituency = ?tcg } & ?tcg == "PROGR" ) )

( ?r == II | ?r == III )

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="dass"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  CP-> ?ModalR {
    <=> ?Xl
    slex = ?lexM
  //  lemma = "to"
    pos = "MD"
    spos = auxiliary
    tense=?Xl.tense
    finiteness=?Xl.finiteness
    middle = yes
    OC-> ?Yr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
  //    spos=?Xl.spos
  //    id=?Xl.id
      finiteness="INF"
      bottom=yes
    }
  }
}
  ]
]

/*is eaten

THIS RULE should go check in the lexicon which is the correct auxiliary for passive.*/
DSynt<=>SSynt DE_transfer_node_PASS : DE_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  voice="PASS"
  //¬tem_constituency=?t
  ¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "wenn" | c:dlex = "dass" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.DE

( ¬?Xl { tem_constituency = ?tc } | ( ?Xl { tem_constituency = ?tcg } & ?tcg == "PROGR" ) )

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )

//¬ ( c:?Xl { c:lex = ?lex3 } & lexicon.?lex3.transitive.no )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="werden"
//  lemma = "be"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  OC-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
  //  lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness="PART"
    bottom=yes
  }
}
  ]
]

/* has eaten*/
DSynt<=>SSynt DE_transfer_node_PERF : DE_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  ( tem_constituency="PERF" | tem_constituency="PERFPROGR" )
  ¬voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "wenn" | c:dlex = "dass" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.DE

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="haben"
//  lemma="have"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  OC-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma=?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness="PART"
    bottom=yes
  }
}
  ]
]

/* is eating */
excluded DSynt<=>SSynt DE_transfer_node_PROGR : DE_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  ¬voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "wenn" | c:dlex = "dass" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.DE

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )

// see FR_transfer_node_PROGR_wrong_parse
¬ ( c:?Xl {c:lemma = "être" c:II-> c:?V3l { c:finiteness = "GER" } } )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="être_en_train_de"
//  lemma = "be"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  analyt_progr-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
  //  lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness="INF"
    bottom=yes
  }
}
  ]
]

/* is eating */
excluded DSynt<=>SSynt DE_transfer_node_PROGR_wrong_parse : DE_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  ¬voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "wenn" | c:dlex = "dass" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.DE

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )

( c:?Xl {c:lemma = "être" c:II-> c:?V3l { c:finiteness = "GER" } } )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="être_en_train_de"
//  lemma = "be"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  analyt_progr-> rc:?Yr {
   rc:<=> ?V3l
     rc:finiteness = "GER"
     finiteness="INF"
  }
}
  ]
]

/* that [he] is eating */
DSynt<=>SSynt DE_transfer_node_PERF_THAT : DE_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  ( tem_constituency="PERF" | tem_constituency="PERFPROGR" )
  finiteness="FIN"
  //¬voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "wenn" | c:dlex = "dass" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.DE

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }

( ¬?Xl.voice == "PASS" | ( c:?Xl { c:lex = ?lex3 } & lexicon.?lex3.transitive.no ) )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="dass"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  CP-> ?Yr {
    <=> ?Xl
    slex="haben"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense=?Xl.tense
    middle=yes
    OC-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="PART"
      bottom=yes
    }
  }
}
  ]
]

/* has been eaten 

THIS RULE should go check in the lexicon which is the correct auxiliary for passive.*/
DSynt<=>SSynt DE_transfer_node_PERF_PASS : DE_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  // if prefprogr, simplify to perf, no? PTB_train_14564
  ( tem_constituency="PERF" | tem_constituency="PERFPROGR" )
  voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "wenn" | c:dlex = "dass" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.DE

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )

//¬ ( c:?Xl { c:lex = ?lex3 } & lexicon.?lex3.transitive.no )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="haben"
//  lemma = "have"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  OC-> ?Yr {
    <=> ?Xl
    slex="werden"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="PART"
    middle=yes
    OC-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="PART"
      bottom=yes
    }
  }
}
  ]
]

/* that [he] has been eaten */
DSynt<=>SSynt DE_transfer_node_PERF_PASS_THAT : DE_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  // if prefprogr, simplify to perf, no? PTB_train_14564
  ( tem_constituency="PERF" | tem_constituency="PERFPROGR" )
  finiteness="FIN"
  voice="PASS"
  ¬finiteness="INF"
  ¬modality = ?m
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "wenn" | c:dlex = "dass" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.DE

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }

¬ ( c:?Xl { c:lex = ?lex3 } & lexicon.?lex3.transitive.no )
  ]
  mixed = [

  ]
  rightside = [
?Wr {
    <=> ?Xl 
  slex="dass"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  CP-> ?Xr {
    <=> ?Xl
    slex="haben"
  //  lemma = "have"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense=?Xl.tense
    middle=yes
    OC-> ?Yr {
      <=> ?Xl
      slex="werden"
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
//      id=?Xl.id
      finiteness="PART"
      middle=yes
      OC-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
//        spos=?Xl.spos
//        id=?Xl.id
        finiteness="PART"
        bottom=yes
      }
    }
  }
}
  ]
]

/* is being eaten 

THIS RULE should go check in the lexicon which is the correct auxiliary for passive.*/
excluded DSynt<=>SSynt DE_transfer_node_PROGR_PASS : DE_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "wenn" | c:dlex = "dass" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.DE

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="être_en_train_de"
//  lemma = "be"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  analyt_progr-> ?Yr {
    <=> ?Xl
    slex="werden"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="INF"
    middle=yes
    analyt_pass-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="PART"
      bottom=yes
    }
  }
}
  ]
]

/* that [he] is eating */
excluded DSynt<=>SSynt DE_transfer_node_PROGR_THAT : DE_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  finiteness="FIN"
  ¬voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "wenn" | c:dlex = "dass" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.DE

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="dass"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?Yr {
    <=> ?Xl
    slex="être_en_train_de"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense=?Xl.tense
    middle=yes
    analyt_progr-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="INF"
      bottom=yes
    }
  }
}
  ]
]

/* that [he] is being eaten 

THIS RULE should go check in the lexicon which is the correct auxiliary for passive.*/
excluded DSynt<=>SSynt DE_transfer_node_PROGR_PASS_THAT : DE_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  finiteness="FIN"
  voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "wenn" | c:dlex = "dass" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.DE

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Wr {
    <=> ?Xl 
  slex="dass"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?Xr {
    <=> ?Xl
    slex="être_en_train_de"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense=?Xl.tense
    middle=yes
    analyt_progr-> ?Yr {
      <=> ?Xl
      slex="werden"
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
//      id=?Xl.id
      finiteness="INF"
      middle=yes
      analyt_pass-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
//        spos=?Xl.spos
//        id=?Xl.id
        finiteness="PART"
        bottom=yes
      }
    }
  }
}
  ]
]

/* that [he] is eaten */
DSynt<=>SSynt DE_transfer_node_PASS_THAT : DE_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  finiteness="FIN"
  voice="PASS"
  //¬tem_constituency=?t
  ¬finiteness="INF"
  ¬modality=?m
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "wenn" | c:dlex = "dass" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.DE

( ¬?Xl { tem_constituency = ?tc } | ( ?Xl { tem_constituency = ?tcg } & ?tcg == "PROGR" ) )

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="dass"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  CP-> ?Yr {
    <=> ?Xl
    slex="werden"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense=?Xl.tense
    middle=yes
    OC-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="PART"
      bottom=yes
    }
  }
}
  ]
]

/* that [he] should be eaten 

THIS RULE should go check in the lexicon which is the correct auxiliary for passive.*/
DSynt<=>SSynt DE_transfer_node_PASS_THAT_MODAL : DE_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  finiteness="FIN"
  voice="PASS"
  //¬tem_constituency=?t
  ¬finiteness="INF"
  modality = ?mod
  modality_type = ?mt
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "wenn" | c:dlex = "dass" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.DE
lexicon.modality.?mod.?mt.?lexM

( ¬?Xl { tem_constituency = ?tc } | ( ?Xl { tem_constituency = ?tcg } & ?tcg == "PROGR" ) )

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="dass"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  CP->  ?ModalR {
    <=> ?Xl
    slex = ?lexM
  //  lemma = "to"
    pos = "MD"
    spos = auxiliary
    tense=?Xl.tense
    finiteness=?Xl.finiteness
    middle = yes
    OC-> ?Yr {
      <=> ?Xl
      slex="werden"
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
  //    id=?Xl.id
      finiteness="INF"
      middle=yes
      OC-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
  //      spos=?Xl.spos
  //      id=?Xl.id
        finiteness="PART"
        bottom=yes
      }
    }
  }
}
  ]
]

/* that [he] should be eaten 

THIS RULE should go check in the lexicon which is the correct auxiliary for passive.*/
DSynt<=>SSynt DE_transfer_node_PASS_MODAL : DE_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  finiteness="FIN"
  voice="PASS"
  //¬tem_constituency=?t
  ¬finiteness="INF"
  modality = ?mod
  modality_type = ?mt
}

¬c:?Zl {c:?r-> ?Xl{}}

language.id.iso.DE
lexicon.modality.?mod.?mt.?lexM

( ¬?Xl { tem_constituency = ?tc } | ( ?Xl { tem_constituency = ?tcg } & ?tcg == "PROGR" ))

//¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }  //condition included in the 1st condition
  ]
  mixed = [

  ]
  rightside = [
?ModalR {
    <=> ?Xl
    slex = ?lexM
  //  lemma = "to"
    pos = "MD"
    spos = auxiliary
    tense=?Xl.tense
    finiteness=?Xl.finiteness
    middle = yes
    OC-> ?Yr {
      <=> ?Xl
      slex="werden"
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
  //    id=?Xl.id
      finiteness="INF"
      middle=yes
      OC-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
  //      spos=?Xl.spos
  //      id=?Xl.id
        finiteness="PART"
        bottom=yes
    }
  }
}
  ]
]

DSynt<=>SSynt EL_transfer_node_IN_governed : EL_transfer_node_multi_corresp
[
  leftside = [
c:?Gov {
  c:lex=?lex
  c:?r-> ?Xl {
    ¬c:tem_constituency=?tc
    ¬modality=?m
  }
}


// Generalize the "IN" part to all languages? Testing now on catalan.
// Problem is: it may be an overkill. Maybe handle complex prepositions differently, with a dedicated rule or with a "cheat" lemma in the lexicon
// (e.g. "next to" instead of "next" subcategorizing "to")
( ?Gov.pos == "IN" | ?Xl.pos == "NN" | ?Xl.pos == "NP"  | ?Xl.pos == "VB" | ?Xl.pos == "CD" )

// In abstractive summarization, sometimes we keep the prepositions
¬ ( ?Xl { c:subcat_prep = ?spx c:GovLex = ?glx } & ?glx == ?lex )

lexicon.?lex.gp.?r.prep.?prep

// II will be mapped to a subject
¬(?r == II & ?Gov.voice == "PASS")

language.id.iso.EL
  ]
  mixed = [

  ]
  rightside = [
?PrepR {
  <=> ?Xl
  slex = ?prep
  //  added_prep = ?prep
//  lemma = ?prep
  pos = "IN"
  spos = preposition
//  id=?Xl.id
  top = yes
  prepos-> ?Xr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma=?Xl.lemma
    pos=?Xl.pos
//    spos=?Xl.spos
//    id=?Xl.id
//    number=?Xl.number
    bottom = yes
  }
}
  ]
]

DSynt<=>SSynt EL_transfer_node_IN_governed_inStr : EL_transfer_node_multi_corresp
[
  leftside = [
c:?Gov {
  c:lex=?lex
  c:?r-> ?Xl {
    ¬c:tem_constituency=?tc
    ¬modality=?m
  }
}


// Generalize the "IN" part to all languages? Testing now on catalan.
// Problem is: it may be an overkill. Maybe handle complex prepositions differently, with a dedicated rule or with a "cheat" lemma in the lexicon
// (e.g. "next to" instead of "next" subcategorizing "to")
( ?Gov.pos == "IN" | ?Xl.pos == "NN" | ?Xl.pos == "NP"  | ?Xl.pos == "VB" | ?Xl.pos == "CD" )

// In abstractive summarization, sometimes we keep the prepositions
( ?Xl { c:subcat_prep = ?spx c:GovLex = ?glx } & ?glx == ?lex )

// II will be mapped to a subject
¬(?r == II & ?Gov.voice == "PASS")

language.id.iso.EL
  ]
  mixed = [

  ]
  rightside = [
?PrepR {
  <=> ?Xl
  slex = ?spx
  lex = #?spx+_IN_01#
  //  added_prep = ?prep
//  lemma = ?prep
  pos = "IN"
  spos = preposition
//  id=?Xl.id
  top = yes
  prepos-> ?Xr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma=?Xl.lemma
    pos=?Xl.pos
//    spos=?Xl.spos
//    id=?Xl.id
//    number=?Xl.number
    bottom = yes
  }
}
  ]
]

/*similar rules missing for all configurations of auxiliaries! (160802_ME_edited #0)*/
DSynt<=>SSynt EN_transfer_node_IN_governed : EN_transfer_node_multi_corresp
[
  leftside = [
c:?Gov {
  c:lex=?lex
  c:?r-> ?Xl {
    ¬voice="PASS"
    ¬tem_constituency=?tc
    ¬modality=?m
    ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" | c:pos = "JJ" | c:pos = "WP" )
  }
}

lexicon.?lex.gp.?r.prep.?prep
language.id.iso.EN
// see prep Locin
¬ ( ?prep == Locin & c:?Xl { c:lex = ?lexX } & lexicon.?lexX.Locin.?lexPrep & lexicon.?lexPrep.lemma.?prepLocin )

// In abstractive summarization, sometimes we keep the prepositions
¬ ( ?Xl { c:subcat_prep = ?spx c:GovLex = ?glx } & ?glx == ?lex )

// II will be mapped to a subject
¬(?r == II & ?Gov.voice == "PASS")

// no "by" unless in a passive contruction (actually BY have been removed from latest version of lexicon)
¬ (?r == I & ?prep == "by" & ¬?Gov.voice == "PASS" )
// Generalization: never introduce preposition for A1 of verbs? (they end up as subjects or agents)
// the INF part is to cover for INF verbs with a gov that asks for a "to"; no rule covers that so far, so I decide to let the "to"
// see node_basic and node_to; PTB_train_3751
( ¬ (?Gov.pos == "VB" & ?r == I ) | ?Xl.finiteness == "INF" )
¬ (?r == III & ?Gov.dative_shift == "DO")

// if Xl is a finite verb, don't introduce the preposition (see THAT rules)
¬ ( c:?Gov {¬( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  )} & ( ?r == II | ?r == III | ?r == IV ) & ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } } )

// see transfer_node_TO
( ¬?Xl.finiteness == "INF" | ?prep == "to" )

//exclude control and raise verbs when introducing a preposition on a non verbal element
// restrict to "to"???
¬ ( c:?Gov { c:dlex = ?lem } & control_raise.?type.lex.?lem & ¬?Xl.pos == "VB" & ?prep == "to" )

// if the noun is genitive and has a coreference, it will be pronominalized
¬ ( c:?Xl { c:case = "GEN" c:<-> c:?Antecedent {} ¬c:ambiguous_antecedent = "yes" ¬c:?r13-> c:?D13 {}  } & ¬c:?Gov12 { c:definiteness = "INDEF" c:?r12-> c:?Xl {} } )

// if Xl is a personal pronoun and has genitive case, it will be transformed into a possessive
 ¬ (?Xl.case == "GEN" & ?Xl.pos == "PRP")
  ]
  mixed = [

  ]
  rightside = [
?PrepR {
  <=> ?Xl
  slex = ?prep
  //  added_prep = ?prep
//  lemma = ?prep
  pos = "IN"
  spos = preposition
//  id=?Xl.id
  top = yes
  random = #randInt()#
  PMOD-> ?Xr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma=?Xl.lemma
    pos=?Xl.pos
//    spos=?Xl.spos
//    id=?Xl.id
//    number=?Xl.number
    bottom = yes
  }
}
  ]
]

DSynt<=>SSynt EN_transfer_node_IN_governed_inStr : EN_transfer_node_multi_corresp
[
  leftside = [
c:?Gov {
  c:lex=?lex
  c:?r-> ?Xl {
    ¬voice="PASS"
    ¬tem_constituency=?tc
    ¬modality=?m
    ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" | c:pos = "RB" | c:pos = "JJ" )
    subcat_prep = ?spx
    GovLex = ?glx
  }
}

language.id.iso.EN

// In abstractive summarization, sometimes we keep the prepositions
( ?glx == ?lex
  | ( ¬ ( ?glx == ?lex ) & ( c:?Grandma { c:lex = ?lexGrandma c:?rg1-> c:?Gov {} } & ?lexGrandma == ?glx & ( ?r == APPEND | ?Xl.meaning == "ELABORATION"  ) ) )
)

// II will be mapped to a subject
¬(?r == II & ?Gov.voice == "PASS")

// no "by" unless in a passive contruction (actually BY have been removed from latest version of lexicon)
¬ (?r == I & ?prep == "by" & ¬?Gov.voice == "PASS" )
// Generalization: never introduce preposition for A1 of verbs? (they end up as subjects or agents)
// the INF part is to cover for INF verbs with a gov that asks for a "to"; no rule covers that so far, so I decide to let the "to"
// see node_basic and node_to; PTB_train_3751
( ¬ (?Gov.pos == "VB" & ?r == I ) | ?Xl.finiteness == "INF" )
¬ (?r == III & ?Gov.dative_shift == "DO")

// if Xl is a finite verb, don't introduce the preposition (see THAT rules)
¬ ( c:?Gov {¬( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  )} & ( ?r == II | ?r == III | ?r == IV ) & ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } } )

// see transfer_node_TO
( ¬?Xl.finiteness == "INF" | ?prep == "to" )

//exclude control and raise verbs when introducing a preposition on a non verbal element
// restrict to "to"???
¬ ( c:?Gov { c:dlex = ?lem } & control_raise.?type.lex.?lem & ¬?Xl.pos == "VB" & ?prep == "to" )

// if the noun is genitive and has a coreference, it will be pronominalized
¬ ( c:?Xl { c:case = "GEN" c:<-> c:?Antecedent {} ¬c:ambiguous_antecedent = "yes" ¬c:?r13-> c:?D13 {}  } & ¬c:?Gov12 { c:definiteness = "INDEF" c:?r12-> c:?Xl {} } )

// if Xl is a personal pronoun and has genitive case, it will be transformed into a possessive
 ¬ (?Xl.case == "GEN" & ?Xl.pos == "PRP")
  ]
  mixed = [

  ]
  rightside = [
?PrepR {
  <=> ?Xl
  slex = ?spx
  lex = #?spx+_IN_01#
  //  added_prep = ?spx
//  lemma = ?prep
  pos = "IN"
  spos = preposition
//  id=?Xl.id
  top = yes
  random = #randInt()#
  id = #randInt()#
  PMOD-> ?Xr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma=?Xl.lemma
    pos=?Xl.pos
//    spos=?Xl.spos
//    id=?Xl.id
//    number=?Xl.number
    bottom = yes
  }
}
  ]
]

/*there is a governed preposition and the verb above is passive.
(different from PASS_IN_governed, in which the passive verb itself has a governed prep)*/
DSynt<=>SSynt EN_transfer_node_IN_governed_II_pass : EN_transfer_node_multi_corresp
[
  leftside = [
c:?Gov {
  c:lex=?lex
  c:?r-> ?Xl {
    ¬voice="PASS"
    ¬tem_constituency=?tc
    ¬modality=?m
    ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB"  | c:pos = "CD" | c:pos = "PRP" )
  }
}

lexicon.?lex.gp.?r.prep.?prep
language.id.iso.EN

// II will be mapped to a subject
(?r == II & ?Gov.voice == "PASS")

// if Xl is a finite verb, don't introduce the preposition (see THAT rules)
¬ ( c:?Gov {¬( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  )} & ( ?r == II | ?r == III | ?r == IV ) & ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } } )

// if the II is an INF, we will transform it into a GER afterwards, no need to apply infinitive rule
//( ?prep == "to" | ¬?Xl.finiteness == "INF" )

//exclude control and raise verbs when introducing a preposition on a non verbal element
// restrict to "to"???
¬ ( c:?Gov { c:dlex = ?lem } & control_raise.?type.lex.?lem & ¬?Xl.pos == "VB" & ?prep == "to"  )
  ]
  mixed = [

  ]
  rightside = [
rc:?Govr {
  rc:<=> ?Gov
  ¬rc:top=yes
  ¬rc:middle=yes
  PRT-> ?PrepR {
    slex = ?prep
    //  added_prep = ?prep
  //  lemma = ?prep
    pos = "IN"
    spos = preposition
    include = bubble_of_gov
    random = #randInt()#
  //  id=?Xl.id
  }
}

?Xr {
  <=> ?Xl
  slex=?Xl.dlex
//  lemma=?Xl.lemma
  pos=?Xl.pos
//  spos=?Xl.spos
//  id=?Xl.id
//  number=?Xl.number
}
  ]
]

/*similar rules missing for all configurations of auxiliaries! (160802_ME_edited #0)*/
DSynt<=>SSynt EN_transfer_node_IN_governed_Locin : EN_transfer_node_multi_corresp
[
  leftside = [
c:?Gov {
  c:lex=?lex
  c:?r-> ?Xl {
    ¬voice="PASS"
    ¬tem_constituency=?tc
    ¬modality=?m
    ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" | c:pos = "JJ" )
    c:lex = ?lexX
  }
}

lexicon.?lex.gp.?r.prep.Locin
lexicon.?lexX.Locin.?lexPrep
lexicon.?lexPrep.lemma.?prep
language.id.iso.EN

// In abstractive summarization, sometimes we keep the prepositions
¬ ( ?Xl { c:subcat_prep = ?spx c:GovLex = ?glx } & ?glx == ?lex )

// II will be mapped to a subject
¬(?r == II & ?Gov.voice == "PASS")

// no "by" unless in a passive contruction (actually BY have been removed from latest version of lexicon)
¬ (?r == I & ?prep == "by" & ¬?Gov.voice == "PASS" )
// Generalization: never introduce preposition for A1 of verbs? (they end up as subjects or agents)
// the INF part is to cover for INF verbs with a gov that asks for a "to"; no rule covers that so far, so I decide to let the "to"
// see node_basic and node_to; PTB_train_3751
( ¬ (?Gov.pos == "VB" & ?r == I ) | ?Xl.finiteness == "INF" )
¬ (?r == III & ?Gov.dative_shift == "DO")

// if Xl is a finite verb, don't introduce the preposition (see THAT rules)
¬ ( c:?Gov {¬( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  )} & ( ?r == II | ?r == III | ?r == IV ) & ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } } )

// see transfer_node_TO
( ¬?Xl.finiteness == "INF" | ?prep == "to" )

//exclude control and raise verbs when introducing a preposition on a non verbal element
// restrict to "to"???
¬ ( c:?Gov { c:dlex = ?lem } & control_raise.?type.lex.?lem & ¬?Xl.pos == "VB" & ?prep == "to" )

// if the noun is genitive and has a coreference, it will be pronominalized
¬ ( c:?Xl { c:case = "GEN" c:<-> c:?Antecedent {} ¬c:ambiguous_antecedent = "yes"  } & ¬c:?Gov12 { c:definiteness = "INDEF" c:?r12-> c:?Xl {} } )
  ]
  mixed = [

  ]
  rightside = [
?PrepR {
  <=> ?Xl
  slex = ?prep
  //  added_prep = ?prep
//  lemma = ?prep
  pos = "IN"
  spos = preposition
//  id=?Xl.id
  top = yes
  random = #randInt()#
  PMOD-> ?Xr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma=?Xl.lemma
    pos=?Xl.pos
//    spos=?Xl.spos
//    id=?Xl.id
//    number=?Xl.number
    bottom = yes
    Locin = "yes"
  }
}
  ]
]

/* to eat */
DSynt<=>SSynt EN_transfer_node_TO : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  ¬c:voice="PASS"
  ¬c:tem_constituency=?t
  c:finiteness="INF"
}

language.id.iso.EN

// if in the lexicon there is already a "to", don't add this one
¬ ( c:?Y1l { c:lex = ?lex1 c:?r1-> c:?Xl {} }
 & lexicon.?lex1.gp.?r1.prep.?to1 & ?to1 == "to"
)
// if the node above is already a "to" don't add another one
¬ ( c:?Y2l {c:lex = "to_IN_01" c:?r2-> c:?Xl {} } )
// if in the lexicon there is an infinitive argument without preposition
// complementary rule missing?? check this condition when there is an input.
// ¬ ( c:?Y2l { c:lex = ?lex2 c:?r2-> c:?Xl {} }
// & lexicon.?lex2.gp.?r2.finiteness.?f & ?f == "INF"
// & ¬ lexicon.?lex2.gp.?r2.prep.?to2
//)

// see in_governed_II_pass
¬( c:?Gov {c:voice = "PASS" c:lex = ?lex2 c:II-> ?Xl {} } & lexicon.?lex2.gp.II.prep.?to1 )
  ]
  mixed = [

  ]
  rightside = [
?GovR {
  <=> ?Xl
  slex="to"
//  lemma = "to"
  pos = "IN"
  spos = "preposition"
  top = yes
  IM-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness = "INF"
    bottom = yes
  }
}
  ]
]

/*should eat*/
DSynt<=>SSynt EN_transfer_node_MODAL : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  ¬c:voice="PASS"
  ¬c:tem_constituency=?t
  ¬c:finiteness = "INF"
  modality = ?mod
  modality_type = ?mt
}

language.id.iso.EN
lexicon.modality.?mod.?mt.?lex

( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  )
                  c:?rds-> ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" ) }} & lexicon.?lex2.gp.?r2.prep )

// the clause is not interrogative with modality DES, TEN or APP (those verbs need DO support - see EN_transfer_node_DO_interrogative_MODAL)
¬( ?Xl.clause_type == "INT" & ( ?mod == "DES" | ?mod == "TEN" | ?mod == "APP" ) )
  ]
  mixed = [

  ]
  rightside = [
?GovR {
  <=> ?Xl
  slex = ?lex
  lex = #?lex+_MD_01#
//  lemma = "to"
  pos = "MD"
  spos = auxiliary
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top = yes
  VC-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness = "INF"
    bottom = yes
  }
}
  ]
]

/*PREP [how] should eat
!!! ALL other MODAL rules are missing !!! (combinations with other auxiliaries)

RULE NOT TESTED*/
DSynt<=>SSynt EN_transfer_node_MODAL_IN_governed : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  ¬c:voice="PASS"
  ¬c:tem_constituency=?t
  //¬c:finiteness = "INF"
  modality = ?mod
  modality_type = ?mt
}

language.id.iso.EN
lexicon.modality.?mod.?mt.?lex

¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  ) c:?rds-> ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )

// there is a governed preposition
( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" | c:pos = "JJ" ) }} & lexicon.?lex2.gp.?r2.prep.?prep )

// see transfer_node_TO
( ¬?Xl.finiteness == "INF" | ?prep == "to" )
  ]
  mixed = [

  ]
  rightside = [
?PrepR {
  <=> ?Xl
  slex = ?prep
  //  added_prep = ?prep
//  lemma = ?prep
  pos = "IN"
  spos = preposition
//  id=?Xl.id
  top = yes
  random = #randInt()#
  PMOD-> ?GovR {
    <=> ?Xl
    slex = ?lex
  //  lemma = "to"
    pos = "MD"
    spos = auxiliary
    tense=?Xl.tense
    finiteness=?Xl.finiteness
    middle = yes
    VC-> ?Yr {
      <=> ?Xl
      slex=?Xl.dlex
  //    lemma = ?Xl.lemma
      pos = "VB"
  //    spos=?Xl.spos
  //    id=?Xl.id
      finiteness = "INF"
      bottom = yes
    }
  }
}
  ]
]

/* that [he] eats */
DSynt<=>SSynt EN_transfer_node_THAT : EN_transfer_node_multi_corresp
[
  leftside = [
c:?Yl {
  ¬c:blocked = "YES"
  ¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that" )
  c:?r-> ?Xl {
    ¬voice="PASS"
    ¬tem_constituency=?t
    ¬modality=?m
    c:finiteness="FIN"
  }
}

language.id.iso.EN

( ?r == II | ?r == III | ?r == IV )

// see do_neg_that, unless node is "be"
( ?Xl { ( ¬ c:ATTR-> c:?Neg {c:dlex = "not" } | c:dlex = "be" ) } )
// there isn't already a conjunctive pronoun below
( ?Xl { ¬ c:?rWP-> c:?WP {c:pos = "WP" } } )

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="that"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  SUB-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
  //  lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    tense=?Xl.tense
    finiteness="FIN"
    bottom=yes
  }
}
  ]
]

/* that [he] should eat */
DSynt<=>SSynt EN_transfer_node_THAT_MODAL : EN_transfer_node_multi_corresp
[
  leftside = [
c:?Yl {
  ¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that" )
  c:?r-> ?Xl {
    ¬voice="PASS"
    ¬tem_constituency=?t
    modality = ?mod
    modality_type = ?mt
    c:finiteness="FIN"
  }
}

language.id.iso.EN
lexicon.modality.?mod.?mt.?lexM

( ?r == II | ?r == III | ?r == IV )

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }

// there isn't already a conjunctive pronoun below
( ?Xl { ¬ c:?rWP-> c:?WP {c:pos = "WP" } } )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="that"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  SUB-> ?ModalR {
    <=> ?Xl
    slex = ?lexM
  //  lemma = "to"
    pos = "MD"
    spos = auxiliary
    tense=?Xl.tense
    finiteness=?Xl.finiteness
    middle = yes
    VC-> ?Yr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
  //    spos=?Xl.spos
  //    id=?Xl.id
      finiteness="INF"
      bottom=yes
    }
  }
}
  ]
]

/* has eaten*/
DSynt<=>SSynt EN_transfer_node_PERF : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PERF"
  ¬voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  )
                  c:?rds-> ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.EN

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="have"
  lex = "have_VB_01"
//  lemma="have"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  VC-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma=?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness="PART"
    bottom=yes
  }
}
  ]
]

/* should have eaten*/
DSynt<=>SSynt EN_transfer_node_PERF_MODAL : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PERF"
  ¬voice="PASS"
  ¬finiteness="INF"
  modality = ?mod
  modality_type = ?mt
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  )
                  c:?rds-> ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.EN
lexicon.modality.?mod.?mt.?lexM

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?ModalR {
  <=> ?Xl
  slex = ?lexM
  lex = #?lexM+_MD_01#
  pos = "MD"
  spos = auxiliary
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top = yes
  VC-> ?Xr {
    <=> ?Xl
    slex="have"
  //  lemma="have"
    pos = "VB"
    spos=auxiliary
  //  id=?Xl.id
    finiteness= "INF"
    middle=yes
    VC-> ?Yr {
      <=> ?Xl
      slex=?Xl.dlex
  //    lemma=?Xl.lemma
      pos = "VB"
  //    spos=?Xl.spos
  //    id=?Xl.id
      finiteness="PART"
      bottom=yes
    }
  }
}
  ]
]

/* has been eaten */
DSynt<=>SSynt EN_transfer_node_PERF_PASS : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  // if prefprogr, simplify to perf, no? PTB_train_14564
  ( tem_constituency="PERF" | tem_constituency="PERFPROGR" )
  voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  )
                  c:?rds-> ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.EN

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="have"
  lex = "have_VB_01"
//  lemma = "have"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  VC-> ?Yr {
    <=> ?Xl
    slex="be"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="PART"
    middle=yes
    VC-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="PART"
      bottom=yes
    }
  }
}
  ]
]

/* should have been eaten */
DSynt<=>SSynt EN_transfer_node_PERF_PASS_MODAL : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  // if prefprogr, simplify to perf, no? PTB_train_14564
  ( tem_constituency="PERF" | tem_constituency="PERFPROGR" )
  voice="PASS"
  ¬finiteness="INF"
  modality = ?mod
  modality_type = ?mt
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  )
                  c:?rds-> ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.EN
lexicon.modality.?mod.?mt.?lexM

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?ModalR {
  <=> ?Xl
  slex = ?lexM
  lex = #?lexM+_MD_01#
  pos = "MD"
  spos = auxiliary
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top = yes
  VC-> ?Xr {
    <=> ?Xl
    slex="have"
  //  lemma = "have"
    pos = "VB"
    spos=auxiliary
  //  id=?Xl.id
    finiteness="INF"
    middle=yes
    VC-> ?Yr {
      <=> ?Xl
      slex="be"
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
  //    id=?Xl.id
      finiteness="PART"
      middle=yes
      VC-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
  //      spos=?Xl.spos
  //      id=?Xl.id
        finiteness="PART"
        bottom=yes
      }
    }
  }
}
  ]
]

/* to have eaten */
DSynt<=>SSynt EN_transfer_node_PERF_TO : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PERF"
  ¬voice="PASS"
  finiteness="INF"
}
¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III | ?rds == IV) )

language.id.iso.EN

// if in the lexicon there is already a "to", don't add this one
¬ ( c:?Y1l { c:lex = ?lex1 c:?r1-> c:?Xl {} }
 & lexicon.?lex1.gp.?r1.prep.?to1 & ?to1 == "to"
)
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="to"
//  lemma = "to"
  pos = "IN"
  spos=preposition
//  id=?Xl.id
  top=yes
  IM-> ?Yr {
    <=> ?Xl
    slex="have"
  //  lemma = "have"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="INF"
    middle=yes
    VC-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="PART"
      bottom=yes
    }
  }
}
  ]
]

/* that [he] has eaten */
DSynt<=>SSynt EN_transfer_node_PERF_THAT : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PERF"
  finiteness="FIN"
  ¬voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  ) c:?rds-> ?Xl { ¬ c:?rWP-> c:?WP {c:pos = "WP" } } }
 & (?rds == II | ?rds == III | ?rds == IV) )

language.id.iso.EN

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="that"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  SUB-> ?Yr {
    <=> ?Xl
    slex="have"
  //  lemma = "have"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense=?Xl.tense
    middle=yes
    VC-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="PART"
      bottom=yes
    }
  }
}
  ]
]

/* that [he] should have eaten */
DSynt<=>SSynt EN_transfer_node_PERF_THAT_MODAL : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PERF"
  finiteness="FIN"
  ¬voice="PASS"
  ¬finiteness="INF"
  modality = ?mod
  modality_type = ?mt
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  ) c:?rds-> ?Xl { ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )

language.id.iso.EN
lexicon.modality.?mod.?mt.?lexM

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="that"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  SUB->  ?ModalR {
    <=> ?Xl
    slex = ?lexM
  //  lemma = "to"
    pos = "MD"
    spos = auxiliary
    tense=?Xl.tense
    finiteness=?Xl.finiteness
    middle = yes
    VC-> ?Yr {
      <=> ?Xl
      slex="have"
    //  lemma = "have"
      pos = "VB"
      spos=auxiliary
  //    id=?Xl.id
      finiteness="INF"
      middle=yes
      VC-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
  //      spos=?Xl.spos
  //      id=?Xl.id
        finiteness="PART"
        bottom=yes
      }
    }
  }
}
  ]
]

/*PREP [how] has eaten

RULE NOT TESTED*/
DSynt<=>SSynt EN_transfer_node_PERF_IN_governed : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PERF"
  ¬voice="PASS"
  //¬finiteness="INF"
}
¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  ) c:?rds-> ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )

language.id.iso.EN

// there is a governed preposition
( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" | c:pos = "JJ" ) }} & lexicon.?lex2.gp.?r2.prep.?prep )

// see transfer_node_TO
( ¬?Xl.finiteness == "INF" | ?prep == "to" )
  ]
  mixed = [

  ]
  rightside = [
?PrepR {
  <=> ?Xl
  slex = ?prep
  //  added_prep = ?prep
//  lemma = ?prep
  pos = IN
  spos = preposition
//  id=?Xl.id
  top = yes
  random = #randInt()#
  PMOD-> ?Xr {
    <=> ?Xl
    slex="have"
  //  lemma="have"
    pos = "VB"
    spos=auxiliary
  //  id=?Xl.id
    tense=?Xl.tense
    finiteness=?Xl.finiteness
    middle=yes
    VC-> ?Yr {
      <=> ?Xl
      slex=?Xl.dlex
  //    lemma=?Xl.lemma
      pos = "VB"
  //    spos=?Xl.spos
  //    id=?Xl.id
      finiteness="PART"
      bottom=yes
    }
  }
}
  ]
]

/* to have been eaten */
DSynt<=>SSynt EN_transfer_node_PERF_PASS_TO : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  // if prefprogr, simplify to perf, no? PTB_train_14564
  ( tem_constituency="PERF" | tem_constituency="PERFPROGR" )
  voice="PASS"
  finiteness="INF"
}
¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III | ?rds == IV) )

language.id.iso.EN

// if in the lexicon there is already a "to", don't add this one
¬ ( c:?Y1l { c:lex = ?lex1 c:?r1-> c:?Xl {} }
 & lexicon.?lex1.gp.?r1.prep.?to1 & ?to1 == "to"
)
  ]
  mixed = [

  ]
  rightside = [
?Wr {
    <=> ?Xl 
  slex="to"
//  lemma = "to"
  pos = "IN"
  spos=preposition
//  id=?Xl.id
  top=yes
  IM-> ?Xr {
    <=> ?Xl
    slex="have"
  //  lemma = "have"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="INF"
    middle=yes
    VC-> ?Yr {
      <=> ?Xl
      slex="be"
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
//      id=?Xl.id
      finiteness="PART"
      middle=yes
      VC-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
//        spos=?Xl.spos
//        id=?Xl.id
        finiteness="PART"
        bottom=yes
      }
    }
  }
}
  ]
]

/* that [he] has been eaten */
DSynt<=>SSynt EN_transfer_node_PERF_PASS_THAT : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  // if prefprogr, simplify to perf, no? PTB_train_14564
  ( tem_constituency="PERF" | tem_constituency="PERFPROGR" )
  finiteness="FIN"
  voice="PASS"
  ¬finiteness="INF"
  ¬modality = ?m
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  ) c:?rds-> ?Xl { ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )

language.id.iso.EN

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Wr {
    <=> ?Xl 
  slex="that"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  SUB-> ?Xr {
    <=> ?Xl
    slex="have"
  //  lemma = "have"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense=?Xl.tense
    middle=yes
    VC-> ?Yr {
      <=> ?Xl
      slex="be"
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
//      id=?Xl.id
      finiteness="PART"
      middle=yes
      VC-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
//        spos=?Xl.spos
//        id=?Xl.id
        finiteness="PART"
        bottom=yes
      }
    }
  }
}
  ]
]

/* that [he] should have been eaten */
DSynt<=>SSynt EN_transfer_node_PERF_PASS_THAT_MODAL : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  // if prefprogr, simplify to perf, no? PTB_train_14564
  ( tem_constituency="PERF" | tem_constituency="PERFPROGR" )
  finiteness="FIN"
  voice="PASS"
  ¬finiteness="INF"
  modality = ?mod
  modality_type = ?mt
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  ) c:?rds-> ?Xl { ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )

language.id.iso.EN
lexicon.modality.?mod.?mt.?lexM

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Wr {
    <=> ?Xl 
  slex="that"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  SUB->  ?ModalR {
    <=> ?Xl
    slex = ?lexM
  //  lemma = "to"
    pos = "MD"
    spos = auxiliary
    tense=?Xl.tense
    finiteness=?Xl.finiteness
    middle = yes
    VC-> ?Xr {
      <=> ?Xl
      slex="have"
    //  lemma = "have"
      pos = "VB"
      spos=auxiliary
  //    id=?Xl.id
      finiteness="INF"
      middle=yes
      VC-> ?Yr {
        <=> ?Xl
        slex="be"
      //  lemma = "be"
        pos = "VB"
        spos=auxiliary
  //      id=?Xl.id
        finiteness="PART"
        middle=yes
        VC-> ?Zr {
          <=> ?Xl
          slex=?Xl.dlex
        //  lemma = ?Xl.lemma
          pos = "VB"
  //        spos=?Xl.spos
  //        id=?Xl.id
          finiteness="PART"
          bottom=yes
        }
      }
    }
  }
}
  ]
]

/*PREP [how] has been eaten 

RULE NOT TESTED*/
DSynt<=>SSynt EN_transfer_node_PERF_PASS_IN_governed : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  // if prefprogr, simplify to perf, no? PTB_train_14564
  ( tem_constituency="PERF" | tem_constituency="PERFPROGR" )
  voice="PASS"
  //¬finiteness="INF"
}
¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  ) c:?rds-> ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )

language.id.iso.EN

// there is a governed preposition
( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" | c:pos = "JJ" ) }} & lexicon.?lex2.gp.?r2.prep.?prep )

// see transfer_node_TO
( ¬?Xl.finiteness == "INF" | ?prep == "to" )
  ]
  mixed = [

  ]
  rightside = [
?PrepR {
  <=> ?Xl
  slex = ?prep
  //  added_prep = ?prep
//  lemma = ?prep
  pos = "IN"
  spos = preposition
//  id=?Xl.id
  top = yes
  random = #randInt()#
  PMOD-> ?Xr {
    <=> ?Xl
    slex="have"
  //  lemma = "have"
    pos = "VB"
    spos=auxiliary
  //  id=?Xl.id
    tense=?Xl.tense
    finiteness=?Xl.finiteness
    middle=yes
    VC-> ?Yr {
      <=> ?Xl
      slex="be"
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
  //    id=?Xl.id
      finiteness="PART"
      middle=yes
      VC-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
  //      spos=?Xl.spos
  //      id=?Xl.id
        finiteness="PART"
        bottom=yes
      }
    }
  }
}
  ]
]

/* is eating */
DSynt<=>SSynt EN_transfer_node_PROGR : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  ¬voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  )
                  c:?rds-> ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.EN

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="be"
  lex = "be_VB_01"
//  lemma = "be"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  VC-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
  //  lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness="GER"
    bottom=yes
  }
}
  ]
]

/* should be eating */
DSynt<=>SSynt EN_transfer_node_PROGR_MODAL : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  ¬voice="PASS"
  ¬finiteness="INF"
  modality = ?mod
  modality_type = ?mt
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  )
                 c:?rds-> ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.EN
lexicon.modality.?mod.?mt.?lexM

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?ModalR {
  <=> ?Xl
  slex = ?lexM
  lex = #?lexM+_MD_01#
  pos = "MD"
  spos = auxiliary
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top = yes
  VC-> ?Xr {
    <=> ?Xl
    slex="be"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
  //  id=?Xl.id
    finiteness="INF"
    middle=yes
    VC-> ?Yr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
  //    spos=?Xl.spos
  //    id=?Xl.id
      finiteness="GER"
      bottom=yes
    }
  }
}
  ]
]

/* is being eaten */
DSynt<=>SSynt EN_transfer_node_PROGR_PASS : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  )
                  c:?rds-> ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.EN

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="be"
  lex = "be_VB_01"
//  lemma = "be"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  VC-> ?Yr {
    <=> ?Xl
    slex="be"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="GER"
    middle=yes
    VC-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="PART"
      bottom=yes
    }
  }
}
  ]
]

/* should be being eaten */
DSynt<=>SSynt EN_transfer_node_PROGR_PASS_MODAL : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  voice="PASS"
  ¬finiteness="INF"
  modality = ?mod
  modality_type = ?mt
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  )
                  c:?rds-> ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.EN
lexicon.modality.?mod.?mt.?lexM

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?ModalR {
  <=> ?Xl
  slex = ?lexM
  lex = #?lexM+_MD_01#
  pos = "MD"
  spos = auxiliary
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top = yes
  VC-> ?Xr {
    <=> ?Xl
    slex="be"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
  //  id=?Xl.id
    finiteness="INF"
    middle=yes
    VC-> ?Yr {
      <=> ?Xl
      slex="be"
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
  //    id=?Xl.id
      finiteness="GER"
      middle=yes
      VC-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
  //      spos=?Xl.spos
  //      id=?Xl.id
        finiteness="PART"
        bottom=yes
      }
    }
  }
}
  ]
]

/* to be eating */
DSynt<=>SSynt EN_transfer_node_PROGR_TO : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  ¬voice="PASS"
  finiteness="INF"
}
¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III | ?rds == IV) )

language.id.iso.EN

// if in the lexicon there is already a "to", don't add this one
¬ ( c:?Y1l { c:lex = ?lex1 c:?r1-> c:?Xl {} }
 & lexicon.?lex1.gp.?r1.prep.?to1 & ?to1 == "to"
)
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="to"
//  lemma = "to"
  pos = "IN"
  spos=preposition
//  id=?Xl.id
  top=yes
  IM-> ?Yr {
    <=> ?Xl
    slex="be"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="INF"
    middle=yes
    VC-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="GER"
      bottom=yes
    }
  }
}
  ]
]

/* that [he] is eating */
DSynt<=>SSynt EN_transfer_node_PROGR_THAT : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  finiteness="FIN"
  ¬voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  ) c:?rds-> ?Xl { ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )

language.id.iso.EN

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="that"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  SUB-> ?Yr {
    <=> ?Xl
    slex="be"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense=?Xl.tense
    middle=yes
    VC-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="GER"
      bottom=yes
    }
  }
}
  ]
]

/* that [he] should be eating */
DSynt<=>SSynt EN_transfer_node_PROGR_THAT_MODAL : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  finiteness="FIN"
  ¬voice="PASS"
  ¬finiteness="INF"
  modality = ?mod
  modality_type = ?mt
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  ) c:?rds-> ?Xl { ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )

language.id.iso.EN
lexicon.modality.?mod.?mt.?lexM

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="that"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  SUB->  ?ModalR {
    <=> ?Xl
    slex = ?lexM
  //  lemma = "to"
    pos = "MD"
    spos = auxiliary
    tense=?Xl.tense
    finiteness=?Xl.finiteness
    middle = yes
    VC-> ?Yr {
      <=> ?Xl
      slex="be"
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
  //    id=?Xl.id
      finiteness="INF"
      middle=yes
      VC-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
  //      spos=?Xl.spos
  //      id=?Xl.id
        finiteness="GER"
        bottom=yes
      }
    }
  }
}
  ]
]

/*PREP [how] is eating 
PTB_eval_85
RULE NOT TESTED
*/
DSynt<=>SSynt EN_transfer_node_PROGR_IN_governed : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  ¬voice="PASS"
  //¬finiteness="INF"
}
¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  ) c:?rds-> ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )

language.id.iso.EN

// there is a governed preposition
( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" | c:pos = "JJ" ) }} & lexicon.?lex2.gp.?r2.prep.?prep )

// see transfer_node_TO
( ¬?Xl.finiteness == "INF" | ?prep == "to" )
  ]
  mixed = [

  ]
  rightside = [
?PrepR {
  <=> ?Xl
  slex = ?prep
  //  added_prep = ?prep
//  lemma = ?prep
  pos = "IN"
  spos = preposition
//  id=?Xl.id
  top = yes
  random = #randInt()#
  PMOD-> ?Xr {
    <=> ?Xl
    slex="be"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
  //  id=?Xl.id
    tense=?Xl.tense
    finiteness=?Xl.finiteness
    middle=yes
    VC-> ?Yr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
  //    spos=?Xl.spos
  //    id=?Xl.id
      finiteness="GER"
      bottom=yes
    }
  }
}
  ]
]

/* to have been eating */
DSynt<=>SSynt EN_transfer_node_PROGR_PASS_TO : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  voice="PASS"
  finiteness="INF"
}
¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III | ?rds == IV) )

language.id.iso.EN

// if in the lexicon there is already a "to", don't add this one
¬ ( c:?Y1l { c:lex = ?lex1 c:?r1-> c:?Xl {} }
 & lexicon.?lex1.gp.?r1.prep.?to1 & ?to1 == "to"
)
  ]
  mixed = [

  ]
  rightside = [
?Wr {
    <=> ?Xl 
  slex="to"
//  lemma = "to"
  pos = "IN"
  spos=preposition
//  id=?Xl.id
  top=yes
  IM-> ?Xr {
    <=> ?Xl
    slex="have"
  //  lemma = "have"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="INF"
    middle=yes
    VC-> ?Yr {
      <=> ?Xl
      slex="be"
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
//      id=?Xl.id
      finiteness="PART"
      middle=yes
      VC-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
//        spos=?Xl.spos
//        id=?Xl.id
        finiteness="GER"
        bottom=yes
      }
    }
  }
}
  ]
]

/* that [he] is being eaten */
DSynt<=>SSynt EN_transfer_node_PROGR_PASS_THAT : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  finiteness="FIN"
  voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  ) c:?rds-> ?Xl { ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )

language.id.iso.EN

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Wr {
    <=> ?Xl 
  slex="that"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  SUB-> ?Xr {
    <=> ?Xl
    slex="be"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense=?Xl.tense
    middle=yes
    VC-> ?Yr {
      <=> ?Xl
      slex="be"
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
//      id=?Xl.id
      finiteness="GER"
      middle=yes
      VC-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
//        spos=?Xl.spos
//        id=?Xl.id
        finiteness="PART"
        bottom=yes
      }
    }
  }
}
  ]
]

/* that [he] should be being eaten */
DSynt<=>SSynt EN_transfer_node_PROGR_PASS_THAT_MODAL : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  finiteness="FIN"
  voice="PASS"
  ¬finiteness="INF"
  modality = ?mod
  modality_type = ?mt
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  ) c:?rds-> ?Xl { ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )

language.id.iso.EN
lexicon.modality.?mod.?mt.?lexM

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Wr {
    <=> ?Xl 
  slex="that"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  SUB->  ?ModalR {
    <=> ?Xl
    slex = ?lexM
  //  lemma = "to"
    pos = "MD"
    spos = auxiliary
    tense=?Xl.tense
    finiteness=?Xl.finiteness
    middle = yes
    VC-> ?Xr {
      <=> ?Xl
     slex="be"
     //  lemma = "be"
      pos = "VB"
      spos=auxiliary
  //    id=?Xl.id
      finiteness="INF"
      middle=yes
      VC-> ?Yr {
        <=> ?Xl
        slex="be"
      //  lemma = "be"
        pos = "VB"
        spos=auxiliary
  //      id=?Xl.id
        finiteness="GER"
        middle=yes
        VC-> ?Zr {
          <=> ?Xl
          slex=?Xl.dlex
        //  lemma = ?Xl.lemma
          pos = "VB"
  //        spos=?Xl.spos
  //        id=?Xl.id
          finiteness="PART"
          bottom=yes
        }
      }
    }
  }
}
  ]
]

/*PREP [how] is being eaten 

RULE NOT TESTED*/
DSynt<=>SSynt EN_transfer_node_PROGR_PASS_IN_governed : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  voice="PASS"
  //¬finiteness="INF"
}
¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  ) c:?rds-> ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )

language.id.iso.EN

// there is a governed preposition
( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" | c:pos = "JJ" ) }} & lexicon.?lex2.gp.?r2.prep.?prep )

// see transfer_node_TO
( ¬?Xl.finiteness == "INF" | ?prep == "to" )
  ]
  mixed = [

  ]
  rightside = [
?PrepR {
  <=> ?Xl
  slex = ?prep
  //  added_prep = ?prep
//  lemma = ?prep
  pos = "IN"
  spos = preposition
//  id=?Xl.id
  top = yes
  random = #randInt()#
  PMOD-> ?Xr {
    <=> ?Xl
    slex="be"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
  //  id=?Xl.id
    tense=?Xl.tense
    finiteness=?Xl.finiteness
    middle=yes
    VC-> ?Yr {
      <=> ?Xl
      slex="be"
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
  //    id=?Xl.id
      finiteness="GER"
      middle=yes
      VC-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
  //      spos=?Xl.spos
  //      id=?Xl.id
        finiteness="PART"
        bottom=yes
      }
    }
  }
}
  ]
]

/* has been eating */
DSynt<=>SSynt EN_transfer_node_PERFPROGR : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PERFPROGR"
  ¬voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  )
                 c:?rds-> ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.EN

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="have"
  lex = "have_VB_01"
//  lemma = "have"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  VC-> ?Yr {
    <=> ?Xl
    slex="be"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="PART"
    middle=yes
    VC-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="GER"
      bottom=yes
    }
  }
}
  ]
]

/* should have been eating */
DSynt<=>SSynt EN_transfer_node_PERFPROGR_MODAL : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PERFPROGR"
  ¬voice="PASS"
  ¬finiteness="INF"
  modality = ?mod
  modality_type = ?mt
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  )
                  c:?rds-> ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.EN
lexicon.modality.?mod.?mt.?lexM

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?ModalR {
  <=> ?Xl
  slex = ?lexM
  lex = #?lexM+_MD_01#
  pos = "MD"
  spos = auxiliary
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top = yes
  VC-> ?Xr {
    <=> ?Xl
    slex="have"
  //  lemma = "have"
    pos = "VB"
    spos=auxiliary
  //  id=?Xl.id
    finiteness="INF"
    middle=yes
    VC-> ?Yr {
      <=> ?Xl
      slex="be"
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
  //    id=?Xl.id
      finiteness="PART"
      middle=yes
      VC-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
  //      spos=?Xl.spos
  //      id=?Xl.id
        finiteness="GER"
        bottom=yes
      }
    }
  }
}
  ]
]

/* to have been eating */
DSynt<=>SSynt EN_transfer_node_PERFPROGR_TO : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PERFPROGR"
  ¬voice="PASS"
  finiteness="INF"
}
¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III | ?rds == IV) )

language.id.iso.EN

// if in the lexicon there is already a "to", don't add this one
¬ ( c:?Y1l { c:lex = ?lex1 c:?r1-> c:?Xl {} }
 & lexicon.?lex1.gp.?r1.prep.?to1 & ?to1 == "to"
)
  ]
  mixed = [

  ]
  rightside = [
?Wr {
    <=> ?Xl 
  slex="to"
//  lemma = "to"
  pos = "IN"
  spos=preposition
//  id=?Xl.id
  top=yes
  IM-> ?Xr {
    <=> ?Xl
    slex="have"
  //  lemma = "have"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="INF"
    middle=yes
    VC-> ?Yr {
      <=> ?Xl
      slex="be"
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
//      id=?Xl.id
      finiteness="PART"
      middle=yes
      VC-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
//        spos=?Xl.spos
//        id=?Xl.id
        finiteness="GER"
        bottom=yes
      }
    }
  }
}
  ]
]

/* that [he] has been eating */
DSynt<=>SSynt EN_transfer_node_PERFPROGR_THAT : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PERFPROGR"
  finiteness="FIN"
  ¬voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  ) c:?rds-> ?Xl { ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )

language.id.iso.EN

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Wr {
    <=> ?Xl 
  slex="that"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  SUB-> ?Xr {
    <=> ?Xl
    slex="have"
  //  lemma = "have"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    tense=?Xl.tense
    finiteness="FIN"
    middle=yes
    VC-> ?Yr {
      <=> ?Xl
      slex="be"
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
//      id=?Xl.id
      finiteness="PART"
      middle=yes
      VC-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
//        spos=?Xl.spos
//        id=?Xl.id
        finiteness="GER"
        bottom=yes
      }
    }
  }
}
  ]
]

/* that [he] should have been eating */
DSynt<=>SSynt EN_transfer_node_PERFPROGR_THAT_MODAL : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PERFPROGR"
  finiteness="FIN"
  ¬voice="PASS"
  ¬finiteness="INF"
  modality = ?mod
  modality_type = ?mt
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  ) c:?rds-> ?Xl { ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )

language.id.iso.EN
lexicon.modality.?mod.?mt.?lexM

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Wr {
    <=> ?Xl 
  slex="that"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  SUB->  ?ModalR {
    <=> ?Xl
    slex = ?lexM
  //  lemma = "to"
    pos = "MD"
    spos = auxiliary
    tense=?Xl.tense
    finiteness=?Xl.finiteness
    middle = yes
    VC-> ?Xr {
      <=> ?Xl
      slex="have"
    //  lemma = "have"
      pos = "VB"
      spos=auxiliary
  //    id=?Xl.id
      finiteness="INF"
      middle=yes
      VC-> ?Yr {
        <=> ?Xl
        slex="be"
      //  lemma = "be"
        pos = "VB"
        spos=auxiliary
  //      id=?Xl.id
        finiteness="PART"
        middle=yes
        VC-> ?Zr {
          <=> ?Xl
          slex=?Xl.dlex
        //  lemma = ?Xl.lemma
          pos = "VB"
  //        spos=?Xl.spos
  //        id=?Xl.id
          finiteness="GER"
          bottom=yes
        }
      }
    }
  }
}
  ]
]

/*PREP [how] has been eating 

RULE NOT TESTED*/
DSynt<=>SSynt EN_transfer_node_PERFPROGR_IN_governed : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PERFPROGR"
  ¬voice="PASS"
  //¬finiteness="INF"
}
¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  ) c:?rds-> ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )

language.id.iso.EN

// there is a governed preposition
( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" | c:pos = "JJ" ) }} & lexicon.?lex2.gp.?r2.prep.?prep )

// see transfer_node_TO
( ¬?Xl.finiteness == "INF" | ?prep == "to" )
  ]
  mixed = [

  ]
  rightside = [
?PrepR {
  <=> ?Xl
  slex = ?prep
  //  added_prep = ?prep
//  lemma = ?prep
  pos = IN
  spos = preposition
//  id=?Xl.id
  top = yes
  random = #randInt()#
  PMOD-> ?Xr {
    <=> ?Xl
    slex="have"
  //  lemma = "have"
    pos = "VB"
    spos=auxiliary
  //  id=?Xl.id
    tense=?Xl.tense
    finiteness=?Xl.finiteness
    middle=yes
    VC-> ?Yr {
      <=> ?Xl
      slex="be"
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
  //    id=?Xl.id
      finiteness="PART"
      middle=yes
      VC-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
  //      spos=?Xl.spos
  //      id=?Xl.id
        finiteness="GER"
        bottom=yes
      }
    }
  }
}
  ]
]

/*is eaten */
DSynt<=>SSynt EN_transfer_node_PASS : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  voice="PASS"
  ¬tem_constituency=?t
  ¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  )
                  c:?rds-> ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.EN

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="be"
//  lemma = "be"
  pos = "VB"
  // test (lex needed for aggregation)
  lex = "be_VB_01"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  VC-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
  //  lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness="PART"
    bottom=yes
  }
}
  ]
]

/*should be eaten */
DSynt<=>SSynt EN_transfer_node_PASS_MODAL : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  voice="PASS"
  ¬tem_constituency=?t
  ¬finiteness="INF"
  modality = ?mod
  modality_type = ?mt
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  )
                  c:?rds-> ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.EN
lexicon.modality.?mod.?mt.?lexM
//lexicon.?lexM.lemma.?lemMod

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?ModalR {
  <=> ?Xl
  slex = ?lexM
  lex = #?lexM+_MD_01#
  pos = "MD"
  spos = auxiliary
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top = yes
  VC-> ?Xr {
    <=> ?Xl
    slex="be"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
  //  id=?Xl.id
    finiteness="INF"
    middle=yes
    VC-> ?Yr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
  //    spos=?Xl.spos
  //    id=?Xl.id
      finiteness="PART"
      bottom=yes
    }
  }
}
  ]
]

/* to be eaten */
DSynt<=>SSynt EN_transfer_node_PASS_TO : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  voice="PASS"
  ¬tem_constituency=?t
  finiteness="INF"
}
¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III | ?rds == IV) )

language.id.iso.EN

// if in the lexicon there is already a "to", don't add this one
¬ ( c:?Y1l { c:lex = ?lex1 c:?r1-> c:?Xl {} }
 & lexicon.?lex1.gp.?r1.prep.?to1 & ?to1 == "to"
)
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="to"
//  lemma = "to"
  pos = "IN"
  spos=preposition
//  id=?Xl.id
  top=yes
  IM-> ?Yr {
    <=> ?Xl
    slex="be"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="INF"
    middle=yes
    VC-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="PART"
      bottom=yes
    }
  }
}
  ]
]

/* that [he] is eaten */
DSynt<=>SSynt EN_transfer_node_PASS_THAT : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  finiteness="FIN"
  voice="PASS"
  ¬tem_constituency=?t
  ¬finiteness="INF"
  ¬modality=?m
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  ) c:?rds-> ?Xl {¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )

language.id.iso.EN

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="that"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  SUB-> ?Yr {
    <=> ?Xl
    slex="be"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense=?Xl.tense
    middle=yes
    VC-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="PART"
      bottom=yes
    }
  }
}
  ]
]

/* that [he] should be eaten */
DSynt<=>SSynt EN_transfer_node_PASS_THAT_MODAL : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  finiteness="FIN"
  voice="PASS"
  ¬tem_constituency=?t
  ¬finiteness="INF"
  modality = ?mod
  modality_type = ?mt
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  ) c:?rds-> ?Xl { ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )

language.id.iso.EN
lexicon.modality.?mod.?mt.?lexM

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="that"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  SUB->  ?ModalR {
    <=> ?Xl
    slex = ?lexM
  //  lemma = "to"
    pos = "MD"
    spos = auxiliary
    tense=?Xl.tense
    finiteness=?Xl.finiteness
    middle = yes
    VC-> ?Yr {
      <=> ?Xl
      slex="be"
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
  //    id=?Xl.id
      finiteness="INF"
      middle=yes
      VC-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
  //      spos=?Xl.spos
  //      id=?Xl.id
        finiteness="PART"
        bottom=yes
      }
    }
  }
}
  ]
]

/* PREP [how] is eaten */
DSynt<=>SSynt EN_transfer_node_PASS_IN_governed : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  voice="PASS"
  ¬tem_constituency=?t
  //¬finiteness="INF"
}
¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  ) c:?rds-> ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )

language.id.iso.EN

// there is a governed preposition
( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" | c:pos = "JJ" ) }} & lexicon.?lex2.gp.?r2.prep.?prep )

// see transfer_node_TO
( ¬?Xl.finiteness == "INF" | ?prep == "to" )
  ]
  mixed = [

  ]
  rightside = [
?PrepR {
  <=> ?Xl
  slex = ?prep
  //  added_prep = ?prep
//  lemma = ?prep
  pos = IN
  spos = preposition
//  id=?Xl.id
  top = yes
  random = #randInt()#
  PMOD-> ?Xr {
    <=> ?Xl
    slex="be"
    //  lemma = "be"
    pos = "VB"
    spos=auxiliary
    //  id=?Xl.id
    tense=?Xl.tense
    finiteness=?Xl.finiteness
    middle=yes
    VC-> ?Yr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
    //    spos=?Xl.spos
    //    id=?Xl.id
      finiteness="PART"
      bottom=yes
    }
  }
  }
  ]
]

/*that [he] does [not] eat*/
DSynt<=>SSynt EN_transfer_node_DO_neg : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  c:pos = "VB"
  ¬tem_constituency=?t
  ¬voice="PASS"
  //¬finiteness="INF"
  //¬finiteness="GER"
  c:finiteness="FIN"
  ¬modality=?m
  ¬c:dlex = "be"
  c:ATTR-> c:?Neg {
    c:dlex = "not"
  }
}
( ¬(c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  )
                c:?rds-> ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" ) }} & lexicon.?lex2.gp.?r2.prep )

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="do"
  lex = "do_VB_01"
//  lemma="do"
  pos = "VB"
  spos = auxiliary
//  id=?Xl.id
  tense = ?Xl.tense
  finiteness = ?Xl.finiteness
  top = yes
  VC-> ?Yr {
    <=> ?Xl
    slex = ?Xl.dlex
//    lemma=?Xl.lemma
    pos = "VB"
//    spos = ?Xl.spos
//    id=?Xl.id
    finiteness = "INF"
    bottom = yes
  }
}
  ]
]

/*does [not] eat*/
DSynt<=>SSynt EN_transfer_node_DO_neg_THAT : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  c:pos = "VB"
  ¬tem_constituency=?t
  ¬voice="PASS"
  //¬finiteness="INF"
  //¬finiteness="GER"
  c:finiteness="FIN"
  ¬modality=?m
  ¬c:dlex = "be"
  c:ATTR-> c:?Neg {
    c:dlex = "not"
  }
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  ) c:?rds-> ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" }}} & (?rds == II | ?rds == III | ?rds == IV) )

language.id.iso.EN

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="that"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  SUB-> ?Yr {
    <=> ?Xl
    slex="do"
  //  lemma = "do"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense=?Xl.tense
    middle=yes
    VC-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="INF"
      bottom=yes
    }
  }
}
  ]
]

/*introduces support verb "do" in interrogatives*/
DSynt<=>SSynt EN_transfer_node_DO_interrogative : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  c:pos = "VB"
  ¬tem_constituency=?t
  ¬voice="PASS"

  c:finiteness="FIN"
  ¬modality=?m
  ¬c:dlex = "be"
  c:clause_type="INT"
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
?DO {
  <=> ?Xl
  slex="do"
  lex = "do_VB_01"
  pos = "VB"
  spos = auxiliary
  tense = ?Xl.tense
  finiteness = ?Xl.finiteness
  top = yes
  VC-> ?Yr {
    <=> ?Xl
    slex = ?Xl.dlex
    pos = "VB"
    finiteness = "INF"
    bottom = yes
  }
}
  ]
]

/*introduces support verb "do" in interrogatives*/
DSynt<=>SSynt EN_transfer_node_DO_interrogative_MODAL : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  c:pos = "VB"
  ¬tem_constituency=?t
  ¬voice="PASS"

  c:finiteness="FIN"
  modality = ?mod
  modality_type = ?modtype

  ¬c:dlex = "be"
  c:clause_type="INT"
}

language.id.iso.EN
lexicon.modality.?mod.?modtype.?lexMod
( ?mod == "DES" | ?mod == "TEN" | ?mod == "APP" )
  ]
  mixed = [

  ]
  rightside = [
?DO {
  <=> ?Xl
  slex="do"
  lex = "do_VB_01"
  pos = "VB"
  spos = auxiliary
  tense = ?Xl.tense
  finiteness = ?Xl.finiteness
  top = yes
  VC-> ?ModalR {
    <=> ?Xl
    slex = ?lexMod
    lex = #?lexMod+_MD_01#
    pos = "MD"
    spos = auxiliary
    finiteness = "INF"    
    middle=yes
    VC-> ?Yr {
      <=> ?Xl
      slex = ?Xl.dlex
      pos = "VB"
      finiteness = "INF"
      bottom = yes
    }  
  }
}
  ]
]

/*is going to eat
DISABLE FOR NOW, replaced by modality "future"*/
excluded DSynt<=>SSynt EN_transfer_node_IMM : EN_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="IMM"
  ¬voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "when" | c:dlex = "which"  ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )

language.id.iso.EN

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="be"
//  lemma="have"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  VC-> ?Z1r {
    <=> ?Xl
    slex="go"
  //  lemma="have"
    pos = "VB"
    spos=auxiliary
  //  id=?Xl.id
    finiteness="GER"
    middle=yes
    VC-> ?Z2r {
      <=> ?Xl
      slex="to"
    //  lemma="have"
      pos = "IN"
      spos=preposition
    //  id=?Xl.id
      middle=yes
      IM-> ?Yr {
        <=> ?Xl
        slex=?Xl.dlex
    //    lemma=?Xl.lemma
        pos = "VB"
    //    spos=?Xl.spos
    //    id=?Xl.id
        finiteness="INF"
        bottom=yes
      }
    }
  }
}
  ]
]

DSynt<=>SSynt ES_transfer_node_IN_governed : ES_transfer_node_multi_corresp
[
  leftside = [
c:?Gov {
  c:lex=?lex
  c:?r-> ?Xl {
    ¬c:voice="PASS"
    ( ¬c:tem_constituency=?tc | c:tem_constituency = "IMP" | c:tem_constituency = "PERF-S" )
    ¬c:modality=?m
    ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" )
  }
}

// In abstractive summarization, sometimes we keep the prepositions
¬ ( c:?Xl { c:subcat_prep = ?spx c:GovLex = ?glx } & ?glx == ?lex )

lexicon.?lex.gp.?r.prep.?prep
¬(?r == I & ?prep == "por" & ¬?Gov.voice == "PASS")

// II will be mapped to a subject
¬(?r == II & ?Gov.voice == "PASS")

language.id.iso.ES

// if the noun is genitive and has a coreference, it will be pronominalized. Only English for now; if activate, test it.
// ¬ ( c:?Xl { c:case = "GEN" c:<-> c:?Antecedent {} } )
  ]
  mixed = [

  ]
  rightside = [
?PrepR {
  <=> ?Xl
  slex = ?prep
  //  added_prep = ?prep
//  lemma = ?prep
  pos = "IN"
  spos = preposition
//  id=?Xl.id
  top = yes
  prepos-> ?Xr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma=?Xl.lemma
    pos=?Xl.pos
//    spos=?Xl.spos
//    id=?Xl.id
//    number=?Xl.number
    bottom = yes
  }
}
  ]
]

DSynt<=>SSynt ES_transfer_node_IN_governed_inStr : ES_transfer_node_multi_corresp
[
  leftside = [
c:?Gov {
  c:lex=?lex
  c:?r-> ?Xl {
    ¬voice="PASS"
    ( ¬c:tem_constituency=?tc | c:tem_constituency = "IMP" | c:tem_constituency = "PERF-S" )
    ¬modality=?m
    ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" | c:pos = "RB" | c:pos = "JJ" )
    subcat_prep = ?spx
    GovLex = ?glx
  }
}

language.id.iso.ES

// In abstractive summarization, sometimes we keep the prepositions
//( ?glx == ?lex | ( c:?Grandma { c:lex = ?lexGrandma c:?rg1-> c:?Gov {} } & ?lexGrandma == ?glx & ?r == APPEND ) )
( ?glx == ?lex
  | ( ¬ ?glx == ?lex & ( c:?Grandma { c:lex = ?lexGrandma c:?rg1-> c:?Gov {} } & ?lexGrandma == ?glx & ( ?r == APPEND | ?Xl.meaning == "ELABORATION"  ) ) )
)

// no "by" unless in a passive contruction (actually BY have been removed from latest version of lexicon)
¬ (?r == I & ?prep == "por" & ¬?Gov.voice == "PASS" )

// II will be mapped to a subject
¬(?r == II & ?Gov.voice == "PASS")

// if the noun is genitive and has a coreference, it will be pronominalized. Only English for now; if activate, test it.
// ¬ ( c:?Xl { c:case = "GEN" c:<-> c:?Antecedent {} } )
  ]
  mixed = [

  ]
  rightside = [
?PrepR {
  <=> ?Xl
  slex = ?spx
  lex = #?spx+_IN_01#
  //  added_prep = ?spx
//  lemma = ?prep
  pos = "IN"
  spos = preposition
//  id=?Xl.id
  top = yes
  random = #randInt()#
  id = #randInt()#
  prepos-> ?Xr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma=?Xl.lemma
    pos=?Xl.pos
//    spos=?Xl.spos
//    id=?Xl.id
//    number=?Xl.number
    bottom = yes
  }
}
  ]
]

/* that [he] eats */
DSynt<=>SSynt ES_transfer_node_THAT : ES_transfer_node_multi_corresp
[
  leftside = [
c:?Yl {
  ¬ ( c:pos = "IN" | c:dlex = "cuando" | c:dlex = "que" )
  c:?r-> ?Xl {
    ¬voice="PASS"
    ( ¬c:tem_constituency=?tc | c:tem_constituency = "IMP" | c:tem_constituency = "PERF-S" )
    ¬modality=?m
    c:finiteness="FIN"
  }
}

language.id.iso.ES

( ?r == II | ?r == III )

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="que"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
  //  lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    tense=?Xl.tense
    finiteness="FIN"
    bottom=yes
  }
}
  ]
]

/*should eat*/
DSynt<=>SSynt ES_transfer_node_MODAL : ES_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  ¬c:voice="PASS"
  ( ¬c:tem_constituency=?tc | c:tem_constituency = "IMP" | c:tem_constituency = "PERF-S" )
  //¬c:finiteness = "INF"
  modality = ?mod
  modality_type = ?mt
}

language.id.iso.ES
lexicon.modality.?mod.?mt.?lex
lexicon.?lex.lemma.?lem

( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "cuando" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?GovR {
  <=> ?Xl
  slex = ?lem
  lex = ?lex
//  lemma = "to"
  pos = "MD"
  spos = modal
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top = yes
  modal-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness = "INF"
    bottom = yes
  }
}
  ]
]

/* that [he] should eat */
DSynt<=>SSynt ES_transfer_node_THAT_MODAL : ES_transfer_node_multi_corresp
[
  leftside = [
c:?Yl {
  ¬ ( c:pos = "IN" | c:dlex = "cuando" | c:dlex = "que" )
  c:?r-> ?Xl {
    ¬voice="PASS"
    ( ¬c:tem_constituency=?tc | c:tem_constituency = "IMP" | c:tem_constituency = "PERF-S" )
    modality = ?mod
    modality_type = ?mt
    c:finiteness="FIN"
  }
}

language.id.iso.ES
lexicon.modality.?mod.?mt.?lexM
lexicon.?lexM.lemma.?lem

( ?r == II | ?r == III )

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="que"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?ModalR {
    <=> ?Xl
    slex = ?lem
    lex = ?lexM
  //  lemma = "to"
    pos = "MD"
    spos = modal
    tense=?Xl.tense
    finiteness=?Xl.finiteness
    middle = yes
    modal-> ?Yr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
  //    spos=?Xl.spos
  //    id=?Xl.id
      finiteness="INF"
      bottom=yes
    }
  }
}
  ]
]

/*is eaten */
DSynt<=>SSynt ES_transfer_node_PASS_aux : ES_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  voice="PASS"
  // Introduce auxiliary if there is a first argument; if not, use "se"; see ES_transfer_node_PASS_se
  // There seems to be a rule that applies to specific verbs that take auxiliary even though they have no first argument.
  // Find list of such verbs and make a more generic rule.
  ( c:I-> c:?Arg1l {} | c:lex = "afectar_VB_01" | c:lex = "conocer_VB_02" | c:lex = "condecorar_VB_01" )
  ( ¬c:tem_constituency=?tc | c:tem_constituency = "IMP" | c:tem_constituency = "PERF-S" )
  //¬finiteness="INF"
  ¬modality=?m
  c:lex = ?lex
}

( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "cuando" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.ES

lexicon.?lex.aux_pass.?aux
lexicon.?aux.lemma.?lem

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex = ?lem
//  lemma = "be"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  analyt_pass-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
  //  lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness="PART"
    bottom=yes
  }
}
  ]
]

DSynt<=>SSynt ES_transfer_node_PASS_se : ES_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  voice="PASS"
  // See ES_transfer_node_PASS_aux
  ¬c:I-> c:?Arg1l {}
  ( ¬c:tem_constituency=?tc | c:tem_constituency = "IMP" | c:tem_constituency = "PERF-S" )
  //¬finiteness="INF"
  ¬modality=?m
  // See ES_transfer_node_PASS_aux
  ¬ c:lex = "afectar_VB_01"
  ¬ c:lex = "conocer_VB_02"
  ¬ c:lex = "condecorar_VB_01"
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "cuando" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.ES

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex = ?Xl.dlex
  pos = "VB"
  aux_refl-> ?se {
    slex = "se"
    pos = "PRP"
    spos = "passive_marker"
    include = bubble_of_gov
  }
}
  ]
]

/*should be eaten */
DSynt<=>SSynt ES_transfer_node_PASS_MODAL_se : ES_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  voice="PASS"
  ¬tem_constituency=?t
  //¬finiteness="INF"
  modality = ?mod
  modality_type = ?mt
}

( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "cuando" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.ES
lexicon.modality.?mod.?mt.?lexM
lexicon.?lexM.lemma.?lem

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?ModalR {
  <=> ?Xl
  slex = ?lem
  lex = ?lexM
  pos = "MD"
  spos = modal
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top = yes
  modal-> ?Xr {
    <=> ?Xl
    slex=?Xl.lemma
    pos = ?Xl.pos
    finiteness="INF"
    bottom=yes
  }
  aux_refl-> ?se {
    slex = "se"
    pos = "PRP"
    spos = "passive_marker"
    include = bubble_of_gov
  }
}
  ]
]

/* that [he] should be eaten 

THIS RULE should go check in the lexicon which is the correct auxiliary for passive.*/
DSynt<=>SSynt ES_transfer_node_PASS_THAT_MODAL : ES_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  finiteness="FIN"
  voice="PASS"
  ( ¬c:tem_constituency=?tc | c:tem_constituency = "IMP" | c:tem_constituency = "PERF-S" )
  ¬finiteness="INF"
  modality = ?mod
  modality_type = ?mt
  c:lex = ?lex
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "cuando" | c:dlex = "que" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.ES
lexicon.modality.?mod.?mt.?lexM
lexicon.?lexM.lemma.?lem

lexicon.?lex.aux_pass.?aux
lexicon.?aux.lemma.?lem2

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="que"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj->  ?ModalR {
    <=> ?Xl
    slex = ?lem
    lex = ?lexM
  //  lemma = "to"
    pos = "MD"
    spos = modal
    tense=?Xl.tense
    finiteness=?Xl.finiteness
    middle = yes
    modal-> ?Yr {
      <=> ?Xl
      slex = ?lem2
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
  //    id=?Xl.id
      finiteness="INF"
      middle=yes
      analyt_pass-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
  //      spos=?Xl.spos
  //      id=?Xl.id
        finiteness="PART"
        bottom=yes
      }
    }
  }
}
  ]
]

/* has eaten*/
DSynt<=>SSynt ES_transfer_node_PERF : ES_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  ( tem_constituency="PERF-C" | tem_constituency="PERF" )
  ¬voice="PASS"
  //¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "cuando" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.ES

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex = "haber"
//  lemma="have"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  analyt_perf-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma=?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness="PART"
    bottom=yes
  }
}
  ]
]

/* that [he] is eating */
DSynt<=>SSynt ES_transfer_node_PERF_THAT : ES_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  ( tem_constituency="PERF-C" | tem_constituency="PERF" )
  finiteness="FIN"
  //¬voice="PASS"
  //¬finiteness="INF"
  ¬modality=?m
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "cuando" | c:dlex = "que" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.ES

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }

( ¬?Xl.voice == "PASS" | ( c:?Xl { c:lex = ?lex3 } & lexicon.?lex3.transitive.no ) )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="que"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?Yr {
    <=> ?Xl
    slex =  "haber"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense=?Xl.tense
    middle=yes
    analyt_perf-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="PART"
      bottom=yes
    }
  }
}
  ]
]

/* has been eaten 

THIS RULE should go check in the lexicon which is the correct auxiliary for passive.*/
DSynt<=>SSynt ES_transfer_node_PERF_PASS_aux : ES_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  // if prefprogr, simplify to perf, no? PTB_train_14564
  ( c:I-> c:?Arg1l {} | c:lex = "afectar_VB_01" | c:lex = "conocer_VB_02" | c:lex = "condecorar_VB_01" )
  ( tem_constituency="PERF-C" | tem_constituency="PERF" | tem_constituency="PERFPROGR" )
  voice="PASS"
  //¬finiteness="INF"
  ¬modality=?m
  c:lex = ?lex
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "cuando" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.ES

lexicon.?lex.aux_pass.?aux
lexicon.?aux.lemma.?lem

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )

//¬ ( c:?Xl { c:lex = ?lex3 } & lexicon.?lex3.transitive.no )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="haber"
//  lemma = "have"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  analyt_perf-> ?Yr {
    <=> ?Xl
    slex =  ?lem
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="PART"
    middle=yes
    analyt_pass-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="PART"
      bottom=yes
    }
  }
}
  ]
]

/* has been eaten 

THIS RULE should go check in the lexicon which is the correct auxiliary for passive.*/
DSynt<=>SSynt ES_transfer_node_PERF_PASS_se : ES_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  // if prefprogr, simplify to perf, no? PTB_train_14564
  ¬c:I-> c:?Arg1l {}
  ( tem_constituency="PERF-C" | tem_constituency="PERF" | tem_constituency="PERFPROGR" )
  voice="PASS"
  //¬finiteness="INF"
  ¬modality=?m
  // See ES_transfer_node_PASS_aux
  ¬ c:lex = "afectar_VB_01"
  ¬ c:lex = "conocer_VB_02"
  ¬ c:lex = "condecorar_VB_01"
  c:lex = ?lex
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "cuando" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.ES

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )

//¬ ( c:?Xl { c:lex = ?lex3 } & lexicon.?lex3.transitive.no )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="haber"
//  lemma = "have"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  analyt_perf-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="PART"
    bottom=yes
  }
  aux_refl-> ?se {
    slex = "se"
    pos = "PRP"
    spos = "passive_marker"
    include = bubble_of_gov
  }
}
  ]
]

/* that [he] has been eaten */
DSynt<=>SSynt ES_transfer_node_PERF_PASS_THAT : ES_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  // if prefprogr, simplify to perf, no? PTB_train_14564
  ( tem_constituency="PERF-C" | tem_constituency="PERF" | tem_constituency="PERFPROGR" )
  finiteness="FIN"
  voice="PASS"
  //¬finiteness="INF"
  ¬modality = ?m
  c:lex = ?lex
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "cuando" | c:dlex = "que" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.ES

lexicon.?lex.aux_pass.?aux
lexicon.?aux.lemma.?lem

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }

¬ ( c:?Xl { c:lex = ?lex3 } & lexicon.?lex3.transitive.no )
  ]
  mixed = [

  ]
  rightside = [
?Wr {
    <=> ?Xl 
  slex="que"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?Xr {
    <=> ?Xl
    slex = "haber"
  //  lemma = "have"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense=?Xl.tense
    middle=yes
    analyt_perf-> ?Yr {
      <=> ?Xl
      slex =  ?lem
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
//      id=?Xl.id
      finiteness="PART"
      middle=yes
      analyt_pass-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
//        spos=?Xl.spos
//        id=?Xl.id
        finiteness="PART"
        bottom=yes
      }
    }
  }
}
  ]
]

/* is eating */
DSynt<=>SSynt ES_transfer_node_PROGR : ES_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  ¬voice="PASS"
  //¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "cuando" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.ES

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="estar"
//  lemma = "be"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  analyt_progr-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
  //  lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness="GER"
    bottom=yes
  }
}
  ]
]

/* that [he] is eating */
DSynt<=>SSynt ES_transfer_node_PROGR_THAT : ES_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  finiteness="FIN"
  ¬voice="PASS"
  //¬finiteness="INF"
  ¬modality=?m
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "cuando" | c:dlex = "que" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.ES

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="que"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?Yr {
    <=> ?Xl
    slex="estar"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense=?Xl.tense
    middle=yes
    analyt_progr-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="GER"
      bottom=yes
    }
  }
}
  ]
]

/* is being eaten 

THIS RULE should go check in the lexicon which is the correct auxiliary for passive.*/
DSynt<=>SSynt ES_transfer_node_PROGR_PASS : ES_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  voice="PASS"
  //¬finiteness="INF"
  ¬modality=?m
  c:lex = ?lex
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "cuando" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.ES

lexicon.?lex.aux_pass.?aux
lexicon.?aux.lemma.?lem

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="estar"
//  lemma = "be"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  analyt_progr-> ?Yr {
    <=> ?Xl
    slex = ?lem
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="GER"
    middle=yes
    analyt_pass-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="PART"
      bottom=yes
    }
  }
}
  ]
]

/* that [he] is being eaten 

THIS RULE should go check in the lexicon which is the correct auxiliary for passive.*/
DSynt<=>SSynt ES_transfer_node_PROGR_PASS_THAT : ES_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  finiteness="FIN"
  voice="PASS"
  //¬finiteness="INF"
  ¬modality=?m
  c:lex = ?lex
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "cuando" | c:dlex = "que" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.ES

lexicon.?lex.aux_pass.?aux
lexicon.?aux.lemma.?lem

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Wr {
    <=> ?Xl 
  slex="que"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?Xr {
    <=> ?Xl
    slex="estar"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense=?Xl.tense
    middle=yes
    analyt_progr-> ?Yr {
      <=> ?Xl
      slex = ?lex
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
//      id=?Xl.id
      finiteness="GER"
      middle=yes
      analyt_pass-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
//        spos=?Xl.spos
//        id=?Xl.id
        finiteness="PART"
        bottom=yes
      }
    }
  }
}
  ]
]

/* should be eating */
DSynt<=>SSynt EN_transfer_node_PROGR_MODAL : ES_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  ¬voice="PASS"
  //¬finiteness="INF"
  modality = ?mod
  modality_type = ?mt
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "cuando" | c:dlex = "que" )
                 c:?rds-> ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } }} & (?rds == II | ?rds == III | ?rds == IV) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.ES
lexicon.modality.?mod.?mt.?lex
lexicon.?lex.lemma.?lem


// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?ModalR {
  <=> ?Xl
  slex = ?lem
  lex = ?lex
  pos = "MD"
  spos = auxiliary
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top = yes
  modal-> ?Xr {
    <=> ?Xl
    slex="estar"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
  //  id=?Xl.id
    finiteness="INF"
    middle=yes
    analyt_progr-> ?Yr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
  //    spos=?Xl.spos
  //    id=?Xl.id
      finiteness="GER"
      bottom=yes
    }
  }
}
  ]
]

DSynt<=>SSynt IT_transfer_node_IN_governed : IT_transfer_node_multi_corresp
[
  leftside = [
c:?Gov {
  c:lex=?lex
  c:?r-> ?Xl {
    ¬voice="PASS"
    ¬tem_constituency=?tc
    ¬modality=?m
    ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" )
  }
}

lexicon.?lex.gp.?r.prep.?prep
//¬(?r == I & ?prep == "de" & ¬?Gov.voice == "PASS")

language.id.iso.IT

// see prep Locin
¬ ( ?prep == Locin & c:?Xl { c:lex = ?lexX } & lexicon.?lexX.Locin.?lexPrep & lexicon.?lexPrep.lemma.?prepLocin )
  ]
  mixed = [

  ]
  rightside = [
?PrepR {
  <=> ?Xl
  slex = ?prep
  //  added_prep = ?prep
//  lemma = ?prep
  pos = IN
  spos = preposition
//  id=?Xl.id
  top = yes
  prepos-> ?Xr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma=?Xl.lemma
    pos=?Xl.pos
//    spos=?Xl.spos
//    id=?Xl.id
//    number=?Xl.number
    bottom = yes
  }
}
  ]
]

DSynt<=>SSynt IT_transfer_node_IN_governed_Locin : IT_transfer_node_multi_corresp
[
  leftside = [
c:?Gov {
  c:lex=?lex
  c:?r-> ?Xl {
    ¬voice="PASS"
    ¬tem_constituency=?tc
    ¬modality=?m
    ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" | c:pos = "JJ" )
    c:lex = ?lexX
  }
}

lexicon.?lex.gp.?r.prep.Locin
lexicon.?lexX.Locin.?lexPrep
lexicon.?lexPrep.lemma.?prep
language.id.iso.IT

// In abstractive summarization, sometimes we keep the prepositions
¬ ( ?Xl { c:subcat_prep = ?spx c:GovLex = ?glx } & ?glx == ?lex )

// II will be mapped to a subject
¬(?r == II & ?Gov.voice == "PASS")

// no "by" unless in a passive contruction (actually BY have been removed from latest version of lexicon)
¬ (?r == I & ?prep == "per" & ¬?Gov.voice == "PASS" )
// Generalization: never introduce preposition for A1 of verbs? (they end up as subjects or agents)
// the INF part is to cover for INF verbs with a gov that asks for a "to"; no rule covers that so far, so I decide to let the "to"
// see node_basic and node_to; PTB_train_3751
( ¬ (?Gov.pos == "VB" & ?r == I ) | ?Xl.finiteness == "INF" )

// if Xl is a finite verb, don't introduce the preposition (see THAT rules)
¬ ( c:?Gov {¬( c:pos = "IN" | c:dlex = "quando" | c:dlex = "che" )} & ( ?r == II | ?r == III | ?r == IV ) & ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } } )

//still using EN_control for other languages, does this make sense?
//exclude control and raise verbs when introducing a preposition on a non verbal element
// restrict to "to"???
¬ ( c:?Gov { c:dlex = ?lem } & control_raise.?type.lex.?lem & ¬?Xl.pos == "VB" & ?prep == "to" )

// if the noun is genitive and has a coreference, it will be pronominalized
¬ ( c:?Xl { c:case = "GEN" c:<-> c:?Antecedent {} ¬c:ambiguous_antecedent = "yes"  } & ¬c:?Gov12 { c:definiteness = "INDEF" c:?r12-> c:?Xl {} } )
  ]
  mixed = [

  ]
  rightside = [
?PrepR {
  <=> ?Xl
  slex = ?prep
  //  added_prep = ?prep
//  lemma = ?prep
  pos = "IN"
  spos = preposition
//  id=?Xl.id
  top = yes
  random = #randInt()#
  prepos-> ?Xr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma=?Xl.lemma
    pos=?Xl.pos
//    spos=?Xl.spos
//    id=?Xl.id
//    number=?Xl.number
    bottom = yes
    Locin = "yes"
  }
}
  ]
]

/* che [lui] mangia */
DSynt<=>SSynt IT_transfer_node_THAT : IT_transfer_node_multi_corresp
[
  leftside = [
c:?Yl {
  ¬ ( c:pos = "IN" | c:dlex = "quando" | c:dlex = "che" )
  c:?r-> ?Xl {
    ¬voice="PASS"
    ¬tem_constituency=?t
    ¬modality=?m
    c:finiteness="FIN"
  }
}

language.id.iso.IT

( ?r == II | ?r == III )

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="che"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
  //  lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    tense=?Xl.tense
    finiteness="FIN"
    bottom=yes
  }
}
  ]
]

/*dovrebbe mangiare*/
DSynt<=>SSynt IT_transfer_node_MODAL : IT_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  ¬c:voice="PASS"
  ¬c:tem_constituency=?t
  ¬c:finiteness = "INF"
  modality = ?mod
  modality_type = ?mt
}

language.id.iso.IT
lexicon.modality.?mod.?mt.?lex

( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quando" | c:dlex = "che" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?GovR {
  <=> ?Xl
  slex = ?lex
//  lemma = "to"
  pos = "MD"
  spos = auxiliary
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top = yes
  modal-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness = "INF"
    bottom = yes
  }
}
  ]
]

/* che [lui] dovebbere mangiare */
DSynt<=>SSynt IT_transfer_node_THAT_MODAL : IT_transfer_node_multi_corresp
[
  leftside = [
c:?Yl {
  ¬ ( c:pos = "IN" | c:dlex = "quando" | c:dlex = "che" )
  c:?r-> ?Xl {
    ¬voice="PASS"
    ¬tem_constituency=?t
    modality = ?mod
    modality_type = ?mt
    c:finiteness="FIN"
  }
}

language.id.iso.IT
lexicon.modality.?mod.?mt.?lexM

( ?r == II | ?r == III )

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="che"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?ModalR {
    <=> ?Xl
    slex = ?lexM
  //  lemma = "to"
    pos = "MD"
    spos = auxiliary
    tense=?Xl.tense
    finiteness=?Xl.finiteness
    middle = yes
    modal-> ?Yr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
  //    spos=?Xl.spos
  //    id=?Xl.id
      finiteness="INF"
      bottom=yes
    }
  }
}
  ]
]

/*[lui] è mangiato */
DSynt<=>SSynt IT_transfer_node_PASS : IT_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  voice="PASS"
  ¬tem_constituency=?t
  ¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quando" | c:dlex = "che" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.IT

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="essere"
//  lemma = "be"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  analyt_pass-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
  //  lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness="PART"
    bottom=yes
  }
}
  ]
]

/*Two possible auxiliaries; get info in lexicon. 
ha mangiato / è andato
*/
DSynt<=>SSynt IT_transfer_node_PERF : IT_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PERF"
  ¬voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
  c:lex = ?lex
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quando" | c:dlex = "che" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.IT

lexicon.?lex.aux_perf.?aux
lexicon.?aux.lemma.?lem

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
//  lemma="have"
  slex = ?lem
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  analyt_perf-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma=?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness="PART"
    bottom=yes
  }
}
  ]
]

/* sta mangiando*/
DSynt<=>SSynt IT_transfer_node_PROGR : IT_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  ¬voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quando" | c:dlex = "che" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.IT

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="stare"
//  lemma = "be"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  analyt_progr-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
  //  lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness="GER"
    bottom=yes
  }
}
  ]
]

/* che [lei] ha mangiato*/
DSynt<=>SSynt IT_transfer_node_PERF_THAT : IT_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PERF"
  finiteness="FIN"
  //¬voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
  c:lex = ?lex
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quando" | c:dlex = "che" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.IT

lexicon.?lex.aux_perf.?aux
lexicon.?aux.lemma.?lem

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }

( ¬?Xl.voice == "PASS" | ( c:?Xl { c:lex = ?lex3 } & lexicon.?lex3.transitive.no ) )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="che"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?Yr {
    <=> ?Xl
    slex = ?lem
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense=?Xl.tense
    middle=yes
    analyt_perf-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="PART"
      bottom=yes
    }
  }
}
  ]
]

/* [lei] è stata mangiata

Auxiliary for PERFECT when combined with PASSIVE is "stare"

THIS RULE should go check in the lexicon which is the correct auxiliary for passive.*/
DSynt<=>SSynt IT_transfer_node_PERF_PASS : IT_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  // if prefprogr, simplify to perf, no? PTB_train_14564
  ( tem_constituency="PERF" | tem_constituency="PERFPROGR" )
  voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quando" | c:dlex = "che" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.IT

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )

//¬ ( c:?Xl { c:lex = ?lex3 } & lexicon.?lex3.transitive.no )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  // passive first
  slex="essere"
//  lemma = "have"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  analyt_perf-> ?Yr {
    <=> ?Xl
    // perfect second
    slex="stare"
    lex="stare_VB_01"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="PART"
    middle=yes
    analyt_pass-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="PART"
      bottom=yes
    }
  }
}
  ]
]

/* che [lui] è stato mangiato */
DSynt<=>SSynt IT_transfer_node_PERF_PASS_THAT : IT_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  // if prefprogr, simplify to perf, no? PTB_train_14564
  ( tem_constituency="PERF" | tem_constituency="PERFPROGR" )
  finiteness="FIN"
  voice="PASS"
  ¬finiteness="INF"
  ¬modality = ?m
  c:lex = ?lex
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quando" | c:dlex = "che" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.IT

lexicon.?lex.aux_perf.?aux
lexicon.?aux.lemma.?lem

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }

¬ ( c:?Xl { c:lex = ?lex3 } & lexicon.?lex3.transitive.no )
  ]
  mixed = [

  ]
  rightside = [
?Wr {
    <=> ?Xl 
  slex="che"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?Xr {
    <=> ?Xl
    slex = ?lem
  //  lemma = "have"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense=?Xl.tense
    middle=yes
    analyt_perf-> ?Yr {
      <=> ?Xl
      slex="essere"
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
//      id=?Xl.id
      finiteness="PART"
      middle=yes
      analyt_pass-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
//        spos=?Xl.spos
//        id=?Xl.id
        finiteness="PART"
        bottom=yes
      }
    }
  }
}
  ]
]

/* [lui]  viene mangiato

THIS RULE should go check in the lexicon which is the correct auxiliary for passive.*/
DSynt<=>SSynt IT_transfer_node_PROGR_PASS : IT_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quando" | c:dlex = "che" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.IT

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="venire"
//  lemma = "be"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  analyt_progr-> ?Zr {
    <=> ?Xl
    slex=?Xl.dlex
  //  lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness="PART"
    bottom=yes
  }
}
  ]
]

/* che [lei] sta mangiando*/
DSynt<=>SSynt IT_transfer_node_PROGR_THAT : IT_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  finiteness="FIN"
  ¬voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quando" | c:dlex = "che" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.IT

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="che"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?Yr {
    <=> ?Xl
    slex="stare"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense=?Xl.tense
    middle=yes
    analyt_progr-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="GER"
      bottom=yes
    }
  }
}
  ]
]

/* che [lei] viene mangiata

THIS RULE should go check in the lexicon which is the correct auxiliary for passive.*/
DSynt<=>SSynt IT_transfer_node_PROGR_PASS_THAT : IT_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  finiteness="FIN"
  voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quando" | c:dlex = "che" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.IT

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Wr {
    <=> ?Xl 
  slex="che"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?Xr {
    <=> ?Xl
    slex="venire"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense=?Xl.tense
    middle=yes
    analyt_progr-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="PART"
      bottom=yes
    }
  }
}
  ]
]

/* che [lui] dovrebbe essere mangiato

THIS RULE should go check in the lexicon which is the correct auxiliary for passive.*/
DSynt<=>SSynt IT_transfer_node_PASS_THAT_MODAL : IT_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  finiteness="FIN"
  voice="PASS"
  ¬tem_constituency=?t
  ¬finiteness="INF"
  modality = ?mod
  modality_type = ?mt
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quando" | c:dlex = "che" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.IT
lexicon.modality.?mod.?mt.?lexM

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="che"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj->  ?ModalR {
    <=> ?Xl
    slex = ?lexM
  //  lemma = "to"
    pos = "MD"
    spos = auxiliary
    tense=?Xl.tense
    finiteness=?Xl.finiteness
    middle = yes
    modal-> ?Yr {
      <=> ?Xl
      slex="essere"
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
  //    id=?Xl.id
      finiteness="INF"
      middle=yes
      analyt_pass-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
  //      spos=?Xl.spos
  //      id=?Xl.id
        finiteness="PART"
        bottom=yes
      }
    }
  }
}
  ]
]

DSynt<=>SSynt FR_transfer_node_IN_governed : FR_transfer_node_multi_corresp
[
  leftside = [
c:?Gov {
  c:lex=?lex
  c:?r-> ?Xl {
    ¬voice="PASS"
    ¬tem_constituency=?tc
    ¬modality=?m
    ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" )
  }
}

lexicon.?lex.gp.?r.prep.?prep
¬(?r == I & ?prep == "par" & ¬?Gov.voice == "PASS")

language.id.iso.FR

( ¬ (?Gov.pos == "VB" & ?r == I ) | ?Xl.finiteness == "INF" )

// if Xl is a finite verb, don't introduce the preposition (see THAT rules)
¬ ( c:?Gov {¬( c:pos = "IN" | c:dlex = "quand" | c:dlex = "que" )} & ( ?r == II | ?r == III ) & ?Xl {finiteness="FIN"} )
  ]
  mixed = [

  ]
  rightside = [
?PrepR {
  <=> ?Xl
  slex = ?prep
  //  added_prep = ?prep
//  lemma = ?prep
  pos = IN
  spos = preposition
//  id=?Xl.id
  top = yes
  prepos-> ?Xr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma=?Xl.lemma
    pos=?Xl.pos
//    spos=?Xl.spos
//    id=?Xl.id
//    number=?Xl.number
    bottom = yes
  }
}
  ]
]

/* that [he] eats */
DSynt<=>SSynt FR_transfer_node_THAT : FR_transfer_node_multi_corresp
[
  leftside = [
c:?Yl {
  ¬ ( c:pos = "IN" | c:dlex = "quand" | c:dlex = "que" )
  c:?r-> ?Xl {
    ¬voice="PASS"
    ¬tem_constituency=?t
    ¬modality=?m
    c:finiteness="FIN"
  }
}

language.id.iso.FR

( ?r == II | ?r == III )

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="que"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
  //  lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    tense=?Xl.tense
    finiteness="FIN"
    bottom=yes
  }
}
  ]
]

/*should eat*/
DSynt<=>SSynt FR_transfer_node_MODAL : FR_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  ¬c:voice="PASS"
  ¬c:tem_constituency=?t
  ¬c:finiteness = "INF"
  modality = ?mod
  modality_type = ?mt
}

language.id.iso.FR
lexicon.modality.?mod.?mt.?lex

( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quand" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP" | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?GovR {
  <=> ?Xl
  slex = ?lex
//  lemma = "to"
  pos = "MD"
  spos = auxiliary
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top = yes
  modal-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness = "INF"
    bottom = yes
  }
}
  ]
]

/* that [he] should eat */
DSynt<=>SSynt FR_transfer_node_THAT_MODAL : FR_transfer_node_multi_corresp
[
  leftside = [
c:?Yl {
  ¬ ( c:pos = "IN" | c:dlex = "quand" | c:dlex = "que" )
  c:?r-> ?Xl {
    ¬voice="PASS"
    ¬tem_constituency=?t
    modality = ?mod
    modality_type = ?mt
    c:finiteness="FIN"
  }
}

language.id.iso.FR
lexicon.modality.?mod.?mt.?lexM

( ?r == II | ?r == III )

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="que"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?ModalR {
    <=> ?Xl
    slex = ?lexM
  //  lemma = "to"
    pos = "MD"
    spos = auxiliary
    tense=?Xl.tense
    finiteness=?Xl.finiteness
    middle = yes
    modal-> ?Yr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
  //    spos=?Xl.spos
  //    id=?Xl.id
      finiteness="INF"
      bottom=yes
    }
  }
}
  ]
]

/*is eaten

THIS RULE should go check in the lexicon which is the correct auxiliary for passive.*/
DSynt<=>SSynt FR_transfer_node_PASS : FR_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  voice="PASS"
  ¬tem_constituency=?t
  ¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quand" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.FR

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )

//¬ ( c:?Xl { c:lex = ?lex3 } & lexicon.?lex3.transitive.no )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="être"
//  lemma = "be"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  analyt_pass-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
  //  lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness="PART"
    bottom=yes
  }
}
  ]
]

/* has eaten*/
DSynt<=>SSynt FR_transfer_node_PERF : FR_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PERF"
  ¬voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quand" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.FR

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="avoir"
//  lemma="have"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  analyt_perf-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma=?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness="PART"
    bottom=yes
  }
}
  ]
]

/* is eating */
DSynt<=>SSynt FR_transfer_node_PROGR : FR_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  ¬voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quand" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.FR

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )

// see FR_transfer_node_PROGR_wrong_parse
¬ ( c:?Xl {c:lemma = "être" c:II-> c:?V3l { c:finiteness = "GER" } } )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="être_en_train_de"
//  lemma = "be"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  analyt_progr-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
  //  lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness="INF"
    bottom=yes
  }
}
  ]
]

/* is eating */
DSynt<=>SSynt FR_transfer_node_PROGR_wrong_parse : FR_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  ¬voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quand" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.FR

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )

( c:?Xl {c:lemma = "être" c:II-> c:?V3l { c:finiteness = "GER" } } )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="être_en_train_de"
//  lemma = "be"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  analyt_progr-> rc:?Yr {
   rc:<=> ?V3l
     rc:finiteness = "GER"
     finiteness="INF"
  }
}
  ]
]

/* that [he] is eating */
DSynt<=>SSynt FR_transfer_node_PERF_THAT : FR_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PERF"
  finiteness="FIN"
  //¬voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quand" | c:dlex = "que" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.FR

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }

( ¬?Xl.voice == "PASS" | ( c:?Xl { c:lex = ?lex3 } & lexicon.?lex3.transitive.no ) )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="que"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?Yr {
    <=> ?Xl
    slex="avoir"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense=?Xl.tense
    middle=yes
    analyt_perf-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="PART"
      bottom=yes
    }
  }
}
  ]
]

/* has been eaten 

THIS RULE should go check in the lexicon which is the correct auxiliary for passive.*/
DSynt<=>SSynt FR_transfer_node_PERF_PASS : FR_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  // if prefprogr, simplify to perf, no? PTB_train_14564
  ( tem_constituency="PERF" | tem_constituency="PERFPROGR" )
  voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quand" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.FR

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )

//¬ ( c:?Xl { c:lex = ?lex3 } & lexicon.?lex3.transitive.no )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="avoir"
//  lemma = "have"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  analyt_perf-> ?Yr {
    <=> ?Xl
    slex="être"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="PART"
    middle=yes
    analyt_pass-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="PART"
      bottom=yes
    }
  }
}
  ]
]

/* that [he] has been eaten */
DSynt<=>SSynt FR_transfer_node_PERF_PASS_THAT : FR_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  // if prefprogr, simplify to perf, no? PTB_train_14564
  ( tem_constituency="PERF" | tem_constituency="PERFPROGR" )
  finiteness="FIN"
  voice="PASS"
  ¬finiteness="INF"
  ¬modality = ?m
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quand" | c:dlex = "que" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.FR

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }

¬ ( c:?Xl { c:lex = ?lex3 } & lexicon.?lex3.transitive.no )
  ]
  mixed = [

  ]
  rightside = [
?Wr {
    <=> ?Xl 
  slex="que"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?Xr {
    <=> ?Xl
    slex="avoir"
  //  lemma = "have"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense=?Xl.tense
    middle=yes
    analyt_perf-> ?Yr {
      <=> ?Xl
      slex="être"
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
//      id=?Xl.id
      finiteness="PART"
      middle=yes
      analyt_pass-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
//        spos=?Xl.spos
//        id=?Xl.id
        finiteness="PART"
        bottom=yes
      }
    }
  }
}
  ]
]

/* is being eaten 

THIS RULE should go check in the lexicon which is the correct auxiliary for passive.*/
DSynt<=>SSynt FR_transfer_node_PROGR_PASS : FR_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quand" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.FR

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="être_en_train_de"
//  lemma = "be"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  analyt_progr-> ?Yr {
    <=> ?Xl
    slex="être"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="INF"
    middle=yes
    analyt_pass-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="PART"
      bottom=yes
    }
  }
}
  ]
]

/* that [he] is eating */
DSynt<=>SSynt FR_transfer_node_PROGR_THAT : FR_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  finiteness="FIN"
  ¬voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quand" | c:dlex = "que" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.FR

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="que"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?Yr {
    <=> ?Xl
    slex="être_en_train_de"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense=?Xl.tense
    middle=yes
    analyt_progr-> ?Zr {
      <=> ?Xl
      slex=?Xl.dlex
    //  lemma = ?Xl.lemma
      pos = "VB"
//      spos=?Xl.spos
//      id=?Xl.id
      finiteness="INF"
      bottom=yes
    }
  }
}
  ]
]

/* that [he] is being eaten 

THIS RULE should go check in the lexicon which is the correct auxiliary for passive.*/
DSynt<=>SSynt FR_transfer_node_PROGR_PASS_THAT : FR_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  tem_constituency="PROGR"
  finiteness="FIN"
  voice="PASS"
  ¬finiteness="INF"
  ¬modality=?m
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quand" | c:dlex = "que" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.FR

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Wr {
    <=> ?Xl 
  slex="que"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?Xr {
    <=> ?Xl
    slex="être_en_train_de"
  //  lemma = "be"
    pos = "VB"
    spos=auxiliary
//    id=?Xl.id
    finiteness="FIN"
    tense=?Xl.tense
    middle=yes
    analyt_progr-> ?Yr {
      <=> ?Xl
      slex="être"
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
//      id=?Xl.id
      finiteness="INF"
      middle=yes
      analyt_pass-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
//        spos=?Xl.spos
//        id=?Xl.id
        finiteness="PART"
        bottom=yes
      }
    }
  }
}
  ]
]

/* that [he] should be eaten 

THIS RULE should go check in the lexicon which is the correct auxiliary for passive.*/
DSynt<=>SSynt FR_transfer_node_PASS_THAT_MODAL : FR_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  finiteness="FIN"
  voice="PASS"
  ¬tem_constituency=?t
  ¬finiteness="INF"
  modality = ?mod
  modality_type = ?mt
}
( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quand" | c:dlex = "que" ) c:?rds-> ?Xl {}} & (?rds == II | ?rds == III) )

language.id.iso.FR
lexicon.modality.?mod.?mt.?lexM

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="que"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj->  ?ModalR {
    <=> ?Xl
    slex = ?lexM
  //  lemma = "to"
    pos = "MD"
    spos = auxiliary
    tense=?Xl.tense
    finiteness=?Xl.finiteness
    middle = yes
    modal-> ?Yr {
      <=> ?Xl
      slex="être"
    //  lemma = "be"
      pos = "VB"
      spos=auxiliary
  //    id=?Xl.id
      finiteness="INF"
      middle=yes
      analyt_pass-> ?Zr {
        <=> ?Xl
        slex=?Xl.dlex
      //  lemma = ?Xl.lemma
        pos = "VB"
  //      spos=?Xl.spos
  //      id=?Xl.id
        finiteness="PART"
        bottom=yes
      }
    }
  }
}
  ]
]

DSynt<=>SSynt PL_transfer_node_IN_governed : PL_transfer_node_multi_corresp
[
  leftside = [
c:?Gov {
  c:lex=?lex
  c:?r-> ?Xl {}
}

lexicon.?lex.gp.?r.prep.?prep

// II will be mapped to a subject
¬(?r == II & ?Gov.voice == "PASS")

language.id.iso.PL
  ]
  mixed = [

  ]
  rightside = [
?PrepR {
  <=> ?Xl
  slex = ?prep
  //  added_prep = ?prep
//  lemma = ?prep
  pos = IN
  spos = preposition
//  id=?Xl.id
  top = yes
  comp-> ?Xr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma=?Xl.lemma
    pos=?Xl.pos
//    spos=?Xl.spos
//    id=?Xl.id
//    number=?Xl.number
    bottom = yes
  }
}
  ]
]

/*should eat
!!! ALL other MODAL rules are missing !!! (combinations with others)*/
DSynt<=>SSynt PL_transfer_node_MODAL : PL_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  ¬c:voice="PASS"
  ¬c:tem_constituency=?t
  modality = ?mod
  modality_type = ?mt
}

language.id.iso.PL
lexicon.modality.?mod.?mt.?lex
  ]
  mixed = [

  ]
  rightside = [
?GovR {
  <=> ?Xl
  slex = ?lex
//  lemma = "to"
  pos = "MD"
  spos = auxiliary
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top = yes
  comp_inf-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness = "INF"
    bottom = yes
  }
}
  ]
]

/* that [he] eats */
DSynt<=>SSynt PL_transfer_node_THAT : PL_transfer_node_multi_corresp
[
  leftside = [
c:?Yl {
  ¬c:pos="IN"
  c:II-> ?Xl {
    ¬voice="PASS"
    ¬tem_constituency=?t
    c:finiteness="FIN"
  }
}

language.id.iso.PL
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="żeby"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  comp-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
  //  lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    tense=?Xl.tense
    finiteness="FIN"
    bottom=yes
  }
}
  ]
]

/*similar rules missing for all configurations of auxiliaries! (160802_ME_edited #0)*/
DSynt<=>SSynt PT_transfer_node_IN_governed_Locin : PT_transfer_node_multi_corresp
[
  leftside = [
c:?Gov {
  c:lex=?lex
  c:?r-> ?Xl {
    ¬voice="PASS"
    ¬tem_constituency=?tc
    ¬modality=?m
    ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" | c:pos = "JJ" )
    c:lex = ?lexX
  }
}

lexicon.?lex.gp.?r.prep.Locin
lexicon.?lexX.Locin.?lexPrep
lexicon.?lexPrep.lemma.?prep
language.id.iso.PT

// In abstractive summarization, sometimes we keep the prepositions
¬ ( ?Xl { c:subcat_prep = ?spx c:GovLex = ?glx } & ?glx == ?lex )

// II will be mapped to a subject
¬(?r == II & ?Gov.voice == "PASS")

// no "by" unless in a passive contruction (actually BY have been removed from latest version of lexicon)
¬ (?r == I & ?prep == "by" & ¬?Gov.voice == "PASS" )
// Generalization: never introduce preposition for A1 of verbs? (they end up as subjects or agents)
// the INF part is to cover for INF verbs with a gov that asks for a "to"; no rule covers that so far, so I decide to let the "to"
// see node_basic and node_to; PTB_train_3751
( ¬ (?Gov.pos == "VB" & ?r == I ) | ?Xl.finiteness == "INF" )

// if Xl is a finite verb, don't introduce the preposition (see THAT rules)
¬ ( c:?Gov {¬( c:pos = "IN" | c:dlex = "quando" | c:dlex = "que" )} & ( ?r == II | ?r == III | ?r == IV ) & ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } } )


//exclude control and raise verbs when introducing a preposition on a non verbal element
// restrict to "to"???
¬ ( c:?Gov { c:dlex = ?lem } & control_raise.?type.lex.?lem & ¬?Xl.pos == "VB" & ?prep == "to" )
  ]
  mixed = [

  ]
  rightside = [
?PrepR {
  <=> ?Xl
  slex = ?prep
  //  added_prep = ?prep
//  lemma = ?prep
  pos = "IN"
  spos = preposition
//  id=?Xl.id
  top = yes
  random = #randInt()#
  prepos-> ?Xr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma=?Xl.lemma
    pos=?Xl.pos
//    spos=?Xl.spos
//    id=?Xl.id
//    number=?Xl.number
    bottom = yes
    Locin = "yes"
  }
}
  ]
]

DSynt<=>SSynt PT_transfer_node_IN_governed : PT_transfer_node_multi_corresp
[
  leftside = [
c:?Gov {
  c:lex=?lex
  c:?r-> ?Xl {
    ¬voice="PASS"
    ¬tem_constituency=?tc
    ¬modality=?m
    ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" | c:pos = "PRP" | c:pos = "JJ" )
  }
}

lexicon.?lex.gp.?r.prep.?prep
language.id.iso.PT
// see prep Locin
¬ ( ?prep == Locin & c:?Xl { c:lex = ?lexX } & lexicon.?lexX.Locin.?lexPrep & lexicon.?lexPrep.lemma.?prepLocin )

// In abstractive summarization, sometimes we keep the prepositions
¬ ( ?Xl { c:subcat_prep = ?spx c:GovLex = ?glx } & ?glx == ?lex )

// II will be mapped to a subject
¬(?r == II & ?Gov.voice == "PASS")

// no "by" unless in a passive contruction (actually BY have been removed from latest version of lexicon)
¬ (?r == I & ?prep == "by" & ¬?Gov.voice == "PASS" )
// Generalization: never introduce preposition for A1 of verbs? (they end up as subjects or agents)
// the INF part is to cover for INF verbs with a gov that asks for a "to"; no rule covers that so far, so I decide to let the "to"
// see node_basic and node_to; PTB_train_3751
( ¬ (?Gov.pos == "VB" & ?r == I ) | ?Xl.finiteness == "INF" )
¬ (?r == III & ?Gov.dative_shift == "DO")

// if Xl is a finite verb, don't introduce the preposition (see THAT rules)
¬ ( c:?Gov {¬( c:pos = "IN" | c:dlex = "when" | c:dlex = "which" | c:dlex = "that"  )} & ( ?r == II | ?r == III | ?r == IV ) & ?Xl {finiteness="FIN" ¬ c:?rWP-> c:?WP {c:pos = "WP" } } )

// see transfer_node_TO
( ¬?Xl.finiteness == "INF" | ?prep == "to" )

//exclude control and raise verbs when introducing a preposition on a non verbal element
// restrict to "to"???
¬ ( c:?Gov { c:dlex = ?lem } & control_raise.?type.lex.?lem & ¬?Xl.pos == "VB" & ?prep == "to" )

// if the noun is genitive and has a coreference, it will be pronominalized
¬ ( c:?Xl { c:case = "GEN" c:<-> c:?Antecedent {} } )
  ]
  mixed = [

  ]
  rightside = [
?PrepR {
  <=> ?Xl
  slex = ?prep
  //  added_prep = ?prep
//  lemma = ?prep
  pos = "IN"
  spos = preposition
//  id=?Xl.id
  top = yes
  random = #randInt()#
  prepos-> ?Xr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma=?Xl.lemma
    pos=?Xl.pos
//    spos=?Xl.spos
//    id=?Xl.id
//    number=?Xl.number
    bottom = yes
  }
}
  ]
]

/*is eaten */
DSynt<=>SSynt PT_transfer_node_PASS_aux : PT_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  voice="PASS"
  ( ¬c:tem_constituency=?tc | c:tem_constituency = "IMP" | c:tem_constituency = "PERF-S" )
  ¬modality=?m
  c:lex = ?lex
}

( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quando" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.PT

lexicon.?lex.aux_pass.?aux
lexicon.?aux.lemma.?lem

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex = ?lem
//  lemma = "be"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  analyt_pass-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
  //  lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness="PART"
    bottom=yes
  }
}
  ]
]

/* that [he] eats */
DSynt<=>SSynt PT_transfer_node_THAT : PT_transfer_node_multi_corresp
[
  leftside = [
c:?Yl {
  ¬ ( c:pos = "IN" | c:dlex = "quando" | c:dlex = "que" )
  c:?r-> ?Xl {
    ¬voice="PASS"
    ( ¬c:tem_constituency=?tc | c:tem_constituency = "IMP" | c:tem_constituency = "PERF-S" )
    ¬modality=?m
    c:finiteness="FIN"
  }
}

language.id.iso.PT

( ?r == II | ?r == III )

¬ c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex="que"
//  lemma = "that"
  pos = "IN"
  spos=conjunction
//  id=?Xl.id
  top=yes
  sub_conj-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
  //  lemma = ?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    tense=?Xl.tense
    finiteness="FIN"
    bottom=yes
  }
}
  ]
]

/* has eaten*/
DSynt<=>SSynt PT_transfer_node_PERF : PT_transfer_node_multi_corresp
[
  leftside = [
?Xl {
  ( tem_constituency="PERF-C" | tem_constituency="PERF" )
  ¬voice="PASS"
  //¬finiteness="INF"
  ¬modality=?m
}
( ¬ ( c:?Yl {¬ ( c:pos = "IN" | c:dlex = "quando" | c:dlex = "que" ) c:?rds-> ?Xl {finiteness="FIN"}} & (?rds == II | ?rds == III) )
 | c:?ConjN1l { c:finiteness = "FIN" c:COORD-> c:?CoordN { c:II-> ?Xl {} } }
)

language.id.iso.PT

// there is no governed preposition
¬( c:?Gov2 {c:lex=?lex2 c:?r2-> ?Xl { ( c:pos = "NN" | c:pos = "NP"  | c:pos = "VB" | c:pos = "CD" ) }} & lexicon.?lex2.gp.?r2.prep )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex = "ter"
//  lemma="have"
  pos = "VB"
  spos=auxiliary
//  id=?Xl.id
  tense=?Xl.tense
  finiteness=?Xl.finiteness
  top=yes
  analyt_perf-> ?Yr {
    <=> ?Xl
    slex=?Xl.dlex
//    lemma=?Xl.lemma
    pos = "VB"
//    spos=?Xl.spos
//    id=?Xl.id
    finiteness="PART"
    bottom=yes
  }
}
  ]
]

DSynt<=>SSynt DE_transfer_rel_COORD : DE_transfer_relations
[
  leftside = [
c:?Xl {
  COORD-> c:?Yl {}
}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bottom=yes
  ¬rc:middle=yes
  CD-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt DE_transfer_rel_NAME_PNC : DE_transfer_relations
[
  leftside = [
c:?Xl {
  NAME-> c:?Yl {
  }
}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  PNC-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt DE_transfer_rel_APPEND_DEP : DE_transfer_relations
[
  leftside = [
c:?Xl {
  APPEND-> c:?Yl {}
}

// if it's a relative clause, map it to NMOD
¬ (c:?Xl {c:pos = "NN" } & c:?Yl {c:finiteness = "FIN" c:*?r-> c:?Rel { c:<-> c:?Xl {}}} )

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //¬rc:bottom=yes
  //¬rc:middle=yes
  ¬(rc:middle=yes & ¬rc:OC-> rc:?Nr {})
  ¬(rc:top=yes & ¬rc:spos=auxiliary)
  PAR-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}

(¬ rc:?Xr { rc:bottom=yes & ¬rc:finiteness="FIN" }
 | ( rc:?TO { rc:?rel-> rc:?Xr {} } & ?rel == NK ) )

¬rc:?Mr {rc:OC-> rc:?Xr {}}
  ]
]

/*RP is a particle (e.g. win over) sometimes found in the paradigm of an a adjective. (PTB_train_52)

Seems that AMOD gives problems with linearization... it should be changed by some other name without problem (as in the rule ATTR_SUFFIX).
However, until the moment no unproblematic name has been found, so...*/
DSynt<=>SSynt DE_transfer_rel_ATTR_MO : DE_transfer_relations
[
  leftside = [
c:?Xl {
  ATTR-> c:?Yl {
  }
}

language.id.iso.DE

¬ (?Xl.pos == "NN" & ( ?Yl.pos == "JJ" | ?Yl.pos == "NN" ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  MO-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

/*RP is a particle (e.g. win over) sometimes found in the paradigm of an a adjective. (PTB_train_52)

Seems that AMOD gives problems with linearization... it should be changed by some other name without problem (as in the rule ATTR_SUFFIX).
However, until the moment no unproblematic name has been found, so...*/
DSynt<=>SSynt DE_transfer_rel_ATTR_NK : DE_transfer_relations
[
  leftside = [
c:?Xl {
  ATTR-> c:?Yl {
  }
}

language.id.iso.DE

(?Xl.pos == "NN" & ( ?Yl.pos == "JJ" | ?Yl.pos == "NN" ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  NK-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt DE_transfer_rel_I_II_SBJ : DE_transfer_relations
[
  leftside = [
c:?Xl {
 // (c:pos = "VAFIN" | c:pos = "VVFIN") //these attrs are present in the corpus, but not in the projects material
  ( c:pos = "VB" | c:pos = "MD" )
  ?r-> c:?Yl {}
}

language.id.iso.DE

((?r == I & c:?Xl {¬c:voice = "PASS"} & c:?Yl {¬c:lemma = "von"}) | (?r == II & c:?Xl {c:voice = "PASS"}))

// next condition disabled for now, see if we need it...
//¬(c:?Xl { ( c:finiteness="INF" | c:finiteness ="PART" ) } & ?r == I)
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬(rc:bottom = yes & ¬rc:finiteness = "FIN")
  ¬(rc:middle = yes & ¬rc:OC -> rc:?Nr {})
  ¬(rc:top = yes & ¬rc:spos = auxiliary)
//  ¬rc:middle=yes
  SB-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom = yes
    ¬rc:middle = yes
  }
}
¬rc:?Mr {rc:OC-> rc:?Xr {}} //the subject holds on the auxiliary in GER
  ]
]

DSynt<=>SSynt DE_transfer_rel_I_NK : DE_transfer_relations
[
  leftside = [
c:?Xl {
  c:pos = "NN"
  I-> c:?Yl {
    ¬(c:pos = "VB" | c:pos="MD")
  }
}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  NK-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt DE_transfer_rel_II_NK : DE_transfer_relations
[
  leftside = [
c:?Xl {
  ( c:pos = "NP" | c:pos = "NN" )
  II-> c:?Yl {
    // ¬(c:pos = "VB" | c:pos="MD")
  }
}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  NK-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

/*Relation POBJ doesn't exist in TIGER, but it's a mess without it.*/
DSynt<=>SSynt DE_transfer_rel_II_PMOD : DE_transfer_relations
[
  leftside = [
c:?Xl {
  (c:pos = "IN" | c:pos = "RB" )
  II-> c:?Yl {
  // see CP
  ¬ (c:pos = "VB" | c:pos="MD")
  }
}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  PMOD-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt DE_transfer_rel_II_CC : DE_transfer_relations
[
  leftside = [
c:?Xl {
  c:pos="JJ"
  II-> c:?Yl {}
}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  CC-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt DE_transfer_rel_II_CJ : DE_transfer_relations
[
  leftside = [
c:?Xl {
  (c:pos="CC" | c:lemma="und")
  II-> c:?Yl {}
}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  CJ-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt DE_transfer_rel_II_OA : DE_transfer_relations
[
  leftside = [
c:?Xl {
  (c:pos = "VB" | c:pos="MD")
  ¬c:voice="PASS"
  ¬c:lemma="sein"
  II-> c:?Yl {}
}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  OA-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt DE_transfer_rel_II_PD : DE_transfer_relations
[
  leftside = [
c:?Xl {
  (c:pos = "VB" | c:pos="MD")
  ¬c:voice="PASS"
  c:lemma="sein"
  II-> c:?Yl {}
}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  PD-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt DE_transfer_rel_II_CP : DE_transfer_relations
[
  leftside = [
c:?Xl {
  (c:pos="IN" | c:pos="RB" | c:pos="WDT")
  II-> c:?Yl {
    (c:pos = "VB" | c:pos="MD")
  }
}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  CP-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

/*Can also be DA, see what it depends on...*/
DSynt<=>SSynt DE_transfer_rel_III_OA2 : DE_transfer_relations
[
  leftside = [
c:?Xl {
  ¬c:pos = "NN"
  III-> c:?Yl {
    ¬c:pos="TO"
  }
}

language.id.iso.DE

// see transfer node coord governed
¬ ( c:?Xl { c:lex = ?lex } & lexicon.?lex.gp.III.coordination.?CLex 
  & lexicon.?CLex.lemma )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  OA2-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

/*Can also be DA, see what it depends on...*/
DSynt<=>SSynt DE_transfer_rel_IV_OA2 : DE_transfer_relations
[
  leftside = [
c:?Xl {
  ¬c:pos = "NN"
  IV-> c:?Yl {
    ¬c:pos="TO"
  }
}

language.id.iso.DE

// see transfer node coord governed
¬ ( c:?Xl { c:lex = ?lex } & lexicon.?lex.gp.IV.coordination.?CLex 
  & lexicon.?CLex.lemma )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  OA2-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

/*Are the RS conditions correct? It looks like it works for auxiliaries, but what about governed preps?
(e.g. allergic to lactose and gluten)
Right now this is handled as a post-processing... To change ASAP.*/
DSynt<=>SSynt EN_transfer_rel_COORD : EN_transfer_relations
[
  leftside = [
c:?Xl {
  COORD-> c:?Yl {}
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  // see node_by_LGS
  ¬rc:lgs = yes
  ¬rc:bottom=yes
  ¬rc:middle=yes
  COORD-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt EN_transfer_rel_NAME_PRT : EN_transfer_relations
[
  leftside = [
c:?Xl {
  NAME-> c:?Yl {
    c:pos="RP"
  }
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  PRT-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt EN_transfer_rel_NAME_NAME : EN_transfer_relations
[
  leftside = [
c:?Xl {
  NAME-> c:?Yl {
    ¬c:pos="RP"
  }
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  NAME-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

/*RP is a particle (e.g. win over) sometimes found in the paradigm of an a adjective. (PTB_train_52)

Seems that AMOD gives problems with linearization... it should be changed by some other name without problem (as in the rule ATTR_SUFFIX).
However, until the moment no unproblematic name has been found, so...*/
DSynt<=>SSynt EN_transfer_rel_ATTR_AMOD : EN_transfer_relations
[
  leftside = [
c:?Xl {
  ( c:pos = "JJ" | c:pos = "RP" )
  ?r-> c:?Yl {}
}

language.id.iso.EN

(?r == ATTR | ?r == II)

// don't duplicate ATTR in case there is already a relation between the nodes (close to impossible to manage in previous level)
¬ ( ?r == ATTR & c:?Zl { c:?s-> c:?Yl {} } & ¬ ?s == ATTR )

// If ?Xl is a noun modifier and a comparative adjective, a special relation is introduced instead of the argumental relation
¬ ( c:?GovL { ( c:pos = "NN" | c:pos = "JJ" | c:pos = "RB" ) c:ATTR-> c:?Xl { c:lex = ?lexXl } } & lexicon.?lexXl.comparative.yes & ?r == II )
// ( c:pos = "NN" | c:pos = "JJ" | c:pos = "RB" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  AMOD-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt EN_transfer_rel_ATTR_AMOD_COMPAR : EN_transfer_relations
[
  leftside = [
c:?Xl {
  ( c:pos = "JJ" | c:pos = "RP" )
  ?r-> c:?Yl {}
}

language.id.iso.EN

(?r == ATTR | ?r == II)

// don't duplicate ATTR in case there is already a relation between the nodes (close to impossible to manage in previous level)
¬ ( ?r == ATTR & c:?Zl { c:?s-> c:?Yl {} } & ¬ ?s == ATTR )

// If ?Xl is a noun modifier and a comparative adjective, a special relation is introduced instead of the argumental relation
( c:?GovL { ( c:pos = "NN" | c:pos = "JJ" | c:pos = "RB" ) c:ATTR-> c:?Xl { c:lex = ?lexXl } } & lexicon.?lexXl.comparative.yes & ?r == II )
// ( c:pos = "NN" | c:pos = "JJ" | c:pos = "RB" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  AMOD_COMP-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt EN_transfer_rel_APPEND_DEP : EN_transfer_relations
[
  leftside = [
c:?Xl {
  APPEND-> c:?Yl {}
}

// if it's a relative clause, map it to NMOD
¬ (c:?Xl {c:pos = "NN" } & c:?Yl {c:finiteness = "FIN" c:*?r-> c:?Rel1 { c:<-> c:?Xl {}}} )
// If an adjective, usually comparative is there, map to ADV
¬ (c:?Xl {c:pos = "VB" } & c:?Yl {c:pos= "JJ" c:II-> c:?N2 {}} )


language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //¬rc:bottom=yes
  //¬rc:middle=yes
  ¬(rc:middle=yes & ¬rc:VC-> rc:?Nr {})
  ¬(rc:top=yes & ¬rc:spos=auxiliary)
  DEP-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}

(¬ rc:?Xr { rc:bottom=yes & ¬rc:finiteness="FIN" }
 | ( rc:?TO { rc:?rel-> rc:?Xr {} } & (?rel == PMOD | ?rel == IM ) ) )

¬rc:?Mr {rc:VC-> rc:?Xr {}}
  ]
]

DSynt<=>SSynt EN_transfer_rel_APPEND_ADV : EN_transfer_relations
[
  leftside = [
c:?Xl {
  APPEND-> c:?Yl {}
}

// If an adjective, usually comparative is there, map to ADV
(c:?Xl {c:pos = "VB" } & c:?Yl {c:pos= "JJ" c:II-> c:?N2 {}} )


language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //¬rc:bottom=yes
  //¬rc:middle=yes
  ¬(rc:middle=yes & ¬rc:VC-> rc:?Nr {})
  ¬(rc:top=yes & ¬rc:spos=auxiliary)
  ADV-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}

(¬ rc:?Xr { rc:bottom=yes & ¬rc:finiteness="FIN" }
 | ( rc:?TO { rc:?rel-> rc:?Xr {} } & (?rel == PMOD | ?rel == IM ) ) )

¬rc:?Mr {rc:VC-> rc:?Xr {}}
  ]
]

DSynt<=>SSynt EN_transfer_rel_ATTR_NMOD : EN_transfer_relations
[
  leftside = [
c:?Xl {
  (c:pos = "NN" | c:pos = "NP" )
  c:pos = ?pos
  ?r-> c:?Yl {
    ¬c:pos="POS"
  }
}

language.id.iso.EN


(?r == ATTR | (?r == APPEND & (c:?Xl {} & c:?Yl {c:finiteness = "FIN" c:*?s-> c:?Rel { c:<-> c:?Xl {}}} ) ) )

// don't duplicate ATTR in case there is already a relation between the nodes (close to impossible to manage in previous level)
¬ ( ?r == ATTR & c:?Zl { c:?s2-> c:?Yl {} } & ¬ ?s2 == ATTR )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  NMOD-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt EN_transfer_rel_ARG_NMOD : EN_transfer_relations
[
  leftside = [
c:?Xl {
  c:pos = "NN"
  ?r-> c:?Yl {
  }
}

language.id.iso.EN
(?r == I | ?r == II | ?r == III | ?r == IV | ?r == V | ?r == VI | ?r == VII | ?r == VIII | ?r == IX | ?r == X | ?r == XI)

¬ ( ?r == II & c:?Xl { ( c:dlex = "coffee_shop" | c:dlex = "pub" | c:dlex = "restaurant" ) } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  NMOD-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

/*Ugly patch for E2E inputs; think of how to handle appositions properly in English some day.*/
DSynt<=>SSynt EN_transfer_rel_ARG_COORD : EN_transfer_relations
[
  leftside = [
c:?Xl {
  c:pos = "NN"
  ?r-> c:?Yl {
  }
}

language.id.iso.EN

( ?r == II & c:?Xl { ( c:dlex = "coffee_shop" | c:dlex = "pub" | c:dlex = "restaurant" ) } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  COORD-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

/*For some reason SUFFIX gives problems with the linearization, when checking the lexicon.
Also tried SUFFIPF, also does not work.*/
DSynt<=>SSynt EN_transfer_rel_ATTR_SUFFIX : EN_transfer_relations
[
  leftside = [
c:?Xl {
  c:pos = "NN"
  ATTR-> c:?Yl {
    c:pos = "POS"
  }
}

language.id.iso.EN

// don't duplicate ATTR in case there is already a relation between the nodes (close to impossible to manage in previous level)
¬ ( c:?Zl { c:?s-> c:?Yl {} } & ¬ ?s == ATTR )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  NMOD_SUF-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

/*TEST EXTR instead of ADV in order to force linearizer to push adv at the end.*/
DSynt<=>SSynt EN_transfer_rel_ATTR_ADV : EN_transfer_relations
[
  leftside = [
c:?Xl {
  ¬c:pos = "NN"
  ¬c:pos = "NP"
  ¬c:pos = "JJ"
  ¬c:pos = "RP"
  ATTR-> c:?Yl {
    ¬c:pos="HYPH"
  }
}

language.id.iso.EN

// don't duplicate ATTR in case there is already a relation between the nodes (close to impossible to manage in previous level)
¬ ( c:?Zl { c:?s-> c:?Yl {} } & ¬ ?s == ATTR )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //¬rc:bottom=yes
  //¬rc:middle=yes
  ¬(rc:top=yes & ¬rc:spos=auxiliary)
  ADV-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}

¬ ( rc:?Mr { rc:VC-> rc:?Xr { rc:<=> ?Xl } } )

(¬ rc:?Xr { rc:bottom=yes & ¬rc:finiteness="FIN" } | ( rc:?TO { rc:?rel-> rc:?Xr {} } & (?rel == PMOD | ?rel == IM ) ) )
  ]
]

DSynt<=>SSynt EN_transfer_rel_ATTR_HYPH : EN_transfer_relations
[
  leftside = [
c:?Xl {
  ¬c:pos = "NN"
  ¬c:pos = "JJ"
  ¬c:pos = "RP"
  ATTR-> c:?Yl {
    c:pos="HYPH"
  }
}

language.id.iso.EN

// don't duplicate ATTR in case there is already a relation between the nodes (close to impossible to manage in previous level)
¬ ( c:?Zl { c:?s-> c:?Yl {} } & ¬ ?s == ATTR )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  HYPH-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt EN_transfer_rel_I_LGS : EN_transfer_relations
[
  leftside = [
c:?Xl {
//  spos="VV"
  ¬c:voice="PASS"
  I-> c:?Yl {
    ( c:lemma="by" | c:dlex="by" )
  }
}

language.id.iso.EN

// there is no mapping in the lexicon already
¬ ( c:?Xl { c:lex = ?lexXl } & lexicon.?lexXl.gp.I.rel.?R & lexicon.?lexXl.gp.I.prep.?prep & ?prep == "by" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  LGS-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt EN_transfer_rel_I_II_SBJ : EN_transfer_relations
[
  leftside = [
c:?Xl {
  (c:pos = "VB" | c:pos="MD" | c:pos="JJ")
  ?r-> c:?Yl {}
}

language.id.iso.EN
((?r == I & c:?Xl {¬c:voice="PASS"} & c:?Yl {¬( c:lemma="by" | c:dlex="by" )}) | (?r == II & c:?Xl {c:voice="PASS"}))

¬ ( c:?Xl { ( c:finiteness="INF" | c:finiteness ="PART" ) ¬ c:?rel-> c:?WRB { c:pos = "WRB" } } & ?r == I )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬(rc:bottom=yes & ¬rc:finiteness="FIN")
  ¬(rc:middle=yes & ¬rc:VC-> rc:?Nr {})
  ¬(rc:top=yes & ¬rc:spos=auxiliary)
//  ¬rc:middle=yes
  SBJ-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
¬rc:?Mr {rc:VC-> rc:?Xr {}}
  ]
]

DSynt<=>SSynt EN_transfer_rel_I_II_SBJ_PART : EN_transfer_relations
[
  leftside = [
c:?Xl {
  (c:pos = "VB" | c:pos="MD")
  c:finiteness = "PART"
  ¬voice="PASS"
  I-> c:?Yl {
    ¬( c:lemma="by" | c:dlex="by" )
  }
  ¬c:?rel-> c:?WRB {
    c:pos = "WRB"
  }
}

language.id.iso.EN

// don't apply for raising and control verbs
// UPDATE: ?Yl should not be transferred in the first place...
//¬ ( c:?Zl { c:pos = "VB" c:?r-> c:?Xl {} c:?s-> c:?X2l {} }
//   & ( c:?Yl {<-> c:?X2l {} } | c:?Z2l {<-> c:?Yl {} } )
//)
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  LGS-> ?Br {
    slex="by"
    <=> ?Yl
    lgs = yes
  //  lemma = "by"
    pos = "IN"
    //include = bubble_of_gov
    spos=preposition
    top = yes
    PMOD-> rc:?Yr {
      rc:<=> ?Yl
      bottom = yes
      ¬rc:slex = "by"
      ¬rc:bottom=yes
      ¬rc:middle=yes
    }
  }
}
  ]
]

DSynt<=>SSynt EN_transfer_rel_I_II_SBJ_INF : EN_transfer_relations
[
  leftside = [
c:?Xl {
  (c:pos = "VB" | c:pos="MD")
  c:finiteness="INF"
  ¬voice="PASS"
  I-> c:?Yl {
    ¬( c:lemma="by" | c:dlex="by" )
  }
  ¬c:?rel-> c:?WRB {
    c:pos = "WRB"
  }
}

language.id.iso.EN

// don't apply for raising and control verbs
// UPDATE: ?Yl should not be transferred in the first place...
//¬ ( c:?Zl { c:pos = "VB" c:?r-> c:?Xl {} c:?s-> c:?X2l {} }
//   & ( c:?Yl {<-> c:?X2l {} } | c:?Z2l {<-> c:?Yl {} } )
//)
  ]
  mixed = [
// so rule only applies once in case of multiple correspondence situation
//(
( rc:?Xr { rc:<=> ?Xl rc:id = ?idr } & ?idr == ?Xl.id )
//   | ( rc:?Xr { rc:<=> ?Xl rc:VC-> rc:?OtherXr { rc:<=> ?Xl rc:id = ?id2r } } & ?id2r == ?Xl.id )
//)
  ]
  rightside = [
rc:?Mr {
  rc:?r-> rc:?Xr {
    rc:<=> ?Xl
  }
  LGS-> ?Br {
    slex="for"
  //  lemma = "by"
    pos = "IN"
    include = bubble_of_gov
    spos=preposition
    PMOD-> rc:?Yr {
      rc:<=> ?Yl
      ¬rc:bottom=yes
      ¬rc:middle=yes
    }
  }
}

( ( ?r == PMOD | ?r == IM ) | ( ?r == ADV & rc:?Mr {rc:slex = "to"} ) )
  ]
]

DSynt<=>SSynt EN_transfer_rel_I_II_SBJ_INF2 : EN_transfer_relations
[
  leftside = [
c:?Xl {
  (c:pos = "VB" | c:pos="MD")
  c:finiteness="INF"
  ¬voice="PASS"
  I-> c:?Yl {
    ¬( c:lemma="by" | c:dlex="by" )
  }
  ¬c:?rel-> c:?WRB {
    c:pos = "WRB"
  }
}

language.id.iso.EN

// don't apply for raising and control verbs
// UPDATE: ?Yl should not be transferred in the first place...
//¬ ( c:?Zl { c:pos = "VB" c:?r-> c:?Xl {} c:?s-> c:?X2l {} }
//   & ( c:?Yl {<-> c:?X2l {} } | c:?Z2l {<-> c:?Yl {} } )
//)
  ]
  mixed = [
// so rule only applies once in case of multiple correspondence situation
( rc:?Xr { rc:<=> ?Xl rc:VC-> rc:?OtherXr { rc:<=> ?Xl rc:id = ?id2r } } & ?id2r == ?Xl.id )
  ]
  rightside = [
rc:?Mr {
  rc:?r-> rc:?Xr {
    rc:<=> ?Xl
  }
  LGS-> ?Br {
    slex="for"
  //  lemma = "by"
    pos = "IN"
    include = bubble_of_gov
    spos=preposition
    PMOD-> rc:?Yr {
      rc:<=> ?Yl
      ¬rc:bottom=yes
      ¬rc:middle=yes
    }
  }
}

( ( ?r == PMOD | ?r == IM ) | ( ?r == ADV & rc:?Mr {rc:slex = "to"} ) )
  ]
]

DSynt<=>SSynt EN_transfer_rel_II_CONJ : EN_transfer_relations
[
  leftside = [
c:?Xl {
  (c:pos="CC" | c:lemma="/")
  II-> c:?Yl {}
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  CONJ-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt EN_transfer_rel_II_IM : EN_transfer_relations
[
  leftside = [
c:?Xl {
  c:pos="TO"
  II-> c:?Yl {}
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  IM-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt EN_transfer_rel_II_OBJ : EN_transfer_relations
[
  leftside = [
c:?Xl {
  (c:pos = "VB" | c:pos="MD")
  ¬ ( c:lemma="be" | c:dlex="be" )
  ¬c:voice="PASS"
  II-> c:?Yl {}
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  OBJ-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt EN_transfer_rel_II_PRD : EN_transfer_relations
[
  leftside = [
c:?Xl {
  (c:pos = "VB" | c:pos="MD")
  ¬c:voice="PASS"
  ( c:lemma="be" | c:dlex="be" )
  II-> c:?Yl {}
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  PRD-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt EN_transfer_rel_II_PMOD : EN_transfer_relations
[
  leftside = [
c:?Xl {
  (c:pos = "IN" | c:pos = "RB")
  II-> c:?Yl {
    ¬(c:pos = "VB" | c:pos="MD")
  }
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  PMOD-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt EN_transfer_rel_II_SUB : EN_transfer_relations
[
  leftside = [
c:?Xl {
  (c:pos="IN" | c:pos="RB" | c:pos="WDT")
  II-> c:?Yl {
    (c:pos = "VB" | c:pos="MD")
  }
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  SUB-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt EN_transfer_rel_II_III_DIR : EN_transfer_relations
[
  leftside = [
c:?Xl {
  II_III-> c:?Yl {}
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  DIR-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt EN_transfer_rel_III_EXT : EN_transfer_relations
[
  leftside = [
c:?Xl {
  ¬c:pos = "NN"
  ¬dative_shift = "DO"
  III-> c:?Yl {
    ¬c:pos="TO"
  }
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  EXT-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt EN_transfer_rel_III_IOBJ : EN_transfer_relations
[
  leftside = [
c:?Xl {
  ¬c:pos = "NN"
  dative_shift = "DO"
  III-> c:?Yl {
    ¬c:pos="TO"
  }
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  IOBJ-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt EN_transfer_rel_III_OPRD : EN_transfer_relations
[
  leftside = [
c:?Xl {
  ¬c:pos = "NN"
  III-> c:?Yl {
    c:pos="TO"
  }
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  OPRD-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt EN_transfer_rel_IV_plus : EN_transfer_relations
[
  leftside = [
c:?Xl {
  ¬c:pos = "NN"
  ?r-> c:?Yl {}
}

language.id.iso.EN

( ?r == IV | ?r == V | ?r == VI | ?r == VII | ?r == VIII | ?r == IX | ?r == X | ?r == XI)
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  EXT-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

excluded DSynt<=>SSynt EN_transfer_rel_V : EN_transfer_relations
[
  leftside = [
c:?Xl {
  ¬c:pos = "NN"
  V-> c:?Yl {}
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  EXT-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt CA_EL_ES_FR_IT_PT_transfer_rel_COORD : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  COORD-> c:?Yl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bottom=yes
  ¬rc:middle=yes
  coord-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt CA_EL_ES_FR_IT_PT_transfer_rel_NAME_NAME : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  NAME-> c:?Yl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  aux_phras-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt CA_EL_ES_FR_IT_PT_transfer_rel_APPEND : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  ?r-> c:?Yl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

( ?r == APPEND | ( c:?Xl { c:pos = "IN" } & ?r == I ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ( ¬rc:top=yes | rc:spos=auxiliary | rc:spos=modal )
  adjunct-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}


¬ rc:?Xr { rc:middle=yes &
 ¬ (rc:analyt_perf-> rc:?N1r {} | rc:analyt_pass-> rc:?N2r {} | rc:analyt_progr-> rc:?N3r {} | rc:analyt_fut-> rc:?N4r {} | rc:modal-> rc:?N5r {} ) }
¬rc:?M1r {rc:analyt_perf-> rc:?Xr {}}
¬rc:?M2r {rc:analyt_pass-> rc:?Xr {}}
¬rc:?M3r {rc:analyt_progr-> rc:?Xr {}}
¬rc:?M4r {rc:analyt_fut-> rc:?Xr {}}
¬rc:?M5r {rc:modal-> rc:?Xr {}}
  ]
]

DSynt<=>SSynt CA_EL_ES_FR_IT_PT_transfer_rel_ATTR_modif : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  ( c:pos = "NN" | c:pos = "NP" )
  ATTR-> c:?Yl {
    ( c:pos = "JJ" | c:finiteness = "PART" )
  }
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  modif-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

excluded DSynt<=>SSynt CA_EL_ES_FR_IT_PT_transfer_rel_ATTR_modif_NP : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  c:pos = "NP"
  ATTR-> c:?Yl {
    c:finiteness = "PART"
  }
}

( language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.EL | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  modif-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt CA_EL_ES_FR_IT_PT_transfer_rel_ATTR_appos : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  c:pos = "NN"
  ATTR-> c:?Yl {
    ( c:pos = "NN" | c:pos = "NP" )
  }
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  appos-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt CA_EL_ES_FR_IT_PT_transfer_rel_ATTR_det : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  c:pos = "NN"
  ATTR-> c:?Yl {
    c:pos = "DT"
  }
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  det-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt CA_EL_ES_FR_IT_PT_transfer_rel_ATTR_relat : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  ( c:pos = "NN" | c:pos = "NP" )
  ATTR-> c:?Yl {
    c:pos = "VB"
    c:finiteness = "FIN"
  }
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  relat-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt CA_EL_ES_FR_IT_PT_transfer_rel_ATTR_attr : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  c:pos = "NN"
  ATTR-> c:?Yl {
    ( (c:pos = "VB" ¬c:finiteness = "FIN" ¬c:finiteness = "PART" ) | c:pos = "IN" | c:pos = "RB" )
  }
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  attr-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt CA_EL_ES_FR_IT_PT_transfer_rel_ATTR_quant : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  c:pos = "NN"
  ATTR-> c:?Yl {
    c:dlex = ?d
  }
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

( ?d == 0 | ?d < 0 | ?d > 0 | ?Yl.pos == "CD" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  quant-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt CA_EL_ES_FR_IT_PT_transfer_rel_ARG_obl_compl : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  ( c:pos = "NN" | c:pos = "JJ" )
  ?r-> c:?Yl {
    ¬(c:pos = "VB" | c:pos="MD")
  }
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

(?r == I | ?r == II | ?r == III | ?r == IV | ?r == V)
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  obl_compl-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

/*This rule is too generic.*/
DSynt<=>SSynt CA_EL_ES_FR_IT_PT_transfer_rel_ATTR_adv : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  ¬c:pos = "NN"
  ¬c:pos = "NP"
  //¬c:pos = "JJ"
  ATTR-> c:?Yl { }
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

// see CA_EL_ES_FR_IT_transfer_rel_ATTR_compar
¬ ( ?Xl.pos == "JJ" & ?Yl.type == "comparative" )
  ]
  mixed = [
// If X is an adjective the rule should apply (despite the other conditions)
// There are ome restrictions in the lexicon wrt how some adverbs can combine; 190709WebNLG_eval_ALL_es.conll, 182
// See CA_EL_ES_FR_IT_transfer_rel_ATTR_adv bottom
?Xl.pos == "JJ" | ( ¬ ( c:?Yl { c:lex = ?lex1 } & lexicon.?lex1.gov.finiteness.?f1 )
 | ( c:?Yl { c:lex = ?lex2 } & lexicon.?lex2.gov.finiteness.?f2 & rc:?Xr { ( ¬rc:top=yes | rc:spos=auxiliary ) rc:<=> ?Xl rc:finiteness = ?fR2 } & ?f2 == ?fR2 
   & ¬rc:?N1r {rc:analyt_perf-> rc:?Xr {}} & ¬rc:?N2r {rc:analyt_pass-> rc:?Xr {}} & ¬rc:?N3r {rc:analyt_progr-> rc:?Xr {}} & ¬rc:?N4r {rc:analyt_fut-> rc:?Xr {}}
 )
)

// BUG MATE: weird error if activated with the condition above, but works alone (no Inc state found; 190709WebNLG_eval_ALL_es.conll, 182
// not really needed so far
//( ¬ ( c:?Yl { c:lex = ?lex3 } & lexicon.?lex3.gov.pos.?p3 )
// | ( c:?Yl { c:lex = ?lex4 } & lexicon.?lex4.gov.pos.?p4 & rc:?Xr { ( ¬rc:top=yes | rc:spos=auxiliary ) rc:<=> ?Xl rc:pos = ?pR4 } & ?p4 == ?pR4 
//   & ¬rc:?P1r {rc:analyt_perf-> rc:?Xr {}} & ¬rc:?P2r {rc:analyt_pass-> rc:?Xr {}} & ¬rc:?P3r {rc:analyt_progr-> rc:?Xr {}} & ¬rc:?P4r {rc:analyt_fut-> rc:?Xr {}}
// )
//)
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //¬rc:bottom=yes
  //¬rc:middle=yes
  //( ¬rc:top=yes | rc:spos=auxiliary )
  // if Xr is a verb it should be the one that will be inflected, if not, then don't choose the top node 
  ( rc:finiteness="FIN" | rc:finiteness="PART" | ( ¬rc:top=yes & ¬rc:pos="VB" )  )
  adv-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
¬rc:?M1r {rc:analyt_perf-> rc:?Xr {}}
¬rc:?M2r {rc:analyt_pass-> rc:?Xr {}}
¬rc:?M3r {rc:analyt_progr-> rc:?Xr {}}
¬rc:?M4r {rc:analyt_fut-> rc:?Xr {}}
//¬rc:?M5r {rc:modal-> rc:?Xr {}}
  ]
]

DSynt<=>SSynt CA_EL_ES_FR_IT_PT_transfer_rel_ATTR_adv_bottom : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  ¬c:pos = "NN"
  ¬c:pos = "NP"
  //¬c:pos = "JJ"
  ATTR-> c:?Yl { }
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

// see CA_EL_ES_FR_IT_transfer_rel_ATTR_compar
¬ ( ?Xl.pos == "JJ" & ?Yl.type == "comparative" )

( c:?Yl { c:lex = ?lex2 } & lexicon.?lex2.gov.finiteness.?f2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
 rc:bottom=yes
 rc:finiteness = ?fR2
  adv-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}

?f2 == ?fR2
  ]
]

/*This rule is too generic.*/
DSynt<=>SSynt CA_EL_ES_FR_IT_PT_transfer_rel_ATTR_compar : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  c:pos = "JJ"
  ATTR-> c:?Yl {
    c:type = "comparative"
  }
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  //¬rc:bottom=yes
  //¬rc:middle=yes
  ( ¬rc:top=yes | rc:spos=auxiliary )
  compar-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
¬rc:?M1r {rc:analyt_perf-> rc:?Xr {}}
¬rc:?M2r {rc:analyt_pass-> rc:?Xr {}}
¬rc:?M3r {rc:analyt_progr-> rc:?Xr {}}
¬rc:?M4r {rc:analyt_fut-> rc:?Xr {}}
//¬rc:?M5r {rc:modal-> rc:?Xr {}}
  ]
]

DSynt<=>SSynt CA_EL_ES_FR_IT_PT_transfer_rel_I_II_subj : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  (c:pos = "VB" | c:pos="MD")
  ?r-> c:?Yl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

( (?r == I & c:?Xl { ¬c:voice="PASS" } & c:?Yl { ¬c:lemma="por" } )
| (?r == II & c:?Xl { c:voice="PASS" } )
)

¬ (c:?Xl { ( c:finiteness="INF" | c:finiteness="PART" ) } & ?r == I )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬(rc:bottom=yes & ¬rc:finiteness="FIN")
  //¬(rc:middle=yes & ¬rc:VC-> rc:?Nr {})
  ( ¬rc:top=yes | rc:spos=auxiliary | rc:spos=modal )
//  ¬rc:middle=yes
  subj-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
¬ rc:?Xr { rc:middle=yes &
 ¬ (rc:analyt_perf-> rc:?N1r {} | rc:analyt_pass-> rc:?N2r {} | rc:analyt_progr-> rc:?N3r {} | rc:analyt_fut-> rc:?N4r {} | rc:modal-> rc:?N5r {} ) }

¬rc:?M1r {rc:analyt_perf-> rc:?Xr {}}
¬rc:?M2r {rc:analyt_pass-> rc:?Xr {}}
¬rc:?M3r {rc:analyt_progr-> rc:?Xr {}}
¬rc:?M4r {rc:analyt_fut-> rc:?Xr {}}
¬rc:?M5r {rc:modal-> rc:?Xr {}}
  ]
]

DSynt<=>SSynt ES_transfer_rel_I_II_agent : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  (c:pos = "VB" | c:pos="MD")
  c:finiteness=?fin
  ¬voice="PASS"
  I-> c:?Yl {
    ¬c:lemma="por"
  }
}

language.id.iso.ES

( ?fin == "INF" | ?fin == "PART" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:finiteness = ?fin
  agent-> ?Br {
    slex="por"
  //  lemma = "by"
    pos = "IN"
    spos=preposition
    include = bubble_of_gov
    prepos-> rc:?Yr {
      rc:<=> ?Yl
      ¬rc:bottom=yes
      ¬rc:middle=yes
    }
  }
}
  ]
]

DSynt<=>SSynt FR_transfer_rel_I_II_agent : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  (c:pos = "VB" | c:pos="MD")
  c:finiteness=?fin
  ¬voice="PASS"
  I-> c:?Yl {
    ¬c:lemma="par"
  }
}

language.id.iso.FR

( ?fin == "INF" | ?fin == "PART" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:finiteness = ?fin
  agent-> ?Br {
    slex="par"
  //  lemma = "by"
    pos = "IN"
    spos=preposition
    include = bubble_of_gov
    prepos-> rc:?Yr {
      rc:<=> ?Yl
      ¬rc:bottom=yes
      ¬rc:middle=yes
    }
  }
}
  ]
]

DSynt<=>SSynt IT_transfer_rel_I_II_agent : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  (c:pos = "VB" | c:pos="MD")
  c:finiteness=?fin
  ¬voice="PASS"
  I-> c:?Yl {
    ¬c:lemma="de"
  }
}

language.id.iso.IT

( ?fin == "INF" | ?fin == "PART" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:finiteness = ?fin
  agent-> ?Br {
    slex="de"
  //  lemma = "by"
    pos = "IN"
    spos=preposition
    include = bubble_of_gov
    prepos-> rc:?Yr {
      rc:<=> ?Yl
      ¬rc:bottom=yes
      ¬rc:middle=yes
    }
  }
}
  ]
]

DSynt<=>SSynt PT_transfer_rel_I_II_agent : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  (c:pos = "VB" | c:pos="MD")
  c:finiteness=?fin
  ¬voice="PASS"
  I-> c:?Yl {
    ¬c:lemma="de"
  }
}

language.id.iso.PT

( ?fin == "INF" | ?fin == "PART" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:finiteness = ?fin
  agent-> ?Br {
    slex="por"
  //  lemma = "by"
    pos = "IN"
    spos=preposition
    include = bubble_of_gov
    prepos-> rc:?Yr {
      rc:<=> ?Yl
      ¬rc:bottom=yes
      ¬rc:middle=yes
    }
  }
}
  ]
]

DSynt<=>SSynt CA_EL_ES_FR_IT_PT_transfer_rel_II_coord_conj : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  (c:pos="CC" | c:lemma="/")
  II-> c:?Yl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  coord_conj-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt CA_EL_ES_FR_IT_PT_transfer_rel_II_dobj : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  (c:pos = "VB" | c:pos="MD")
  ¬c:voice="PASS"
  II-> c:?Yl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

¬ ( language.id.iso.FR & c:?Xl {c:lemma = "être" } & c:?Yl { c:finiteness = "GER" } )

//¬ ( language.id.iso.ES & c:?Xl { ( c:lemma = "ser" | c:lemma = "estar" ) } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  rc:spos = ?s
  ¬rc:?REL-> rc:?Fr { rc:<=> ?Yl }
  dobj-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:pos = "IN"
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}

¬?s == "copula"
  ]
]

DSynt<=>SSynt CA_EL_ES_FR_IT_PT_transfer_rel_II_obl_obj : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  (c:pos = "VB" | c:pos="MD")
  ¬c:voice="PASS"
  II-> c:?Yl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

¬ ( language.id.iso.CA & ( ?Xl.lex == "ser_VB_01" | ?Xl.lex == "estar_VB_01" ) )
¬ ( language.id.iso.ES & ( ?Xl.lex == "ser_VB_01" | ?Xl.lex == "estar_VB_01" | ?Xl.lex == "ser_VB_02" ) )
¬ ( language.id.iso.FR & ?Xl.lex == "être_VB_01" )
¬ ( language.id.iso.EL & ?Xl.lex == "είμαι_VB_01" )
¬ ( language.id.iso.PT & ( ?Xl.lex == "ser_VB_01" | ?Xl.lex == "estar_VB_01" ) )
¬ ( language.id.iso.IT & ( ?Xl.lex == "essere_VB_01" | ?Xl.lex == "stare_VB_01" ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  obl_obj-> rc:?Yr {
    rc:<=> ?Yl
    rc:pos = "IN"
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt CA_EL_ES_FR_IT_PT_transfer_rel_II_copul : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  (c:pos = "VB" | c:pos="MD")
  ¬c:voice="PASS"
  II-> c:?Yl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:spos="copula"
  ¬rc:top=yes
  ¬rc:middle=yes
  copul-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt CA_EL_ES_FR_IT_PT_transfer_rel_II_prepos : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  (c:pos = "IN" | c:pos = "RB")
  II-> c:?Yl {
    ¬(c:pos = "VB" | c:pos="MD")
  }
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  prepos-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt CA_EL_ES_FR_IT_PT_transfer_rel_II_sub_conj : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  (c:pos="IN" | c:pos="RB" | c:pos="WDT")
  II-> c:?Yl {
    (c:pos = "VB" | c:pos="MD")
  }
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  sub_conj-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt CA_EL_ES_FR_IT_PT_transfer_rel_III_iobj : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  III-> c:?Yl {
    ¬c:pos="TO"
  }
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  iobj-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt CA_EL_ES_FR_IT_PT_transfer_rel_obl_obj : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  ¬c:pos = "NN"
  IV-> c:?Yl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  obl_obj-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt CA_EL_ES_FR_IT_PT_transfer_rel_V : CA_EL_ES_FR_IT_PT_transfer_relations
[
  leftside = [
c:?Xl {
  ¬c:pos = "NN"
  V-> c:?Yl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  obl_obj-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt PL_rel_lexicon_I : PL_transfer_relations
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  ?r-> c:?Yl {}
}

language.id.iso.PL

lexicon.?lex.gp.?r.rel.?R
( ?R == subj | ?R == adjunct )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ( rc:pos = "VB" | rc:pos = "MD" )
  ¬ ( rc:bottom = yes & ¬rc:finiteness="FIN" )
  ¬ ( rc:middle = yes & ¬rc:finiteness="FIN" )
  ?R-> rc:?Yr {
    rc:<=> ?Yl
   ¬rc:bottom = yes
   ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt PL_rel_lexicon : PL_transfer_relations
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  ?r-> c:?Yl {}
}

language.id.iso.PL

lexicon.?lex.gp.?r.rel.?R
  ]
  mixed = [
¬ ( rc:?Xr { ( rc:top = yes | rc:middle = yes ) } & ¬ ( ?R == subj | ?R == adjunct ) )
¬ ( ?R == subj | ?R == adjunct )

//  ¬(rc:bottom=yes & ¬rc:finiteness="FIN")
//  ¬(rc:middle=yes & ¬rc:VC-> rc:?Nr {})
//  ¬(rc:top=yes & ¬rc:spos=auxiliary)
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
    //¬rc:top=yes
    //¬rc:middle=yes
  ?R-> rc:?Yr {
    rc:<=> ?Yl
   ¬rc:bottom = yes
   ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt PL_rel_ATTR_adv : PL_transfer_relations
[
  leftside = [
c:?Xl {
  // see ATTR NMOD
  ¬c:pos = "NN"
  ATTR-> c:?Yl {
    // see ATTR quant
    ¬c:pos = "CD"
  }
}

language.id.iso.PL
// see ATTR_restr
¬ ( c:?Yl { c:lex = ?lex } & lexicon.?lex.restrictive.yes )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  adv-> rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

DSynt<=>SSynt PL_rel_ATTR_NMOD : PL_transfer_relations
[
  leftside = [
c:?Xl {
  c:pos = "NN"
  ATTR-> c:?Yl {
    ¬c:pos = "CD"
  }
}

language.id.iso.PL
// see ATTR_restr
¬ ( c:?Yl { c:lex = ?lex } & lexicon.?lex.restrictive.yes )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  NMOD-> rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

DSynt<=>SSynt PL_rel_ATTR_quant : PL_transfer_relations
[
  leftside = [
c:?Xl {
  ATTR-> c:?Yl {
    c:pos = "CD"
  }
}

language.id.iso.PL
// see ATTR_restr
¬ ( c:?Yl { c:lex = ?lex } & lexicon.?lex.restrictive.yes )

//( ?r == ATTR | ?r == II )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  quant-> rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

DSynt<=>SSynt PL_rel_ATTR_restr : PL_transfer_relations
[
  leftside = [
c:?Xl {
  ATTR-> c:?Yl {
    c:lex = ?lex
  }
}

language.id.iso.PL
lexicon.?lex.restrictive.yes
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  restr-> rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

/*Are the RS conditions correct? It looks like it works for governed preps, but what about auxiliaries?*/
DSynt<=>SSynt PL_rel_COORD : PL_transfer_relations
[
  leftside = [
c:?Xl {
  COORD-> c:?Yl {}
}

language.id.iso.PL
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:top=yes
  ¬rc:middle=yes
  coord-> rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bottom=yes
    ¬rc:middle=yes
  }
}
  ]
]

DSynt<=>SSynt K_attr_gest_fen : K_attr_gestures
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

DSynt<=>SSynt K_attr_gest_fex : K_attr_gestures
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

DSynt<=>SSynt K_attr_gest_fin : K_attr_gestures
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

DSynt<=>SSynt K_attr_gest_att : K_attr_gestures
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

DSynt<=>SSynt K_attr_gest_exp : K_attr_gestures
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

DSynt<=>SSynt K_attr_gest_pro : K_attr_gestures
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

DSynt<=>SSynt K_attr_gest_soc : K_attr_gestures
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

DSynt<=>SSynt K_attr_gest_sty : K_attr_gestures
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

DSynt<=>SSynt K_attr_gest_sa : K_attr_gestures
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

/*Between is as a dependent in our structures, but imposes
 a case on the governor (between 1 and 4 times)*/
DSynt<=>SSynt PL_case_between : PL_attributes
[
  leftside = [
c:?Xl {
  c:II-> c:?Yl {
    c:lex = "między_IN_01"
    c:II-> c:?Num {
      c:pos = "CD"
    }
  }
}

language.id.iso.PL
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  case = "ins"
  number = "PL"
}
  ]
]

DSynt<=>SSynt PL_case_default : PL_attributes
[
  leftside = [
c:?Xl {
  ¬case = ?n
}

language.id.iso.PL
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:case=?g
  case="nom"
}
  ]
]

DSynt<=>SSynt PL_person_number_ty : PL_attributes
[
  leftside = [
c:?Xl {
  c:lex = "ty_PRP_01"
}

language.id.iso.PL
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  person = "2"
  number = "SG"
}
  ]
]

DSynt<=>SSynt attr_ambiguous_antecedent : anaphora
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

DSynt<=>SSynt attr_definiteness : anaphora
[
  leftside = [
c:?Xl {
  c:definiteness = ?n
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

DSynt<=>SSynt attr_SameLocAsPrevious : anaphora
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

DSynt<=>SSynt attr_Subtree_coref : anaphora
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

