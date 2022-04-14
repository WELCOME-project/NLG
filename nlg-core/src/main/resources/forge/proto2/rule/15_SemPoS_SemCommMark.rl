Sem<=>ASem transfer
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>ASem marks_for_thematicity
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

Sem<=>ASem counting_depth
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*This set of rules (except fill_bubble) should be excluded if the input received already has a bubble around.*/
Sem<=>ASem bubble
[
  leftside = [

  ]
  mixed = [

  ]
  rightside = [

  ]
]

/*If an A0 has been assigned by default to a predicate that has no A0.
This should be controlled somehow during Con-Sem*/
Sem<=>ASem mark_wrong_A0_PATCH
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  c:A0-> c:?Yl {}
}

¬lexicon.?lex.gp.A0
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  A0 = "wrong"
}
  ]
]

/*If an A0 has been assigned by default to a predicate that has no A0.
This should be controlled somehow during Con-Sem*/
Sem<=>ASem mark_wrong_A1_PATCH
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  c:A0-> c:?Yl {}
  c:A1-> c:?Zl {}
}

¬lexicon.?lex.gp.A0
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  A1 = "wrong"
}
  ]
]

/*If an A0 has been assigned by default to a predicate that has no A0.
This should be controlled somehow during Con-Sem*/
Sem<=>ASem mark_wrong_A2_PATCH
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  c:A0-> c:?Yl {}
  c:A1-> c:?Zl {}
  c:A2-> c:?Al {}
}

¬lexicon.?lex.gp.A0
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  A2 = "wrong"
}
  ]
]

/*If an A0 has been assigned by default to a predicate that has no A0.
This should be controlled somehow during Con-Sem*/
Sem<=>ASem mark_wrong_A3_PATCH
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  c:A0-> c:?Yl {}
  c:A1-> c:?Zl {}
  c:A2-> c:?Al {}
  c:A3-> c:?Bl {}
}

¬lexicon.?lex.gp.A0
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  A3 = "wrong"
}
  ]
]

/*If an A0 has been assigned by default to a predicate that has no A0.
This should be controlled somehow during Con-Sem*/
Sem<=>ASem mark_wrong_A4_PATCH
[
  leftside = [
c:?Xl {
  c:lex = ?lex
  c:A0-> c:?Yl {}
  c:A1-> c:?Zl {}
  c:A2-> c:?Al {}
  c:A3-> c:?Bl {}
  c:A4-> c:?Bl {}
}

¬lexicon.?lex.gp.A0
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  A4 = "wrong"
}
  ]
]

Sem<=>ASem block_node_and
[
  leftside = [
c:?Xl {
  c:pos = "CC"
  ¬c:?r-> c:?Yl {}
}

¬c:?Zl { c:NonCore-> c:?Xl {} }
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  block = "yes"
}
  ]
]

Sem<=>ASem block_node_identicalPred
[
  leftside = [
c:?Sem1l {
  c:sem = ?sem1
  c:id = ?id1
  c:?r1-> c:?Depl {}
  ¬c:?s1-> c:?OtherDep1 {}
}

c:?Sem2l {
  c:sem = ?sem2
  c:id = ?id2
  c:?r2-> c:?Depl {}
  ¬c:?s2-> c:?OtherDep2 {}
}

?sem1 == ?sem2
?id1 < ?id2

¬c:?Gov1 { c:?t1-> c:?Sem1l {}}
¬c:?Gov2 { c:?t2-> c:?Sem2l {}}
  ]
  mixed = [

  ]
  rightside = [
rc:?Sem2R {
  rc:<=> ?Sem2l
  block = "yes"
}
  ]
]

/*For the languages wirh a case system, if we have no information about the gender of a node and we have a way to go around it according to the lexicon, we use it.
E.g. in Greek: for V4Design, if a building B is not in the lexicon, we use "the object of interest B" for the remainder of the generation.
So all the agreements are done with "object", for which we know the gender;*/
Sem<=>ASem mark_NoGender_casesystem
[
  leftside = [
c:?Xl {
  c:variable_class = ?vc
}

language.syntax.casesystem.yes
// there is a noun to be used in the lexicon
lexicon.miscellaneous.NP_generalization.?vc.?lexVC
// this noun has an entry in the lexicon
lexicon.?lexVC.pos.?pos
  ]
  mixed = [
rc:?Xr { rc:<=> ?Xl rc:lex = ?lex}
¬lexicon.?lex.gender.?gen
  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  block = "yes"
  add_NP_generalization = ?lexVC
}
  ]
]

