#ifndef MEDIATOR_H
#define MEDIATOR_H

#include "sql_engine.h"
#include "QVariant"
#include "QList"
#include "QJsonObject"
#include "QDebug"


class Mediator : public QObject
{
    Q_OBJECT

public:
    Mediator();

    Q_INVOKABLE QString select(QJsonObject query);

private:
    SQL_Engine      DB;

    bool            resOfOperation;
    QJsonObject     lasteExecToDb;
};

#endif // MEDIATOR_H
