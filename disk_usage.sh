#!/bin/bash
# disk_usage.sh -  Verilen dizinler içindeki en büyük N tane dosyayı listeleyecek

include_files=false # -a verilmezse sadece dizinleri listeler
top_n=10 # -n verilmezse 10 öğre göstersin

# Parametrenin olmadığı durum
if [ $# -eq 0 ]; then
    echo "usage: disk_usage.sh [-a -n N] directory..."
    exit 1
fi

# Pararmetreli durum kontrolü
while getopts ":an:" opt; do
    case $opt in
        a)
            # -a parametresinin odluğu durumda dosyalar da listelenecek
            include_files=true
            ;;
        n)  #-n verilmişse top_n=$OPTARG ile girilen değerin sayısal olup olmadığını kontrol edecek
            top_n=$OPTARG
            if ! [[ "$top_n" =~ ^[0-9]+$ ]]; then
                echo "Error: -n requires a numeric argument"
                exit 1
            fi
            ;;
        :)
            # -n yazılıp sayı verilmediği durum hatası kontrol edilecek
            echo "Error: -n requires a numeric argument"
            exit 1
            ;;
        \?) # Geçersiz parametre verilirse hata dönecek
            echo "Invalid option: -$OPTARG"
            echo "usage: disk_usage.sh [-a -n N] directory..."
            exit 1
            ;;
    esac
done

# getops parametreleri (a-, -n 5) işledikten sonra listeden atıyor ve geriye /etc /var kalıyor sonrasında $@ bunları tutuyor.
shift $((OPTIND - 1))

# Kullanıcının dizin girmediği durumda hata verecek
if [ $# -eq 0 ]; then
    echo "Error: You must specify at least one directory."
    exit 1
fi

# Her dizin için ayrı ayrı kontrol saglanacak
for dir in "$@"; do
    if [ ! -d "$dir" ]; then # Dizinin olup olmadığı kontrol ediliyor
        echo "Error: $dir is not a valid directory"
        continue
    fi

    if [ "$include_files" = true ]; then                          # -a varsa dosyaları da dahil edecek
        du -ah "$dir" 2>/dev/null | sort -h -r | head -n "$top_n" # en büyük N tane dosya/dizin sıralanacak
                                                                  
    else                                                           #sadece dizi/dizinler sıralanacak 
        du -h "$dir" 2>/dev/null | sort -h -r | head -n "$top_n"   #en büyük N dizini sıralayacak
                                                                   # if sonu    
    fi
done
