SELECT
    owner,
    (
        SELECT
            f(owner)
        FROM
            dual
    ) f
FROM
    stage;
/

SELECT
    dbms_utility.get_cpu_time -:cpu cpu_hsecs,
    userenv('client_info')
FROM
    dual;
--> the function went from 72,841 calls down to 66
