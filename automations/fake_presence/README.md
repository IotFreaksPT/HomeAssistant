A minha versão do Fake Presence

Podem ajustar ao vosso cenário facilmente:

* trigger:
    * time_pattern de 5 em 5 minutos
    * state weather_time_off_day: quando muda de dia para noite (tenho um sensor que muda e day to night)
* condition
    * state anyone_home: somente quando ninguem esta em casa (tenho um sensor que passa para off quando ninguem esta em casa)
    * Um range somente para ser mais random, e não correr sempre de 5 em 5 minutos
* action
    * Primeira condição de dia: basicamente desliga tudo e abre as janelas
    * Segunda condição de noite:
        * entre a 1 e as 9 desliga tudo
        * O verdadeiro codigo do random:
            * dummy_entity: entidade dummy para chamar quando nada acontece
            * mintime: tempo minimo para uma ação (on ou off)
            * mintimeon: tempo minimo para uma entidade ficar on
            * maxtimeon: tempo maximo para uma entidade ficar on
            * min_on: numero minimo de entidades on
            * max_on: nuero maximo de entidades on
            * target: lista de entidades a manipular
