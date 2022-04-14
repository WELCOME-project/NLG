DMorph<=>SMorph transfer_node
[
  leftside = [
?Xl {
  ¬c:bubble = yes
  ¬c:elide = "yes"
  slex = ?l
}

//¬(c:?Xl{slex = "no" c:~?Govl{c:pos = "VB"}})

¬ ( language.id.iso.PL & ?l == "ty" )
¬ ( language.id.iso.PL & ?l == "4" )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  morph = ?l
}
  ]
]

DMorph<=>SMorph transfer_node_elide
[
  leftside = [
?Xl {
  ¬c:bubble = yes
  c:elide = "yes"
}
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  morph = ""
  inflect = no
}
  ]
]

DMorph<=>SMorph transfer_relation_precedence
[
  leftside = [
c:?Xl {
  ~ c:?Yl {}
}
 //for covering those cases of intermediate adjuncts
¬(c:?Xl{c:adjunct = "final_lin_adjunct"} & c:?Yl{¬c:slex = "."})

( ¬ ( c:?Xl { c:n_modif = ?nm1 ¬c:no_comma = "yes" } & ¬ ( c:?Yl { c:n_modif = ?nm2 } & ?nm1 == ?nm2 ) ) | ?Yl.slex == "." | ?Yl.slex == "," )
¬ ( c:?Yl { c:n_modif = ?nm3 ¬c:no_comma = "yes"  } & ¬ ( c:?Xl { c:n_modif = ?nm4 } & ?nm3 == ?nm4 ) )

¬ ( c:?Xl { c:parenth = ?p1 } & ¬ ( c:?Yl { c:parenth = ?p2 } & ?p1 == ?p2 ) )
¬ ( c:?Yl { c:parenth = ?p3 } & ¬ ( c:?Xl { c:parenth = ?p4 } & ?p3 == ?p4 ) )
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

DMorph<=>SMorph transfer_relation_concatenate
[
  leftside = [
c:?Xl {
  concatenate_gov = ?c
  c:~ c:?Yl {
    c:slex = ?s
  }
}

?c == ?s
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  concatenate-> rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

excluded DMorph<=>SMorph assign_first_ID
[
  leftside = [
c:?Xl {
  c:~ c:?Yl {}
}

// ?Xl is the first node
¬c:?Zl { c:~ c:?Xl {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  id_gen = "1"
}
  ]
]

excluded DMorph<=>SMorph assing_remaining_IDs
[
  leftside = [
c:?Xl {
  c:~ c:?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:id_gen = ?id
  rc:~ rc:?Yr {
    rc:<=> ?Yl
    id_gen = #?id+"1"#
  }
}
  ]
]

/*Compiles info needed for generating the final form, instead of retrieving it.*/
DMorph<=>SMorph morph_gen_build
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DMorph<=>SMorph DE
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DMorph<=>SMorph EL
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DMorph<=>SMorph EN
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DMorph<=>SMorph CA_ES_FR_IT_PT
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DMorph<=>SMorph PL
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*We rebuild the dependency structure for the prosody to use dependencies as features.
Real bad move cuz we count on the names of the words (no individual IDs so far).
If two nodes have the same name, the dependency structure will be wrong.*/
excluded DMorph<=>SMorph PATCH_add_dependency_backwards
[
  leftside = [
c:?Xl {
  gov_gen = ?g1
  deprel_gen = ?d
  c:*~ c:?Yl {
    c:slex = ?g2
  }
}

?g1 == ?g2
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ?d-> rc:?Xr {
    rc:<=> ?Xl
  }
}

//?e == ?d
  ]
]

/*We rebuild the dependency structure for the prosody to use dependencies as features.
Real bad move cuz we count on the names of the words (no individual IDs so far).
If two nodes have the same name, the dependency structure will be wrong.*/
excluded DMorph<=>SMorph PATCH_add_dependency_forward
[
  leftside = [
c:?Xl {
  c:slex = ?g2
  c:*~ c:?Yl {
    gov_gen = ?g1
    deprel_gen = ?d
  }
}

?g1 == ?g2
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ?d-> rc:?Yr {
    rc:<=> ?Yl
  }
}

//?e == ?d
  ]
]

/*We rebuild the dependency structure for the prosody to use dependencies as features.
Real bad move cuz we count on the names of the words (no individual IDs so far).
If two nodes have the same name, the dependency structure will be wrong.*/
excluded DMorph<=>SMorph PATCH_add_dependency_final_punc
[
  leftside = [
c:?Xl {
  ¬c:gov_gen = ?g1
  ¬c:deprel_gen = ?d
  c:*~ c:?Yl {
    ¬c:~ c:?Zl {}
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  punc-> rc:?Yr {
    rc:<=> ?Yl
  }
}

//?e == ?d
  ]
]

DMorph<=>SMorph K_attr_gestures
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DMorph<=>SMorph K_attr_gestures_bubble
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

DMorph<=>SMorph attr_added_prep
[
  leftside = [
c:?Xl {
  added_prep = ?n
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

DMorph<=>SMorph attr_blocked
[
  leftside = [
c:?Xl {
  c:blocked = ?pos
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  blocked = ?pos
}
  ]
]

/*Needed for generation of prosody.*/
DMorph<=>SMorph attr_dsyntRel
[
  leftside = [
c:?Xl {
  dsyntRel = ?fin
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  dsyntRel = ?fin
}
  ]
]

DMorph<=>SMorph attr_finiteness
[
  leftside = [
c:?Xl {
  c:finiteness = ?pos
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  finiteness = ?pos
}
  ]
]

DMorph<=>SMorph attr_gender
[
  leftside = [
c:?Xl {
  c:gender = ?pos
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  gender = ?pos
}
  ]
]

DMorph<=>SMorph attr_lex
[
  leftside = [
c:?Xl {
  c:lex = ?lex
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

DMorph<=>SMorph attr_number
[
  leftside = [
c:?Xl {
  c:number = ?pos
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  number = ?pos
}
  ]
]

DMorph<=>SMorph attr_pos
[
  leftside = [
c:?Xl {
  c:pos = ?pos
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  pos = ?pos
}
  ]
]

DMorph<=>SMorph attr_slex
[
  leftside = [
c:?Xl {
  c:slex = ?pos
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  morph_backup = ?pos
}
  ]
]

DMorph<=>SMorph attr_spos
[
  leftside = [
c:?Xl {
  c:spos = ?pos
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  spos = ?pos
}
  ]
]

DMorph<=>SMorph attr_thematicity
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

DMorph<=>SMorph add_final_comma_adjunct
[
  leftside = [
c:?Xl {
  ¬c:n_modif = ?nm1
  ~ c:?Yl {}
}

(c:?Xl{c:adjunct = "final_lin_adjunct"} & c:?Yl{¬c:slex = "."}) //for covering those cases of intermediate adjuncts
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ~ ?Cr{
    morph = ","
    ~ rc:?Yr {
      rc:<=> ?Yl
    }
  }
}
  ]
]

/*Introduces the opening comma and parenthesis.
NOT TESTED.*/
DMorph<=>SMorph add_comma_nmodif_parenth1
[
  leftside = [
c:?Xl {
  ~ c:?Yl {
    c:n_modif = ?nm1
    c:parenth = ?p1
    ¬c:no_comma = "yes"
  }
}

¬ ( c:?Xl { c:n_modif = ?nm2 } & ?nm1 == ?nm2 )
¬ ( c:?Xl { c:parenth = ?p2 } & ?p1 == ?p2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ~ ?Cr{
    morph = ", ("
    ~ rc:?Yr {
      rc:<=> ?Yl
    }
  }
}
  ]
]

/*Introduces the opening comma.*/
DMorph<=>SMorph add_comma_nmodif1
[
  leftside = [
c:?Xl {
  ~ c:?Yl {
    c:n_modif = ?nm1
    ¬c:no_comma = "yes"
  }
}

¬ ( c:?Xl { c:n_modif = ?nm2 } & ?nm1 == ?nm2 )

// don't apply if there is also an opening parenthesis (not tested)
¬ ( c:?Yl { c:parenth = ?p1} & ¬( c:?Xl { c:parenth = ?p2 } & ?p1 == ?p2 ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ~ ?Cr{
    morph = ","
    ~ rc:?Yr {
      rc:<=> ?Yl
    }
  }
}
  ]
]

/*Introduces the opening parenthesis.*/
DMorph<=>SMorph add_parenth1
[
  leftside = [
c:?Xl {
  c:~ c:?Yl {
    c:parenth = ?p1
  }
}

¬ ( c:?Xl { c:parenth = ?p2 } & ?p1 == ?p2 )

// don't apply if there is also an opening comma (not tested)
¬ ( c:?Yl { c:n_modif = ?n1 } & ¬( c:?Xl { c:n_modif = ?n2 } & ?n1 == ?n2 ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ~ ?Cr{
    morph = "("
    ~ rc:?Yr {
      rc:<=> ?Yl
    }
  }
}
  ]
]

/*Introduces the opening parenthesis.*/
excluded DMorph<=>SMorph add_parenth1
[
  leftside = [
c:?Xl {
  c:~ c:?Yl {
    c:parenth = ?p1
  }
}

¬ ( c:?Xl { c:parenth = ?p2 } & ?p1 == ?p2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  rc:morph = ?s
  rc:morph_backup = ?mb
  // so rule applies after the rules that introduce possible inflection information
  rc:~ rc:?Follow {}
  ¬rc:parenth = "yes"
  // that's not very smart, as it won't be possible to inflect the word if needed.
  morph = #(+?s#
  morph_backup = #(+?mb#
  parenth = "yes"
}
  ]
]

/*Introduces the closing comma and parenthesis.*/
DMorph<=>SMorph add_comma_nmodif_parenth2
[
  leftside = [
c:?Xl {
  c:n_modif = ?nm1
  c:parenth = ?p1
  ¬c:no_comma = "yes"
  ~ c:?Yl {
// if ?Yl has a n_modif that is different from ?nm1, nmodif2 takes care of the comma
    ¬c:n_modif = ?nm2
    ¬c:parenth = ?p2
  }
}

¬ ?Yl.slex == "."
¬ ?Yl.slex == ","
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ~ ?Cr {
    morph = ") ,"
    ~ rc:?Yr {
      rc:<=> ?Yl
    }
  }
}
  ]
]

/*Introduces the closing comma and parenthesis.*/
DMorph<=>SMorph add_comma_nmodif_parenth2_comma
[
  leftside = [
c:?Xl {
  c:n_modif = ?nm1
  c:parenth = ?p1
  ¬c:no_comma = "yes"
  ~ c:?Yl {
// if ?Yl has a n_modif that is different from ?nm1, nmodif2 takes care of the comma
    ¬c:n_modif = ?nm2
    ¬c:parenth = ?p2
  }
}

¬ ?Yl.slex == "."
?Yl.slex == ","
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ~ ?Cr {
    morph = ")"
    ~ rc:?Yr {
      rc:<=> ?Yl
    }
  }
}
  ]
]

/*Introduces the closing comma.*/
DMorph<=>SMorph add_comma_nmodif2
[
  leftside = [
c:?Xl {
  c:n_modif = ?nm1
  ¬c:no_comma = "yes"
  ~ c:?Yl {
// if ?Yl has a n_modif that is different from ?nm1, nmodif2 takes care of the comma
    ¬c:n_modif = ?nm2
  }
}

¬ ?Yl.slex == "."
¬ ?Yl.slex == ","

// don't apply if there is also a closing parenthesis
¬ ( c:?Xl { c:parenth = ?p1 } & c:?Yl { ¬c:parenth = ?p2 } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ~ ?Cr {
    morph = ","
    ~ rc:?Yr {
      rc:<=> ?Yl
    }
  }
}
  ]
]

/*Introduces the closing parenthesis.*/
DMorph<=>SMorph add_parenth2
[
  leftside = [
c:?Xl {
  c:parenth = ?p1
  c:~ c:?Yl {
    ¬c:parenth = ?p2
  }
}

// don't apply if there is also a closing comma
¬ ( c:?Xl { c:n_modif = ?n1 } & c:?Yl { ¬c:n_modif = ?n2 } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ~ ?Cr {
    morph = ")"
    ~ rc:?Yr {
      rc:<=> ?Yl
    }
  }
}
  ]
]

/*Introduces the closing parenthesis.*/
excluded DMorph<=>SMorph add_parenth2
[
  leftside = [
c:?Xl {
  c:parenth = ?p1
  c:~ c:?Yl {
    ¬c:parenth = ?p2
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:morph = ?s
  rc:morph_backup = ?mb
  // so rule applies after the rules that introduce possible inflection information
  rc:~ rc:?Follow {}
  ¬rc:parenth = "yes"
  // that's not very smart, as it won't be possible to inflect the word if needed.
  morph = #?s+)#
  morph_backup = #?mb+)#
  parenth = "yes"
}
  ]
]

DMorph<=>SMorph percolate_blocked
[
  leftside = [
c:?Xl {
  c:*~ c:?Yl {} 
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:blocked ="YES"
  //rc:n = ?n
  rc:~ rc:?Yr {
    rc:<=> ?Yl
    blocked ="YES"
    //n = #?n+1#
  }
}
  ]
]

excluded DMorph<=>SMorph add_bubble
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
?bubble {
  morph = "Sentence"
  bubble = yes
  rc:+?Xr {
    rc:<=> ?Xl
    rc:pos = ?p
  }
}
  ]
]

excluded DMorph<=>SMorph extend_bubble
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
?bubble {
  morph = "Sentence"
  bubble = yes
  rc:+?Xr {
    rc:<=> ?Xl
    rc:pos = ?p
  }
}
  ]
]

DMorph<=>SMorph morph_gen_build_JJ : morph_gen_build
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  c:lex = ?lex
}

lexicon.?lex.adj_root.?root
lexicon.?lex.adj_group.?group

( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  rc:gen_suffix = ?suf
  rule_prefix = ?root
  rule_suffix = #?group+_+?suf#
}
  ]
]

DMorph<=>SMorph morph_gen_build_N : morph_gen_build
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  c:lex = ?lex
}

lexicon.?lex.noun_root.?root
lexicon.?lex.noun_group.?group
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  rc:gen_suffix = ?suf
  rule_prefix = ?root
  rule_suffix = #?group+_+?suf#
}
  ]
]

