#include "mediator.h"

Mediator::Mediator()
{
    resOfOperation = false;
}


QString Mediator::select(QJsonObject query){
    QString sjson;
//    QJsonObject        recordObject;
    QJsonArray a;
    QList<QString> l;
    QString t;

    if (query.isEmpty()){
//        recordObject.insert("","");
//        return recordObject;
    }

    QJsonObject::iterator i = query.begin();

    while (i != query.end()){
        if (i.key() == "colums"){
            a = i.value().toArray();
            for(qint8 i = 0; i < a.size(); i++)
                if (a.size() == 1)
                    l << "*";
                else
                    l << a[i].toString();
        }
        if (i.key() == "table")
            t = i.value().toString();
        i++;
    }

    sjson = DB.select(t, l);

    return sjson;
}
