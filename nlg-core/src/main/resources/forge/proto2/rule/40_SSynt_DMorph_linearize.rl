SSynt<=>DMorph transfer_node
[
  leftside = [
?Xl {
  ¬block = "yes"
  ¬c:comma_substitute = "yes"
  slex = ?slex
  spos = ?spos
}

// see node adjunct
//¬c:?Yl { c:adjunct-> c:?Xl {} }

//¬(c:?Gl{c:NMOD-> ?Xl{c:lex = ?l}} & lexicon.?l.genitive)
¬c:?Pl{
  (c:pos = "PRP" | c:pos = "WP$")
  c:SUFFIX-> c:?Xl{}
}

¬ ( language.id.iso.EN & ?slex == "i"
 )

¬ ( ?Xl { c:slex = "Sentence" ¬c:?r-> c:?Yl {} } & ¬c:?Zl {c:?s-> ?Xl {} } )
  ]
  mixed = [

  ]
  rightside = [
?XP {
  <=>?Xl
  bubble = yes
  slex = ?spos
  ?Xr {
    <=>?Xl
    slex = ?slex
  }
}
  ]
]

SSynt<=>DMorph transfer_node_comma_substitute
[
  leftside = [
?Xl {
  slex= ?s
  spos = ?spos
  ¬c:block = "yes"
  //( ¬c:block = "yes" | c:cancel_block = "yes" )
  c:comma_substitute = "yes"
}
  ]
  mixed = [

  ]
  rightside = [
?XP {
  <=>?Xl
  bubble = yes
  slex = ?spos
  ?Xr {
    <=>?Xl
    slex = ","
  }
}
  ]
]

SSynt<=>DMorph EN_transfer_node_1ps
[
  leftside = [
?Xl {
  ¬c:?Nodel {}
  ¬block = "yes"
  slex = "i"
}

¬ ( ?Xl { c:slex = "Sentence" ¬c:?r-> c:?Yl {} } & ¬c:?Zl {c:?s-> ?Xl {} } )

¬c:?Pl{
  c:pos = "PRP"
  c:SUFFIX-> c:?Xl{}
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=>?Xl
  slex = "I"
}
  ]
]

/*Only apply if there only one sentence in the input.*/
SSynt<=>DMorph transfer_node_backup
[
  leftside = [
?Xl {
  c:slex = "Sentence"
  ¬c:?r-> c:?Yl {}
  ¬c:~ c:?X2l {}
  // doesn't contain any node or only contains nodes that are blocked.
  ( ¬c:?Node1l {} | ¬c:?Node2l { ¬c:block = "yes" } )
}

¬c:?Zl {c:?s-> ?Xl {} }
¬c:?X3l {c:~ ?Xl {} }
  ]
  mixed = [

  ]
  rightside = [
?Xr {
  <=>?Xl
  slex = "[...]"
}
  ]
]

SSynt<=>DMorph transfer_node_Text
[
  leftside = [
?Xl {
  slex = "Text"
  c:?node {}
}
  ]
  mixed = [

  ]
  rightside = [
?XP {
  <=>?Xl
  bubble = yes
  slex = "Text"
}
  ]
]

SSynt<=>DMorph add_det_same
[
  leftside = [
c:?Vl{
  c:pos = "VB"
  c:?r-> c:?Sl{
    c:slex = "same"
    ¬c:?s-> c:?Nl{}
  }
}

(?r == SBJ | ?r == OBJ)
  ]
  mixed = [

  ]
  rightside = [
rc:?Sr{
  rc:<=>?Sl
  NMOD-> ?Dl{
    slex = "the"
    pos = "DT"
    added = "yes"
  }
}
  ]
]

excluded SSynt<=>DMorph transfer_node_adjunct
[
  leftside = [
?Xl {
  slex = ?slex
  spos = ?spos
}

c:?Yl { c:adjunct-> c:?Xl {} }
  ]
  mixed = [

  ]
  rightside = [
?XP {
  <=>?Xl
  bubble = yes
  slex = ?spos
  ?Xr {
    <=>?Xl
    slex = #(+?slex+)#
  }
}
  ]
]

