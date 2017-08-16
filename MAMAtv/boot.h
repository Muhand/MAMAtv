#ifndef BOOT_H
#define BOOT_H

#include <QObject>
#include <QString>
#include <string>

class Boot : public QObject{
    Q_OBJECT
    Q_PROPERTY(bool errorOccured READ errorOccured NOTIFY errorOccuredChanged)
    Q_PROPERTY(QString errorMsg READ errorMsg NOTIFY errorMsgChanged)
    Q_PROPERTY(QString currentChannelNum READ currentChannelNum NOTIFY currentChannelNumChanged)
    Q_PROPERTY(QString xmlContent READ xmlContent NOTIFY xmlContentChanged)

public:
    explicit Boot(QObject *parent = 0);

    Q_INVOKABLE void load();

    ////////////////////////////////////
    //Setters and getters
    ////////////////////////////////////
    bool errorOccured();
    void setErrorOccured(const bool &errorOccured);
    QString errorMsg();
    void setErrorMsg(const QString &errorMsg);
    QString currentChannelNum();
    void setCurrentChannelNum(const QString &currentChannelNum);
    QString xmlContent();
    void setXmlContent(const QString &xmlContent);

    ///////////////////////////////////
    //Functions
    ///////////////////////////////////
    bool createConfigDirectory();
    bool createConfigFile(std::string const &configFileDirectory);
    bool download(std::string const &downloadDirectory);

signals:
    void errorOccuredChanged();
    void errorMsgChanged();
    void currentChannelNumChanged();
    void xmlContentChanged();
    ///////////////////////////////////////
    void configLoadedSuccessfully();
    void configDirectoryCreatedSuccessfully();
    void configFileCreatedSuccessfully();
    void channelsFileDownloadedSuccesfully();
    void newSettingAdded();
    void created();

private:
    bool m_errorOccured;
    QString m_errorMsg;
    QString m_currentChannelNum;
    QString m_xmlContent;

    ///////////////////////////////////////
    //Functions
    ///////////////////////////////////////
    void configure(const QString &line);
    bool loadXMLContent();
};

#endif // BOOT_H
