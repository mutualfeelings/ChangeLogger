#!/bin/sh

# Version 1.3

# variables
if [ -z "$2" ]; then
    echo "Укажите уровень логирования (например: ERROR, INFO, DEBUG, TRACE) вторым аргументом."
    exit 1
fi
LVL=$2
LOG_PATH="/home/tc/storage/crystal-cash/modules/loader/log4j.xml"

if ps aux | grep -q '[r]u.crystals.pos.touch2.loader.Loader'; then
    CASH_TYPE="touch"
else
    CASH_TYPE="pos"
fi

echo "Тип кассы: $CASH_TYPE"

mainLogger() {
    loggers_pos="ru.crystals.pos.cards ru.crystals.pos.keylock ru.crystals.pos.barcodeprocessing ru.crystals.pos.softcheck ru.crystals.pos.visualization ru.crystals.pos.bank ru.crystals.pos.fiscalprinter ru.crystals.pos.keyboard ru.crystals.pos.check ru.crystals.pos.payments ru.crystals.plugins org.apache.kafka ru.crystals.pos.techprocess ru.crystals.pos.utils.CommonLogger ru.crystals.pos.speed.SpeedLog ru.crystals.pos.barcodescanner ru.crystals.pos.advertising ru.crystals.pos.checkdisplay ru.crystals.pos.cashdrawer ru.crystals.pos.customerdisplay ru.crystals.pos.cashdrawer ru.crystals.pos.scale ru.crystals.pos.user"
    loggers_touch="ru.crystals.pos.cards ru.crystals.pos.keylock ru.crystals.pos.barcodeprocessing ru.crystals.pos.softcheck ru.crystals.pos.visualization ru.crystals.pos.bank ru.crystals.pos.fiscalprinter ru.crystals.pos.keyboard ru.crystals.pos.check ru.crystals.pos.payments ru.crystals.plugins org.apache.kafka ru.crystals.pos.techprocess ru.crystals.pos.utils.CommonLogger ru.crystals.pos.speed.SpeedLog ru.crystals.pos.barcodescanner ru.crystals.pos.advertising ru.crystals.pos.checkdisplay ru.crystals.pos.cashdrawer ru.crystals.pos.customerdisplay ru.crystals.pos.cashdrawer ru.crystals.pos.scale ru.crystals.pos.user ru.crystals.pos.touch2 ru.crystals.pos.touch2.jetty"

    if [ "$CASH_TYPE" = "touch" ]; then
        loggers=$loggers_touch
    else
        loggers=$loggers_pos
    fi

    for logger in $loggers; do
        sed -i "s/<Logger name=\"$logger\" level=\".*\">/<Logger name=\"$logger\" level=\"$LVL\">/" "$LOG_PATH"
    done
}

marks() {
    loggersMarks="ru.crystals.httpclient ru.crystals.transport ru.crystals.pos.egais.excise.validation ru.crystals.pos.catalog.mark"
    for logger in $loggersMarks; do
        sed -i "s/<Logger name=\"$logger\" level=\".*\">/<Logger name=\"$logger\" level=\"$LVL\">/" "$LOG_PATH"
    done
}

loy() {
    loggersLoy="ru.crystalservice.setv6.discounts ru.crystals.loyal ru.crystals.pos.loyal ru.crystals.pos.loyalty ru.crystals.api ru.crystals.pos.gateway ru.crystals.processing.gateway"
    for logger in $loggersLoy; do
        sed -i "s/<Logger name=\"$logger\" additivity=\"false\" level=\".*\">/<Logger name=\"$logger\" additivity=\"false\" level=\"$LVL\">/" "$LOG_PATH"
    done
}

goods() {
    sed -i "s/<Logger name=\"ru.crystals.pos.catalog\" level=\".*\">/<Logger name=\"ru.crystals.pos.catalog\" level=\"$LVL\">/" "$LOG_PATH"
}

config() {
    loggerConfig="ru.crystals.pos.configurator ru.crystals.pos.property"
    for logger in $loggerConfig; do
        sed -i "s/<Logger name=\"$logger\" level=\".*\">/<Logger name=\"$logger\" level=\"$LVL\">/" "$LOG_PATH"
    done
}

other() {
    otherLoggers="org.hibernate org.glassfish.jersey org.eclipse ru.crystals.json ru.crystals.cashclient ru.crystals.set10client ru.crystals.pos.registry"
    for logger in $otherLoggers; do
        sed -i "s/<Logger name=\"$logger\" level=\".*\">/<Logger name=\"$logger\" level=\"$LVL\">/" "$LOG_PATH"
    done
}

case "$1" in
    main) mainLogger;;
    loy) loy;;
    marks) marks;;
    goods) goods;;
    config) config;;
    other) other;;
    *) printf "Please, enter logger: \nmain\nloy\nmarks\nconfig\nother\ngoods\n"
        exit 1
esac

echo "Уровень логирования для $1 установлен на $LVL"
exit 0