#include "boot.h"
#include <fstream>
#include <iostream>
#include <dirent.h>
#include <sys/stat.h>
#include <curl/curl.h>
#include <curl/easy.h>
#include <sstream>

using namespace std;

//size_t write_data(void *ptr, size_t size, size_t nmemb, void *stream) {
//    string data((const char*) ptr, (size_t) size * nmemb);
//    *((stringstream*) stream) << data << endl;
//    return size * nmemb;
//}
size_t write_file_data(void *ptr, size_t size, size_t nmemb, FILE *stream) {
    size_t written;
    written = fwrite(ptr, size, nmemb, stream);
    return written;
}

size_t write_out_data(void *ptr, size_t size, size_t nmemb, void *stream) {
    string data((const char*) ptr, (size_t) size * nmemb);
    *((stringstream*) stream) << data << endl;
    return size * nmemb;
}
Boot::Boot(QObject *parent) : QObject(parent)
{
    emit created();
}

bool Boot::errorOccured()
{
    return m_errorOccured;
}

void Boot::setErrorOccured(const bool &errorOccured)
{
    m_errorOccured = errorOccured;

    emit errorOccuredChanged();
}

QString Boot::errorMsg()
{
    return m_errorMsg;
}

void Boot::setErrorMsg(const QString &errorMsg)
{
    if(m_errorMsg == errorMsg)
        return;

    m_errorMsg = errorMsg;

    emit errorMsgChanged();
}

QString Boot::currentChannelNum()
{
    return m_currentChannelNum;
}

void Boot::setCurrentChannelNum(const QString &currentChannelNum)
{
    if(currentChannelNum == m_currentChannelNum)
        return;

    m_currentChannelNum = currentChannelNum;

    emit currentChannelNumChanged();
}

QString Boot::xmlContent()
{
    return m_xmlContent;
}

void Boot::setXmlContent(const QString &xmlContent)
{
    if(m_xmlContent == xmlContent)
        return;

    m_xmlContent = xmlContent;

    emit xmlContentChanged();
}

void Boot::load()
{
    ifstream configFile;
    const string directory="config";
    const string configFileDirectory = directory+"/config.cfg";
    const string channelsDownloadDirectory = directory + "/channels.xml";

    DIR* dir = opendir("config");

    if (dir)
    {
        /* Directory exists. */
        closedir(dir);
        goto READCONFIG;
    }
    else if (ENOENT == errno)
    {
        /* Directory does not exist. */


        setErrorMsg("Config directory doesn't exist");

        //////////////////////////////////////////////
        //Create config directory
        //////////////////////////////////////////////
        if(!createConfigDirectory())
        {
            setErrorOccured(true);

            //Clean up
            goto CLEANUP;
        }

        //////////////////////////////////////////////
        //Create config file
        //////////////////////////////////////////////
        if(!createConfigFile(configFileDirectory))
        {
            setErrorOccured(true);

            //Clean up
            goto CLEANUP;
        }


        //////////////////////////////////////////////
        //Download channels.xml
        //////////////////////////////////////////////
        if(!download(channelsDownloadDirectory))
        {
            setErrorOccured(true);

            //Clean up
            goto CLEANUP;
        }

        goto READCONFIG;

    }
    else
    {
        /* opendir() failed for some other reason. */

        //Write a new error message
        setErrorMsg("An unknown error has occured while opening your config directory");

        //Set error to be true
        setErrorOccured(true);

        //Clean up
        goto CLEANUP;
    }


READCONFIG:
    //Now open the file
    setErrorMsg("Trying to open config file");
    configFile.open(configFileDirectory);

    if(!configFile.is_open())
    {
        //Write a new error message
        setErrorMsg("There was an error opening your config file");

        //Set error to be true
        setErrorOccured(true);

        //Clean up
        goto CLEANUP;
    }

    setErrorMsg("Config file was opened successfully");
    setErrorMsg("Now reading settings from config file");
    while(!configFile.eof())
    {
        string temp;
//        configFile >> temp;
        getline(configFile, temp);
        QString qTemp = QString::fromStdString(temp);

        configure(qTemp);

        //Log
        //setErrorMsg(qTemp);
    }
    setErrorMsg("Reading from config file was successful.");

    setErrorMsg("Loading xml content");
    if(!loadXMLContent())
    {
        setErrorMsg("An error occured while loading xml content");

        setErrorOccured(true);

        goto CLEANUP;
    }

    setErrorMsg("Loading xml content is done");


    //If everything went successful then emit a success signal
    emit configLoadedSuccessfully();

CLEANUP:
    setErrorMsg("Cleaning up resources");
    if(configFile.is_open())
        configFile.close();
    setErrorMsg("Cleaning up resources is done");
    return;
}

