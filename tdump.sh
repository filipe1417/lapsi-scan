#!/usr/bin/bash

ESC=$(printf '\033') RESET="${ESC}[0m" RED="${ESC}[31m"
GREEN="${ESC}[32m" YELLOW="${ESC}[33m" BLUE="${ESC}[34m" MAGENTA="${ESC}[35m" WHITE="${ESC}[37m" DEFAULT="${ESC}[39m"

greenprint() { printf "${GREEN}%s${RESET}\n" "$1"; }
blueprint() { printf "${BLUE}%s${RESET}\n" "$1"; }
redprint() { printf "${RED}%s${RESET}\n" "$1"; }
yellowprint() { printf "${YELLOW}%s${RESET}\n" "$1"; }
magentaprint() { printf "${MAGENTA}%s${RESET}\n" "$1"; } 

MENU_TCPDUMP="
$(blueprint "##########  OPÇÕES DE ATAQUES  ##########")
$(greenprint "SNIFFING NA REDE COM TCPDUMP")

$(yellowprint "1.") $(blueprint "Tcpdump na rede toda") $(magentaprint "(sudo)")
$(yellowprint "2.") $(blueprint "Tcpdump com filtros") $(magentaprint "(sudo)")
$(yellowprint "3)") $(blueprint "Voltar")
$(yellowprint "4)") $(redprint "Sair do programa")
"

MENU_FILTROS="
$(greenprint "~~FILTROS~~")

$(yellowprint "1)") $(blueprint "Host específico") 
$(yellowprint "2)") $(blueprint "Portas específicas") 
$(yellowprint "3)") $(blueprint "Flag do cabeçalho TCP") 
$(yellowprint "4)") $(blueprint "Voltar")
$(yellowprint "5)") $(redprint "Sair do programa")
"

MENU_FLAGS="

$(blueprint "Digite a Flag do cabeçalho TCP:  ")
$(yellowprint "1.") $(blueprint "CWR")
$(yellowprint "2.") $(blueprint "ECE")
$(yellowprint "3.") $(blueprint "URG")
$(yellowprint "4.") $(blueprint "ACK")
$(yellowprint "5.") $(blueprint "PSH")
$(yellowprint "6.") $(blueprint "RST")
$(yellowprint "7.") $(blueprint "SYN")
$(yellowprint "8.") $(blueprint "FIN")
$(yellowprint "9.") $(blueprint "Voltar")

"

menu_tcpdump(){

    clear
    unset opcao0
    echo  "$MENU_TCPDUMP"
    read -r opcao0
    case $opcao0 in
        '1')
	    tcpdump
	;;
        '2')
            tcpdump_filtros
        ;;

	'3')
	    menu_inicial
	;;	
	
        '4')
            exit 0
        ;;
        *)
            echo "Opção inválida"
        ;;
    esac
    printf "%s " "Press enter to continue"
    read ans
    menu_tcpdump
}


tcpdump_filtros(){

    echo  "$MENU_FILTROS"
    read -r  opcao1
    
    case $opcao1 in  
        '1')
            echo "Digite o IP alvo"
            read -r IP
	    tcpdump -i eno1 -n host $IP
	    
	                
        ;;

        '2')
            echo "Digite o IP alvo"
            read -r IP 
            echo "Digite o número da porta"
            read -r porta
            tcpdump -i eno1 -n host $IP and port $porta
	    
        ;;

        '3')
	    echo "$MENU_FLAGS"
	    read -r opc3
	    case $opc3 in

                '1')
                     tcpdump -i eno1 -n  tcp[13] == 128
                 ;;

                '2')
                     tcpdump -i eno1 -n  tcp[13] == 64
                 ;;

                '3')
                     tcpdump -i eno1 -n  tcp[13] == 32
                 ;;

                '4')
                     tcpdump -i  eno1 -n  tcp[13] == 16
                 ;;

                '5')
                     tcpdump -i eno1 -n  tcp[13] == 8
                 ;;

                '6')
                     tcpdump -i eno1 -n  tcp[13] == 4
                 ;;

                '7')
                     tcpdump -i eno1 -n  tcp[13] == 2
                 ;;

                '8')
                     tcpdump -i eno1 -n  tcp[13] == 1
                 ;;

		'9')
		    clear	
		    tcpdump_filtros

		 ;;

	    esac
        
       
	 ;;

	'4')
	    menu_tcpdump
	 ;;

	'5')
	    exit 0
    	 ;;

	 *)
            echo "Opção inválida"
        ;;	 
   
    esac
}

menu_tcpdump

