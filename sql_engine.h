#ifndef SQL_ENGINE_H
#define SQL_ENGINE_H

#include "QtSql"
#include "QVariant"
#include "QMapIterator"
#include "QList"
#include "QMetaType"
#include "QDebug"

class SQL_Engine
{
public:
    SQL_Engine();
    bool createTable(QString tableName, QList <QString> colum);
    bool insert(QVariantMap dataInsert, QString tableName, QList <QString> colum);
    QString select(QString tableName, QList <QString> colum);
    bool deleteTable(QString tableName);
    bool exportDB ();
    ~SQL_Engine();

private:
    bool connection ();
    bool isTableExists(QString tableName);

    const QString databaceName = "Kachalka.db";
    const QString userName = "admin";
    const QString userPassword = "123456";

    QSqlDatabase db;
};

#endif // SQL_ENGINE_H
