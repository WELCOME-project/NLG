/*Words that are not inflected.*/
SMorph<=>Sentence transfer_node_copy_noInflect
[
  leftside = [
?Xl {
  ¬c:inflect= yes
  //¬c:blocked = "YES"
  //¬c:blocked = "subtree"
  ¬c:blocked = ?BLOCK
  morph = ?m
}

¬ ( ( language.id.iso.ES | language.id.iso.IT | language.id.iso.EL | language.id.iso.CA | language.id.iso.PT ) & c:?Xl {c:concatenate-> c:?Zl {}} )

¬ ( language.id.iso.DE  & c:?Y1l {c:concatenate-> c:?Xl {}} )
¬ ( language.id.iso.DE & c:?Xl {c:concatenate-> c:?Y2l {}} )

¬ ( c:?Y3l { ¬c:blocked = "YES" ¬c:blocked = "unique" c:morph = ?mY3
    c:~ c:?Xl { ¬c:blocked = "YES" ¬c:blocked = "unique" c:morph = "'s" } }
  & language.id.iso.EN & morph.?mY3.endswith.s
)

¬ ( ( ( language.id.iso.CA & ?m == "es" ) | ( language.id.iso.IT & (?m == "ci" | ?m == "ne" ) ) ) & c:?Xl { c:~ c:?Y4l { c:morph = ?mY4 } }
 & ( morph.?mY4.startswith.vowel | ( ?Y4l { c: lex = ?Ylex } & lexicon.?Ylex.startswith.vowel ) ) & morph.?m.precedesVowel.?c
)
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  word = ?m
}
  ]
]

/*If there is an entry in the morphologicon.*/
SMorph<=>Sentence transfer_node_morph
[
  leftside = [
?Xl {
  //¬c:blocked = "YES"
  //¬c:blocked = "subtree"
  ¬c:blocked = ?BLOCK
  inflect = yes
  morph = ?m
}

morph.?m.word.?w

¬ ( ( language.id.iso.ES | language.id.iso.DE | language.id.iso.IT | language.id.iso.EL | language.id.iso.CA | language.id.iso.PT ) & c:?Y1l {c:concatenate-> c:?Xl {}} )
¬ ( language.id.iso.DE & c:?Xl {c:concatenate-> c:?Y2l {}} )

// DefDet and IndefDet change before a word that start with a vowel
¬ ( ( language.id.iso.IT | language.id.iso.EN | language.id.iso.CA )& ?Xl.pos == "DT" //& morph.?m.endswith.vowel
     & c:?Xl { c:~ c:?Y3l { c:morph = ?mY } } & ( morph.?mY.startswith.vowel | ( ?Y3l { c: lex = ?Ylex } & lexicon.?Ylex.startswith.vowel )  )
     & morph.?m.precedesVowel.?c
)

¬ ( language.id.iso.EL & c:?Xl { c:~ c:?Y5l { c:morph = ?mY5 } }
 & morph.?mY5.startswith.NotVowelOrPlosive & morph.?m.precedesNotVowelOrPlosive.?c5
)
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  word = ?w
}
  ]
]

/*If there is a rule to produce the inflected form. Can be bypassed if there is a form in morphologicon.*/
SMorph<=>Sentence transfer_node_rule
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*If there is no entry in the morphologicon, and no rules to inflect, but the node needs to be inflected.*/
SMorph<=>Sentence transfer_node_morph_backup
[
  leftside = [
?Xl {
  //¬c:blocked = "YES"
  //¬c:blocked = "subtree"
  ¬c:blocked = ?BLOCK
  inflect = yes
  morph = ?m
  morph_backup = ?mb
}

¬ morph.?m.word.?w

¬ ( c:?Xl { c:rule_suffix = ?rs c:rule_prefix = ?rp } & morph.?rs.?infSuff )

¬ ( ( language.id.iso.ES | language.id.iso.DE | language.id.iso.IT | language.id.iso.EL | language.id.iso.PT ) & c:?Y1l {c:concatenate-> c:?Xl {}} )
¬ ( language.id.iso.DE & c:?Xl {c:concatenate-> c:?Y2l {}} )

¬ ( language.id.iso.EN & c:?Xl { c:pos = "NN" c:number = "PL" } )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  word = ?mb
}
  ]
]

