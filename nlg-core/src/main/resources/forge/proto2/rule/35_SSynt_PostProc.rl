SSynt<=>SSynt transfer_nodes
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

SSynt<=>SSynt transfer_relations
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

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

SSynt<=>SSynt markers
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

SSynt<=>SSynt rewrite_node_empty_sentence
[
  leftside = [
c:?Bl {
  c:slex = "Sentence"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Br {
  rc:<=> ?Bl
  rc:depth = "1.0"
  ¬rc:?Xr {}
  slex = "[...]"
}
  ]
]

/* If the governing noun is the second argument of a verb and has an indefinite determiner, no comma and "that" instead of "which".
See also mark_modifier_subtree1.*/
SSynt<=>SSynt change_rel_pro_no_comma
[
  leftside = [
c:?Govl {
  c:pos = ?pos
  c:?r-> c:?Xl {
    ( c:pos = "NN" | c:pos = "NP" )
    c:NMOD-> c:?Det {
      c:slex = "a"
    }
    c:NMOD-> c:?Yl {
      c:pos = "VB"
      c:?s-> c:?RelPro {
        c:slex = "which"
      }
    }
  }
}


  
( ?pos == "VB" | ?pos == "MD" )     
( ?r == DOBJ | ?r == PRD )
  ]
  mixed = [

  ]
  rightside = [
rc:?RelProR {
  rc:<=> ?RelPro
  slex = "that"
}
  ]
]

/*Rule change_rel_pro_no_comma: 
If the governing noun is the second argument of a verb and has an indefinite determiner, no comma and "that" instead of "which".
Under the same conditions, this rule introduces a gerund randomly.
Part 1 of the rule assigns random number.*/
SSynt<=>SSynt block_rel_pro_no_comma1
[
  leftside = [
c:?Govl {
  c:pos = ?pos
  c:?r-> c:?Xl {
    ( c:pos = "NN" | c:pos = "NP" )
    c:NMOD-> c:?Det {
      c:slex = "a"
    }
    c:NMOD-> c:?Yl {
      c:pos = "VB"
      c:SBJ-> c:?RelPro {
        c:slex = "which"
      }
    }
  }
}


  
( ?pos == "VB" | ?pos == "MD" )     
( ?r == DOBJ | ?r == PRD )
  ]
  mixed = [

  ]
  rightside = [
rc:?RelProR {
  rc:<=> ?RelPro
  random = #randInt()# 
}

rc:?Yr {
  rc:<=> ?Yl
  random = #randInt()# 
}
  ]
]

/*Rule change_rel_pro_no_comma: 
If the governing noun is the second argument of a verb and has an indefinite determiner, no comma and "that" instead of "which".
Under the same conditions, this rule introduces a gerund randomly.
Part 2 of the rule makes it happen.*/
SSynt<=>SSynt block_rel_pro_no_comma2
[
  leftside = [
c:?Govl {
  c:pos = ?pos
  c:?r-> c:?Xl {
    ( c:pos = "NN" | c:pos = "NP" )
    c:NMOD-> c:?Det {
      c:slex = "a"
    }
    c:NMOD-> c:?Yl {
      c:pos = "VB"
      ¬c:lex = "be_VB_01"
      c:SBJ-> c:?RelPro {
        c:slex = "which"
      }
    }
  }
}


  
( ?pos == "VB" | ?pos == "MD" )     
( ?r == DOBJ | ?r == PRD )
  ]
  mixed = [

  ]
  rightside = [
rc:?RelProR {
  rc:<=> ?RelPro
  rc:random = ?r1
  block = "yes"
}

rc:?Yr {
  rc:<=> ?Yl
  rc:random = ?r2
  rc:finiteness = "FIN"
  finiteness = "GER"
}

?r1 > ?r2
  ]
]

SSynt<=>SSynt transfer_node_basic : transfer_nodes
[
  leftside = [
?Xl {
  slex= ?s
  ¬c:block = "yes"
  //( ¬c:block = "yes" | c:cancel_block = "yes" )
  ¬c:comma_substitute = "yes"
}

¬ ( c:?Y1l { c:?r1-> ?Xl {} } & ¬?r1 == SBJ
    & lexicon.miscellaneous.personal_pronouns.correspondences.?s )

// if a verb has a prefix and is the main verb or is introduced by "zu", the prefix must be separated
// see DE_transfer_nodes_prefix
¬ ( language.id.iso.DE & ?Xl { c:lex = ?lex } & lexicon.?lex.prefix
  & ( ¬c:?Y2l { c:?r2-> ?Xl {} } | c:?Y3l { c:slex = "zu" c:PMOD-> ?Xl {} } ) )

¬ ( language.id.iso.DE & ?Xl { c:slex = "dass" } & ( c:?Y3l { c:lex = "gefallen_VB_01" c:SB-> ?Xl {} } ) )
¬ ( language.id.iso.DE & ?Xl { c:slex = "schlafen gehen" } & ¬ c:?Y4l {c:?r4-> ?Xl {} } )

¬ ( language.id.iso.DE & ?Xl { c:pos = "CD" c:slex = "1" } )

¬ ( language.id.iso.EN & ?s == Locin & ?Xl { c:PMOD-> c:?Y5l { ( c:class = "Year" | c:class = "Date" ) } } )

¬ ( language.id.iso.EN & ?s == "not" & ?Gov6l { c:AMOD-> c:?Xl {} } )
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

SSynt<=>SSynt transfer_node_pronouns : transfer_nodes
[
  leftside = [
c:?Y1l {
  c:?r1-> ?Xl {
    ¬c:block = "yes"
    //( ¬c:block = "yes" | c:cancel_block = "yes" )
    slex = ?s
  }
}

¬?r1 == SBJ

lexicon.miscellaneous.personal_pronouns.correspondences.?s.ACC.?slex
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex = ?slex
}
  ]
]

SSynt<=>SSynt transfer_node_comma : transfer_nodes
[
  leftside = [
?Xl {
  slex= ?s
  ¬c:block = "yes"
  //( ¬c:block = "yes" | c:cancel_block = "yes" )
  c:comma_substitute = "yes"
}
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex = ","
}
  ]
]

excluded SSynt<=>SSynt EN_add_det : transfer_nodes
[
  leftside = [
c:?Xl {
  c:slex = ?s
  ¬c:NMOD-> c:?Det {
    c:slex = "the"
  }
}

language.id.iso.EN

// list here possible values
( ?s == "United_States" | ?s == "United_Kingdom" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  NMOD-> ?DetR {
    slex = "the"
    pos = "DT"
    spos = "DT"
    lemma = "the"
    id = #randInt()#
    include = bubble_of_gov
  }
}
  ]
]

SSynt<=>SSynt EN_Locin_PATCH_date : transfer_nodes
[
  leftside = [
?Xl {
  slex = Locin
  c:PMOD-> c:?Yl {
    c:class = "Date"
  }
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
    slex = "on"

}
  ]
]

SSynt<=>SSynt EN_Locin_PATCH_year : transfer_nodes
[
  leftside = [
?Xl {
  slex = Locin
  c:PMOD-> c:?Yl {
    c:class = "Year"
  }
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
    slex = "in"

}
  ]
]

SSynt<=>SSynt EN_rewrite_located_to : transfer_nodes
[
  leftside = [
c:?Yl {
  c:slex = "locate"
  c:EXT-> c:?Xl {
    c:slex = "to"
    c:PMOD-> c:?Zl {
      c:slex = ?s
    }
  }
}

¬?s == "north"
¬?s == "south"
¬?s == "west"
¬?s == "east"
¬?s == "northeast"
¬?s == "northwest"
¬?s == "southeast"
¬?s == "southwest"
¬?s == "right"
¬?s == "left"
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:slex = "to"
  slex = "at"
  lex = "at_IN_01"
}
  ]
]