Sem<=>ASem node : transfer
[
  leftside = [
?Xl {
  ¬c:blocked = "YES"
}
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

Sem<=>ASem rel_copy : transfer
[
  leftside = [
c: ?Xl {
  ?r-> c:?Yl {
  }
}

// if ?Xl had external arguments, there is a mismatch between the normalized arg number and the original one
// only arguments being or following A0 are marked with "original_rel" during analysis
¬ ( c:?Xl { c:hasExtArg = "yes" }
 & lexicon._predicateNoExtArg_.gp.?r.?DSyntR
 & ( project_info.project.gen_type.D2T | project_info.project.ExtArg.NO )
)
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr{
  rc:<=> ?Xl
  ?r -> rc: ?Yr{
     rc:<=> ?Yl
  }
}
  ]
]

/*when a predicate has ext arg, we have to reestablish the original argumental notation so as to match with lexicon.
This set of rules is so because of the quotes issue. When MATE is updated, clean this shit.
Ruole for KRISTINA, not for MULTISENSOR.*/
Sem<=>ASem rel_ext_Arg : transfer
[
  leftside = [
c:?Xl{
  hasExtArg = "yes"
  ?r-> c:?Yl{}
}

lexicon._predicateNoExtArg_.gp.?r.?DSyntR
lexicon._predicateExtArg_.gp.?newr.?DSyntR

// MULTISENSOR is text to text, so the relations have been introduced according to the lexicon
// external arguments already have the right annotation
( project_info.project.gen_type.D2T | project_info.project.ExtArg.NO )
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr{
  rc:<=> ?Xl
  ?newr-> rc: ?Yr{
     rc:<=> ?Yl
  }
}
  ]
]

Sem<=>ASem rel_precedence : transfer
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

Sem<=>ASem rel_coref : transfer
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

/*For now, we use pos 
in the father node (we have more controlled that feature), but ideally we should use more semantic 
features (such as those below).*/
excluded Sem<=>ASem mark_verb_root_II : marks_for_thematicity
[
  leftside = [
c:?Pl{
  (c:pos="RB" | c:pos="IN" | c:pos="CC" | c:dpos="RB" | c:dpos="IN" | c:dpos="CC" | c:dpos="TO")
  c:A1-> c:?Xl{
    (c:pos = "V" | c:dpos = "VB")
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr{
  rc: <=> ?Xl
  verb_root = "possible"
}
  ]
]

/*The alternation of pos & dpos is due to the different input structures we could have
We need to normalize the quotations in the input structures*/
excluded Sem<=>ASem mark_verb_root_I : marks_for_thematicity
[
  leftside = [
c:?Xl{
  (c:pos = "V" | c:dpos = "VB"  | c:pos = V)
}

¬c:?Bl {c:?r-> c:?Xl{}}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr{
  rc: <=> ?Xl
  verb_root = "possible"
}
  ]
]

/*If a node is on the A2 side of an elaboration, a conjunction or a preposition, mark it.
The idea is to not allow it to be root during the next grammar application.*/
Sem<=>ASem mark_A2_elab : marks_for_thematicity
[
  leftside = [
c:?El{
  ( sem = "ELABORATION" | c:pos = "IN" | c:pos = "TO" | c:pos = "JJ" )
  c:A2-> c:?Yl{}  
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Er{
  rc:<=>?El
  block_elaba2_from = ?Yl.sem
}

rc:?Yr{
  rc:<=>?Yl
  isElaba2 = "yes"
}
  ]
]

/*If a node is on the A2 side of an elaboration, a conjunction or a preposition, mark it.
The idea is to not allow it to be root during the next grammar application.

Not sure it's a good rule: many dependents can be shared in coordinations... (cf PTB_eval_22)
  -> added commonDep condition to allow shared dependents in some cases*/
Sem<=>ASem mark_A2_coord : marks_for_thematicity
[
  leftside = [
c:?El {
  c:pos = "CC"
  c:Set-> c:?Yl {
    ¬c:conj_num = "1"
  }
  c:Set-> c:?Zl {
    c:conj_num = "1"
  }
}

// If ?Zl points to the same node as the A2, let's keep considering ?Yl as a potential root
¬ ( c:?Yl { c:?r-> c:?CommonDep {} } & c:?Zl { c:?s-> c:?CommonDep {} } )
  ]
  mixed = [

  ]
  rightside = [
rc:?Er{
  rc:<=>?El
  //block_coorda2_from = "below"
  block_coorda2_from = ?Yl.sem
}

rc:?Yr{
  rc:<=>?Yl
  isCoorda2 = "yes"
}

rc:?Zr{
  rc:<=>?Zl
  block_coorda2_from = "below"
//  block_coorda2_from = ?Yl.sem
}
  ]
]

/*If a node is on the A2 side of an elaboration, a conjunction or a preposition, mark it.
The idea is to not allow it to be root during the next grammar application.*/
excluded Sem<=>ASem mark_A2_prep : marks_for_thematicity
[
  leftside = [
c:?El{
  ( c:pos = "IN" | c:pos = "TO" )
  c:A2-> c:?Yl{}  
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Er{
  rc:<=>?El
  block_from = ?Yl.sem
}

rc:?Yr{
  rc:<=>?Yl
  isPrepa2 = "yes"
}
  ]
]

Sem<=>ASem mark_son_elaba2 : marks_for_thematicity
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
  rc:<=>?Xl
  rc:isElaba2 = "yes"
}

rc:?Yr {
  rc:<=>?Yl
  ¬rc:isElaba2 = "yes"
  isElaba2 = "yes"
}
  ]
]

Sem<=>ASem mark_parent_elaba2 : marks_for_thematicity
[
  leftside = [
c:?Xl {
  c:?r-> c:?Yl {
    c:sem=?s
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=>?Yl
  rc:isElaba2 = "yes"
}

rc:?Xr {
  rc:<=>?Xl
  ¬rc:isElaba2 = "yes"
  isElaba2 = "yes"
  ¬rc:block_elaba2_from = ?s
}
  ]
]

Sem<=>ASem mark_son_coorda2 : marks_for_thematicity
[
  leftside = [
c:?Xl {
  c:?r-> c:?Yl {}
}
  ]
  mixed = [
// ?Xr didn't get his block_coord_A2 from a sibling of ?Yl
¬ ( ?r == Set & c:?Yl { c:conj_num = "1" } & rc:?Xr { rc:<=> ?Xl rc:block_coorda2_from = ?s rc:Set-> rc:?Zr { rc:sem = ?t } } & ?s == ?t )
  ]
  rightside = [
rc:?Xr {
  rc:<=>?Xl
  rc:isCoorda2 = "yes"
}

rc:?Yr {
  rc:<=>?Yl
  ¬rc:isCoorda2 = "yes"
  isCoorda2 = "yes"
}
  ]
]

Sem<=>ASem mark_parent_coorda2 : marks_for_thematicity
[
  leftside = [
c:?Xl {
  c:?r-> c:?Yl {
    c:sem = ?s
  }
}
  ]
  mixed = [
// ?Xr didn't get his block_coord_A2 from a sibling of ?Yl
¬ ( ?r == Set & rc:?Xr { rc:<=> ?Xl  rc:block_coorda2_from = ?f rc:Set-> rc:?Zr { rc:sem = ?t } } & ?f == ?t )
  ]
  rightside = [
rc:?Yr {
  rc:<=>?Yl
  rc:isCoorda2 = "yes"
}

rc:?Xr {
  rc:<=>?Xl
  ¬rc:isCoorda2 = "yes"
  isCoorda2 = "yes"
  ¬rc:block_coorda2_from = "below"
  ¬rc:block_coorda2_from = ?s
}
  ]
]

excluded Sem<=>ASem mark_A1_sem : marks_for_thematicity
[
  leftside = [
c:?El{
  c:A1-> c:?Yl{}  
}

(?El.sem == "ELABORATION" | (?El.sem == ?s & semanticon.?s))

¬(c:?Xl {
  ¬(c:pos="RB" | c:pos="IN" | c:pos="CC" | c:dpos="RB" | c:dpos="IN" | c:dpos="CC" | c:dpos="TO")
  c:?r-> c:?Yl{}
  c:sem = ?o
} & ¬(?o == "ELABORATION" | (semanticon.?o & ?r == A1)))
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr{
  rc:<=>?Yl
  isa1 = "yes"
}
  ]
]

/*if the rule is applied more than once, the son_a1 value is replaced and just the last
one appears... see how this problem could be fixed*/
excluded Sem<=>ASem mark_son_a1 : marks_for_thematicity
[
  leftside = [
c:?Xl{
  c:?r-> c:?Yl{}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  rc:isa1=yes
  son_a1 = ?Yl.sem
}

rc:?Yr{
  rc:<=>?Yl
  isa1=yes
}
  ]
]

/*rethink completely this rule :(*/
excluded Sem<=>ASem mark_parent_a1 : marks_for_thematicity
[
  leftside = [
c:?Xl{
  c:?r-> c:?Yl{}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr{
  rc:<=>?Yl
  rc:isa1=yes
}

rc:?Xr{
  rc:<=>?Xl
  ¬rc: isa1 = yes
  ¬rc: son_a1 = ?Yl.sem
  isa1=yes
}
  ]
]

/*If this rule is included, mark_A1_sem and mark_verb_root_I & II should be excluded.
Condition: 1st line => either it is governed by an adverb/preposition, etc.
                2nd line => either by a semanteme/elaboration, or a metanode introduced earlier
                      3rd line => and not receive any relation from a node that is not a semanteme nor a prepos
                4rd line => or it is not governed by anything*/
excluded Sem<=>ASem mark_A1_sem_poss_root : marks_for_thematicity
[
  leftside = [
c:?Yl {(c:dpos = "VB" | c:pos = "V" | c:pos = "VB" | c:dpos = "V")}  

(
  (
   (c:?G {(c:pos="RB" | c:pos="IN" | c:pos="CC" | c:dpos="RB" | c:dpos="IN" | c:dpos="CC" | c:dpos="TO"| c:dpos="POS"| c:dpos="CD")
      & c:A1-> c:?Yl {}})
   |
   (c:?El {c:A1-> c:?Yl {}} & (?El.sem == "ELABORATION" | (?El.sem == ?s & semanticon.?s) | ?El.type == META))
  ) 
&
  ¬ (c:?Nl {c:?R-> c:?Yl {}}
    & ¬ (?Nl.sem == "ELABORATION"
       | (?Nl.sem == ?S & semanticon.?S & ?R == A1)
       | ?Nl.type == META
       | c:?Nl  {(c:pos="RB" | c:pos="IN" | c:pos="CC" | c:dpos="RB" | c:dpos="IN" | c:dpos="CC" | c:dpos="TO"| c:dpos="POS" | c:dpos="CD")} 
      )
    )
|
  (¬c:?Bl {c:?r-> c:?Yl{}})
)
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=>?Yl
  verb_root = "possible"
}
  ]
]

/*If this rule is included, mark_A1_sem and mark_verb_root_I & II should be excluded.
Condition: 1st line => either it is governed by an adverb/preposition, etc.
                2nd line => either by a semanteme/elaboration, or a metanode introduced earlier
                      3rd line => and not receive any relation from a node that is not a semanteme nor a prepos
                4rd line => or it is not governed by anything*/
Sem<=>ASem mark_A1_sem_poss_root_V_FIX : marks_for_thematicity
[
  leftside = [
c:?Yl {
  (c:dpos = "VB" | c:pos = "V" | c:pos = "VB" | c:dpos = "V")
  // there can be communicative information already in the input
  ¬c:main_rheme = yes  
}  

 (
  c:?G { c:A1-> c:?Yl {}
            (c:pos="RB" | c:pos="IN" | c:pos="CC" | c:dpos="RB" | c:dpos="IN" | c:dpos="CC"
            | c:dpos="TO"| c:dpos="POS"| c:dpos="CD" | c:pos="JJ" | c:dpos="JJ")
   }
  |
  ( c:?El {c:A1-> c:?Yl {}} & (?El.sem == "ELABORATION" | (?El.sem == ?s & semanticon.?s) | ?El.type == META)
    &
  ¬ (c:?Nl {c:?R-> c:?Yl {}}
    & ¬ (?Nl.sem == "ELABORATION"
       | (?Nl.sem == ?S & semanticon.?S & ?R == A1)
       | ?Nl.type == META
       | c:?Nl  {(c:pos="RB" | c:pos="IN" | c:pos="CC" | c:dpos="RB" | c:dpos="IN" | c:dpos="CC"
        | c:dpos="TO"| c:dpos="POS" | c:dpos="CD" | c:pos="JJ" | c:dpos="JJ")} 
      )
    )
  ) 
  |
  (¬c:?Bl {c:?r-> c:?Yl{}})
  |
  // with the new grammars A1 relation below coordinations is replaced by "Set"
  ( c:?Cl { c:Set-> c:?Yl { c:member="A1"} } & ¬c:?GovC {c:?relC-> c:?Cl {} })
)
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=>?Yl
  ¬rc:verb_root = "possible"
  verb_root = "possible"
}
  ]
]

/*If this rule is included, mark_A1_sem and mark_verb_root_I & II should be excluded.
Condition: 1st line => either it is governed by an adverb/preposition, etc.
                2nd line => either by a semanteme/elaboration, or a metanode introduced earlier
                      3rd line => and not receive any relation from a node that is not a semanteme nor a prepos
                4rd line => or it is not governed by anything*/
Sem<=>ASem mark_A1_sem_poss_root_A_FIX : marks_for_thematicity
[
  leftside = [
c:?Yl {
  //if there's a verb below an adverb, the verb should  be chosen (?)
  (c:pos = "JJ" | c:pos = "IN" | ( c:pos = "RB" & ¬c:?arg-> c:?ArgVl { c:pos = "VB" } ) )
  // there can be communicative information already in the input
  ¬c:main_rheme = yes  
  // not and maybe others can't be root...
  ¬ ( c:sem = "not" | c:sem = "never" | c:sem = "always" )
}

 (
  c:?G { c:A1-> c:?Yl {} (c:pos="RB" | c:pos="IN" | c:pos="CC" | c:dpos="RB" | c:dpos="IN" | c:dpos="CC" | c:dpos="TO"| c:dpos="POS" | c:dpos="CD" | c:pos="CD") }
  |
  ( c:?El {c:A1-> c:?Yl {}} & (?El.sem == "ELABORATION" | (?El.sem == ?s & semanticon.?s) | ?El.type == META)
    &
  ¬ (c:?Nl {c:?R-> c:?Yl {}}
    & ¬ (?Nl.sem == "ELABORATION"
       | (?Nl.sem == ?S & semanticon.?S & ?R == A1)
       | ?Nl.type == META
       | c:?Nl  {(c:pos="RB" | c:pos="IN" | c:pos="CC" | c:dpos="RB" | c:dpos="IN" | c:dpos="CC" | c:dpos="TO"| c:dpos="POS" | c:dpos="CD")} 
      )
    )
  ) 
  |
  (¬c:?Bl {c:?r-> c:?Yl{}})
  |
  // with the new grammars A1 relation below coordinations is replaced by "Set"
  ( c:?Cl { c:Set-> c:?Yl { c:member="A1"} } & ¬c:?GovC {c:?relC-> c:?Cl {} })
)

¬ ( c:?Yl { c:lex = ?lex } & lexicon.?lex.negation.yes )
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=>?Yl
  ¬rc:a_root = "possible"
  a_root = "possible"
}
  ]
]

/*If this rule is included, mark_A1_sem and mark_verb_root_I & II should be excluded.
Condition: 1st line => either it is governed by an adverb/preposition, etc.
                2nd line => either by a semanteme/elaboration, or a metanode introduced earlier
                      3rd line => and not receive any relation from a node that is not a semanteme nor a prepos
                4rd line => or it is not governed by anything*/
Sem<=>ASem mark_A1_sem_poss_root_Loc_FIX : marks_for_thematicity
[
  leftside = [
c:?Yl {
  ¬( c:dpos = "VB" | c:pos = "V" | c:pos = "VB" | c:dpos = "V"
      | c:pos = "JJ" | c:pos = "IN" | ( c:pos = "RB" & ¬c:?arg-> c:?ArgVl { c:pos = "VB" } ) )
  c:Location-> c:?Xl {
    // there can be communicative information already in the input
    ¬c:main_rheme = yes
  }
}

 (
  c:?G { c:A1-> c:?Yl {} (c:pos="RB" | c:pos="IN" | c:pos="CC" | c:dpos="RB" | c:dpos="IN" | c:dpos="CC" | c:dpos="TO"| c:dpos="POS"| c:dpos="CD") }
  |
  ( c:?El {c:A1-> c:?Yl {}} & (?El.sem == "ELABORATION" | (?El.sem == ?s & semanticon.?s) | ?El.type == META)
    &
  ¬ (c:?Nl {c:?R-> c:?Yl {}}
    & ¬ (?Nl.sem == "ELABORATION"
       | (?Nl.sem == ?S & semanticon.?S & ?R == A1)
       | ?Nl.type == META
       | c:?Nl  {(c:pos="RB" | c:pos="IN" | c:pos="CC" | c:dpos="RB" | c:dpos="IN" | c:dpos="CC" | c:dpos="TO"| c:dpos="POS" | c:dpos="CD")} 
      )
    )
  ) 
  |
  (¬c:?Bl {c:?r-> c:?Yl{}})
  |
  // with the new grammars A1 relation below coordinations is replaced by "Set"
  ( c:?Cl { c:Set-> c:?Yl { c:member="A1"} } & ¬c:?GovC {c:?relC-> c:?Cl {} })
)
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=>?Yl
  ¬rc:loc_root = "possible"
  loc_root = "possible"
}
  ]
]

/*If this rule is included, mark_A1_sem and mark_verb_root_I & II should be excluded.
Condition: 1st line => either it is governed by an adverb/preposition, etc.
                2nd line => either by a semanteme/elaboration, or a metanode introduced earlier
                      3rd line => and not receive any relation from a node that is not a semanteme nor a prepos
                4rd line => or it is not governed by anything*/
Sem<=>ASem mark_A1_sem_poss_root_N_FIX : marks_for_thematicity
[
  leftside = [
c:?Yl {
  (c:pos = "NN" | c:pos = "NNP" | c:pos = "WP")
  // there can be communicative information already in the input
  ¬c:main_rheme = yes  
}

 (
  c:?G { c:A1-> c:?Yl {} (c:pos="RB" | c:pos="IN" | c:pos="CC" | c:dpos="RB" | c:dpos="IN" | c:dpos="CC" | c:dpos="TO"| c:dpos="POS"| c:dpos="CD") }
  |
  ( c:?El {c:A1-> c:?Yl {}} & (?El.sem == "ELABORATION" | (?El.sem == ?s & semanticon.?s) | ?El.type == META)
    &
  ¬ (c:?Nl {c:?R-> c:?Yl {}}
    & ¬ (?Nl.sem == "ELABORATION"
       | (?Nl.sem == ?S & semanticon.?S & ?R == A1)
       | ?Nl.type == META
       | c:?Nl  {(c:pos="RB" | c:pos="IN" | c:pos="CC" | c:dpos="RB" | c:dpos="IN" | c:dpos="CC" | c:dpos="TO"| c:dpos="POS" | c:dpos="CD")} 
      )
    )
  ) 
  |
  (¬c:?Bl {c:?r-> c:?Yl{}})
  |
  // with the new grammars A1 relation below coordinations is replaced by "Set"
  ( c:?Cl { c:Set-> c:?Yl { c:member="A1"} } & ¬c:?GovC {c:?relC-> c:?Cl {} })
)


// if there's an oper for the noun, allow for keeping the noun as the main rheme although there is a location root possible
// 190228_beAWARE_P2_IT, sentence 7
( ¬ c:?Yl { c:Location-> c:?Xl {} }
 | ( c:?Yl { c:lex = ?lexY1 c:?r1-> c:?Dep1 {} } & lexicon.?lexY1.gp.?r1.I & lexicon.?lexY1.Oper1.?Oper1 & lexicon.?Oper1.lemma.?lem1 )
 | ( c:?Yl { c:lex = ?lexY2 c:?r2-> c:?Dep2 {} } & lexicon.?lexY2.gp.?r2.II & lexicon.?lexY2.Oper2.?Oper2 & lexicon.?Oper2.lemma.?lem2 )
)
  ]
  mixed = [

  ]
  rightside = [
rc:?Yr {
  rc:<=>?Yl
  ¬rc:n_root = "possible"
  n_root = "possible"
}
  ]
]

excluded Sem<=>ASem mark_second_level_verb : marks_for_thematicity
[
  leftside = [
c:?Xl {
  (c:dpos = "VB" | c:pos = "V")
}

( (c:?Xl {
  c:?r-> c:?Yl {(c:dpos = "VB" | c:pos = "V")}})
|
(c:?Xl {
  c:?r-> c:?Zl {¬(c:dpos = "VB" | c:pos = "V")}} &
c:?Yl {
  (c:dpos = "VB" | c:pos = "V")
  c:?s-> c:?Zl {¬(c:dpos = "VB" | c:pos = "V")}}) )
  ]
  mixed = [

  ]
  rightside = [
rc:?S {
  rc:sem = "Sentence"
  rc: level = "1"
  rc:?Xr {
    rc:<=> ?Xl
    rc:verb_root = "possible"
    rc:weight = ?w
  }
 // rc:?Yr {
 //   rc:<=> ?Yl
   // rc:weight = ?m
  //  ¬rc:verb_root = "possible"
   // level = "2"
//  }
}

//(?m < ?w)

//(?w == #?m + 1#) 

//| (?m < ?w & (rc:?Zr {weight = ?i} & ¬?i > ?m)))
  ]
]

Sem<=>ASem mark_brotherhood : marks_for_thematicity
[
  leftside = [
c:?Xl {
  (c:dpos = "VB" | c:pos = "V")
  c:id = ?a
  c:?r->  c:?Nl {c:id = ?i}
}
c:?Yl {
  (c:dpos = "VB" | c:pos = "V")
  c:id = ?b
  c:?s->  c:?Nl {c:id = ?i}
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Sr {
  rc:sem = "Sentence"
  rc:?Xr {
    rc:<=>?Xl
    rc:weight = ?w
    bro = "1"
    son_is = ?Nl.sem
  }
  rc:?Yr {
    rc:<=>?Yl
    rc:weight = ?p
    bro = "2"
    son_is = ?Nl.sem    
  }
}

((?w == ?p & ?a < ?b) | ?w > ?p)
  ]
]

excluded Sem<=>ASem count_depth_levels : counting_depth
[
  leftside = [
c:?Xl{
  c:?r-> c:?Yl{}
}

¬?r == NAME
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  rc:depth_level=?n
}

rc:?Yr{
  rc:<=>?Yl
  depth_level=#?n+1#
}
  ]
]

excluded Sem<=>ASem mark_first_depth_level : counting_depth
[
  leftside = [
c:?Xl{
  c:pos = V
  c:?r-> c:?Yl{}
}

¬?r == NAME
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  ¬rc:depth_level = ?v
}

rc:?Yr{
  rc:<=>?Yl
  depth_level = 1
}
  ]
]