DMorph<=>SMorph morph_gen_build_V_prefix : morph_gen_build
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  c:lex = ?lex
}

lexicon.?lex.verb_root.?root
//lexicon.?lex.verb_group.?group
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  rc:gen_suffix = ?suf
  rule_prefix = ?root
//  rule_suffix = #?group+_+?suf#
}
  ]
]

DMorph<=>SMorph EN_morph_gen_build_V_prefix : morph_gen_build
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  c:pos = "VB"
  c:slex = ?lex
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  rc:gen_suffix = ?suf
  rule_prefix = ?lex
//  rule_suffix = #?group+_+?suf#
}
  ]
]

DMorph<=>SMorph morph_gen_build_V_suffix : morph_gen_build
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  ( c:pos = "VB" | c:pos = "MD" )
  c:lex = ?lex
}

//lexicon.?lex.verb_root.?root
¬lexicon.?lex.verb_group.?group
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  rc:gen_suffix = ?suf
  // rule_prefix = ?root
  rule_suffix = #?suf#
}
  ]
]

DMorph<=>SMorph morph_gen_build_V_suffix_group : morph_gen_build
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  ( c:pos = "VB" | c:pos = "MD" )
  c:lex = ?lex
}

//lexicon.?lex.verb_root.?root
lexicon.?lex.verb_group.?group
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  rc:gen_suffix = ?suf
  // rule_prefix = ?root
  rule_suffix = #?group+_+?suf#
}
  ]
]

