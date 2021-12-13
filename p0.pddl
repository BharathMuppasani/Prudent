; Templated problem file
;;!pre-parsing:{type: "nunjucks", data: "datafile.json"}

(define (problem p0)
(:domain dialog)

(:objects
    {{ data.DataBase|map("name")|join(' ')}} - database
    {% for data in data.DataBase %}
        {{ data.security.owners|join(' ') }} - owner
    {% endfor %}
)

(:init
;;( access
    {% for data in data.DataBase %}
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
;;)

)

(:goal (and
    {% for data in data.DataBase %}
        {% if data.security.access %}
            (open {{data.name}})
        {% endif %}
        {% if data.security.access == false %}
            {% for head in data.security.owners %}
                (request_owner_db {{data.name}} {{head}})
            {% endfor %}
        {% endif %}
    {% endfor %}

))


)