/*adds weight=1 to the leaves (not those that hold on the relation NAME)*/
Sem<=>ASem weight_level1_noname : counting_depth
[
  leftside = [
c:?Xl{
  ¬c:?r-> c:?Yl{}
}

¬c:?Gl{c:NAME-> c:?Xl{}}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  weight=1
}
  ]
]

/*add weight=1 to the first node of the NAME relation (if that is the only relation 
governed by such node)*/
Sem<=>ASem weight_level1_name : counting_depth
[
  leftside = [
c:?Xl{
  (c:NAME-> c:?Yl{} & ¬(c:A0-> c:?Zl{} | c:A1-> c:?Zl{} | c:A2-> c:?Zl{} | c:A3-> c:?Zl{} | c:A4-> c:?Zl{} 
                               | c:A5-> c:?Zl{} | c:A6-> c:?Zl{} | c:A7-> c:?Zl{} | c:A8-> c:?Zl{}
                               | c:A9-> c:?Zl{} | c:A10-> c:?Zl{}
                               | c:Elaboration-> c:?Zl {}
                               | c:Location-> c:?Zl {}
                               | c:Time-> c:?Zl {}
                               | c:Manner-> c:?Zl {}
                               | c:Direction-> c:?Zl {}
                               | c:Extent-> c:?Zl {}
                               | c:Benefactive-> c:?Zl {}
                               | c:Purpose-> c:?Zl {}
                               )
   )
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  weight=1
  weight_node = ok
}
  ]
]