DMorph<=>SMorph DE_JJ : DE
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  pos = ?pos
  number = ?num
  gender = ?gen
  case = ?cas
}

language.id.iso.DE

( ?pos == "JJ" | ?pos == "DT" )
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<+?pos+><+?gen+><+?num+><+?cas+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph DE_N : DE
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  pos = "NN"
  ¬c:invariant = yes
  number = ?num
  case = ?case
}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<N><+?num+><+?case+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph DE_V_finite : DE
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  ¬c:tem_constituency = ?tc
  finiteness = "FIN"
  mood = ?mood
  tense = ?ten
  person = ?per
  number = ?num
}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<V><+?mood+><+?ten+><+?num+><+?per+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph DE_V_finite_tc : DE
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  tem_constituency = ?tc
  finiteness = "FIN"
  mood = ?mood
  tense = ?ten
  person = ?per
  number = ?num
}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<V><+?tc+><+?mood+><+?ten+><+?num+><+?per+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph DE_V_non_finite : DE
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  ¬c:tem_constituency = ?tc
  finiteness = ?fin
}

language.id.iso.DE

¬ ?fin == "FIN"
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<V><+?fin+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph EL_concatenate : EL
[
  leftside = [
c:?Prep {
  c:slex = "σε"
  c:~ c:?Det {
    c:pos = "DT"
    c:slex = "ο"
    c:case = "ACC"
  }
}

language.id.iso.EL
  ]
  mixed = [

  ]
  rightside = [
rc:?PrepR {
  rc:<=> ?Prep
  concatenate-> rc:?DetR {
    rc:<=> ?Det
  }
}
  ]
]

