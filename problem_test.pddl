(define (problem problem_test)
(:domain dialogplan3)
(:objects
    CSV_data - database
    John - owner
    find_contact_number_of_person - input
    find_number - intent
)
(:init
    (not (status-have-user-query find_contact_number_of_person))
    (not (have_db_source CSV_data))
    (db_admin CSV_data John)
)

(:goal (and
    (have_user_intent find_number)
    (have_db_access CSV_data)

))


)