Sem<=>ASem weight_level2 : counting_depth
[
  leftside = [
c:?Yl{
  c:?r-> c:?Xl{}
}
  ]
  mixed = [
( ¬ c:?Xl { c:?s-> c:?Zl {} } | rc:?Xr {rc:weight_node = ok } )
  ]
  rightside = [
rc:?Xr{
  rc:<=>?Xl
  rc:weight=1
}

rc:?Yr{
  rc:<=>?Yl
  weight=2
}
  ]
]

Sem<=>ASem weight_level3 : counting_depth
[
  leftside = [
c:?Al{
  c:?t-> c:?Yl{
    c:?r-> c:?Xl{
      //¬c:?s-> c:?Zl{}
    }
  }
}
  ]
  mixed = [
( ¬ c:?Xl { c:?s-> c:?Zl {} } | rc:?Xr {rc:weight_node = ok } )
  ]
  rightside = [
rc:?Yr{
  rc:<=>?Yl
  rc:weight=2
}

rc:?Ar{
  rc:<=>?Al
  weight=3
}

rc:?Xr{
  rc:<=>?Xl
}
  ]
]

Sem<=>ASem weight_level4 : counting_depth
[
  leftside = [
c:?Bl{
  c:?u-> c:?Al{
    c:?t-> c:?Yl{
      c:?r-> c:?Xl{
        //¬c:?s-> c:?Zl{}
      }
    }
  }
}
  ]
  mixed = [
( ¬ c:?Xl { c:?s-> c:?Zl {} } | rc:?Xr {rc:weight_node = ok } )
  ]
  rightside = [
rc:?Ar{
  rc:<=>?Al
  rc:weight=3
}

rc:?Br{
  rc:<=>?Bl
  weight=4
}

rc:?Xr{
  rc:<=>?Xl
}
  ]
]