SSynt<=>SSynt EN_transfer_node_not_AMOD : transfer_nodes
[
  leftside = [
c:?Yl {
  c:AMOD-> ?Xl {
    slex= "not"
    ¬c:block = "yes"
    //( ¬c:block = "yes" | c:cancel_block = "yes" )
    ¬c:comma_substitute = "yes"
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
  ¬rc:added_non = "yes"
  added_non = "yes"
  slex = #"non-"+?s#
}
  ]
]

SSynt<=>SSynt rewrite_pronouns_1 : transfer_nodes
[
  leftside = [
c:?Yl {
  c:pos = "NN"
  c:NMOD-> c:?Xl {
    ( c:slex = "I" | c:slex = "i" )
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:slex = ?s
  rc:pos = ?p
  ¬rc:pronoun = replaced
  pronoun = replaced
  pronominalized = yes
  slex = "my"
  lex = "my_PRP$_01"
  pos = "PRP$"
  spos = "pronoun"
}
  ]
]

SSynt<=>SSynt rewrite_pronouns_2 : transfer_nodes
[
  leftside = [
c:?Yl {
  c:pos = "NN"
  c:NMOD-> c:?Xl {
    c:slex = "you"
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:slex = ?s
  rc:pos = ?p
  ¬rc:pronoun = replaced
  pronoun = replaced
  pronominalized = yes
  slex = "your"
  lex = "your_PRP$_01"
  pos = "PRP$"
  spos = "pronoun"
}
  ]
]

SSynt<=>SSynt rewrite_pronouns_3 : transfer_nodes
[
  leftside = [
c:?Yl {
  c:pos = "NN"
  c:NMOD-> c:?Xl {
    ( c:slex = "he" | c:slex = "she" | c:slex = "they" )
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:slex = ?s
  rc:pos = ?p
  ¬rc:pronoun = replaced
  pronoun = replaced
  pronominalized = yes
  slex = "their"
  lex = "their_PRP$_01"
  pos = "PRP$"
  spos = "pronoun"
}
  ]
]

SSynt<=>SSynt rewrite_pronouns_4 : transfer_nodes
[
  leftside = [
c:?Yl {
  c:pos = "NN"
  c:NMOD-> c:?Xl {
    c:slex = "it"
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:slex = ?s
  rc:pos = ?p
  ¬rc:pronoun = replaced
  pronoun = replaced
  pronominalized = yes
  slex = "its"
  lex = "its_PRP$_01"
  pos = "PRP$"
  spos = "pronoun"
}
  ]
]

excluded SSynt<=>SSynt rewrite_pronouns_rel1 : transfer_nodes
[
  leftside = [
c:?Yl {
  ( c:pos = "NN" | c:pos = "NP" )
  c:NMOD-> c:?Xl {
    c:finiteness = "FIN"
    c:?r-> c:?Zl {
      c:<-> c:?Yl {}
      c:pos = "NP"
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  rc:slex = ?s
  rc:pos = ?p
  slex = "who"
  lex = "who_WP_01"
  pos = "WP"
  spos = "pronoun"
}
  ]
]

excluded SSynt<=>SSynt rewrite_pronouns_rel2 : transfer_nodes
[
  leftside = [
c:?Yl {
  ( c:pos = "NN" | c:pos = "NP" )
  c:NMOD-> c:?Xl {
    c:finiteness = "FIN"
    c:?r-> c:?Zl {
      c:<-> c:?Yl {}
      ¬c:pos = "NP"
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  rc:slex = ?s
  rc:pos = ?p
  slex = "which"
  lex = "which_WDT_01"
  pos = "WDT"
  spos = "pronoun"
}
  ]
]

/*if a verb has a prefix and is the main verb or is introduced by "zu", the prefix must be separated

see transfer_node_basic*/
SSynt<=>SSynt DE_transfer_nodes_prefix : transfer_nodes
[
  leftside = [
?Xl {
  c:lex = ?lex
  ¬c:block = "yes"
  //( ¬c:block = "yes" | c:cancel_block = "yes" )
}

language.id.iso.DE
lexicon.?lex.prefix.?pref
lexicon.?lex.stem.?stem

 ( ¬c:?Y2l { c:?r2-> ?Xl {} } | c:?Y3l { c:slex = "zu" c:PMOD-> ?Xl {} } )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex = ?stem
  SVP-> ?Pr {
    slex = ?pref
    lex = #?pref+_RB_01#
    pos = "RB"
    spos = "particle"
    include = bubble_of_gov
  }
}
  ]
]

SSynt<=>SSynt DE_transfer_node_es_gefallen : transfer_nodes
[
  leftside = [
c:?Xl {
  c:lex = "gefallen_VB_01"
  c:SB-> c:?Yl {
    c:slex = "dass"
  }
}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  SB-> ?Pro {
    slex = "es"
    lex = "es_PRP_01"
    pos = "PRP"
    spos = "pronoun"
    person = "3"
    case = "nom"
    number = "SG"
    gender = "NEUTR"
    include = bubble_of_gov
    id = #randInt()#
  }
  OA2-> rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

SSynt<=>SSynt DE_transfer_node_dass_gefallen : transfer_nodes
[
  leftside = [
?Xl {
  c:slex = "dass"
  slex= ?s
  ¬c:block = "yes"
  //( ¬c:block = "yes" | c:cancel_block = "yes" )
}

language.id.iso.DE

c:?Y3l { c:lex = "gefallen_VB_01" c:SB-> ?Xl {} }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex = "wenn"
  pos = "IN"
  spos = "conjunction"
}
  ]
]

/*if a verb has a prefix and is the main verb or is introduced by "zu", the prefix must be separated

see transfer_node_basic*/
SSynt<=>SSynt DE_transfer_nodes_schalfengehen : transfer_nodes
[
  leftside = [
?Xl {
  c:slex = "schlafen gehen"
  ¬c:block = "yes"
  //( ¬c:block = "yes" | c:cancel_block = "yes" )
}

language.id.iso.DE

//only split of root, in order to send the second verb at the end of the sentence
¬ c:?Yl {c:?r-> ?Xl {} }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex ="gehen"
  OC-> ?Pr {
    slex = "schlafen"
    lex = "schlafen_VB_01"
    pos = "VB"
    spos = "verb"
    include = bubble_of_gov
  }
}
  ]
]

/*if a verb has a prefix and is the main verb or is introduced by "zu", the prefix must be separated

see transfer_node_basic*/
SSynt<=>SSynt DE_transfer_nodes_CD : transfer_nodes
[
  leftside = [
?Xl {
  c:pos = "CD"
  c:slex = "1"
  ¬c:block = "yes"
  //( ¬c:block = "yes" | c:cancel_block = "yes" )
}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  slex = "ein"
}
  ]
]

SSynt<=>SSynt fill_bubble : transfer_nodes
[
  leftside = [
c:?Bub {
  c:slex = ?d
  c:?Xl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?BubR {
  rc:<=> ?Bub
  rc:+?Xr {
    rc:<=> ?Xl
  }
}
  ]
]

SSynt<=>SSynt expand_bubble_gov : transfer_nodes
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

SSynt<=>SSynt add_expletive : transfer_nodes
[
  leftside = [
c:?Xl {
  c:slex = "be"
  c:finiteness = "FIN"
  ¬c:SBJ-> c:?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  SBJ-> ?IT {
    slex = "it"
    lex = "it_PRP_01"
    pos = "PRP"
    spos = "pronoun"
    include = bubble_of_gov
  }
}
  ]
]

excluded SSynt<=>SSynt add_parentheses_DEP : transfer_nodes
[
  leftside = [
c:?Xl {
  c:?r-> c:?Yl {
    c:type = "parenthetical"
    ¬c:?z-> c:?Zl {}
  }
}

( ?r == DEP | ?r == adjunct )
//  | ?r == NMOD | ?r == modif
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:parenth = "yes"
  rc:slex = ?s
  slex = #(+?s+)#
  parenth = "yes"
}
  ]
]

excluded SSynt<=>SSynt add_parentheses_DEP2 : transfer_nodes
[
  leftside = [
c:?Xl {
  c:?r-> c:?Yl {
    c:type = "parenthetical"
    c:?z-> c:?Zl {
      c:type = "parenthetical"
      ¬c:?w-> c:?Wl {}
    }
  }
}

( ?r == DEP | ?r == adjunct )
//  | ?r == NMOD | ?r == modif
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:parenth = "yes"
  rc:slex = ?sY
  slex = #?sY+)#
  parenth = "yes"
}

rc:?Zr {
  rc:<=> ?Zl
  ¬rc:parenth = "yes"
  rc:slex = ?sZ
  slex = #(+?sZ#
  parenth = "yes"
}
  ]
]

SSynt<=>SSynt add_quotes : transfer_nodes
[
  leftside = [
c:?Yl {
  c:type = "quoted"
}

( ¬?Yl.pos == "IN" | c:?Govl { c:type = "quoted" c:?r-> c:?Yl {} } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  rc:slex = ?s
  ¬rc:quotes = "yes"
  slex = #\"+?s+\"#
  quotes = "yes"
}
  ]
]

SSynt<=>SSynt add_also_fromConAgg1 : transfer_nodes
[
  leftside = [
c:?Yl {
  c:type = "add_also"
}

¬c:?Xl { c:type = "add_also" c:?r-> c:?Yl {} }

lexicon.miscellaneous.adverbs.also.?lex
lexicon.miscellaneous.adverbs.rel.?R
lexicon.?lex.lemma.?lem
lexicon.?lex.lemma.?pos
lexicon.?lex.lemma.?spos
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  rc:slex = ?s
  ?R-> ?IT {
    slex = ?lem
    lex = ?lex
    pos = ?pos
    spos = ?spos
    include = bubble_of_gov
    dsyntRel = ATTR
    id = #randInt()#
  }
}
  ]
]

excluded SSynt<=>SSynt add_also_fromSynt : transfer_nodes
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

/*The modif dependent is usually realized after the governor, so we can put parentheses.
This rule is a bit of a hack, it applies when a relative clause below a NP was not built.*/
SSynt<=>SSynt add_parentheses_NP_modif : transfer_nodes
[
  leftside = [
c:?Xl {
  c:pos = "NP"
  c:modif-> c:?Yl {
    ¬c:?r-> c:?Zl {}
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:parenth_added = "yes"
  rc:slex = ?s
  slex = #(+?s+)#
  parenth_added = "yes"
}
  ]
]

/*Some coordinations are moved during this transduction, so there may be a need for changing some conjunctions by commas.*/
SSynt<=>SSynt cord_comma_substitute : transfer_nodes
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
  slex = ","
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

excluded SSynt<=>SSynt EN_add_parentheses_N_Det : transfer_nodes
[
  leftside = [
c:?Xl {
  c:DEP-> c:?Yl {
    c:type = "parenthetical"
    c:NMOD-> c:?Zl {
      c:pos = "DT"
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
  ¬rc:parenth = "yes"
  rc:slex = ?s
  slex = #(+?s+)#
  parenth = "yes"
}

rc:?Zr {
  rc:<=> ?Zl
  block = "yes"
}
  ]
]

excluded SSynt<=>SSynt add_node_something : transfer_nodes
[
  leftside = [
c:?Xl {
  c:add_deprel = ?r
  c:add_dep = ?lex
  ¬ ( c:spos = "auxiliary" | c:spos = auxiliary )
}

lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos
lexicon.?lex.spos.?spos
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
 ?r-> ?NewN {
   slex = ?lem
   spos = ?spos
   pos = ?pos
   include = bubble_of_gov
 }
}
  ]
]

excluded SSynt<=>SSynt expand_bubble_gov : transfer_nodes
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

/*This rule has to apply in the second cluster! See block_disconnected_nodes.*/
SSynt<=>SSynt transfer_rel_dep : transfer_relations
[
  leftside = [
c:?Xl {
  ?r-> c:?Yl {}
}

// filter relations between a node and itself
¬ ( ?Xl.id == ?Yl.id & ?Xl.slex == ?Yl.slex & ?Xl.pos == ?Yl.pos & ?Xl.spos == ?Yl.spos
 & ?Xl.straight_weight == ?Yl.straight_weight )

// See transfer_rel_dep_introduce_coord
¬ ( c:?Yl { c:introduce_conj = ?intc } )

// filter relations that point to one same node
// priority to prepositional relations
¬ ( c:?Xl { c:id = ?idX1 } & c:?A1l { ¬c:block = "yes"c:id = ?idA1 c:pos = "IN" c:?s1-> c:?Yl {} } & ¬ ?idX1 == ?idA1 )
// when same relation, only keep the smallest id
¬ ( c:?Xl { c:id = ?idX2 } & c:?A2l { ¬c:block = "yes" c:id = ?idA2 c:?r-> c:?Yl {} } & ¬ ?idX2 == ?idA2 & ?idA2 < ?idX2 )
// when same id, use random
¬ ( c:?Xl { c:id = ?idX3 c:random_id = ?randX3 } & c:?A3l { ¬c:block = "yes" c:id = ?idA3  c:random_id = ?randA3 c:?r-> c:?Yl {} }
  & ?idX3 == ?idA3  & ¬ ?randX3 == ?randA3 & ?randA3 < ?randX3 )

// Add to to EXT that are NPs (no idea if a good idea; AMR-cctv-7)
( ¬ ( language.id.iso.EN & ?r == EXT & c:?Yl { ( c:pos = "NP" | c:pos = "NN" | ( c:pos = "VB" & ¬c:finiteness = ?fin ) ) }
    & c:?Xl { ¬ ( c:slex = "call" c:finiteness = "PART" ) } ) | ?Yl.class == "Rating" )
¬ ( language.id.iso.EN & c:?Yl { ( c:pos = "NN" | c:pos = "NP" ) c:add_of = yes } )
¬ ( language.id.iso.EN & c:?Yl { c:add_to = yes } )

// see DE_transfer_node_es_gefallen
¬ ( language.id.iso.DE & ?r == SB & c:?Xl { c:lex = "gefallen_VB_01" } & c:?Yl { c:slex = "dass" } )
// see DE_transfer_rel_haar
¬ ( language.id.iso.DE & ?r == MO & c:?Z3l { c:lex = "kämmen_VB_01" c:OA-> c:?Xl { c:slex = "Haar" } & c:SB-> c:?Y4l { } } )

// See transfer_rel_dep_supportNoIn
¬ ( ( language.id.iso.ES | language.id.iso.EL | language.id.iso.PT ) & ?Xl.type == "support_verb_noIN"
    & ( ( ?r == subj & c:?Xl { c:copul-> c:?Copl { ¬c:class = "partOf" ¬(c:pos = "IN" | c:pos = "JJ") ¬c:case = "GEN" } } & c:?Yl { ¬ ( c:class = "Person" | c:class = "Location" | c:pos = "PP") } ) ) )
¬ ( ( language.id.iso.ES | language.id.iso.EL | language.id.iso.PT ) & ?Xl.type == "support_verb_noIN"
    & ( ( ?r == copul & ¬?Yl.class == "partOf" & ¬(?Yl.pos == "IN" | ?Yl.pos == "JJ") & ¬?Yl.case == "GEN" & c:?Xl { c:subj-> c:?Copl { ¬ ( c:class = "Person" | c:class = "Location" | c:pos = "PP" ) } } ) ) )

// Move the comparatives; see transfer_rel_dep_comparative
¬ ( ?r == adv & c:?Xl { c:copul-> c:?Copul1l { c:pos = "JJ" } } & ?Yl.type == "comparative" )

// See EN_transfer_rel_dep_there_is
( ¬ ( language.id.iso.EN & ( ?r == SBJ & c:?Xl { c:slex = "be" c:PRD-> c:?Copl { c:meaning = "locative_relation" } } & c:?Yl { ¬c:pos = "NP" ¬c:pos = "PP" ( c:NMOD-> c:?DetY { c:slex = "a" } | ¬c:NMOD-> c:?NoDetY { c:pos = "DT" } ) } ) )
  | ?Xl.type == "support_verb_noIN" )
( ¬ ( language.id.iso.EN & ( ?r == PRD & ?Yl.meaning == "locative_relation" & c:?Xl { c:slex = "be" c:SBJ-> c:?Copl {} } & c:?Copl { ¬c:pos = "NP" ¬c:pos = "PP" ( c:NMOD-> c:?DetY { c:slex = "a" } | ¬c:NMOD-> c:?NoDetY { c:pos = "DT" } ) } ) )
  | ?Xl.type == "support_verb_noIN" )
// See ES_transfer_rel_dep_there_is
( ¬ ( language.id.iso.ES & ( ?r == subj & c:?Xl { c:slex = "estar" c:copul-> c:?Copl { c:meaning = "locative_relation" } } & c:?Yl { ¬c:pronominalized = yes ¬c:pos = "NP" ¬c:pos = "PP" ( c:det-> c:?DetY { c:slex = "un" } | ¬c:det-> c:?NoDetY { c:pos = "DT" } ) } ) )
  | ?Xl.type == "support_verb_noIN" )
( ¬ ( language.id.iso.ES & ( ?r == copul & ?Yl.meaning == "locative_relation" & c:?Xl { c:slex = "estar" c:subj-> c:?Copl {} } & c:?Copl { ¬c:pronominalized = yes ¬c:pos = "NP" ¬c:pos = "PP" ( c:det-> c:?DetY { c:slex = "un" } | ¬c:det-> c:?NoDetY { c:pos = "DT" } ) } ) )
  | ?Xl.type == "support_verb_noIN" )
// See ES_transfer_rel_dep_there_is
( ¬ ( language.id.iso.PT & ( ?r == subj & c:?Xl { c:slex = "estar" c:copul-> c:?Copl { c:meaning = "locative_relation" } } & c:?Yl { ¬c:pronominalized = yes ¬c:pos = "NP" ¬c:pos = "PP" ( c:det-> c:?DetY { ( c:slex = "um" | c:slex = "nenhum" ) } | ¬c:det-> c:?NoDetY { c:pos = "DT" } ) } ) )
  | ?Xl.type == "support_verb_noIN" )
( ¬ ( language.id.iso.PT & ( ?r == copul & ?Yl.meaning == "locative_relation" & c:?Xl { c:slex = "estar" c:subj-> c:?Copl {} } & c:?Copl { ¬c:pronominalized = yes ¬c:pos = "NP" ¬c:pos = "PP" ( c:det-> c:?DetY { ( c:slex = "um" | c:slex = "nenhum" ) } | ¬c:det-> c:?NoDetY { c:pos = "DT" } ) } ) )
  | ?Xl.type == "support_verb_noIN" )
// See IT_transfer_rel_dep_there_is
( ¬ ( language.id.iso.IT & ( ?r == subj & c:?Xl { c:slex = "essere" c:obl_obj-> c:?Copl { c:meaning = "locative_relation" } } & c:?Yl { ¬c:pos = "NP" ¬c:pos = "PP" ( c:det-> c:?DetY { ( c:slex = "un" | c:slex = "nessun" ) } | ¬c:det-> c:?NoDetY { c:pos = "DT" } ) } ) )
  | ?Xl.type == "support_verb_noIN" )
( ¬ ( language.id.iso.IT & ( ?r == obl_obj & ?Yl.meaning == "locative_relation" & c:?Xl { c:slex = "essere" c:subj-> c:?Copl {} } & c:?Copl { ¬c:pos = "NP" ¬c:pos = "PP" ( c:det-> c:?DetY { ( c:slex = "un" | c:slex = "nessun" ) } | ¬c:det-> c:?NoDetY { c:pos = "DT" } ) } ) )
  | ?Xl.type == "support_verb_noIN" )
  
// see EN_transfer_time_adverb
¬ ( language.id.iso.EN & ?r == ADV & c:?Xl { c:lex = "time_RB_01" } & c:?Yl { c:pos = "CD" } )

// if a node has a locative dependent but there is a copula just above with a locative dependent too, raise the first one
¬ ( lexicon.dependencies_default_map.ATTR.rel.?r & ?Yl.meaning == "locative_relation" 
    & c:?Copl { c:?r5-> c:?Xl {} c:?s5-> c:?Y5l { c:meaning = "locative_relation" } } 
    & lexicon.dependencies_default_map.I.rel.?r5 & lexicon.dependencies_default_map.II.rel.?s5
)

// See rel_dep_raise_nonprojective
¬ ( lexicon.dependencies_default_map.ATTR.rel.?r & ?Yl.pos == "IN" & ?Xl.pos == "RB" 
    & c:?Gov6l { c:pos = "NN" c:?s6-> c:?Xl {} } & lexicon.dependencies_default_map.ATTR.rel.?s6 )
    
// See EN_transfer_rel_dep_both
¬ ( language.id.iso.EN & c:?Xl { ( c:pos = "NN" | c:pos = "NP" ) } & c:?Yl { c:slex = "both" } & ?r == DEP )

// See transfer_rel_COORD_move_down
¬ ( language.id.iso.EN & ?r == COORD & c:?Xl { c:pos = "IN" c:PMOD-> c:?K7l { ( c:pos = "NN" | c:pos = "NP" ) } } & c:?Yl { c:CONJ-> c:?Z7l { ( c:pos = "NN" | c:pos = "NP" ) } } )

//Move dependent down in case it is the sibling of another dependent of a conjunction (ill-formed tree due to weird aggregation probably)
¬ (  lexicon.miscellaneous.conjunction.coord_conj_rel.?r & c:?Xl { c:?r8-> c:?Dep8 { c:id = ?idD8 } } & ?r8 == ?r & c:?Yl { c:id = ?idY } & ?idD8 < ?idY )

// Obl_compl to possessive determiner is changed to det relation for allowing for agrements in the next step
¬ ( language.id.iso.PT & ?r == obl_compl & ?Yl.pos == "DT" & ?Yl.pronominalized == yes )
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

/*This rule has to apply in the second cluster! See block_disconnected_nodes.*/
SSynt<=>SSynt transfer_rel_dep_add_of : transfer_relations
[
  leftside = [
c:?Xl {
  ?r-> c: ?Yl {
    ( c:pos = "NN" | c:pos = "NP" )
    c:add_of = yes
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ?r-> ?To {
    slex = "of"
    lex = "of_IN_01"
    pos = "IN"
    spos = "preposition"
    lemma = "of"
    include = bubble_of_gov
    PMOD-> rc:?Yr {
      rc:<=> ?Yl
    }
  }
}
  ]
]

/*This rule has to apply in the second cluster! See block_disconnected_nodes.*/
SSynt<=>SSynt transfer_rel_dep_add_to : transfer_relations
[
  leftside = [
c:?Xl {
  ?r-> c: ?Yl {
    c:add_to = yes
  }
}

// see rel_dep_EXT_NP
¬ ( ?r == EXT & c:?Yl { ( c:pos = "NP" | c:pos = "NN" | ( c:pos = "VB" & ¬c:finiteness = ?fin ) ) } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ?r-> ?To {
    slex = "to"
    lex = "to_IN_01"
    pos = "IN"
    spos = "preposition"
    lemma = "to"
    include = bubble_of_gov
    PMOD-> rc:?Yr {
      rc:<=> ?Yl
    }
  }
}
  ]
]

/*This rule has to apply in the second cluster! See block_disconnected_nodes.*/
SSynt<=>SSynt transfer_rel_dep_introduce_coord_comma : transfer_relations
[
  leftside = [
c:?Xl {
  c:?s-> c:?Zl {
    coord_anchor = ?idZ
  }
  ?r-> c: ?Yl {
    introduce_conj = ?intc
    c:id = ?idY
    //the coordinated verb will have another coord below
    c:coord_anchor = ?idOther
  }
}

?idY == ?idZ

lexicon.miscellaneous.conjunction.?intc.?lex
lexicon.miscellaneous.conjunction.coord_rel.?rel1
lexicon.miscellaneous.conjunction.coord_conj_rel.?rel2

lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos
lexicon.?lex.spos.?spos
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ?rel1-> ?To {
    slex = ?lem
    lex = ?lex
    pos = ?pos
    spos = ?spos
    lemma = ?lem
    include = bubble_of_gov
    comma_substitute = "yes"
    ?rel2-> rc:?Yr {
      rc:<=> ?Yl
    }
  }
}
  ]
]

/*This rule has to apply in the second cluster! See block_disconnected_nodes.*/
SSynt<=>SSynt transfer_rel_dep_introduce_coord_conj : transfer_relations
[
  leftside = [
c:?Xl {
  c:?s-> c:?Zl {
    coord_anchor = ?idZ
  }
  ?r-> c: ?Yl {
    introduce_conj = ?intc
    c:id = ?idY
    //the coordinated verb will NOT have another coord below
    ¬c:coord_anchor = ?idOther
  }
}

?idY == ?idZ

lexicon.miscellaneous.conjunction.?intc.?lex
lexicon.miscellaneous.conjunction.coord_rel.?rel1
lexicon.miscellaneous.conjunction.coord_conj_rel.?rel2

lexicon.?lex.lemma.?lem
lexicon.?lex.pos.?pos
lexicon.?lex.spos.?spos
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ?rel1-> ?To {
    slex = ?lem
    lex = ?lex
    pos = ?pos
    spos = ?spos
    lemma = ?lem
    I_applied = "YES"
    include = bubble_of_gov
    ?rel2-> rc:?Yr {
      rc:<=> ?Yl
    }
  }
}
  ]
]

/*if a node has a locative dependent but there is a copula just above with a locative dependent too, raise the first one*/
SSynt<=>SSynt transfer_rel_dep_raise_location : transfer_relations
[
  leftside = [
c:?Copl {
  c:?r1-> c:?X1l {
    c:?s-> c:?Yl {
      c:meaning = "locative_relation"
    }
  }
  c:?r2-> c:?X2l {
    c:meaning = "locative_relation"
   }
} 

 lexicon.dependencies_default_map.ATTR.rel.?s
lexicon.dependencies_default_map.I.rel.?r1
lexicon.dependencies_default_map.II.rel.?r2
  ]
  mixed = [

  ]
  rightside = [
rc:?X2r {
  rc:<=> ?X2l
  COORD-> rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

/*highest building in the world: "in" raises frm "highest" to "building"*/
SSynt<=>SSynt transfer_rel_dep_raise_nonprojective : transfer_relations
[
  leftside = [
c:?Zl {
  c:pos = "NN"
  c:?s-> c:?Xl {
    c:pos = "RB"
    ?r-> c:?Yl {
      c:pos = "IN"
    }
  }
}

lexicon.dependencies_default_map.ATTR.rel.?r
lexicon.dependencies_default_map.ATTR.rel.?s
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ?r-> rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

/*This rule has to apply in the second cluster! See block_disconnected_nodes.*/
SSynt<=>SSynt EN_transfer_rel_dep_EXT_NP : transfer_relations
[
  leftside = [
c:?Xl {
  ¬ ( c:slex = "call" c:finiteness = "PART" )
  EXT-> c: ?Yl {
    ( c:pos = "NP" | c:pos = "NN" | ( c:pos = "VB" & ¬c:finiteness = ?fin ) )
    ¬c:type = "address"
    ¬c:class = "Rating"
  }
}

// Add to to EXT that are NPs (no idea if a good idea; AMR-cctv-7)
language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  EXT-> ?To {
    slex = "to"
    lex = "to_IN_01"
    pos = "IN"
    spos = "preposition"
    lemma = "to"
    include = bubble_of_gov
    PMOD-> rc:?Yr {
      rc:<=> ?Yl
    }
  }
}
  ]
]

/*This rule has to apply in the second cluster! See block_disconnected_nodes.*/
SSynt<=>SSynt EN_transfer_rel_dep_both : transfer_relations
[
  leftside = [
c:?Xl {
 ( c:pos = "NN" | c:pos = "NP" )
  DEP-> c: ?Yl {
    c:slex = "both"
  }
}

// Add to to EXT that are NPs (no idea if a good idea; AMR-cctv-7)
language.id.iso.EN
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

/*Test rule.*/
SSynt<=>SSynt EN_transfer_rel_COORD_move_down : transfer_relations
[
  leftside = [
c:?Xl {
  c:pos = "IN"
  COORD-> c: ?Yl {
    c:CONJ-> c:?Z7l { ( c:pos = "NN" | c:pos = "NP" ) }
  }
  c:PMOD-> c:?K7l { ( c:pos = "NN" | c:pos = "NP" ) }
}

// Add to to EXT that are NPs (no idea if a good idea; AMR-cctv-7)
language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?K7r {
  rc:<=> ?K7l
  COORD-> rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

/*This rule has to apply in the second cluster! See block_disconnected_nodes.*/
SSynt<=>SSynt EN_transfer_rel_dep_EXT_NP_address : transfer_relations
[
  leftside = [
c:?Xl {
  ¬ ( c:slex = "call" c:finiteness = "PART" )
  EXT-> c: ?Yl {
    ( c:pos = "NP" | c:pos = "NN" | ( c:pos = "VB" & ¬c:finiteness = ?fin ) )
    c:type = "address"
  }
}

// Add to to EXT that are NPs (no idea if a good idea; AMR-cctv-7)
language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  EXT-> ?To {
    slex = "at"
    lex = "at_IN_01"
    pos = "IN"
    spos = "preposition"
    lemma = "at"
    include = bubble_of_gov
    PMOD-> rc:?Yr {
      rc:<=> ?Yl
    }
  }
}
  ]
]

/*Invert copul and subject for linarization.*/
SSynt<=>SSynt EN_transfer_rel_dep_there_is : transfer_relations
[
  leftside = [
c:?Xl {
  c:slex = "be"
  ¬c:type = "support_verb_noIN"
  SBJ-> c:?Yl {
    ¬c:pos = "PP"
    ¬c:pos = "NP"
  }
  PRD-> c:?Zl {
    c:meaning = "locative_relation"
  }
}

language.id.iso.EN

c:?Yl { ¬c:pos = "NP" ( c:NMOD-> c:?DetY { c:slex = "a" } | ¬c:NMOD-> c:?NoDetY { c:pos = "DT" } ) }
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  SBJ-> ?To {
    slex = "there"
    lex = "there_PRP_01"
    pos = "PRP"
    spos = "pronoun"
    lemma = "there"
    include = bubble_of_gov
    number = ?Yl.number
    person = ?Yl.person
  }
  PRD-> rc:?Yr {
    rc:<=> ?Yl
  }
  ADV-> rc:?Zr {
    rc:<=> ?Zl
  }
}
  ]
]

SSynt<=>SSynt EN_transfer_rel_dep_time_ADV : transfer_relations
[
  leftside = [
c:?Xl {
  c:lex = "time_RB_01"
  c:ADV-> c:?Yl {
    c:pos = "CD"
  }
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:pos = "NN"
  NMOD-> rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

/*Invert copul and subject for linarization.*/
SSynt<=>SSynt ES_transfer_rel_dep_there_is : transfer_relations
[
  leftside = [
c:?Xl {
  c:slex = "estar"
  ¬c:type = "support_verb_noIN"
  subj-> c:?Yl {
    ¬c:pronominalized = yes
  }
  copul-> c:?Zl {
    c:meaning = "locative_relation"
  }
}

language.id.iso.ES

c:?Yl { ¬c:pos = "NP" ( c:det-> c:?DetY { c:slex = "un" } | ¬c:det-> c:?NoDetY { c:pos = "DT" } ) }
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  slex = "hay"
  invariant = yes
  copul-> rc:?Yr {
    rc:<=> ?Yl
  }
  adv-> rc:?Zr {
    rc:<=> ?Zl
  }
}
  ]
]

/*Insert "ci" in existential constructions*/
SSynt<=>SSynt IT_transfer_rel_dep_there_is : transfer_relations
[
  leftside = [
c:?Xl {
  c:slex = "essere"
  ¬c:type = "support_verb_noIN"
  subj-> c:?Yl {
    ¬c:pos = "PP"
    ¬c:pos = "NP"
  }
  obl_obj-> c:?Zl {
    c:meaning = "locative_relation"
  }
}

language.id.iso.IT

c:?Yl { ¬c:pos = "NP" ( c:det-> c:?DetY { ( c:slex = "un" | c:slex = "nessun" ) } | ¬c:det-> c:?NoDetY { c:pos = "DT" } ) }
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  subj-> ?Ci {
    slex = "ci"
    lex = "ci_RB_01"
    pos = "RB"
    spos = "adverb"
    lemma = "ci"
    include = bubble_of_gov
    number = ?Yl.number
    person = ?Yl.person
  }
  obl_obj-> rc:?Yr {
    rc:<=> ?Yl
  }
  adv-> rc:?Zr {
    rc:<=> ?Zl
  }
}
  ]
]

/*Invert copul and subject for linarization.*/
SSynt<=>SSynt PT_transfer_rel_dep_there_is : transfer_relations
[
  leftside = [
c:?Xl {
  c:slex = "estar"
  ¬c:type = "support_verb_noIN"
  subj-> c:?Yl {
    ¬c:pronominalized = yes
  }
  copul-> c:?Zl {
    c:meaning = "locative_relation"
  }
}

language.id.iso.PT

c:?Yl { ¬c:pos = "NP" ( c:det-> c:?DetY { ( c:slex = "um" | c:slex = "nenhum" ) } | ¬c:det-> c:?NoDetY { c:pos = "DT" } ) }
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  slex = "ter"
  copul-> rc:?Yr {
    rc:<=> ?Yl
  }
  adv-> rc:?Zr {
    rc:<=> ?Zl
  }
}
  ]
]

/*Invert copul and subject for linarization.*/
SSynt<=>SSynt PT_transfer_rel_dep_det_seu : transfer_relations
[
  leftside = [
c:?Xl {
  obl_compl-> c:?Yl {
    c:pos = "DT"
    c:pronominalized = yes
  }
}

language.id.iso.PT
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  det-> rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

/*Keep RS ~ synchronised with ES_transfer_rel_dep_there_is and PT_transfer_rel_dep_there_is.

Rules missing (i) to look for the negation as subject (nada, nadie, etc.), and (ii) maybe on the dependent of ?Dl (??).*/
SSynt<=>SSynt ES_PT_transfer_rel_dep_there_is_NOT : transfer_relations
[
  leftside = [
c:?Xl {
  c:slex = "estar"
  c:subj-> c:?Yl {
    c:?r-> c:?Dl {
      c:lex = ?lex
    }
  }
  c:copul-> c:?Zl {}
}

( language.id.iso.ES | language.id.iso.PT )

(?r == modif | ?r == det )

lexicon.miscellaneous.negation.?a.?lex
lexicon.miscellaneous.negation.basic.?lexNeg
lexicon.?lexNeg.pos.?posNeg
lexicon.?lexNeg.spos.?sposNeg
lexicon.?lexNeg.lemma.?lemNeg
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:copul-> rc:?Yr {
    rc:<=> ?Yl
  }
  rc:adv-> rc:?Zr {
    rc:<=> ?Zl
  }
  // should be restr, but linearisation rules are not designed for restr yet apparently.
  adv-> ?Neg {
    slex = ?lemNeg
    lex = ?lexNeg
    pos = ?posNeg
    spos = ?sposNeg
    include = bubble_of_gov
  }
}
  ]
]

/*Keep RS ~ synchronised with IT_transfer_rel_dep_there_is.

Rules missing (i) to look for the negation as subject (nada, nadie, etc.), and (ii) maybe on the dependent of ?Dl (??).*/
SSynt<=>SSynt IT_transfer_rel_dep_there_is_NOT : transfer_relations
[
  leftside = [
c:?Xl {
  c:slex = "essere"
  c:subj-> c:?Yl {
    c:?r-> c:?Dl {
      c:lex = ?lex
    }
  }
  c:obl_obj-> c:?Zl {}
}

language.id.iso.IT

(?r == modif | ?r == det )

lexicon.miscellaneous.negation.?a.?lex
lexicon.miscellaneous.negation.basic.?lexNeg
lexicon.?lexNeg.pos.?posNeg
lexicon.?lexNeg.spos.?sposNeg
lexicon.?lexNeg.lemma.?lemNeg
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:obl_obj-> rc:?Yr {
    rc:<=> ?Yl
  }
  rc:adv-> rc:?Zr {
    rc:<=> ?Zl
  }
  // should be restr, but linearisation rules are not designed for restr yet apparently.
  adv-> ?Neg {
    slex = ?lemNeg
    lex = ?lexNeg
    pos = ?posNeg
    spos = ?sposNeg
    include = bubble_of_gov
  }
}
  ]
]

/*Invert copul and subject for linarization.*/
SSynt<=>SSynt EL_ES_PT_transfer_rel_dep_supportNoIn : transfer_relations
[
  leftside = [
c:?Xl {
  ?r-> c: ?Yl {
    ¬c:class = "partOf"
    ¬( c:pos = "IN" | c:pos = "JJ" )    
    ¬c:case = "GEN"    
  }
  ?s-> c: ?Zl {
  ¬ ( c:class = "Person" | c:class = "Location" | c:pos = "PP" )
  }
}

( ?Xl.type == "support_verb_noIN" &
  ( ( language.id.iso.ES | language.id.iso.EL | language.id.iso.PT ) & ?r == copul & ?s == subj )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:type = "support_verb_noIN"
  type = "normal"
  ?s-> rc:?Yr {
    rc:<=> ?Yl
  }
  ?r-> rc:?Zr {
    rc:<=> ?Zl
  }
}
  ]
]

SSynt<=>SSynt transfer_rel_dep_comparative : transfer_relations
[
  leftside = [
c:?Xl {
  adv-> c:?Yl { c:type = "comparative" }
  c:copul-> c:?Zl {
    c:pos = "JJ"
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  compar-> rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

/*This rule has to apply in the second cluster! See block_disconnected_nodes.*/
SSynt<=>SSynt transfer_rel_dep_reattach_block1 : transfer_relations
[
  leftside = [
c:?Xl {
  ?r-> c: ?Yl {
    c:block = "yes"
    ?s-> c: ?Zl {}
  }
}

//some preps are introduced twice above a node, one of them is not blocked
¬c:?Nodel {
  ¬c:block = "yes"
  c:?rel1-> c:?Zl {}
}

// if several candidates (sometimes the tree is not a tree), only choose one.
// use random attribute to distinguish
¬ ( c:?Xl { c:random_id = ?randX }
  & c:?Al { ¬c:block = "yes" c:random_id = ?randA c:?r1-> c:?Y1l { c:block = "yes" c:?s1-> c:?Zl {} } }
  & ?randA < ?randX )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ?r-> rc:?Zr {
    rc:<=> ?Zl
  }
}
  ]
]

/*This rule has to apply in the second cluster! See block_disconnected_nodes.*/
SSynt<=>SSynt transfer_rel_dep_reattach_block2 : transfer_relations
[
  leftside = [
c:?Xl {
  ?r-> c: ?Yl {
    c:block = "yes"
    ?s-> c: ?Zl {
      c:block = "yes"
      ?t-> c: ?Wl {}
    }
  }
}

//some preps are introduced twice above a node, one of them is not blocked
¬c:?Nodel {
  ¬c:block = "yes"
  c:?rel1-> c:?Wl {}
}

// if several candidates (sometimes the tree is not a tree), only choose one.
// use random attribute to distinguish
¬ ( c:?Xl { c:random_id = ?randX }
  & c:?Al { c:block = "yes"c:random_id = ?randA
        c:?r1-> c:?Y1l { c:block = "yes"
                       c:?s1-> c:?Z1l { c:block = "yes" c:?t1-> c:?Wl {} } } }
  & ?randA < ?randX )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ?r-> rc:?Wr {
    rc:<=> ?Wl
  }
}
  ]
]

/*This rule has to apply in the second cluster! See block_disconnected_nodes.*/
SSynt<=>SSynt transfer_rel_dep_reattach_block3 : transfer_relations
[
  leftside = [
c:?Xl {
  ?r-> c: ?Yl {
    c:block = "yes"
    ?s-> c: ?Zl {
      c:block = "yes"
      ?t-> c: ?Wl {
        c:block = "yes"
        ?u-> c: ?Vl {}
      }
    }
  }
}

//some preps are introduced twice above a node, one of them is not blocked
¬c:?Nodel {
  ¬c:block = "yes"
  c:?rel1-> c:?Vl {}
}

// if several candidates (sometimes the tree is not a tree), only choose one.
// use random attribute to distinguish
¬ ( c:?Xl { c:random_id = ?randX }
  & c:?Al { ¬c:block = "yes" c:random_id = ?randA
         c:?r1-> c:?Y1l { c:block = "yes"
                        c:?s1-> c:?Z1l { c:block = "yes"
                                        c:?t1-> c:?W1l { c:block = "yes" c:?u1-> c:?Vl {} } } } }
  & ?randA < ?randX )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ?r-> rc:?Vr {
    rc:<=> ?Vl
  }
}
  ]
]

/*This rule has to apply in the second cluster! See block_disconnected_nodes.
A node with a gov_id means it had a governor in DSynt. If it has no gov here, it needs to be reattached.*/
SSynt<=>SSynt transfer_rel_dep_reattach_stranded_nodes : transfer_relations
[
  leftside = [
c:?Bl {
  c:?Xl {
    ¬ c:?node1 {}
    gov_id = ?gid
  }
  c:?Yl {
    ¬ c:?node1 {}
    c:id = ?id
  }
}

?gid == ?id

¬ c:?Zl { c:?r-> c:?Xl {} }

¬ c:?Kl { c:id = ?id c:?s-> c:?Yl {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  DEP-> rc:?Xr {
    rc:<=> ?Xl
  }
}
  ]
]

/*Move dependent down in case it is the sibling of another dependent of a conjunction (ill-formed tree due to weird aggregation probably)*/
SSynt<=>SSynt transfer_rel_dep_coord_relocate_one_level : transfer_relations
[
  leftside = [
c:?Andl {
  c:?r-> c:?Anchor {}
  ?r1-> c:?Dep2 {
    c:id = ?idD2
  }
} 
  
lexicon.miscellaneous.conjunction.coord_conj_rel.?r1
lexicon.miscellaneous.conjunction.coord_rel.?rCoord
  ]
  mixed = [

  ]
  rightside = [
rc:?AnchorR {
  rc:<=> ?Anchor
  rc:anchor_coord_relocate_final = ?idD2
  ?rCoord-> ?And {
    slex = ?Andl.slex
    lex = ?Andl.lex
    pos = ?Andl.pos
    spos = ?Andl.spos
    include = bubble_of_gov
    ?r1-> rc:?Dep2R {
      rc:<=> ?Dep2
    }
  }
}
  ]
]

/*Move dependent down in case it is the sibling of another dependent of a conjunction (ill-formed tree due to weird aggregation probably)*/
SSynt<=>SSynt transfer_rel_dep_coord_relocate_more_level : transfer_relations
[
  leftside = [
c:?Andl {
  c:?r2-> c:?Dep1 {
    c:*?r-> c:?Anchor {}
  }
  ?r1-> c:?Dep2 {
    c:id = ?idD2
  }
} 

?r1 == ?r2

lexicon.miscellaneous.conjunction.coord_conj_rel.?r1
lexicon.miscellaneous.conjunction.coord_rel.?rCoord
  ]
  mixed = [

  ]
  rightside = [
rc:?AnchorR {
  rc:<=> ?Anchor
  rc:anchor_coord_relocate_final = ?idD2
  ?rCoord-> ?And {
    slex = ?Andl.slex
    lex = ?Andl.lex
    pos = ?Andl.pos
    spos = ?Andl.spos
    include = bubble_of_gov
    ?r1-> rc:?Dep2R {
      rc:<=> ?Dep2
    }
  }
}
  ]
]

SSynt<=>SSynt transfer_rel_precedence : transfer_relations
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

SSynt<=>SSynt transfer_rel_coref : transfer_relations
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

SSynt<=>SSynt transfer_rel_coref_pronominalised : transfer_relations
[
  leftside = [
c:?Xl {
  c:pronominalized = yes
  c:?r-> c:?Ante {
    c:block = "yes"
    <-> c: ?Yl {}
  }
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

excluded Sem<=>DSynt transfer_rel_bubbles : transfer_relations
[
  leftside = [
c:?Xl {
  c:slex = "Sentence"
  ?r-> c: ?Yl {
    c:slex = "Sentence"
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

SSynt<=>SSynt DE_transfer_rel_haar : transfer_relations
[
  leftside = [
c:?Zl {
  c:lex = "kämmen_VB_01"
  c:OA-> c:?Xl {
    c:slex = "Haar"
    MO-> c:?Hl {}
  }
  c:SB-> c:?Yl {}
}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  MO-> rc:?Hr {
    rc:<=> ?Hl
  }
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

SSynt<=>SSynt DE_attr_pos_VtoN : transfer_attributes
[
  leftside = [
c:?Yl {
  //c:lex = "vor_IN_01"
  c:pos = "IN"
  c:CP->  c:?Xl {
    c:pos = "VB"
    ¬c:finiteness = "FIN"
  }
}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  pos = "VB"
  spos = "verb"
  finiteness = "INF"
  NK-> ?Det {
    slex = "das"
    lex = "das_DT_01"
    pos = "DT"
    spos = "determiner"
    include = bubble_of_gov
    straight_weight = "1"
    straight_weight_up = "yes"
    id = #randInt()#
  }
}
  ]
]

SSynt<=>SSynt EN_attr_pos_JJ_VBpart : transfer_attributes
[
  leftside = [
c:?Xl {
  pos = "VB"
  c:finiteness = "PART"
}

language.id.iso.EN

c:?Y2l { c:NMOD-> c:?Xl { } }
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  pos = "JJ"
}
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

Sem<=>DSynt EN_attr_finiteness_GER_prep : transfer_attributes
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
  ¬rc:slex = "to"
  ¬rc:slex = "if"
  ¬rc:slex = "whether"
  ( rc:pos = "IN" | rc:pos = "TO" )
  rc:?r-> rc:?Xr {
    rc:<=> ?Xl
    rc:pos = ?pos
    // BUG: dunno why, when activated the rule doesn't apply
    //¬rc:finiteness = ?finR
    finiteness = "GER"
  }
}

(?r == PMOD | ?r == IM )
  ]
]

/*A coordinated verb with no finiteness takes it from the conjunct above.*/
SSynt<=>SSynt attr_finiteness_COORD_percolate : transfer_attributes
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:?r-> c:?And {
    c:?s-> c:?Yl {
      c:pos = "VB"
      ¬c:finiteness = ?nY
    }
  }
}

lexicon.miscellaneous.conjunction.coord_rel.?r
lexicon.miscellaneous.conjunction.coord_conj_rel.?s
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:finiteness=?f
}

rc:?Yr {
  rc:<=> ?Yl
  finiteness=?f
}
  ]
]

SSynt<=>SSynt attr_gender : transfer_attributes
[
  leftside = [
c:?Xl {
  gender = ?n
}

¬ ( language.id.iso.PT & c:?Gov { c:obl_compl-> c:?Xl { c:pos = "DT" c:pronominalized = yes } } )
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

SSynt<=>SSynt attr_number : transfer_attributes
[
  leftside = [
c:?Xl {
  number = ?n
}


¬ ( c:?Xl {  c:<-> c:?Yl { c:number = ?nY } } & ¬?n == ?nY )

¬ ( language.id.iso.PT & c:?Gov { c:obl_compl-> c:?Xl { c:pos = "DT" c:pronominalized = yes } } )
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

SSynt<=>SSynt attr_number_rewrite_Ante : transfer_attributes
[
  leftside = [
c:?Yl {
  number = ?nY
  c:<-> c:?Xl {
    c:number = ?nX
  }
}

¬?nY == ?nX

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
  number = ?nX
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

// see DE_pos_VtoN
¬ ( language.id.iso.DE & c:?Y1l { c:lex = "vor_IN_01" c:CP->  c:?Xl { c:pos = "VB" } } )

¬ ( language.id.iso.EN & c:?Y2l { c:NMOD-> c:?Xl { c:pos = "VB" c:finiteness = "PART" } } )

¬ ( language.id.iso.EN & c:?Xl { c:lex = "time_RB_01" c:ADV-> c:?Yl { c:pos = "CD" } } )
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

SSynt<=>SSynt EN_attr_pos_spos_time_ADV : transfer_attributes
[
  leftside = [
c:?Xl {
  c:lex = "time_RB_01"
  c:ADV-> c:?Yl {
    c:pos = "CD"
  }
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  pos = "NN"
  spos = "noun"
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

// see DE_pos_VtoN
¬ ( language.id.iso.DE & c:?Yl { c:lex = "vor_IN_01" c:CP->  c:?Xl { c:pos = "VB" } } )

¬ ( language.id.iso.EN & c:?Xl { c:lex = "time_RB_01" c:ADV-> c:?Yl { c:pos = "CD" } } )
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

( language.syntax.aspect.synthetic
  | ( ( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR | language.id.iso.PT ) & c:?Xl { ( tem_constituency = "IMP" | tem_constituency = "PERF-S" ) } )
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

/*Not sure why all the conditions were there. Maybe if there are several layers of comas, there should be several rules as well.*/
SSynt<=>SSynt parenth_mark : markers
[
  leftside = [
c:?Yl {
  c:type = "parenthetical"
  c:id = ?i
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  parenth = ?i
}
  ]
]

/*Not sure why all the conditions were there. Maybe if there are several layers of comas, there should be several rules as well.*/
SSynt<=>SSynt parenth_percolate : markers
[
  leftside = [
c:?Yl {
  //¬ ( ( c:pos = "NN" | c:pos = "NP" )
  //c:NMOD-> c:?Zl {
   // ( c:pos = "VB" | c:pos = "NN" | c:pos = "NP" )
  //} )
 // ¬ ( ( c:pos = "NN" | c:pos = "NP" )
 // c:NMOD-> c:?Al {
   // c:pos = "JJ"
   // c:?r-> c:?Bl {}
  //} )
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:parenth = ?n
  rc:?r-> rc:?Yr {
    rc:<=> ?Yl
    // don't check if the node already has it, so the highest node of the subtree will overwrite possible embedded parenth
    //¬rc:parenth = ?m
    parenth = ?n
  }
}
  ]
]

SSynt<=>SSynt mark_block : markers
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

SSynt<=>SSynt mark_modifier : markers
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

SSynt<=>SSynt mark_agreement : markers
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

SSynt<=>SSynt mark_weight : markers
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

SSynt<=>SSynt mark_coord_relocate : markers
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

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

/*If for some reason some nodes are still disconnected after this step, filter them.
This rule will work as long as all the relations are transferred in the same cluster as the bubble is filled.*/
SSynt<=>SSynt block_disconnected_nodes : mark_block
[
  leftside = [
c:?Bl {
  c:slex = "Sentence"
  c:?Xl {}
  c:?Yl {}
}

// to limit number of applications of rule
//?Xl.id < ?Yl.id
//Back to the old strategy: keep the bigger subtree.
( ?Xl.straight_weight < ?Yl.straight_weight | ( ?Xl.straight_weight == ?Yl.straight_weight & ?Xl.id < ?Yl.id ) )
// this grammar is not supposed to create disconnections, so this condition should be safe.
// it helps restricting the contexts in which the rule applies.
¬c:?N1l { c:?r1-> c:?Xl {} }
¬c:?N2l { c:?r2-> c: ?Yl {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?Br {
  rc:<=> ?Bl
  rc:?Xr {
    rc:<=> ?Xl
    block = "yes"
  }
//  rc:?Yr {
//    block = "yes"
//  }
}
¬rc:?N1r { rc:?R1-> rc:?Xr {rc:<=> ?Xl } }
//¬rc:?N2r { rc:?R2-> rc:?Yr {rc:<=> ?Yl } }
  ]
]

SSynt<=>SSynt block_percolate : mark_block
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
  rc:?r-> rc:?Yr {
    block = "yes"
  }
}
  ]
]

/*In languages like Spanish, "cuyo" (of wihch) is introduced in place of the preposition.
In this case, block the dependents.*/
SSynt<=>SSynt ES_FR_block_dependent_RelPro : mark_block
[
  leftside = [
c:?Xl {
  c:?r-> c:?Which {
    ( c:spos = "relative_pronoun" | c:pronominalizedLoc = yes )
    c:prepos-> c:?Yl {}
  }
}

( language.id.iso.ES | language.id.iso.FR )

( ?r == obl_compl | ?r == obl_obj )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  block = "yes"
}
  ]
]

/*To avoid the following: the video, [the] which title is blabla.*/
SSynt<=>SSynt block_det_RelPro_sibling : mark_block
[
  leftside = [
c:?Xl {
  c:?r-> c:?Which {
    ( c:spos = relative_pronoun | c:spos = "relative_pronoun" )
  }
  c:?s-> c:?Yl {
    c:pos = "DT"
  }
}

( ?r == NMOD | ?r == obl_compl )
( ?s == NMOD | ?s == det )

// Greek keeps its determiners
¬language.id.iso.EL
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  block = "yes"
}
  ]
]

SSynt<=>SSynt block_det_RelPro_dependent : mark_block
[
  leftside = [
c:?Xl {
  c:?r-> c:?Which {
    ( c:spos = relative_pronoun | c:spos = "relative_pronoun" )
    c:?s-> c:?Yl {
      c:pos = "DT"
    }
  }
}

( ?s == NMOD | ?s == det )

// In greek we must keep the det on the relative pronoun
¬ language.id.iso.EL

// "Cual" can have a determiner in Spanish; we should deal with it based on the PoS, but I'm not sure the PoS are clean in the lexicon...
¬ ( language.id.iso.ES & ?Which.slex == "cual" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  block = "yes"
}
  ]
]

/*If a noun has been pronominalized by the previous module, remove the possibly remaining dependent.
This rule comes from a sort of hack in case of pronominalization of prepositional group, in which the prep
 is the one replaced by the pronoun, whereas the noun is untouched by the previous grammar.
Happens in 170822a_known_input_multiple2.conll #251*/
excluded SSynt<=>SSynt block_dep_pronoun_gen_dependent : mark_block
[
  leftside = [
c:?Govl {
  ( c:pos = "NN" | c:pos = "NP" )
  // The following configuration will be rendered with a genitive pronoun like "her"
  c:?r-> c:?Xl {
    // also add pronominalize=yes here?
    ( c:slex = "_PRO_" | c:slex = "_PRO-HUM_" | c:pronominalizedLoc = yes )
    c:?s-> c:?Depl {
      ( c:pos = "NN" | c:pos = "NP" )
    }
  }
}

( ?r == NMOD | ?r == obl_compl )
( ?s == PMOD | ?s == prepos )
  ]
  mixed = [

  ]
  rightside = [
rc:?DepR {
  rc:<=> ?Depl
  block = "yes"
}
  ]
]

excluded SSynt<=>SSynt EL_block_dep_pronoun_gen_dependent : mark_block
[
  leftside = [
c:?Govl {
  ( c:pos = "NN" | c:pos = "NP" )
  c:obl_compl-> c:?Xl {
    ( c:slex = "_PRO_" | c:slex = "_PRO-HUM_" | c:pronominalizedLoc = yes )
    c:case = "GEN"
    c:det-> c:?Depl {
      ( c:pos = "DT" | c:pos = "CD" )
    }
  }
}

language.id.iso.EL
  ]
  mixed = [

  ]
  rightside = [
rc:?DepR {
  rc:<=> ?Depl
  block = "yes"
}
  ]
]

/*If a noun has been pronominalized by the previous module, but the determiner has been built at the same time.
Happens in 170822a_known_input_multiple2.conll #251*/
excluded SSynt<=>SSynt block_det_pronoun_gen_sibling : mark_block
[
  leftside = [
c:?Govl {
  ( c:pos = "NN" | c:pos = "NP" )
  // The following configuration will be rendered with a genitive pronoun like "her"
  c:?r-> c:?Xl {
    ( c:slex = "_PRO_" | c:slex = "_PRO-HUM_" ) 
  }
  c:?s-> c:?Detl {
    c:pos = "DT"
  }
}

( ?r == NMOD | ?r == obl_compl )
( ?s == NMOD | ?s == det )

// In catalan and greek we can keep the det next to the genitive pronoun
¬ language.id.iso.CA
¬ language.id.iso.EL
  ]
  mixed = [

  ]
  rightside = [
rc:?DetR {
  rc:<=> ?Detl
  block = "yes"
}
  ]
]

/*Should this rule be limited to Greek?
Could this rule be merged with block_dep_pronoun_gen?*/
excluded SSynt<=>SSynt block_dep_pronoun_personal_dependent : mark_block
[
  leftside = [
c:?Govl {
  c:?r-> c:?Xl {
    ( c:slex = "_PRO_" | c:slex = "_PRO-HUM_" | c:pronominalizedLoc = yes )
    c:?s-> c:?Depl {
      //( c:pos = "DT" | c:pos = "CD" )
    }
  }
}

// Just putting dependencies for controlling the application of the rule!; may be more generic
( ?r == subj | ?r == dobj | ?r == iobj | ?r == obl_obj )

//language.id.iso.EL
  ]
  mixed = [

  ]
  rightside = [
rc:?DepR {
  rc:<=> ?Depl
  block = "yes"
}
  ]
]

excluded SSynt<=>SSynt EN_block_det_indef_PRD_coord : mark_block
[
  leftside = [
c:?Vl {
  c:SBJ-> c:?Subj {
    ( c:number = "PL" | c:COORD-> c:?Conj { c:slex = "and" } )
  }
  c:PRD-> c:?Xl {
    c:NMOD-> c:?Yl {
      c:slex = "a"
      ¬c:?r-> c:?Dep {}
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
}
  ]
]

/*To avoid the following: the word length and [the] vocabulary richness index.*/
SSynt<=>SSynt EN_block_det_coord_arg : mark_block
[
  leftside = [
c:?Xl {
  c:NMOD-> c:?Arg1 {
    c:pos = "NN"
    ( c:dsyntRel = I | c:dsyntRel = II | c:dsyntRel = III )
    ¬c:NMOD-> c:?Det1 {
      c:pos = "DT"
    }
    c:COORD-> c:?And {
      c:CONJ-> c:?Arg2 {
        c:pos = "NN"
        c:NMOD-> c:?Det2 {
          c:pos = "DT"
        }
      }
    }
  }
}


// Greek keeps its determiners
language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Det2R {
  rc:<=> ?Det2
  block = "yes"
}
  ]
]

SSynt<=>SSynt block_duplicate_relPro_simple : mark_block
[
  leftside = [
c:?Xl {
  c:NMOD-> c:?Wl {
    ( c:spos = relative_pronoun | c:spos ="relative_pronoun" )
    c:id =?idW
  }
  c:NMOD-> c:?Yl {
    ( c:spos = relative_pronoun | c:spos ="relative_pronoun" )
    c:id = ?idY
  }
}

?idW < ?idY
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  block = "yes"
}
  ]
]

SSynt<=>SSynt block_duplicate_relPro_complex : mark_block
[
  leftside = [
c:?Xl {
  c:NMOD-> c:?Prep1 {
    c:pos = "IN"
    c:?r1-> c:?Wl {
      ( c:spos = relative_pronoun | c:spos ="relative_pronoun" )
      c:id =?idW
    }
  }
  c:NMOD-> c:?Prep2 {
    c:pos = "IN"
    c:?r2-> c:?Yl {
      ( c:spos = relative_pronoun | c:spos ="relative_pronoun" )
      c:id =?idY
    }
  }
}

?idW < ?idY
  ]
  mixed = [

  ]
  rightside = [
rc:?Prep2r {
  rc:<=> ?Prep2
  block = "yes"
}
  ]
]

/*We mark the subtree corresponding to a noun modifier
in order to introduce commas in the next stage.*/
SSynt<=>SSynt EN_mark_modifier_subtree1 : mark_modifier
[
  leftside = [
c:?Xl {
  ( c:pos = "NN" | c:pos = "NP" )
  c:NMOD-> c:?Yl {
    ( c:pos = "VB" | c:pos = "MD" | c:pos = "NN" | c:pos = "NP" )
    ¬c:type = "no_comma"
    ¬c:type = "RESTR"
    ¬c:case = "GEN"
    // see modif_subtree2
    ¬c:finiteness = "PART"
  }
}

// No comma if the governing noun is the second argument of a verb and has an indefinite determiner.
¬ ( c:?Govl { c:pos = ?pos c:?r-> c:?Xl { c:NMOD-> c:?Det { c:slex = "a" } } }
     & ( ?pos == "VB" | ?pos == "MD" ) & ( ?r == DOBJ | ?r == PRD ) )

// NN1 NMOD-> NN2, NN2 will go before (compositionality)
( ¬ ( ?Xl.pos == "NN" & ?Yl.pos == "NN" ) | c:?Yl { c:?r2-> c:?dep2 {} } )

// If definite det and NP, don't put the comma (testing, not sure it's correct)
¬ ( c:?Xl { c:NMOD-> c:?Zl { c:slex = "the" } } & ?Yl.pos =="NP" )

//PATCH V4Design
¬ ( c:?Xl { c:lex = "aspect_NN_01" c:number = "PL" } )

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  n_modif = ?Xl.id
}
  ]
]

/*We mark the subtree corresponding to a noun modifier
in order to introduce commas in the next stage.*/
SSynt<=>SSynt CA_EL_ES_FR_IT_mark_modifier_subtree1 : mark_modifier
[
  leftside = [
c:?Xl {
  ( c:pos = "NN" | c:pos = "NP" )
  c:?r-> c:?Yl {
    ( c:pos = "VB" | c:pos = "MD" | c:pos = "NN" | c:pos = "NP" )
    ¬c:type = "no_comma"
    ¬c:type = "RESTR"
    ¬c:introduce_conj = ?ic
  }
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

( ?r == relat | ?r == appos )

// No comma if the governing noun is the second argument of a verb and has an indefinite determiner.
¬ ( c:?Govl { c:pos = ?pos c:?s-> c:?Xl { c:det-> c:?Det { c:slex = "un" } } }
     & ( ?pos == "VB" | ?pos == "MD" ) & ( ?s == dobj | ?s == copul ) )

// If the dependent is an NP alone, this will probably be a simple apposition
( ¬ ?Yl.pos == "NP" | c:?Yl { c:?dep-> c:?depZ {} } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  n_modif = ?Xl.id
}
  ]
]

/*We mark the subtree corresponding to a noun modifier
in order to introduce commas in the next stage.*/
SSynt<=>SSynt EN_mark_modifier_subtree2 : mark_modifier
[
  leftside = [
c:?Xl {
  ( c:pos = "NN" | c:pos = "NP" )
  c:NMOD-> c:?Yl {
    ( c:pos = "JJ" | c:finiteness = "PART" )
    ¬c:type = "no_comma"
    ¬c:type = "RESTR"
    c:?r-> c:?Zl {
      ¬c:slex = "not"
      ¬c:slex = "non"
      ¬c:slex = "very"
      ¬c:slex = "quite"
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
  n_modif = ?Xl.id
}
  ]
]

/*We mark the subtree corresponding to a noun modifier
in order to introduce commas in the next stage.*/
SSynt<=>SSynt CA_EL_ES_FR_IT_mark_modifier_subtree2 : mark_modifier
[
  leftside = [
c:?Xl {
  ( c:pos = "NN" | c:pos = "NP" )
  c:modif-> c:?Yl {
    ( c:pos = "JJ" | c:finiteness = "PART" )
    ¬c:type = "no_comma"
    ¬c:type = "RESTR"
    c:?r-> c:?Zl {
      ¬c:slex = "non"
      ¬c:slex = "no"
    }
  }
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  n_modif = ?Xl.id
}
  ]
]

/*Not sure why all the conditions were there. Maybe if there are several layers of comas, there should be several rules as well.*/
SSynt<=>SSynt n_modif_percolate : mark_modifier
[
  leftside = [
c:?Yl {
  //¬ ( ( c:pos = "NN" | c:pos = "NP" )
  //c:NMOD-> c:?Zl {
   // ( c:pos = "VB" | c:pos = "NN" | c:pos = "NP" )
  //} )
 // ¬ ( ( c:pos = "NN" | c:pos = "NP" )
 // c:NMOD-> c:?Al {
   // c:pos = "JJ"
   // c:?r-> c:?Bl {}
  //} )
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:n_modif = ?n
  rc:?r-> rc:?Yr {
    rc:<=> ?Yl
    //¬rc:n_modif = ?m
    n_modif = ?n
  }
}
  ]
]

SSynt<=>SSynt n_modif_percolate_new_nodes : mark_modifier
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:n_modif = ?n
  rc:?r-> rc:?Yr {
    rc:include = ?i
    ¬rc:n_modif = ?nmod
    n_modif = ?n
  }
}
  ]
]

/*Percent takes its number from the complement noun below?*/
SSynt<=>SSynt agreement_percent_dependent : mark_agreement
[
  leftside = [
c:?Xl {
  c:slex = "percent"
  c:NMOD-> c:?Of {
    c:slex = "of"
    c:PMOD-> c:?Noun {}
  }
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?NounR {
  rc:<=> ?Noun
  //gender = ?gen.
  rc:number = ?n
}

rc:?Xr {
  rc:<=> ?Xl
  rc:number = ?nX
  number = ?n
  ¬rc:update_num_RS = "yes"
  update_num_RS = "yes"
}
  ]
]

/*In German, if the adjective is AFTER the noun (e.g. in the copula complement position) is invariant.*/
SSynt<=>SSynt agreement_sibling_number_NOUN_copul : mark_agreement
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
¬ ( language.id.iso.EN & ?Subj.pos == "CD" )
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

/*Rules are now applied in the level before to allow for smooth resolution of agreements.*/
SSynt<=>DMorph agreement_sibling_number_NOUN_copul_COORD : mark_agreement
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

/*The depth rules will work if enough relations are created before the 3rd cluster, which is usually the case.
It weirdly done, and probably can be done better. The idea is to get at the leaves when the whole tree is built, not before,
 which is why we start from the root (the ssynt tree is built from the root).*/
SSynt<=>SSynt depth_root : mark_weight
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
SSynt<=>SSynt depth_down : mark_weight
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
SSynt<=>SSynt weight_up_leaf_1 : mark_weight
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
SSynt<=>SSynt weight_up_leaf_lexicon : mark_weight
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
SSynt<=>SSynt weight_up_Block : mark_weight
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  straight_weight = ?w
  rc:?r-> rc:?Yr {
    rc:straight_weight = ?w
   rc:block = "yes"
  }
}
  ]
]

/*When down to the leaf, go up again, counting from the bottom.
That way, we end up with each subtree having a number for its depth.*/
SSynt<=>SSynt weight_up_notBlock_1 : mark_weight
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
    ¬rc:block = "yes"
  }
}
  ]
]

/*Some units have their own weight in the lexicon, in this case we sum up this weight instead of 1.*/
SSynt<=>SSynt weight_up_notBlock_lexicon : mark_weight
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
    ¬rc:block = "yes"

  }
}
  ]
]

SSynt<=>SSynt weight_horizontal_2 : mark_weight
[
  leftside = [
c:?Xl {
  c:?r1-> c:?Y1l { c:id = ?idY1 }
  c:?r2-> c:?Y2l { c:id = ?idY2 }
  ¬c:?r3-> c:?Y3l { c:id = ?idY3 }
}

// to refrain the rule from applying too many times
?idY1 < ?idY2
¬ ( c:?Xl { c:?r0-> c:?Y0l { c:id = ?idY0 } } & ?idY0 < ?idY1 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  num_deps = "2"
}
  ]
]

SSynt<=>SSynt weight_horizontal_3 : mark_weight
[
  leftside = [
c:?Xl {
  c:?r1-> c:?Y1l { c:id = ?idY1 }
  c:?r2-> c:?Y2l { c:id = ?idY2 }
  c:?r3-> c:?Y3l { c:id = ?idY3 }
  ¬c:?r4-> c:?Y4l { c:id = ?idY4 }
}

// to refrain the rule from applying too many times
?idY1 < ?idY2
?idY2 < ?idY3
¬ ( c:?Xl { c:?r0-> c:?Y0l { c:id = ?idY0 } } & ?idY0 < ?idY1 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  num_deps = "3"
}
  ]
]

SSynt<=>SSynt weight_horizontal_4 : mark_weight
[
  leftside = [
c:?Xl {
  c:?r1-> c:?Y1l { c:id = ?idY1 }
  c:?r2-> c:?Y2l { c:id = ?idY2 }
  c:?r3-> c:?Y3l { c:id = ?idY3 }
  c:?r4-> c:?Y4l { c:id = ?idY4 }
  ¬c:?r5-> c:?Y5l { c:id = ?idY5 }
}

// to refrain the rule from applying too many times
?idY1 < ?idY2
?idY2 < ?idY3
?idY3 < ?idY4
¬ ( c:?Xl { c:?r0-> c:?Y0l { c:id = ?idY0 } } & ?idY0 < ?idY1 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  num_deps = "4"
}
  ]
]

SSynt<=>SSynt weight_horizontal_5 : mark_weight
[
  leftside = [
c:?Xl {
  c:?r1-> c:?Y1l { c:id = ?idY1 }
  c:?r2-> c:?Y2l { c:id = ?idY2 }
  c:?r3-> c:?Y3l { c:id = ?idY3 }
  c:?r4-> c:?Y4l { c:id = ?idY4 }
  c:?r5-> c:?Y5l { c:id = ?idY5 }
  ¬c:?r6-> c:?Y6l { c:id = ?idY6 }
}

// to refrain the rule from applying too many times
?idY1 < ?idY2
?idY2 < ?idY3
?idY3 < ?idY4
?idY4 < ?idY5
¬ ( c:?Xl { c:?r0-> c:?Y0l { c:id = ?idY0 } } & ?idY0 < ?idY1 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  num_deps = "5"
}
  ]
]

SSynt<=>SSynt weight_horizontal_6 : mark_weight
[
  leftside = [
c:?Xl {
  c:?r1-> c:?Y1l { c:id = ?idY1 }
  c:?r2-> c:?Y2l { c:id = ?idY2 }
  c:?r3-> c:?Y3l { c:id = ?idY3 }
  c:?r4-> c:?Y4l { c:id = ?idY4 }
  c:?r5-> c:?Y5l { c:id = ?idY5 }
  c:?r6-> c:?Y6l { c:id = ?idY6 }
}

// to refrain the rule from applying too many times
?idY1 < ?idY2
?idY2 < ?idY3
?idY3 < ?idY4
?idY4 < ?idY5
?idY4 < ?idY6
¬ ( c:?Xl { c:?r0-> c:?Y0l { c:id = ?idY0 } } & ?idY0 < ?idY1 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  num_deps = "6"
}
  ]
]

/*Move dependent down in case it is the sibling of another dependent of a conjunction (ill-formed tree due to weird aggregation probably)*/
SSynt<=>SSynt mark_coord_relocate_anchor : mark_coord_relocate
[
  leftside = [
c:?Andl {
  c:?r1-> c:?Dep1 {
    c:id = ?idD1
  }
  c:?r2-> c:?Dep2 {
    c:id = ?idD2
  }
} 
  
lexicon.miscellaneous.conjunction.coord_conj_rel.?r1

?r1 == ?r2

?idD1 < ?idD2

// Only apply to cases with 2 conjuncts; rules for more conjunts are needed.
¬ ( c:?Andl { c:?r3-> c:?Dep3 { c:id = ?idD3 } } & lexicon.miscellaneous.conjunction.coord_conj_rel.?r3  & ¬ ?idD3 == ?idD1 & ¬ ?idD3 == ?idD2 )

// If ?X1 has a coordination, the anchor will be somewhere below it.
( c:?Dep1 { c:?s-> c:?Dep4 { ¬c:block = "yes" } } & ( lexicon.miscellaneous.conjunction.coord_rel.?s | lexicon.miscellaneous.conjunction.coord_conj_rel.?s ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Dep1R {
  rc:<=> ?Dep1
  anchor_coord_relocate = ?idD2
}
  ]
]

/*Move dependent down in case it is the sibling of another dependent of a conjunction (ill-formed tree due to weird aggregation probably)*/
SSynt<=>SSynt mark_coord_relocate_anchor_one_level : mark_coord_relocate
[
  leftside = [
c:?Andl {
  c:?r1-> c:?Dep1 {
    c:id = ?idD1
  }
  c:?r2-> c:?Dep2 {
    c:id = ?idD2
  }
} 
  
lexicon.miscellaneous.conjunction.coord_conj_rel.?r1

?r1 == ?r2

?idD1 < ?idD2

// Only apply to cases with 2 conjuncts; rules for more conjunts are needed.
¬ ( c:?Andl { c:?r3-> c:?Dep3 { c:id = ?idD3 } } & lexicon.miscellaneous.conjunction.coord_conj_rel.?r3  & ¬ ?idD3 == ?idD1 & ¬ ?idD3 == ?idD2 )

// If ?X1 has no coordination, the anchor will be  X1 itself (just one level below the original position of the moved conjunct)
¬ ( c:?Dep1 { c:?s-> c:?Dep4 { ¬c:block = "yes" } } & ( lexicon.miscellaneous.conjunction.coord_rel.?s | lexicon.miscellaneous.conjunction.coord_conj_rel.?s ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Dep1R {
  rc:<=> ?Dep1
  anchor_coord_relocate_final = ?idD2
}
  ]
]

/*Move dependent down in case it is the sibling of another dependent of a conjunction (ill-formed tree due to weird aggregation probably)*/
SSynt<=>SSynt mark_coord_relocate_anchor_percolate : mark_coord_relocate
[
  leftside = [
c:?Dep1 {
  c:id = ?idD1
  c:?r-> c:?Dep2 {
    c:?s-> c:?Dep3 {}
  }
}

( ( lexicon.miscellaneous.conjunction.coord_rel.?r | lexicon.miscellaneous.conjunction.coord_conj_rel.?r ) & ¬ ?Dep2.block == "yes" )

( ( lexicon.miscellaneous.conjunction.coord_rel.?s | lexicon.miscellaneous.conjunction.coord_conj_rel.?s ) & ¬ ?Dep3.block == "yes" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Dep1R {
  rc:<=> ?Dep1
  rc:anchor_coord_relocate = ?idD2
  rc:?R-> rc:?Dep2R {
    rc:<=> ?Dep2
    anchor_coord_relocate = ?idD2
  }
}

?R == ?r
  ]
]

/*Move dependent down in case it is the sibling of another dependent of a conjunction (ill-formed tree due to weird aggregation probably)*/
SSynt<=>SSynt mark_coord_relocate_anchor_percolate_final : mark_coord_relocate
[
  leftside = [
c:?Dep1 {
  c:id = ?idD1
  c:?r-> c:?Dep2 {}
}

( ( lexicon.miscellaneous.conjunction.coord_rel.?r | lexicon.miscellaneous.conjunction.coord_conj_rel.?r ) & ¬ ?Dep2.block == "yes"  )

¬ ( c:?Dep2 { c:?s-> c:?Dep3 { ¬c:block = "yes" } } & ( lexicon.miscellaneous.conjunction.coord_rel.?s | lexicon.miscellaneous.conjunction.coord_conj_rel.?s ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Dep1R {
  rc:<=> ?Dep1
  rc:anchor_coord_relocate = ?idD2
  rc:?R-> rc:?Dep2R {
    rc:<=> ?Dep2
    anchor_coord_relocate_final = ?idD2
  }
}

?R == ?r
  ]
]