/*?sw & ( ?sw == vowel | ?sw == z | ?sw == sConsonant )*/
SMorph<=>Sentence transfer_node_morph_before_vowel
[
  leftside = [
?Xl {
  //¬c:blocked = "YES"
  //¬c:blocked = "subtree"
  ¬c:blocked = ?BLOCK
  morph = ?m
}

morph.?m.word.?w

( ?Xl.inflect == yes | ( language.id.iso.CA & ?m == "es" ) | ( language.id.iso.IT & ?m == "ci") | ( language.id.iso.IT & ?m == "ne") )

( language.id.iso.IT | language.id.iso.EN | language.id.iso.CA )

( ?Xl.pos == "DT" | ( language.id.iso.CA & ?m == "es" ) | ( language.id.iso.IT & ?m == "ci") | ( language.id.iso.IT & ?m == "ne") )
//morph.?m.endswith.vowel
c:?Xl { c:~ c:?Y3l { c:morph = ?mY } }
( morph.?mY.startswith.vowel | ( ?Y3l { c: lex = ?Ylex } & lexicon.?Ylex.startswith.vowel ) )
morph.?m.precedesVowel.?c
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  word = ?c
}
  ]
]

/*If a word is not in the lexicon or morphologicon.*/
SMorph<=>Sentence EN_transfer_node_morph_plural_N_backup
[
  leftside = [
?Xl {
  //¬c:blocked = "YES"
  //¬c:blocked = "subtree"
  ¬c:blocked = ?BLOCK
  inflect = yes
  morph = ?m
  morph_backup = ?mb
}

¬ morph.?m.word.?w
¬ ( c:?Xl { c:rule_suffix = ?rs c:rule_prefix = ?rp } & morph.?rs.?infSuff )

( language.id.iso.EN & c:?Xl { c:pos = "NN" c:number = "PL" } )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  word = #?mb+s#
}
  ]
]

/*?sw & ( ?sw == vowel | ?sw == z | ?sw == sConsonant )*/
SMorph<=>Sentence EN_transfer_node_morph_genitive_s
[
  leftside = [
c:?Xl {
  //¬c:blocked = "YES"
  //¬c:blocked = "subtree"
  ¬c:blocked = ?BLOCK
  c:morph = ?m
  c:~ ?Yl {
    //¬c:blocked = "YES"
    //¬c:blocked = "subtree"
    ¬c:blocked = ?BLOCK
    morph = "'s"
    
  }
}

language.id.iso.EN

morph.?m.endswith.s
  ]
  mixed = [

  ]
  rightside = [
?Yr {
  <=> ?Yl
  word = "'"
}
  ]
]

SMorph<=>Sentence IT_transfer_node_morph_before_consonant
[
  leftside = [
?Xl {
  //¬c:blocked = "YES"
  //¬c:blocked = "subtree"
 ¬c:blocked = ?BLOCK
  inflect = yes
  morph = ?m
  c:gender = "MASC"
  c:number = "PL"
}

morph.?m.word.?w

language.id.iso.IT

?Xl.pos == "DT"
morph.?m.endswith.vowel

c:?Xl { c:~ c:?Y3l { c:morph = ?mY } }
morph.?mY.startswith.?sw & ( ?sw == z | ?sw == sConsonant )
morph.?m.precedesVowel.?c
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  word = ?c
}
  ]
]

/*?sw & ( ?sw == vowel | ?sw == z | ?sw == sConsonant )*/
SMorph<=>Sentence EL_transfer_node_morph_before_Not_vowelOrPlosive
[
  leftside = [
?Xl {
  //¬c:blocked = "YES"
  //¬c:blocked = "subtree"
  ¬c:blocked = ?BLOCK
  morph = ?m
  c:~ c:?Y3l {
    c:morph = ?mY
  }
}

morph.?m.word.?w

language.id.iso.EL

morph.?mY.startswith.NotVowelOrPlosive
morph.?m.precedesNotVowelOrPlosive.?c
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  word = ?c
}
  ]
]

SMorph<=>Sentence transfer_node_sentence
[
  leftside = [
?Xl {
 c:blocked = "YES"
  sentence = ?m
}
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  word = ?m
}
  ]
]