DMorph<=>SMorph EL_DT_JJ_WP : EL
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  pos = ?pos
  number = ?num
  gender = ?gen
  case = ?cas
}

language.id.iso.EL

( ?pos == "JJ" | ?pos == "DT" | ?pos == "WP" )
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<+?pos+><+?gen+><+?num+><+?cas+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph EL_N : EL
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  pos = "NN"
  ¬c:invariant = yes
  number = ?num
  case = ?case
}

language.id.iso.EL
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<N><+?num+><+?case+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph EL_V_finite : EL
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  finiteness = "FIN"
  mood = ?mood
  number = ?num
  person = ?per
//  tem_constituency = ?tc
  tense = ?ten
  voice = ?voi
}

language.id.iso.EL
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<V><+?voi+><+?mood+><+?ten+><+?num+><+?per+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph EL_V_non_finite : EL
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  ¬c:tem_constituency = ?tc
  finiteness = ?fin
}

language.id.iso.EL

¬ ?fin == "FIN"
¬ ?fin == "PART"
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<V><+?fin+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph EL_V_non_finite_PART : EL
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  finiteness = "PART"
  number = ?num
  gender = ?gen
  case = ?cas
}

language.id.iso.EL
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<V><PART><+?gen+><+?num+><+?cas+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph EL_Pro : EL
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  pos = ?pos
  ( c:slex = "_PRO_" | c:slex = "_PRO-HUM_" )
  case = ?case
  gender = ?gen
  number = ?num
  person = ?per
  //deprel_gen = ?dep
}

language.id.iso.EL

( ?pos == "PP" | ?pos == "WP$" | ?pos == "WP" )
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<+?pos+><+?per+><+?gen+><+?num+><+?case+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph EN_negation_verb : EN
[
  leftside = [
c:?Xl{
  ¬c:elide = "yes"
  c:slex = "no" 
  c:~?Vl{
    c:pos = "VB"
    c:mood = ?d
    c:number = ?n
    c:person = ?p
    c:tense = ?t
    }
  }

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<+?d+><+?t+><+?n+><+?p+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph EN_N : EN
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  pos = "NN"
  ¬c:invariant = yes
  number = ?num
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<N><+?num+>#
  inflect = yes
  gen_suffix = #<N><+?num+>#
}
  ]
]

DMorph<=>SMorph EN_V_finite : EN
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  finiteness = "FIN"
  mood = ?mood
  tense = ?ten
  person = ?per
  number = ?num
}

language.id.iso.EN

¬ c:?Ml{
  (c:slex = "must" | c:slex = "should" | c:slex = "should") 		//when a verb follows a modal, does not conjugate
  c:~ c:?node {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<V><+?mood+><+?ten+><+?num+><+?per+>#
  inflect = yes
  gen_suffix = #<V><+?mood+><+?ten+><+?num+><+?per+>#
}
  ]
]

DMorph<=>SMorph EN_V_non_finite_non_modal : EN
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  finiteness = ?fin
}

language.id.iso.EN

