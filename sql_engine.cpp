#include "sql_engine.h"


SQL_Engine::SQL_Engine()
{
    qDebug() << "SQL_Engine is started";
    connection();
}

bool SQL_Engine::connection(){
    bool res;
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(databaceName);
    res = db.open();
    if(!res) {
        qDebug() << "Error: Unable to open database !!!" ;
        return res;
    }
    db.setHostName("localhost");
    db.setUserName(userName);
    db.setPassword(userPassword);

    SQL_Engine::db = db;
    qDebug() << "Connected !!!" ;
    return res;
}

bool SQL_Engine::createTable(QString tableName, QList <QString> colum){
    bool res;
    QSqlQuery query = QSqlQuery(db);
    QString strQuery ="CREATE TABLE IF NOT EXISTS " + tableName + " (id INT PRIMARY KEY, %colum% )";

    if(colum.isEmpty())
        qDebug() << "Error: 'colum' is empty !!!";

    if(isTableExists(tableName)){
        qDebug() << "Warning: tabe is existing";
        return true;
    }

    for(int i = 0; i < colum.size(); i++){
        strQuery = strQuery.replace("%colum%", colum[i] +  " VARCHAR(255), %colum% ");
    }
    strQuery = strQuery.replace(", %colum%", "");

    //-------//
    query.prepare(strQuery);
    res = query.exec();
    //-------//
    if (!res){
        qDebug() << "Error: Cannot create teable !!!"  << query.lastError().text();
    }
    return res;
}

bool SQL_Engine::insert(QVariantMap dataInsert, QString tableName, QList <QString> colum){
    bool res;
    QSqlQuery query = QSqlQuery(db);
    QString strQuery = "INSERT INTO " + tableName + " ( %colum% ) VALUES ( %columValue% )";

    if(!db.isOpen()){
        connection();
    }

    if(dataInsert.isEmpty()){
        qDebug() << "Error: Nothing to insert !!!";
        return false;
    }

    if(!isTableExists(tableName)){
        qDebug() << "Error: tabe is not existing";
        return false;
    }

    if(colum.isEmpty())
        qDebug() << "Error: 'colum' is empty !!!";

    for(int i = 0; i < colum.size(); i++){
        strQuery = strQuery.replace("%colum%", colum[i] +  ", %colum%");
        strQuery = strQuery.replace("%columValue%", "?"  ", %columValue%");
    }
    strQuery = strQuery.replace(", %colum%", "");
    strQuery = strQuery.replace(", %columValue%", "");

    //--------//
    query.prepare(strQuery);
    //--------//

    for(QVariantMap::iterator i = dataInsert.begin(); i != dataInsert.end(); ++i){
        query.addBindValue(i.key());
        query.addBindValue(i.value());
        res = query.exec();
        if (!res){
            qDebug() << "Error: Cannot insert into teable !!!"  << query.lastError().text();
        }
    }


    return res;
}

QString SQL_Engine::select(QString tableName, QList <QString> colum){
    bool res;
    QJsonDocument  json;
    QJsonArray     recordsArray;
    QJsonObject  recordObject;
    QSqlQuery query = QSqlQuery(db);
    QString strQuery = "SELECT %colum% FROM " + tableName;

    if(!db.isOpen()){
        connection();
    }

    if(!isTableExists(tableName)){
        qDebug() << "Error: table '" + tableName + "' is not existing";
        return "Error: table '" + tableName + "' is not existing";
    }

    for(int i = 0; i < colum.size(); i++){
        strQuery = strQuery.replace("%colum%", colum[i] +  ", %colum%");
    }
    strQuery = strQuery.replace(", %colum%", "");

    //--------
    query.prepare(strQuery);
    res = query.exec();
    if (!res){
        qDebug() << "Error: Cannot select from teable !!!"  << query.lastError().text();
    }
    //--------

    while(query.next()) {
        for(int i = 0; i < query.record().count(); i++) {
            recordObject.insert( query.record().fieldName(i), QJsonValue::fromVariant(query.value(i)) );
        }
        recordsArray.push_back(recordObject);
    }

    json.setArray(recordsArray);

    return json.toJson();
}

bool SQL_Engine::deleteTable(QString tableName){
    bool res;
    QSqlQuery query = QSqlQuery(db);
    QString strQuery = "DELETE FROM " + tableName;
    query.prepare(strQuery);
    res = isTableExists(tableName);
    if(res){
        res = query.exec();
        if (res){
            return true;
        }
    }

    qDebug() << "Error: Cannot delete teable !!!"  << query.lastError().text();
    return false;
}

bool SQL_Engine::isTableExists(QString tableName){
    QStringList list;
    list = db.tables();

    for (qint8 i = 0; i < list.length() && list.length(); i++){
        if(list[i] == tableName)
            return true;
    }

    return false;
}

bool SQL_Engine::exportDB(){
    return false;
}

SQL_Engine::~SQL_Engine(){
    qDebug() << "SQL_Engine is stoped";
}
