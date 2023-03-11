#!/bin/bash
#usage: ./mytests/tests.sh

NAME_BIN='202unsold'

mytests() {
    # 'err/test' argv' 'name of the test'
    err '' 'no arguments'
    err '70 70 70' 'too much arguments'
    err '70' 'too less arguments'
    err 'a 80' 'letter first argument'
    err '80 a' 'letter second argument'
    err '40 60' '<= 50 first argument'
    err '60 30' '<= 50 second argument'
    err '-40 60' 'neg first argument'
    err '40 -60' 'neg second argument'
    err '40 10I00492040244141460' 'second argument +int'
    test '60 70' '60 70'
    test '70 70' '70 70'
    test '82 51' '82 51'
    test '52 191' '52 191'
    test '19023 1231' '19023 1231'
    test '12945 86' '12945 86'
    test '52 52' '52 52'
    test '19304213 119302' '19304213 119302'
    test '931421 93' '931421 93'
    test '231 10032' '231 10032'
    test '513 866' '513 866'
}


L='__________________________________________________________________________\n'

#Reset
NC='\033[0m'

#Text color
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
GREY='\033[0;37m'

#Background color
RED_B='\033[41m'
GREEN_B='\033[42m'
YELLOW_B='\033[43m'
BLUE_B='\033[44m'
PURPLE_B='\033[45m'
CYAN_B='\033[46m'
GREY_B='\033[47m'

#Text Font Bold
RED_BOLD='\033[1;31m'
GREEN_BOLD='\033[1;32m'
YELLOW_BOLD='\033[1;33m'
BLUE_BOLD='\033[1;34m'
PURPLE_BOLD='\033[1;35m'
CYAN_BOLD='\033[1;36m'
GREY_BOLD='\033[1;37m'

#Text Font Italic
RED_ITALIC='\033[3;31m'
GREEN_ITALIC='\033[3;32m'
YELLOW_ITALIC='\033[3;33m'
BLUE_ITALIC='\033[3;34m'
PURPLE_ITALIC='\033[3;35m'
CYAN_ITALIC='\033[3;36m'
GREY_ITALIC='\033[3;37m'

#Text Font Underline
RED_UNDERLINE='\033[4;31m'
GREEN_UNDERLINE='\033[4;32m'
YELLOW_UNDERLINE='\033[4;33m'
BLUE_UNDERLINE='\033[4;34m'
PURPLE_UNDERLINE='\033[4;35m'
CYAN_UNDERLINE='\033[4;36m'
GREY_UNDERLINE='\033[4;37m'

declare -i finalres;
declare -i nb_test;
declare -i nb_test_diff;
finalres=0;
PATH_SOL='mytests/solutions/sol_'
PATH_RES='mytests/results/res_'

echo -e ${GREY_BOLD}$L\
'\t\t\t\t\t\t\t\t\n'\
'\t\t\t     '${GREY_BOLD}'FUNCTIONNAL-TESTS'${NC}'\t\t\t\t\n'\
'\t\t\t\t\t\t\t\t\t\n'\
'\t\t\t    '${PURPLE_BOLD} $NAME_BIN'\t\t\t\t\n'${GREY_BOLD}$L

test() {
echo -e ${GREY_BOLD}'__________________________________________________________________________'
    ((nb_test++))
    ((nb_test_diff++))

    ./${NAME_BIN} $1 > $PATH_RES$((nb_test_diff)).txt
    diff -q $PATH_SOL$((nb_test_diff)).txt $PATH_RES$((nb_test_diff)).txt > /dev/null
    res=$?

    if [ $res == 1 ]
    then
        echo -e ${BLUE_BOLD} '\n n°' $((nb_test_diff)) ${CYAN_ITALIC} $2 ${GREY_BOLD} : ${RED_BOLD}' fail\n'${NC}
    elif [ $res == 0 ]
    then
        echo -e ${BLUE_BOLD} '\n n°' $((nb_test_diff)) ${CYAN_ITALIC} $2 ${GREY_BOLD} : ${GREEN_BOLD}' sucess\n'${NC}
        ((finalres++))
    else
        echo -e '\nerror with diff command test\n'
    fi
}

err() {
echo -e ${GREY_BOLD}'__________________________________________________________________________'
    ((nb_test++))
    ./${NAME_BIN} $1 2> /dev/null 1> /dev/null
    res=$?

    if [ $res == 84 ]
    then
        echo -e ${BLUE_BOLD} '\n n°' $((nb_test)) ${YELLOW_ITALIC}$2 ${GREY_BOLD} : ${GREEN_BOLD}' sucess\n' ${GREY_BOLD}
        ((finalres++))
    elif [ $res == 0 ]
    then
        echo -e ${BLUE_BOLD} '\n n°' $((nb_test)) ${YELLOW_ITALIC} $2 ${GREY_BOLD} : ${RED_BOLD}' fail\n' ${GREY_BOLD}
    fi
}

mytests
echo -e ${GREY_BOLD}\
'__________________________________________________________________________\n\n'\
${RED_BOLD}'END OF THE TEST\t\t\t\t\t\t'\
${CYAN_BOLD}'RESULT: '$((finalres))'/'$((nb_test))'\n'${GREY_BOLD}\
'__________________________________________________________________________\n'${NC}