SSynt<=>DMorph transfer_node_fallback
[
  leftside = [
?Xl {
  slex = ?slex
  ¬spos = ?spos
  ¬c:?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
?XP {
  <=>?Xl
  bubble = yes
  slex = "UKN"
  ?Xr {
    <=>?Xl
    slex = ?slex
  }
}
  ]
]

SSynt<=>DMorph transfer_sentence
[
  leftside = [
c:?Xl {
  c:slex = "Sentence"
  c:?Root {}
}

//( ¬( c:?node1 { c:?r-> c:?Root {} } ) | c:?node2 { c:Parataxis-> c:?Root {} } )

 ¬( c:?node1 { c:?r-> c:?Root {} } )
  ]
  mixed = [

  ]
  rightside = [
?XP {
  <=>?Xl
  bubble = yes
  slex = "Sentence"
  unique = #randInt()#
  rc:+?BubbleR {
    rc:<=> ?Root
    rc:bubble = yes
    //rc:?NodeR {
      //rc:<=> ?Root
     // ~ ?Punt {
     //   slex = "."
     //   deprel_gen = punc
     // }
    //}
  }
  //?Punt {}
}
  ]
]

/*add one dot for each sentence*/
excluded SMorph<=>Sentence add_dot
[
  leftside = [
c:?Xl {
  c:slex = "Sentence"
  c:?Root {}
}

¬(c:?node {c:?r-> c:?Root {}})
  ]
  mixed = [

  ]
  rightside = [
rc:?RootR {
  rc:<=> ?Root
  ~ ?Punt {
    word = "."
  }
}

rc:?Sentence {
  rc:slex = 
}
  ]
]

/*Transfers precedence between bubbles to root of SSynt trees so we don't need bubbles anymore on RS.*/
SSynt<=>DMorph transfer_rel_precedence
[
  leftside = [
c:?Xl {
  c:?Root1 {}
  ~ c: ?Yl {
    c:?Root2 {}
  }
}

¬(c:?node1 {c:?r-> c:?Root1{}})
¬(c:?node2 {c:?s-> c:?Root2{}})
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Root1
  ¬rc:bubble = yes
  ~ rc:?Yr {
    rc:<=> ?Root2
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph bubble_in
[
  leftside = [
c:?Xl {
  ?r-> c:?Yl {}
}

// See bubble_in_inserted_comma_adjunct
( ¬ ?r == adjunct | ( ( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )
    &  ( ( c:?Xl { c:pos = "IN" c:prepos-> c:?Depl {} } & ?Yl.pos == "NP" ) | ?Yl.type == "quoted" | ?Yl.type == "parenthetical" ) )
)

// In this case we create another sentence bubble.
¬ ?r == Parataxis

// See bubble_in_compar rules
¬ ( ( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR ) & ?r == compar )
¬ ( ( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR ) & c:?Yl { c:compar-> c:?Dep2l {} } )
¬ ( language.id.iso.EN & c:?GovX { ( c:pos = "NN" | c:pos = "JJ" | c:pos = "RB" ) c:?relGX-> c:?Xl {} } & ?r == AMOD_COMP )
¬ ( language.id.iso.EN & c:?Xl { ( c:pos = "NN" | c:pos = "JJ" | c:pos = "RB" ) } & c:?Yl { c:AMOD_COMP-> c:?Dep3l {} } )


¬?r == b

// DE_transfer_bubble_SVP
¬ ( language.id.iso.DE & ?r == SVP )

// the order in EN relative clauses with auxs is not projective
¬ ( language.id.iso.EN & c:?Gov1 { c:NMOD-> c:?Gov2 { c:VC-> c:?Xl {} } } )
¬ ( ( language.id.iso.CA | language.id.iso.ES ) & c:?Gov3 { c:relat-> c:?Gov4 { c:?rS-> c:?Xl {} } } & ( ?rS == modal | ?rS == analyt_perf | ?rS == analyt_pass | ?rS == analyt_progr ) )

// the order in EN wh-interrogatives with preposition stranding is not projective
¬ ( language.id.iso.EN & c:?Verb {c:clause_type = "INT" & c:?r5-> c:?Xl {c:pos = "IN"}} & ( c:?Yl {c:spos = "WP"} | c:?Yl {c:NMOD->c:?WDT {c:pos = "WDT"}}))
  ]
  mixed = [

  ]
  rightside = [
rc:?XP {
  rc:<=> ?Xl
  rc:bubble = yes
  rc:+?YP {
    rc:<=> ?Yl
    ¬rc: inserted = "yes"
    rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph bubble_in_parataxis
[
  leftside = [
c:?Xl {
  Parataxis-> c:?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Sent {
  rc:?XP {
    rc:<=> ?Xl
    rc:bubble = yes
  }
  rc:+?YP {
    rc:<=> ?Yl
    ¬rc: inserted = "yes"
    rc:bubble = yes
  }
}
  ]
]

/*In a comparative construction, the gov goes in the bubble of the dep.*/
SSynt<=>DMorph CA_ES_FR_bubble_in_compar_down
[
  leftside = [
c:?Xl {
  compar-> c:?Yl {}
}

( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR )
  ]
  mixed = [

  ]
  rightside = [
rc:?YP {
  rc:<=> ?Yl
  rc:bubble = yes
  rc:+?XP {
    rc:<=> ?Xl
    ¬rc: inserted = "yes"
    rc:bubble = yes
  }
}
  ]
]

/*In a comparative construction, the gov goes in the bubble of the dep.*/
SSynt<=>DMorph CA_ES_FR_bubble_in_compar_up
[
  leftside = [
c:?Govl {
  ?r-> c:?Xl {
    c:compar-> c:?Yl {}
  }
}

( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR )
  ]
  mixed = [

  ]
  rightside = [
rc:?GovP {
  rc:<=> ?Govl
  rc:bubble = yes
  rc:+?YP {
    rc:<=> ?Yl
    ¬rc: inserted = "yes"
    rc:bubble = yes
  }
}
  ]
]

/*In a comparative construction, the gov goes in the bubble of the dep.*/
SSynt<=>DMorph EN_bubble_in_compar_updown
[
  leftside = [
c:?GovX {
  ( c:pos = "NN" | c:pos = "JJ" | c:pos = "RB" )
  c:?relGX-> c:?Xl {
    AMOD_COMP-> c:?Yl {}
  }
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?GovP {
  rc:<=> ?GovX
  rc:bubble = yes
  rc:+?XP {
    rc:<=> ?Xl
    ¬rc: inserted = "yes"
    rc:bubble = yes
  }
  rc:+?YP {
    rc:<=> ?Yl
    ¬rc: inserted = "yes"
    rc:bubble = yes
  }

}
  ]
]

SSynt<=>DMorph EN_bubble_in_aux_relative
[
  leftside = [
c:?Gov1 {
  c:NMOD-> c:?Gov2 {
    c:VC-> c:?Xl {
      c:?r-> c:?Yl {}
    }
  }
}

¬?r == adjunct
¬?r == b


// the order in EN relative clauses with auxs is not projective
language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?GovP {
  rc:<=> ?Gov2
  rc:bubble = yes
  rc:+?YP {
    rc:<=> ?Yl
    ¬rc: inserted = "yes"
    rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph EN_bubble_wh_interrogatives_prep_stranding
[
  leftside = [
c:?Aux {
  c:*VC-> c:?Verb {
    c:clause_type = "INT"
    c:?s-> c:?Xl {
      c:pos = "IN"
      c:?r-> c:?Yl {}
    }
  }
}

// the order in English interrogative clauses with preposition stranding is not projective
language.id.iso.EN
( c:?Yl {c: spos = "WP"} | c:?Yl {c:NMOD->c:?WDT {c:pos = "WDT"}})
  ]
  mixed = [

  ]
  rightside = [
rc:?AuxP {
  rc:<=> ?Aux
  rc:bubble = yes
  rc:+?YP {
    rc:<=> ?Yl
    ¬rc: inserted = "yes"
    rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph CA_ES_bubble_in_aux_relative
[
  leftside = [
c:?Gov1 {
  c:relat-> c:?Gov2 {
    c:?rS-> c:?Xl {
      c:?r-> c:?Yl {}
    }
  }
}

¬?r == adjunct
¬?r == b

( ?rS == modal | ?rS == analyt_perf | ?rS == analyt_pass | ?rS == analyt_progr )


// the order in SPA relative clauses with auxs is not projective
( language.id.iso.CA | language.id.iso.ES )
  ]
  mixed = [

  ]
  rightside = [
rc:?GovP {
  rc:<=> ?Gov2
  rc:bubble = yes
  rc:+?YP {
    rc:<=> ?Yl
    ¬rc: inserted = "yes"
    rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph bubble_Text
[
  leftside = [
c:?Xl {
  c:slex = "Text"
  c:?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?XP {
  rc:<=> ?Xl
  rc:bubble = yes
  rc:+?YP {
    rc:<=> ?Yl
    rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph bubble_in_inserted_comma_adjunct
[
  leftside = [
c:?Xl {
  adjunct-> c:?Yl {}
}

¬ ( ( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )
    & ( ( c:?Xl { c:pos = "IN" c:prepos-> c:?Depl {} } & ?Yl.pos == "NP" )
 | ?Yl.type == "quoted" | ?Yl.type == "parenthetical" )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?XP {
  rc:<=> ?Xl
  rc:bubble = yes
  ?SYM{
    slex = "SYM"
    bubble = yes
    ?Cr{
      slex = ","
      inserted = "yes"
      ~ rc:?Yr {
        rc:<=> ?Yl
       ¬ rc:bubble = yes
       }
    }
  }
}

?SYM {
  rc:+?YP{
    rc:<=>?Yl
    rc:bubble = yes
  }
}
  ]
]

/*Not a great rule, it's here until we implement a better handling of multiple locations as copulatives (need to check dbpedia)
This will work for DBpedia-like inputs, but obviously it's not a good generic rule at all.
(Sagrada Familia is in Barcelona, Catalonia, Spain)*/
SSynt<=>DMorph replace_coord_by_comma_location
[
  leftside = [
c:?be {
  ( c:spos = "copula" | c:lex = "be_VB_01" | c:meaning = "locative_relation" )
  c:?r-> c:?Loc {
    //c:class = "Location"
    c:*?a-> c:?And {
      c:pos = "CC"
      c:?s-> c:?Xl {
        c:variable_class = ?v
      }
    }
  }
}

( ( ?Loc.class == "Location" & ( ?v == "AdministrativeArrondissement" | ?v == "AdministrativeCounty" | ?v == "Canton" | ?v == "CeremonialCounty"
  | ?v == "City" | ?v == "Country" | ?v == "District" | ?v == "Location" | ?v == "LocationCity" | ?v == "LocationCountry"
  | ?v == "LocationTown" | ?v == "Municipality" | ?v == "Range" | ?v == "Region" | ?v == "State" ) )
  | ?v == "BirthPlace" | ?v == "PlaceOfBirth" | ?v == "DeathPlace" | ?v == "PlaceOfDeath" | ?v == "FoundationPlace" | ?v == "Place" )
  ]
  mixed = [
rc:?LocR { rc:variable_class = ?vL rc:~ rc:?AndR { rc:<=> ?And  rc:~ rc:?Xr { rc:<=> ?Xl rc:variable_class = ?vX } } }

( ( ?Loc.class == "Location" & ( ?vL == "AdministrativeArrondissement" | ?vL == "AdministrativeCounty" | ?vL == "Canton" | ?vL == "CeremonialCounty" | ?vL == "City" | ?vL == "Country" | ?vL == "District"
  | ?vL == "Location" | ?vL == "LocationCity" | ?vL == "LocationCountry" | ?vL == "LocationTown" | ?vL == "Municipality" | ?vL == "Range" | ?vL == "Region" | ?vL == "State" )
  // If the type is the same, we more likely want to maintain the conjunction
  & ¬ ?vL == ?vX )
  | ?vL == "BirthPlace" | ?vL == "PlaceOfBirth" | ?vL == "DeathPlace" | ?vL == "PlaceOfDeath" | ?vL == "FoundationPlace" | ?vL == "Place" )
//( ?vX == "AdministrativeArrondissement" | ?vX == "AdministrativeCounty" | ?vX == "Canton" | ?vX == "CeremonialCounty" | ?vX == "City" | ?vX == "Country" | ?vX == "District"
//     | ?vX == "Location" | ?vX == "LocationCity" | ?vX == "LocationCountry" | ?vX == "LocationTown" | ?vX == "Municipality" | ?vX == "Range" | ?vX == "Region" | ?vX == "State" )
  ]
  rightside = [
rc:?LocR {
  rc:variable_class = ?vL
  rc:~ rc:?AndR {
    rc:<=> ?And
    rc:pos = "CC"
    rc:slex = ?slex
    ¬rc:slex = ","
    slex = ","
    rc:~ rc:?Xr {
      rc:<=> ?Xl
      rc:variable_class = ?vX
    }
  }
}
  ]
]

SSynt<=>DMorph DE_transfer_concatenate_NK
[
  leftside = [
c:?Xl {
  c:pos = "NN"
  c:NK-> c:?Yl {
    c:pos = "NN"
    c:case = "nom"
    ¬c:CD-> c:?Conj {}
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  concatenate-> rc:?Xr {
    rc:<=> ?Xl
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph DE_transfer_concatenate_NK_COORD1
[
  leftside = [
c:?Xl {
  c:pos = "NN"
  c:NK-> c:?Y2l {
    c:pos = "NN"
    c:case = "nom"
    c:CD-> c:?Conj {
      c:CJ-> c:?Yl {
        c:pos = "NN"
        ¬c:CD-> c:?Conj {}
      }
    }
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  concatenate-> rc:?Xr {
    rc:<=> ?Xl
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph DE_transfer_concatenate_SVP
[
  leftside = [
c:?Xl {
  c:slex = "zu"
  c:PMOD-> c:?Yl {
    c:finiteness = "INF"
    c:SVP-> c:?Zl {}
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  concatenate-> rc:?Xr {
    rc:<=> ?Xl
    ¬rc:bubble = yes
    concatenate-> rc:?Yr {
      rc:<=> ?Yl
      ¬rc:bubble = yes
    }
  }
}
  ]
]

SSynt<=>DMorph DE_bubble_in_SVP_out
[
  leftside = [
c:?Bl {
  c:slex = "Sentence"
  c:?Xl {
    ¬c:finiteness = "INF"
    SVP-> c:?Yl {}
  }
}



language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?BP {
  rc:<=>?Bl
  rc:slex = "Sentence"
 rc: ?Punt {
    rc:slex = "."
  }
  rc:+?SVP {
    rc:<=> ?Yl
    rc:bubble = yes
  }
}

rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  ~  rc:?YP {
    rc:<=> ?Yl
    ¬rc:bubble = yes
    ~  rc: ?Punt {}
  }
}
  ]
]

SSynt<=>DMorph DE_bubble_in_SVP_in
[
  leftside = [
c:?Zl {
  c:slex = "zu"
  c:PMOD-> c:?Xl {
    c:finiteness = "INF"
    SVP-> c:?Yl {}
  }
}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?ZBr {
  rc:<=>?Zl
  rc:bubble = yes
  rc:+?SVP {
    rc:<=> ?Yl
    rc:bubble = yes
  }
}

rc:?YP {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ~  rc:?Zl {
    rc:<=> ?Zl
    ¬rc:bubble = yes
    ~  rc: ?Xr {
      rc:<=> ?Xl
    }
  }
}
  ]
]

SSynt<=>DMorph slex_modifications
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*Dunno if the right way to go for storing dependencies in final output*/
SSynt<=>DMorph PATCH_transfer_attr_concatenate
[
  leftside = [
c:?Yl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  rc:concatenate-> rc:?Xr {
    //rc:<=> ?Xl
  }
  concatenate_gov = ?Xr.slex
}
  ]
]

SSynt<=>DMorph transfer_attributes
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*These rules should be organized as a hierarchy if possible, so as to facilitate editing*/
SSynt<=>DMorph order_horizontal
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

SSynt<=>DMorph order_vertical
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*If a node X and its aunt are both linearised after X's governor, X comes before auntie.
Eg: Anders was selected (gov) by NASA (X) in 1963 (auntie, depend on "was")
(WebNLG_eval_2017 sent. 20, english)*/
SSynt<=>DMorph order_diagonal
[
  leftside = [
c:?Xl {
  c:?r1-> c:?Y1l {}
  c:?r2-> c:?Y2l {
    c:?s-> c:?Zl {}
  }
}

// Do not apply when Y2 is a comparative and Z is its associated preposition
¬ ( c:?Y2l { c:lex = ?Y2lex } & c:?Y1l { c:spos = "JJ" } & lexicon.?Y2lex.comparative.yes
    & c:?Zl { c:slex = ?Zslex } & lexicon.?Y2lex.gp.II.prep.?prep & ?prep == ?Zslex)
  ]
  mixed = [

  ]
  rightside = [
rc:?Y2r {
  rc:<=> ?Y2l
  rc:~ rc:?Y1r {
    rc:<=> ?Y1l
  }
  rc:~ rc:?Zr {
    rc:<=> ?Zl
    ~ rc:?Y1r {
      rc:<=> ?Y1l
    }
  }
}
  ]
]

SSynt<=>DMorph sentence_type_punctuations
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

SSynt<=>DMorph agreement
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

SSynt<=>DMorph ellipsis_referringExp
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*To activate if linearization is done statistically.
Deactivate lin order rules.*/
excluded SSynt<=>DMorph attach_trees
[
  leftside = [
?B1l {
  c:?X1l {}
  b-> ?B2l {
    c:?X2l {}
  }
}

¬c:?Gov1 { c:?r1-> c:?X1l {} }
¬c:?Gov2 { c:?r2-> c:?X2l {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?X1r {
  rc:<=> ?X1l
  P-> ?Punc {
    slex = ";"
    pos = ":"
  }
  COORD-> rc:?X2r {
    rc:<=> ?X2l
  }
}
  ]
]

/*Excluded because of MATE bug: the rule applied to nodes that did not satisfy the right side configuration (!?)
I haven't found any impact for this exlusion on MATE Tests (for ES and IT), but maybe this should be doubled checked. */
excluded SSynt<=>DMorph mark_last_element_adjunct
[
  leftside = [
c:?Xl {
  c:adjunct-> c:?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?SYM{
  rc:slex = "SYM"
  rc:bubble = yes
  rc:?Cr{
    rc:slex = ","
    rc:inserted = "yes"
    rc:~?Yr{
      rc:<=>?Yl
      rc:*~ rc:?Zr{
        adjunct = "final_lin_adjunct"
        ¬rc:~?Lr{}
      }
    }
  }
}
  ]
]

/*PATCH because will work only as long as all precedences are inserted in the same cluster.*/
excluded SSynt<=>DMorph PATCH_assign_ID_1
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  ¬rc:bubble = yes
  id_gen = "1"
  rc:~ rc:?Yr {
    ¬rc:bubble = yes
  }
}

// ?Xr is the first node
¬rc:?Zr {rc:~rc:?Xr {}}
  ]
]

/*PATCH because will work only as long as all precedences are inserted in the same cluster.*/
excluded SSynt<=>DMorph PATCH_assign_ID_others
[
  leftside = [
c:?Xl {}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  ¬rc:bubble = yes
  rc:id_gen = ?id
  rc:~ rc:?Yr {
    ¬rc:bubble = yes
    id_gen = #?id+1#
  }
}

// ?Yl is contained (recursive) in ?Bubble1
//((rc:?Bubble1 {rc:*?Nr {}}
// no other node in ?Yl's bubble already points to ?Yl
//  & ¬rc:?Bubble3 {rc:?Nr {} rc:*?Al {rc:~ rc:?Nr {}}}
// no other node in ?Bubble1 (recursive) is between ?Xl and ?Yl;
// precedence relations should be *~?? (grammar is ver long with *)
//   & ¬(rc:?Bubble1 {rc:*?Cl {}} & rc:?Xr {rc:~ rc:?Cl {}} & rc:?Cl {rc:~ rc:?Nr {}}))
// or in a ?Bubble2 that contains (recursive) ?Xl
// | (rc:?Bubble2 {rc:?Nr {} rc:*?Xr {}}
// no other node in ?Bubble2 (recursive) is between ?Xl and ?Yl;
//   & ¬(rc:?Bubble2 {rc:*?Dl {}} & rc:?Xr {rc:~ rc:?Dl {}} & rc:?Dl {rc:~ rc:?Nr {}}))
//)
  ]
]

excluded SSynt<=>DMorph transfer_node_possessive
[
  leftside = [
?Xl {
  slex = ?slex
  spos = ?spos
}

// see node adjunct
//¬c:?Yl { c:adjunct-> c:?Xl {} }

(?Xl{c:lex = ?l} & lexicon.?l.genitive.?g)
  ]
  mixed = [

  ]
  rightside = [
?XP {
  <=>?Xl
  bubble = "yes"
  slex = ?spos
  ?Xr {
    <=>?Xl
    slex = ?g
  }
}
  ]
]

/*Mark the cases in which we don't want to introduce a comma during the next stage.
If a proper noun is after a definite noun, don't put a comma between them.
| c:slex = "city_centre" | c:slex = "riverside"*/
excluded SSynt<=>DMorph mark_n_modif_noComma_NP
[
  leftside = [
c:?Xl {
  c:?r-> c:?Yl {
    c:n_modif = ?n
    c:pos = "NP"
  }
  c:NMOD-> c:?Det {
    c:slex = "the"
  }
}

?Xl.id == ?n
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:~ rc:?Yr {
    rc:<=> ?Yl
    no_comma = "yes"
  }
}
  ]
]

SSynt<=>DMorph mark_n_modif_noComma_PATCH
[
  leftside = [
c:?Xl {
  c:?r-> c:?Yl {
    c:n_modif = ?n
    ( c:slex = "city_centre" | c:slex = "riverside" )
  }
  c:NMOD-> c:?Det {
    c:slex = "the"
  }
}

?Xl.id == ?n
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  no_comma = "yes"
  rc:~ rc:?Xr {
    rc:<=> ?Xl
  }
}
  ]
]

/*If the n_modif subtree is on the left of the head Noun, do not introduce commas.*/
SSynt<=>DMorph mark_n_modif_noComma_WrongSide
[
  leftside = [
c:?Xl {
  c:id = ?idX
  c:?r-> c:?Yl {
    c:n_modif = ?n
  }
}

?idX == ?n
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  no_comma = "yes"
  rc:~ rc:?Xr {
    rc:<=> ?Xl
  }
}
  ]
]

/*Mark the cases in which we don't want to introduce a comma during the next stage.
If a proper noun is after a definite noun, don't put a comma between them.*/
excluded SSynt<=>DMorph mark_n_modif_noComma_NP
[
  leftside = [
c:?Xl {
  c:?r-> c:?Yl {
    c:n_modif = ?n
    c:pos = "NP"
  }
  c:NMOD-> c:?Det {
    c:slex = "the"
  }
}

?Xl.id == ?n
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:~ rc:?Yr {
    rc:<=> ?Yl
    no_comma = "yes"
  }
}
  ]
]

/*Mark the cases in which we don't want to introduce a comma during the next stage.
If a proper noun is after a definite noun, don't put a comma between them.*/
SSynt<=>DMorph mark_n_modif_noComma_percolate_after
[
  leftside = [
c:?Xl {
  c:n_modif = ?n
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:n_modif = ?n
  rc:no_comma = "yes"
  rc:~ rc:?Yr {
    rc:n_modif = ?n
    no_comma = "yes"
  }
}
  ]
]

/*Mark the cases in which we don't want to introduce a comma during the next stage.
If a proper noun is after a definite noun, don't put a comma between them.*/
SSynt<=>DMorph mark_n_modif_noComma_percolate_before
[
  leftside = [
c:?Yl {
  c:n_modif = ?n
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:n_modif = ?n
  no_comma = "yes"
  rc:~ rc:?Yr {
    rc:<=> ?Yl
    rc:n_modif = ?n
    rc:no_comma = "yes"
  }
}
  ]
]

/*if the rules at the previous level bring together two (or more) relative clauses below the same node, add a coord conj to the 2nd relative and forward.*/
SSynt<=>DMorph EN_add_coord_multiple_relatives
[
  leftside = [
c:?Xl {
  ( c:pos = "NN" | c:pos = "NP" )
  c:NMOD-> c:?V1l {
    ( c:pos = "VB" | c:pos = "MD" )
    c:finiteness = "FIN"
    c:?r1-> c:?relPro1 {
      c:slex = ?s1
      c:spos = relative_pronoun
    }
  }
  c:NMOD-> c:?V2l {
    ( c:pos = "VB" | c:pos = "MD" )
    c:finiteness = "FIN"
    c:?r2-> c:?relPro2 {
      c:slex = ?s2
      c:spos = relative_pronoun
    }
  }
}

?r1 == ?r2
?s1 == ?s2
  ]
  mixed = [

  ]
  rightside = [
rc:?V1r {
  rc:<=> ?V1l
  rc:~ rc:?V2r {
    rc:<=> ?V2l
  }
}

rc:?relPro2r {
  rc:<=> ?relPro2
  slex = "and"
  pos = "CC"
  spos = coord_conjunction
  rc:~ rc:?V2r {
    rc:<=> ?V2l
  }
}
  ]
]

SSynt<=>DMorph transform_slex : slex_modifications
[
  leftside = [
c:?Xl {
  c:slex = ?slex
  c:spos = ?spos
}

(c:?Gl{c:NMOD-> c:?Xl{c:lex = ?l}} & lexicon.?l.genitive.?g)
  ]
  mixed = [

  ]
  rightside = [
rc:?XP {
  rc:<=>?Xl
  rc:bubble = yes
  rc:slex = ?spos
  rc:?Xr {
    rc:<=>?Xl
    rc:slex = ?slex
    slex = ?g
  }
}
  ]
]

SSynt<=>DMorph replace_slex_possessives : slex_modifications
[
  leftside = [
c:?Pl{
  (c:slex = "us" | c:slex = "we")
  c:SUFFIX-> c:?Sl{}
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Pr{
  rc:<=>?Pl
  slex = "our"
}
  ]
]

SSynt<=>DMorph months : slex_modifications
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

SSynt<=>DMorph week_days : slex_modifications
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

SSynt<=>DMorph K_attr_gestures : transfer_attributes
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

SSynt<=>DMorph attr_added_prep : transfer_attributes
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

SSynt<=>DMorph attr_case : transfer_attributes
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
  ¬rc:case=?g
  case=?n
}
  ]
]

excluded SSynt<=>DMorph attr_class : transfer_attributes
[
  leftside = [
c:?Xl {
  class = "Location"
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:class=?g
  class = "Location"
}
  ]
]

SSynt<=>DMorph attr_clause_type : transfer_attributes
[
  leftside = [
c:?Xl {
  clause_type = ?fin
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  clause_type = ?fin
}
  ]
]

/*Needed for generation of prosody.*/
SSynt<=>DMorph attr_dsyntRel : transfer_attributes
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

SSynt<=>DMorph attr_elide : transfer_attributes
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

SSynt<=>DMorph attr_finiteness : transfer_attributes
[
  leftside = [
c:?Xl {
  finiteness = ?fin
}

¬ ( ?fin == "GER" & c:?Pl{
     c:slex = "to" c:PMOD-> c:?Xl {} } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  finiteness = ?fin
}
  ]
]

SSynt<=>DMorph attr_finiteness_default_INF : transfer_attributes
[
  leftside = [
c:?Pl{
  c:slex = "to"
  c:PMOD-> c:?Vl{c:pos = "VB" c:finiteness = ?f}
}

?f == "GER"
  ]
  mixed = [

  ]
  rightside = [
rc:?Vr{
  rc:<=>?Vl
  ¬rc:bubble = yes
  finiteness = "INF"
}
  ]
]

SSynt<=>DMorph attr_finiteness_default_GER : transfer_attributes
[
  leftside = [
c:?Pl{
  ¬c:slex = "to"
  c:?r-> c:?Vl{c:pos = "VB" ¬c:finiteness = ?f}
}

( ?r == PMOD | ?r == SUB )
  ]
  mixed = [

  ]
  rightside = [
rc:?Vr{
  rc:<=>?Vl
  finiteness = "GER"
}
  ]
]

SSynt<=>DMorph attr_gender : transfer_attributes
[
  leftside = [
c:?Xl {
  gender = ?fin
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  gender = ?fin
}
  ]
]

SSynt<=>DMorph attr_id : transfer_attributes
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
  ¬rc:bubble = yes
  id = ?lex
}
  ]
]

SSynt<=>DMorph attr_id0 : transfer_attributes
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
  ¬rc:bubble = yes
  id0 = ?lex
}
  ]
]

SSynt<=>DMorph attr_invariant_lexicon : transfer_attributes
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  ¬c:pronominalized = yes
}

lexicon.?lex.invariant.yes
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  invariant = yes
}
  ]
]

SSynt<=>DMorph attr_invariant_NE : transfer_attributes
[
  leftside = [
c:?Xl {
  (c:NE = "YES" | c:spos = proper_noun)
  ¬c:pronominalized = yes
}

¬ language.syntax.case_system.yes
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  invariant = yes
}
  ]
]

/*Don't transfer attribute if the dependent is BEFORE its governor (in this case, we can't introduce commas).
The n_modif attribute can be quite deep in the tree, and far from the head noun; need a *~ operator on the RS.
Actually won't work, since not all elements of the n_modif subtree have a precedence path to the head noun (e.g. relative pronoun).
I handle this with a marker rule, that is, adding a feature on the RS and block the introduction during the next transduction.*/
SSynt<=>DMorph transfer_n_modif : transfer_attributes
[
  leftside = [
//c:?Gov {
//  c:id = ?idG
//  c:*?r->

c:?Xl {
    n_modif = ?idX
  }
//}
//?idG == ?idX
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  //¬rc:pos = "NP"
  n_modif = ?idX
}

//Only apply if Xr is AFTER its governor
// !!! We need this condition for the pos=NP above !
//rc:?GovR { rc:<=> ?Gov rc:*~ rc:?Xr {} }
  ]
]

SSynt<=>DMorph attr_lex : transfer_attributes
[
  leftside = [
c:?Xl {
  c:lex = ?fin
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  lex = ?fin
}
  ]
]

SSynt<=>DMorph attr_mood : transfer_attributes
[
  leftside = [
c:?Xl {
  mood = ?fin
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  mood = ?fin
}
  ]
]

SSynt<=>DMorph attr_mood_default : transfer_attributes
[
  leftside = [
c:?Xl {
  c:finiteness = "FIN"
  ¬c:mood = ?fin
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  mood = "IND"
}
  ]
]

SSynt<=>DMorph attr_number : transfer_attributes
[
  leftside = [
c:?Xl {
  number = ?fin
}

// see PT_agree_noun_nenhum
//¬ ( c:?Xl { c:pos = "NN" c:?r-> c:?Yl { ( c:slex = "nenhum" ) } }
//    & language.id.iso.PT & ( ?r == modif | ?r == modif_descr ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  number = ?fin
}
  ]
]

SSynt<=>DMorph attr_parenth : transfer_attributes
[
  leftside = [
c:?Xl {
  parenth = ?fin
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  parenth = ?fin
}
  ]
]

SSynt<=>DMorph attr_person : transfer_attributes
[
  leftside = [
c:?Xl {
  ( c:pronominalized = yes | c:relativized = yes )
  person = ?fin
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  person = ?fin
}
  ]
]

SSynt<=>DMorph attr_pos : transfer_attributes
[
  leftside = [
c:?Xl {
// BUG: gives overlap with transfer_node!!
  c:pos = ?fin
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  pos = ?fin
}
  ]
]

SSynt<=>DMorph attr_pronominalized : transfer_attributes
[
  leftside = [
c:?Xl {
  pronominalized = ?fin
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  pronominalized = ?fin
}
  ]
]

SSynt<=>DMorph attr_tense : transfer_attributes
[
  leftside = [
c:?Xl {
  tense = ?fin
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  tense = ?fin
}
  ]
]

SSynt<=>DMorph attr_thematicity : transfer_attributes
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

SSynt<=>DMorph attr_spos : transfer_attributes
[
  leftside = [
c:?Xl {
  c:spos = ?fin
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  spos = ?fin
}
  ]
]

SSynt<=>DMorph attr_tc : transfer_attributes
[
  leftside = [
c:?Xl {
  c:tem_constituency = ?fin
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
  ¬rc:bubble = yes
  tem_constituency = ?fin
}
  ]
]

excluded SSynt<=>DMorph attr_tc_default : transfer_attributes
[
  leftside = [
c:?Xl {
  ¬c:tem_constituency = ?fin
}

language.syntax.verbform.synthetic
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  tem_constituency = ?fin
}
  ]
]

SSynt<=>DMorph variable_class : transfer_attributes
[
  leftside = [
c:?Xl {
  variable_class = ?fin
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  variable_class = ?fin
}
  ]
]

SSynt<=>DMorph attr_voice : transfer_attributes
[
  leftside = [
c:?Xl {
  c:voice = ?fin
}


¬ ( c:?Xl { c: lex = ?lex } & lexicon.?lex.voice.?v )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  voice = ?fin
}
  ]
]

/*In Greek, some verbs are bound to an active or passive ending. We use "voice" to carry this info, not sure it's the most unambiguous way.*/
SSynt<=>DMorph attr_voice_lexicon : transfer_attributes
[
  leftside = [
c:?Xl {
  c:lex = ?lex
}

lexicon.?lex.voice.?v
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  voice = ?v
}
  ]
]

/*Dunno if the right way to go for storing dependencies in final output*/
SSynt<=>DMorph PATCH_transfer_attr_dependency : transfer_attributes
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
  ¬rc:bubble = yes
  deprel_gen = ?r
  gov_gen = ?Xl.slex
}
  ]
]

/*Parataxis goes after any other relation.*/
SSynt<=>DMorph order_H_Parataxis : order_horizontal
[
  leftside = [
c:?Xl {
  c:Parataxis-> c:?Yl {
}
  c:?r-> c:?Zl {
}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Yr {rc:<=> ?Yl}
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bubble = yes
  }
}
  ]
]

/*Missing rules if both dependents are restrictives.*/
SSynt<=>DMorph order_H_restrictive_siblingToTheRight : order_horizontal
[
  leftside = [
c:?Xl {
  c:?s-> c:?Yl {
    c:straight_weight = ?s1
  }
  c:?r-> c:?Zl {
    c:straight_weight = ?s2
  }
}

// If a RS node is a restrictive, it must be before all other deps on the right of the governor
( c:?Zl { c:lex = ?lZo } & ( lexicon.?lZo.anteposed.restrictive.?yes1 | lexicon.?lZo.postposed.restrictive.?yes2 ) )

// aux_refl is even closer to the verb
¬ ?s == aux_refl
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:~ rc:?Yr {
    rc:<=> ?Yl
  }
}

rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Yr {rc:<=> ?Yl}
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bubble = yes
  }
}
  ]
]

/*Missing rules if both dependents are restrictives.*/
SSynt<=>DMorph order_H_restrictive_siblingToTheLeft : order_horizontal
[
  leftside = [
c:?Xl {
  c:?s-> c:?Yl {
    c:straight_weight = ?s1
  }
  c:?r-> c:?Zl {
    c:straight_weight = ?s2
  }
}

// If a RS node is a restrictive, it must be after all other deps on the left of the governor
( c:?Zl { c:lex = ?lZo } & ( lexicon.?lZo.anteposed.restrictive.?yes1 | lexicon.?lZo.postposed.restrictive.?yes2 ) )

// aux_refl is even closer to the verb
¬ ?s == aux_refl
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  rc:~ rc:?Xr {
    rc:<=> ?Xl
  }
}

rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*adv goes by default at the end of the sentence.

PATCH NOT: restrictives such as NOT should be marked in a lexicon*/
SSynt<=>DMorph order_H_same_dep_diff_weight : order_horizontal
[
  leftside = [
c:?Xl {
  c:?s-> c:?Yl {
    c:straight_weight = ?s1
  }
  c:?r-> c:?Zl {
    c:straight_weight = ?s2
  }
}

?s == ?r

// put the smallest dependents first
?s1 > ?s2

//¬(?r == NMOD & ?Zl.pos == "IN" & ¬?Yl.pos == "IN") 	//prepositions that modify a noun are always posterior

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Zl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Yl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )

¬ ( language.id.iso.EN & ( ?r == NMOD & ?Zl.dsyntRel == III & ?Yl.dsyntRel == II ) )
¬ ( language.id.iso.EN & ( ?r == NMOD & ?Zl.case == "GEN" ) )
¬ ( language.id.iso.EN & ( ?r == NMOD & ?Yl.case == "GEN" ) )

// If ?yl and ?Zl are two sibling adjectives, the adjective that has an adverb goes first (191119_CONNEXIONs str. 27).
¬ ( c:?Yl { c:spos = "JJ" c:?r3-> c:?Adv3l { c:spos = "RB" } } & c:?Zl { c:spos = "JJ" } )

// Comparatives go first although their weight is higher
¬ ( c:?Yl { c:lex = ?Ylex } & c:?Zl { c:spos = "JJ" } & lexicon.?Ylex.comparative.yes )
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Yr {rc:<=> ?Yl}
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bubble = yes
  }
}
  ]
]

/*adv goes by default at the end of the sentence.

PATCH NOT: restrictives such as NOT should be marked in a lexicon*/
SSynt<=>DMorph order_H_same_dep_diff_weight_JJ_RB : order_horizontal
[
  leftside = [
c:?Xl {
  c:?s-> c:?Yl {
    c:straight_weight = ?s1
  }
  c:?r-> c:?Zl {
    c:straight_weight = ?s2
  }
}

?s == ?r

// put the smallest dependents first
?s1 > ?s2

//¬(?r == NMOD & ?Zl.pos == "IN" & ¬?Yl.pos == "IN") 	//prepositions that modify a noun are always posterior

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Zl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Yl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )

¬ ( language.id.iso.EN & ( ?r == NMOD & ?Zl.dsyntRel == III & ?Yl.dsyntRel == II ) )

// If ?Yl and ?Zl are two sibling adjectives, the adjective that has an adverb goes first (191119_CONNEXIONs str. 27).
c:?Yl { c:spos = "JJ" c:?r3-> c:?Adv3l { c:spos = "RB" } }
c:?Zl { c:spos = "JJ" }
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {
    rc:<=> ?Zl
  }
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*adv goes by default at the end of the sentence.

PATCH NOT: restrictives such as NOT should be marked in a lexicon*/
SSynt<=>DMorph order_H_same_dep_diff_weight_JJ_comparative : order_horizontal
[
  leftside = [
c:?Xl {
  c:?s-> c:?Yl {
    c:straight_weight = ?s1
  }
  c:?r-> c:?Zl {
    c:straight_weight = ?s2
  }
}

?s == ?r

// put the smallest dependents first
?s1 > ?s2

//¬(?r == NMOD & ?Zl.pos == "IN" & ¬?Yl.pos == "IN") 	//prepositions that modify a noun are always posterior

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Zl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Yl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )

¬ ( language.id.iso.EN & ( ?r == NMOD & ?Zl.dsyntRel == III & ?Yl.dsyntRel == II ) )

// Comparatives go first although their weight is higher
( c:?Yl { c:lex = ?Ylex } & c:?Zl { c:spos = "JJ" } & lexicon.?Ylex.comparative.yes )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {
    rc:<=> ?Zl
  }
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

excluded SSynt<=>DMorph order_H_same_dep_nmod_prep : order_horizontal
[
  leftside = [
c:?Xl {
  c:?s-> c:?Yl {
    c:straight_weight = ?s1
  }
  c:?r-> c:?Zl {
    c:straight_weight = ?s2
  }
}

?s == ?r

// put the smallest dependents first (but the rule also applies in cases in which both dependents have the same weigth)
(?s1 > ?s2 | ?s1 == ?s2)

//prepositions that modify a noun are always posterior-> 100820: I doubt this is true for horizontal ordering
(?r == NMOD & ?Zl.pos == "IN" & (?Yl.pos == "VB" | ?Yl.pos == "NN"))
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*If there is one dependent that is anteposed, that always goes first*/
SSynt<=>DMorph order_H_same_dep_same_weight_antep_i : order_horizontal
[
  leftside = [
c:?Xl {
  c:?r-> c:?Yl {
    c:straight_weight = ?s1
    //¬c:slex = "the"
    ¬c:pos = "DT"
  }
  c:?s-> c:?Zl {
    c:straight_weight = ?s2
  }
}

?s == ?r
?s1 == ?s2

// put the anteposed first
(c:?Zl{c:lex = ?l} & lexicon_MS_EN.?l.anteposed)
(¬c:?Yl{c:lex = ?m} | (c:?Yl{c:lex = ?m} & ¬lexicon_MS_EN.?m.anteposed))

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// Deactivated becaus gives exception
// condition for first  RS node
//¬( c:?Zl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
//¬( c:?Yl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Yr {rc:<=> ?Yl}
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bubble = yes
  }
}
  ]
]

/*If there is one dependent that is anteposed, that always goes first*/
SSynt<=>DMorph order_H_same_dep_same_weight_antep_ii : order_horizontal
[
  leftside = [
c:?Xl {
  c:?r-> c:?Yl {
    c:straight_weight = ?s1
    //c:slex = "the"
    c:pos = "DT"
  }
  c:?s-> c:?Zl {
    c:straight_weight = ?s2
  }
}

?s == ?r
?s1 == ?s2

// put the anteposed first
(c:?Zl{c:lex = ?l} & lexicon_MS_EN.?l.anteposed)
(¬c:?Yl{c:lex = ?m} | (c:?Yl{c:lex = ?m} & ¬lexicon_MS_EN.?m.anteposed))

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// Deactivated becaus gives exception
// condition for first  RS node
//¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
//¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*If a default order is specified for a dependency in the lexicon. For now, this rule is lower in hierarchy than the "different weigth" rules. May want to change that.*/
SSynt<=>DMorph order_H_same_dep_same_weight_no_antep_depLexicon : order_horizontal
[
  leftside = [
c:?Xl {
  c:?r-> c:?Yl {
    c:straight_weight = ?s1
    //c:lex = ?m
    c:pos = ?posY
  }
  c:?s-> c:?Zl {
    c:straight_weight = ?s2
    //c:lex = ?l
   c:pos = ?posZ
  }
}

?s == ?r
?s1 == ?s2

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Zl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Yl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )

// an order is not specified in the description of the dependency
( lexicon.test_map.?r.?posY.default.orderH.?s.?posZ.PRE | lexicon.test_map.?s.?posZ.default.orderH.?r.?posY.POST )

¬( ?Zl.lex == ?l & ((language.id.iso.EN & lexicon_MS_EN.?l.anteposed) | (language.id.iso.DE & lexicon.?l.anteposed)))
¬( ?Yl.lex == ?m & ((language.id.iso.EN & lexicon_MS_EN.?m.anteposed) | (language.id.iso.DE & lexicon.?m.anteposed)))
// see PL_order_H_2adjunct_same_weight
¬( language.id.iso.PL & ( ( ?s2 == "1.0" & ?Yl.pos == "NN" ) | ( ?s2 > "1.0" & ¬?Yl.pos == "NN" ) ) )
¬( language.id.iso.PL & ( ( ?s1 == "1.0" & ?Zl.pos == "NN" ) | ( ?s1 > "1.0" & ¬?Zl.pos == "NN" ) ) )

¬ ( language.id.iso.EN & ( ?r == NMOD & ( ?Yl.pos == "PP" | ?Zl.pos == "PP" | ?Yl.spos == relative_pronoun ) ) )
¬ ( language.id.iso.EN & ( ?r == NMOD & ?Zl.dsyntRel == III & ?Yl.dsyntRel == II ) )
¬ ( language.id.iso.EN & ( ?r == NMOD & ?Zl.case == "GEN" ) )
¬ ( language.id.iso.EN & ( ?r == NMOD & ?Yl.case == "GEN" ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Yr {rc:<=> ?Yl}
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bubble = yes
  }
}
  ]
]

/*adv goes by default at the end of the sentence.

PATCH NOT: restrictives such as NOT should be marked in a lexicon

If there is no dependent that is anteposed, the id defines the final order*/
SSynt<=>DMorph order_H_same_dep_same_weight_no_antep_id0 : order_horizontal
[
  leftside = [
c:?Xl {
  c:?r-> c:?Yl {
    c:straight_weight = ?s1
    //c:lex = ?m
    c:id0 = ?id01
  }
  c:?s-> c:?Zl {
    c:straight_weight = ?s2
    //c:lex = ?l
   c:id0 = ?id02
  }
}

?s == ?r
?s1 == ?s2

// put the smallest dependents first
?id01 > ?id02

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Zl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Yl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )

// an order is not specified in the description of the dependency
¬ ( c:?Yl { c:pos = ?posY } & c:?Zl { c:pos = ?posZ }
    & ( lexicon.test_map.?r.?posY.default.orderH.?s.?posZ | lexicon.test_map.?s.?posZ.default.orderH.?r.?posY )
)

¬( ?Zl.lex == ?l & ((language.id.iso.EN & lexicon_MS_EN.?l.anteposed) | (language.id.iso.DE & lexicon.?l.anteposed)))
¬( ?Yl.lex == ?m & ((language.id.iso.EN & lexicon_MS_EN.?m.anteposed) | (language.id.iso.DE & lexicon.?m.anteposed)))
// see PL_order_H_2adjunct_same_weight
¬( language.id.iso.PL & ( ( ?s2 == "1.0" & ?Yl.pos == "NN" ) | ( ?s2 > "1.0" & ¬?Yl.pos == "NN" ) ) )
¬( language.id.iso.PL & ( ( ?s1 == "1.0" & ?Zl.pos == "NN" ) | ( ?s1 > "1.0" & ¬?Zl.pos == "NN" ) ) )

¬ ( language.id.iso.EN & ( ?r == NMOD & ( ?Yl.pos == "PP" | ?Zl.pos == "PP" | ?Yl.spos == relative_pronoun ) ) )
¬ ( language.id.iso.EN & ( ?r == NMOD & ?Zl.dsyntRel == III & ?Yl.dsyntRel == II ) )
¬ ( ( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )
      & ( ?r == obl_compl & ?Zl.dsyntRel == III & ?Yl.dsyntRel == II ) )
¬ ( language.id.iso.EN & ( ?r == NMOD & ?Zl.case == "GEN" ) )
¬ ( language.id.iso.EN & ( ?r == NMOD & ?Yl.case == "GEN" ) )

¬?Zl.pos == "NP"  //to avoid cycles (e.g.conllS7, planSPAtxt1)
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Yr {rc:<=> ?Yl}
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bubble = yes
  }
}
  ]
]

/*adv goes by default at the end of the sentence.

PATCH NOT: restrictives such as NOT should be marked in a lexicon

If there is no dependent that is anteposed, the id defines the final order*/
SSynt<=>DMorph order_H_same_dep_same_weight_no_antep_id : order_horizontal
[
  leftside = [
c:?Xl {
  c:?r-> c:?Yl {
    c:straight_weight = ?s1
    //c:lex = ?m
    c:id = ?id01
  }
  c:?s-> c:?Zl {
    c:straight_weight = ?s2
    //c:lex = ?l
    c:id = ?id02
  }
}

?s == ?r
?s1 == ?s2

// put the smallest dependents first
?id01 > ?id02

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Zl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Yl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )

// an order is not specified in the description of the dependency
¬ ( c:?Yl { c:pos = ?posY } & c:?Zl { c:pos = ?posZ }
    & ( lexicon.test_map.?r.?posY.default.orderH.?s.?posZ | lexicon.test_map.?s.?posZ.default.orderH.?r.?posY )
)

//¬( ?Zl.lex == ?l & ((language.id.iso.EN & lexicon_MS_EN.?l.anteposed) | (language.id.iso.DE & lexicon.?l.anteposed)))
//¬( ?Yl.lex == ?m & ((language.id.iso.EN & lexicon_MS_EN.?m.anteposed) | (language.id.iso.DE & lexicon.?m.anteposed)))
// see PL_order_H_2adjunct_same_weight
¬ ( language.id.iso.PL & ( ( ?s2 == "1.0" & ?Yl.pos == "NN" ) | ( ?s2 > "1.0" & ¬?Yl.pos == "NN" ) ) )
¬ ( language.id.iso.PL & ( ( ?s1 == "1.0" & ?Zl.pos == "NN" ) | ( ?s1 > "1.0" & ¬?Zl.pos == "NN" ) ) )

¬ ( language.id.iso.EN & ( ?r == NMOD & ( ?Yl.pos == "PP" | ?Zl.pos == "PP" | ?Yl.spos == relative_pronoun ) ) )
¬ ( language.id.iso.EN & ( ?r == NMOD & ?Zl.dsyntRel == III & ?Yl.dsyntRel == II ) )
¬ ( ( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )
      & ( ?r == obl_compl & ?Zl.dsyntRel == III & ?Yl.dsyntRel == II ) )
¬ ( language.id.iso.EN & ( ?r == NMOD & ?Zl.case == "GEN" ) )
¬ ( language.id.iso.EN & ( ?r == NMOD & ?Yl.case == "GEN" ) )

//¬lexicon_MS_EN.?l.anteposed
//¬lexicon_MS_EN.?m.anteposed

( ¬c:?Yl { id0 = ?a } | ¬c:?Zl { id0 = ?b } )
//to avoid cycles (e.g.conllS7, planSPAtxt1)
//¬ ( ?Zl.pos == "NP" & ¬language.id.iso.DE )
//when a preposition and some other element are NMOD, this rules doesn't apply.
¬ ( ?r == NMOD & ?Yl.pos == "IN" & ¬?Zl.pos == "IN" )
¬ ( ?r == NMOD & ?Zl.pos == "IN" & ¬?Yl.pos == "IN" )
//to avoid wrong linearization between adjectives and articles
¬ (c:?Yl {c:pos = "DT"} & ¬ ( c:?Zl { c:pos = "DT" } | c:?Zl { c:pos = "PDT" } ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Yr {rc:<=> ?Yl}
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bubble = yes
  }
}
  ]
]

/*If there is one dependent that is anteposed, that always goes first
Disactivated rule, not sure it's very good. May overlap with no_antep rules.*/
excluded SSynt<=>DMorph order_H_same_dep_same_weight_inserted : order_horizontal
[
  leftside = [
c:?Xl {
  c:lex = ?a
  c:?r-> c:?Zl {
    c:straight_weight = ?s1
    c:slex = ?m
    ¬c:lex = ?n
  }
  c:?s-> c:?Yl {
    c:straight_weight = ?s2
    c:lex = ?l
  }
}

?s == ?r
?s1 == ?s2

// put the anteposed first
¬lexicon_MS_EN.?l.anteposed
(lexicon_MS_EN.?e.lemma.?m & lexicon_MS_EN.?e.anteposed		//if the inserted element is a determiner
 | lexicon_MS_EN.?a.gp.?b.prep.?m)	//if the inserted element is a governed preposition
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Yr {rc:<=> ?Yl}
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph DE_order_H : order_horizontal
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

SSynt<=>DMorph EN_order_H : order_horizontal
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

SSynt<=>DMorph CA_EL_ES_FR_IT_PT_order_H : order_horizontal
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

SSynt<=>DMorph PL_order_H : order_horizontal
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

SSynt<=>DMorph order_V_POST_pos : order_vertical
[
  leftside = [
c:?Gov {
  c:?r-> c:?Dep {
    c:pos = ?pos
  }
}

lexicon.test_map.?r.?pos.default.orderV.lin.POST


¬ ( c:?Dep { c:lex = ?lex } & lexicon.?lex.anteposed )

// embedded verbs are final in German
¬ ( language.id.iso.DE & c:?N1l {c:?r1-> c:?Gov {c:pos = "VB" } } )
  ]
  mixed = [

  ]
  rightside = [
rc:?GovR {
  rc:<=> ?Gov
  ¬rc:bubble = yes
  ~ rc:?DepR {
    rc:<=> ?Dep
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph order_V_POST_default : order_vertical
[
  leftside = [
c:?Gov {
  c:?r-> c:?Dep {
    c:pos = ?pos
  }
}

¬lexicon.test_map.?r.?pos.default.orderV.lin

( lexicon.test_map.?r.default.orderV.lin.POST
  | ( language.id.iso.EN & ?r == SBJ & c:?Gov { c:slex = "be" c:type = "support_verb_noIN" }
      & ¬ (?Dep.class == "Person" | ?Dep.class == "Location" | ?Dep.pos == "PP" | ?Dep.pos == "WP" )
      & ¬ ( c:?Gov { c:PRD-> c:?Prdl { ( c:slex = "part" | c:pos = "JJ" | c:pos = "IN" | c:NMOD-> c:?Det36 { c:slex = "a" } ) } } )
    )
  | ( ?r == SBJ & c:?Gov { c:PRD-> c:?NG6 { ( c:spos = "NN" | c:spos = "NP" ) c:?s6-> c:?Prep6 { c:pos = "IN" c:?t6-> c:?Dep6l { c:spos = relative_pronoun } } } } )
  | ( ?r == SBJ & c:?Gov { c:PRD-> c:?NG7 { ( c:spos = "NN" | c:spos = "NP" ) c:?t7-> c:?Dep7l { c:spos = relative_pronoun } } } )
  | ( ?r == subj & c:?Gov { c:copul-> c:?NG28 { ( c:spos = "NN" | c:spos = "NP" ) c:?s28-> c:?Prep28 { c:pos = "IN" c:?t28-> c:?Dep28l { c:spos = "relative_pronoun" } } } } )
  | ( ?r == subj & c:?Gov { c:copul-> c:?NG29 { ( c:spos = "NN" | c:spos = "NP" ) c:?t29-> c:?Dep29l { c:spos = "relative_pronoun" } } } )
  | ( ?r == subj & c:?Gov { c:copul-> c:?NG31 { c:spos = "relative_pronoun" } } )
  | ( ?r == subj & c:?Gov { c:obl_obj-> c:?Prep30 { c:pos = "IN" c:?t30-> c:?Dep30l { c:spos = "relative_pronoun" } } } )
  | ( ( language.id.iso.ES | language.id.iso.CA ) &  ?r == subj & c:?Gov { c:aux_refl-> c:?AuxRefl33 {} } & ¬ ?Gov.has3rdArg == "yes" )
  | ( ( language.id.iso.ES | language.id.iso.CA ) &  ?r == aux_refl & c:?Gov { ( c:finiteness = "GER" | c:finiteness = "INF" | c:finiteness = "PART" ) } & ¬ ?Gov.has3rdArg == "yes" )
)
¬ ( language.id.iso.EN & ?r == ADV & ?Dep.straight_weight == "1.0" & ¬(?Gov.pos == "IN" | ?Gov.pos == "_"))
¬ ( ( language.id.iso.ES | language.id.iso.CA ) & ?r == adv & ?Dep.straight_weight == "1.0" & ¬(?Gov.pos == "IN" | ?Gov.pos == "_") & ¬?Dep.meaning == "locative_relation" & ¬?Dep.meaning == "point_time" )
¬ ( language.id.iso.EN & ?r == NMOD & ?Gov.slex == "time" & ?Gov.meaning == "frequency" )
¬ ( language.id.iso.EN & ?r == PRD & c:?Gov { c:slex = "be" c:type = "support_verb_noIN"
        ¬c:SBJ-> c:?Subj3 { ( c:class = "Person" | c:class = "Location" | c:pos = "PP" | c:pos = "WP" ) } }
      & ¬c:?Aux { c:VC-> c:?Gov {} }
      & ¬ ( ?Dep.slex == "part" | ?Dep.pos == "JJ" | ?Dep.pos == "IN" | c:?Dep { c:NMOD-> c:?Det35 { c:slex = "a" } } ) )
// deps with relpros go before the governing verb
( ¬ ( language.id.iso.EN & ( ?Dep.spos == relative_pronoun
    | c:?Dep { ( c:spos = "NN" | c:spos = "NP" ) c:?s5-> c:?Dep5l { c:spos = relative_pronoun } }
    | c:?Dep { ( c:spos = "NN" | c:spos = "NP" ) c:?s9-> c:?Prep9 { c:pos = "IN" c:?t9-> c:?Dep9l { c:spos = relative_pronoun } } }
    | ( ( ?r == ADV | ?r == EXT | ?r == OBJ | ?r == PRD ) & ?pos == "IN" & c:?Dep { c:?s8-> c:?Dep8l { c:spos = relative_pronoun } } ) ) )
 | ?r == PMOD
)
( ¬ ( ( language.id.iso.ES | language.id.iso.CA ) & ( ?Dep.spos == "relative_pronoun"
    | c:?Dep { ( c:spos = "NN" | c:spos = "NP" ) c:?s26-> c:?Dep26l { c:spos = "relative_pronoun" } }
    | c:?Dep { ( c:spos = "NN" | c:spos = "NP" ) c:?s27-> c:?Prep27 { c:pos = "IN" c:?t27-> c:?Dep27l { c:spos = "relative_pronoun" } } }
    | ( ( ?r == adv | ?r == iobj | ?r == dobj | ?r == copul | ?r == obl_obj ) & ?pos == "IN" & c:?Dep { c:?s25-> c:?Dep25l { c:spos = "relative_pronoun" } } )
    ) )
 | ?r == prepos
)

// in this case the prefix stays before the verb
¬ ( language.id.iso.DE & ?r == SVP & ?Gov.finiteness == "INF" )
// embedded verbs are final in German
¬ ( language.id.iso.DE & c:?N1l {c:?r1-> c:?Gov {c:pos = "VB" } } )
// when gefallen (like) with "it" subject, subject and object are inverted
¬ ( language.id.iso.DE & ?r == OA & c:?Gov { c:lex = "gefallen_VB_01" } )

¬ ( language.id.iso.EN & ?r == NMOD & ¬(?pos == "IN" | ?pos == "VB" | ( ?pos == "NN" & ?Dep.straight_weight > 6 ) | ?pos == "MD" ) ) //only the prepositional modifiers appear POST.
¬ ( language.id.iso.DE & ?r == NMOD & ¬(?pos == "IN" | ?pos == "VB" | ?pos == "MD" ) ) //only the prepositional modifiers appear POST.

¬ ( c:?Dep { c:lex = ?lex } & lexicon.?lex.anteposed )	//problems with OBJ whose dependent is a DT (e.g.conll7,planSPAtxt1MS=>ENG)

¬(?r == modif & ?Dep.slex == "ce") //fix problems of relations labeling (it should be "det")

¬(?r == appos & ?Dep.slex == "million") //fix problems of relations labeling (it should be "quant") => SPAtxt1MS->FR

// WH-Interrogatives
¬(?Gov.clause_type == "INT" & ( ?pos == "WP" | ?pos == "WRB" | c:?Dep {c:det->c:?WDT {c:pos = "WDT"}}))

// when there is preposition stranding in English interrogatives, the preposition does not precede its dependent
¬ ( language.id.iso.EN & c:?Verb {c:clause_type = "INT" & c:?rV-> c:?Gov {c:pos = "IN"}} & ( ?pos == "WP" | c:?Dep {c:NMOD->c:?WDT {c:pos = "WDT"}}))
  ]
  mixed = [

  ]
  rightside = [
rc:?GovR {
  rc:<=> ?Gov
  ¬rc:bubble = yes
  ~ rc:?DepR {
    rc:<=> ?Dep
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph order_V_POST_name : order_vertical
[
  leftside = [
c:?Gov {
  c:id = ?id1
  c:NAME-> c:?Dep {
    c:id = ?id2
  }
}

?id2 > ?id1
  ]
  mixed = [

  ]
  rightside = [
rc:?GovR {
  rc:<=> ?Gov
  ¬rc:bubble = yes
  ~ rc:?DepR {
    rc:<=> ?Dep
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph order_V_POST_others : order_vertical
[
  leftside = [
c:?Gov {
  c:?r-> c:?Dep {
    c:pos = ?pos
  }
}

( ( ?Gov.slex == "année" & ?r == quant & ?pos == "CD" & ?Dep.slex > 1900 )  //to avoid anteposition of the year (SPAtxt1.plan9); see order_vertical_PRE_default
 | (?r == NMOD & c:?Gov{c:slex = "percentage"} & c:?Dep{c:pos = "NN"}) //to avoid anteposition of the noun that refer to the total of percentage
 | (?r == NMOD & ( c:?Gov{c:lex = ?l} & lexicon.?l.anteposed))
 | (?r == NMOD & c:?Dep { c:pronominalized = yes c:pos = "RB" } )
 // why was this limited to a weight of 2? Longer nominal arguments can go before the governing noun.
 | (?r == NMOD & ( ?pos == "NN" & ?Dep.straight_weight > 6 ) )

 | (c:?Gov{c:slex = "year"} & c:?Dep{c:pos = "CD" c:slex = ?s} & ?s > 1900)
// the XXX aircratft fighter
// | (?r == NMOD & ?pos == "NP")
 | (?r == NK & ?Gov.pos == "IN") //to fix the order of prepositional objects (check rule PRE_default)
 | ( ( language.id.iso.EN & ?r == ADV & ?Dep.straight_weight == "1.0" & ¬(?Gov.pos == "IN" | ?Gov.pos == "_")
  & ( c:?Gov { c:VC-> c:?Verb {} } | ?Dep.meaning == "locative_relation" )
 ) )
// English adjectives are linearized after the noun they modify when they have a dependent
// except when this dependent is an adverb modifying the adjective itself or if the adjective is comparative (see order_V_PRE_others and EN_order_V_comparative)
 | ( language.id.iso.EN & ?r == NMOD & ?pos == "JJ" & c:?Dep { c:?ddrr2-> c:?Deppp2l { ¬c:pos = "RB" } } & ¬?ddrr2 == AMOD_COMP )
 | ( (language.id.iso.EN & ( ?Gov.pos == "MD" | ?Gov.slex == "have" | ?Gov.slex == "be" ) & ( ?Dep.slex == "not" | ?Dep.slex == "never" ) ) )
// If there is a pronominalized object, the subject goes on the other side of the verb in order to avoid consecutive noun and pronoun
 | ( language.id.iso.EL & c:?Gov { c:dobj-> c:?Obj34 { ( c:pos = "PP" | c:pos = "WP" ) } } & ?r == subj )
 // Interrrogatives (in English interrogatives there is subject-verb inversion) unless it is the subject being questioned
 | ( language.id.iso.EN & ?r == SBJ & c:?Gov { c:clause_type = "INT" } & ¬(?pos == "WP" | c:?Dep {c:NMOD->?WDT {c:pos = "WDT"}}))
// English adverbs go after the verb to be (see also: order_V_PRE_others and EN_order_H_adv_main_verb_i and ii)
// (the condition might be too strong, there may be some adverbs for which this is not true... )
 | ( language.id.iso.EN & ?Gov.slex == "be" & ?Gov.type == "support_verb_noIN" & ?Dep.pos == "RB")
 )


¬(?Gov.slex == "the" & ?Dep.slex == "even")

// WH-Interrogatives
¬(?Gov.clause_type == "INT" & ( ?pos == "WP" | ?pos == "WRB" | c:?Dep {c:det->c:?WDT {c:pos = "WDT"}}))
  ]
  mixed = [

  ]
  rightside = [
rc:?GovR {
  rc:<=> ?Gov
  ¬rc:bubble = yes
  ~ rc:?DepR {
    rc:<=> ?Dep
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph order_V_PRE_pos : order_vertical
[
  leftside = [
c:?Gov {
  c:?r-> c:?Dep {
    c:pos = ?pos
  }
}

( lexicon.test_map.?r.?pos.default.orderV.lin.PRE
 | ( c:?Dep { c:lex = ?lex } & lexicon.?lex.anteposed )
)

¬ ( ?r == NMOD & c:?Gov { c:slex = "percentage" } & c:?Dep { c:pos = "NN" } )

¬ ( c:?Gov { c:lex = ?l } & lexicon.?l.anteposed )

¬ ( c:?Gov { c:slex = "year" } & c:?Dep { c:pos = "CD" slex = ?s } & ?s > 1900 )

//to cover cases in which dets have been added even with verbs
//¬ ( ?r == NMOD & ?Gov.pos == "VB" )

¬ ( ?r == NMOD & c:?Dep { c:pos = "JJ" c:?r2-> c:?Dep2l {} } )

¬ ( ?r == NMOD & ( ?pos == "NN" & ?Dep.straight_weight > 6 ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?DepR {
  rc:<=> ?Dep
  ¬rc:bubble = yes
  ~ rc:?GovR {
    rc:<=> ?Gov
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph order_V_PRE_default : order_vertical
[
  leftside = [
c:?Gov {
  c:?r-> c:?Dep {
    c:pos = ?pos
  }
}

( ( ¬lexicon.test_map.?r.?pos.default.orderV.lin & lexicon.test_map.?r.default.orderV.lin.PRE )
 | ( c:?Dep { c:lex = ?lex } & lexicon.?lex.anteposed )
 | ( language.id.iso.EN & ?r == NMOD & ¬(?pos == "IN" | ?pos == "VB" | ( ?pos == "NN" & ?Dep.straight_weight > 6 ) | ?pos == "MD" | ( ?Dep.pronominalized == yes & ?Dep.pos =="RB" ) ) ) //locates the non-prepositional modifiers before the noun; check vertical_POST_default
 | ( language.id.iso.EN & ?r == PRD & c:?Gov { c:slex = "be" c:type = "support_verb_noIN"
     ¬c:SBJ-> c:?Subj3 { ( c:class = "Person" | c:class = "Location" | c:pos = "PP" | c:pos = "WP" ) } }
     & ¬c:?Aux { c:VC-> c:?Gov {} }
     & ¬?Dep.slex == "part" & ¬?Dep.pos == "JJ" & ¬?Dep.pos == "IN" & ¬c:?Dep { c:NMOD-> c:?Det35 { c:slex = "a" } }
 & ¬c:?Dep { c:NMOD-> c:?Det35 { c:slex = "a" } }

     )
 | ( language.id.iso.EN & ?r == PRD & c:?Dep { ( c:spos = "NN" | c:spos = "NP" ) c:?s16-> c:?Prep16 { c:pos = "IN" c:?t16-> c:?Dep16l { c:spos = relative_pronoun } } } )
 | ( language.id.iso.EN & ?r == PRD & c:?Dep { ( c:spos = "NN" | c:spos = "NP" ) c:?t17-> c:?Dep17l { c:spos = relative_pronoun } } )
 | ( ( language.id.iso.ES | language.id.iso.CA ) & ?r == copul & c:?Dep { ( c:spos = "NN" | c:spos = "NP" ) c:?s28-> c:?Prep28 { c:pos = "IN" c:?t28-> c:?Dep28l { c:spos = "relative_pronoun" } } } )
 | ( ( language.id.iso.ES | language.id.iso.CA ) & ?r == copul & c:?Dep { ( c:spos = "NN" | c:spos = "NP" ) c:?t29-> c:?Dep29l { c:spos = "relative_pronoun" } } )
 | ( ( language.id.iso.ES | language.id.iso.CA ) & ?r == obl_obj & c:?Dep { c:pos = "IN" c:?t30-> c:?Dep30l { c:spos = "relative_pronoun" } } )
)
 ¬ ( language.id.iso.EN & ?r == SBJ & c:?Gov { c:slex = "be" c:type = "support_verb_noIN" }
      & ¬ ( ?Dep.class == "Person" | ?Dep.class == "Location"  | ?Dep.pos == "PP" | ?Dep.pos == "WP" )
     & ¬ c:?Gov { c:PRD-> c:?Predl { ( c:slex = "part" | c:pos = "JJ" | c:pos = "IN" | c:NMOD-> c:?Det36 { c:slex = "a" } ) } }
)
// relatives
¬ ( language.id.iso.EN & ?r == SBJ & c:?Gov { c:PRD-> c:?NG6 { ( c:spos = "NN" | c:spos = "NP" ) c:?s6-> c:?Prep6 { c:pos = "IN" c:?t6-> c:?Dep6l { c:spos = relative_pronoun } } } } )
¬ ( language.id.iso.EN & ?r == SBJ & c:?Gov { c:PRD-> c:?NG7 { ( c:spos = "NN" | c:spos = "NP" ) c:?t7-> c:?Dep7l { c:spos = relative_pronoun } } } )
¬ ( ( language.id.iso.ES | language.id.iso.CA ) & ?r == subj & c:?Gov { c:copul-> c:?NG26 { ( c:spos = "NN" | c:spos = "NP" ) c:?s26-> c:?Prep26 { c:pos = "IN" c:?t26-> c:?Dep26l { c:spos = "relative_pronoun" } } } } )
¬ ( ( language.id.iso.ES | language.id.iso.CA ) & ?r == subj & c:?Gov { c:copul-> c:?NG27 { ( c:spos = "NN" | c:spos = "NP" ) c:?t27-> c:?Dep27l { c:spos = "relative_pronoun" } } } )
¬ ( ( language.id.iso.ES | language.id.iso.CA ) & ?r == subj & c:?Gov { c:copul-> c:?NG31 { c:spos = "relative_pronoun" } } )
¬ ( ( language.id.iso.ES | language.id.iso.CA ) & ?r == subj & c:?Gov { c:obl_obj-> c:?Prep32 { c:pos = "IN" c:?t32-> c:?Dep32l { c:spos = "relative_pronoun" } } } )
¬ ( ( language.id.iso.ES | language.id.iso.CA ) &  ?r == subj & c:?Gov { c:aux_refl-> c:?AuxRefl33 {} } & ¬ ?Gov.has3rdArg == "yes" )
// ¬ ( language.id.iso.ES & ?r == subj & c:?Gov { c:obl_obj-> c:?NG33 { ( c:spos = "NN" | c:spos = "NP" ) c:?t33-> c:?Dep33l { c:spos = "relative_pronoun" } } } )
// adj with dependents go after the noun
¬(?r == NMOD & c:?Dep { c:pos = "JJ" c:?r2-> c:?Dep2l {} } )
// when gefallen (like) with "it" subject, subject and object are inverted
¬ ( language.id.iso.DE & c:?Gov { c:lex = "gefallen_VB_01" } & ?r == SB )
// don't apply if ?Dep is an embedded verb
¬ ( language.id.iso.DE & c:?Gov2 { c:?r2->c:?Gov {} } & c:?Dep { ( c:pos = "VB" | c:pos = "MD" | ( c:pos = "IN" c:?s2-> c:?Dep2 { ( c:pos = "VB" | c:pos = "MD" ) } ) ) } )
//  to cover cases like "traffic jam is reported" (may be limited to the verb and a few similar ones with the meaning of "there is"
¬ ( language.id.iso.EL & c:?Gov { c:lex = "αναφέρω_VB_01" } & ?r == subj )
// If there is a pronominalized object, the subject goes on the other side of the verb in order to avoid consecutive noun and pronoun
¬ ( language.id.iso.EL & c:?Gov { c:dobj-> c:?Obj34 { ( c:pos = "PP" | c:pos = "WP" ) } } & ?r == subj )

// reflexive pronouns in spanish with non finite verbs
¬ ( ( language.id.iso.ES | language.id.iso.CA ) &  ?r == aux_refl & c:?Gov { ( c:finiteness = "GER" | c:finiteness = "INF" | c:finiteness = "PART" ) } & ¬ ?Gov.has3rdArg == "yes" )


// Interrogatives
¬ ( language.id.iso.EN & ?r == SBJ & c:?Gov { c:clause_type = "INT" } )

//PATCHES
¬(?r == NMOD & c:?Gov{c:slex = "percentage"} & c:?Dep{c:pos = "NN"})
¬(?Gov.slex == "année" & ?r == quant & ?pos == "CD" & ?Dep.slex > 1900) //to avoid anteposition of the year (SPAtxt1.plan9); see order_vertical_POST_default
¬(c:?Gov{c:lex = ?l} & lexicon.?l.anteposed & ¬ ( c:?Dep { c:pos = "CD" }))  //the number modifes the gov first
¬(c:?Gov{c:slex = "year"} & c:?Dep{c:pos = "CD" slex = ?s} & ?s > 1900)
¬(?r == NMOD & ( ?Gov.pos == "VB"  | ?Gov.pos == "MD" ) )		//to cover cases in which dets have been added even with verbs
¬ (?r == NK & ?Gov.pos == "IN")  //in German, NK is used for determiners but also for prepositional objects.

// the XXX aircratft fighter
//¬(?r == NMOD & ?pos == "NP")
  ]
  mixed = [

  ]
  rightside = [
rc:?DepR {
  rc:<=> ?Dep
  ¬rc:bubble = yes
  ~ rc:?GovR {
    rc:<=> ?Gov
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph order_V_PRE_name : order_vertical
[
  leftside = [
c:?Gov {
  c:id = ?id1
  c:NAME-> c:?Dep {
    c:id = ?id2
  }
}

?id2 < ?id1
  ]
  mixed = [

  ]
  rightside = [
rc:?DepR {
  rc:<=> ?Dep
  ¬rc:bubble = yes
  ~ rc:?GovR {
    rc:<=> ?Gov
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph order_V_PRE_others : order_vertical
[
  leftside = [
c:?Gov {
  c:?r-> c:?Dep {}
}

(
//the pos=="IN" part of the condition is to avoid cycles
( language.id.iso.EN & ?r == ADV & ?Dep.straight_weight == "1.0" & ¬(?Gov.pos == "IN" | ?Gov.pos == "_")
  & ¬ c:?Gov { c:VC-> c:?Verb {} } & ¬?Dep.meaning == "locative_relation"
  )
 | ( ( language.id.iso.ES | language.id.iso.CA ) & ?r == adv & ?Dep.straight_weight == "1.0" & ¬(?Gov.pos == "IN" | ?Gov.pos == "_") & ¬?Dep.meaning == "locative_relation" )
 | ( language.id.iso.EN & ?r == NMOD & ?Gov.slex == "time" & ?Gov.meaning == "frequency" )
// English adjectives are linearized after the noun they modify when they have a dependent
// except when this dependent is an adverb modifying the adjective itself (see order_V_PRE_others)
 | ( language.id.iso.EN & ?r == NMOD & c:?Dep { c:pos = "JJ" c:AMOD-> c:?Deppp2l { c:pos = "RB" } } )
 | ( language.id.iso.PL & ?r == comp & ?Gov.slex == "raz" & ?Gov.meaning == "frequency" )
 | ( ( ?r == ADV | ?r == EXT | ?r == OBJ | ?r == PRD )  & c:?Dep { c:pos = "IN" c:?s8-> c:?Dep8l { c:spos = relative_pronoun } } )
 | (?Gov.slex == "the" & ?Dep.slex == "even")
)

¬ (language.id.iso.EN & ( ?Gov.pos == "MD" | ?Gov.slex == "have" | ?Gov.slex == "be" ) & ( ?Dep.slex == "not" | ?Dep.slex == "never" ) )

//(?Gov.slex == "the" & ?Dep.slex == "even") 		//SPA=>ENG, txt1.7(plan)

// English adverbs go after the verb to be (see order_V_POST_others)
// (the condition might be too strong, there may be some adverbs for which this is not true... )
¬ ( language.id.iso.EN & ?Gov.slex == "be" & ?Gov.type == "support_verb_noIN" & ?Dep.pos == "RB")
  ]
  mixed = [

  ]
  rightside = [
rc:?DepR {
  rc:<=> ?Dep
  ¬rc:bubble = yes
  ~ rc:?GovR {
    rc:<=> ?Gov
    ¬rc:bubble = yes
  }
}
  ]
]

/*The WH element in WH interrogatives goes before the verb
(whether it is an auxiliary verb (for EN) or the main verb (for romance languages)*/
SSynt<=>DMorph order_V_PRE_wh_interrogatives : order_vertical
[
  leftside = [
c:?Verb {
  c:*?r-> c:?Dep {
    c:pos = ?pos
    ¬c:spos = relative_pronoun
  }
}

?Verb.clause_type == "INT"
( ?pos == "WP" | ?pos == "WRB" | c:?Dep {c:NMOD->c:?WDT {c:pos = "WDT"}})

// see EN_order_V_PRE_wh_interrogatives_prep_stranding
¬ (language.id.iso.EN & ?r == PMOD)

¬ c:?Verb { c:COORD-> c:?And {}}
  ]
  mixed = [

  ]
  rightside = [
rc:?DepR {
  rc:<=> ?Dep
  ¬rc:bubble = yes
  ~ rc:?VerbR {
    rc:<=> ?Verb
    ¬rc:bubble = yes
  }
}
  ]
]

/*If a dependent is BEFORE its governor, in some cases the grandparent follows too.
For instance, when the gov is a participle in an auxiliary construction, the aux follows it after the dep.
E.g. WebNLG 170822a_known_input_multiple2.conll, #172*/
SSynt<=>DMorph order_V_PRE_grandchild_follow : order_vertical
[
  leftside = [
c:?Xl {
  c:?rS-> c:?Gov {
  // maybe ?r is too generic here... restrict to some rels?
    c:?r-> c:?Dep {}
  }
}

 ( ?rS == VC | ?rS == modal | ?rS == analyt_perf | ?rS == analyt_pass | ?rS == analyt_progr )

// list here relations for which this rule doesn't apply
¬ ?r == adv

// Wh - Interrogatives
¬( ?Xl.clause_type == "INT" & ( ?Dep.pos == "WP" | ?Dep.pos == "WRB" | c:?Dep {c:NMOD->c:?WDT {c:pos = "WDT"}}))
  ]
  mixed = [

  ]
  rightside = [
rc:?DepR {
  rc:<=> ?Dep
  ¬rc:bubble = yes
  rc:~ rc:?GovR {
    rc:<=> ?Gov
    ¬rc:bubble = yes
  }
  ~ rc:?Xr {
    rc:<=> ?Xl
    ¬rc:bubble = yes
  }
}

// don't create cycles
¬ rc:?Xr { rc:~ rc:?DepR {} }
  ]
]

/*If a dependent is BEFORE its governor, in some cases the governor's sibling follows too.
For instance, when the gov is a participle in an auxiliary construction, the subj follows it after the dep.
E.g. WebNLG 170822a_known_input_multiple2.conll, #172*/
SSynt<=>DMorph order_V_PRE_nephew_follow : order_vertical
[
  leftside = [
c:?Xl {
  c:?r-> c:?Gov {
  // maybe ?r is too generic here... restrict to some rels?
    c:?x-> c:?Dep {}
  }
  c:?s-> c:?Sibling {}
}


( ( ?r == VC & ?s == SBJ )
 | ( ( ?r == modal | ?r == analyt_perf | ?r == analyt_pass | ?r == analyt_progr ) & ?s == subj ) )

// list here relations for which this rule doesn't apply
¬ ?x == adv
  ]
  mixed = [

  ]
  rightside = [
rc:?DepR {
  rc:<=> ?Dep
  ¬rc:bubble = yes
  rc:~ rc:?XR {
    rc:<=> ?Xl
    ¬rc:bubble = yes
  }
  ~ rc:?SiblingR {
    rc:<=> ?Sibling
    ¬rc:bubble = yes
  }
}

// don't create cycles
¬ rc:?SiblingR { rc:~ rc:?DepR {} }
  ]
]

SSynt<=>DMorph order_V_DEP_pre : order_vertical
[
  leftside = [
c:?Gov {
  c:DEP-> c:?Dep {
    c:pos = ?pos
    ¬c:type = "parenthetical"
  }
}

(?pos == "PP" | ?pos == "CD" | (?pos == "NP" & ¬c:?Gov{c:SBJ-> c:?Zl{}}))//some possessive adjectives and numerals are connected through DEP

¬ c:?Gov {c:pos = "IN"}	//if the governor is a preposition, even if the relation is DEP, the dependent goes after.
  ]
  mixed = [

  ]
  rightside = [
rc:?DepR {
  rc:<=> ?Dep
  ¬rc:bubble = yes
  ~ rc:?GovR {
    rc:<=> ?Gov
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph order_V_DEP_post : order_vertical
[
  leftside = [
c:?Gov {
  c:DEP-> c:?Dep {
    c:pos = ?pos
  }
}

¬?Dep.pos == "PP" //some possessive adjectives are connected through DEP

¬?Dep.pos == "CD"

( ¬(?pos == "NP" & ¬c:?Gov{c:SBJ-> c:?Zl{}}) | ?Dep.type == "parenthetical" )
  ]
  mixed = [

  ]
  rightside = [
rc:?GovR {
  rc:<=> ?Gov
  ¬rc:bubble = yes
  ~ rc:?DepR {
    rc:<=> ?Dep
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph DE_order_V_PRE_VB_embed : order_vertical
[
  leftside = [
c:?Gov {
  c:?r-> c:?Dep {
    c:pos = ?pos
  }
}

language.id.iso.DE

// the Gov is embedded
c:?N1l {c:?r1-> c:?Gov {c:pos = "VB" } }

//there isn't another embedded verb below
¬?pos == "VB"
¬ c:?Dep { c:pos = "IN" c:?r2-> c:?Dep2 { c:pos = "VB" } }
  ]
  mixed = [

  ]
  rightside = [
rc:?DepR {
  rc:<=> ?Dep
  ¬rc:bubble = yes
  ~ rc:?GovR {
    rc:<=> ?Gov
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph DE_order_V_PRE_VB_embed_double : order_vertical
[
  leftside = [
c:?Gov {
  c:?r-> c:?Dep {
      c:pos = "VB"
  }
}

language.id.iso.DE

// the Gov  is embedded
c:?N1l {c:?r1-> c:?Gov {} } //c:?Gov {c:pos = "VB" }
  ]
  mixed = [

  ]
  rightside = [
rc:?GovR {
  rc:<=> ?Gov
  ¬rc:bubble = yes
  ~ rc:?DepR {
    rc:<=> ?Dep
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph DE_order_V_PRE_VB_embed_double_prep : order_vertical
[
  leftside = [
c:?Gov {
  c:?r-> c:?X {
    c:pos = "IN"
    c:?r2-> c:?Dep {
      c:pos = "VB"
    }
  }
}

language.id.iso.DE

// the Gov is embedded
c:?N1l {c:?r1-> c:?Gov { } } // c:?Gov { c:pos = "VB"}
  ]
  mixed = [

  ]
  rightside = [
rc:?GovR {
  rc:<=> ?Gov
  ¬rc:bubble = yes
  ~ rc:?DepR {
    rc:<=> ?Dep
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph EL_order_V_POST_others : order_vertical
[
  leftside = [
c:?Gov {
  c:?r-> c:?Dep {}
}

c:?Gov { c:lex = "αναφέρω_VB_01" } & ?r == subj
  ]
  mixed = [

  ]
  rightside = [
rc:?DepR {
  rc:<=> ?Gov
  ¬rc:bubble = yes
  ~ rc:?GovR {
    rc:<=> ?Dep
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph CA_ES_FR_PT_order_V_comparative : order_vertical
[
  leftside = [
c:?Adj {
  c:compar-> c:?Conj {
    c:prepos-> c:?Xl {}
  }
}

( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?AdjR {
  rc:<=> ?Adj
  ¬rc:bubble = yes
  ~ rc:?XR {
    rc:<=> ?Xl
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph CA_ES_FR_PT_order_V_adjunct : order_vertical
[
  leftside = [
c:?Gov {
  c:adjunct-> c:?Dep {
    c:pos = ?pos
    c:type = "parenthetical"
  }
}
( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?GovR {
  rc:<=> ?Gov
  ¬rc:bubble = yes
  ~ rc:?DepR {
    rc:<=> ?Dep
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph EN_order_V_comparative : order_vertical
[
  leftside = [
c:?Gl {
  ( c:pos = "NN" | c:pos = "JJ" | c:pos = "RB" )
  c:?r-> c:?Adj {
    c:AMOD_COMP-> c:?Xl {
}
  }
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?AdjR {
  rc:<=> ?Adj
  ¬rc:bubble = yes
  ~ rc:?GR {
    rc:<=> ?Gl
    ¬rc:bubble = yes
    ~ rc:?XR {
      rc:<=> ?Xl
      ¬rc:bubble = yes
    }
  }
}
  ]
]

/*The WH element in WH interrogatives goes before the verb (and its eventual auxiliaries)*/
SSynt<=>DMorph EN_order_V_PRE_wh_interrogatives_prep_stranding : order_vertical
[
  leftside = [
c:?Verb {
  c:*?r-> c:?Prep{
    c:PMOD-> c:?Dep {
      ¬c:spos = relative_pronoun
    }
  }
}

language.id.iso.EN

?Verb.clause_type == "INT"
( ?Dep.pos == "WP" | ?Dep.pos == "WRB" | c:?Dep {c:NMOD->c:?WDT {c:pos = "WDT"}})
  ]
  mixed = [

  ]
  rightside = [
rc:?DepR {
  rc:<=> ?Dep
  ¬rc:bubble = yes
  ~ rc:?VerbR {
    rc:<=> ?Verb
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph order_punct_parataxis : sentence_type_punctuations
[
  leftside = [
c:?Sl {
  c:slex = "Sentence"
  c:?Xl {
    c:clause_type = ?ct
    c:Parataxis-> c:?Yl {}
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Sr {
  rc:<=> ?Sl
  rc:*?Xr {
    rc:<=> ?Xl
    rc:~ ?Punt {
      rc:deprel_gen = punc
      in_bubble = "yes"
      ~ rc:?Yr {
        rc:<=> ?Yl
        ¬rc:bubble = yes
      }
    }
  }
}
  ]
]

SSynt<=>DMorph bubble_include_punct : sentence_type_punctuations
[
  leftside = [
c:?Sl {
  c:slex = "Sentence"
  c:?Xl {
    c:clause_type = ?ct
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Sr {
  rc:<=> ?Sl
  rc:*?Xr {
    rc:<=> ?Xl
    rc:~ ?Punt {
      rc:deprel_gen = punc
      in_bubble = "yes"
    }
  }
  rc:+?Punt {}
}
  ]
]

SSynt<=>DMorph declarative : sentence_type_punctuations
[
  leftside = [
c:?Xl{
}

(¬c:?H1l { c:?r-> c:?Xl {} } | c:?H2l { c:Parataxis-> c:?Xl {} } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  ( rc:clause_type = "DECL"
 | rc:clause_type = "PHRAS" )
  ¬rc:bubble = yes
  ~ ?Punt{
    slex = "."
    deprel_gen = punc
  }
}
  ]
]

SSynt<=>DMorph interrogative : sentence_type_punctuations
[
  leftside = [
c:?Xl{
}

(¬c:?H1l { c:?r-> c:?Xl {} } | c:?H2l { c:Parataxis-> c:?Xl {} } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  rc:clause_type = "INT"
  ¬rc:bubble = yes
  ~ ?Punt {
    slex = "?"
    deprel_gen = punc
  }
}
  ]
]

SSynt<=>DMorph exclamative_imperative : sentence_type_punctuations
[
  leftside = [
c:?Xl{
}

(¬c:?H1l { c:?r-> c:?Xl {} } | c:?H2l { c:Parataxis-> c:?Xl {} } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  ¬rc:bubble = yes
  (rc:clause_type = "EXCL" | rc:clause_type = "IMP")
  ~ ?Punt{
    slex = "!"
    deprel_gen = punc
  }
}
  ]
]

SSynt<=>DMorph agreement_up : agreement
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

SSynt<=>DMorph agreement_down : agreement
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*In German, if the adjective is AFTER the noun (e.g. in the copula complement position) is invariant.*/
SSynt<=>DMorph CA_EL_ES_FR_IT_PT_agreement_sibling_gender_JJ : agreement
[
  leftside = [
c:?Xl {
  ( c:slex = "estar" | c:slex = "ser" | c:slex = "être" | c:slex = "essere" | c:slex = "είμαι")
  c:subj-> c:?Subj {
    c:gender = ?gen
    //c:number = ?num
  }
  c:?r-> c:?Obj {
    c:pos = "JJ"
  }
}

( ?r == dobj | ?r == copul )

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

¬ ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj1 { c:coord_conj-> c:?dep1 { c:gender = "MASC" } } } )
¬ ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj2a { c:coord_conj-> c:?dep2a { c:coord-> c:?Conj2b { c:coord_conj-> c:?dep2b { c:gender = "MASC" } } } } } )
¬ ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj3a { c:coord_conj-> c:?dep3a { c:coord-> c:?Conj3b { c:coord_conj-> c:?dep3b { c:coord-> c:?Conj3c { c:coord_conj-> c:?dep3c { c:gender = "MASC" } } } } } } } )
¬ ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj4a { c:coord_conj-> c:?dep4a { c:coord-> c:?Conj4b { c:coord_conj-> c:?dep4b { c:coord-> c:?Conj4c { c:coord_conj-> c:?dep4c { c:coord-> c:?Conj4d { c:coord_conj-> c:?dep4d { c:gender = "MASC" } } } } } } } } } )
  ]
  mixed = [

  ]
  rightside = [
rc:?ObjR {
  rc:<=> ?Obj
  ¬rc:bubble = yes
  gender = ?gen
  //number = ?num
}
  ]
]

/*In German, if the adjective is AFTER the noun (e.g. in the copula complement position) is invariant.*/
SSynt<=>DMorph CA_EL_ES_FR_IT_PT_agreement_sibling_gender_JJ_COORD : agreement
[
  leftside = [
c:?Xl {
  ( c:slex = "estar" | c:slex = "ser" | c:slex = "être" | c:slex = "essere" | c:slex = "είμαι")
  c:subj-> c:?Subj {
    c:gender = ?gen
    //c:number = ?num
  }
  c:?r-> c:?Obj {
    c:pos = "JJ"
  }
}

( ?r == dobj | ?r == copul )

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

( ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj1 { c:coord_conj-> c:?dep1 { c:gender = "MASC" } } } )
 | ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj2a { c:coord_conj-> c:?dep2a { c:coord-> c:?Conj2b { c:coord_conj-> c:?dep2b { c:gender = "MASC" } } } } } )
 | ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj3a { c:coord_conj-> c:?dep3a { c:coord-> c:?Conj3b { c:coord_conj-> c:?dep3b { c:coord-> c:?Conj3c { c:coord_conj-> c:?dep3c { c:gender = "MASC" } } } } } } } )
 | ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj4a { c:coord_conj-> c:?dep4a { c:coord-> c:?Conj4b { c:coord_conj-> c:?dep4b { c:coord-> c:?Conj4c { c:coord_conj-> c:?dep4c { c:coord-> c:?Conj4d { c:coord_conj-> c:?dep4d { c:gender = "MASC" } } } } } } } } } )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?ObjR {
  rc:<=> ?Obj
  ¬rc:bubble = yes
  gender = "MASC"
  //number = ?num
}
  ]
]

/*In German, if the adjective is AFTER the noun (e.g. in the copula complement position) is invariant.*/
SSynt<=>DMorph CA_EL_ES_FR_IT_PT_agreement_sibling_number_JJ : agreement
[
  leftside = [
c:?Xl {
  ( c:slex = "estar" | c:slex = "ser" | c:slex = "être" | c:slex = "essere" | c:slex = "είμαι")
  c:subj-> c:?Subj {
    //c:gender = ?gen
    c:number = ?num
    ¬c:coord-> c:?Coord {}
  }
  c:?r-> c:?Obj {
    c:pos = "JJ"
  }
}

( ?r == dobj | ?r == copul )

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?ObjR {
  rc:<=> ?Obj
  ¬rc:bubble = yes
  //gender = ?gen
  number = ?num
}
  ]
]

/*In German, if the adjective is AFTER the noun (e.g. in the copula complement position) is invariant.*/
SSynt<=>DMorph CA_EL_ES_FR_IT_PT_agreement_sibling_number_JJ_COORD : agreement
[
  leftside = [
c:?Xl {
  ( c:slex = "estar" | c:slex = "ser" | c:slex = "être" | c:slex = "essere" | c:slex = "είμαι")
  c:subj-> c:?Subj {
    //c:gender = ?gen
    c:number = ?num
    c:coord-> c:?Coord {}
  }
  c:?r-> c:?Obj {
    c:pos = "JJ"
  }
}

( ?r == dobj | ?r == copul )

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?ObjR {
  rc:<=> ?Obj
  ¬rc:bubble = yes
  //gender = ?gen
  number = "PL"
}
  ]
]

/*In German, if the adjective is AFTER the noun (e.g. in the copula complement position) is invariant.*/
SSynt<=>DMorph CA_ES_FR_IT_PT_agreement_sibling_gender_PARTpass : agreement
[
  leftside = [
c:?Xl {
  ( c:slex = "estar" | c:slex = "ser" | c:slex = "être" | c:slex = "essere" )
  c:subj-> c:?Subj {
    c:gender = ?gen
    //c:number = ?num
  }
  c:analyt_pass-> c:?Obj {
    c:finiteness = "PART"
  }
}

( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

//PATCH make more clever rules with agree_gender
¬ ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj1 { c:coord_conj-> c:?dep1 { c:gender = "MASC" } } } )
¬ ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj2a { c:coord_conj-> c:?dep2a { c:coord-> c:?Conj2b { c:coord_conj-> c:?dep2b { c:gender = "MASC" } } } } } )
¬ ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj3a { c:coord_conj-> c:?dep3a { c:coord-> c:?Conj3b { c:coord_conj-> c:?dep3b { c:coord-> c:?Conj3c { c:coord_conj-> c:?dep3c { c:gender = "MASC" } } } } } } } )
¬ ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj4a { c:coord_conj-> c:?dep4a { c:coord-> c:?Conj4b { c:coord_conj-> c:?dep4b { c:coord-> c:?Conj4c { c:coord_conj-> c:?dep4c { c:coord-> c:?Conj4d { c:coord_conj-> c:?dep4d { c:gender = "MASC" } } } } } } } } } )
  ]
  mixed = [

  ]
  rightside = [
rc:?ObjR {
  rc:<=> ?Obj
  ¬rc:bubble = yes
  gender = ?gen
  //number = ?num
}
  ]
]

/*In German, if the adjective is AFTER the noun (e.g. in the copula complement position) is invariant.*/
SSynt<=>DMorph CA_ES_FR_IT_PT_agreement_sibling_gender_PARTpass_otherAux : agreement
[
  leftside = [
c:?Xl {
  c:subj-> c:?Subj {
    c:gender = ?gen
    //c:number = ?num
  }
  c:?r-> c:?Yl {
    ( c:slex = "estar" | c:slex = "ser" | c:slex = "être" | c:slex = "essere" )
    c:analyt_pass-> c:?Obj {
      c:finiteness = "PART"
    }
  }
}

( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

( ?r == analyt_perf | ?r == analyt_progr )

//PATCH make more clever rules with agree_gender
¬ ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj1 { c:coord_conj-> c:?dep1 { c:gender = "MASC" } } } )
¬ ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj2a { c:coord_conj-> c:?dep2a { c:coord-> c:?Conj2b { c:coord_conj-> c:?dep2b { c:gender = "MASC" } } } } } )
¬ ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj3a { c:coord_conj-> c:?dep3a { c:coord-> c:?Conj3b { c:coord_conj-> c:?dep3b { c:coord-> c:?Conj3c { c:coord_conj-> c:?dep3c { c:gender = "MASC" } } } } } } } )
¬ ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj4a { c:coord_conj-> c:?dep4a { c:coord-> c:?Conj4b { c:coord_conj-> c:?dep4b { c:coord-> c:?Conj4c { c:coord_conj-> c:?dep4c { c:coord-> c:?Conj4d { c:coord_conj-> c:?dep4d { c:gender = "MASC" } } } } } } } } } )
  ]
  mixed = [

  ]
  rightside = [
rc:?ObjR {
  rc:<=> ?Obj
  ¬rc:bubble = yes
  gender = ?gen
  //number = ?num
}
  ]
]

/*In German, if the adjective is AFTER the noun (e.g. in the copula complement position) is invariant.*/
SSynt<=>DMorph CA_FR_IT_PT_agreement_sibling_gender_PARTperf : agreement
[
  leftside = [
c:?Xl {
  ( c:slex = "être" | c:slex = "essere" )
  c:subj-> c:?Subj {
    c:gender = ?gen
    //c:number = ?num
  }
  c:analyt_perf-> c:?Obj {
    c:finiteness = "PART"
  }
}

( language.id.iso.CA | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

//PATCH make more clever rules with agree_gender
¬ ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj1 { c:coord_conj-> c:?dep1 { c:gender = "MASC" } } } )
¬ ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj2a { c:coord_conj-> c:?dep2a { c:coord-> c:?Conj2b { c:coord_conj-> c:?dep2b { c:gender = "MASC" } } } } } )
¬ ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj3a { c:coord_conj-> c:?dep3a { c:coord-> c:?Conj3b { c:coord_conj-> c:?dep3b { c:coord-> c:?Conj3c { c:coord_conj-> c:?dep3c { c:gender = "MASC" } } } } } } } )
¬ ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj4a { c:coord_conj-> c:?dep4a { c:coord-> c:?Conj4b { c:coord_conj-> c:?dep4b { c:coord-> c:?Conj4c { c:coord_conj-> c:?dep4c { c:coord-> c:?Conj4d { c:coord_conj-> c:?dep4d { c:gender = "MASC" } } } } } } } } } )
  ]
  mixed = [

  ]
  rightside = [
rc:?ObjR {
  rc:<=> ?Obj
  ¬rc:bubble = yes
  gender = ?gen
  //number = ?num
}
  ]
]

/*In German, if the adjective is AFTER the noun (e.g. in the copula complement position) is invariant.*/
SSynt<=>DMorph CA_ES_FR_IT_PT_agreement_sibling_gender_PARTpass_COORD : agreement
[
  leftside = [
c:?Xl {
  ( c:slex = "estar" | c:slex = "ser" | c:slex = "être" | c:slex = "essere" )
  c:subj-> c:?Subj {
    c:gender = ?gen
    //c:number = ?num
  }
  c:analyt_pass-> c:?Obj {
    c:finiteness = "PART"
  }
}

( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

//PATCH make more clever rules with agree_gender
( ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj1 { c:coord_conj-> c:?dep1 { c:gender = "MASC" } } } )
 | ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj2a { c:coord_conj-> c:?dep2a { c:coord-> c:?Conj2b { c:coord_conj-> c:?dep2b { c:gender = "MASC" } } } } } )
 | ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj3a { c:coord_conj-> c:?dep3a { c:coord-> c:?Conj3b { c:coord_conj-> c:?dep3b { c:coord-> c:?Conj3c { c:coord_conj-> c:?dep3c { c:gender = "MASC" } } } } } } } )
 | ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj4a { c:coord_conj-> c:?dep4a { c:coord-> c:?Conj4b { c:coord_conj-> c:?dep4b { c:coord-> c:?Conj4c { c:coord_conj-> c:?dep4c { c:coord-> c:?Conj4d { c:coord_conj-> c:?dep4d { c:gender = "MASC" } } } } } } } } } )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?ObjR {
  rc:<=> ?Obj
  ¬rc:bubble = yes
  gender = "MASC"
  //number = "PL"
}
  ]
]

/*In German, if the adjective is AFTER the noun (e.g. in the copula complement position) is invariant.*/
SSynt<=>DMorph CA_ES_FR_IT_PT_agreement_sibling_gender_PARTpass_COORD_otherAux : agreement
[
  leftside = [
c:?Xl {
  c:subj-> c:?Subj {
    c:gender = ?gen
    //c:number = ?num
  }
  c:?r-> c:?Yl {
    ( c:slex = "estar" | c:slex = "ser" | c:slex = "être" | c:slex = "essere" )
    c:analyt_pass-> c:?Obj {
      c:finiteness = "PART"
    }
  }
}

( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

( ?r == analyt_perf | ?r == analyt_progr )

//PATCH make more clever rules with agree_gender
( ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj1 { c:coord_conj-> c:?dep1 { c:gender = "MASC" } } } )
 | ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj2a { c:coord_conj-> c:?dep2a { c:coord-> c:?Conj2b { c:coord_conj-> c:?dep2b { c:gender = "MASC" } } } } } )
 | ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj3a { c:coord_conj-> c:?dep3a { c:coord-> c:?Conj3b { c:coord_conj-> c:?dep3b { c:coord-> c:?Conj3c { c:coord_conj-> c:?dep3c { c:gender = "MASC" } } } } } } } )
 | ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj4a { c:coord_conj-> c:?dep4a { c:coord-> c:?Conj4b { c:coord_conj-> c:?dep4b { c:coord-> c:?Conj4c { c:coord_conj-> c:?dep4c { c:coord-> c:?Conj4d { c:coord_conj-> c:?dep4d { c:gender = "MASC" } } } } } } } } } )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?ObjR {
  rc:<=> ?Obj
  ¬rc:bubble = yes
  gender = "MASC"
  //number = "PL"
}
  ]
]

/*In German, if the adjective is AFTER the noun (e.g. in the copula complement position) is invariant.*/
SSynt<=>DMorph CA_FR_IT_PT_agreement_sibling_gender_PARTperf_COORD : agreement
[
  leftside = [
c:?Xl {
  ( c:slex = "être" | c:slex = "essere" )
  c:subj-> c:?Subj {
    c:gender = ?gen
    //c:number = ?num
  }
  c:analyt_perf-> c:?Obj {
    c:finiteness = "PART"
  }
}

( language.id.iso.CA | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

//PATCH make more clever rules with agree_gender
( ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj1 { c:coord_conj-> c:?dep1 { c:gender = "MASC" } } } )
 | ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj2a { c:coord_conj-> c:?dep2a { c:coord-> c:?Conj2b { c:coord_conj-> c:?dep2b { c:gender = "MASC" } } } } } )
 | ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj3a { c:coord_conj-> c:?dep3a { c:coord-> c:?Conj3b { c:coord_conj-> c:?dep3b { c:coord-> c:?Conj3c { c:coord_conj-> c:?dep3c { c:gender = "MASC" } } } } } } } )
 | ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj4a { c:coord_conj-> c:?dep4a { c:coord-> c:?Conj4b { c:coord_conj-> c:?dep4b { c:coord-> c:?Conj4c { c:coord_conj-> c:?dep4c { c:coord-> c:?Conj4d { c:coord_conj-> c:?dep4d { c:gender = "MASC" } } } } } } } } } )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?ObjR {
  rc:<=> ?Obj
  ¬rc:bubble = yes
  gender = "MASC"
  //number = "PL"
}
  ]
]

/*In German, if the adjective is AFTER the noun (e.g. in the copula complement position) is invariant.*/
SSynt<=>DMorph CA_ES_FR_IT_PT_agreement_sibling_number_PARTpass : agreement
[
  leftside = [
c:?Xl {
  ( c:slex = "estar" | c:slex = "ser" | c:slex = "être" | c:slex = "essere" )
  c:subj-> c:?Subj {
    //c:gender = ?gen
    c:number = ?num
    ¬c:coord-> c:?Coord {}
  }
  c:analyt_pass-> c:?Obj {
    c:finiteness = "PART"
  }
}

( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

//PATCH make more clever rules with agree_gender
  ]
  mixed = [

  ]
  rightside = [
rc:?ObjR {
  rc:<=> ?Obj
  ¬rc:bubble = yes
  //gender = ?gen
  number = ?num
}
  ]
]

/*In German, if the adjective is AFTER the noun (e.g. in the copula complement position) is invariant.*/
SSynt<=>DMorph CA_ES_FR_IT_PT_agreement_sibling_number_PARTpass_otherAux : agreement
[
  leftside = [
c:?Xl {
  c:subj-> c:?Subj {
    //c:gender = ?gen
    c:number = ?num
    ¬c:coord-> c:?Coord {}
  }
  c:?r-> c:?Yl {
    ( c:slex = "estar" | c:slex = "ser" | c:slex = "être" | c:slex = "essere" )
    c:analyt_pass-> c:?Obj {
      c:finiteness = "PART"
    }
  }
}

( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

( ?r == analyt_perf | ?r == analyt_progr )

//PATCH make more clever rules with agree_gender
  ]
  mixed = [

  ]
  rightside = [
rc:?ObjR {
  rc:<=> ?Obj
  ¬rc:bubble = yes
  //gender = ?gen
  number = ?num
}
  ]
]

/*In German, if the adjective is AFTER the noun (e.g. in the copula complement position) is invariant.*/
SSynt<=>DMorph CA_FR_IT_PT_agreement_sibling_number_PARTperf : agreement
[
  leftside = [
c:?Xl {
  ( c:slex = "être" | c:slex = "essere" )
  c:subj-> c:?Subj {
    //c:gender = ?gen
    c:number = ?num
    ¬c:coord-> c:?Coord {}
  }
  c:analyt_perf-> c:?Obj {
    c:finiteness = "PART"
  }
}

( language.id.iso.CA | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

//PATCH make more clever rules with agree_gender
  ]
  mixed = [

  ]
  rightside = [
rc:?ObjR {
  rc:<=> ?Obj
  ¬rc:bubble = yes
  //gender = ?gen
  number = ?num
}
  ]
]

/*In German, if the adjective is AFTER the noun (e.g. in the copula complement position) is invariant.*/
SSynt<=>DMorph CA_ES_FR_IT_PT_agreement_sibling_number_PARTpass_COORD : agreement
[
  leftside = [
c:?Xl {
  ( c:slex = "estar" | c:slex = "ser" | c:slex = "être" | c:slex = "essere" )
  c:subj-> c:?Subj {
    //c:gender = ?gen
    c:number = ?num
    c:coord-> c:?Coord {}
  }
  c:analyt_pass-> c:?Obj {
    c:finiteness = "PART"
  }
}

( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

//PATCH make more clever rules with agree_gender
  ]
  mixed = [

  ]
  rightside = [
rc:?ObjR {
  rc:<=> ?Obj
  ¬rc:bubble = yes
  //gender = ?gen
  number = "PL"
}
  ]
]

/*In German, if the adjective is AFTER the noun (e.g. in the copula complement position) is invariant.*/
SSynt<=>DMorph CA_ES_FR_IT_PT_agreement_sibling_number_PARTpass_COORD_otherAux : agreement
[
  leftside = [
c:?Xl {
  c:subj-> c:?Subj {
    //c:gender = ?gen
    c:number = ?num
    c:coord-> c:?Coord {}
  }
  c:?r-> c:?Yl {
    ( c:slex = "estar" | c:slex = "ser" | c:slex = "être" | c:slex = "essere" )
    c:analyt_pass-> c:?Obj {
      c:finiteness = "PART"
    }
  }
}

( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

( ?r == analyt_perf | ?r == analyt_progr )

//PATCH make more clever rules with agree_gender
  ]
  mixed = [

  ]
  rightside = [
rc:?ObjR {
  rc:<=> ?Obj
  ¬rc:bubble = yes
  //gender = ?gen
  number = "PL"
}
  ]
]

/*In German, if the adjective is AFTER the noun (e.g. in the copula complement position) is invariant.*/
SSynt<=>DMorph CA_FR_IT_PT_agreement_sibling_number_PARTperf_COORD : agreement
[
  leftside = [
c:?Xl {
  ( c:slex = "être" | c:slex = "essere" )
  c:subj-> c:?Subj {
    //c:gender = ?gen
    c:number = ?num
    c:coord-> c:?Coord {}
  }
  c:analyt_perf-> c:?Obj {
    c:finiteness = "PART"
  }
}

( language.id.iso.CA | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

//PATCH make more clever rules with agree_gender
  ]
  mixed = [

  ]
  rightside = [
rc:?ObjR {
  rc:<=> ?Obj
  ¬rc:bubble = yes
  //gender = ?gen
  number = "PL"
}
  ]
]

/*In Italian perfect + passive constructions both participles must agree in gender with the subject:
"Un'alluvione è stata segnalata"*/
SSynt<=>DMorph IT_agreement_sibling_gender_PARTperfpass : agreement
[
  leftside = [
c:?Essere {
  c:slex = "essere" 
  c:subj-> c:?Subj {
    c:gender = ?gen
  }
  c:analyt_perf-> c:?Stare {
    c:slex = "stare" 
    c:finiteness = "PART"
    c:analyt_pass-> c:?MainV {
      c:finiteness = "PART"
    }
  }
}

language.id.iso.IT

//PATCH make more clever rules with agree_gender
¬ ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj1 { c:coord_conj-> c:?dep1 { c:gender = "MASC" } } } )
¬ ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj2a { c:coord_conj-> c:?dep2a { c:coord-> c:?Conj2b { c:coord_conj-> c:?dep2b { c:gender = "MASC" } } } } } )
¬ ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj3a { c:coord_conj-> c:?dep3a { c:coord-> c:?Conj3b { c:coord_conj-> c:?dep3b { c:coord-> c:?Conj3c { c:coord_conj-> c:?dep3c { c:gender = "MASC" } } } } } } } )
¬ ( ?gen == "FEM" & c:?Subj { c:coord-> c:?Conj4a { c:coord_conj-> c:?dep4a { c:coord-> c:?Conj4b { c:coord_conj-> c:?dep4b { c:coord-> c:?Conj4c { c:coord_conj-> c:?dep4c { c:coord-> c:?Conj4d { c:coord_conj-> c:?dep4d { c:gender = "MASC" } } } } } } } } } )
  ]
  mixed = [

  ]
  rightside = [
rc:?MainVR {
  rc:<=> ?MainV
  ¬rc:bubble = yes
  gender = ?gen
}
  ]
]

/*In Italian perfective + passive constructions both participles must agree in number with the subject:
"Un'alluvione è stata segnalata"*/
SSynt<=>DMorph IT_agreement_sibling_number_PARTperfpass : agreement
[
  leftside = [
c:?Essere {
  c:slex = "essere" 
  c:subj-> c:?Subj {
    c:number = ?num
  }
  c:analyt_perf-> c:?Stare {
    c:slex = "stare" 
    c:finiteness = "PART"
    c:analyt_pass-> c:?MainV {
      c:finiteness = "PART"
    }
  }
}

language.id.iso.IT

//PATCH make more clever rules with agree_gender
//¬ ( ?num == "SG" & c:?Subj { c:coord-> c:?Conj1 { c:coord_conj-> c:?dep1 {} } } )
//¬ ( ?num == "SG" & c:?Subj { c:coord-> c:?Conj2a { c:coord_conj-> c:?dep2a { c:coord-> c:?Conj2b { c:coord_conj-> c:?dep2b {} } } } } )
//¬ ( ?num == "SG" & c:?Subj { c:coord-> c:?Conj3a { c:coord_conj-> c:?dep3a { c:coord-> c:?Conj3b { c:coord_conj-> c:?dep3b { c:coord-> c:?Conj3c { c:coord_conj-> c:?dep3c {} } } } } } } )
//¬ ( ?num == "SG" & c:?Subj { c:coord-> c:?Conj4a { c:coord_conj-> c:?dep4a { c:coord-> c:?Conj4b { c:coord_conj-> c:?dep4b { c:coord-> c:?Conj4c { c:coord_conj-> c:?dep4c { c:coord-> c:?Conj4d { c:coord_conj-> c:?dep4d {} } } } } } } } } )
  ]
  mixed = [

  ]
  rightside = [
rc:?MainVR {
  rc:<=> ?MainV
  ¬rc:bubble = yes
  number = ?num
}
  ]
]

/*Rules are now applied in the level before to allow for smooth resolution of agreements.*/
excluded SSynt<=>DMorph agreement_sibling_number_NOUN_copul : agreement
[
  leftside = [
c:?Xl {
  c:?r-> c:?Subj {
    //c:gender = ?gen
    c:number = ?num
    ¬c:coord-> c:?Coord {}
  }
  c:?s-> c:?Obj {
    c:pos = "NN"
  }
}


( ?r == subj | ?r == SBJ )
( ?s == copul | ?s == PRD )

//PATCH make more clever rules with agree_gender
  ]
  mixed = [

  ]
  rightside = [
rc:?ObjR {
  rc:<=> ?Obj
  ¬rc:bubble = yes
  //gender = ?gen.
  rc:number = ?n
  number = ?num
  update_num_deps = "yes"
}
  ]
]

/*Rules are now applied in the level before to allow for smooth resolution of agreements.*/
excluded SSynt<=>DMorph agreement_sibling_number_NOUN_copul_COORD : agreement
[
  leftside = [
c:?Xl {
  c:?r-> c:?Subj {
    c:coord-> c:?Coord {}
  }
  c:?s-> c:?Obj {
    c:pos = "NN"
  }
}


( ?r == subj | ?r == SBJ )
( ?s == copul | ?s == PRD )

//PATCH make more clever rules with agree_gender
  ]
  mixed = [

  ]
  rightside = [
rc:?ObjR {
  rc:<=> ?Obj
  ¬rc:bubble = yes
  //gender = ?gen
  rc:number = ?n
  number = "PL"
  update_num_deps = "yes"
}
  ]
]

SSynt<=>DMorph ellipsis : ellipsis_referringExp
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*Pronoun subject is dropped in Spanish*/
SSynt<=>DMorph PT_introduce_deictic : ellipsis_referringExp
[
  leftside = [
c:?gov {
  c:subj-> c:?node {
    pos = "PP"
    ( c:slex = "_PRO_" | c:slex = "_PRO-HUM_" )
    c:<-> c:?Ante {
      c:slex = ?slex
      c:pos = ?pos
    }
  }
}

// in Portuguese, referring  subjects that are ot in the initial position in a sentence are not pronominalised; we introduce a deictic instead
language.id.iso.PT
// simplified condition: apply to subject of main verb, which will usually be in the first position of the sentence
¬c:?GrandGov { c:?r-> c:?gov {} }

lexicon.miscellaneous.determiners.?def.?lex
?def == "DEI"
lexicon.?lex.lemma.?lem
  ]
  mixed = [

  ]
  rightside = [
rc:?Bub{
  rc:<=> ?node
  rc:bubble = yes
  rc:?nodeR {
    rc:<=> ?node
    ¬rc:bubble = yes
    ¬rc:deictic = "introduced"
    rc:pos = "PP"
    rc:slex = ?s
    slex = ?slex
    pos = ?pos
    deictic = "introduced"
  }
  ?Deictic {
    slex = ?lem
    number = ?nodeR.number
    gender = ?nodeR.gender
    pos = "DT"
    ~rc:?nodeR {}
  }
}
  ]
]

SSynt<=>DMorph anaphora_resolution : ellipsis_referringExp
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

SSynt<=>DMorph january : months
[
  leftside = [
c:?Xl{
  ( c:pos = "NN" | c:pos = "NP" )
  c:slex = "january"
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  rc:slex = ?slex
  slex = "January"
}
  ]
]

SSynt<=>DMorph february : months
[
  leftside = [
c:?Xl{
  ( c:pos = "NN" | c:pos = "NP" )
  c:slex = "february"
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  rc:slex = ?slex
  slex = "February"
}
  ]
]

SSynt<=>DMorph march : months
[
  leftside = [
c:?Xl{
  ( c:pos = "NN" | c:pos = "NP" )
  c:slex = "march"
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  rc:slex = ?slex
  slex = "March"
}
  ]
]

SSynt<=>DMorph april : months
[
  leftside = [
c:?Xl{
  ( c:pos = "NN" | c:pos = "NP" )
  c:slex = "april"
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  rc:slex = ?slex
  slex = "April"
}
  ]
]

SSynt<=>DMorph may : months
[
  leftside = [
c:?Xl{
  ( c:pos = "NN" | c:pos = "NP" )
  c:slex = "may"
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  rc:slex = ?slex
  slex = "May"
}
  ]
]

SSynt<=>DMorph june : months
[
  leftside = [
c:?Xl{
  ( c:pos = "NN" | c:pos = "NP" )
  c:slex = "june"
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  rc:slex = ?slex
  slex = "June"
}
  ]
]

SSynt<=>DMorph july : months
[
  leftside = [
c:?Xl{
  ( c:pos = "NN" | c:pos = "NP" )
  c:slex = "july"
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  rc:slex = ?slex
  slex = "July"
}
  ]
]

SSynt<=>DMorph august : months
[
  leftside = [
c:?Xl{
  ( c:pos = "NN" | c:pos = "NP" )
  c:slex = "august"
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  rc:slex = ?slex
  slex = "August"
}
  ]
]

SSynt<=>DMorph september : months
[
  leftside = [
c:?Xl{
  ( c:pos = "NN" | c:pos = "NP" )
  c:slex = "september"
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  rc:slex = ?slex
  slex = "September"
}
  ]
]

SSynt<=>DMorph october : months
[
  leftside = [
c:?Xl{
  ( c:pos = "NN" | c:pos = "NP" )
  c:slex = "october"
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  rc:slex = ?slex
  slex = "October"
}
  ]
]

SSynt<=>DMorph november : months
[
  leftside = [
c:?Xl{
  ( c:pos = "NN" | c:pos = "NP" )
  c:slex = "november"
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  rc:slex = ?slex
  slex = "November"
}
  ]
]

SSynt<=>DMorph december : months
[
  leftside = [
c:?Xl{
  ( c:pos = "NN" | c:pos = "NP" )
  c:slex = "december"
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  rc:slex = ?slex
  slex = "December"
}
  ]
]

SSynt<=>DMorph monday : week_days
[
  leftside = [
c:?Xl{
  ( c:pos = "NN" | c:pos = "NP" )
  c:slex = "monday"
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  rc:slex = ?slex
  slex = "Monday"
}
  ]
]

SSynt<=>DMorph tuesday : week_days
[
  leftside = [
c:?Xl{
  ( c:pos = "NN" | c:pos = "NP" )
  c:slex = "tuesday"
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  rc:slex = ?slex
  slex = "Tuesday"
}
  ]
]

SSynt<=>DMorph wednesday : week_days
[
  leftside = [
c:?Xl{
  ( c:pos = "NN" | c:pos = "NP" )
  c:slex = "wednesday"
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  rc:slex = ?slex
  slex = "Wednesday"
}
  ]
]

SSynt<=>DMorph thursday : week_days
[
  leftside = [
c:?Xl{
  ( c:pos = "NN" | c:pos = "NP" )
  c:slex = "thursday"
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  rc:slex = ?slex
  slex = "Thursday"
}
  ]
]

SSynt<=>DMorph friday : week_days
[
  leftside = [
c:?Xl{
  ( c:pos = "NN" | c:pos = "NP" )
  c:slex = "friday"
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  rc:slex = ?slex
  slex = "Friday"
}
  ]
]

SSynt<=>DMorph saturday : week_days
[
  leftside = [
c:?Xl{
  ( c:pos = "NN" | c:pos = "NP" )
  c:slex = "saturday"
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  rc:slex = ?slex
  slex = "Saturday"
}
  ]
]

SSynt<=>DMorph sunday : week_days
[
  leftside = [
c:?Xl{
  ( c:pos = "NN" | c:pos = "NP" )
  c:slex = "sunday"
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  rc:slex = ?slex
  slex = "Sunday"
}
  ]
]

SSynt<=>DMorph K_attr_gest_fen : K_attr_gestures
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
  rc:?Punctr {
    rc:deprel_gen = punc
    ¬rc:~ rc:?nodeR {}
    FacialEnthusiasm = ?u
  }
}
  ]
]

SSynt<=>DMorph K_attr_gest_fex : K_attr_gestures
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
  rc:?Punctr {
    rc:deprel_gen = punc
    ¬rc:~ rc:?nodeR {}
    FacialExpression = ?u
  }
}
  ]
]

SSynt<=>DMorph K_attr_gest_fin : K_attr_gestures
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
  rc:?Punctr {
    rc:deprel_gen = punc
    ¬rc:~ rc:?nodeR {}
    FacialIntensity = ?u
  }
}
  ]
]

SSynt<=>DMorph K_attr_gest_att : K_attr_gestures
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
  rc:?Punctr {
    rc:deprel_gen = punc
    ¬rc:~ rc:?nodeR {}
    hasAttitude = ?u
  }
}
  ]
]

SSynt<=>DMorph K_attr_gest_exp : K_attr_gestures
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
  rc:?Punctr {
    rc:deprel_gen = punc
    ¬rc:~ rc:?nodeR {}
    hasExpressivity = ?u
  }
}
  ]
]

SSynt<=>DMorph K_attr_gest_pro : K_attr_gestures
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
  rc:?Punctr {
    rc:deprel_gen = punc
    ¬rc:~ rc:?nodeR {}
    hasProximity = ?u
  }
}
  ]
]

SSynt<=>DMorph K_attr_gest_soc : K_attr_gestures
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
  rc:?Punctr {
    rc:deprel_gen = punc
    ¬rc:~ rc:?nodeR {}
    hasSocial = ?u
  }
}
  ]
]

SSynt<=>DMorph K_attr_gest_sty : K_attr_gestures
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
  rc:?Punctr {
    rc:deprel_gen = punc
    ¬rc:~ rc:?nodeR {}
    hasStyle = ?u
  }
}
  ]
]

SSynt<=>DMorph K_attr_gest_sa : K_attr_gestures
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
  rc:?Punctr {
    rc:deprel_gen = punc
    ¬rc:~ rc:?nodeR {}
    speechAct = ?u
  }
}
  ]
]

