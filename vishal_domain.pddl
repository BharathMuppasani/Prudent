(define (domain dialogplan3)

(:requirements :strips :typing :conditional-effects :negative-preconditions)
(:types
  database owner input intent
)

(:predicates
    (get_user_query ?x)
    (status-have-user-query ?x)
    (get_user_intent ?x)
    (have_user_intent ?x)
    (get_db_source ?x)
    (have_db_source ?x)
    (have_db_access ?x)
    (db_admin ?x ?y )
    (request_db_admin ?x ?y)
)

(:action GET_USER_QUERY
    :parameters (?x)
    :precondition (not (status-have-user-query ?x))
    :effect (and (get_user_query ?x)
    (status-have-user-query ?x)
    )
)

(:action GET_USER_INTENT
    :parameters (?x ?y)
    :precondition (and 
    (status-have-user-query ?x)
    (not (have_user_intent ?y))
    )
    :effect (and (get_user_intent ?x)
    (have_user_intent ?y)
    )
)

(:action GET_DB_SOURCE
    :parameters (?x)
    :precondition (and
    (not (have_db_source ?x))
    )
    :effect (and (get_db_source ?x)
    (have_db_source ?x))
)

(:action request_admin
    :parameters (?x ?y)
    :precondition (and (have_db_source ?x)
    (db_admin ?x ?y)
    (not (have_db_access ?x)
    )
    )
    :effect (and (request_db_admin ?x ?y)
    )
)

(:action GET_DB_ACCESS
    :parameters (?x ?y)
    :precondition (and (request_db_admin ?x ?y))
    :effect (and (have_db_access ?x))
)

 
)