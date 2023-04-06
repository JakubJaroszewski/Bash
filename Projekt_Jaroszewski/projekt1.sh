# Autor Jakub Jaroszewski 
main() {
    if ! command -v curl &> /dev/null; then #sprawdzanie czy jest pobrany curl
    echo "curl nie jest zainstalowany, instalowanie..."
    sudo apt-get update && sudo apt-get install curl
    fi
    FILE="strony.txt"
    CONTENT=$(tr -d '\n' < "$FILE") # odczytuje zawartość pliku i zapisuje w zmiennej
    CONTENT=$(echo "$CONTENT" | tr ' ' '\n') # zamienia znaki spacji na znaki nowej linii
    pages=()
    j=0
    for PAGE in $CONTENT; do # zapisuje strony do tablicy
    pages[$j]=$PAGE
    ((j++))
    done
    files=()
    for i in $(seq 1 ${#pages[@]}); do #tworzy odpowiednia ilość plików do zapisaywania zawartości stron; ${#pages[@]} zwraca długość tablicy 
    files+=("file_$i.txt")
    touch "${files[-1]}" # "${files[-1]}" ostatni plik w tablicy files
    done
    for i in $(seq 0 $(( ${#pages[@]} - 1 )) ) # seq oznacza w jakim zakresie będzie iterowane i 
    do
    local url=${pages[$i]} 
    local old_content=$(cat "${files[$i]}")
    local new_content=$(get_page_content "$url") #wywołanie funkcji get_page_content z argumentem "$url"
    if [ "$old_content" = "$new_content" ]; then # porównuje zawartość dwóch plików i wypisuje odpowiednią informacje 
        echo "Strona ${pages[$i]} nie uległa zmianie"
    else
        echo "Strona ${pages[$i]} uległa zmianie"
        echo "$new_content" > "${files[$i]}"
    fi
    done
}
get_page_content() {   #funkcja służąca do pobiernia zawartości strony
    local url="$1"
    local content=$(curl -s "$url")
    if [ $? -eq 0 ]; then  
        echo "$content" 
    else
        echo "wystąpił bład podczas pobierania treści ze strony $url."
    fi
}
if [ $# -eq 0 ] # dla wywołania funkcji bez argumentów wykonuje się skrypt 
then
main
elif [ $1 -eq 1 ] # dla wywołania funkcji z argumentem 1 wyświetla się pomoc
then
echo "POMOC"
echo "1) Skrypt sczytuje strony z pliku konfiguracyjnego: strony.txt"
echo "2) Aby uruchomić skrypt należy uruchomić skrypt bez argumentów"
echo "3) UWAGA, strony muszą być dodawane po spacji i z każdą zmianą pliku strony.txt należy go zapisać"
echo "4) UWAGA, pliki które stworzymy nie mogą zostać przeniesione do innego folderu, dotyczy to także pliku strony.txt"
echo "5) Pozostałe informacje na temat skryptu znajdują się w dokumentacji"
else  # dla wywołania funkcji z innym argumentem  
echo "Aby uzyskać pomoc należy otworzyć dokumentację lub uruchomić program z argumentem 1"
exit 1
fi