SSynt<=>DMorph DE_order_H_det : DE_order_H
[
  leftside = [
c:?Xl {
  c:det-> c:?Yl {}
  c:?r-> c:?Zl {}
}

language.id.iso.DE

¬ ( ?r == det & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b} )

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph DE_order_H_modif_same_weight_no_antep_id : DE_order_H
[
  leftside = [
c:?Xl {
  c:?r-> c:?Yl {
    c:straight_weight = ?s1
    c:lex = ?m
    c:id = ?id01
  }
  c:?s-> c:?Zl {
    c:straight_weight = ?s2
    c:pos = "CD"
   c:id = ?id02
  }
}

?s == ?r
?s1 == ?s2

// put the smallest dependents first
?id01 > ?id02

¬(language.id.iso.DE & lexicon.?m.anteposed)

/* ¬lexicon_MS_EN.?l.anteposed
¬lexicon_MS_EN.?m.anteposed */

(¬c:?Yl{id0 = ?a} | ¬c:?Zl{id0 = ?b})

/* ¬?Zl.pos == "NP"  //to avoid cycles (e.g.conllS7, planSPAtxt1)

¬ (?r == NMOD & ?Yl.pos == "IN" & ¬?Zl.pos == "IN")		//when a preposition and some other element are NMOD, this rules doesn't apply.

¬ (?r == NMOD & ?Zl.pos == "IN" & ¬?Yl.pos == "IN")

¬ (c:?Yl {c:pos = "DT"} & ¬(c:?Zl{c:pos = "DT"} | c:?Zl{c:pos = "PDT"} )) */ //to avoid wrong linearization between adjectives and articles */

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Zl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Yl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Yr {rc:<=> ?Yl}
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph DE_order_H_NK_det : DE_order_H
[
  leftside = [
c:?Xl {
  c:NK-> c:?Yl {c:pos = "DT"}
  c:?r-> c:?Zl {}
}

language.id.iso.DE

¬ ( ?r == NK & c:?Yl{c:straight_weight = ?a} & c:?Zl{ c:pos = "DT" c:straight_weight = ?b} )

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph DE_order_H_subj : DE_order_H
[
  leftside = [
c:?Xl {
  c:SB-> c:?Yl {}
  c:?r-> c:?Zl {}
}

language.id.iso.DE

¬ ( ?r == SB & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b} )


// when gefallen (like) with "it" subject, subject and object are inverted
¬ ( ?r == OA & c:?Xl { c:lex = "gefallen_VB_01" } )

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph DE_order_H_OA : DE_order_H
[
  leftside = [
c:?Xl {
  c:OA-> c:?Yl {}
  c:?r-> c:?Zl {}
}

language.id.iso.DE

¬ ( ?r == OA & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b} )
¬ ?r == OA2
¬ ?r ==  OC
¬ ?r ==  SB
¬ ?r ==  CD

¬ ?Xl.lex == "gefallen_VB_01"

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Zl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Yl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Yr {rc:<=> ?Yl}
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph DE_order_H_OA2 : DE_order_H
[
  leftside = [
c:?Xl {
  c:OA2-> c:?Yl {}
  c:?r-> c:?Zl {}
}

language.id.iso.DE

¬ ( ?r == OA2 & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b} )

//¬?r == OA 	//the dative object appears before the accusative one

¬ ?r ==  SB
¬ ?r ==  OC
¬ ?r ==  CD

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Zl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Yl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Yr {rc:<=> ?Yl}
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bubble = yes
  }
}
  ]
]

/*for now, the rules about NK are divided into determiners and not determiners, but either they specify more and more, or
they merge*/
SSynt<=>DMorph DE_order_H_NK_no_det : DE_order_H
[
  leftside = [
c:?Xl {
  c:NK-> c:?Yl {¬c:pos = "DT"}
  c:?r-> c:?Zl {}
}

language.id.iso.DE

¬ ( ?r == NK & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b} )

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph DE_order_H_PAR : DE_order_H
[
  leftside = [
c:?Xl {
  c:PAR-> c:?Yl {}
  c:?r-> c:?Zl {}
}

language.id.iso.DE

¬ ( ?r == PAR & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b} )

¬ (?r == NK & c:?Zl{c:pos = "DT"})

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph DE_order_H_MO : DE_order_H
[
  leftside = [
c:?Xl {
  c:?r-> c:?Yl {}
  c:MO-> c:?Zl {}
}

language.id.iso.DE

¬ ?r == SVP
¬ ?r == OA
¬ ?r == OA2
¬ ?r ==  OC
¬ ?r ==  CD
¬ ( ?r == MO & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b} )

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*when gefallen (like) with "it" subject, subject and object are inverted*/
SSynt<=>DMorph DE_order_H_subj_invert_comma : DE_order_H
[
  leftside = [
c:?Xl {
  c:lex = "gefallen_VB_01"
  c:SB-> c:?Yl {
    c:lex = "es_PRP_01"
  }
  c:OA-> c:?Zl {}
}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ~ rc:?Xr {
    rc:<=> ?Xl
    ¬rc:bubble = yes
    ~ rc:?Yr {
      rc:<=> ?Yl
      ¬rc:bubble = yes
      ~ ?Cr {
        slex = ","
        inserted = "yes"
      }
    }
  }
}

rc:?Bubble {
  rc:slex = "pronoun"
  rc:?Yr {
    rc:<=> ?Yl
    //¬rc:bubble = yes
  }
  ?Cr {}
}
  ]
]

/*when gefallen (like) with "it" subject, subject and object are inverted*/
SSynt<=>DMorph DE_order_H_subj_invert : DE_order_H
[
  leftside = [
c:?Xl {
  c:lex = "gefallen_VB_01"
  c:SB-> c:?Yl {
    ¬c:lex = "es_PRP_01"
  }
  c:OA-> c:?Zl {}
}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ~ rc:?Xr {
    rc:<=> ?Xl
    ¬rc:bubble = yes
    ~ rc:?Yr {
      rc:<=> ?Yl
      ¬rc:bubble = yes
    }
  }
}
  ]
]

SSynt<=>DMorph DE_order_H_OC : DE_order_H
[
  leftside = [
c:?Xl {
  c:?r-> c:?Yl {}
  c:OC-> c:?Zl {}
}

language.id.iso.DE

¬ ( ?r == OC & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b} )
¬ ?r == CD

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph DE_order_H_coord : DE_order_H
[
  leftside = [
c:?Xl {
  c:?r-> c:?Yl {}
  c:CD-> c:?Zl {}
}

language.id.iso.DE

¬ ?r == SVP
¬ ( ?r == CD & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b} )

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*This ruls could be generalized for noun arguments in some other languages.*/
SSynt<=>DMorph EN_order_H_same_dep_NMOD_arg : EN_order_H
[
  leftside = [
c:?Xl {
  c:NMOD-> c:?Yl {
     c:dsyntRel = III

}
  c:NMOD-> c:?Zl {
    c:dsyntRel = II

}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Yr {rc:<=> ?Yl}
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bubble = yes
  }
}
  ]
]

/*PMOD goes by default before all other dependencies.*/
SSynt<=>DMorph EN_order_HV_pmod_patch : EN_order_H
[
  leftside = [
c:?Xl {
  c:pos = "IN"
  c:PMOD-> c:?Yl {
  }
  c:DEP-> c:?Zl {
    c:pos = "NP"
  }
}

language.id.iso.EN

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Zl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Yl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Yr {rc:<=> ?Yl}
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bubble = yes
  }
  ¬rc:~ rc:?Xr {rc:<=> ?Xl}
  ~ rc:?Xr {
    rc:<=> ?Xl
    ¬rc:bubble = yes
  }
}
  ]
]

/*adv goes by default at the end of the sentence.

PATCH NOT: restrictives such as NOT should be marked in a lexicon

Should it be included within ENG? => no "adjunct"*/
SSynt<=>DMorph EN_order_H_adjunct : EN_order_H
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:adjunct-> c:?Yl {
    ¬c:slex = "not"
  }
  c:?r-> c:?Zl {}
}

language.id.iso.EN

//¬ ( ?Yl.straight_weight == "1.0" )
¬ ( ?r == adjunct & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b})
( ¬ ?r == COORD | ?Yl.coord_type == "shared_dep" )

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Zl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Yl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ~ rc:?Yr {
      rc:<=> ?Yl
      ¬rc:bubble = yes
  }
}
  ]
]

