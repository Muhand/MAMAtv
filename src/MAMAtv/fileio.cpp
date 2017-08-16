#include"fileio.h"
#include <fstream>

FileIo::FileIo(QObject *parent) : QObject(parent)
{
//    source="";
//    errorMsg="";
}

QString FileIo::source()
{
    return m_source;
}

void FileIo::setSource(const QString &source)
{
    if(source == m_source)
        return;

    m_source = source;
    emit sourceChanged();
}

void FileIo::write(QString input)
{
    if(m_source != "")
    {
        std::string file = m_source.toUtf8().constData();
        std::string in = input.toUtf8().constData();
        std::ofstream out(file);
        out << in;
        out.close();
    }
//    else{
//        errorMsg="You need to set file source first";
//    }

}