¬ ?fin == "FIN"
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<V><+?fin+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph EN_epenthesis : EN
[
  leftside = [
c:?det {
  ¬c:elide = "yes"
  c:slex = "a"
  c:~ c:?node {
    c:lex = ?lex
  }
}

language.id.iso.EN

lexicon.?lex.epenthesis.yes
  ]
  mixed = [

  ]
  rightside = [
rc:?detR {
  rc:<=> ?det
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<DT><epenthesis>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph EN_Pro_poss : EN
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  pos = ?pos
  ( c:slex = "its" | c:slex = "he" )
  gender = ?gen
  number = ?num
  person = ?per
}

language.id.iso.EN

(?pos == "DT" | ?pos == "PP")
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<+?pos+><+?per+><+?gen+><+?num+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph EN_Pro_nonPoss : EN
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  pos = ?pos
  ( c:slex = "_PRO_" | c:slex = "_PRO-HUM_" )
  gender = ?gen
  number = ?num
  person = ?per
  deprel_gen = ?dep
}

language.id.iso.EN

?pos == "PP"
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<+?pos+><+?per+><+?gen+><+?num+><+?dep+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph EN_V_finite_coord : EN
[
  leftside = [
c:?V1 {
  c:finiteness = "FIN"
  c:mood = ?mood1
  c:tense = ?ten1
  c:person = ?per
  c:number = ?num1
  c:*~c:?and{
      c:slex = "and"
      c:~c:?node {
          ¬c:elide = "yes"
          c:finiteness = "FIN"
          c:mood = ?mood
          c:tense = ?ten
          c:number = ?num
          ¬c:person = ?per1
     }
  }
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<V><+?mood+><+?ten+><+?num+><+?per+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph EN_V_finite_embedded : EN
[
  leftside = [
c:?V1 {
  c:finiteness = "FIN"
  c:mood = ?mood1
  c:tense = ?ten1
  c:person = ?per
  c:number = ?num1
  c:*~c:?sub{
      c:slex = "when"
      c:~c:?node {
          ¬c:elide = "yes"
          c:finiteness = "FIN"
          c:mood = ?mood
          c:tense = ?ten
          c:number = ?num
          ¬c:person = ?per1
     }
  }
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<V><+?mood+><+?ten+><+?num+><+?per+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph EN_V_non_finite_modal : EN
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  finiteness = ?fin
}

language.id.iso.EN

c:?Ml{
  (c:slex = "must" | c:slex = "should" | c:slex = "should") 		//when a verb follows a modal, does not conjugate
  c:~ c:?node {}
  }
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<V><+INF>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph EN_DT : EN
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  pos = "DT"
  ¬c:invariant = yes
  number = ?num
}

language.id.iso.EN

¬ ( c:?node {c:gender = ?g c:person = ?p ( c:slex = "its" | c:slex = "he" ) } )
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<DT><+?num+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph CA_concatenate : CA_ES_FR_IT_PT
[
  leftside = [
c:?Prep {
  ( c:slex = "de" | c:slex = "a" | c:slex = "per" )
  c:~ c:?Det {
    c:~ c:?Noun {
      c:lex = ?Nlex
    }
  }
}

language.id.iso.CA

c:?Det { c:slex = "el" c:gender = "MASC" }
  ]
  mixed = [
// In Catalan preposition+article are not concatenated if the article can be apostrophized
¬ ( ( morph.?m.startswith.vowel | lexicon.?Nlex.startswith.vowel ) & c:?Det { c:number = "SG" } )

  ]
  rightside = [
rc:?PrepR {
  rc:<=> ?Prep
  concatenate-> rc:?DetR {
    rc:<=> ?Det
    rc:~ rc:?NounR {
      rc: <=> ?Noun
      rc:morph = ?m
    }
  }
}
  ]
]

DMorph<=>SMorph ES_concatenate : CA_ES_FR_IT_PT
[
  leftside = [
c:?Prep {
  ( c:slex = "de" | c:slex = "a" )
  c:~ c:?Det {}
}

language.id.iso.ES

( c:?Det { c:slex = "el" c:number = "SG" c:gender = "MASC" }
 | ( c:?Det { c:slex = "el" c:number = "SG" c:gender = "FEM" c:~ c:?Noun {c:lex = ?l} } & lexicon.?l.startswith.?v & ?v == "a_tonica" )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?PrepR {
  rc:<=> ?Prep
  concatenate-> rc:?DetR {
    rc:<=> ?Det
  }
}
  ]
]

DMorph<=>SMorph IT_concatenate : CA_ES_FR_IT_PT
[
  leftside = [
c:?Prep {
  ( c:slex = "a" | c:slex = "di" | c:slex = "da" | c:slex = "in" | c:slex = "su" )
  c:~ c:?Det {
    c:pos = "DT"
    ¬c:slex = "un"
  }
}

language.id.iso.IT

// it is also true for plural!
//( c:?Det { c:slex = "il" c:number = "SG" } )
  ]
  mixed = [

  ]
  rightside = [
rc:?PrepR {
  rc:<=> ?Prep
  concatenate-> rc:?DetR {
    rc:<=> ?Det
  }
}
  ]
]

DMorph<=>SMorph PT_concatenate_o : CA_ES_FR_IT_PT
[
  leftside = [
c:?Prep {
  ( c:slex = "de" | c:slex = "a" | c:slex = "em" | c:slex = "para" | c:slex = "por" )
  c:~ c:?Det {}
}

language.id.iso.PT

c:?Det { c:slex = "o" }
  ]
  mixed = [

  ]
  rightside = [
rc:?PrepR {
  rc:<=> ?Prep
  concatenate-> rc:?DetR {
    rc:<=> ?Det
  }
}
  ]
]

DMorph<=>SMorph PT_concatenate_um : CA_ES_FR_IT_PT
[
  leftside = [
c:?Prep {
  c:slex = "em"
  c:~ c:?Det {}
}

language.id.iso.PT

c:?Det { c:slex = "um" }
  ]
  mixed = [

  ]
  rightside = [
rc:?PrepR {
  rc:<=> ?Prep
  concatenate-> rc:?DetR {
    rc:<=> ?Det
  }
}
  ]
]

/*Go get the info on ?Det's governor, which need to be a dobj or a prepos relation.*/
excluded DMorph<=>SMorph PT_concatenate_PRO : CA_ES_FR_IT_PT
[
  leftside = [
c:?Prep {
  ( c:slex = "de" | c:slex = "em" )
  c:~ c:?Det {}
}

language.id.iso.PT

c:?Det { c:slex = "_PRO-HUM_" }
  ]
  mixed = [

  ]
  rightside = [
rc:?PrepR {
  rc:<=> ?Prep
  concatenate-> rc:?DetR {
    rc:<=> ?Det
  }
}
  ]
]

DMorph<=>SMorph CA_ES_FR_IT_PT_JJ_variable : CA_ES_FR_IT_PT
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  ¬ ( c:slex = "su" | c:slex = "son" )
  pos = ?pos
  number = ?num
  gender = ?gen
  c:slex = ?s
}

( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

( ?pos == "JJ" | ?pos == "DT" )

//?lex == "le_DT_01"
//?lex == #?s+_+?pos+_01#

//(¬lexicon.?lex.gender | (lexicon.?lex.gender.?h & ¬?h == "invariable"))

¬(lexicon.?lex.lemma.?s & lexicon.?lex.gender.?g & ?g == "invariable")
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<+?pos+><+?gen+><+?num+>#
  inflect = yes
  gen_suffix = #<+?pos+><+?gen+><+?num+>#
}
  ]
]

DMorph<=>SMorph CA_ES_FR_IT_PT_N_lexical_gender : CA_ES_FR_IT_PT
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  pos = "NN"
  ¬c:invariant = yes
  number = ?num
  lex = ?lex
}

( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

lexicon.?lex.gender.?g
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<N><+?num+>#
  inflect = yes
  gen_suffix = #<N><+?num+>#
}
  ]
]