/*adv goes by default at the end of the sentence.

PATCH NOT: restrictives such as NOT should be marked in a lexicon*/
SSynt<=>DMorph EN_order_H_adv_main_verb_i : EN_order_H
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:ADV-> c:?Yl {
    ¬c:slex = "not"
    ¬c:pos = "WRB"		//if an adverbial relative element is present, it goes first
  }
  c:?r-> c:?Zl {}
}

language.id.iso.EN

//¬ ( ?Yl.straight_weight == "1.0" )  unclear this condition
¬ ( ?r == ADV & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b} )
¬ ?r == adjunct
¬ c:?Zl { c:type = "parenthetical" }
( ¬ ?r == COORD | ?Yl.coord_type == "shared_dep" )
¬ ?r == Parataxis

//¬ ( ?Yl.straight_weight == "1.0" & ¬ (?Xl.pos == "IN" | ?Xl.pos == "_") )
¬ ( ?Yl.straight_weight == "1.0" & ¬ (?Xl.pos == "IN" | ?Xl.pos == "_")
  & ( ?Yl.slex == "already" | ?Yl.slex == "also" | ?Yl.slex == "always" | ?Yl.slex == "first" | ?Yl.slex == "formerly"
     | ?Yl.slex == "just" | ?Yl.slex == "nearly" | ?Yl.slex == "never" | ?Yl.slex == "possibly" | ?Yl.slex == "only"
     | ?Yl.slex == "often" | ?Yl.slex == "probably" | ?Yl.slex == "really" | ?Yl.slex == "simply" | ?Yl.slex == "sometimes" | ?Yl.slex == "then"
     | ?Yl.slex == "usually" | ?Yl.slex == "well" | ?Yl.slex == "definitely" | ?Yl.slex == "currently" | ?Yl.slex == "last" | ?Yl.slex == "particularly" ) )

// ?Xl is the root of the sentence
¬ c:?Gl { c:?s-> c:?Xl {} }

¬(?Yl.slex == "when" & ¬c:?Yl{c:?s-> c:?Vl{}})	//when "when" subordinates, it follows; otherwise, it porecedes

¬(?r == OBJ & ?Zl.slex == "country") //specific rule for avoid cycles (I need to improve the methodology!!)

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Zl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Yl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Yr {rc:<=> ?Yl}
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bubble = yes
  }
}
  ]
]

/*adv goes by default at the end of the sentence.

PATCH NOT: restrictives such as NOT should be marked in a lexicon*/
SSynt<=>DMorph EN_order_H_adv_main_verb_ii : EN_order_H
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:ADV-> c:?Yl {
    ¬c:slex = "not"
    ¬c:pos = "WRB"		//if an adverbial relative element is present, it goes first
  }
  c:?r-> c:?Zl {}
}

language.id.iso.EN

//¬ ( ?Yl.straight_weight == "1.0" )  unclear this condition
¬ ( ?r == ADV & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b} )
¬ ?r == adjunct

//(?Yl.straight_weight == "1.0" & ¬(?Xl.pos == "IN" | ?Xl.pos == "_"))
( ?Yl.straight_weight == "1.0" & ¬ (?Xl.pos == "IN" | ?Xl.pos == "_")
  & ( ?Yl.slex == "already" | ?Yl.slex == "also" | ?Yl.slex == "always" | ?Yl.slex == "first" | ?Yl.slex == "formerly"
     | ?Yl.slex == "just" | ?Yl.slex == "nearly" | ?Yl.slex == "never" | ?Yl.slex == "possibly" | ?Yl.slex == "only"
     | ?Yl.slex == "often" | ?Yl.slex == "probably" | ?Yl.slex == "really" | ?Yl.slex == "simply" | ?Yl.slex == "sometimes" | ?Yl.slex == "then"
     | ?Yl.slex == "usually" | ?Yl.slex == "well" | ?Yl.slex == "definitely" | ?Yl.slex == "currently" | ?Yl.slex == "last" | ?Yl.slex == "particularly" ) )

// ?Xl is the root of the sentence
¬ c:?Gl{c:?s-> c:?Xl{}}

// Adverbs go after the verb to be (and hence, also after its PRD - see EN_order_H_prd_as_subj)
// (the condition might be too strong, there may be some adverbs for which this is not true... )
¬ ( ?r == PRD & ?Xl.slex == "be" & ?Xl.type == "support_verb_noIN" )

// The rule doesn't apply to the subject (unless it is a copulative sentence - see EN_order_H_prd_as_subj)
( ¬ ?r == SBJ | ( ?Xl.slex == "be" & ?Xl.type == "support_verb_noIN" ) )

¬ ( ?r == NMOD & ?Zl.pos == "DT" )

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*adv goes by default at the end of the sentence.

PATCH NOT: restrictives such as NOT should be marked in a lexicon*/
SSynt<=>DMorph EN_order_H_adv_embedded_verb_i : EN_order_H
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:ADV-> c:?Yl {
  //  (c:pos = "WRB" | c:pos = "JJ")	//if an adverbial relative element is present, it goes first
  }
  c:?r-> c:?Zl {}
}

language.id.iso.EN

c:?Gl { c:?s-> c:?Xl {} } //embeddedness

¬ ( ?r == ADV & c:?Yl { c:straight_weight = ?a } & c:?Zl { c:straight_weight = ?b } )
¬ ?r == adjunct

( ?Yl.pos == "WRB" | ( ( ?Yl.pos == "JJ" | ?Yl.pos == "IN" ) & ¬?r == SBJ ) )

¬ ( ?r == OBJ | ?r == PRD )

¬?r == VC

¬ ( ?r == NMOD & ?Zl.pos == "DT" )

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*I added this rule cos PRD + ADV was not covered by any other rule...*/
SSynt<=>DMorph EN_order_H_adv_embedded_verb_ii : EN_order_H
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:ADV-> c:?Yl {
  //  (c:pos = "WRB" | c:pos = "JJ")	//if an adverbial relative element is present, it goes first
  }
  c:PRD-> c:?Zl {}
}

language.id.iso.EN

c:?Gl { c:?s-> c:?Xl {} } //embeddedness

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Zl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Yl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )

¬?Yl.spos == relative_pronoun
¬c:?Yl { c:spos = "IN" c:?s5-> c:?Dep5l { c:spos = relative_pronoun } }
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Yr {rc:<=> ?Yl}
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bubble = yes
  }
}
  ]
]

/*adv goes by default at the end of the sentence.

PATCH NOT: restrictives such as NOT should be marked in a lexicon*/
SSynt<=>DMorph EN_order_H_adv_no_verb : EN_order_H
[
  leftside = [
c:?Xl {
  ¬c:pos = "VB"
  c:ADV-> c:?Yl {
    ¬c:slex = "not"
    ¬c:slex = "already"
    ¬c:slex = "also"
    ¬c:slex = "always"
    ¬c:slex = "first"
    ¬c:slex = "formerly"
    ¬c:slex = "just"
    ¬c:slex = "nearly"
    ¬c:slex = "never"
    ¬c:slex = "often"
    ¬c:slex = "probably"
    ¬c:slex = "really"
    ¬c:slex = "simply"
    ¬c:slex = "sometimes"
    ¬c:slex = "then"
    ¬c:slex = "usually"
    ¬c:slex = "well"
    ¬c:slex = "definitely"
    ¬c:slex = "currently"
    ¬c:slex = "last"
    ¬c:slex = "particularly"    
    ¬c:slex = "possibly"
  }
  c:?r-> c:?Zl {}
}

language.id.iso.EN

//¬ ( ?Yl.straight_weight == "1.0" )
¬ ( ?r == ADV & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b} )
¬ ?r == adjunct
( ¬ ?r == COORD
 | ?Yl.coord_type == "shared_dep" )
¬ ?r == Parataxis

¬(?r == DEP & ?Zl.pos == "NP" & ¬c:?Xl{c:SUBJ-> c:?Al{}})

¬ (?r == ADV & ?Zl.pos == "WRB")

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Zl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Yl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )

// WH-Interrogatives
¬(?Xl.clause_type == "INT" & ( ?Yl.spos == "WP" | ?Yl.spos == "WRB" | c:?Yl {c:det->?WDT {c:pos = "WDT"}}))
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Yr {rc:<=> ?Yl}
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bubble = yes
  }
}
  ]
]

/*eg: scored more (Xl) points than him (Yl) in the paint (Zl, if we accept it can depend on "more" and not "score")

Should it be included within ENG? => no "adjunct"*/
SSynt<=>DMorph EN_order_H_amod_comp : EN_order_H
[
  leftside = [
c:?Xl {
  c:AMOD_COMP-> c:?Yl {
}
  c:?r-> c:?Zl {}
}

language.id.iso.EN

// Can this even happen? Just in case...
¬ ?r == DT
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ~ rc:?Zr {
      rc:<=> ?Zl
      ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph EN_order_H_coord : EN_order_H
[
  leftside = [
c:?Xl {
  c:?r-> c:?Yl {
  }
  c:COORD-> c:?Zl {}
}

language.id.iso.EN

// covered by generic rules sme_dep_diff_weight
¬(?r == COORD & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b})

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )

¬ ?r == Parataxis

¬ ?Yl.coord_type == "shared_dep"
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph EN_order_H_coord_sharedDep : EN_order_H
[
  leftside = [
c:?Xl {
  c:?r-> c:?Yl {
  }
  c:COORD-> c:?Zl {}
}

language.id.iso.EN

// covered by generic rules sme_dep_diff_weight
¬(?r == COORD & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b})

?Yl.coord_type == "shared_dep"
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Yr {rc:<=> ?Yl}
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph EN_order_H_ext : EN_order_H
[
  leftside = [
c:?Xl {
  c:?r-> c:?Yl {
  }
  c:EXT-> c:?Zl {}
}

language.id.iso.EN

//¬(?r == DEP & ?Yl.pos == "NP" & ¬c:?Xl{c:SUBJ-> c:?Al{}})

//¬(language.id.iso.EN & ?r == ADV & ?Yl.straight_weight == "1.0" & ¬(?Xl.pos == "IN" | ?Xl.pos == "_"))

( ¬ ?r == COORD | ?Zl.coord_type == "shared_dep" )
¬?r == ADV
¬?r == LGS
¬ ?r == Parataxis

¬(?r == EXT & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b})

//¬ (?r == ADV & ?Yl.pos == "WRB")

¬ c:?Zl { c:pos = "IN" c:PMOD-> c:?Depl { c:spos = relative_pronoun } }

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*IM goes by default before all other dependencies.*/
SSynt<=>DMorph EN_order_H_im : EN_order_H
[
  leftside = [
c:?Xl {
  c:IM-> c:?Yl {
  }
  c:?r-> c:?Zl {}
}

language.id.iso.EN

¬ (?r == ADV & ?Zl.pos == "WRB")

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*OBJ goes by default before all dependencies but the subject.*/
SSynt<=>DMorph EN_order_H_iobj : EN_order_H
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:IOBJ-> c:?Yl {}
  c:?r-> c:?Zl {}
}

language.id.iso.EN

¬(?r == SBJ | (?r == ADV & c:?Zl {c:slex = "not"}) | ?r == LGS | ?Zl.spos == relative_pronoun
  | c:?Zl { ( c:spos = "NN" | c:spos = "NP" ) c:?s5-> c:?Dep5l { c:spos = relative_pronoun } }
  | c:?Zl { ( c:spos = "NN" | c:spos = "NP" ) c:?s6-> c:?Prep6 { c:pos = "IN" c:?t6-> c:?Dep6l { c:spos = relative_pronoun } } }
)
¬ ( ( ?r == ADV | ?r == EXT | ?r == OBJ | ?r == PRD ) & c:?Zl { c:pos = "IN" c:?s9-> c:?Dep9l { c:spos = relative_pronoun } } )

¬ ( ?r == IOBJ & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b} )

¬ (?r == ADV & ?Zl.pos == "WRB")

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph EN_order_H_lgs_JJ : EN_order_H
[
  leftside = [
c:?Xl {
  c:pos = "JJ"
  c:LGS-> c:?Yl {}
  c:?r-> c:?Zl {}
}

language.id.iso.EN

¬ ?r == COORD
// to distinguish between "selected by NASA in 1965" and "rated 2/5 by customers".
¬ ?Zl.dsyntRel == ATTR
¬ ?Zl.dsyntRel == APPEND
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Yr {rc:<=> ?Yl}
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph EN_order_H_lgs_VB : EN_order_H
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:LGS-> c:?Yl {}
  c:?r-> c:?Zl {}
}

language.id.iso.EN

¬(?r == SBJ | (?r == ADV & c:?Zl {c:slex = "not"})
    | ?Zl.spos == relative_pronoun
    | c:?Zl { ( c:spos = "NN" | c:spos = "NP" ) c:?s5-> c:?Dep5l { c:spos = relative_pronoun } }
    | ( ( ?r == ADV | ?r == EXT | ?r == OBJ | ?r == PRD ) & c:?Zl { c:pos = "IN" c:?s6-> c:?Dep6l { c:spos = relative_pronoun } } ) )

¬ ( ?r == LGS & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b} )

¬ (?r == EXT & ?Zl.slex == "he" & ?Zl.id == "9") 		//patch for fixing 2.2 plan FR => ENG

¬ (?r == ADV & ?Zl.slex == "each")

¬ (?r == ADV & ?Zl.straight_weight == "1.0")

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*Actually, having a restrictoin about pos or slex, many cases of NMOD plus another relation are not ordered.
We need to test more. */
SSynt<=>DMorph EN_order_H_nmod_genitive : EN_order_H
[
  leftside = [
c:?Xl {
  ( c:pos = "NN" | c:pos = "NP" )
  c:NMOD-> c:?Yl {
   ( c:case = "GEN" )
  }
  c:?r-> c:?Zl {}
}

language.id.iso.EN

 ¬ ( ?r == NMOD & c:?Zl { c:pos = "DT" } )

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*Actually, having a restrictoin about pos or slex, many cases of NMOD plus another relation are not ordered.
We need to test more. */
SSynt<=>DMorph EN_order_H_nmod_right : EN_order_H
[
  leftside = [
c:?Xl {
  ( c:pos = "NN" | c:pos = "NP" )
  c:NMOD-> c:?Yl {
   //very specific the last part, because we don't want to do it more general (SPAtxt2.1 => ENG)
   ( c:pos = "DT" | c:pos = "PP" | c:slex = "we")
  }
  c:?r-> c:?Zl {}
}

language.id.iso.EN

 ¬ ( ?r == NMOD & c:?Yl { c:straight_weight = ?a } & c:?Zl { ( c:pos = "DT" | c:pos = "PP" ) c:straight_weight = ?b } )

¬ (?r == ADV & ?Zl.pos == "WRB")

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph EN_order_H_nmod_nmod_relat : EN_order_H
[
  leftside = [
c:?Xl {
  ( c:pos = "NN" | c:pos = "NP" )
  c:NMOD-> c:?Yl {
    ¬c:finiteness = "FIN"
    ¬c:pos = "DT"
  }
  c:NMOD-> c:?Zl {
    c:finiteness = "FIN"
  }
}

language.id.iso.EN

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*OBJ goes by default before all dependencies but the subject.*/
SSynt<=>DMorph EN_order_H_obj : EN_order_H
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:OBJ-> c:?Yl {}
  c:?r-> c:?Zl {}
}

language.id.iso.EN

¬(?r == SBJ | (?r == ADV & c:?Zl {c:slex = "not"}) | ?r == LGS | ?r == IOBJ | ?Zl.spos == relative_pronoun
  | c:?Zl { ( c:spos = "NN" | c:spos = "NP" ) c:?s5-> c:?Dep5l { c:spos = relative_pronoun } }
  | c:?Zl { ( c:spos = "NN" | c:spos = "NP" ) c:?s6-> c:?Prep6 { c:pos = "IN" c:?t6-> c:?Dep6l { c:spos = relative_pronoun } } }
)
¬ ( ( ?r == ADV | ?r == EXT | ?r == OBJ | ?r == PRD ) & c:?Zl { c:pos = "IN" c:?s9-> c:?Dep9l { c:spos = relative_pronoun } } )
¬ ( ?r == ADV & ?Zl.straight_weight == "1.0" )

¬ ( ?r == OBJ & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b} )

//¬?r == EXT  //for avoiding cycles between EXT and OBJ

¬ (?r == NMOD & ?Zl.slex == "the")		//to avoid cycles with wrong tagger (NMOD from a verb); FR2.4plan

¬?Zl.slex == "when"

¬ ( ?r == ADV & ?Zl.pos == "IN" ¬c:?Gl{c:?s-> c:?Xl{}} )  //In 2015, I did that... (SPA1.2)

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*PMOD goes by default before all other dependencies.*/
SSynt<=>DMorph EN_order_H_pmod : EN_order_H
[
  leftside = [
c:?Xl {
  c:PMOD-> c:?Yl {
  }
  c:?r-> c:?Zl {}
}

language.id.iso.EN

¬ (?r == ADV & ?Zl.pos == "WRB")

//some possessive adjectives and numerals are connected through DEP
¬ ( c:?Xl { ¬ c:pos = "IN" c:DEP-> c:?Dep { c:pos = ?pos } }
 & (?pos == "PP" | ?pos == "CD" | (?pos == "NP" & c:?Xl{ ¬c:SBJ-> c:?Vl {} } ) )
)

// patch
¬ ( c:?Xl { c:pos = "IN" } & ?r == DEP & c:?Zl { c:pos = "NP" } )

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*SUBJ goes by default before all other dependencies.
This rules has lots of dependencies in other rules; maybe find another way to deal with it.*/
SSynt<=>DMorph EN_order_H_prd_as_subj : EN_order_H
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:slex = "be"
  c:type = "support_verb_noIN"
  c:PRD-> c:?Yl {
  }
  c:?r-> c:?Zl {}
}

language.id.iso.EN

¬ ?Zl.spos == relative_pronoun
¬ c:?Zl { ( c:spos = "NN" | c:spos = "NP" ) c:?s5-> c:?Dep5l { c:spos = relative_pronoun } }
¬c:?Zl { ( c:spos = "NN" | c:spos = "NP" ) c:?s6-> c:?Prep6 { c:pos = "IN" c:?t6-> c:?Dep6l { c:spos = relative_pronoun } } }
¬ ( ( ?r == ADV | ?r == EXT | ?r == OBJ | ?r == PRD ) & c:?Zl { c:pos = "IN" c:?s9-> c:?Dep9l { c:spos = relative_pronoun } } )

¬ ( ?r == PRD & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b} )

¬ ( ?r == ADV & (?Zl.pos == "WRB" | ?Zl.pos == "JJ" ))		//to keep the good order in subordinated clauses

¬ (?r == SBJ & ( ?Zl.class == "Person" | ?Zl.class == "Location" | ?Zl.pos == "PP" | ?Zl.pos == "WP" ) )
¬ (?r == SBJ & ?Yl.pos == "JJ" )

¬?Yl.slex == "part"
¬?Yl.pos == "IN"
¬c:?Yl { c:NMOD-> c:?Det35 { c:slex = "a" } }

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*SUBJ goes by default before all other dependencies.*/
SSynt<=>DMorph EN_order_H_relpro : EN_order_H
[
  leftside = [
c:?Xl {
  c:?s-> c:?Yl {
    c:spos = relative_pronoun
  }
  c:?r-> c:?Zl {}
}

language.id.iso.EN

¬ (?r == ADV & ?Zl.pos == "WRB")

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*SUBJ goes by default before all other dependencies.*/
SSynt<=>DMorph EN_order_H_relpro_embed1 : EN_order_H
[
  leftside = [
c:?Xl {
  c:?s-> c:?Yl {
    ( c:spos = "NN" | c:spos = "NP" )
    c:?s5-> c:?Dep5l { c:spos = relative_pronoun }
  }
  c:?r-> c:?Zl {}
}

language.id.iso.EN

¬ (?r == ADV & ?Zl.pos == "WRB")

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*SUBJ goes by default before all other dependencies.*/
SSynt<=>DMorph EN_order_H_relpro_embed1bis : EN_order_H
[
  leftside = [
c:?Xl {
  c:?t-> c:?Yl {
    c:pos = "IN"
    c:?s5-> c:?Dep5l { c:spos = relative_pronoun }
  }
  c:?r-> c:?Zl {}
}

language.id.iso.EN

¬ (?r == ADV & ?Zl.pos == "WRB")

( ?t == ADV | ?t == EXT | ?t == OBJ | ?t == PRD )

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*SUBJ goes by default before all other dependencies.*/
SSynt<=>DMorph EN_order_H_relpro_embed2 : EN_order_H
[
  leftside = [
c:?Xl {
  c:?s-> c:?Yl {
    ( c:spos = "NN" | c:spos = "NP" )
    c:?s6-> c:?Prep6 {
      c:pos = "IN"
      c:?s5-> c:?Dep5l { c:spos = relative_pronoun }
    }
  }
  c:?r-> c:?Zl {}
}

language.id.iso.EN

¬ ( ?r == ADV & ?Zl.pos == "WRB" )
¬ ( ?Zl.spos == relative_pronoun )

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph EN_order_H_restrictive : EN_order_H
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:ADV-> c:?Yl {c:slex = "not"}
  c:?r-> c:?Zl {}
}

language.id.iso.EN

¬( ?r == SBJ | ?Zl.spos == relative_pronoun
  | c:?Zl { ( c:spos = "NN" | c:spos = "NP" ) c:?s5-> c:?Dep5l { c:spos = relative_pronoun } }
  | c:?Zl { ( c:spos = "NN" | c:spos = "NP" ) c:?s6-> c:?Prep6 { c:pos = "IN" c:?t6-> c:?Dep6l { c:spos = relative_pronoun } } }
)
¬ ( ( ?r == ADV | ?r == EXT | ?r == OBJ | ?r == PRD ) & c:?Zl { c:pos = "IN" c:?s9-> c:?Dep9l { c:spos = relative_pronoun } } )

¬ ( ?r == ADV & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b} )

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*SUBJ goes by default before all other dependencies.*/
SSynt<=>DMorph EN_order_H_subj : EN_order_H
[
  leftside = [
c:?Xl {
  ( c:pos = "VB"
 | c:pos = "MD" )
  c:SBJ-> c:?Yl {}
  c:?r-> c:?Zl {}
}

language.id.iso.EN

¬?Zl.spos == relative_pronoun
// In wh-interrogatives the wh-element goes before the subject (this is true for other languages, should it be lanaguage independent?)
//¬( ( ?Zl.spos == "WP" | ?Zl.spos == "WRB" ) & ?Xl.clause_type == "INT" )

¬c:?Zl { ( c:spos = "NN" | c:spos = "NP" ) c:?s5-> c:?Dep5l { c:spos = relative_pronoun } }
¬c:?Zl { ( c:spos = "NN" | c:spos = "NP" ) c:?s6-> c:?Prep6 { c:pos = "IN" c:?t6-> c:?Dep6l { c:spos = relative_pronoun } } }
¬ ( ( ?r == ADV | ?r == EXT | ?r == OBJ | ?r == PRD ) & c:?Zl { c:pos = "IN" c:?s9-> c:?Dep9l { c:spos = relative_pronoun } } )

¬ ( ?r == SBJ & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b} )

¬ ( ?r == ADV & ( ?Zl.pos == "WRB" ) )		//to keep the good order in subordinated clauses

¬ ( c:?Xl { c:slex = "be" c:type = "support_verb_noIN" } & ¬ ( ?Yl.class == "Person" | ?Yl.class == "Location" | ?Yl.pos == "PP" | ?Yl.pos == "WP" )
      & ¬ ( ?r ==PRD & c:?Zl { ( c:slex = "part" | c:pos = "JJ" | c:pos = "IN" | c:NMOD-> c:?Det36 { c:slex = "a" } ) } )
)

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*SUBJ goes by default before all other dependencies.*/
SSynt<=>DMorph EN_order_H_sub : EN_order_H
[
  leftside = [
c:?Xl {
  c:SUB-> c:?Yl {}
  c:?r-> c:?Zl {}
}

language.id.iso.EN

¬ ( ?r == SUB & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b} )

¬ (?r == ADV & ?Zl.pos == "WRB")

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*VC goes by default before all other dependencies of a verb.*/
SSynt<=>DMorph EN_order_H_VC : EN_order_H
[
  leftside = [
c:?Xl {
  c:VC-> c:?Yl {
  }
  c:?r-> c:?Zl {}
}

language.id.iso.EN

¬?r == SBJ

//¬(?r == ADV & ?Zl.pos == "RB") //"have already been/have"
¬?Zl.spos == relative_pronoun
¬c:?Zl { ( c:spos = "NN" | c:spos = "NP" ) c:?s5-> c:?Dep5l { c:spos = relative_pronoun } }
¬c:?Zl { ( c:spos = "NN" | c:spos = "NP" ) c:?s6-> c:?Prep6 { c:pos = "IN" c:?t6-> c:?Dep6l { c:spos = relative_pronoun } } }
¬ ( ( ?r == ADV | ?r == EXT | ?r == OBJ | ?r == PRD ) & c:?Zl { c:pos = "IN" c:?s9-> c:?Dep9l { c:spos = relative_pronoun } } )

// see Adv_light rule
¬ ( ?r == ADV & ?Zl.straight_weight == "1.0" & ¬(?Xl.pos == "IN" | ?Xl.pos == "_")
  & ( ?Zl.slex == "already" | ?Zl.slex == "also" | ?Zl.slex == "always" | ?Zl.slex == "first" | ?Zl.slex == "formerly"
     | ?Zl.slex == "just" | ?Zl.slex == "nearly" | ?Zl.slex == "never" | ?Zl.slex == "possibly"
     | ?Zl.slex == "often" | ?Zl.slex == "probably" | ?Zl.slex == "really" | ?Zl.slex == "simply" | ?Zl.slex == "sometimes" | ?Zl.slex == "then"
     | ?Zl.slex == "usually" | ?Zl.slex == "well" | ?Zl.slex == "definitely" | ?Zl.slex == "currently" | ?Zl.slex == "last" | ?Zl.slex == "particularly" ) )

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )

// WH-Interrogatives
¬(?Xl.clause_type == "INT" & ( ?Zl.spos == "WP" | ?Zl.spos == "WRB" | c:?Zl {c:det->c:?WDT {c:pos = "WDT"}}))
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*This rule should apply to some adverbs only.*/
SSynt<=>DMorph EN_order_H_VC_Adv_light : EN_order_H
[
  leftside = [
c:?Xl {
  c:VC-> c:?Yl {
  }
  c:?r-> c:?Zl {}
}

language.id.iso.EN

//¬(?r == ADV & ?Zl.pos == "RB") //"have already been/have" 

( ?Zl.slex == "already" | ?Zl.slex == "also" | ?Zl.slex == "always" | ?Zl.slex == "first" | ?Zl.slex == "formerly"
    | ?Zl.slex == "just" | ?Zl.slex == "nearly" | ?Zl.slex == "never" | ?Zl.slex == "possibly"
    | ?Zl.slex == "often" | ?Zl.slex == "probably" | ?Zl.slex == "really" | ?Zl.slex == "simply" | ?Zl.slex == "sometimes" | ?Zl.slex == "then"
    | ?Zl.slex == "usually" | ?Zl.slex == "well" | ?Zl.slex == "definitely" | ?Zl.slex == "currently" | ?Zl.slex == "last" | ?Zl.slex == "particularly" )
     
(?r == ADV & ?Zl.straight_weight == "1.0" & ¬(?Xl.pos == "IN" | ?Xl.pos == "_"))  //a different version of the previous condition (non-dependent of POS)

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Zl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Yl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Yr {rc:<=> ?Yl}
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bubble = yes
  }
}
  ]
]

excluded SSynt<=>DMorph EN_order_H_nmod_wrong : EN_order_H
[
  leftside = [
c:?Xl {
  ¬ c:pos = "NN"
  c:NMOD-> c:?Yl {
   ( c:pos = "DT" | c:slex = "we") //very specific the second part, because we don't want to do it more general (SPAtxt2.1 => ENG)
  }
  c:?r-> c:?Zl {}
}

language.id.iso.EN

¬ ( ?r == NMOD & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b} )

¬ (?r == ADV & ?Zl.pos == "WRB")
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*DEP goes by default after all other dependencies.*/
SSynt<=>DMorph EN_order_DEP_default : EN_order_H
[
  leftside = [
c:?Xl {
  // see EN_order_HV_pmod_patch
  ¬ ( c:pos = "IN"
 c:PMOD-> c:?Yl {
}
 )
  c:DEP-> c:?Zl {
    //c:pos = "NP"
  }
  c:?r-> c:?Wl {}
}

language.id.iso.EN

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Zl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )

¬ ( ?r == DEP & c:?Wl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b})
( ¬ ?r == ADV | ?Zl.parenth == "yes" | ?Zl.type == "parenthetical" )
( ¬ ?r == COORD | ?Zl.coord_type == "shared_dep" )
¬ ?r == Parataxis
  ]
  mixed = [

  ]
  rightside = [
rc:?Wr {
  rc:<=> ?Wl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*This ruls could be generalized for noun arguments in some other languages.*/
SSynt<=>DMorph CA_EL_ES_FR_IT_PT_order_H_same_dep_oblCompl_arg : CA_EL_ES_FR_IT_PT_order_H
[
  leftside = [
c:?Xl {
  c:obl_compl-> c:?Yl {
     c:dsyntRel = III
  
}
  c:obl_compl-> c:?Zl {
    c:dsyntRel = II
  
}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Yr {rc:<=> ?Yl}
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bubble = yes
  }
}
  ]
]

/*adv goes by default at the end of the sentence.

PATCH NOT: restrictives such as NOT should be marked in a lexicon

Should it be included within ENG? => no "adjunct"*/
SSynt<=>DMorph CA_EL_ES_FR_IT_PT_order_H_adjunct : CA_EL_ES_FR_IT_PT_order_H
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:adjunct-> c:?Yl {
    ¬c:slex = "no"
  }
  c:?r-> c:?Zl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

¬ ( ?r == adjunct & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b} )

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Zl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Yl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ~ rc:?Yr {
      rc:<=> ?Yl
      ¬rc:bubble = yes
  }
}
  ]
]

/*PMOD goes by default before all other dependencies.*/
SSynt<=>DMorph CA_EL_ES_FR_IT_PT_order_HV_pmod_patch : CA_EL_ES_FR_IT_PT_order_H
[
  leftside = [
c:?Xl {
  c:pos = "IN"
  c:prepos-> c:?Yl {
  }
  c:adjunct-> c:?Zl {
    c:pos = "NP"
  }
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Zl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Yl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Yr {rc:<=> ?Yl}
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bubble = yes
  }
  ¬rc:~ rc:?Xr {rc:<=> ?Xl}
  ~ rc:?Xr {
    rc:<=> ?Xl
    ¬rc:bubble = yes
  }
}
  ]
]

/*adv goes by default at the end of the sentence.
*/
SSynt<=>DMorph CA_EL_ES_FR_IT_PT_order_H_adv_main_verb_i : CA_EL_ES_FR_IT_PT_order_H
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:adv-> c:?Yl {
    ¬c:pos = "WRB"		//if an adverbial relative element is present, it goes first
  }
  c:?r-> c:?Zl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

//¬ ( ?Yl.straight_weight == "1.0" )  unclear this condition
¬ ( ?r == adv & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b} )
¬ ?r == adjunct
¬ ?r == coord

//¬ ( ?Yl.straight_weight == "1.0" & ¬ (?Xl.pos == "IN" | ?Xl.pos == "_") )
¬ ( ?Yl.straight_weight == "1.0" & ¬ (?Xl.pos == "IN" | ?Xl.pos == "_") & ¬?Yl.meaning == "locative_relation" & ¬?Yl.meaning == "point_time" )

// ?Xl is the root of the sentence
// don't remember why we splitted the main/non main verbs
//¬ c:?Gl{c:?s-> c:?Xl{}}

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Zl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Yl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Yr {rc:<=> ?Yl}
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bubble = yes
  }
}
  ]
]

/*adv goes by default at the end of the sentence.
*/
SSynt<=>DMorph CA_EL_ES_FR_IT_PT_order_H_adv_main_verb_ii : CA_EL_ES_FR_IT_PT_order_H
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:adv-> c:?Yl {
    ¬c:pos = "WRB"		//if an adverbial relative element is present, it goes first
  }
  c:?r-> c:?Zl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

//¬ ( ?Yl.straight_weight == "1.0" )  unclear this condition
¬ ( ?r == adv & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b} )
¬ ?r == adjunct
¬ ?r == coord

//¬ ( ?Yl.straight_weight == "1.0" & ¬ (?Xl.pos == "IN" | ?Xl.pos == "_") )
( ?Yl.straight_weight == "1.0" & ¬ (?Xl.pos == "IN" | ?Xl.pos == "_") & ¬?Yl.meaning == "locative_relation" & ¬?Yl.meaning == "point_time" )

// ?Xl is the root of the sentence
// don't remember why we splitted the main/non main verbs
//¬ c:?Gl{c:?s-> c:?Xl{}}

( ¬ ?r == subj
 | ( language.id.iso.EL & c:?Xl { c:dobj-> c:?Obj3 { ( c:pos = "PP" | c:pos = "WP" ) } } )
// In Italian negative existencial constructions, negation come before the subject ("ci")
// (see also rule CA_EL_ES_FR_IT_PT_order_H_adv_main_verb_ii )
 | ( language.id.iso.IT & ?Zl.slex == "ci" & ?Yl.slex == "non")
)
// ¬ ?r == aux_refl

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*adv goes by default at the end of the sentence.
*/
SSynt<=>DMorph CA_EL_ES_FR_IT_PT_order_H_dep : CA_EL_ES_FR_IT_PT_order_H
[
  leftside = [
c:?Xl {
  c:DEP-> c:?Yl {}
  c:?r-> c:?Zl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

¬ ( ?r == DEP & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b} )
¬ ?r == coord

¬?Zl.pos == "PP" //to avoid cycles when no DEP dependent has straight_weight (SPAtxt2corr_plan.1)
¬?Yl.pos == "PP" //for possessives, they should always be before the head; so, it should be necessary to order the posterior dependents

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Zl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Yl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Yr {rc:<=> ?Yl}
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bubble = yes
  }
}
  ]
]

/*adv goes by default at the end of the sentence.
*/
SSynt<=>DMorph CA_EL_ES_FR_IT_PT_order_H_coord : CA_EL_ES_FR_IT_PT_order_H
[
  leftside = [
c:?Xl {
  c:coord-> c:?Yl {}
  c:?r-> c:?Zl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

¬ ( ?r == coord & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b} )

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Zl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Yl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Yr {rc:<=> ?Yl}
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bubble = yes
  }
}
  ]
]

/*OBJ goes by default before all dependencies but the subject.*/
SSynt<=>DMorph CA_EL_ES_FR_IT_PT_order_H_obl_compl : CA_EL_ES_FR_IT_PT_order_H
[
  leftside = [
c:?Xl {
  ¬c:pos = "VB"
  c:obl_compl-> c:?Yl {}
  c:?r-> c:?Zl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

¬ ?r == det
¬ ?r == quant
¬ ?r == modif
¬(?r == obl_compl & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b})

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*SUBJ goes by default before all other dependencies.*/
SSynt<=>DMorph CA_EL_ES_FR_IT_PT_order_H_prepos : CA_EL_ES_FR_IT_PT_order_H
[
  leftside = [
c:?Xl {
  c:prepos-> c:?Yl {}
  c:?r-> c:?Zl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

¬(?r == prepos & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b})

// see order
¬ ( ?r == adjunct & ?Zl.pos == "NP")

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*SUBJ goes by default before all other dependencies.*/
excluded SSynt<=>DMorph CA_ES_FR_order_H_relpro : CA_EL_ES_FR_IT_PT_order_H
[
  leftside = [
c:?Xl {
  c:?s-> c:?Yl {
    c:spos = "relative_pronoun"
  }
  c:?r-> c:?Zl {}
}


( language.id.iso.CA | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT )

¬ (?r == adv & ?Zl.pos == "WRB")
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph CA_EL_ES_FR_IT_PT_order_H_NN : CA_EL_ES_FR_IT_PT_order_H
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

SSynt<=>DMorph CA_EL_ES_FR_IT_PT_order_H_VB : CA_EL_ES_FR_IT_PT_order_H
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*OBJ goes by default before all dependencies but the subject.*/
SSynt<=>DMorph PL_order_H_subj : PL_order_H
[
  leftside = [
c:?Xl {
  c:subj-> c:?Yl {}
  c:?r-> c:?Zl {}
}

language.id.iso.PL
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*OBJ goes by default before all dependencies but the subject.*/
SSynt<=>DMorph PL_order_H_refl : PL_order_H
[
  leftside = [
c:?Xl {
  c:refl-> c:?Yl {}
  c:?r-> c:?Zl {}
}

language.id.iso.PL

// reflexive pronoun goes immediately after the verb
¬ lexicon.test_map.?r.default.orderV.lin.PRE
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*adv goes by default at the end of the sentence.

PATCH NOT: restrictives such as NOT should be marked in a lexicon*/
SSynt<=>DMorph PL_order_H_adjunct : PL_order_H
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:adv-> c:?Yl {
    c:straight_weight = ?wy
    //¬c:slex = "not"
  }
  c:?r-> c:?Zl {
    c:straight_weight = ?wz
    }
}

language.id.iso.PL

// adv goes by default after the verb, so can't be before PRE elements
¬ lexicon.test_map.?r.default.orderV.lin.PRE

//¬ ( ?Yl.straight_weight == "1.0" )
//¬ ?r == refl
¬ ( ?r == adv & ?wy == ?wz)
¬ ( ?r == adv & ?wz > ?wy )
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Yr {rc:<=> ?Yl}
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bubble = yes
  }
}
  ]
]

/*adv goes by default at the end of the sentence.

PATCH NOT: restrictives such as NOT should be marked in a lexicon*/
SSynt<=>DMorph PL_order_H_2adjunct_same_weight : PL_order_H
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:adv-> c:?Yl {
    c:straight_weight = ?wy
    //¬c:slex = "not"
  }
  c:adv-> c:?Zl {
    c:straight_weight = ?wz
    }
}

language.id.iso.PL

?wy == ?wz

( ( ?wy == "1.0" & ?Zl.pos == "NN" ) | ( ?wy > "1.0" & ¬?Zl.pos == "NN" ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*adv goes by default at the end of the sentence.

PATCH NOT: restrictives such as NOT should be marked in a lexicon*/
SSynt<=>DMorph PL_order_H_obj_obj2 : PL_order_H
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:obj-> c:?Yl {
  }
  c:obj2-> c:?Zl {
    }
}

language.id.iso.PL
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*OBJ goes by default before all dependencies but the subject.*/
excluded SSynt<=>DMorph PL_order_H_obj : PL_order_H
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:obj-> c:?Yl {}
  c:?r-> c:?Zl {}
}

language.id.iso.PL

¬ lexicon.test_map.?r.default.orderV.lin.PRE
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*MAKE RULES WITH COORDINATE SUBJECTS!!!
See old MATE (agree_number, etc.)*/
SSynt<=>DMorph agree_verb_number : agreement_up
[
  leftside = [
c:?Xl {
  //c:pos = "VB"
  c:?r-> c:?Yl {
    ¬ ( c:slex = "I" | c:slex = "you" | c:slex = "we" | c:slex = "ktoś"
         | c:slex = "i" | c:slex = "You" | c:slex = "We" )
    c:number = ?p
  }
}

( ?r == SBJ | ?r == subj | ?r == SB )

//the subject is not a coordination
¬ ( language.id.iso.CA & ?p == "SG" & c:?Yl { c:coord-> c:?And5 { ( c:slex="i" | c:lex = "i_CC_01" ) } } )
¬ ( language.id.iso.EN & ?p == "SG" & c:?Yl { c:COORD-> c:?And1 { ( c:slex="and" | c:lex = "and_CC_01" ) } } )
¬ ( language.id.iso.IT & ?p == "SG" & c:?Yl { c:coord-> c:?And2 { ( c:slex="e" | c:lex = "e_CC_01" ) } } )
¬ ( language.id.iso.ES & ?p == "SG" & c:?Yl { c:coord-> c:?And3 { ( c:slex="y" | c:lex = "y_CC_01" ) } } )
¬ ( language.id.iso.FR & ?p == "SG" & c:?Yl { c:coord-> c:?And4 { ( c:slex="et" | c:lex = "et_CC_01" ) } } )
¬ ( language.id.iso.PT & ?p == "SG" & c:?Yl { c:coord-> c:?And6 { ( c:slex="e" | c:lex = "e_CC_01" ) } } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  number = ?p
}
  ]
]

/*MAKE RULES WITH COORDINATE SUBJECTS!!!
See old MATE (agree_number, etc.)*/
SSynt<=>DMorph agree_verb_number_I : agreement_up
[
  leftside = [
c:?Xl {
  //c:pos = "VB"
  c:?r-> c:?Yl {
    ( c:slex = "I" | c:slex = "i" | c:slex = "it" | c:slex = "he" | c:slex = "she" | c:slex = "this" | c:slex = "that" | c:slex = "It"
      | c:slex = "He" | c:slex = "She" | c:slex = "This" | c:slex = "That" | c:slex = "ktoś" | c:slex = "ty" | c:pos = "VB" )

  }
}

( ?r == SBJ | ?r == subj | ?r == SB )

//the subject is not a coordination
( ¬c:?Yl { c:COORD-> c:?And {c:slex="and"}} | ?Yl.pos == "VB" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  number = "SG"
}
  ]
]

/*MAKE RULES WITH COORDINATE SUBJECTS!!!
See old MATE (agree_number, etc.)*/
SSynt<=>DMorph agree_verb_number_I_thereBe : agreement_up
[
  leftside = [
c:?Xl {
  c:slex = "be"
  c:?r-> c:?Yl {
    c:slex = "there"
  }
  c:?s-> c:?Zl {
    c:number = ?p
  }
}

( ?r == SBJ | ?r == subj )
( ?s == OBJ | ?s == obj )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  number = ?p
}
  ]
]

/*MAKE RULES WITH COORDINATE SUBJECTS!!!
See old MATE (agree_number, etc.)*/
SSynt<=>DMorph agree_verb_number_you_we : agreement_up
[
  leftside = [
c:?Xl {
  //c:pos = "VB"
  c:?r-> c:?Yl {
    (c:slex = "you" | c:slex = "we" | c:slex = "they" | c:slex = "You" | c:slex = "We" | c:slex = "They")
  }
}

( ?r == SBJ | ?r == subj )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  number = "PL"
}
  ]
]

/*MAKE RULES WITH COORDINATE SUBJECTS!!!
See old MATE (agree_number, etc.)*/
SSynt<=>DMorph agree_verb_number_coord : agreement_up
[
  leftside = [
c:?Xl {
  //c:pos = "VB"
  c:?r-> c:?Yl {
    c:number = ?p
  }
}

( ?r == SBJ | ?r == subj )

//the subject is not a coordination
( (?p == "SG" | ( ?Yl.slex == "I" | ?Yl.slex == "it" | ?Yl.slex == "he" | ?Yl.slex == "she" | ?Yl.slex == "this" | ?Yl.slex == "that"
                        | ?Yl.slex == "i" | ?Yl.slex == "It" | ?Yl.slex == "He" | ?Yl.slex == "She" | ?Yl.slex == "This" | ?Yl.slex == "That"
) )
 & ( ( language.id.iso.EN & c:?Yl { c:COORD-> c:?And1 { ( c:slex="and" | c:lex = "and_CC_01" ) } } )
    | ( language.id.iso.IT & c:?Yl { c:coord-> c:?And2 { ( c:slex="e" | c:lex = "e_CC_01" ) } } )
    | ( language.id.iso.CA & c:?Yl { c:coord-> c:?And5 { ( c:slex="i" | c:lex = "i_CC_01" ) } } )
    | ( language.id.iso.ES & c:?Yl { c:coord-> c:?And3 { ( c:slex="y" | c:lex = "y_CC_01" ) } } )
    | ( language.id.iso.FR & c:?Yl { c:coord-> c:?And4 { ( c:slex="et" | c:lex = "et_CC_01" ) } } )
    | ( language.id.iso.PT & c:?Yl { c:coord-> c:?And6 { ( c:slex="e" | c:lex = "e_CC_01" ) } } )

  )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  number = "PL"
}
  ]
]

SSynt<=>DMorph agree_verb_number_no_subj : agreement_up
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:finiteness = "FIN" 
  ¬c:number = ?n
  ¬c:SBJ-> c:?S1l {}
  ¬c:SB-> c:?S2l {}
  ¬c:subj-> c:?S3l {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  number = "SG"
}
  ]
]

excluded SSynt<=>DMorph EN_agree_verb_number_no_subj : agreement_up
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:finiteness = "FIN" 
  ¬number = ?n
 // ¬c:person = ?p
  ¬c:SBJ-> c:?Sl{}
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  number = "SG"
}
  ]
]