bool Boot::createConfigDirectory()
{
    //Log
    setErrorMsg("Creating config directory");

    const int dir_err = mkdir("config", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
    if (-1 == dir_err)
    {
        setErrorMsg("Creating config directory failed for an unknown reason.");
        return false;
    }

    setErrorMsg("Creating config directory was successful");

    emit configDirectoryCreatedSuccessfully();

    return true;

}

bool Boot::createConfigFile(string const &configFileDirectory)
{
    setErrorMsg("Creating config file");
    ofstream out(configFileDirectory);

    if(!out.is_open())
    {
        setErrorMsg("There was an error creating config file");
        return false;
    }

    out <<"LastChannel=1";
    out.close();

    setErrorMsg("Creating config file was successful");

    emit configFileCreatedSuccessfully();
    return true;
}

bool Boot::download(std::string const &downloadDirectory)
{
    setErrorMsg("Downloading Channels.xml");

    bool res = false;
    CURL *pCurl;
    FILE *fptr;
    std::stringstream out;
    CURLcode codes;
    char *url = "http://www.muhandjumah.com/IPTV/channels.xml";
    const char *outfilename = downloadDirectory.c_str();
    //  char outfilename[256] = downloadDirectory.c_str()+"/channels.xml";
    pCurl = curl_easy_init();

    if(pCurl)
    {
        fptr = fopen(outfilename, "wb");
        curl_easy_setopt(pCurl, CURLOPT_URL, url);
        curl_easy_setopt(pCurl, CURLOPT_FOLLOWLOCATION, 1L);
        curl_easy_setopt(pCurl, CURLOPT_NOSIGNAL, 1); //Prevent "longjmp causes uninitialized stack frame" bug
        curl_easy_setopt(pCurl, CURLOPT_ACCEPT_ENCODING, "deflate");
        curl_easy_setopt(pCurl, CURLOPT_WRITEFUNCTION, write_file_data);
        curl_easy_setopt(pCurl, CURLOPT_WRITEDATA, fptr);
//        curl_easy_setopt(pCurl, CURLOPT_WRITEFUNCTION, write_out_data);
//        curl_easy_setopt(pCurl, CURLOPT_WRITEDATA, &out);

        /* Perform the request, res will get the return code */
        codes = curl_easy_perform(pCurl);

        if(codes != CURLE_OK)
        {
            setErrorMsg("There was an error downloading channels.xml, confirm is teh correct URL");
            res = false;
        }
        else
        {
            setErrorMsg("Channels.xml download was successful");
            res = true;
        }

    }
    else
    {
        setErrorMsg("There was an error initializing curl to download channels.xml");
        res = false;
    }


    //CLEAN UP
    if(res)
    {
//        setXmlContent(QString::fromStdString(out.str()));
//        loadXMLContent();
        emit channelsFileDownloadedSuccesfully();
    }
    curl_easy_cleanup(pCurl);
    fclose(fptr);
    //    delete [] outfilename;
    return res;
}

void Boot::configure(const QString &line)
{
    QStringList settingList = line.split( "=" );
    QString settingName = settingList.value(0);
    QString settingValue = settingList.value(1);


    if(settingName == "LastChannel")
        setCurrentChannelNum(settingValue);

    setErrorMsg("Added "+settingName+" with value "+settingValue);

    emit newSettingAdded();
}

bool Boot::loadXMLContent()
{
    bool res;
    ifstream channelsList;
    QString tempXMLContent;

    setErrorMsg("Parsing channels.xml");
    setErrorMsg("Trying to open channels.xml");

    channelsList.open("config/channels.xml");


    if(!channelsList.is_open())
    {
        setErrorMsg("There was an error opening channels.xml");
        res = false;
    }
    else
    {
        setErrorMsg("channels.xml was opened successfully");
        setErrorMsg("now reading from channels.xml");

        while(!channelsList.eof())
        {
            string temp;
//            channelsList >> temp;
            getline(channelsList, temp);
            QString qTemp = QString::fromStdString(temp);

            setErrorMsg("Parsing " +qTemp);
            tempXMLContent += qTemp+"\n";
        }

        setXmlContent(tempXMLContent);

        setErrorMsg("Parsing is complete");

        res = true;
    }


    return res;
}