DMorph<=>SMorph CA_ES_FR_IT_PT_N_no_lexical_gender : CA_ES_FR_IT_PT
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  pos = "NN"
  ¬c:invariant = yes
  number = ?num
  lex = ?lex
  gender = ?g
}

( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

¬lexicon.?lex.gender.?g
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<N><+?g+><+?num+>#
  inflect = yes
  gen_suffix = #<N><+?num+>#
}
  ]
]

DMorph<=>SMorph CA_ES_FR_IT_PT_V_finite_noAspect : CA_ES_FR_IT_PT
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  finiteness = "FIN"
  mood = ?mood
  tense = ?ten
  person = ?per
  number = ?num
  ¬c:tem_constituency = ?tc
}

( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<V><+?mood+><IMP><+?ten+><+?num+><+?per+>#
  gen_suffix = #<V><+?mood+><IMP><+?ten+><+?num+><+?per+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph CA_ES_FR_IT_PT_V_finite_Aspect : CA_ES_FR_IT_PT
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  finiteness = "FIN"
  mood = ?mood
  tense = ?ten
  person = ?per
  number = ?num
  tem_constituency = ?tc
}

( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<V><+?mood+><+?tc+><+?ten+><+?num+><+?per+>#
  gen_suffix = #<V><+?mood+><+?tc+><+?ten+><+?num+><+?per+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph CA_ES_FR_IT_PT_V_GER : CA_ES_FR_IT_PT
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  finiteness = ?fin
}

( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

¬c:?et{
  (c:slex = "et" | c:slex = "y")			//this condition excludes the cases where a coordinated verb
  c:~ c:?node{}}						//takes finiteness = "INF" and it should be conjugated

?fin == "GER"
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<V><+?fin+>#
  gen_suffix = #<V><+?fin+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph CA_ES_FR_IT_PT_V_PART : CA_ES_FR_IT_PT
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  finiteness = "PART"
  c:number = ?n
  c:gender = ?g
}

( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

¬c:?et{
  (c:slex = "et" | c:slex = "y")			//this condition excludes the cases where a coordinated verb
  c:~ c:?node{}
  }							//takes finiteness = "INF" and it should be conjugated
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<V><PART><+?g+><+?n+>#
  inflect = yes
  gen_suffix = #<V><PART><+?g+><+?n+>#
}
  ]
]

DMorph<=>SMorph CA_ES_FR_IT_PT_V_PART_default : CA_ES_FR_IT_PT
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  finiteness = ?fin
}

( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

¬c:?et{
  (c:slex = "et" | c:slex = "y")			//this condition excludes the cases where a coordinated verb
  c:~ c:?node{}}						//takes finiteness = "INF" and it should be conjugated

( ?fin == "PART" & c:?node { ( ¬c:number = ?n | ¬c:gender = ?g ) } )
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<V><+?fin+><MASC><SG>#
  inflect = yes
  rule = yes
  gen_suffix = #<V><PART><MASC><SG>#
}
  ]
]

DMorph<=>SMorph ES_poss_Pro : CA_ES_FR_IT_PT
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  pos = ?pos
  c:slex = "su"
  number = ?num
  person = ?per
}

language.id.iso.ES

(?pos == "DT" | ?pos == "PP")
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<+?pos+><+?per+><+?num+>#
  inflect = yes
}
  ]
]

/*Pronoun subject is dropped in Spanish*/
excluded DMorph<=>SMorph ES_Pro_subj : CA_ES_FR_IT_PT
[
  leftside = [
c:?node {
  pos = ?pos
  ( c:slex = "_PRO_" | c:slex = "_PRO-HUM_" )
  deprel_gen = subj
}

language.id.iso.ES

?pos == "PP"
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  inflect = no
  blocked = "unique"
}
  ]
]

/*Pronoun subject is dropped in Spanish*/
excluded DMorph<=>SMorph ES_Pro_noSubj : CA_ES_FR_IT_PT
[
  leftside = [
c:?node {
  pos = ?pos
  ( c:slex = "_PRO_" | c:slex = "_PRO-HUM_" )
  c:deprel_gen = ?r
  c:gender = ?gen
  c:number = ?num
}

¬?r == subj

language.id.iso.ES

lexicon.miscellaneous.personal_pronouns.human.?num.?gen.?r.?M

?pos == "PP"
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = ?M
  inflect = no
}
  ]
]

