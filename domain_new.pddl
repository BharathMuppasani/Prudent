(define (domain dialog)
(:requirements :typing :fluents :conditional-effects :negative-preconditions) 
(:types
  database owner query col
)

(:predicates 
  (can_access ?x )
  (open ?x)
  (have_db_source ?x)
  (no_db_source ?x)
  (have_user_query ?x)
  (have_user_intent ?x)
  (get_user_intent ?x)
  (request_access ?x)
  (db_owner ?x ?y)
  (request_owner_db ?x ?y)
  (get_col_metadata ?x)
  (role_labelled ?x ?y)
  (display ?y)
)

(:action no_db_source
    :parameters (?x ?y)
    :precondition (and
      (have_user_intent ?y)
      (not (have_db_source ?x))
    )  
    :effect (and (no_db_source ?x))
)

(:action get_user_intent_from
    :parameters (?x)
    :precondition (and (have_user_query ?x))
    :effect (and (get_user_intent ?x)
    (have_user_intent ?x)
    )
)


(:action display
  :parameters (?x)
  :precondition (and 
    (have_db_source ?x)
    (can_access ?x)
  )
  :effect (and (open ?x)
  )
)

(:action request_access_to
  :parameters ( ?x )
  :precondition (and
    (have_db_source ?x)
    (not (can_access ?x))
  )
  :effect (and (request_access ?x)
  )
)

(:action owner_list_of
    :parameters ( ?x ?y)
    :precondition (and 
      (request_access ?x)
      (db_owner ?x ?y)
    )
    :effect (and (request_owner_db ?x ?y)
              (can_access ?x)
)
)

(:action col_metadata_of
    :parameters (?x ?y)
    :precondition (and 
    (can_access ?x)
    (open ?x))
    :effect (and (get_col_metadata ?y))
)

(:action semantic_role_labelling
    :parameters (?x ?y)
    :precondition (and 
    (get_col_metadata ?y)
    (have_user_intent ?x)
    )
    :effect (and (role_labelled ?x ?y))
)


(:action match_results_from_user_intent
    :parameters (?x ?y)
    :precondition (and 
    (get_col_metadata ?y)
    (have_user_intent ?x)
    (role_labelled ?x ?y)
    )
    :effect (and (display ?y))
)


)