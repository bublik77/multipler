#!/bin/bash
./.env_key
echo $KEY
FIO_MULTIPLIER_SUM=$(curl -Ss -H "X-CMC_PRO_API_KEY: $KEY" -H "Accept: application/json" -d "start=1&limit=5000&convert=USD" -G https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest  | jq '.data[] | select(.symbol=="FIO") | .quote.USD.price')

#echo $((1/$(($FIO_MULTIPLIER_SUM * 1))))
RES=$(echo "1 / $FIO_MULTIPLIER_SUM" | bc -l)

echo $RES

#./cleos.sh push action fio.fee setfeemult '{"multiplier": $RES, "actor": "'$actor'", "max_fee":20000000000 }' -p $actor