DMorph<=>SMorph CA_ES_FR_IT_PT_Pro_nonPoss : CA_ES_FR_IT_PT
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  pos = ?pos
  ( c:slex = "_PRO_" | c:slex = "_PRO-HUM_" | c:slex = "cuyo" )
  gender = ?gen
  number = ?num
  person = ?per
  deprel_gen = ?dep
}

( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )


¬(?r == subj & language.id.iso.ES )

( ?pos == "PP" | ?pos == "WP$" | ?pos == "WP" )
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<+?pos+><+?per+><+?gen+><+?num+><+?dep+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph FR_poss_Pro : CA_ES_FR_IT_PT
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  pos = ?pos
  c:slex = "son"
  number = ?num
  person = ?per
  gender = ?gen
}

language.id.iso.FR

(?pos == "DT" | ?pos == "PP")
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<+?pos+><+?per+><+?gen+><+?num+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph CA_ES_FR_IT_PT_JJ_invariable : CA_ES_FR_IT_PT
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  ¬ ( c:slex = "su" | c:slex = "son" )
  pos = ?pos
  number = ?num
  gender = ?gen
  c:slex = ?s
}

( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

( ?pos == "JJ" | ?pos == "DT" )

(lexicon.?lex.lemma.?s & lexicon.?lex.pos.?pos & lexicon.?lex.gender.?g & ?g == "invariable")
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<+?pos+><+?num+>#
  inflect = yes
}
  ]
]

excluded DMorph<=>SMorph ES_FR_IT_V_finite_coord : CA_ES_FR_IT_PT
[
  leftside = [
c:?V1 {
  c:finiteness = "FIN"
  c:mood = ?mood1
  c:tense = ?ten1
  c:person = ?per
  c:number = ?num1
  c:*~c:?and{
     ( c:slex = "et" | c:slex = "y")
      c:~c:?node {
         ¬c:elide = "yes"
         // c:finiteness = "FIN" (sometimes it carries finiteness = "INF"
         // c:mood = ?mood
        //  c:tense = ?ten
        //  c:number = ?num
          ¬c:person = ?per1
          c:pos = "VB"
     }
  }
}

(language.id.iso.FR | language.id.iso.ES | language.id.iso.IT )
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<V><+?mood1+><+?ten1+><+?num1+><+?per+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph FR_poss_modifier : CA_ES_FR_IT_PT
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  pos = ?pos
  ( c:slex = "nous" )
  c:dsyntRel = ATTR
}

language.id.iso.FR

(?pos == "DT" | ?pos == "PP")
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<GER>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph CA_ES_FR_IT_PT_V_finite_coord : CA_ES_FR_IT_PT
[
  leftside = [
c:?V1 {
  c:finiteness = "FIN"
  c:mood = ?mood1
  c:tense = ?ten1
  c:person = ?per
  c:number = ?num1
  c:*~c:?and{
     ( c:slex = "et" | c:slex = "y")
      c:~c:?node {
          ¬c:elide = "yes"
          c:finiteness = "FIN"
          c:mood = ?mood
          c:tense = ?ten
          c:number = ?num
          ¬c:person = ?per1
     }
  }
}

( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<V><+?mood+><+?ten+><+?num+><+?per+>#
  gen_suffix = #<V><+?mood+><+?ten+><+?num+><+?per+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph CA_ES_FR_IT_PT_V_finite_embedded : CA_ES_FR_IT_PT
[
  leftside = [
c:?V1 {
  c:finiteness = "FIN"
  c:mood = ?mood1
  c:tense = ?ten1
  c:person = ?per
  c:number = ?num1
  c:*~c:?sub{
     ( c:slex = "quand" | c:slex = "cuando")
      c:~c:?node {
          ¬c:elide = "yes"
          c:finiteness = "FIN"
          c:mood = ?mood
          c:tense = ?ten
          c:number = ?num
          ¬c:person = ?per1
     }
  }
}

( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<V><+?mood+><+?ten+><+?num+><+?per+>#
  gen_suffix = #<V><+?mood+><+?ten+><+?num+><+?per+>#
  inflect = yes
}
  ]
]

excluded DMorph<=>SMorph IT_particle : CA_ES_FR_IT_PT
[
  leftside = [
c:?Part {
  ( c:slex = "ci" | c:slex = "ne" )
  c:~ c:?Essere {
    c:slex = "essere"
  }
}

language.id.iso.IT
  ]
  mixed = [

  ]
  rightside = [
rc:?PartR {
  rc:<=> ?Part
  ¬rc:inflect = yes
  inflect = yes
}
  ]
]

DMorph<=>SMorph PL_JJ : PL
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  ¬ ( c:slex = "su" | c:slex = "son" )
  pos = ?pos
  number = ?num
  gender = ?gen
  case = ?case
}

language.id.iso.PL

( ?pos == "JJ" | ?pos == "DT" )
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<+?pos+><+?gen+><+?num+><+?case+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph PL_N : PL
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  ( pos = "NN" | pos = "NP" )
  ¬c:invariant = yes
  ¬c:slex = "dwudziestej pierwszej czterdzieści pięć"
  ¬c:slex = "szóstej rano"
  number = ?num
  case = ?case
}

language.id.iso.PL
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<N><+?num+><+?case+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph PL_V_finite : PL
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  ¬c:tem_constituency = ?tc
  finiteness = "FIN"
  mood = ?mood
  tense = ?ten
  person = ?per
  number = ?num
}

language.id.iso.PL
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<V><+?mood+><+?ten+><+?num+><+?per+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph PL_V_finite_tc : PL
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  tem_constituency = ?tc
  finiteness = "FIN"
  mood = ?mood
  tense = ?ten
  person = ?per
  number = ?num
}

