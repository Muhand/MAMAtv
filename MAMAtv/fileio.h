#ifndef FILEIO_H
#define FILEIO_H

#include <QObject>
#include <QString>

class FileIo : public QObject{
    Q_OBJECT
    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)
public:
    explicit FileIo(QObject *parent = 0);

    Q_INVOKABLE void write(QString input);

    QString source();
    void setSource(const QString &source);

signals:
    void sourceChanged();

private:
    QString m_source;
};

#endif // FILEIO_H
