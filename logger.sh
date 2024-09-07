#version 1.1

#variables
lvl=$2
#path="/home/tc/storage/crystal-cash/modules/loader/log4j.xml"
path="/Users/Anton/VScode/ChangeLogger/log.sh"

#Основные логеры, используемы при анализе

mainLogger() {
    local loggers=(
        "ru.crystals.pos.cards"
        "ru.crystals.pos.keylock"
        "ru.crystals.pos.barcodeprocessing"
        "ru.crystals.pos.softcheck"
        "ru.crystals.pos.visualization"
        "ru.crystals.pos.bank"
        "ru.crystals.pos.fiscalprinter"
        "ru.crystals.pos.keyboard"
        "ru.crystals.pos.check"
        "ru.crystals.pos.payments"
        "ru.crystals.plugins"
        "ru.crystals.pos.cashdrawer"
        "org.apache.kafka"
        "ru.crystals.pos.techprocess"
        "ru.crystals.pos.utils.CommonLogger"
        "ru.crystals.pos.speed.SpeedLog"
        "ru.crystals.pos.barcodescanner"
        "ru.crystals.pos.advertising"
        "ru.crystals.pos.checkdisplay"
        "ru.crystals.pos.scale"
        "ru.crystals.pos.rfidscanner"
    )

    for logger in "${loggers[@]}"; do
        sed -i '' "s/<Logger name=\"$logger\" level=\".*\">/<Logger name=\"$logger\" level=\"$lvl\">/" $path
    done
}

#Логеры тач кассы

touch() {
    local loggersTouch=(
        "ru.crystals.pos.touch2"
        "ru.crystals.pos.touch2.jetty"
    )

    for logger in "${loggersTouch[@]}"; do
        sed -i '' "s/<Logger name=\"$logger\" level=\".*\">/<Logger name=\"$logger\" level=\"$lvl\">/" $path
    done
}

#Логеры лояльности, включая для слс

loy() {
    local loggersLoy=(
        "ru.crystalservice.setv6.discounts"
        "ru.crystals.loyal"
        "ru.crystals.pos.loyal"
        "ru.crystals.pos.loyalty"
        "ru.crystals.api"
        "ru.crystals.pos.gateway"
    )

    for logger in "${loggersLoy[@]}"; do
        sed -i '' "s/<Logger name=\"$logger\" additivity=\"false\" level=\".*\">/<Logger name=\"$logger\" additivity=\"false\" level=\"$lvlLoggers\">/" $path
    done
}

#Логер goods

goods() {
    sed -i '' "s/<Logger name=\"ru.crystals.pos.catalog\" level=\".*\">/<Logger name=\"ru.crystals.pos.catalog\" level=\"$lvl\">/" $path
}

#Логеры необходимые для анализа валидации марки

marks() {
    local markLoggers=(
        "ru.crystals.httpclient"
        "ru.crystals.transport"
        "ru.crystals.pos.egais.excise.validation"
    )

    for logger in "${markLoggers[@]}"; do
        sed -i '' "s/<Logger name=\"$logger\" level=\".*\">/<Logger name=\"$logger\" level=\"$lvl\">/" $path
    done    
}

#Остальные логеры, которые чаще всего находятся в error

other() {
    local otherLoggers=(
        "org.hibernate"
        "org.glassfish.jersey"
        "org.eclipse"
        "ru.crystals.pos.aop"
        "ru.crystals.pos.operdaymessanger"
        "ru.crystals.pos.erpi"
        "ru.crystals.json"
        "ru.crystals.cashclient"
        "ru.crystals.set10client"
        "ru.crystals.pos.plastek"
        "ru.crystals.pos.registry"
        "ru.crystals.pos.aeroflot"
        "ru.crystals.pos.emsr"
        "ru.crystals.cm.cash"
        "ru.crystals.set5"
        ru.crystals.informix
        "ru.crystals.siebel"
    )

    for logger in "${otherLoggers[@]}"; do
        sed -i '' "s/<Logger name=\"$logger\" level=\".*\">/<Logger name=\"$logger\" level=\"$lvl\">/" $path
    done
}

case "$1" in
    main) mainLogger;;
    loy) loy;;
    touch) touch;;
    goods) goods;;
    mark) marks;;
    other) other;;
    *) echo "Please, enter logger: \n \
main \n \
loy \n \
touch \n \
mark \n \
other \n \
goods"
        echo
        exit 1
esac
exit 0