SMorph<=>Sentence transfer_relation_dependency
[
  leftside = [
c:?Xl {
  ?r-> c:?Yl {}
}

¬ ?r == concatenate
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ?r->  rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

SMorph<=>Sentence transfer_relation_precedence
[
  leftside = [
c:?Xl {
  ~ c:?Yl {}
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

/*Stupid rules, make same mechanism as for commas.*/
SMorph<=>Sentence transfer_relation_precedence_blocked1
[
  leftside = [
c:?Xl {
  ¬c:blocked = ?u1
  ~ c:?Zl {
    blocked = ?u2
    ~ c:?Yl {
      ¬c:blocked = ?u3
    }
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

/*Stupid rules, make same mechanism as for commas.*/
SMorph<=>Sentence transfer_relation_precedence_blocked2
[
  leftside = [
c:?Xl {
  ¬c:blocked = ?u1
  ~ c:?Z1l {
    blocked = ?u2
    ~ c:?Z2l {
      c:blocked = ?u3
      ~ c:?Yl {
        ¬c:blocked = ?u4
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
  ~ rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

/*Stupid rules, make same mechanism as for commas.*/
SMorph<=>Sentence transfer_relation_precedence_blocked3
[
  leftside = [
c:?Xl {
  ¬c:blocked = ?u1
  ~ c:?Z1l {
    blocked = ?u2
    ~ c:?Z2l {
      c:blocked = ?u3
      ~ c:?Z3l {
        c:blocked = ?u4
        ~ c:?Yl {
          ¬c:blocked = ?u5
        }
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
  ~ rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

/*Stupid rules, make same mechanism as for commas.*/
SMorph<=>Sentence transfer_relation_precedence_blocked4
[
  leftside = [
c:?Xl {
  ¬c:blocked = ?u1
  ~ c:?Z1l {
    blocked = ?u2
    ~ c:?Z2l {
      c:blocked = ?u3
      ~ c:?Z3l {
        c:blocked = ?u4
        ~ c:?Z4l {
          c:blocked = ?u5
          ~ c:?Yl {
            ¬c:blocked = ?u6
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
rc:?Xr {
  rc:<=> ?Xl
  ~ rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

/*Stupid rules, make same mechanism as for commas.*/
SMorph<=>Sentence transfer_relation_precedence_blocked5
[
  leftside = [
c:?Xl {
  ¬c:blocked = ?u1
  ~ c:?Z1l {
    blocked = ?u2
    ~ c:?Z2l {
      c:blocked = ?u3
      ~ c:?Z3l {
        c:blocked = ?u4
        ~ c:?Z4l {
          c:blocked = ?u5
          ~ c:?Z5l {
            c:blocked = ?u6
            ~ c:?Yl {
              ¬c:blocked = ?u7
            }
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
rc:?Xr {
  rc:<=> ?Xl
  ~ rc:?Yr {
    rc:<=> ?Yl
  }
}
  ]
]

SMorph<=>Sentence ES_transfer_node_concatenate
[
  leftside = [
?Xl {
  morph = ?m
  concatenate-> ?Yl {
    ~ c:?Zl {}
  }
}

language.id.iso.ES
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  word = #?m+l#
  ~ rc:?Zr {
    rc:<=> ?Zl
  }
}
  ]
]

/*Make just one rule for all cases and handle in morphologicon.*/
SMorph<=>Sentence CA_EL_IT_PT_transfer_node_concatenate
[
  leftside = [
?Xl {
  morph = ?mX
  concatenate-> ?Yl {
    morph = ?mY
    ~ c:?Zl {}
  }
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.IT | language.id.iso.PT )

morph.?mY.concatenate.?mX.?word
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  word = ?word
  ~ rc:?Zr {
    rc:<=> ?Zl
  }
}
  ]
]

SMorph<=>Sentence DE_node_concatenate_2_2morph
[
  leftside = [
?Xl {
  morph = ?m1
  concatenate-> ?Yl {
    morph = ?m2
    ~ c:?Zl {}
  }
}

morph.?m1.word.?w1
morph.?m2.word.?w2

language.id.iso.DE

// there's only one concatenate
¬ c:?Y1l {c:concatenate-> c:?Xl {}}
¬ c:?Yl {c:concatenate-> c:?Y2l {}}
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  word = #?w1+?w2#
  ~ rc:?Zr {
    rc:<=> ?Zl
  }
}
  ]
]

SMorph<=>Sentence DE_node_concatenate_2_1morph_a
[
  leftside = [
?Xl {
  morph = ?m1
  concatenate-> ?Yl {
    morph = ?m2
    ~ c:?Zl {}
  }
}

morph.?m1.word.?w1
¬morph.?m2.word.?w2

language.id.iso.DE

// there's only one concatenate
¬ c:?Y1l {c:concatenate-> c:?Xl {}}
¬ c:?Yl {c:concatenate-> c:?Y2l {}}
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  word = #?w1+?m2#
  ~ rc:?Zr {
    rc:<=> ?Zl
  }
}
  ]
]

SMorph<=>Sentence DE_node_concatenate_2_1morph_b
[
  leftside = [
?Xl {
  morph = ?m1
  concatenate-> ?Yl {
    morph = ?m2
    ~ c:?Zl {}
  }
}

¬morph.?m1.word.?w1
morph.?m2.word.?w2

language.id.iso.DE

// there's only one concatenate
¬ c:?Y1l {c:concatenate-> c:?Xl {}}
¬ c:?Yl {c:concatenate-> c:?Y2l {}}
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  word = #?m1+?w2#
  ~ rc:?Zr {
    rc:<=> ?Zl
  }
}
  ]
]

SMorph<=>Sentence DE_node_concatenate_2_0morph
[
  leftside = [
?Xl {
  morph = ?m1
  concatenate-> ?Yl {
    morph = ?m2
    ~ c:?Zl {}
  }
}

¬morph.?m1.word.?w1
¬morph.?m2.word.?w2

language.id.iso.DE

// there's only one concatenate
¬ c:?Y1l {c:concatenate-> c:?Xl {}}
¬ c:?Yl {c:concatenate-> c:?Y2l {}}
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  word = #?m1+?m2#
  ~ rc:?Zr {
    rc:<=> ?Zl
  }
}
  ]
]

/*3 concatenates happens now with ?X = particle (invariant), ?Y = prep (invariant) and ?K = verb (in morphologicon)*/
SMorph<=>Sentence DE_node_concatenate_3
[
  leftside = [
?Xl {
  morph = ?m1
  concatenate-> ?Yl {
    morph = ?m2
    concatenate-> ?Kl {
      morph = ?m3
      ~ c:?Zl {}
    }
  }
}

¬morph.?m1.word.?w1
¬morph.?m2.word.?w2
morph.?m3.word.?w3

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  word = #?m1+?m2+?w3#
  ~ rc:?Zr {
    rc:<=> ?Zl
  }
}
  ]
]

excluded SMorph<=>Sentence transfer_id
[
  leftside = [
c:?Xl {
  id_gen = ?id
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  id_gen = ?id
}
  ]
]

/*Needed for generation of prosody.*/
SMorph<=>Sentence attr_dsyntRel
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

SMorph<=>Sentence attr_pos
[
  leftside = [
c:?Xl {
  pos = ?pos
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

SMorph<=>Sentence attr_spos
[
  leftside = [
c:?Xl {
  spos = ?pos
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

SMorph<=>Sentence attr_thematicity
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

SMorph<=>Sentence K_attr_gestures
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*Rule for regular inflection of words (verbs, nouns and adjectives)*/
SMorph<=>Sentence transfer_node_rule_prefix_suffix : transfer_node_rule
[
  leftside = [
?Xl {
  //¬c:blocked = "YES"
  //¬c:blocked = "subtree"
  ¬c:blocked = ?BLOCK
  inflect = yes
  morph = ?m
  rule_prefix = ?rp
  rule_suffix = ?rs
}

// There isn't an entry in the morphologicon (irregular inflections)
¬ morph.?m.word.?w
morph.?rs.suffix.?suff

// Implemented for theses languages (still testing and extending to more cases)
( language.id.iso.EN | language.id.iso.ES | language.id.iso.PT | language.id.iso.IT | language.id.iso.CA )
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=> ?Xl
  word = #?rp+?suff#
}
  ]
]

SMorph<=>Sentence K_attr_gest_fen : K_attr_gestures
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

SMorph<=>Sentence K_attr_gest_fex : K_attr_gestures
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

SMorph<=>Sentence K_attr_gest_fin : K_attr_gestures
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

SMorph<=>Sentence K_attr_gest_att : K_attr_gestures
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

SMorph<=>Sentence K_attr_gest_exp : K_attr_gestures
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

SMorph<=>Sentence K_attr_gest_pro : K_attr_gestures
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

SMorph<=>Sentence K_attr_gest_soc : K_attr_gestures
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

SMorph<=>Sentence K_attr_gest_sty : K_attr_gestures
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

SMorph<=>Sentence K_attr_gest_sa : K_attr_gestures
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