/*MAKE RULES WITH COORDINATE SUBJECTS!!!
See old MATE (agree_number, etc.)*/
SSynt<=>DMorph agree_verb_person_1 : agreement_up
[
  leftside = [
c:?Xl {
  //c:pos = "VB"
  c:?r-> c:?Yl {
    ( c:slex = "I" | c:slex = "we" | c:slex = "We" | c:slex = "i")
  }
}

( ?r == SBJ | ?r == subj | ?r == SB )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  person = "1"
}
  ]
]

/*MAKE RULES WITH COORDINATE SUBJECTS!!!
See old MATE (agree_number, etc.)*/
SSynt<=>DMorph agree_verb_person_2 : agreement_up
[
  leftside = [
c:?Xl {
  //c:pos = "VB"
  c:?r-> c:?Yl {
   ( c:slex = "you" | c:slex = "You" | c:slex = "ty" | c:slex = "du" )
  }
}

( ?r == SBJ | ?r == subj | ?r == SB )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  person = "2"
}
  ]
]

/*MAKE RULES WITH COORDINATE SUBJECTS!!!
See old MATE (agree_number, etc.)*/
SSynt<=>DMorph agree_verb_person_3 : agreement_up
[
  leftside = [
c:?Xl {
  //c:pos = "VB"
  c:?r-> c:?Yl {
    ¬ ( c:slex = "I" | c:slex = "you" | c:slex = "we" | c:slex = "i"  | c:slex = "You" | c:slex = "We" | c:slex = "ty" | c:slex = "du")
  }
}

( ?r == SBJ | ?r == subj | ?r == SB )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  person = "3"
}
  ]
]

SSynt<=>DMorph agree_verb_person_no_subj : agreement_up
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:finiteness = "FIN" 
 // ¬c:number = ?n
  ¬person = ?p
  ¬c:SBJ-> c:?S1l {}
  ¬c:SB-> c:?S2l {}
  ¬c:subj-> c:?S3l {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  person = "3"
}
  ]
]

excluded SSynt<=>DMorph agree_verb_number_embedded_V_noSubj : agreement_up
[
  leftside = [
c:?Xl {
  //c:pos = "VB"
  c:?r-> c:?Yl {
    ¬ ( c:slex = "I" | c:slex = "you" | c:slex = "we" | c:slex = "ktoś" )
    c:number = ?p
  }
  c:?s-> c:?Prepl {
     c:pos = "IN"
     c:?t-> c:?Verbl {
      c:finiteness = "FIN"
      ¬c:subj-> c:?S1l {}
      ¬c:SUBJ-> c:?S2l {}
    }
  }
}

( ?r == SBJ | ?r == subj )

//the subject is not a coordination
¬ (?p == "SG" & c:?Yl { c:COORD-> c:?And {c:slex="and"}})
  ]
  mixed = [

  ]
  rightside = [
rc:?Vr {
  rc:<=> ?Verbl
  number = ?p
}
  ]
]

excluded SSynt<=>DMorph agree_verb_number_embedded_V_noSubj2 : agreement_up
[
  leftside = [
c:?Xl {
  //c:pos = "VB"
  c:?r-> c:?Yl {
    ¬ ( c:slex = "I" | c:slex = "you" | c:slex = "we" | c:slex = "ktoś" )
    c:number = ?p
  }
  c:obj-> c:?Objl {
    c:pos = "VB"
    c:?s-> c:?Prepl {
      c:pos = "IN"
      c:?t-> c:?Verbl {
        c:finiteness = "FIN"
        ¬c:subj-> c:?S1l {}
        ¬c:SUBJ-> c:?S2l {}
      }
    }
  }
}

( ?r == SBJ | ?r == subj )

//the subject is not a coordination
¬ (?p == "SG" & c:?Yl { c:COORD-> c:?And {c:slex="and"}})
  ]
  mixed = [

  ]
  rightside = [
rc:?Vr {
  rc:<=> ?Verbl
  number = ?p
}
  ]
]

excluded SSynt<=>DMorph agree_verb_person_3_embedded_V_noSubj : agreement_up
[
  leftside = [
c:?Xl {
  //c:pos = "VB"
  c:?r-> c:?Yl {
    ¬ ( c:slex = "I" | c:slex = "you" | c:slex = "we" | c:slex = "ktoś" )
  }
  c:?s-> c:?Prepl {
    c:pos = "IN"
    c:?t-> c:?Verbl {
      c:finiteness = "FIN"
      ¬c:subj-> c:?S1l {}
      ¬c:SUBJ-> c:?S2l {}
    }
  }
}

( ?r == SBJ | ?r == subj )
  ]
  mixed = [

  ]
  rightside = [
rc:?Vr {
  rc:<=> ?Verbl
  person = "3"
}
  ]
]

excluded SSynt<=>DMorph agree_verb_person_3_embedded_V_noSubj2 : agreement_up
[
  leftside = [
c:?Xl {
  //c:pos = "VB"
  c:?r-> c:?Yl {
    ¬ ( c:slex = "I" | c:slex = "you" | c:slex = "we" | c:slex = "ktoś" )
  }
  c:obj-> c:?Objl {
    c:pos = "VB"
    c:?s-> c:?Prepl {
      c:pos = "IN"
      c:?t-> c:?Verbl {
        c:finiteness = "FIN"
        ¬c:subj-> c:?S1l {}
        ¬c:SUBJ-> c:?S2l {}
      }
    }
  }
}

( ?r == SBJ | ?r == subj )
  ]
  mixed = [

  ]
  rightside = [
rc:?Vr {
  rc:<=> ?Verbl
  person = "3"
}
  ]
]

/*This rule should be in the previous ruleset...*/
excluded SSynt<=>DMorph agree_noun_number_PL : agreement_up
[
  leftside = [
c:?Xl{
  c:?r-> c:?Al{
  (c:slex = "multiple" | c:slex = "various" | c:slex = "several" | c:slex = "many" | c:slex = "few"
    | ( c:pos = "CD" & ( ¬ ( c:slex = "0" | c:slex = "1" ) | c:coord-> c:?CO {} ) ) )
  }
}

(?r == NMOD | ?r == det | ?r == modif | ?r == quant  | ?r == NK
 | (language.id.iso.PL & ?r == comp )
)

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

/*MAKE RULES WITH COORDINATE SUBJECTS!!!
See old MATE (agree_number, etc.)*/
excluded SSynt<=>DMorph PT_agree_noun_nenhum : agreement_up
[
  leftside = [
c:?Xl {
  c:pos = "NN"
  c:?r-> c:?Yl {
    ( c:slex = "nenhum" )
  }
}

language.id.iso.PT
( ?r == modif | ?r == modif_descr )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  number = "SG"
}
  ]
]

/*MAKE RULES WITH COORDINATE SUBJECTS!!!
See old MATE (agree_number, etc.)*/
SSynt<=>DMorph DE_agree_det_number_default : agreement_down
[
  leftside = [
c:?Xl {
  ¬c:number = ?p
  c:NK-> c:?Yl {
    c:pos = "DT"
  }
}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  // so rules that insert all attributes have applied already, and num is overwritten if necessary
  rc:pos = ?g
  number = "SG"
}
  ]
]

/*MAKE RULES WITH COORDINATE SUBJECTS!!!
See old MATE (agree_number, etc.)*/
SSynt<=>DMorph DE_agree_det_gender_default : agreement_down
[
  leftside = [
c:?Xl {
  ¬c:gender = ?p
  c:NK-> c:?Yl {
    c:pos = "DT"
  }
}

language.id.iso.DE
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  // so rules that insert all attributes have applied already, and num is overwritten if necessary
  rc:pos = ?g
  gender = "NEUTR"
}
  ]
]

/*Number of nouns can be changed on the RS (see agreement sibling number NOUN).*/
SSynt<=>DMorph agree_number_RightSide : agreement_down
[
  leftside = [
c:?Xl {
  c:?r-> c:?Yl {
    ( c:pos = "DT" | c:pos = "JJ" | c:finiteness = "PART" )
  }
}

( ?r == NMOD | ?r == det | ?r == modif )

¬ ( language.id.iso.EN & ?Yl.slex == "its" )

¬c:?Xl {
  (c:slex = "pourcentage" | c:slex = "porcentaje"
   | c:slex = "percentage")
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  rc:update_num_deps = "yes"
  rc:number = ?numRS
}

rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  rc:number = ?p
  number = ?numRS
}
  ]
]

/*MAKE RULES WITH COORDINATE SUBJECTS!!!
See old MATE (agree_number, etc.)
!!! We check the number on the RS so the number is percolated down in case of double determiner (e.g. catalan "la meva").*/
SSynt<=>DMorph agree_det_number : agreement_down
[
  leftside = [
c:?Xl {
  //c:number = ?p
  c:?r-> c:?Yl {
    //c:pos = "DT"
  }
}

( ( ( ?r == NMOD | ?r == det | ?r == NK ) & ?Yl.pos == "DT" )
 | ( ( language.id.iso.ES | language.id.iso.CA ) & ?r == obl_compl & ?Yl.pos == "WP" )
)

¬ ( language.id.iso.EN & ?Yl.slex == "its" )

¬c:?Xl {
  (c:slex = "pourcentage" | c:slex = "porcentaje"
   | c:slex = "percentage")
   } //with %, we always talk in singular
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  rc:number = ?p
}

rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  // so rules that insert all attributes have applied already, and num is overwritten if necessary
  rc:pos = ?g
  number = ?p
}
  ]
]

/*MAKE RULES WITH COORDINATE SUBJECTS!!!
See old MATE (agree_number, etc.)

!!! We check the gender on the RS so the number is percolated down in case of double determiner (e.g. catalan "la meva").*/
SSynt<=>DMorph agree_det_gender : agreement_down
[
  leftside = [
c:?Xl {
  //c:gender = ?p
  c:?r-> c:?Yl {
  // if the det is a pronoun
    //¬c:gender = ?g
    //c:pos = "DT"
  }
}

( ( ( ?r == NMOD | ?r == det | ?r == NK ) & ?Yl.pos == "DT" )
 | ( ( language.id.iso.ES | language.id.iso.CA | language.id.iso.PT ) & ?r == obl_compl & ?Yl.pos == "WP" )
)

// ( ?r == SBJ | ?r == det )
//( ?r == det | ?r == obl_obj | ?r == NK )

¬ ( language.id.iso.EN & ?Yl.slex == "its" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  rc:gender = ?p
}

rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  // so rules that insert all attributes have applied already, and num is overwritten if necessary
  rc:pos = ?g
  gender = ?p
}
  ]
]

/*MAKE RULES WITH COORDINATE SUBJECTS!!!
See old MATE (agree_number, etc.)*/
SSynt<=>DMorph agree_det_case : agreement_down
[
  leftside = [
c:?Xl {
  c:case = ?p
  c:?r-> c:?Yl {
    c:pos = "DT"
  }
}

( ( language.id.iso.DE & ?r == NK )
  | ( language.id.iso.EL & ?r == det )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  // so rules that insert all attributes have applied already, and num is overwritten if necessary
  rc:pos = ?g
  case = ?p
}
  ]
]

/*MAKE RULES WITH COORDINATE SUBJECTS!!!
See old MATE (agree_number, etc.)*/
SSynt<=>DMorph agree_adj_number : agreement_down
[
  leftside = [
c:?Xl {
  c:number = ?p
  c:?r-> c:?Yl {
    ( c:pos = "JJ" | c:finiteness = "PART" )
  }
}

(?r == modif | ?r == NMOD | ?r == NK)
( language.id.iso.ES | language.id.iso.CA | language.id.iso.FR | language.id.iso.PL | language.id.iso.DE
  | language.id.iso.IT | language.id.iso.EL | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  // so rules that insert all attributes have applied already, and num is overwritten if necessary
  rc:pos = ?g
  number = ?p
}
  ]
]

/*MAKE RULES WITH COORDINATE SUBJECTS!!!
See old MATE (agree_number, etc.)*/
SSynt<=>DMorph agree_adj_gender : agreement_down
[
  leftside = [
c:?Xl {
  c:gender = ?p
  c:?r-> c:?Yl {
    ( c:pos = "JJ" | c:finiteness = "PART" )
  }
}

(?r == modif | ?r == NMOD | ?r == NK)
( language.id.iso.ES | language.id.iso.CA | language.id.iso.FR | language.id.iso.PL | language.id.iso.DE
  | language.id.iso.IT | language.id.iso.EL | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  // so rules that insert all attributes have applied already, and num is overwritten if necessary
  rc:pos = ?g
  gender = ?p
}
  ]
]

/*MAKE RULES WITH COORDINATE SUBJECTS!!!
See old MATE (agree_number, etc.)*/
SSynt<=>DMorph agree_adj_case : agreement_down
[
  leftside = [
c:?Xl {
  c:case = ?p
  c:?r-> c:?Yl {
    ( c:pos = "JJ" | ( c:pos = "VB" c:finiteness = "PART" ) )
  }
}

( ?r == NMOD | ?r == NK | ?r == modif )
( language.id.iso.PL | language.id.iso.DE | language.id.iso.EL )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  // so rules that insert all attributes have applied already, and num is overwritten if necessary
  rc:pos = ?g
  case = ?p
}
  ]
]

/*MAKE RULES WITH COORDINATE SUBJECTS!!!
See old MATE (agree_number, etc.)*/
SSynt<=>DMorph agree_obl_number : agreement_down
[
  leftside = [
c:?Xl {
  c:number = ?p
  c:obl_compl-> c:?Yl {
    ( c:pos = "WP$" | c:pos = "PP" )
  }
}

( language.id.iso.ES | language.id.iso.CA | language.id.iso.FR | language.id.iso.PL | language.id.iso.DE
  | language.id.iso.IT | language.id.iso.EL | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  // so rules that insert all attributes have applied already, and num is overwritten if necessary
  rc:pos = ?g
  number = ?p
}
  ]
]

/*MAKE RULES WITH COORDINATE SUBJECTS!!!
See old MATE (agree_number, etc.)*/
SSynt<=>DMorph agree_obl_gender : agreement_down
[
  leftside = [
c:?Xl {
  c:gender = ?p
  c:obl_compl-> c:?Yl {
    ( c:pos = "WP$" | c:pos = "PP" )
  }
}

( language.id.iso.ES | language.id.iso.CA | language.id.iso.FR | language.id.iso.PL | language.id.iso.DE
  | language.id.iso.IT | language.id.iso.EL | language.id.iso.PT )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  // so rules that insert all attributes have applied already, and num is overwritten if necessary
  rc:pos = ?g
  gender = ?p
}
  ]
]

SSynt<=>DMorph mark_block_deps : ellipsis
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*If a verb V2 is repeated in a coordination, elide it, unless:
- the subject of V2 is the object of V1.*/
SSynt<=>DMorph mark_block_repeated_verb_coord : ellipsis
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:?coord-> c:?And {
    c:?conj-> c:?Yl {
      c:pos = "VB"
    }
  }
}


lexicon.miscellaneous.conjunction.coord_rel.?coord
lexicon.miscellaneous.conjunction.coord_conj_rel.?conj

// Don't apply to contrast ("while")
¬ ( c:?And { c:lex = ?lex } & lexicon.miscellaneous.conjunction.?c.?lex & ?c == "contrast" )

?Xl.slex == ?Yl.slex
?Xl.spos == ?Yl.spos
?Xl.finiteness == ?Yl.finiteness
( ?Xl.mood == ?Yl.mood | ( c:?Xl { ¬c:mood = ?moX } & c:?Yl { ¬c:mood = ?moY } ) )
( ?Xl.tense == ?Yl.tense | ( c:?Xl { ¬c:tense = ?teX } & c:?Yl { ¬c:tense = ?teY } ) )
// type captures if a verb is a support verb or not; not sure it's a good idea to check this
( ?Xl.type == ?Yl.type | ( c:?Xl { ¬c:type = ?tyX } & c:?Yl { ¬c:type = ?tyY } ) )
( ?Xl.meaning == ?Yl.meaning | ( c:?Xl { ¬c:meaning = ?meX } & c:?Yl { ¬c:meaning = ?meY } ) )
//( ?Xl.tem_constituency == ?Yl.tem_constituency
// | ( c:?Xl { ¬c:tem_constituency = ?tcX } & c:?Yl { ¬c:tem_constituency = ?tcY } ) )
//( ?Xl.voice == ?Yl.voice  | ( c:?Xl { ¬c:voice = ?vX } & c:?Yl { ¬c:voice = ?vY } ) )

// if the subject of V2 is the object of V1, don't elide, that's weird.
¬ ( c:?Xl { c:?r1-> c:?N1l {} } & c:?Yl { c:?r2-> c: ?N2l {} }
    & lexicon.dependencies_default_map.II.rel.?r1 & lexicon.dependencies_default_map.I.rel.?r2 
    & ( c:?N2l { c:<-> c:?N1l {} } | c:?N1l { c:<-> c:?N2l {} } | ( c:?N1l { c:<-> c:?Y0l {} } & c:?N2l { c:<-> c:?Y0l {} } ) ) )

// Only elide copulas (BE) if: (1) has 2 deps, (2) no dep has grand-daughters (one level of depth below the dep)
// maybe add more conditions; this is a simplification of a parallelism between the 2 VPs, which should be the condition to elide the BE.
¬ ( lexicon.miscellaneous.verbs.copula.?cop & ?cop == ?Xl.lex
    & ¬ ( ?Xl.straight_weight > 3 & ?Yl.straight_weight > 3 & ?Xl.num_deps > 2 & ?Yl.num_deps > 2 ) 
)
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:number = ?nX
  rc:person = ?pX
}

rc:?Yr {
  rc:<=> ?Yl
  rc:number = ?nY
  rc:person = ?pY
  blocked = "VP"
}

( ¬ ( rc:?Xr { rc:number = ?nX0 rc:person = ?pX0 } & rc:?Yr { rc:number = ?nY0 rc:person = ?pY0 } )
 |  ( rc:?Xr { rc:number = ?nX rc:person = ?pX } & rc:?Yr { rc:number = ?nY rc:person = ?pY } & ?nX == ?nY & ?pX == ?pY ) )
  ]
]

/*If a subject is repeated and is linearized on the right of the verb, remove first subject.*/
SSynt<=>DMorph mark_block_repeated_subj_right : ellipsis
[
  leftside = [
c:?Verb1 {
  c:subj-> c:?X1l {
    ¬c:?r1-> c:?Y1l {}
  }
  c:coord-> c:?And {
    c:coord_conj-> c:?Verb2 {
      c:subj-> c:?X2l {
        ¬c:?r2-> c:?Y2l {}
      }
    }
  }
}

( ?X1l.slex == ?X2l.slex | c:?X2l { c:<-> c:?X1l {} } | ( c:?X2l { c:<-> c:?X0l {} } & c:?X1l { c:<-> c:?X0l {} } ) )

//language.id.iso.ES
  ]
  mixed = [

  ]
  rightside = [
rc:?Verb1r {
  rc:<=> ?Verb1
  rc:~ rc:?X1r {
    rc:<=> ?X1l
    blocked = "subtree"
  }
}
  ]
]

