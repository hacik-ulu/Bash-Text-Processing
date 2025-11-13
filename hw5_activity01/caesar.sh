#!/bin/bash

rotation=${1:-13}               # Kullanılacak rotasyon değeri alınacak (yoksa 13)
rotation=$(( rotation % 26 ))   # 26 üstü değerler normale çekilecek

upper=ABCDEFGHIJKLMNOPQRSTUVWXYZ # Büyük harfler kullanılacak
lower=abcdefghijklmnopqrstuvwxyz # Küçük harfler kullanılacak

upper2="$upper$upper"           # Kaydırma için genişletilmiş diziler oluşturulacak
lower2="$lower$lower"

SET1="$upper$lower"             # Çevrilecek harf kümesi hazırlanacak

# Kaydırılmış harf karşılıkları alınacak
SET2="$(echo "$upper2" | cut -c $((rotation+1))-$((rotation+26)))"
SET2+=$(echo "$lower2" | cut -c $((rotation+1))-$((rotation+26)))

# Dönüştürme işlemi yapılacak
tr "$SET1" "$SET2"
