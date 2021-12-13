;;!pre-parsing:{type: "nunjucks", data: "datafile.json"}

(define (domain dialog)
(:requirements :typing :fluents :negative-preconditions) 
(:types
  database
  owner
)

(:predicates 
  (can_access ?x )
  (open ?x)
  (request_access ?x)
  (db_owner ?x ?y)
  (request_owner_db ?x ?y)
)

(:action display_access
  :parameters ( ?x )
  :precondition (and 
    (can_access ?x)
  )
  :effect (and (open ?x)
  )
)

(:action request_access
  :parameters ( ?x )
  :precondition (not (can_access ?x))
  :effect (and (request_access ?x)
  )
)

(:action owner_list
    :parameters ( ?x ?y)
    :precondition (and 
      (request_access ?x)
      (db_owner ?x ?y)
    )
    :effect (and (request_owner_db ?x ?y)
              (can_access ?x) )
)

)
 