/*If a subject is repeated and is linearized on the left of the verb, remove second subject.*/
SSynt<=>DMorph mark_block_repeated_subj_left : ellipsis
[
  leftside = [
c:?Verb1 {
  c:SBJ-> c:?X1l {
    ¬c:?r1-> c:?Y1l {}
  }
  c:COORD-> c:?And {
    c:CONJ-> c:?Verb2 {
      c:id = ?id
      c:SBJ-> c:?X2l {
        ¬c:?r2-> c:?Y2l {}
      }
    }
  }
}

( ?X1l.slex == ?X2l.slex | c:?X2l { c:<-> c:?X1l {} } | ( c:?X2l { c:<-> c:?X0l {} } & c:?X1l { c:<-> c:?X0l {} } ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?X2r {
  rc:<=> ?X2l
  blocked = "subtree"
  rc:~ rc:?Verb2r {
    rc:id = ?id
    //rc:<=> ?Verb2
  }
}
  ]
]

SSynt<=>DMorph mark_block_percolate_subtree : ellipsis
[
  leftside = [
c:?Xl {
  c:?r-> c:?Yl {} 
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:blocked = "subtree"
}
 
rc:?Yr {
  rc:<=> ?Yl
  blocked = "subtree"
}
  ]
]

SSynt<=>DMorph mark_block_percolate_VP : ellipsis
[
  leftside = [
c:?Xl {
  c:pos = "VB"
  c:?r-> c:?M1 {}
  c:?coord-> c:?And {
    c:?conj-> c:?Yl {
      c:pos = "VB"
      c:?s-> c:?M2 {}
    }
  }
}

lexicon.miscellaneous.conjunction.coord_rel.?coord
lexicon.miscellaneous.conjunction.coord_conj_rel.?conj

?M1.slex == ?M2.slex

// list here concerned dependencies; consider moving to dico
( ( language.id.iso.EN & ?r == VC & ?s == VC ) 
  | ( language.id.iso.ES & ?r == aux_refl & ?s == aux_refl )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  rc:blocked = "VP"
}
 
rc:?M2r {
  rc:<=> ?M2
  blocked = "VP"
}
  ]
]

/*Pronoun subject is dropped in Spanish*/
SSynt<=>DMorph CA_EL_ES_PT_mark_block_Pro_subj : ellipsis
[
  leftside = [
c:?gov {
  c:subj-> c:?node {
    pos = "PP"
    ( c:slex = "_PRO_" | c:slex = "_PRO-HUM_" )
  }
}

( language.id.iso.EL | language.id.iso.ES | language.id.iso.CA
// in Portuguese, only elide subjects that are not in the initial position in a sentence (simplified to pronominalised subjects of a main verb).
  | ( language.id.iso.PT & c:?GrandGov { c:?r-> c:?gov {} } )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?nodeR {
  rc:<=> ?node
  blocked = "unique"
}
  ]
]

/*These rules should apply in the second cluster, before the anaphora rules in the 3rd cluster.*/
SSynt<=>DMorph mark_ambiguous_antecedent : anaphora_resolution
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

SSynt<=>DMorph anaphora_attr : anaphora_resolution
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*Fuse this rule with anaphora_personal rules.*/
SSynt<=>DMorph anaphora_possessives_mark_human_NE : anaphora_resolution
[
  leftside = [
c:?Node1 {
  c:case = "GEN"
   //¬c:ambiguous_antecedent = "yes" 
  c:<-> c:?Node2 {
    ( c:NE = "YES" & c:class = "Person" )
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
¬ ( c:?Node2 { c:?t1-> c:?Verb1 {c:finiteness = "FIN" c:?r1-> c:?Node1 {}}} & ( lexicon.dependencies_default_map.ATTR.rel.?t1 | lexicon.dependencies_default_map.APPEND.rel.?t1 ) )
¬ ( c:?Node2 { c:?t2-> c:?Verb2 {c:finiteness = "FIN" c:?r2-> c:?MNode { c:?s2-> c:?Node1 {}}}} & ( lexicon.dependencies_default_map.ATTR.rel.?t2 | lexicon.dependencies_default_map.APPEND.rel.?t2 ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Node1R {
  rc:<=> ?Node1
  ¬rc:bubble = yes
  ¬rc:ambiguous_antecedent = "yes" 
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
SSynt<=>DMorph anaphora_possessives_mark_human_PRO : anaphora_resolution
[
  leftside = [
c:?Node1 {
  c:case = "GEN"
   //¬c:ambiguous_antecedent = "yes" 
  c:dlex = ?dN1
  c:<-> c:?Node2 {
    ( c:pos = "PRP" & c:class = "Person" )
  }
}

lexicon.miscellaneous.personal_pronouns.correspondences.?dN1.GEN.?det

// only if governor is a noun or a gerund
c:?Govl {
  c:?r-> c:?Node1 {}
  ( c:pos = "NN" | c:finiteness = "GER" )  
}

// exclude cases of relative clause
¬ ( c:?Node2 { c:?t1-> c:?Verb1 {c:finiteness = "FIN" c:?r1-> c:?Node1 {}}} & ( lexicon.dependencies_default_map.ATTR.rel.?t1 | lexicon.dependencies_default_map.APPEND.rel.?t1 ) )
¬ ( c:?Node2 { c:?t2-> c:?Verb2 {c:finiteness = "FIN" c:?r2-> c:?MNode { c:?s2-> c:?Node1 {}}}} & ( lexicon.dependencies_default_map.ATTR.rel.?t2 | lexicon.dependencies_default_map.APPEND.rel.?t2 ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Node1R {
  rc:<=> ?Node1
  ¬rc:bubble = yes
  ¬rc:ambiguous_antecedent = "yes" 
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
SSynt<=>DMorph anaphora_possessives_mark_non_human : anaphora_resolution
[
  leftside = [
c:?Node1 {
  c:case = "GEN"
   //¬c:ambiguous_antecedent = "yes" 
  c:<-> c:?Node2 {
    ¬( c:NE = "YES" & c:class = "Person" )
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
¬ ( c:?Node2 { c:?t1-> c:?Verb1 {c:finiteness = "FIN" c:?r1-> c:?Node1 {}}} & ( lexicon.dependencies_default_map.ATTR.rel.?t1 | lexicon.dependencies_default_map.APPEND.rel.?t1 ) )
¬ ( c:?Node2 { c:?t2-> c:?Verb2 {c:finiteness = "FIN" c:?r2-> c:?MNode { c:?s2-> c:?Node1 {}}}} & ( lexicon.dependencies_default_map.ATTR.rel.?t2 | lexicon.dependencies_default_map.APPEND.rel.?t2 ) )
  ]
  mixed = [

  ]
  rightside = [
rc:?Node1R {
  rc:<=> ?Node1
  ¬rc:bubble = yes
  ¬rc:ambiguous_antecedent = "yes" 
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

/*If the governor is a verb and the antecedent is just above, the dependent should be a relative pronoun.
This rule applies if the antecedent is the subject of the main verb in the previous sentence.
This rule should be completed by the Prep counterpart, and the block_dep_pronoun_gen rules in level 35 be changed accordingly.
WebNLG_test_triples5_es.conll Sent6, 170822a_known_input_multiple2.conll Sent251*/
SSynt<=>DMorph anaphora_personal_non_human_direct : anaphora_resolution
[
  leftside = [
c:?Sent1 {
  c:slex = "Sentence"
  c:?Root1 {
    c:?r-> c:?Ante {}
  }
  c:~ c:?Sent2 {
    c:slex = "Sentence"
    c:?Gov {
      ¬c:definiteness = "INDEF"
      ¬c:pos = "JJ"
      c:?a-> c:?Dep {
        //¬( c:NE = "YES" & c:class = "Person" )
        // only pronominalize if there is no dependent, or if subtree is the same
         ( ¬c:?dep-> c:?Depl {} | ¬c:subtree_coref = "different" )
        ¬c:pos = "WDT"
        ¬c:spos = personal_pronoun
        ¬c:spos = relative_pronoun
        //¬c:ambiguous_antecedent = "yes" 
        c:<-> c:?Ante {}
      }
    }
  }
}

// BUG? This kind of condition on the LS seems to create an explosion of combinations and the tansduction doesn't end.
//( ( ( ?r == SBJ | ?r == subj ) & ¬?a == PRD & ¬?a == copul & ¬?a == LGS & ¬?a == agent )
//        | ( ( ?r == PRD | ?r == OBJ | ?r == dobj | ?r == copul ) & ( ?a == OBJ | ?a == dobj ) )
//)
( ( lexicon.miscellaneous.subject.rel.?r & ¬?a == PRD & ¬?a == copul & ¬?a == LGS & ¬?a == agent )
  | ( lexicon.dependencies_default_map.II.rel.?r & lexicon.miscellaneous.direct_object.rel.?a )
)

¬language.id.iso.EL
// Seems to be a BUG when this condition is here!!! See en_genInputs str 136
//¬project_info.project.pronominalize.no

¬c:?Ante {c:NE = "YES" c:class = "Person" }
¬c:?Dep {c:NE = "YES" c:class = "Person" }

//if the relative pronoun is already inserted, it's not necessary the lemma transformation. TEST this with KRISTINA
¬?Dep.lemma == "that"

// ?Root1 is a root
¬c:?Grandma1 { c:?rel1-> c:?Root1 {} }

¬ ( lexicon.miscellaneous.conjunction.coord_rel.?CREL1 & c:?Dep { c:?CREL1-> c:?Conj2 {} } )
¬ ( lexicon.miscellaneous.conjunction.coord_rel.?CREL2 & c:?Ante { c:?CREL2-> c:?Conj3 {} } )

// See anaphoraSameLoc; this condition may be very simplistic
¬ ( ?Dep.class == "Location" )
¬ ( ?Dep.SameLocAsPrevious == "YES" )

// In this case, we introduce a possessive pronoun
¬ ( c:?Gov { c:slex = ?slG } & ?Dep { c:case = "GEN" } & lexicon.miscellaneous.case_prep.GEN.lex.?slG )
  ]
  mixed = [
¬project_info.project.pronominalize.no
  ]
  rightside = [
rc:?DepR {
  rc:<=> ?Dep
  ¬rc:bubble = yes
  ¬rc:ambiguous_antecedent = "yes" 
  //( ¬ ( rc:top = yes & rc:pos = "IN" ) | rc:slex = "of" )
  ¬rc:pronominalized = yes
  rc:slex = ?slex
  rc:pos = ?posDep
  rc:spos = ?sposDep
  slex = "_PRO_"
  pos = "PP"
  spos = personal_pronoun
  pronominalized = yes
}


//( rc:?Root1R {
//  rc:<=> ?Root1
//  rc:?SBJ-> rc:?AnteR {
//    rc:<=> ?Ante
//  }
//}
// & ( ( ( ?SBJ == SBJ | ?SBJ == subj ) & ¬?R == PRD & ¬?R == copul & ¬?R == LGS & ¬?R == agent )
//        | ( ( ?SBJ == PRD | ?SBJ == OBJ | ?SBJ == dobj | ?SBJ == copul )
        // removed copul & PRD
//             & ( ?R == OBJ | ?R == dobj ) )
//     )
//)
  ]
]

/*If we have an noun with a definite determiner and a prepositional group headed by the genitive preposition,
  the dependent of the preposition is pronominalised as a possessive pronoun, instead of the definite determiner.*/
SSynt<=>DMorph anaphora_personal_non_human_direct_prepGen : anaphora_resolution
[
  leftside = [
c:?Sent1 {
  c:slex = "Sentence"
  c:?Root1 {
    c:?r-> c:?Ante {}
  }
  c:~ c:?Sent2 {
    c:slex = "Sentence"
    c:?Noun {
      c:definiteness = "DEF"
      c:?d1-> c:?Gov {
        c:slex = ?slG
        c:?a-> c:?Dep {
          c:case = "GEN"
          //¬( c:NE = "YES" & c:class = "Person" )
          // only pronominalize if there is no dependent, or if subtree is the same
           ( ¬c:?dep-> c:?Depl {} | ¬c:subtree_coref = "different" )
          ¬c:pos = "WDT"
          ¬c:spos = personal_pronoun
          ¬c:spos = relative_pronoun
          //¬c:ambiguous_antecedent = "yes" 
          c:<-> c:?Ante {}
        }
      }
      c:?d2-> c:?Det {
        c:pos = "DT"
        c:slex = ?slexDT
      }
    }
  }
}

// BUG? This kind of condition on the LS seems to create an explosion of combinations and the tansduction doesn't end.
//( ( ( ?r == SBJ | ?r == subj ) & ¬?a == PRD & ¬?a == copul & ¬?a == LGS & ¬?a == agent )
//        | ( ( ?r == PRD | ?r == OBJ | ?r == dobj | ?r == copul ) & ( ?a == OBJ | ?a == dobj ) )
//)
( ( lexicon.miscellaneous.subject.rel.?r & ¬?a == PRD & ¬?a == copul & ¬?a == LGS & ¬?a == agent )
  | ( lexicon.dependencies_default_map.II.rel.?r & lexicon.miscellaneous.direct_object.rel.?a )
)

¬language.id.iso.EL
// Seems to be a BUG when this condition is here!!! See en_genInputs str 136
//¬project_info.project.pronominalize.no
lexicon.miscellaneous.case_prep.GEN.lex.?slG
( lexicon.miscellaneous.determiners.?def.?lexDT & ?def == "DEF" & lexicon.?lexDT.lemma.?lemDT & ?lemDT == ?slexDT )

¬c:?Ante {c:NE = "YES" c:class = "Person" }
¬c:?Dep {c:NE = "YES" c:class = "Person" }

//if the relative pronoun is already inserted, it's not necessary the lemma transformation. TEST this with KRISTINA
¬?Dep.lemma == "that"

// ?Root1 is a root
¬c:?Grandma1 { c:?rel1-> c:?Root1 {} }

¬ ( lexicon.miscellaneous.conjunction.coord_rel.?CREL1 & c:?Dep { c:?CREL1-> c:?Conj2 {} } )
¬ ( lexicon.miscellaneous.conjunction.coord_rel.?CREL2 & c:?Ante { c:?CREL2-> c:?Conj3 {} } )

// See anaphoraSameLoc; this condition may be very simplistic
¬ ( ?Dep.class == "Location" )
¬ ( ?Dep.SameLocAsPrevious == "YES" )
  ]
  mixed = [
¬project_info.project.pronominalize.no
  ]
  rightside = [
// Sould it really be Det here, and not Dep? Check this.
rc:?DetR {
  rc:<=> ?Det
  ¬rc:bubble = yes
  //( ¬ ( rc:top = yes & rc:pos = "IN" ) | rc:slex = "of" )
  ¬rc:pronominalized = yes
  rc:slex = ?slex
  rc:pos = ?posDep
  rc:spos = ?sposDep
  slex = "_PRO_"
  pos = "PP"
  spos = personal_pronoun
  pronominalized = yes
  person = ?Ante.person
}


rc:?DepR {
  rc:<=> ?Dep
  ¬rc:ambiguous_antecedent = "yes"
}

rc:?GovR {
  rc:<=> ?Gov
  ¬rc:bubble = yes
  blocked = "subtree"
}
  ]
]

/*In Greek, it looks better if we maintain the ambiguity rather than repeating a subject/object.*/
SSynt<=>DMorph EL_anaphora_personal_non_human_direct : anaphora_resolution
[
  leftside = [
c:?Sent1 {
  c:slex = "Sentence"
  c:?Root1 {
    c:?r-> c:?Ante {}
  }
  c:~ c:?Sent2 {
    c:slex = "Sentence"
    c:?Gov {
      ¬c:definiteness = "INDEF"
      ¬c:pos = "JJ"
      c:?a-> c:?Dep {
        //¬( c:NE = "YES" & c:class = "Person" )
        // only pronominalize if there is no dependent, or if subtree is the same
         ( ¬c:?dep-> c:?Depl {} | ¬c:subtree_coref = "different" )
        ¬c:pos = "WDT"
        ¬c:spos = personal_pronoun
        ¬c:spos = relative_pronoun
        //¬c:ambiguous_antecedent = "yes" 
        c:<-> c:?Ante {}
      }
    }
  }
}

language.id.iso.EL
¬project_info.project.pronominalize.no

( ( ?r == subj | ?r == dobj | ?r == copul )
 & ( ?a == subj | ?a == dobj | ?a == copul )
)

¬c:?Ante {c:NE = "YES" c:class = "Person" }
¬c:?Dep {c:NE = "YES" c:class = "Person" }

// ?Root1 is a root
¬c:?Grandma1 { c:?rel1-> c:?Root1 {} }

¬ ( lexicon.miscellaneous.conjunction.coord_rel.?CREL1 & c:?Dep { c:?CREL1-> c:?Conj2 {} } )
¬ ( lexicon.miscellaneous.conjunction.coord_rel.?CREL2 & c:?Ante { c:?CREL2-> c:?Conj3 {} } )

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
rc:?DepR {
  rc:<=> ?Dep
  ¬rc:bubble = yes
  ¬rc:ambiguous_antecedent = "yes"
  ¬rc:pronominalized = yes
  rc:slex = ?slex
  rc:pos = ?posDep
  rc:spos = ?sposDep
  slex = "_PRO_"
  pos = "PP"
  spos = personal_pronoun
  pronominalized = yes
}


//( rc:?Root1R {
//  rc:<=> ?Root1
//  rc:?SBJ-> rc:?AnteR {
//    rc:<=> ?Ante
//  }
//}
// & ( ?SBJ == subj | ?SBJ == dobj | ?SBJ == copul )
// & ( ?R == subj | ?R == dobj | ?R == copul )
//)
  ]
]

/*If the governor is a verb and the antecedent is just above, the dependent should be a relative pronoun.
This rule applies if the subject of the preceding sentence points to the same node as ?Dep.
This rule should be completed by the Prep counterpart, and the block_dep_pronoun_gen rules in level 35 be changed accordingly.
WebNLG_test_triples5_es.conll Sent6, 170822a_known_input_multiple2.conll Sent251*/
SSynt<=>DMorph anaphora_personal_non_human_indirect : anaphora_resolution
[
  leftside = [
c:?Sent1 {
  c:slex = "Sentence"
  c:?Root1 {
    c:?r-> c:?OtherNode {
      c:<-> c:?Ante {}
    }
  }
  c:~ c:?Sent2 {
    c:slex = "Sentence"
    c:?Gov {
      ¬c:definiteness = "INDEF"
      c:?a-> c:?Dep {
        //¬( c:NE = "YES" & c:class = "Person" )
        // only pronominalize if there is no dependent, or if subtree is the same
         ( ¬c:?dep-> c:?Depl {} | ¬c:subtree_coref = "different" )
        ¬c:pos = "WDT"
        ¬c:spos = personal_pronoun
        ¬c:spos = relative_pronoun
        //¬c:ambiguous_antecedent = "yes" 
        c:<-> c:?Ante {}
      }
    }
  }
}

¬language.id.iso.EL
//¬project_info.project.pronominalize.no

// BUG: this kind of condition on the LS seems to create an explosion of combinations and the tansduction doesn't end.
//( ( ( ?r == SBJ | ?r == subj ) & ¬?a == PRD & ¬?a == copul & ¬?a == LGS & ¬?a == agent )
//        | ( ( ?r == PRD | ?r == OBJ | ?r == dobj | ?r == copul ) & ( ?a == OBJ | ?a == dobj ) )
//)
( ( lexicon.miscellaneous.subject.rel.?r & ¬?a == PRD & ¬?a == copul & ¬?a == LGS & ¬?a == agent )
  | ( lexicon.dependencies_default_map.II.rel.?r & lexicon.miscellaneous.direct_object.rel.?a )
)

¬c:?Ante {c:NE = "YES" c:class = "Person" }
¬c:?Dep {c:NE = "YES" c:class = "Person" }

//if the relative pronoun is already inserted, it's not necessary the lemma transformation. TEST this with KRISTINA
¬?Dep.lemma == "that"

// ?Root1 is a root
¬c:?Grandma1 { c:?rel1-> c:?Root1 {} }

¬ ( lexicon.miscellaneous.conjunction.coord_rel.?CREL1 & c:?Dep { c:?CREL1-> c:?Conj2 {} } )
¬ ( lexicon.miscellaneous.conjunction.coord_rel.?CREL2 & c:?Ante { c:?CREL2-> c:?Conj3 {} } )

// In this case, we introduce a possessive pronoun
¬ ( c:?Gov { c:slex = ?slG } & ?Dep { c:case = "GEN" } & lexicon.miscellaneous.case_prep.GEN.lex.?slG )
  ]
  mixed = [
¬project_info.project.pronominalize.no

//rc:?DepR { rc:<=>?Dep }

//( ¬ ( ?DepR.top == yes & ?DepR.pos == "IN" )
//  | ( language.id.iso.EN & ?DepR.slex == "of" )
//  | ( language.id.iso.ES & ?DepR.slex == "de" )
//)


//NOT IN LEXICON YET
//lexicon.?ppro.lemma.?lem
//lexicon.?ppro.pos.?pos
//lexicon.?ppro.spos.?spos
// doesn't work without the following condition:
//(?R == SBJ | ?R == OBJ)
  ]
  rightside = [
rc:?DepR {
  rc:<=> ?Dep
  ¬rc:bubble = yes
  ¬rc:ambiguous_antecedent = "yes"
  // ( ¬ ( rc:top = yes & rc:pos = "IN" ) | rc:slex = "of" )
  ¬rc:pronominalized = yes
  rc:slex = ?slex
  rc:pos = ?posDep
  rc:spos = ?sposDep
  slex = "_PRO_"
  pos = "PP"
  spos = personal_pronoun
  pronominalized = yes
}
  ]
]

/*Not tested yet.*/
SSynt<=>DMorph anaphora_personal_non_human_indirect_prepGen : anaphora_resolution
[
  leftside = [
c:?Sent1 {
  c:slex = "Sentence"
  c:?Root1 {
    c:?r-> c:?OtherNode {
      c:<-> c:?Ante {}
    }
  }
  c:~ c:?Sent2 {
    c:slex = "Sentence"
    c:?Noun {
      c:definiteness = "DEF"
      c:?d1-> c:?Gov {
        c:slex = ?slG
        c:?a-> c:?Dep {
          c:case = "GEN"
          //¬( c:NE = "YES" & c:class = "Person" )
          // only pronominalize if there is no dependent, or if subtree is the same
           ( ¬c:?dep-> c:?Depl {} | ¬c:subtree_coref = "different" )
          ¬c:pos = "WDT"
          ¬c:spos = personal_pronoun
          ¬c:spos = relative_pronoun
         //¬c:ambiguous_antecedent = "yes" 
          c:<-> c:?Ante {}
        }
      }
      c:?d2-> c:?Det {
        c:pos = "DT"
        c:slex = ?slexDT
      }
    }
  }
}

// BUG? This kind of condition on the LS seems to create an explosion of combinations and the tansduction doesn't end.
//( ( ( ?r == SBJ | ?r == subj ) & ¬?a == PRD & ¬?a == copul & ¬?a == LGS & ¬?a == agent )
//        | ( ( ?r == PRD | ?r == OBJ | ?r == dobj | ?r == copul ) & ( ?a == OBJ | ?a == dobj ) )
//)
( ( lexicon.miscellaneous.subject.rel.?r & ¬?a == PRD & ¬?a == copul & ¬?a == LGS & ¬?a == agent )
  | ( lexicon.dependencies_default_map.II.rel.?r & lexicon.miscellaneous.direct_object.rel.?a )
)

¬language.id.iso.EL
// Seems to be a BUG when this condition is here!!! See en_genInputs str 136
//¬project_info.project.pronominalize.no
lexicon.miscellaneous.case_prep.GEN.lex.?slG
( lexicon.miscellaneous.determiners.?def.?lexDT & ?def == "DEF" & lexicon.?lexDT.lemma.?lemDT & ?lemDT == ?slexDT )

¬c:?Ante {c:NE = "YES" c:class = "Person" }
¬c:?Dep {c:NE = "YES" c:class = "Person" }

//if the relative pronoun is already inserted, it's not necessary the lemma transformation. TEST this with KRISTINA
¬?Dep.lemma == "that"

// ?Root1 is a root
¬c:?Grandma1 { c:?rel1-> c:?Root1 {} }

¬ ( lexicon.miscellaneous.conjunction.coord_rel.?CREL1 & c:?Dep { c:?CREL1-> c:?Conj2 {} } )
¬ ( lexicon.miscellaneous.conjunction.coord_rel.?CREL2 & c:?Ante { c:?CREL2-> c:?Conj3 {} } )

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
rc:?DetR {
  rc:<=> ?Det
  ¬rc:bubble = yes
  //( ¬ ( rc:top = yes & rc:pos = "IN" ) | rc:slex = "of" )
  ¬rc:pronominalized = yes
  rc:slex = ?slex
  rc:pos = ?posDep
  rc:spos = ?sposDep
  slex = "_PRO_"
  pos = "PP"
  spos = personal_pronoun
  pronominalized = yes
  person = ?Ante.person
}

rc:?DepR {
  rc:<=> ?Dep
  ¬rc:ambiguous_antecedent = "yes"
}

rc:?GovR {
  rc:<=> ?Gov
  ¬rc:bubble = yes
  blocked = "subtree"
}
  ]
]

/*If the governor is a verb and the antecedent is just above, the dependent should be a relative pronoun.
This rule applies if the subject of the preceding sentence points to the same node as ?Dep.
This rule should be completed by the Prep counterpart, and the block_dep_pronoun_gen rules in level 35 be changed accordingly.
WebNLG_test_triples5_es.conll Sent6, 170822a_known_input_multiple2.conll Sent251*/
SSynt<=>DMorph EL_anaphora_personal_non_human_indirect : anaphora_resolution
[
  leftside = [
c:?Sent1 {
  c:slex = "Sentence"
  c:?Root1 {
    c:?r-> c:?OtherNode {
      c:<-> c:?Ante {}
    }
  }
  c:~ c:?Sent2 {
    c:slex = "Sentence"
    c:?Gov {
      ¬c:definiteness = "INDEF"
      c:?a-> c:?Dep {
        //¬( c:NE = "YES" & c:class = "Person" )
        // only pronominalize if there is no dependent, or if subtree is the same
         ( ¬c:?dep-> c:?Depl {} | ¬c:subtree_coref = "different" )
        ¬c:pos = "WDT"
        ¬c:spos = personal_pronoun
        ¬c:spos = relative_pronoun
        //¬c:ambiguous_antecedent = "yes" 
        c:<-> c:?Ante {}
      }
    }
  }
}

language.id.iso.EL
¬project_info.project.pronominalize.no

( ( ?r == subj | ?r == dobj | ?r == copul )
 & ( ?a == subj | ?a == dobj | ?a == copul )
)

¬c:?Ante {c:NE = "YES" c:class = "Person" }
¬c:?Dep {c:NE = "YES" c:class = "Person" }

//if the relative pronoun is already inserted, it's not necessary the lemma transformation. TEST this with KRISTINA
¬?Dep.lemma == "that"

// ?Root1 is a root
¬c:?Grandma1 { c:?rel1-> c:?Root1 {} }

¬ ( lexicon.miscellaneous.conjunction.coord_rel.?CREL1 & c:?Dep { c:?CREL1-> c:?Conj2 {} } )
¬ ( lexicon.miscellaneous.conjunction.coord_rel.?CREL2 & c:?Ante { c:?CREL2-> c:?Conj3 {} } )
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
rc:?DepR {
  rc:<=> ?Dep
  ¬rc:bubble = yes
  ¬rc:ambiguous_antecedent = "yes"
  ¬rc:pronominalized = yes
  rc:slex = ?slex
  rc:pos = ?posDep
  rc:spos = ?sposDep
  slex = "_PRO_"
  pos = "PP"
  spos = personal_pronoun
  pronominalized = yes
}
  ]
]

/*This rule applies if the antecedent is the subect of the main verb in the previous sentence.
Applies if there is only one node to pronominalize.
This rule should be completed by the Prep counterpart, and the block_dep_pronoun_gen rules in level 35 be changed accordingly.
WebNLG_test_triples5_es.conll Sent6, 170822a_known_input_multiple2.conll Sent251*/
SSynt<=>DMorph anaphora_personal_human_direct : anaphora_resolution
[
  leftside = [
c:?Sent1 {
  c:slex = "Sentence"
  c:?Root1 {
    c:?r-> c:?Ante {}
  }
  c:~ c:?Sent2 {
    c:slex = "Sentence"
    c:?Gov {
      c:?a-> c:?Dep {
        //( c:NE = "YES" & c:class = "Person" )
        // only pronominalize if there is no dependent, or if subtree is the same
         ( ¬c:?dep-> c:?Depl {} | ¬c:subtree_coref = "different" )
        ¬c:pos = "WDT"
        ¬c:spos = personal_pronoun
        ¬c:spos = relative_pronoun
        //¬c:ambiguous_antecedent = "yes" 
        c:<-> c:?Ante {}
      }
    }
  }
}

¬language.id.iso.EL
¬project_info.project.pronominalize.no

// BUG: this kind of condition on the LS seems to create an explosion of combinations and the tansduction doesn't end.
//( ( ( ?r == SBJ | ?r == subj ) & ¬?a == PRD & ¬?a == copul & ¬?a == LGS & ¬?a == agent )
//        | ( ( ?r == PRD | ?r == OBJ | ?r == dobj | ?r == copul ) & ( ?a == OBJ | ?a == dobj ) )
//)
( ( lexicon.miscellaneous.subject.rel.?r & ¬?a == PRD & ¬?a == copul & ¬?a == LGS & ¬?a == agent )
  | ( lexicon.dependencies_default_map.II.rel.?r & lexicon.miscellaneous.direct_object.rel.?a )
)

( c:?Ante {c:NE = "YES" c:class = "Person" }
 | c:?Dep {c:NE = "YES" c:class = "Person" } )

// see anaphora possessive
¬ ( c:?Gov { ( c:pos = "NN" | c:finiteness = "GER" ) }  & c:?Dep { c:case = "GEN" } )

// ?Root1 is a root
¬c:?Grandma1 { c:?rel1-> c:?Root1 {} }

¬ ( lexicon.miscellaneous.conjunction.coord_rel.?CREL1 & c:?Dep { c:?CREL1-> c:?Conj2 {} } )
¬ ( lexicon.miscellaneous.conjunction.coord_rel.?CREL2 & c:?Ante { c:?CREL2-> c:?Conj3 {} } )
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
rc:?DepR {
  rc:<=> ?Dep
  ¬rc:bubble = yes
  ¬rc:ambiguous_antecedent = "yes"
  ( ¬ ( rc:top = yes & rc:pos = "IN" ) | rc:slex = "of" )
  ¬rc:pronominalized = yes
  rc:slex = ?slex
  rc:pos = ?posDep
  rc:spos = ?sposDep
  slex = "_PRO-HUM_"
  pos = "PP"
  spos = personal_pronoun
  //gender = ?Ante.gender
  //number = ?Ante.number
  pronominalized = yes
}
  ]
]

/*This rule applies if the antecedent is the subect of the main verb in the previous sentence.
Applies if there is only one node to pronominalize.
This rule should be completed by the Prep counterpart, and the block_dep_pronoun_gen rules in level 35 be changed accordingly.
WebNLG_test_triples5_es.conll Sent6, 170822a_known_input_multiple2.conll Sent251*/
SSynt<=>DMorph EL_anaphora_personal_human_direct : anaphora_resolution
[
  leftside = [
c:?Sent1 {
  c:slex = "Sentence"
  c:?Root1 {
    c:?r-> c:?Ante {}
  }
  c:~ c:?Sent2 {
    c:slex = "Sentence"
    c:?Gov {
      c:?a-> c:?Dep {
        //( c:NE = "YES" & c:class = "Person" )
        // only pronominalize if there is no dependent, or if subtree is the same
         ( ¬c:?dep-> c:?Depl {} | ¬c:subtree_coref = "different" )
        ¬c:pos = "WDT"
        ¬c:spos = personal_pronoun
        ¬c:spos = relative_pronoun
        //¬c:ambiguous_antecedent = "yes" 
        c:<-> c:?Ante {}
      }
    }
  }
}

language.id.iso.EL
¬project_info.project.pronominalize.no

( ( ?r == subj | ?r == dobj | ?r == copul )
 & ( ?a == subj | ?a == dobj | ?a == copul )
)

( c:?Ante {c:NE = "YES" c:class = "Person" }
 | c:?Dep {c:NE = "YES" c:class = "Person" } )

// see anaphora possessive
¬ ( c:?Gov { ( c:pos = "NN" | c:finiteness = "GER" ) }  & c:?Dep { c:case = "GEN" } )

// ?Root1 is a root
¬c:?Grandma1 { c:?rel1-> c:?Root1 {} }

¬ ( lexicon.miscellaneous.conjunction.coord_rel.?CREL1 & c:?Dep { c:?CREL1-> c:?Conj2 {} } )
¬ ( lexicon.miscellaneous.conjunction.coord_rel.?CREL2 & c:?Ante { c:?CREL2-> c:?Conj3 {} } )
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
rc:?DepR {
  rc:<=> ?Dep
  ¬rc:bubble = yes
  ¬rc:ambiguous_antecedent = "yes"
  ¬rc:pronominalized = yes
  rc:slex = ?slex
  rc:pos = ?posDep
  rc:spos = ?sposDep
  slex = "_PRO-HUM_"
  pos = "PP"
  spos = personal_pronoun
  //gender = ?Ante.gender
  //number = ?Ante.number
  pronominalized = yes
}
  ]
]

/*This rule applies if the subject of the preceding sentence points to the same node as ?Dep.
This rule should be completed by the Prep counterpart, and the block_dep_pronoun_gen rules in level 35 be changed accordingly.
WebNLG_test_triples5_es.conll Sent6, 170822a_known_input_multiple2.conll Sent251*/
SSynt<=>DMorph anaphora_personal_human_indirect : anaphora_resolution
[
  leftside = [
c:?Sent1 {
  c:slex = "Sentence"
  c:?Root1 {
    c:?r-> c:?OtherNode {
      c:<-> c:?Ante {}
    }
  }
  c:~ c:?Sent2 {
    c:slex = "Sentence"
    c:?Gov {
      c:?a-> c:?Dep {
        //( c:NE = "YES" & c:class = "Person" )
        // only pronominalize if there is no dependent, or if subtree is the same
         ( ¬c:?dep-> c:?Depl {} | ¬c:subtree_coref = "different" )
        ¬c:pos = "WDT"
        ¬c:spos = personal_pronoun
        ¬c:spos = relative_pronoun
        //¬c:ambiguous_antecedent = "yes" 
        c:<-> c:?Ante {}
      }
    }
  }
}

¬language.id.iso.EL
¬project_info.project.pronominalize.no

// BUG: this kind of condition on the LS seems to create an explosion of combinations and the tansduction doesn't end.
//( ( ( ?r == SBJ | ?r == subj ) & ¬?a == PRD & ¬?a == copul & ¬?a == LGS & ¬?a == agent )
//        | ( ( ?r == PRD | ?r == OBJ | ?r == dobj | ?r == copul ) & ( ?a == OBJ | ?a == dobj ) )
//)
( ( lexicon.miscellaneous.subject.rel.?r & ¬?a == PRD & ¬?a == copul & ¬?a == LGS & ¬?a == agent )
  | ( lexicon.dependencies_default_map.II.rel.?r & lexicon.miscellaneous.direct_object.rel.?a )
)

( c:?Ante {c:NE = "YES" c:class = "Person" }
 | c:?Dep {c:NE = "YES" c:class = "Person" } )

// see anaphora possessive
¬ ( c:?Gov { ( c:pos = "NN" | c:finiteness = "GER" ) }  & c:?Dep { c:case = "GEN" } )

// ?Root1 is a root
¬c:?Grandma1 { c:?rel1-> c:?Root1 {} }

¬ ( lexicon.miscellaneous.conjunction.coord_rel.?CREL1 & c:?Dep { c:?CREL1-> c:?Conj2 {} } )
¬ ( lexicon.miscellaneous.conjunction.coord_rel.?CREL2 & c:?Ante { c:?CREL2-> c:?Conj3 {} } )
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
rc:?DepR {
  rc:<=> ?Dep
  ¬rc:bubble = yes
  ¬rc:ambiguous_antecedent = "yes"
  ( ¬ ( rc:top = yes & rc:pos = "IN" ) | rc:slex = "of" )
  ¬rc:pronominalized = yes
  rc:slex = ?slex
  rc:pos = ?posDep
  rc:spos = ?sposDep
  slex = "_PRO-HUM_"
  pos = "PP"
  spos = personal_pronoun
  //gender = ?Ante.gender
  //number = ?Ante.number
  pronominalized = yes
}
  ]
]

/*This rule applies if the subject of the preceding sentence points to the same node as ?Dep.
This rule should be completed by the Prep counterpart, and the block_dep_pronoun_gen rules in level 35 be changed accordingly.
WebNLG_test_triples5_es.conll Sent6, 170822a_known_input_multiple2.conll Sent251*/
SSynt<=>DMorph EL_anaphora_personal_human_indirect : anaphora_resolution
[
  leftside = [
c:?Sent1 {
  c:slex = "Sentence"
  c:?Root1 {
    c:?r-> c:?OtherNode {
      c:<-> c:?Ante {}
    }
  }
  c:~ c:?Sent2 {
    c:slex = "Sentence"
    c:?Gov {
      c:?a-> c:?Dep {
        //( c:NE = "YES" & c:class = "Person" )
        // only pronominalize if there is no dependent, or if subtree is the same
         ( ¬c:?dep-> c:?Depl {} | ¬c:subtree_coref = "different" )
        ¬c:pos = "WDT"
        ¬c:spos = personal_pronoun
        ¬c:spos = relative_pronoun
        //¬c:ambiguous_antecedent = "yes" 
        c:<-> c:?Ante {}
      }
    }
  }
}

language.id.iso.EL
¬project_info.project.pronominalize.no

( ( ?r == subj | ?r == dobj | ?r == copul )
 & ( ?a == subj | ?a == dobj | ?a == copul )
)

( c:?Ante {c:NE = "YES" c:class = "Person" }
 | c:?Dep {c:NE = "YES" c:class = "Person" } )

// see anaphora possessive
¬ ( c:?Gov { ( c:pos = "NN" | c:finiteness = "GER" ) }  & c:?Dep { c:case = "GEN" } )

// ?Root1 is a root
¬c:?Grandma1 { c:?rel1-> c:?Root1 {} }

¬ ( lexicon.miscellaneous.conjunction.coord_rel.?CREL1 & c:?Dep { c:?CREL1-> c:?Conj2 {} } )
¬ ( lexicon.miscellaneous.conjunction.coord_rel.?CREL2 & c:?Ante { c:?CREL2-> c:?Conj3 {} } )
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
rc:?DepR {
  rc:<=> ?Dep
  ¬rc:bubble = yes
  ¬rc:ambiguous_antecedent = "yes"
  ¬rc:pronominalized = yes
  rc:slex = ?slex
  rc:pos = ?posDep
  rc:spos = ?sposDep
  slex = "_PRO-HUM_"
  pos = "PP"
  spos = personal_pronoun
  //gender = ?Ante.gender
  //number = ?Ante.number
  pronominalized = yes
}
  ]
]

SSynt<=>DMorph anaphora_sameLoc : anaphora_resolution
[
  leftside = [
c:?S1l {
  c:?Gov1 {
    c:?r1-> c:?Dep1 {}
  }
  c:~ c:?S2l {
    c:?Gov2 {
      c:?r2-> c:?Dep2 {
        SameLocAsPrevious = "YES"
        ¬c:spos = personal_pronoun
        ¬c:spos = relative_pronoun
        //Doesn't always work to pronominalize with a coord
        // ¬c:COORD-> c:?Conj {}
      }
    }
  }
}

¬project_info.project.pronominalize.no

( lexicon.dependencies_default_map.ATTR.rel.?r2 | lexicon.dependencies_default_map.II.rel.?r2 )

// The precendent Locative is on the root, and can be pronominalized with reduced risk of ambiguitiy, or there's only one Location in S1l
// this rule won't work until we have all locations marked with "class=Location" so far; simplified as on the following lines for now.
// ( ¬c:?Gov3 { c:?r3-> c:?Gov1 {} } | ¬ ( c:?S1l { c:?Dep7 { c:class = "Location" } } & ¬?Dep7.id == ?Dep1.id ) )
( ¬ c:?Gov3 { c:?r3-> c:?Gov1 {} } | ( c:?Gov4 { c:?r4-> c:?Gov1 { c:pos ="IN" } } & lexicon.dependencies_default_map.II.rel.?r1 & ¬c:?Gov5 { c:?r5-> c:?Gov4 {} } ) )
¬ ( c:?S1l { c:?Dep7 { c:class = "Location" } } & ¬?Dep7.id == ?Dep1.id )

// the first occurrence is in the previous sentence or both locs point to the same
( c:?Dep2 { c:<-> c:?Dep1 {} } | c:?Dep2 { c:?r5-> c:?Dep2Bis { c:<-> c:?Dep1 {} } }
 | ( ( c:?Dep2 { c:<-> c:?Dep0 {} }  | c:?Dep2 { c:?r6-> c:?Dep2Ter { c:<-> c:?Dep0 {} } } ) & c:?Dep1 { c:<-> c:?Dep0 {} } ) )

// pronominalize if the sentences are consecutive or if there is no other location in between the two sentences
// this rule won't work until we have all locations marked with "class=Location" so far; removed star on "b" above for now.
//( c:?S1l { c:b-> c:?S2l {} } | ¬ c:?S1l { c:*b-> c:?S4l { c:?X4l { c:class = "Location" } c:*b-> c:?S2l {} } } )

¬ ( lexicon.miscellaneous.conjunction.coord_rel.?CREL1 & c:?Dep2 { c:?CREL1-> c:?Conj {} } )

lexicon.miscellaneous.locative_pronoun.?r2.?ppro
  ]
  mixed = [

  ]
  rightside = [
rc:?DepR {
  rc:<=> ?Dep2
  ¬rc:bubble = yes
  ¬rc:pronominalizedLoc = yes
  ¬rc:ambiguous_antecedent = "yes"
  rc:slex = ?slex
  rc:pos = ?posDep
  rc:spos = ?sposDep
  slex = ?ppro
  pos = "RB"
  spos = adverb
  pronominalized = yes
  pronominalizedLoc = yes
}
  ]
]

SSynt<=>DMorph anaphora_sameTime : anaphora_resolution
[
  leftside = [
c:?Gov {
  c:?r-> c:?Dep {
    SameTimeAsPrevious = "YES"
    ¬c:spos = personal_pronoun
    ¬c:spos = relative_pronoun
    //Doesn't always work to pronominalize witha coord
    //¬c:COORD-> c:?Conj {}
  }
}

¬project_info.project.pronominalize.no

¬ ( lexicon.miscellaneous.conjunction.coord_rel.?CREL1 & c:?Dep { c:?CREL1-> c:?Conj {} } )
lexicon.dependencies_default_map.ATTR.rel.?r

lexicon.miscellaneous.time_pronoun.?r.?ppro
  ]
  mixed = [

  ]
  rightside = [
rc:?DepR {
  rc:<=> ?Dep
  ¬rc:bubble = yes
  ¬rc:ambiguous_antecedent = "yes"
  ¬rc:pronominalized = yes
  rc:slex = ?slex
  rc:pos = ?posDep
  rc:spos = ?sposDep
  slex = ?ppro
  pos = "RB"
  spos = adverb
  pronominalized = yes
}
  ]
]

SSynt<=>DMorph anaphora_sameLocTime_block : anaphora_resolution
[
  leftside = [
c:?Gov {
  c:?r-> c:?Dep {
    ( c:SameLocAsPrevious = "YES" | c:SameTimeAsPrevious = "YES" )
    c:?s-> c:?Xl {
      ( SameLocAsPrevious = "YES" | SameTimeAsPrevious = "YES" )
    }
  }
}

¬project_info.project.pronominalize.no

// generally adverbials or complements of copulas
//(?r == ATTR | ?r == II )
( lexicon.dependencies_default_map.ATTR.rel.?r | lexicon.dependencies_default_map.II.rel.?r )
lexicon.dependencies_default_map.II.rel.?s
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
  blocked = "subtree"
}
  ]
]

/*det goes by default before all other dependencies.*/
SSynt<=>DMorph CA_EL_ES_FR_IT_PT_order_H_det : CA_EL_ES_FR_IT_PT_order_H_NN
[
  leftside = [
c:?Xl {
  ( c:pos = "NN" | c:pos = "NP" )
  c:?s-> c:?Yl {
    c:pos = "DT"
  }
  c:?r-> c:?Zl {}
}

?s == det

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

¬(?r == det & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b})

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*det goes by default before all other dependencies.*/
SSynt<=>DMorph CA_EL_ES_FR_IT_PT_order_H_possPro : CA_EL_ES_FR_IT_PT_order_H_NN
[
  leftside = [
c:?Xl {
  ( c:pos = "NN" | c:pos = "NP" )
  c:obl_compl-> c:?Yl {
    c:pos = "PP"
  }
  c:?r-> c:?Zl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )


¬?r == det

¬( ?r == obl_compl & ?Zl.pos == "PP" & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b})

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*modif goes by default before all other dependencies but det and quant*/
SSynt<=>DMorph CA_EL_ES_FR_IT_PT_order_H_quant : CA_EL_ES_FR_IT_PT_order_H_NN
[
  leftside = [
c:?Xl {
  ( c:pos = "NN" | c:pos = "NP" )
  c:quant-> c:?Yl {}
  c:?r-> c:?Zl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

¬?r == det
¬( ?r == obl_compl & ( ?Zl.pos == "PP" | ?Zl.pos == "WP" ) )

¬(?r == quant & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b})

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*modif goes by default before all other dependencies but det and quant*/
SSynt<=>DMorph CA_EL_ES_FR_IT_PT_order_H_modif : CA_EL_ES_FR_IT_PT_order_H_NN
[
  leftside = [
c:?Xl {
  ( c:pos = "NN" | c:pos = "NP" )
  c:modif-> c:?Yl {}
  c:?r-> c:?Zl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

¬?r == det
¬( ?r == obl_compl & ( ?Zl.pos == "PP" | ?Zl.pos == "WP" ) )
¬?r == quant

¬(?r == modif & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b})

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )

// If the Yl is a descriptive (will be between commas), put it at the end
( c:?Yl { ¬c:n_modif = ?nmY1 } | c:?Zl { c:n_modif = ?nmZ1 } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*modif goes by default before all other dependencies but det and quant*/
SSynt<=>DMorph CA_EL_ES_FR_IT_PT_order_H_appos : CA_EL_ES_FR_IT_PT_order_H_NN
[
  leftside = [
c:?Xl {
  ( c:pos = "NN" | c:pos = "NP" )
  c:appos-> c:?Yl {}
  c:?r-> c:?Zl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

¬?r == det
¬( ?r == obl_compl & ( ?Zl.pos == "PP" | ?Zl.pos == "WP" ) )
¬?r == quant
¬?r == modif

¬(?r == appos & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b})

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )

// If the Yl is a descriptive (will be between commas), put it at the end
( c:?Yl { ¬c:n_modif = ?nmY1 } | c:?Zl { c:n_modif = ?nmZ1 } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*attr goes by default after all other dependencies.*/
SSynt<=>DMorph CA_EL_ES_FR_IT_PT_order_H_attr : CA_EL_ES_FR_IT_PT_order_H_NN
[
  leftside = [
c:?Xl {
  ( c:pos = "NN" | c:pos = "NP" )
  c:?r-> c:?Yl {}
  c:attr-> c:?Zl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

¬(?r == attr & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b})
¬ ?r == DEP //to avoid cycles (order_H_dep is already applied)
¬ ?r == coord //to avoid cycles and because it makes sense (SPAtxt2correctedplan0)

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )

// If the Yl is a descriptive (will be between commas), put it at the end
( c:?Yl { ¬c:n_modif = ?nmY1 } | c:?Zl { c:n_modif = ?nmZ1 } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*If the a dependent is a descriptive, it is marked with the n_modif attribute for some reason.
The dependent will be between commas, thus put it at the end*/
SSynt<=>DMorph CA_EL_ES_FR_IT_PT_order_H_descriptive : CA_EL_ES_FR_IT_PT_order_H_NN
[
  leftside = [
c:?Xl {
  ( c:pos = "NN" | c:pos = "NP" )
  c:?s-> c:?Yl {
    ¬c:n_modif = ?nmY
  }
  c:?r-> c:?Zl {
    c:n_modif = ?nmZ
  }
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

( ?r == quant | ?r == modif | ?r == appos | ?r == attr )

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*SUBJ goes by default before all other dependencies.*/
SSynt<=>DMorph CA_EL_ES_FR_IT_PT_order_H_subj : CA_EL_ES_FR_IT_PT_order_H_VB
[
  leftside = [
c:?Xl {
  ( c:pos = "VB" | c:pos = "MD" )
  c:subj-> c:?Yl {}
  c:?r-> c:?Zl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

¬?Zl.spos == "relative_pronoun"
¬ c:?Zl { ( c:spos = "NN" | c:spos = "NP" ) c:?s5-> c:?Dep5l { c:spos = "relative_pronoun" } }
¬c:?Zl { ( c:spos = "NN" | c:spos = "NP" ) c:?s6-> c:?Prep6 { c:pos = "IN" c:?t6-> c:?Dep6l { c:spos = "relative_pronoun" } } }
¬ ( ( ?r == adv | ?r == iobj | ?r == obl_obj | ?r == dobj | ?r == copul ) & c:?Zl { c:pos = "IN" c:?s9-> c:?Dep9l { c:spos = "relative_pronoun" } } )
¬(?r == subj & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b})

// in case of aux_refl, the subject goes after the verb
¬ ( ( language.id.iso.CA | language.id.iso.ES ) & ?r == aux_refl & ¬ ?Xl.has3rdArg == "yes" )
¬ ( ( language.id.iso.CA | language.id.iso.ES ) & ( ?r == analyt_perf | ?r == analyt_progr | ?r == modal | ?r == analyt_pass ) & c:?Xl { c:aux_refl-> c:?AuxRefl10 {} } & ¬ ?Xl.has3rdArg == "yes" )

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )

// in the following case the subject goes after the verb
¬ ( language.id.iso.EL &?r == dobj & c:?Zl { ( c:pos = "PP" | c:pos = "WP" ) } )
¬ ( language.id.iso.EL & c:?Xl { c:dobj-> c:?Obj11 { ( c:pos = "PP" | c:pos = "WP" ) } } )

// In Italian negative existencial constructions, negation come before the subject ("ci")
// (see also rule CA_EL_ES_FR_IT_PT_order_H_adv_main_verb_ii )
¬ ( language.id.iso.IT & ?Yl.slex == "ci" & ?Zl.slex == "non" )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*SUBJ goes by default before all other dependencies? except when there's a reflexive pronoun.*/
SSynt<=>DMorph CA_ES_PT_order_H_subj_aux_refl : CA_EL_ES_FR_IT_PT_order_H_VB
[
  leftside = [
c:?Xl {
  ( c:pos = "VB" | c:pos = "MD" )
  c:subj-> c:?Yl {
    ¬c:spos = "relative_pronoun"
  }
  c:?r-> c:?Zl {}
}

( language.id.iso.CA | language.id.iso.ES | language.id.iso.PT )

( ( ( ?r == analyt_perf | ?r == analyt_progr | ?r == modal | ?r == analyt_pass ) & c:?Xl { ¬c:has3rdArg = "yes" c:aux_refl-> c:?auxRefl {} } ) | ( ?r == aux_refl & ¬?Xl.has3rdArg == "yes" ) )

//¬?Yl.spos == "relative_pronoun"
¬ c:?Yl { ( c:spos = "NN" | c:spos = "NP" ) c:?s1-> c:?Dep1l { c:spos = "relative_pronoun" } }

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Zl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Yl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Yr {rc:<=> ?Yl}
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph CA_ES_PT_order_H_aux_refl : CA_EL_ES_FR_IT_PT_order_H_VB
[
  leftside = [
c:?Xl {
  ( c:pos = "VB" | c:pos = "MD" )
  c:aux_refl-> c:?Zl {}
  c:?r-> c:?Yl {}
}

( language.id.iso.CA | language.id.iso.ES | language.id.iso.PT )

( ¬?r == subj | ( c:?Xl { ¬c:has3rdArg = "yes" c:?s2-> c:?Dep2l {} } & ( ?s2 == analyt_perf | ?s2 == analyt_progr | ?s2 == modal | ?s2 == analyt_pass ) ) )

¬?Yl.spos == "relative_pronoun"
¬ c:?Yl { ( c:spos = "NN" | c:spos = "NP" ) c:?s1-> c:?Dep1l { c:spos = "relative_pronoun" } }
¬c:?Yl { ( c:spos = "NN" | c:spos = "NP" ) c:?s6-> c:?Prep6 { c:pos = "IN" c:?t6-> c:?Dep6l { c:spos = "relative_pronoun" } } }
¬ ( ( ?r == adv | ?r == iobj | ?r == obl_obj | ?r == dobj | ?r == copul ) & c:?Yl { c:pos = "IN" c:?s9-> c:?Dep9l { c:spos = "relative_pronoun" } } )

¬ ( ?r == adv & ?Zl.straight_weight == "1.0" )

// The aux_refl is not before another LeftSide restrictive; aux-refl stays closest to the verb
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Zr {
  rc:<=> ?Zl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Yr {rc:<=> ?Yl}
  ~ rc:?Yr {
    rc:<=> ?Yl
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph CA_ES_PT_order_H_adv_aux_refl : CA_EL_ES_FR_IT_PT_order_H_VB
[
  leftside = [
c:?Xl {
  ( c:pos = "VB" | c:pos = "MD" )
  c:aux_refl-> c:?Zl {}
  c:adv-> c:?Yl {
    c:straight_weight = "1.0"
  }
}

( language.id.iso.CA | language.id.iso.ES | language.id.iso.PT )

// The aux_refl is not before another LeftSide restrictive; aux-refl stays closest to the verb
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*OBJ goes by default before all dependencies but the subject.*/
SSynt<=>DMorph CA_EL_ES_FR_IT_PT_order_H_obj : CA_EL_ES_FR_IT_PT_order_H_VB
[
  leftside = [
c:?Xl {
  ( c:pos = "VB" | c:pos = "MD" )
  c:?s-> c:?Yl {}
  c:?r-> c:?Zl {}
}

( ?s == dobj | ?s == copul )

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

( ¬?r == subj | ( language.id.iso.EL &  c:?Yl { ( c:pos = "PP" | c:pos = "WP" ) } ) )

¬ ( (?r == adv & c:?Zl {c:slex = "no"}) | ?r == aux_refl | ?Zl.spos == "relative_pronoun" )

¬ c:?Zl { ( c:spos = "NN" | c:spos = "NP" ) c:?s5-> c:?Dep5l { c:spos = "relative_pronoun" } }
¬c:?Zl { ( c:spos = "NN" | c:spos = "NP" ) c:?s6-> c:?Prep6 { c:pos = "IN" c:?t6-> c:?Dep6l { c:spos = "relative_pronoun" } } }
¬ ( ( ?r == adv | ?r == iobj | ?r == obl_obj | ?r == dobj | ?r == copul ) & c:?Zl { c:pos = "IN" c:?s9-> c:?Dep9l { c:spos = "relative_pronoun" } } )

¬( ( ?r == dobj | ?r == copul ) & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b})

¬ ( ?r == adv & ?Zl.straight_weight == "1.0" )

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*OBJ goes by default before all dependencies but the subject.*/
SSynt<=>DMorph CA_EL_ES_FR_IT_PT_order_H_obl_obj : CA_EL_ES_FR_IT_PT_order_H_VB
[
  leftside = [
c:?Xl {
  ( c:pos = "VB" | c:pos = "MD" )
  c:obl_obj-> c:?Yl {
    ¬c:pos = "DT"
  }
  c:?r-> c:?Zl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

¬(?r == subj | (?r == adv & c:?Zl {c:slex = "no"}) | ?r == dobj | ?Zl.spos == "relative_pronoun" | ?r == aux_refl )

¬ c:?Zl { ( c:spos = "NN" | c:spos = "NP" ) c:?s5-> c:?Dep5l { c:spos = "relative_pronoun" } }
¬c:?Zl { ( c:spos = "NN" | c:spos = "NP" ) c:?s6-> c:?Prep6 { c:pos = "IN" c:?t6-> c:?Dep6l { c:spos = "relative_pronoun" } } }
¬ ( ( ?r == adv | ?r == iobj | ?r == obl_obj | ?r == dobj | ?r == copul ) & c:?Zl { c:pos = "IN" c:?s9-> c:?Dep9l { c:spos = "relative_pronoun" } } )

¬(?r == obl_obj & c:?Yl{c:straight_weight = ?a} & c:?Zl{c:straight_weight = ?b})

¬ ( ?r == adv & ?Zl.straight_weight == "1.0" )

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*OBJ goes by default before all dependencies but the subject.*/
SSynt<=>DMorph CA_EL_ES_FR_IT_PT_order_H_analyt : CA_EL_ES_FR_IT_PT_order_H_VB
[
  leftside = [
c:?Xl {
  ( c:pos = "VB" | c:pos = "MD" )
  c:?s-> c:?Yl {}
  c:?r-> c:?Zl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.IT | language.id.iso.PT )

(?s == analyt_pass | ?s == analyt_perf | ?s == analyt_progr | ?s == analyt_lex | ?s == modal )

( ¬?r == subj | ( language.id.iso.EL &  c:?Yl { ( c:pos = "PP" | c:pos = "WP" ) } ) )

¬( (?r == adv & c:?Zl {c:slex = "no"}) | ?r == obl_obj | ?Zl.spos == "relative_pronoun")
¬ c:?Zl { ( c:spos = "NN" | c:spos = "NP" ) c:?s5-> c:?Dep5l { c:spos = "relative_pronoun" } }
¬c:?Zl { ( c:spos = "NN" | c:spos = "NP" ) c:?s6-> c:?Prep6 { c:pos = "IN" c:?t6-> c:?Dep6l { c:spos = "relative_pronoun" } } }
¬ ( ( ?r == adv | ?r == iobj | ?r == obl_obj | ?r == dobj | ?r == copul ) & c:?Zl { c:pos = "IN" c:?s9-> c:?Dep9l { c:spos = "relative_pronoun" } } )

¬ ( ?r == adv & ?Zl.straight_weight == "1.0" )

¬ ?r == aux_refl
¬ ?r == aux_pass

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*SUBJ goes by default before all other dependencies.*/
SSynt<=>DMorph CA_EL_ES_FR_PT_order_H_relpro : CA_EL_ES_FR_IT_PT_order_H_VB
[
  leftside = [
c:?Xl {
  c:?s-> c:?Yl {
    c:spos = "relative_pronoun"
  }
  c:?r-> c:?Zl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.PT )

¬ (?r == adv & ?Zl.pos == "WRB")

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )

¬ ( language.id.iso.EL & ?r == det )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*SUBJ goes by default before all other dependencies.*/
SSynt<=>DMorph CA_EL_ES_FR_PT_order_H_relpro_embed1 : CA_EL_ES_FR_IT_PT_order_H_VB
[
  leftside = [
c:?Xl {
  c:?s-> c:?Yl {
    ( c:spos = "NN" | c:spos = "NP" )
    c:?s5-> c:?Dep5l { c:spos = "relative_pronoun" }
  }
  c:?r-> c:?Zl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.PT )

¬ (?r == adv & ?Zl.pos == "WRB")

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*SUBJ goes by default before all other dependencies.*/
SSynt<=>DMorph CA_EL_ES_FR_PT_order_H_relpro_embed1bis : CA_EL_ES_FR_IT_PT_order_H_VB
[
  leftside = [
c:?Xl {
  c:?t-> c:?Yl {
    c:pos = "IN"
    c:?s5-> c:?Dep5l { c:spos = "relative_pronoun" }
  }
  c:?r-> c:?Zl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.PT )

¬ (?r == adv & ?Zl.pos == "WRB")

( ?t == adv | ?t == iobj | ?t == obl_obj | ?t == dobj | ?t == copul )

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

/*SUBJ goes by default before all other dependencies.*/
SSynt<=>DMorph CA_EL_ES_FR_PT_order_H_relpro_embed2 : CA_EL_ES_FR_IT_PT_order_H_VB
[
  leftside = [
c:?Xl {
  c:?s-> c:?Yl {
    ( c:spos = "NN" | c:spos = "NP" )
    c:?s6-> c:?Prep6 {
      c:pos = "IN"
      c:?s5-> c:?Dep5l { c:spos = "relative_pronoun" }
    }
  }
  c:?r-> c:?Zl {}
}

( language.id.iso.CA | language.id.iso.EL | language.id.iso.ES | language.id.iso.FR | language.id.iso.PT )

¬ (?r == adv & ?Zl.pos == "WRB")

// If a RS node is a restrictive, it must be before all other deps on the right, and after all deps on the left
// condition for first  RS node
¬( c:?Yl { c:lex = ?lZo } & lexicon.?lZo.anteposed.restrictive.?yes1 )
// condition for second RS node
¬( c:?Zl { c:lex = ?lYo } & lexicon.?lYo.postposed.restrictive.?yes2 )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  ¬rc:~ rc:?Zr {rc:<=> ?Zl}
  ~ rc:?Zr {
    rc:<=> ?Zl
    ¬rc:bubble = yes
  }
}
  ]
]

SSynt<=>DMorph EN_anaphora_remove_genitive : mark_block_deps
[
  leftside = [
c:?Node {
  c:case = "GEN"
}

language.id.iso.EN
  ]
  mixed = [

  ]
  rightside = [
rc:?NodeR {
  rc:<=> ?Node
  rc:pronominalized = yes
  rc:~ rc:?Gen {
    rc:spos = "genitive"
    elide = "yes"
  }
}
  ]
]

/*If a noun has been pronominalized by the previous module, remove the possibly remaining dependent.
This rule comes from a sort of hack in case of pronominalization of prepositional group, in which the prep
 is the one replaced by the pronoun, whereas the noun is untouched by the previous grammar.
Happens in 170822a_known_input_multiple2.conll #251*/
SSynt<=>SSynt block_dep_pronoun_gen_dependent : mark_block_deps
[
  leftside = [
c:?Govl {
  ( c:pos = "NN" | c:pos = "NP" )
  // The following configuration will be rendered with a genitive pronoun like "her"
  c:?r-> c:?Xl {
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
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
    // also add pronominalize=yes here?
  ( rc:slex = "_PRO_" | rc:slex = "_PRO-HUM_" | rc:pronominalized = yes )
}

rc:?DepR {
  rc:<=> ?Depl
  ¬rc:bubble = yes
  blocked = "subtree"
}
  ]
]

SSynt<=>SSynt EL_block_dep_pronoun_gen_dependent : mark_block_deps
[
  leftside = [
c:?Govl {
  ( c:pos = "NN" | c:pos = "NP" )
  c:obl_compl-> c:?Xl {
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
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
    // also add pronominalize=yes here?
  ( rc:slex = "_PRO_" | rc:slex = "_PRO-HUM_" | rc:pronominalized = yes )
}

rc:?DepR {
  rc:<=> ?Depl
  ¬rc:bubble = yes
  blocked = "subtree"
}
  ]
]

/*If a noun has been pronominalized by the previous module, but the determiner has been built at the same time.
Happens in 170822a_known_input_multiple2.conll #251*/
SSynt<=>SSynt block_det_pronoun_gen_sibling : mark_block_deps
[
  leftside = [
c:?Govl {
  ( c:pos = "NN" | c:pos = "NP" )
  // The following configuration will be rendered with a genitive pronoun like "her"
  c:?r-> c:?Xl {
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
¬ language.id.iso.IT
¬ language.id.iso.PT
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
    // also add pronominalize=yes here?
  ( rc:slex = "_PRO_" | rc:slex = "_PRO-HUM_" | rc:pronominalized = yes )
}

rc:?DetR {
  rc:<=> ?Detl
  ¬rc:bubble = yes
  blocked = "subtree"
}
  ]
]

/*Should this rule be limited to Greek?
Could this rule be merged with block_dep_pronoun_gen?*/
SSynt<=>SSynt block_dep_pronoun_personal_dependent : mark_block_deps
[
  leftside = [
c:?Govl {
  c:?r-> c:?Xl {
    c:?s-> c:?Depl {
      //( c:pos = "DT" | c:pos = "CD" )
    }
  }
}

// Just putting dependencies for controlling the application of the rule!; may be more generic
( ?r == subj | ?r == dobj | ?r == iobj | ?r == obl_obj | ?r == OBJ | ?r == SBJ)

//language.id.iso.EL
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
    // also add pronominalize=yes here?
  ( rc:slex = "_PRO_" | rc:slex = "_PRO-HUM_" | rc:pronominalized = yes )
}

rc:?DepR {
  rc:<=> ?Depl
  ¬rc:bubble = yes
  blocked = "subtree"
}
  ]
]

excluded SSynt<=>SSynt block_percolate : mark_block_deps
[
  leftside = [
c:?Xl {
  c:?r-> c:?Yl {}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  ¬rc:bubble = yes
  rc:elide = "yes"
}

rc:?Yr {
  rc:<=> ?Yl
  ¬rc:bubble = yes
  elide = "yes"
}
  ]
]

/*If a node X2 has a coreference relation with a NE node of another bubble in which there is another NE, mark X2.
If no NE has a class.*/
Sem<=>ASem mark_ambiguous_antecedent_coref : mark_ambiguous_antecedent
[
  leftside = [
c:?S1l {
  c:slex = "Sentence"
  c:?X1l {
    c:id = ?id1
    c:NE = "YES"
  }
  c:?X3l {
    c:id = ?id3
    c:NE = "YES"
    ¬c:pos = "CD"
    ¬c:slex = "e-book"
    //¬c:relativized = yes
  }
}

c:?X2l {
  c:<-> c:?X1l {}
  ¬c:relativized = yes
}

// We need some additional rules to check if whithin S2, X2 may not be ambiguous anymore, e.g. if there is an element coreferring with it above in the tree. Moved below
( c:?S1l { c:?X2l {} } | c:?S1l { c:~ c:?S2l { c:?X2l { } } } )

// If  X1 is the subject of the main verb, let the pronominalisation take place.
( ¬ ( c:?GovX1 { c:?r1-> c:?X1l {} } & ¬c:?GrandGov { c:?r2-> c:?GovX1 {} } & lexicon.dependencies_default_map.I.rel.?r1 )
    // but if the subject had conjuncts below that could be ambiguous, back to blocking the pronominalisation.
    | ( c:?X1l { c:?Coord-> c:?And { c:?Conj-> c:?XConj { c:class = ?class } } } & ?class == ?X1l.class
       & lexicon.dependencies_default_map.COORD.rel.?Coord & lexicon.dependencies_default_map.II.rel.?Conj )
)

¬ ?id1 == ?id3

// X1 and X3 are not coreferring
c:?X1l { ¬c:<-> c:?X3l {} }
c:?X3l { ¬c:<-> c:?X1l {} }
¬ ( c:?X1l { c:<-> c:?Xante {} } & c:?X3l { c:<-> c:?Xante {} } )

// Don't apply if X3 is a number
¬ ( c:?X3l { c:slex = ?sx } & ( ?sx == 0 |  ?sx < 0 | ?sx > 0 | ?sx == "e-book" ) )

// X1 and X3 have the same class or have no class or only X1 has a class
( ( c:?X1l { ¬c:class = ?mX1 } & c:?X3l { ¬c:class = ?mX3 } )
    | ?X1l.class == ?X3l.class
    | ( c:?X1l { c:class = ?mX2 } & c:?X3l { ¬c:class = ?mX4 } & ¬?mX2 == "Person" )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?X2r {
  rc:<=> ?X2l
  ¬rc:bubble = yes
  ambiguous_antecedent = "yes"
}
  ]
]

/*If a node X2 has a coreference relation with a NE node of another bubble in which there is another NE, mark X2.
If no NE has a class.*/
Sem<=>ASem mark_ambiguous_antecedent_coref_SentBetween : mark_ambiguous_antecedent
[
  leftside = [
c:?S1l {
  c:id = ?id1
  c:slex = "Sentence"
  c:?X1l {
    c:NE = "YES"
  }
  c:*~ c:?Snl {
    c:id = ?idn
    c:?X3l {
      c:NE = "YES"
      ¬c:pos = "CD"
      ¬c:slex = "e-book"
      //¬c:relativized = yes
    }
    c:~ c:?S2l {
    // When deactivated, we need some additional rules to check if whithin S2, X2 may not be ambiguous anymore, e.g. if there is an element coreferring with it above in the tree.
      c:id = ?id2
      c:?X2l {
        c:<-> c:?X1l {}
        ¬c:relativized = yes
      }
    }
  }
}

// If  the subject of the main verb of Snl corefers with X1 too, let the pronominalisation take place.
( ¬ ( c:?Snl { c:?Subj1 { c:<-> c:?X1l {} } } & c:?GovX1 { c:?r1-> c:?Subj1 {} } & ¬c:?GrandGov { c:?r2-> c:?GovX1 {} } & lexicon.dependencies_default_map.I.rel.?r1 )
  // but if the subject had conjuncts below that could be ambiguous, back to blocking the pronominalisation.
  | ( c:?Snl { c:?Subj2 { c:<-> c:?X1l {} c:?Coord-> c:?And { c:?Conj-> c:?XConj { c:class = ?class } } } } & ?class == ?Subj2.class
      & lexicon.dependencies_default_map.COORD.rel.?Coord & lexicon.dependencies_default_map.II.rel.?Conj )
)

¬ ?id1 == ?id3
¬ ?id1 == ?idn

// X1 and X3 are not coreferring
c:?X1l { ¬c:<-> c:?X3l {} }
c:?X3l { ¬c:<-> c:?X1l {} }
¬ ( c:?X1l { c:<-> c:?Xante {} } & c:?X3l { c:<-> c:?Xante {} } )

// Don't apply if X3 is a number
¬ ( c:?X3l { c:slex = ?sx } & ( ?sx == 0 |  ?sx < 0 | ?sx > 0 | ?sx == "e-book" ) )

// X1 and X3 have the same class or have no class or only X1 has a class
( ( c:?X1l { ¬c:class = ?mX1 } & c:?X3l { ¬c:class = ?mX3 } )
    | ?X1l.class == ?X3l.class
    | ( c:?X1l { c:class = ?mX2 } & c:?X3l { ¬c:class = ?mX4 } & ¬?mX2 == "Person" )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?X2r {
  rc:<=> ?X2l
  ¬rc:bubble = yes
  ambiguous_antecedent = "yes"
}
  ]
]

/*If  the subject of the main verb of S2 is also coreferring with X1, let the pronominalisation take place.*/
SSynt<=>DMorph cancel_ambiguous_antecedent_subj_SentSame : mark_ambiguous_antecedent
[
  leftside = [
c:?S1l {
  c:slex = "Sentence"
  c:?X1l {
    c:NE = "YES"
  }
  c:*~ c:?S2l {
    c:?X2l {
      c:<-> c:?X1l {}
      c:id = ?id2
    }
    c:?Root {
      c:?r-> c:?Subj {
        c:<-> c:?X1l {}
        c:id = ?id1
      }
    }
  }
}

 ( lexicon.dependencies_default_map.I.rel.?r | lexicon.miscellaneous.copula.rel.?r )
¬c:?GrandGov { c:?s-> c:?Root {} }
¬?id1 == ?id2

¬ ( c:?Subj { c:<-> c:?X1l {} c:?Coord-> c:?And { c:?Conj-> c:?XConj { c:class = ?class } } } & ?class == ?Subj.class
      & lexicon.dependencies_default_map.COORD.rel.?Coord & lexicon.dependencies_default_map.II.rel.?Conj )
  ]
  mixed = [

  ]
  rightside = [
rc:?X2r {
  rc:<=> ?X2l
  ¬rc:bubble = yes
  rc:ambiguous_antecedent = "yes"
  ambiguous_antecedent = "no"
}
  ]
]

/*If  the subject of the main verb of S2 is also coreferring with X1, let the pronominalisation take place.*/
SSynt<=>DMorph cancel_ambiguous_antecedent_subj_SentPrev : mark_ambiguous_antecedent
[
  leftside = [
c:?S1l {
  c:slex = "Sentence"
  c:?X1l {
    c:NE = "YES"
  }
  c:*~ c:?S3l {
    c:?Root {
      c:?r-> c:?Subj {
        c:<-> c:?X1l {}
        c:id = ?id1
      }
    }
    c:~ c:?S2l {
      c:?X2l {
        c:<-> c:?X1l {}
        c:id = ?id2
      }
    }
  }
}

 ( lexicon.dependencies_default_map.I.rel.?r | lexicon.miscellaneous.copula.rel.?r )
¬c:?GrandGov { c:?s-> c:?Root {} }
¬?id1 == ?id2

¬ ( c:?Subj { c:<-> c:?X1l {} c:?Coord-> c:?And { c:?Conj-> c:?XConj { c:class = ?class } } } & ?class == ?Subj.class
      & lexicon.dependencies_default_map.COORD.rel.?Coord & lexicon.dependencies_default_map.II.rel.?Conj )
  ]
  mixed = [

  ]
  rightside = [
rc:?X2r {
  rc:<=> ?X2l
  ¬rc:bubble = yes
  rc:ambiguous_antecedent = "yes"
  ambiguous_antecedent = "no"
}
  ]
]

/*If  the subject of the main verb of S2 has a genitive complement that is also coreferring with X1, let the pronominalisation take place.*/
SSynt<=>DMorph cancel_ambiguous_antecedent_subjGen_SentSame : mark_ambiguous_antecedent
[
  leftside = [
c:?S1l {
  c:slex = "Sentence"
  c:?X1l {
    c:NE = "YES"
  }
  c:*~ c:?S2l {
    c:?X2l {
      c:<-> c:?X1l {}
      c:id = ?id2
    }
    c:?Root {
      c:?r-> c:?Subj {
        c:?t-> c:?Gen {
          c:case = "GEN"
          c:<-> c:?X1l {}
          c:id = ?id1
        }
      }
    }
  }
}

 ( lexicon.dependencies_default_map.I.rel.?r | lexicon.miscellaneous.copula.rel.?r )
¬c:?GrandGov { c:?s-> c:?Root {} }
¬?id1 == ?id2

¬ ( c:?Subj { c:<-> c:?X1l {} c:?Coord-> c:?And { c:?Conj-> c:?XConj { c:class = ?class } } } & ?class == ?Subj.class
      & lexicon.dependencies_default_map.COORD.rel.?Coord & lexicon.dependencies_default_map.II.rel.?Conj )
  ]
  mixed = [

  ]
  rightside = [
rc:?X2r {
  rc:<=> ?X2l
  ¬rc:bubble = yes
  rc:ambiguous_antecedent = "yes"
  ambiguous_antecedent = "no"
}
  ]
]

/*If  the subject of the main verb of S2 has a genitive complement that is also coreferring with X1, let the pronominalisation take place.*/
SSynt<=>DMorph cancel_ambiguous_antecedent_subjGen_SentPrev : mark_ambiguous_antecedent
[
  leftside = [
c:?S1l {
  c:slex = "Sentence"
  c:?X1l {
    c:NE = "YES"
  }
  c:*~ c:?S3l {
    c:?Root {
      c:?r-> c:?Subj {
        c:?t-> c:?Gen {
          c:case = "GEN"
          c:<-> c:?X1l {}
          c:id = ?id1
        }
      }
    }
    c:~ c:?S2l {
      c:?X2l {
        c:<-> c:?X1l {}
        c:id = ?id2
      }
    }
  }
}

 ( lexicon.dependencies_default_map.I.rel.?r | lexicon.miscellaneous.copula.rel.?r )
¬c:?GrandGov { c:?s-> c:?Root {} }
¬?id1 == ?id2

¬ ( c:?Subj { c:<-> c:?X1l {} c:?Coord-> c:?And { c:?Conj-> c:?XConj { c:class = ?class } } } & ?class == ?Subj.class
      & lexicon.dependencies_default_map.COORD.rel.?Coord & lexicon.dependencies_default_map.II.rel.?Conj )
  ]
  mixed = [

  ]
  rightside = [
rc:?X2r {
  rc:<=> ?X2l
  ¬rc:bubble = yes
  rc:ambiguous_antecedent = "yes"
  ambiguous_antecedent = "no"
}
  ]
]

/*Same as cancel_ambiguous_antecedent_subjGenS2, but with a preposition.*/
SSynt<=>DMorph cancel_ambiguous_antecedent_subjGenPrep_SentSame : mark_ambiguous_antecedent
[
  leftside = [
c:?S1l {
  c:slex = "Sentence"
  c:?X1l {
    c:NE = "YES"
  }
  c:*~ c:?S2l {
    c:?X2l {
      c:<-> c:?X1l {}
      c:id = ?id2
    }
    c:?Root {
      c:?r-> c:?Subj {
        c:?u-> c:?Prep {
          c:pos = "IN"
          c:?t-> c:?Gen {
            c:case = "GEN"
            c:<-> c:?X1l {}
            c:id = ?id1
          }
        }
      }
    }
  }
}

// If  the subject of the main verb of S2 has a genitive complement that is also coreferring with X1, let the pronominalisation take place.
 ( lexicon.dependencies_default_map.I.rel.?r | lexicon.miscellaneous.copula.rel.?r )
¬c:?GrandGov { c:?s-> c:?Root {} }

¬?id1 == ?id2

¬ ( c:?Subj { c:<-> c:?X1l {} c:?Coord-> c:?And { c:?Conj-> c:?XConj { c:class = ?class } } } & ?class == ?Subj.class
      & lexicon.dependencies_default_map.COORD.rel.?Coord & lexicon.dependencies_default_map.II.rel.?Conj )
  ]
  mixed = [

  ]
  rightside = [
rc:?X2r {
  rc:<=> ?X2l
  ¬rc:bubble = yes
  rc:ambiguous_antecedent = "yes"
  ambiguous_antecedent = "no"
}
  ]
]

/*Same as cancel_ambiguous_antecedent_subjGenS2, but with a preposition.*/
SSynt<=>DMorph cancel_ambiguous_antecedent_subjGenPrep_SentPrev : mark_ambiguous_antecedent
[
  leftside = [
c:?S1l {
  c:slex = "Sentence"
  c:?X1l {
    c:NE = "YES"
  }
  c:*~ c:?S3l {
    c:?Root {
      c:?r-> c:?Subj {
        c:?u-> c:?Prep {
          c:pos = "IN"
          c:?t-> c:?Gen {
            c:case = "GEN"
            c:<-> c:?X1l {}
            c:id = ?id1
          }
        }
      }
    }
    c:~ c:?S2l {
      c:?X2l {
        c:<-> c:?X1l {}
        c:id = ?id2
      }
    }
  }
}

// If  the subject of the main verb of S2 has a genitive complement that is also coreferring with X1, let the pronominalisation take place.
 ( lexicon.dependencies_default_map.I.rel.?r | lexicon.miscellaneous.copula.rel.?r )
¬c:?GrandGov { c:?s-> c:?Root {} }

¬?id1 == ?id2

¬ ( c:?Subj { c:<-> c:?X1l {} c:?Coord-> c:?And { c:?Conj-> c:?XConj { c:class = ?class } } } & ?class == ?Subj.class
      & lexicon.dependencies_default_map.COORD.rel.?Coord & lexicon.dependencies_default_map.II.rel.?Conj )
  ]
  mixed = [

  ]
  rightside = [
rc:?X2r {
  rc:<=> ?X2l
  ¬rc:bubble = yes
  rc:ambiguous_antecedent = "yes"
  ambiguous_antecedent = "no"
}
  ]
]

/*Same as cancel_ambiguous_antecedent_subjGenPrepS2, but with a second genitive (not sure it is a great rule).*/
SSynt<=>DMorph cancel_ambiguous_antecedent_subjGenPrepDep_SentSame : mark_ambiguous_antecedent
[
  leftside = [
c:?S1l {
  c:slex = "Sentence"
  c:?X1l {
    c:NE = "YES"
  }
  c:*~ c:?S2l {
    c:?X2l {
      c:<-> c:?X1l {}
      c:id = ?id2
    }
    c:?Root {
      c:?r-> c:?Subj {
        c:?u-> c:?Prep {
          c:pos = "IN"
          c:?t-> c:?Gen1 {
            c:case = "GEN"
            c:?v-> c:?Gen2 {
              c:case = "GEN"
              c:<-> c:?X1l {}
              c:id = ?id1
            }
          }
        }
      }
    }
  }
}

// If  the subject of the main verb of S2 has a genitive complement that is also coreferring with X1, let the pronominalisation take place.
 ( lexicon.dependencies_default_map.I.rel.?r | lexicon.miscellaneous.copula.rel.?r )
¬c:?GrandGov { c:?s-> c:?Root {} }

¬?id1 == ?id2

¬ ( c:?Subj { c:<-> c:?X1l {} c:?Coord-> c:?And { c:?Conj-> c:?XConj { c:class = ?class } } } & ?class == ?Subj.class
      & lexicon.dependencies_default_map.COORD.rel.?Coord & lexicon.dependencies_default_map.II.rel.?Conj )
  ]
  mixed = [

  ]
  rightside = [
rc:?X2r {
  rc:<=> ?X2l
  ¬rc:bubble = yes
  rc:ambiguous_antecedent = "yes"
  ambiguous_antecedent = "no"
}
  ]
]

/*Same as cancel_ambiguous_antecedent_subjGenPrepS2, but with a second genitive (not sure it is a great rule).*/
SSynt<=>DMorph cancel_ambiguous_antecedent_subjGenPrepDep_SentPrev : mark_ambiguous_antecedent
[
  leftside = [
c:?S1l {
  c:slex = "Sentence"
  c:?X1l {
    c:NE = "YES"
  }
  c:*~ c:?S3l {
    c:?Root {
      c:?r-> c:?Subj {
        c:?u-> c:?Prep {
          c:pos = "IN"
          c:?t-> c:?Gen1 {
            c:case = "GEN"
            c:?v-> c:?Gen2 {
              c:case = "GEN"
              c:<-> c:?X1l {}
              c:id = ?id1
            }
          }
        }
      }
    }
    c:~ c:?S2l {
      c:?X2l {
        c:<-> c:?X1l {}
        c:id = ?id2
      }
    }
  }
}

// If  the subject of the main verb of S2 has a genitive complement that is also coreferring with X1, let the pronominalisation take place.
 ( lexicon.dependencies_default_map.I.rel.?r | lexicon.miscellaneous.copula.rel.?r )
¬c:?GrandGov { c:?s-> c:?Root {} }

¬?id1 == ?id2

¬ ( c:?Subj { c:<-> c:?X1l {} c:?Coord-> c:?And { c:?Conj-> c:?XConj { c:class = ?class } } } & ?class == ?Subj.class
      & lexicon.dependencies_default_map.COORD.rel.?Coord & lexicon.dependencies_default_map.II.rel.?Conj )
  ]
  mixed = [

  ]
  rightside = [
rc:?X2r {
  rc:<=> ?X2l
  ¬rc:bubble = yes
  rc:ambiguous_antecedent = "yes"
  ambiguous_antecedent = "no"
}
  ]
]

SSynt<=>DMorph anaphora_attr_number_COORD : anaphora_attr
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

SSynt<=>DMorph anaphora_attr_person : anaphora_attr
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

SSynt<=>DMorph anaphora_attr_person_default : anaphora_attr
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

SSynt<=>DMorph EN_anaphora_attr_gender : anaphora_attr
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

SSynt<=>DMorph EN_anaphora_attr_gender_default : anaphora_attr
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
SSynt<=>DMorph EN_anaphora_attr_number : anaphora_attr
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
SSynt<=>DMorph EN_anaphora_attr_number_default : anaphora_attr
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

SSynt<=>DMorph EN_anaphora_attr_person : anaphora_attr
[
  leftside = [
c:?Node1 {
  c:<-> c:?Node2 {
    c:person = ?gen
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
  person = ?gen
}
  ]
]

SSynt<=>DMorph EN_anaphora_attr_person_default : anaphora_attr
[
  leftside = [
c:?Node1 {
  c:<-> c:?Node2 {
    ¬c:person = ?gen
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
  person = "3"
}
  ]
]