language.id.iso.PL
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<V><+?tc+><+?mood+><+?ten+><+?num+><+?per+>#
  inflect = yes
}
  ]
]

DMorph<=>SMorph PL_V_non_finite : PL
[
  leftside = [
c:?node {
  ¬c:elide = "yes"
  ¬c:tem_constituency = ?tc
  finiteness = ?fin
}

language.id.iso.PL

¬ ?fin == "FIN"
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<V><+?fin+>#
  inflect = yes
}
  ]
]

excluded DMorph<=>SMorph PL_poss_Pro : PL
[
  leftside = [
c:?node {
  pos = ?pos
  ( c:slex = "su" | c:slex = "son" )
  number = ?num
  person = ?per
}

language.id.iso.PL

(?pos == "DT" | ?pos == "PP")
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  ¬rc:inflect = yes
  rc:morph = ?m
  morph = #?m+<+?pos+><+?per+><+?num+>#
  inflect = yes
}
  ]
]

/*for some reason , this word has a "y" at the end..*/
DMorph<=>SMorph PL_patch_polnoc : PL
[
  leftside = [
c:?Xl {
  ¬c:elide = "yes"
  c:slex = "północ"
  c:deprel_gen = comp
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  inflect = yes
}
  ]
]

/*For some reason, the TTS doesn't pronounce some numbers right. Replace numerical values by spelled version.
This should be done in the dico.*/
DMorph<=>SMorph PL_numbers_4_PATCH : PL
[
  leftside = [
?Xl {
  ¬c:elide = "yes"
  slex = "4"
}

language.id.iso.PL
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  morph = "cztery"
}
  ]
]

DMorph<=>SMorph K_attr_gest_fen : K_attr_gestures
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

DMorph<=>SMorph K_attr_gest_fex : K_attr_gestures
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

DMorph<=>SMorph K_attr_gest_fin : K_attr_gestures
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

DMorph<=>SMorph K_attr_gest_att : K_attr_gestures
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

DMorph<=>SMorph K_attr_gest_exp : K_attr_gestures
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

DMorph<=>SMorph K_attr_gest_pro : K_attr_gestures
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

DMorph<=>SMorph K_attr_gest_soc : K_attr_gestures
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

DMorph<=>SMorph K_attr_gest_sty : K_attr_gestures
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

DMorph<=>SMorph K_attr_gest_sa : K_attr_gestures
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

DMorph<=>SMorph K_attr_gest_fen : K_attr_gestures_bubble
[
  leftside = [
c:?Xl{
  FacialEnthusiasm = ?u
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Bubble {
  rc:?Xr {
    rc:<=>?Xl
  }
  FacialEnthusiasm = ?u
}
  ]
]

DMorph<=>SMorph K_attr_gest_fex : K_attr_gestures_bubble
[
  leftside = [
c:?Xl{
  FacialExpression = ?u
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Bubble {
  rc:?Xr {
    rc:<=>?Xl
  }
  FacialExpression = ?u
}
  ]
]

DMorph<=>SMorph K_attr_gest_fin : K_attr_gestures_bubble
[
  leftside = [
c:?Xl{
  FacialIntensity = ?u
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Bubble {
  rc:?Xr {
    rc:<=>?Xl
  }
  FacialIntensity = ?u
}
  ]
]

DMorph<=>SMorph K_attr_gest_att : K_attr_gestures_bubble
[
  leftside = [
c:?Xl{
  hasAttitude = ?u
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Bubble {
  rc:?Xr {
    rc:<=>?Xl
  }
  hasAttitude = ?u
}
  ]
]

DMorph<=>SMorph K_attr_gest_exp : K_attr_gestures_bubble
[
  leftside = [
c:?Xl{
  hasExpressivity = ?u
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Bubble {
  rc:?Xr {
    rc:<=>?Xl
  }
  hasExpressivity = ?u
}
  ]
]

DMorph<=>SMorph K_attr_gest_pro : K_attr_gestures_bubble
[
  leftside = [
c:?Xl{
  hasProximity = ?u
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Bubble {
  rc:?Xr {
    rc:<=>?Xl
  }
  hasProximity = ?u
}
  ]
]

DMorph<=>SMorph K_attr_gest_soc : K_attr_gestures_bubble
[
  leftside = [
c:?Xl{
  hasSocial = ?u
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Bubble {
  rc:?Xr {
    rc:<=>?Xl
  }
  hasSocial = ?u
}
  ]
]

DMorph<=>SMorph K_attr_gest_sty : K_attr_gestures_bubble
[
  leftside = [
c:?Xl{
  hasStyle = ?u
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Bubble {
  rc:?Xr {
    rc:<=>?Xl
  }
  hasStyle = ?u
}
  ]
]

DMorph<=>SMorph K_attr_gest_sa : K_attr_gestures_bubble
[
  leftside = [
c:?Xl{
  speechAct = ?u
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Bubble {
  rc:?Xr {
    rc:<=>?Xl
  }
  speechAct = ?u
}
  ]
]

