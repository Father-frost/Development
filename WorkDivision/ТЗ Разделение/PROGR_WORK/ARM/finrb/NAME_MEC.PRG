PARAMETERS ntmec
DO CASE
CASE ntmec=1
    RETURN "январь  "
CASE ntmec=2
    RETURN "февраль "
CASE ntmec=3
    RETURN "март    "
CASE ntmec=4
    RETURN "апрель  "
CASE ntmec=5
    RETURN "май     "
CASE ntmec=6
    RETURN "июнь    "
CASE ntmec=7
    RETURN "июль    "
CASE ntmec=8
    RETURN "август  "
CASE ntmec=9
    RETURN "сентябрь"
CASE ntmec=10
    RETURN "октябрь "
CASE ntmec=11
    RETURN "ноябрь  "
CASE ntmec=12
    RETURN "декабрь "
ENDCASE
RETURN "        "
