#!/bin/sh

#Version 1.0

#variables
lvl=$2
path="/home/tc/storage/crystal-cash/modules/loader/log4j.xml"

#Основные логеры, используемы при анализе
mainLogger() {
    loggers="ru.crystals.pos.cards ru.crystals.pos.keylock ru.crystals.pos.barcodeprocessing ru.crystals.pos.softcheck ru.crystals.pos.visualization ru.crystals.pos.bank ru.crystals.pos.fiscalprinter ru.crystals.pos.keyboard ru.crystals.pos.check ru.crystals.pos.payments ru.crystals.plugins org.apache.kafka ru.crystals.pos.techprocess ru.crystals.pos.utils.CommonLogger ru.crystals.pos.speed.SpeedLog ru.crystals.pos.barcodescanner ru.crystals.pos.advertising ru.crystals.pos.checkdisplay ru.crystals.pos.egais.excise.validation ru.crystals.pos.cashdrawer"

    for logger in $loggers; do
        sed -i "s/<Logger name=\"$logger\" level=\".*\">/<Logger name=\"$logger\" level=\"$lvl\">/" $path
    done
}

#Логеры тач кассы
touch() {
    loggersTouch="ru.crystals.pos.touch2 ru.crystals.pos.touch2.jetty"
    
    for logger in $loggersTouch; do
        sed -i "s/<Logger name=\"$logger\" level=\".*\">/<Logger name=\"$logger\" level=\"$lvl\">/" $path
    done
}

#Логеры лояльности, включая для слс
loy() {
    loggersLoy="ru.crystalservice.setv6.discounts ru.crystals.loyal ru.crystals.pos.loyal ru.crystals.pos.loyalty ru.crystals.api ru.crystals.pos.gateway"

    for logger in $loggersLoy; do
        sed -i "s/<Logger name=\"$logger\" additivity=\"false\" level=\".*\">/<Logger name=\"$logger\" additivity=\"false\" level=\"$lvl\">/" $path
    done
}

#Логер goods
goods() {
    sed -i "s/<Logger name=\"ru.crystals.pos.catalog\" level=\".*\">/<Logger name=\"ru.crystals.pos.catalog\" level=\"$lvl\">/" $path
}

#Остальные логеры, которые чаще всего находятся в error
other() {
    otherLoggers="org.hibernate org.glassfish.jersey org.eclipse ru.crystals.transport ru.crystals.httpclient ru.crystals.pos.aop ru.crystals.pos.operdaymessanger ru.crystals.pos.erpi ru.crystals.json ru.crystals.cashclient ru.crystals.set10client ru.crystals.pos.plastek ru.crystals.pos.registry"

    for logger in $otherLoggers; do
        sed -i "s/<Logger name=\"$logger\" level=\".*\">/<Logger name=\"$logger\" level=\"$lvl\">/" $path
    done
}

case "$1" in
    main) mainLogger;;
    loy) loy;;
    touch) touch;;
    goods) goods;;
    other) other;;
    *) printf "Please, enter logger: \n \
main \n \
loy \n \
touch \n \
other \n \
goods"
        exit 1
esac
exit 0

cash save