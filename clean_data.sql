-- Queries to clean up the skills_dim table.
/*
The job skills have some redundant alias listings e.g.: 'go' and 'golang'.
Some listings also appear twice verbatim e.g.: 'sas' and 'powerbi' appear twice.
Purpose: to clean the skills_dim table and update the related tables so the 
reported data will reflect more accurately the average salaries and demand 
associated with these skills.  
*/

-- This query shows the skills that have exact duplicates.
SELECT
    skills
FROM
    skills_dim
GROUP BY
    skills
HAVING
    COUNT(skills) > 1

-- There are other less direct duplicates too such as go/golang. 
-- There were 259 records in the original skills table, not too many
-- to filter manually.
SELECT
     skill_id,
     skills
FROM
    skills_dim
WHERE
    skills IN ('go', 'golang', 'power bi', 'mongo', 'visual basic',
               'visualbasic', 'node', 'node.js', 'msaccess', 'ms access', 
               'asp.net core', 'huggingface', 'hugging face', 'no-sql',
               'nosql', 'ruby on rails', 'rubyon rails', 'react', 'react.js',
               'sql server', 'vue', 'vue.js'
               )
ORDER BY skills


/*
Some results seem like duplicates, but are actually distinct:
angular, angular.js, couchdb, couchbase, vba, visual basic, asp.net, asp.netcore
*/

-- This query will fetch the skill IDs associated with these duplicated skills.
-- It joins the tables by skills instead of skill_id which is not ideal, but the
-- skills dim table is small enough for this to be reasonable.
SELECT
    skill_id,
    duplicate_skills.skills
FROM
    (SELECT
        skills
    FROM
        skills_dim
    GROUP BY
        skills
    HAVING
        COUNT(skills) > 1
    UNION
    SELECT
        skills
        FROM
            skills_dim
        WHERE
            skills IN
            ('go', 'golang', 'power bi', 'mongo', 'visual basic',
            'visualbasic', 'node', 'node.js', 'msaccess', 'ms access', 
            'asp.net core', 'huggingface', 'hugging face', 'no-sql',
            'nosql', 'ruby on rails', 'rubyon rails', 'react', 'react.js',
            'sql server', 'vue', 'vue.js'
            )
    ) AS duplicate_skills
INNER JOIN skills_dim
    ON skills_dim.skills = duplicate_skills.skills
ORDER BY
    skills

/*
Now with the duplicate skills and skill IDs identified, we can clean up 
skills_dim and the affected related tables.
*/

CREATE TABLE
