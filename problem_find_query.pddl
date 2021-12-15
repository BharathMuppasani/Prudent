; Templated problem file
;;!pre-parsing:{type: "nunjucks", data: "datafile.json"}

(define (problem problem_find_query)
(:domain dialog)
(:objects
    {{ data.DataBase|map("name")|join(' ')}} - database
    {{data.if_not_present}} - database
    {% for data in data.DataBase %}
        {{ data.security.owners|join(' ') }} - owner
        {{ data.content|join(' ') }} - col
    {% endfor %}
    {{data.user_query}} - query
)

(:init
;;( access
(have_user_query {{data.user_query}})
{% if data.DB_present %}
    {% for data in data.DataBase %}
        (have_db_source {{data.name}})
        (user_intent {{data.name}} {{data.content[0]}})
        {% if data.security.access %}
            (can_access {{data.name}})
        {% endif %}
        {% if data.security.access == false %}
            (not (can_access {{data.name}}))
            {% for head in data.security.owners %}
                (db_owner {{data.name}} {{head}})
            {% endfor %}
        {% endif %}
    {% endfor %}
{% endif %}
{% if data.DB_present == false %}
    (not (have_db_source {{data.if_not_present}}))
{% endif %}

;;)

)

(:goal (and
{% if data.DB_present %}
    (get_user_intent {{data.user_query}})
    {% for data in data.DataBase %}
        (open {{data.name}})
        {% for col in data.content %}
            (get_col_metadata {{data.name}} {{col}})
        {% endfor %}
        (display {{data.content[0]}})
    {% endfor %}
{% else %}(no_db_source {{data.if_not_present}})
{% endif %}
))
)