Sem<=>ASem weight_level5 : counting_depth
[
  leftside = [
c:?Cl{
  c:?v-> c:?Bl{
    c:?u-> c:?Al{
      c:?t-> c:?Yl{
        c:?r-> c:?Xl{
          //¬c:?s-> c:?Zl{}
        }
      }
    }
  }
}
  ]
  mixed = [
( ¬ c:?Xl { c:?s-> c:?Zl {} } | rc:?Xr {rc:weight_node = ok } )
  ]
  rightside = [
rc:?Br{
  rc:<=>?Bl
  rc:weight=4
}

rc:?Cr{
  rc:<=>?Cl
  weight=5
}

rc:?Xr{
  rc:<=>?Xl
}
  ]
]

Sem<=>ASem weight_level6 : counting_depth
[
  leftside = [
c:?Dl{
  c:?w-> c:?Cl{
    c: ?v-> c:?Bl{
      c:?u-> c:?Al{
        c:?t-> c:?Yl{
          c:?r-> c:?Xl{
            //¬c:?s-> c:?Zl{}
          }
        }
      }
    }
  }
}
  ]
  mixed = [
( ¬ c:?Xl { c:?s-> c:?Zl {} } | rc:?Xr {rc:weight_node = ok } )
  ]
  rightside = [
rc:?Cr{
  rc:<=>?Cl
  rc: weight=5
}

rc:?Dr{
  rc:<=>?Dl
  weight=6
}

rc:?Xr{
  rc:<=>?Xl
}
  ]
]

Sem<=>ASem weight_level7 : counting_depth
[
  leftside = [
c:?El{
  c:?x-> c:?Dl{
    c:?w-> c:?Cl{
      c: ?v-> c:?Bl{
        c:?u-> c:?Al{
          c:?t-> c:?Yl{
            c:?r-> c:?Xl{
              //¬c:?s-> c:?Zl{}
            }
          }
        }
      }
    }
  }
}
  ]
  mixed = [
( ¬ c:?Xl { c:?s-> c:?Zl {} } | rc:?Xr {rc:weight_node = ok } )
  ]
  rightside = [
rc:?Dr{
  rc:<=>?Dl
  rc:weight=6
}

rc:?Er{
  rc:<=>?El
  weight=7
}

rc:?Xr{
  rc:<=>?Xl
}
  ]
]

Sem<=>ASem weight_level8 : counting_depth
[
  leftside = [
c:?Fl{
  c:?y-> c:?El{
    c:?x-> c:?Dl{
      c:?w-> c:?Cl{
        c: ?v-> c:?Bl{
          c:?u-> c:?Al{
            c:?t-> c:?Yl{
              c:?r-> c:?Xl{
                //¬c:?s-> c:?Zl{}
              }
            }
          }
        }
      }
    }
  }
}
  ]
  mixed = [
( ¬ c:?Xl { c:?s-> c:?Zl {} } | rc:?Xr {rc:weight_node = ok } )
  ]
  rightside = [
rc:?Er{
  rc:<=>?El
  rc:weight=7
}

rc:?Fr{
  rc:<=>?Fl
  weight=8
}

rc:?Xr{
  rc:<=>?Xl
}
  ]
]

Sem<=>ASem weight_level9 : counting_depth
[
  leftside = [
c:?Gl{
  c:?z-> c:?Fl{
    c:?y-> c:?El{
      c:?x-> c:?Dl{
        c:?w-> c:?Cl{
          c: ?v-> c:?Bl{
            c:?u-> c:?Al{
              c:?t-> c:?Yl{
                c:?r-> c:?Xl{
                 //¬c:?s-> c:?Zl{}
                }
              }
            }
          }
        }
      }
    }
  }
}
  ]
  mixed = [
( ¬ c:?Xl { c:?s-> c:?Zl {} } | rc:?Xr {rc:weight_node = ok } )
  ]
  rightside = [
rc:?Fr{
  rc:<=>?Fl
  rc:weight=8
}

rc:?Gr{
  rc:<=>?Gl
  weight=9
}

rc:?Xr{
  rc:<=>?Xl
}
  ]
]

Sem<=>ASem weight_level10 : counting_depth
[
  leftside = [
c:?Hl{
  c:?a->c: ?Gl{
    c:?z->c: ?Fl{
      c:?y-> c:?El{
        c:?x-> c:?Dl{
          c:?w-> c:?Cl{
            c: ?v-> c:?Bl{
              c:?u-> c:?Al{
                c:?t-> c:?Yl{
                  c:?r-> c:?Xl{
                   //¬c:?s-> c:?Zl{}
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
  ]
  mixed = [
( ¬ c:?Xl { c:?s-> c:?Zl {} } | rc:?Xr {rc:weight_node = ok } )
  ]
  rightside = [
rc:?Gr{
  rc:<=>?Gl
  rc:weight=9
}

rc:?Hr{
  rc:<=>?Hl
  weight=10
}

rc:?Xr{
  rc:<=>?Xl
}
  ]
]

Sem<=>ASem weight_level11 : counting_depth
[
  leftside = [
c:?Il{
  c:?b->c:?Hl{
    c:?a->c: ?Gl{
      c:?z->c: ?Fl{
        c:?y-> c:?El{
          c:?x-> c:?Dl{
            c:?w-> c:?Cl{
              c: ?v-> c:?Bl{
                c:?u-> c:?Al{
                  c:?t-> c:?Yl{
                    c:?r-> c:?Xl{
                     //¬c:?s-> c:?Zl{}
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
  ]
  mixed = [
( ¬ c:?Xl { c:?s-> c:?Zl {} } | rc:?Xr {rc:weight_node = ok } )
  ]
  rightside = [
rc:?Hr{
  rc:<=>?Hl
  rc:weight=10
}

rc:?Ir{
  rc:<=>?Il
  weight=11
}

rc:?Xr{
  rc:<=>?Xl
}
  ]
]

Sem<=>ASem weight_level12 : counting_depth
[
  leftside = [
c:?Jl{
  c:?c->c:?Il{
    c:?b->c:?Hl{
      c:?a->c: ?Gl{
        c:?z->c: ?Fl{
          c:?y-> c:?El{
            c:?x-> c:?Dl{
              c:?w-> c:?Cl{
                c: ?v-> c:?Bl{
                  c:?u-> c:?Al{
                    c:?t-> c:?Yl{
                      c:?r-> c:?Xl{
                       //¬c:?s-> c:?Zl{}
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
  ]
  mixed = [
( ¬ c:?Xl { c:?s-> c:?Zl {} } | rc:?Xr {rc:weight_node = ok } )
  ]
  rightside = [
rc:?Ir{
  rc:<=>?Il
  rc:weight=11
}

rc:?Jr{
  rc:<=>?Jl
  weight=12
}

rc:?Xr{
  rc:<=>?Xl
}
  ]
]

Sem<=>ASem weight_level13 : counting_depth
[
  leftside = [
c:?Kl{
  c:?d->c:?Jl{
    c:?c->c:?Il{
      c:?b->c:?Hl{
        c:?a->c: ?Gl{
          c:?z->c: ?Fl{
            c:?y-> c:?El{
              c:?x-> c:?Dl{
                c:?w-> c:?Cl{
                  c: ?v-> c:?Bl{
                    c:?u-> c:?Al{
                      c:?t-> c:?Yl{
                        c:?r-> c:?Xl{
                         //¬c:?s-> c:?Zl{}
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
  ]
  mixed = [
( ¬ c:?Xl { c:?s-> c:?Zl {} } | rc:?Xr {rc:weight_node = ok } )
  ]
  rightside = [
rc:?Jr{
  rc:<=>?Jl
  rc:weight=12
}

rc:?Kr{
  rc:<=>?Kl
  weight=13
}

rc:?Xr{
  rc:<=>?Xl
}
  ]
]

Sem<=>ASem weight_level14 : counting_depth
[
  leftside = [
c:?Ll{
  c:?e->c:?Kl{
    c:?d->c:?Jl{
      c:?c->c:?Il{
        c:?b->c:?Hl{
          c:?a->c: ?Gl{
            c:?z->c: ?Fl{
              c:?y-> c:?El{
                c:?x-> c:?Dl{
                  c:?w-> c:?Cl{
                    c: ?v-> c:?Bl{
                      c:?u-> c:?Al{
                        c:?t-> c:?Yl{
                          c:?r-> c:?Xl{
                           //¬c:?s-> c:?Zl{}
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
  ]
  mixed = [
( ¬ c:?Xl { c:?s-> c:?Zl {} } | rc:?Xr {rc:weight_node = ok } )
  ]
  rightside = [
rc:?Kr{
  rc:<=>?Kl
  rc:weight=13
}

rc:?Lr{
  rc:<=>?Ll
  weight=14
}

rc:?Xr{
  rc:<=>?Xl
}
  ]
]

Sem<=>ASem weight_level15 : counting_depth
[
  leftside = [
c:?Ml{
  c:?f->c:?Ll{
    c:?e->c:?Kl{
      c:?d->c:?Jl{
        c:?c->c:?Il{
          c:?b->c:?Hl{
            c:?a->c:?Gl{
              c:?z->c: ?Fl{
                c:?y-> c:?El{
                  c:?x-> c:?Dl{
                    c:?w-> c:?Cl{
                      c: ?v-> c:?Bl{
                        c:?u-> c:?Al{
                          c:?t-> c:?Yl{
                            c:?r-> c:?Xl{
                             //¬c:?s-> c:?Zl{}
                            }
                          } 
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
  ]
  mixed = [
( ¬ c:?Xl { c:?s-> c:?Zl {} } | rc:?Xr {rc:weight_node = ok } )
  ]
  rightside = [
rc:?Lr{
  rc:<=>?Ll
  rc:weight=14
}

rc:?Mr{
  rc:<=>?Ml
  weight=15
}

rc:?Xr{
  rc:<=>?Xl
}
  ]
]

Sem<=>ASem weight_level16 : counting_depth
[
  leftside = [
c:?Nl{
  c:?g-> c:?Ml{
    c:?f->c:?Ll{
      c:?e->c:?Kl{
        c:?d->c:?Jl{
          c:?c->c:?Il{
            c:?b->c:?Hl{
              c:?a->c:?Gl{
                c:?z->c: ?Fl{
                  c:?y-> c:?El{
                    c:?x-> c:?Dl{
                      c:?w-> c:?Cl{
                        c: ?v-> c:?Bl{
                          c:?u-> c:?Al{
                            c:?t-> c:?Yl{
                              c:?r-> c:?Xl{
                               //¬c:?s-> c:?Zl{}
                              }
                            }
                          } 
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
  ]
  mixed = [
( ¬ c:?Xl { c:?s-> c:?Zl {} } | rc:?Xr {rc:weight_node = ok } )
  ]
  rightside = [
rc:?Mr{
  rc:<=>?Ml
  rc:weight=15
}

rc:?Nr{
  rc:<=>?Nl
  weight=16
}

rc:?Xr{
  rc:<=>?Xl
}
  ]
]

Sem<=>ASem weight_level17 : counting_depth
[
  leftside = [
c:?Ol{
  c:?h-> c:?Nl{
    c:?g-> c:?Ml{
      c:?f->c:?Ll{
        c:?e->c:?Kl{
          c:?d->c:?Jl{
            c:?c->c:?Il{
              c:?b->c:?Hl{
                c:?a->c:?Gl{
                  c:?z->c: ?Fl{
                    c:?y-> c:?El{
                      c:?x-> c:?Dl{
                        c:?w-> c:?Cl{
                          c: ?v-> c:?Bl{
                            c:?u-> c:?Al{
                              c:?t-> c:?Yl{
                                c:?r-> c:?Xl{
                                 //¬c:?s-> c:?Zl{}
                                }
                              }
                            }
                          } 
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
  ]
  mixed = [
( ¬ c:?Xl { c:?s-> c:?Zl {} } | rc:?Xr {rc:weight_node = ok } )
  ]
  rightside = [
rc:?Nr{
  rc:<=>?Nl
  rc:weight=16
}

rc:?Or{
  rc:<=>?Ol
  weight=17
}

rc:?Xr{
  rc:<=>?Xl
}
  ]
]

Sem<=>ASem weight_level18 : counting_depth
[
  leftside = [
c:?Pl{
  c:?i-> c:?Ol{
    c:?h-> c:?Nl{
      c:?g-> c:?Ml{
        c:?f->c:?Ll{
          c:?e->c:?Kl{
            c:?d->c:?Jl{
              c:?c->c:?Il{
                c:?b->c:?Hl{
                  c:?a->c:?Gl{
                    c:?z->c: ?Fl{
                      c:?y-> c:?El{
                        c:?x-> c:?Dl{
                          c:?w-> c:?Cl{
                            c: ?v-> c:?Bl{
                              c:?u-> c:?Al{
                                c:?t-> c:?Yl{
                                  c:?r-> c:?Xl{
                                   //¬c:?s-> c:?Zl{}
                                  }
                                }
                              }
                            }
                          } 
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
  ]
  mixed = [
( ¬ c:?Xl { c:?s-> c:?Zl {} } | rc:?Xr {rc:weight_node = ok } )
  ]
  rightside = [
rc:?Or{
  rc:<=>?Ol
  rc:weight=17
}

rc:?Pr{
  rc:<=>?Pl
  weight=18
}

rc:?Xr{
  rc:<=>?Xl
}
  ]
]

Sem<=>ASem weight_level19 : counting_depth
[
  leftside = [
c:?Ql{
  c:?j-> c:?Pl{
    c:?i-> c:?Ol{
      c:?h-> c:?Nl{
        c:?g-> c:?Ml{
          c:?f->c:?Ll{
            c:?e->c:?Kl{
              c:?d->c:?Jl{
                c:?c->c:?Il{
                  c:?b->c:?Hl{
                    c:?a->c:?Gl{
                      c:?z->c: ?Fl{
                        c:?y-> c:?El{
                          c:?x-> c:?Dl{
                            c:?w-> c:?Cl{
                              c: ?v-> c:?Bl{
                                c:?u-> c:?Al{
                                  c:?t-> c:?Yl{
                                    c:?r-> c:?Xl{
                                     //¬c:?s-> c:?Zl{}
                                    }
                                  }
                                }
                              }
                            }
                          } 
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
  ]
  mixed = [
( ¬ c:?Xl { c:?s-> c:?Zl {} } | rc:?Xr {rc:weight_node = ok } )
  ]
  rightside = [
rc:?Pr{
  rc:<=>?Pl
  rc:weight=18
}

rc:?Qr{
  rc:<=>?Ql
  weight=19
}

rc:?Xr{
  rc:<=>?Xl
}
  ]
]

Sem<=>ASem weight_level20 : counting_depth
[
  leftside = [
c:?Rl{
  c:?k-> c:?Ql{
    c:?j-> c:?Pl{
      c:?i-> c:?Ol{
        c:?h-> c:?Nl{
          c:?g-> c:?Ml{
            c:?f->c:?Ll{
              c:?e->c:?Kl{
                c:?d->c:?Jl{
                  c:?c->c:?Il{
                    c:?b->c:?Hl{
                      c:?a->c:?Gl{
                        c:?z->c: ?Fl{
                          c:?y-> c:?El{
                            c:?x-> c:?Dl{
                              c:?w-> c:?Cl{
                                c: ?v-> c:?Bl{
                                  c:?u-> c:?Al{
                                    c:?t-> c:?Yl{
                                      c:?r-> c:?Xl{
                                       //¬c:?s-> c:?Zl{}
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          } 
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
  ]
  mixed = [
( ¬ c:?Xl { c:?s-> c:?Zl {} } | rc:?Xr {rc:weight_node = ok } )
  ]
  rightside = [
rc:?Qr{
  rc:<=>?Ql
  rc:weight=19
}

rc:?Rr{
  rc:<=>?Rl
  weight=20
}

rc:?Xr{
  rc:<=>?Xl
}
  ]
]

/*The weight level rules only count depth, i.e. they don't take into account siblings.
These rules add some weight according to the siblings linked by a preposition, an adverb or a semanteme.
It is only a minor improvement, not yet a good solution for the long term.
EDIT: only add the extra weight if the ?Arg1 has its own "important" arguments.*/
Sem<=>ASem add_weight_non_linear : counting_depth
[
  leftside = [
c:?Sem {
  ¬c:pos = "VB"
  ¬c:pos = "NN" 
  c:A1-> c:?Arg1 {
    c:?r-> c:?Dep1 {}
  }
  c:A2-> c:?Arg2 {
  }
}

( ?r == A0 | ?r == A1 | ?r== A2)
  ]
  mixed = [

  ]
  rightside = [
rc:?SemR {
  rc:<=> ?Sem
  rc:weight = ?w0
  rc:A1-> rc:?Arg1R {
    rc:<=> ?Arg1
    rc:weight = ?w1
    ¬rc:new_weight = applied
    new_weight = applied
    weight = #?w1 + ?w2 + 1#
  }
  rc:A2-> rc:?Arg2R {
    rc:<=> ?Arg2
    rc:weight = ?w2
  }
}

// don't apply if a possible verb root is a governor!
¬rc:?NodeR1 {rc:verb_root = "possible" rc:?rel1-> rc:?Arg1R {} }
// the relation should be recursive
¬rc:?NodeR2 {rc:verb_root = "possible" rc:*?rel2-> rc:?SemR {} }
  ]
]

excluded Sem<=>ASem create_bubble : bubble
[
  leftside = [
c:?Xl{
  c:id = "1"
}
  ]
  mixed = [

  ]
  rightside = [
?Br{
  sem = "Sentence"
  level = "1"
  rc: +?Xr{
    rc:<=>?Xl
  }
}
  ]
]

excluded Sem<=>ASem expand_bubble_down : bubble
[
  leftside = [
c:?Xl{
  c:?r-> c:?Yl{}
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Bl{
  rc: sem = "Sentence"
  rc: ?Xr{rc:<=>?Xl}
   ¬rc: ?Yr{rc:<=>?Yl}
   rc: +?Yr{
     rc:<=>?Yl
  }
}
  ]
]

excluded Sem<=>ASem expand_bubble_up : bubble
[
  leftside = [
c:?Yl{
  c: ?r-> c:?Xl{
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Br{
  rc: sem = "Sentence"
  rc: ?Xr{rc:<=>?Xl}
  ¬rc: ?Yr{rc:<=>?Yl}
   rc: +?Yr{
     rc:<=>?Yl
  }
}
  ]
]

/*BUG!
-1*/
Sem<=>ASem fill_bubble : bubble
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
}
  ]
]

/*dpos should be VB, NN, RB, JJ (see pos rules below)*/
Sem<=>ASem attr_definiteness : transfer_attributes
[
  leftside = [
c:?Xl {
  definiteness = ?ds
}
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  definiteness = ?ds
}
  ]
]

Sem<=>ASem attr_dpos : transfer_attributes
[
  leftside = [
c: ?Xl{
  dpos = ?d
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr{
  rc: <=> ?Xl
  dpos = ?d
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

Sem<=>ASem attr_gender_coref1 : transfer_attributes
[
  leftside = [
c: ?Xl {
  c:gender = ?i
  c:<-> c:?Yl {
    ¬c:gender = ?j
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Yr{
  rc: <=> ?Yl
  gender = ?i
}
  ]
]

Sem<=>ASem attr_gender_coref2 : transfer_attributes
[
  leftside = [
c: ?Xl {
  ¬c:gender = ?i
  c:<-> c:?Yl {
    c:gender = ?j
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr{
  rc: <=> ?Xl
  gender = ?j
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
}
  ]
]

/*numbering of conjuncts in coordination*/
Sem<=>ASem attr_has_main_rheme : transfer_attributes
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
}
  ]
]

Sem<=>ASem attr_lex : transfer_attributes
[
  leftside = [
c: ?Xl {
  lex = ?l
}

// the lex is in the lexicon; otherwise, try to get the translated lex (see lex_translated)
 ( lexicon.?l.lemma.?lem | language.id.iso.EN )
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr{
  rc: <=> ?Xl
  lex = ?l
}
  ]
]

Sem<=>ASem attr_lex_translated : transfer_attributes
[
  leftside = [
c: ?Xl {
  lex = ?l
}

// the lex isn't as such in the lexicon;
¬ lexicon.?l.lemma.?lem

//  try to get the translated lex
lexicon.?tlex.lex_ENG.?l
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr{
  rc: <=> ?Xl
  lex = ?tlex
}
  ]
]

/*Funny rule, seems like it should be part of attr_lex. But for now it may be safer to separate.*/
Sem<=>ASem attr_lex_fallback : transfer_attributes
[
  leftside = [
c: ?Xl {
  lex = ?l
}

¬ language.id.iso.EN

// the lex isn't as such in the lexicon;
¬ lexicon.?l.lemma.?lem

//  the lex isn't as lex_ENG
¬ lexicon.?tlex.lex_ENG.?l
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr{
  rc: <=> ?Xl
  lex = ?l
}
  ]
]

/*If a node is in the concepticon, use the mapping to the lexicon.*/
excluded Sem<=>ASem attr_lex_new_concepticon : transfer_attributes
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
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  rc:pos = ?pos
  lex = ?lexLG
}
  ]
]

/*If a node is not in the concepticon (or if there is no concepticon), use the information in the lexicon, if any.

This rule comes from KRISTINA.*/
excluded Sem<=>ASem attr_lex_new_lexicon_lex_ENG : transfer_attributes
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

lexicon.?wp.lex_ENG.?s
lexicon.?wp.lemma.?l

// Test: we take the second one by default
¬ ( lexicon.?wp.id.?id1 & lexicon.?wp2.lex_ENG.?s & lexicon.?wp2.id.?id2
 & ?id2 > ?id1
)
¬ ( lexicon.?wp.entryID.?id3 & lexicon.?wp4.lex_ENG.?s & lexicon.?wp4.entryID.?id4
 & ?id3 > ?id4
)
¬ ( lexicon.?wp.entryId.?id5 & lexicon.?wp6.lex_ENG.?s & lexicon.?wp6.entryId.?id6
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

/*If a node is not in the concepticon (or if there is no concepticon), use the information in the lexicon, if any.

This rule comes from KRISTINA.*/
excluded Sem<=>ASem attr_lex_new_lexicon_Eng_tr : transfer_attributes
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
¬ ( language.id.iso.?lg & lexicon.?wpOrig.lex_ENG.?s & lexicon.?wpOrig.lemma.?lemOrig )

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
excluded Sem<=>ASem attr_lex_new_no_lexicon : transfer_attributes
[
  leftside = [
c:?Xl {
  ¬c:lex = ?l
}

//language.id.iso.EN

// see attr_lex_new_concepticon
¬ ( language.id.iso.?lg & c:?Xl { c:sem = ?s1 } & concepticon.?s1.?lg.lex.?lexLG & lexicon.?lexLG.pos.?pos )

( language.id.iso.EN
  | ¬ ( c:?Xl { c:sem = ?s2 } & lexicon.?wp2.lex_ENG.?s2 & lexicon.?wp2.lemma.?l2 )
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
}
  ]
]

/*numbering of conjuncts in coordination*/
Sem<=>ASem attr_member : transfer_attributes
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

Sem<=>ASem attr_mentioned : transfer_attributes
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
}
  ]
]

Sem<=>ASem attr_number_coref1 : transfer_attributes
[
  leftside = [
c: ?Xl {
  c:number = ?i
  c:<-> c:?Yl {
    ¬c:number = ?j
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Yr{
  rc: <=> ?Yl
  number = ?i
}
  ]
]

Sem<=>ASem attr_number_coref2 : transfer_attributes
[
  leftside = [
c: ?Xl {
  ¬c:number = ?i
  c:<-> c:?Yl {
    c:number = ?j
  }
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr{
  rc: <=> ?Xl
  number = ?j
}
  ]
]

Sem<=>ASem attr_pos : transfer_attributes
[
  leftside = [
c: ?Xl{
  pos = ?p
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr{
  rc: <=> ?Xl
  pos = ?p
}
  ]
]

Sem<=>ASem attr_pos_real : transfer_attributes
[
  leftside = [
c: ?Xl{
  real_pos = ?p
}
  ]
  mixed = [

  ]
  rightside = [
rc: ?Xr{
  rc: <=> ?Xl
  real_pos = ?p
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
}
  ]
]

Sem<=>ASem attr_type : transfer_attributes
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
}
  ]
]

Sem<=>DSynt attr_pos_default_VB : transfer_attributes
[
  leftside = [
c:?Xl {
  c:sem = ?s
  ¬c:?CNode {}
  ¬c:pos = ?pos
  c:pos1 = "VB"
}

¬?s == "Sentence"
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  // so rule applies after pos marking rules
  pos = "VB"
  lex = #?s+_VB_01#
}
  ]
]

Sem<=>DSynt attr_pos_default_NN : transfer_attributes
[
  leftside = [
c:?Xl {
  c:sem = ?s
  ¬c:?CNode {}
  ¬c:pos = ?pos
  ¬c:pos1 = "VB"
  c:pos2 = "NN"
}

¬?s == "Sentence"
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  // so rule applies after pos marking rules
  pos = "NN"
  lex = #?s+_NN_01#
}
  ]
]

Sem<=>DSynt attr_pos_default_RB : transfer_attributes
[
  leftside = [
c:?Xl {
  c:sem = ?s
  ¬c:?CNode {}
  ¬c:pos = ?pos
  ¬c:pos1 = "VB"
  ¬c:pos2 = "NN"
  c:pos3 = "RB"
}

¬?s == "Sentence"
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  // so rule applies after pos marking rules
  pos = "RB"
  lex = #?s+_RB_01#
}
  ]
]

Sem<=>DSynt attr_pos_default_JJ : transfer_attributes
[
  leftside = [
c:?Xl {
  c:sem = ?s
  ¬c:?CNode {}
  ¬c:pos = ?pos
  ¬c:pos1 = "VB"
  ¬c:pos2 = "NN"
  ¬c:pos3 = "RB"
  ( c:pos4 = "JJ" | c:pos4 = "CD" )
}

¬?s == "Sentence"
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  // so rule applies after pos marking rules
  pos = "JJ"
  lex = #?s+_JJ_01#
}
  ]
]

Sem<=>DSynt attr_pos_default_NP : transfer_attributes
[
  leftside = [
c:?Xl {
  c:sem = ?s
  ¬c:?CNode {}
  ¬c:type = META
  ¬c:type = "META"
  ¬c:pos = ?pos
  ¬c:pos1 = "VB"
  ¬c:pos2 = "NN"
  ¬c:pos3 = "RB"
  ¬ ( c:pos4 = "JJ" | c:pos4 = "CD" )
}

¬?s == "Sentence"
  ]
  mixed = [

  ]
  rightside = [
rc:?Xr {
  rc:<=> ?Xl
  // so rule applies after pos marking rules
  pos = "NP"
  lex = #?s+_NP_01#
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

